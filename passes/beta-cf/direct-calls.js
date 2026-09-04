"use strict";

const {
    decodeJsonStringLiteral,
    isEmptyTable,
    isIdentifier,
    isLuaIdentifier,
    isPrimitiveLiteral,
    isSingleAssignment,
    sourceOf,
} = require("./ast");

function matchEnvLoad(statement, destinationName, keyName) {
    if (!isSingleAssignment(statement, destinationName)) return false;
    const rhs = statement.init[0];
    return rhs?.type === "IndexExpression" && isIdentifier(rhs.base, "_env") && isIdentifier(rhs.index, keyName);
}

function matchDirectMemberCallable(leaf, index, stateName, returnName) {
    let cursor = index;

    // Start from a proven global load: key = "game"; value = _env[key].
    const baseKeyLoad = leaf[cursor];
    if (!isSingleAssignment(baseKeyLoad)) return null;
    const baseKeyReg = baseKeyLoad.variables[0];
    if (!isIdentifier(baseKeyReg)) return null;
    const baseName = decodeJsonStringLiteral(baseKeyLoad.init[0]);
    if (!isLuaIdentifier(baseName)) return null;

    const baseLoad = leaf[cursor + 1];
    if (!isSingleAssignment(baseLoad)) return null;
    const baseDest = baseLoad.variables[0];
    if (!isIdentifier(baseDest) || !matchEnvLoad(baseLoad, baseDest.name, baseKeyReg.name)) return null;

    let expression = baseName;
    let currentRegister = baseDest.name;
    let memberCount = 0;
    cursor += 2;

    // Follow any number of compiler IndexExpression hops. Each hop is exactly:
    // key = "member"; next = current[key]. No search or backtracking.
    while (cursor + 1 < leaf.length) {
        const keyLoad = leaf[cursor];
        if (!isSingleAssignment(keyLoad)) break;
        const keyReg = keyLoad.variables[0];
        if (!isIdentifier(keyReg)) break;
        const memberName = decodeJsonStringLiteral(keyLoad.init[0]);
        if (!isLuaIdentifier(memberName)) break;

        const memberLoad = leaf[cursor + 1];
        if (!isSingleAssignment(memberLoad)) break;
        const memberDest = memberLoad.variables[0];
        const memberIndex = memberLoad.init[0];
        if (!isIdentifier(memberDest) || memberIndex?.type !== "IndexExpression" ||
            !isIdentifier(memberIndex.base, currentRegister) || !isIdentifier(memberIndex.index, keyReg.name)) break;

        expression += `.${memberName}`;
        currentRegister = memberDest.name;
        memberCount++;
        cursor += 2;
    }

    if (memberCount === 0) return null;
    return { next: cursor, globalName: expression, register: currentRegister };
}

function readTempProducer(source, leaf, index, stateName, returnName, temps) {
    const statement = leaf[index];
    if (!isSingleAssignment(statement)) return null;
    const destination = statement.variables[0];
    const rhs = statement.init[0];
    if (!isIdentifier(destination) || destination.name === stateName || destination.name === returnName) return null;
    const name = destination.name;
    if (temps.has(name) && temps.get(name) !== null) return null;

    // Prefer the proven two-statement global-expression producer over treating
    // its string key as an ordinary argument literal.
    const globalName = decodeJsonStringLiteral(rhs);
    const load = leaf[index + 1];
    if (isLuaIdentifier(globalName) && isSingleAssignment(load)) {
        const valueDest = load.variables[0];
        if (isIdentifier(valueDest) && valueDest.name !== stateName && valueDest.name !== returnName &&
            (!temps.has(valueDest.name) || temps.get(valueDest.name) === null) && matchEnvLoad(load, valueDest.name, name)) {
            temps.set(valueDest.name, globalName);
            temps.set(name, null);
            return index + 2;
        }
    }

    if (isPrimitiveLiteral(rhs) || isEmptyTable(rhs)) {
        const text = sourceOf(source, rhs);
        if (text === null) return null;
        temps.set(name, text);
        return index + 1;
    }

    return null;
}

