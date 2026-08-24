return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure, createClosure2, releaseUpvalues, createClosure0, createClosure7, createClosure3, currentUpvalueId, allocUpvalue, vm, createClosure5, upvalueValues, upvalueRefCounts, createClosure4, createUpvalueProxy, releaseUpvalue)
        createClosure3 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1, arg2, arg3)
                return vm(entryId, {
                    arg1,
                    arg2,
                    arg3
                }, captures, gcProxy)
            end
            return closure
        end
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, ReturnVal, r5, r6, r7, r8, r9
            while state do
                if state <= 15 then
                    if state <= 5 then
                        if state <= 4 then
                            if state <= 1 then
                                -- root entry 6761385 -> 1, states 1-1
                                if state == 1 then -- entry 6761385 -> 1
                                    ReturnVal = "print"
                                    state = _env[ReturnVal]
                                    r9 = "testing language/library basics"
                                    ReturnVal = state(r9)
                                    ReturnVal = "getfenv"
                                    state = _env[ReturnVal]
                                    ReturnVal = state()
                                    r9 = ReturnVal
                                    state = createClosure(2, {})
                                    ReturnVal = "concat"
                                    _env[ReturnVal] = state
                                    ReturnVal = createClosure7(5, {})
                                    r7 = ReturnVal
                                    r5 = "assert"
                                    ReturnVal = _env[r5]
                                    r8 = 1
                                    r3 = r7(r8)
                                    r8 = nil
                                    r1 = r3 == r8
                                    r5 = ReturnVal(r1)
                                    r5 = "assert"
                                    ReturnVal = _env[r5]
                                    r4 = 2
                                    r8 = 1
                                    r3 = r7(r8, r4)
                                    r8 = 2
                                    r1 = r3 == r8
                                    r5 = ReturnVal(r1)
                                    r5 = "assert"
                                    ReturnVal = _env[r5]
                                    r4 = 2
                                    r2 = 3
                                    r8 = 1
                                    r3 = r7(r8, r4, r2)
                                    r8 = 2
                                    r1 = r3 == r8
                                    r5 = ReturnVal(r1)
                                    r3 = createClosure2(6, {})
                                    r5 = "assert"
                                    ReturnVal = _env[r5]
                                    r8 = r3()
                                    r3 = 2
                                    r1 = r8 == r3
                                    r5 = ReturnVal(r1)
                                    r3 = createClosure5(9, {})
                                    r5 = "assert"
                                    ReturnVal = _env[r5]
                                    r8 = r3()
                                    r3 = nil
                                    r1 = r8 == r3
                                    r5 = ReturnVal(r1)
                                    r3 = createClosure3(12, {})
                                    r5 = "assert"
                                    ReturnVal = _env[r5]
                                    r8 = r3()
                                    r3 = 1
                                    r1 = r8 == r3
                                    r5 = ReturnVal(r1)
                                    r3 = createClosure0(16, {})
                                    r5 = "assert"
                                    ReturnVal = _env[r5]
                                    r8 = r3()
                                    r3 = 2
                                    r1 = r8 == r3
                                    r3 = createClosure4(20, {})
                                    r5 = ReturnVal(r1)
                                    r5 = "assert"
                                    ReturnVal = _env[r5]
                                    r8 = r3()
                                    r3 = 3
                                    r1 = r8 == r3
                                    r5 = ReturnVal(r1)
                                    r5 = "assert"
                                    ReturnVal = _env[r5]
                                    r3 = createClosure0(21, {})
                                    r8 = r3()
                                    r3 = -1
                                    r1 = r8 == r3
                                    r5 = ReturnVal(r1)
                                    r3 = createClosure2(22, {})
                                    r5 = "assert"
                                    ReturnVal = _env[r5]
                                    r8 = r3()
                                    r3 = 2
                                    r1 = r8 == r3
                                    r5 = ReturnVal(r1)
                                    r5 = "assert"
                                    ReturnVal = _env[r5]
                                    r3 = createClosure4(23, {})
                                    r8 = r3()
                                    r3 = 0.5
                                    r1 = r8 == r3
                                    r2 = createClosure3(24, {})
                                    r5 = ReturnVal(r1)
                                    r4 = "tad"
                                    r3 = "kuy"
                                    r5 = "hee"
                                    r8 = 2
                                    r1 = 1
                                    ReturnVal = {
                                        [r5] = r1,
                                        [r3] = r8,
                                        [r4] = r2
                                    }
                                    r5 = ReturnVal
                                    r1 = "print"
                                    ReturnVal = _env[r1]
                                    r3 = "PASS"
                                    r1 = ReturnVal(r3, r5)
                                    r6 = args
                                    r9 = nil
                                    r7 = nil
                                    r5 = nil
                                    ReturnVal = {}
                                    state = nil
                                end
                            else
                                -- createClosure entry 13637435 -> 2, states 2-4
                                if state <= 3 then
                                    if state <= 2 then
                                        if state == 2 then -- entry 13637435 -> 2
                                            r9 = {
                                                select(2, unpack(args))
                                            }
                                            r6 = args[1]
                                            r7 = "select"
                                            ReturnVal = _env[r7]
                                            r5 = "#"
                                            r7 = ReturnVal(r5, unpack(r9))
                                            ReturnVal = 0
                                            state = r7 == ReturnVal
                                            state = state and 3 or 4
                                        end
                                    else
                                        if state == 3 then
                                            ReturnVal = "tostring"
                                            state = _env[ReturnVal]
                                            ReturnVal = {
                                                state(r6)
                                            }
                                            ReturnVal = {
                                                unpack(ReturnVal)
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    if state == 4 then
                                        r7 = "tostring"
                                        ReturnVal = _env[r7]
                                        r7 = ReturnVal(r6)
                                        r3 = "concat"
                                        r1 = _env[r3]
                                        r3 = r1(unpack(r9))
                                        r5 = ","
                                        ReturnVal = r5 .. r3
                                        state = r7 .. ReturnVal
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            end
                        else
                            -- createClosure7 entry 15025329 -> 5, states 5-5
                            if state == 5 then -- entry 15025329 -> 5
                                r6 = args[1]
                                r9 = args[2]
                                ReturnVal = {
                                    r9
                                }
                                state = nil
                            end
                        end
                    else
                        if state <= 11 then
                            if state <= 8 then
                                -- createClosure2 entry 10468720 -> 6, states 6-8
                                if state <= 7 then
                                    if state <= 6 then
                                        if state == 6 then -- entry 10468720 -> 6
                                            state = 1
                                            r6 = state
                                            state = r6 and 7 or 8
                                        end
                                    else
                                        if state == 7 then
                                            state = 2
                                            r6 = state
                                            state = 8
                                        end
                                    end
                                else
                                    if state == 8 then
                                        ReturnVal = {
                                            r6
                                        }
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure5 entry 9658906 -> 9, states 9-11
                                if state <= 10 then
                                    if state <= 9 then
                                        if state == 9 then -- entry 9658906 -> 9
                                            state = nil
                                            r6 = state
                                            state = r6 and 10 or 11
                                        end
                                    else
                                        if state == 10 then
                                            state = 2
                                            r6 = state
                                            state = 11
                                        end
                                    end
                                else
                                    if state == 11 then
                                        ReturnVal = {
                                            r6
                                        }
                                        state = nil
                                    end
                                end
                            end
                        else
                            -- createClosure3 entry 14931416 -> 12, states 12-15
                            if state <= 13 then
                                if state <= 12 then
                                    if state == 12 then -- entry 14931416 -> 12
                                        state = 0
                                        r6 = state
                                        state = r6 and 13 or 14
                                    end
                                else
                                    if state == 13 then
                                        state = 1
                                        r6 = state
                                        state = 15
                                    end
                                end
                            else
                                if state <= 14 then
                                    if state == 14 then
                                        ReturnVal = 2
                                        r6 = ReturnVal
                                        state = 15
                                    end
                                else
                                    if state == 15 then
                                        ReturnVal = {
                                            r6
                                        }
                                        state = nil
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 21 then
                        if state <= 20 then
                            if state <= 19 then
                                -- createClosure0 entry 67522 -> 16, states 16-19
                                if state <= 17 then
                                    if state <= 16 then
                                        if state == 16 then -- entry 67522 -> 16
                                            state = nil
                                            r6 = state
                                            state = r6 and 17 or 18
                                        end
                                    else
                                        if state == 17 then
                                            state = 1
                                            r6 = state
                                            state = 19
                                        end
                                    end
                                else
                                    if state <= 18 then
                                        if state == 18 then
                                            ReturnVal = 2
                                            r6 = ReturnVal
                                            state = 19
                                        end
                                    else
                                        if state == 19 then
                                            ReturnVal = {
                                                r6
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            else
                                -- createClosure4 entry 16514151 -> 20, states 20-20
                                if state == 20 then -- entry 16514151 -> 20
                                    state = 1
                                    r6 = state
                                    ReturnVal = 2
                                    state = r6 + ReturnVal
                                    r6 = state
                                    ReturnVal = {
                                        r6
                                    }
                                    state = nil
                                end
                            end
                        else
                            -- createClosure0 entry 11356620 -> 21, states 21-21
                            if state == 21 then -- entry 11356620 -> 21
                                state = 1
                                r6 = state
                                ReturnVal = 2
                                state = r6 - ReturnVal
                                r6 = state
                                ReturnVal = {
                                    r6
                                }
                                state = nil
                            end
                        end
                    else
                        if state <= 23 then
                            if state <= 22 then
                                -- createClosure2 entry 10638428 -> 22, states 22-22
                                if state == 22 then -- entry 10638428 -> 22
                                    state = 1
                                    r6 = state
                                    ReturnVal = 2
                                    state = r6 * ReturnVal
                                    r6 = state
                                    ReturnVal = {
                                        r6
                                    }
                                    state = nil
                                end
                            else
                                -- createClosure4 entry 15700955 -> 23, states 23-23
                                if state == 23 then -- entry 15700955 -> 23
                                    state = 1
                                    r6 = state
                                    ReturnVal = 2
                                    state = r6 / ReturnVal
                                    r6 = state
                                    ReturnVal = {
                                        r6
                                    }
                                    state = nil
                                end
                            end
                        else
                            -- createClosure3 entry 10345306 -> 24, states 24-24
                            if state == 24 then -- entry 10345306 -> 24
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                r6 = "G"
                                ReturnVal = state(r6)
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
        createClosure7 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
                return vm(entryId, {
                    arg1,
                    arg2,
                    arg3,
                    arg4,
                    arg5,
                    arg6,
                    arg7
                }, captures, gcProxy)
            end
            return closure
        end
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
            end
            return closure
        end
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        createClosure4 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1, arg2, arg3, arg4)
                return vm(entryId, {
                    arg1,
                    arg2,
                    arg3,
                    arg4
                }, captures, gcProxy)
            end
            return closure
        end
        createClosure = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(...)
                return vm(entryId, {
                    ...
                }, captures, gcProxy)
            end
            return closure
        end
        upvalueValues = {}
        currentUpvalueId = 0
        createClosure5 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1, arg2, arg3, arg4, arg5)
                return vm(entryId, {
                    arg1,
                    arg2,
                    arg3,
                    arg4,
                    arg5
                }, captures, gcProxy)
            end
            return closure
        end
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 3398746
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 3398746
                    end
                })
            end
        end
        upvalueRefCounts = {}
        createClosure2 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1, arg2)
                return vm(entryId, {
                    arg1,
                    arg2
                }, captures, gcProxy)
            end
            return closure
        end
        releaseUpvalues = function(captures)
            local captureIndex, upvalueId = 1, captures[1]
            while upvalueId do
                upvalueRefCounts[upvalueId], captureIndex = upvalueRefCounts[upvalueId] - (1), captureIndex + (1)
                if 0 == upvalueRefCounts[upvalueId] then
                    upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
                end
                upvalueId = captures[captureIndex]
            end
        end
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)