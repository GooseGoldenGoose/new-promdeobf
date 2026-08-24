return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, upvalueValues, createUpvalueProxy, createClosure4, vm, releaseUpvalues, createClosure, currentUpvalueId, createClosure3, upvalueRefCounts, createClosure10, allocUpvalue, releaseUpvalue)
        currentUpvalueId = 0
        createClosure = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(...)
                return vm(entryId, {
                    ...
                }, captures, gcProxy)
            end
            return closure
        end
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
        upvalueRefCounts = {}
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
        createClosure10 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
                return vm(entryId, {
                    arg1,
                    arg2,
                    arg3,
                    arg4,
                    arg5,
                    arg6,
                    arg7,
                    arg8,
                    arg9,
                    arg10
                }, captures, gcProxy)
            end
            return closure
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
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, ReturnVal
            while state do
                if state <= 5 then
                    if state <= 1 then
                        -- root entry 7166338 -> 1, states 1-1
                        if state == 1 then -- entry 7166338 -> 1
                            r4 = allocUpvalue()
                            state = 0
                            upvalueValues[r4] = state
                            state = createClosure4(2, {
                                r4
                            })
                            r1 = state
                            state = createClosure3(6, {
                                r4
                            })
                            r7 = state
                            state = createClosure10(13, {
                                r4
                            })
                            r3 = state
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r2 = upvalueValues[r4]
                            r8 = "start"
                            ReturnVal = state(r8, r2)
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r5 = 5
                            r2 = {
                                r1(r5)
                            }
                            r8 = "choose"
                            ReturnVal = state(r8, unpack(r2))
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r5 = 3
                            r2 = {
                                r7(r5)
                            }
                            r8 = "spin"
                            ReturnVal = state(r8, unpack(r2))
                            r4 = releaseUpvalue(r4)
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r5 = 2
                            r2 = {
                                r3(r5)
                            }
                            r8 = "trim"
                            ReturnVal = state(r8, unpack(r2))
                            r6 = args
                            r1 = nil
                            r7 = nil
                            r3 = nil
                            ReturnVal = {}
                            state = nil
                        end
                    else
                        -- createClosure4 entry 3874673 -> 2, states 2-5
                        if state <= 3 then
                            if state <= 2 then
                                if state == 2 then -- entry 3874673 -> 2
                                    r6 = args[1]
                                    ReturnVal = 3
                                    state = r6 > ReturnVal
                                    state = state and 3 or 4
                                end
                            else
                                if state == 3 then
                                    ReturnVal = upvalueValues[upvalues[1]]
                                    state = ReturnVal + r6
                                    upvalueValues[upvalues[1]] = state
                                    state = 5
                                end
                            end
                        else
                            if state <= 4 then
                                if state == 4 then
                                    r4 = upvalueValues[upvalues[1]]
                                    r1 = 1
                                    ReturnVal = r4 + r1
                                    upvalueValues[upvalues[1]] = ReturnVal
                                    state = 5
                                end
                            else
                                if state == 5 then
                                    r4 = upvalueValues[upvalues[1]]
                                    ReturnVal = {
                                        r4
                                    }
                                    state = nil
                                end
                            end
                        end
                    end
                else
                    if state <= 12 then
                        -- createClosure3 entry 8183125 -> 6, states 6-12
                        if state <= 9 then
                            if state <= 7 then
                                if state <= 6 then
                                    if state == 6 then -- entry 8183125 -> 6
                                        r6 = args[1]
                                        state = 0
                                        r1 = state
                                        r4 = args[2]
                                        state = 7
                                    end
                                else
                                    if state == 7 then
                                        state = r1 < r6
                                        state = state and 8 or 9
                                    end
                                end
                            else
                                if state <= 8 then
                                    if state == 8 then
                                        r7 = 2
                                        ReturnVal = r1 % r7
                                        r7 = 0
                                        state = ReturnVal == r7
                                        state = state and 10 or 11
                                    end
                                else
                                    if state == 9 then
                                        r3 = upvalueValues[upvalues[1]]
                                        ReturnVal = {
                                            r3
                                        }
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 11 then
                                if state <= 10 then
                                    if state == 10 then
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r7 = 2
                                        state = ReturnVal + r7
                                        upvalueValues[upvalues[1]] = state
                                        state = 12
                                    end
                                else
                                    if state == 11 then
                                        r7 = upvalueValues[upvalues[1]]
                                        r3 = 1
                                        ReturnVal = r7 + r3
                                        upvalueValues[upvalues[1]] = ReturnVal
                                        state = 12
                                    end
                                end
                            else
                                if state == 12 then
                                    r3 = 1
                                    r7 = r1 + r3
                                    r1 = r7
                                    state = 7
                                end
                            end
                        end
                    else
                        -- createClosure10 entry 9932502 -> 13, states 13-16
                        if state <= 14 then
                            if state <= 13 then
                                if state == 13 then -- entry 9932502 -> 13
                                    r1 = args[3]
                                    r7 = args[4]
                                    r6 = args[1]
                                    r3 = args[5]
                                    ReturnVal = upvalueValues[upvalues[1]]
                                    r4 = args[2]
                                    state = ReturnVal <= r6
                                    state = 14
                                end
                            else
                                if state == 14 then
                                    ReturnVal = upvalueValues[upvalues[1]]
                                    r8 = 1
                                    state = ReturnVal - r8
                                    upvalueValues[upvalues[1]] = state
                                    state = 15
                                end
                            end
                        else
                            if state <= 15 then
                                if state == 15 then
                                    r8 = upvalueValues[upvalues[1]]
                                    ReturnVal = r8 <= r6
                                    state = ReturnVal and 16 or 14
                                end
                            else
                                if state == 16 then
                                    ReturnVal = upvalueValues[upvalues[1]]
                                    ReturnVal = {
                                        ReturnVal
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
        upvalueValues = {}
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -3421254
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -3421254
                    end
                })
            end
        end
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)