function matchOneDirectGlobalCall(source, leaf, index, stateName, returnName) {
    const temps = new Map();
    let callable = null;

    while (index < leaf.length) {
        const statement = leaf[index];

        if (!callable) {
            const memberCallable = matchDirectMemberCallable(leaf, index, stateName, returnName);
            if (memberCallable) {
                callable = { globalName: memberCallable.globalName, register: memberCallable.register };
                index = memberCallable.next;
                continue;
            }
        }

        if (isSingleAssignment(statement, returnName)) {
            const rhs = statement.init[0];

            if (rhs?.type === "CallExpression" && callable && isIdentifier(rhs.base, callable.register)) break;

            const globalName = decodeJsonStringLiteral(rhs);
            if (isLuaIdentifier(globalName) && matchEnvLoad(leaf[index + 1], stateName, returnName)) {
                if (callable) return null;
                callable = { globalName, register: stateName };
                index += 2;
                continue;
            }
        }

        const next = readTempProducer(source, leaf, index, stateName, returnName, temps);
        if (next === null) return null;
        index = next;
    }

    if (!callable) return null;

    const callStatement = leaf[index];
    if (!isSingleAssignment(callStatement, returnName)) return null;
    const call = callStatement.init[0];
    if (call?.type !== "CallExpression" || !isIdentifier(call.base, callable.register)) return null;

    const renderedArgs = [];
    const used = new Set();
    for (const arg of call.arguments || []) {
        if (!isIdentifier(arg) || !temps.has(arg.name) || temps.get(arg.name) === null || used.has(arg.name)) return null;
        used.add(arg.name);
        renderedArgs.push(temps.get(arg.name));
    }

    for (const [name, value] of temps) {
        if (value !== null && !used.has(name)) return null;
    }

    return {
        next: index + 1,
        source: `${callable.globalName}(${renderedArgs.join(", ")})`,
        globalName: callable.globalName,
        argumentCount: renderedArgs.length,
    };
}

function matchTerminalBookkeeping(leaf, index, stateName, returnName) {
    let sawReturnReset = false;
    let sawStop = false;
    let argsCopies = 0;

    for (; index < leaf.length; index++) {
        const statement = leaf[index];
        if (!isSingleAssignment(statement)) return null;
        const destination = statement.variables[0];
        const rhs = statement.init[0];

        if (isIdentifier(destination, returnName) && isEmptyTable(rhs) && !sawReturnReset) {
            sawReturnReset = true;
            continue;
        }
        if (isIdentifier(destination, stateName) && rhs?.type === "NilLiteral" && sawReturnReset && !sawStop) {
            sawStop = true;
            continue;
        }
        if (isIdentifier(destination) && destination.name !== stateName && destination.name !== returnName &&
            isIdentifier(rhs, "args") && !sawReturnReset && !sawStop) {
            argsCopies++;
            if (argsCopies > 1) return null;
            continue;
        }
        return null;
    }

    return sawReturnReset && sawStop ? index : null;
}

function matchDirectGlobalCallLeaf(source, leaf, stateName, returnName) {
    if (!returnName || leaf.length < 4) return null;

    let index = 0;
    const calls = [];
    let argumentCount = 0;

    while (index < leaf.length) {
        const terminal = matchTerminalBookkeeping(leaf, index, stateName, returnName);
        if (terminal !== null) {
            index = terminal;
            break;
        }

        const matched = matchOneDirectGlobalCall(source, leaf, index, stateName, returnName);
        if (!matched) return null;
        calls.push(matched);
        argumentCount += matched.argumentCount;
        index = matched.next;
    }

    if (index !== leaf.length || calls.length === 0) return null;

    return {
        source: calls.map(call => call.source).join("\n") + "\n",
        globalName: calls.length === 1 ? calls[0].globalName : null,
        argumentCount,
        callCount: calls.length,
    };
}

module.exports = { matchDirectGlobalCallLeaf };
