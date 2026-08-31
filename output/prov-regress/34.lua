return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalues, createUpvalueProxy, createClosure, allocUpvalue, createClosure3, createClosure5, currentUpvalueId, releaseUpvalue, vm, upvalueValues, upvalueRefCounts)
        releaseUpvalues = function(captures)
            local captureIndex, upvalueId = 1, captures[1]
            while upvalueId do
                upvalueRefCounts[upvalueId], captureIndex = upvalueRefCounts[upvalueId] - (1), (1) + captureIndex
                if 0 == upvalueRefCounts[upvalueId] then
                    upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
                end
                upvalueId = captures[captureIndex]
            end
        end
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 84540
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 84540
                    end
                })
            end
        end
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
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
        upvalueRefCounts = {}
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
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, ReturnVal, r4, r5, r6
            while state do
                if state <= 7 then
                    if state <= 1 then
                        -- root entry 6306426 -> 1, states 1-1
                        if state == 1 then -- entry 6306426 -> 1
                            state = createClosure3(2, {})
                            r5 = state
                            state = createClosure3(8, {})
                            r1 = state
                            state = createClosure5(14, {})
                            r2 = state
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r3 = 5
                            r6 = {
                                r5(r3)
                            }
                            ReturnVal = state(unpack(r6))
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r3 = 5
                            r6 = {
                                r1(r3)
                            }
                            ReturnVal = state(unpack(r6))
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r3 = 3
                            r6 = {
                                r2(r3)
                            }
                            ReturnVal = state(unpack(r6))
                            r5 = nil
                            r4 = args
                            r1 = nil
                            r2 = nil
                            ReturnVal = {}
                            state = nil
                        end
                    else
                        -- createClosure3 entry 9372094 -> 2, states 2-7
                        if state <= 4 then
                            if state <= 3 then
                                if state <= 2 then
                                    if state == 2 then -- entry 9372094 -> 2
                                        r4 = args[1]
                                        state = 0
                                        r5 = state
                                        state = 3
                                    end
                                else
                                    if state == 3 then
                                        state = r5 < r4
                                        state = state and 4 or 5
                                    end
                                end
                            else
                                if state == 4 then
                                    ReturnVal = 1
                                    state = r5 + ReturnVal
                                    r5 = state
                                    r1 = 3
                                    ReturnVal = r5 == r1
                                    state = ReturnVal and 6 or 7
                                end
                            end
                        else
                            if state <= 6 then
                                if state <= 5 then
                                    if state == 5 then
                                        ReturnVal = "while-done"
                                        ReturnVal = {
                                            ReturnVal,
                                            r5
                                        }
                                        state = nil
                                    end
                                else
                                    if state == 6 then
                                        ReturnVal = "while"
                                        ReturnVal = {
                                            ReturnVal,
                                            r5
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state == 7 then
                                    state = 3
                                end
                            end
                        end
                    end
                else
                    if state <= 13 then
                        -- createClosure3 entry 7170632 -> 8, states 8-13
                        if state <= 10 then
                            if state <= 9 then
                                if state <= 8 then
                                    if state == 8 then -- entry 7170632 -> 8
                                        r4 = args[1]
                                        r1 = 1
                                        r2 = r1
                                        r1 = 0
                                        r6 = r2 < r1
                                        ReturnVal = 1
                                        r1 = ReturnVal - r2
                                        r5 = r4
                                        state = 9
                                    end
                                else
                                    if state == 9 then
                                        r3 = not r6
                                        r1 = r1 + r2
                                        ReturnVal = r1 <= r5
                                        ReturnVal = r3 and ReturnVal
                                        r3 = r1 >= r5
                                        r3 = r6 and r3
                                        ReturnVal = r3 or ReturnVal
                                        r3 = 10
                                        state = ReturnVal and r3
                                        ReturnVal = 11
                                        state = state or ReturnVal
                                    end
                                end
                            else
                                if state == 10 then
                                    r3 = r1
                                    ReturnVal = 2
                                    state = r3 == ReturnVal
                                    state = state and 12 or 13
                                end
                            end
                        else
                            if state <= 12 then
                                if state <= 11 then
                                    if state == 11 then
                                        state = "for-done"
                                        ReturnVal = {
                                            state,
                                            r4
                                        }
                                        state = nil
                                    end
                                else
                                    if state == 12 then
                                        state = "for"
                                        ReturnVal = {
                                            state,
                                            r3
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state == 13 then
                                    r3 = nil
                                    state = 9
                                end
                            end
                        end
                    else
                        -- createClosure5 entry 4151637 -> 14, states 14-19
                        if state <= 16 then
                            if state <= 15 then
                                if state <= 14 then
                                    if state == 14 then -- entry 4151637 -> 14
                                        r4 = args[1]
                                        state = 0
                                        r5 = state
                                        ReturnVal = 5
                                        state = r5 >= ReturnVal
                                        state = 15
                                    end
                                else
                                    if state == 15 then
                                        ReturnVal = 1
                                        state = r5 + ReturnVal
                                        r5 = state
                                        ReturnVal = r5 == r4
                                        state = ReturnVal and 16 or 17
                                    end
                                end
                            else
                                if state == 16 then
                                    ReturnVal = "repeat"
                                    ReturnVal = {
                                        ReturnVal,
                                        r5
                                    }
                                    state = nil
                                end
                            end
                        else
                            if state <= 18 then
                                if state <= 17 then
                                    if state == 17 then
                                        state = 18
                                    end
                                else
                                    if state == 18 then
                                        r1 = 5
                                        ReturnVal = r5 >= r1
                                        state = ReturnVal and 19 or 15
                                    end
                                end
                            else
                                if state == 19 then
                                    ReturnVal = "repeat-done"
                                    ReturnVal = {
                                        ReturnVal,
                                        r5
                                    }
                                    state = nil
                                end
                            end
                        end
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
        currentUpvalueId = 0
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)