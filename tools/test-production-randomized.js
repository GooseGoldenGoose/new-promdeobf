"use strict";
const fs = require("fs");
const path = require("path");
const { spawnSync } = require("child_process");
const root = path.resolve(__dirname, "..");
const directory = path.join(root, "output", "production-fixtures-" + Date.now());
fs.mkdirSync(directory, { recursive: true });
const fixtures = {
    recursion: 'local function f(n) if n == 0 then return 0 end return f(n-1)+1 end print(f(4))',
    capture: 'local count=0 local function values() count=count+1 return 11,42 end local a,b=values() local function read() return a end a=a+3 print(read(),b,count)',
    table: 'local count=0 local function values() count=count+1 return 11,42 end local t={9,values()} print(t[1],t[2],t[3],count)',
    nestedPack: 'local count=0 local function values() count=count+1 return 11,42 end local function combine(a,b) return a+b end local t={combine(values())} print(t[1],count)',
    breakLoop: 'for k,v in ipairs({11,42}) do print(k,v) break end',
    returnLoop: 'local function f(t) for k,v in ipairs(t) do return k,v end return 0 end print(f({11,42})) print(f({}))',
    conditionalLoopLocal: 'local function f(enabled,t) if enabled then local found=false for k,v in ipairs(t) do if v==42 then found=true break end end if found then print("found") else print("missing") end end end f(true,{11,42}) f(true,{11}) f(false,{42})',
    repeatedValue: 'local count=0 local function value() count=count+1 return {count} end local function f(enabled) if enabled then local t=value() print(t[1],t[1],t==t) end print(count) end f(true) f(false)',
};
let failures = 0;
for (const [name, source] of Object.entries(fixtures)) {
    for (let iteration = 0; iteration < 6; iteration++) {
        const filename = path.join(directory, `${name}-${iteration}.lua`);
        fs.writeFileSync(filename, source + "\n");
        const result = spawnSync(process.execPath, [path.join(__dirname, "fast-obf-deobf.js"), filename, "--runtime", "--seed", String(71001 + iteration * 7919)], {
            cwd: root, encoding: "utf8", timeout: 120000, windowsHide: true, maxBuffer: 4 * 1024 * 1024,
        });
        fs.writeFileSync(filename + ".log", (result.stdout || "") + (result.stderr || "") + (result.error?.message || ""));
        if (result.status !== 0) failures++;
        console.log(`${result.status === 0 ? "PASS" : "FAIL"} ${name} ${iteration}`);
    }
}
const total = Object.keys(fixtures).length * 6;
console.log(`Randomized compiler behavior: ${total - failures}/${total}. Evidence: ${directory}`);
process.exitCode = failures ? 1 : 0;
