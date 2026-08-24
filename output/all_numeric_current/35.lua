return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, vm, createClosure4, releaseUpvalues, releaseUpvalue, upvalueRefCounts, createClosure5, createClosure2, createUpvalueProxy, currentUpvalueId, allocUpvalue, upvalueValues, createClosure)
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, ReturnVal, r9
            while state do
                if state <= 11 then
                    if state <= 10 then
                        -- root entry 6306426 -> 1, states 1-10
                        if state <= 5 then
                            if state <= 3 then
                                if state <= 2 then
                                    if state <= 1 then
                                        if state == 1 then -- entry 6306426 -> 1
                                            ReturnVal = "print"
                                            state = _env[ReturnVal]
                                            r7 = "capture-loop-start"
                                            ReturnVal = state(r7)
                                            r7 = 3
                                            r9 = r7
                                            r7 = 1
                                            r4 = r7
                                            r7 = 0
                                            r3 = r4 < r7
                                            ReturnVal = 1
                                            r7 = ReturnVal - r4
                                            r8 = args
                                            state = 2
                                        end
                                    else
                                        if state == 2 then
                                            r2 = not r3
                                            r7 = r7 + r4
                                            ReturnVal = r7 <= r9
                                            ReturnVal = r2 and ReturnVal
                                            r2 = r7 >= r9
                                            r2 = r3 and r2
                                            ReturnVal = r2 or ReturnVal
                                            r2 = 3
                                            state = ReturnVal and r2
                                            ReturnVal = 4
                                            state = state or ReturnVal
                                        end
                                    end
                                else
                                    if state == 3 then
                                        r2 = allocUpvalue()
                                        upvalueValues[r2] = r7
                                        state = createClosure2(11, {
                                            r2
                                        })
                                        r6 = state
                                        ReturnVal = "print"
                                        state = _env[ReturnVal]
                                        r1 = {
                                            r6()
                                        }
                                        r2 = releaseUpvalue(r2)
                                        r5 = "capture-for"
                                        ReturnVal = state(r5, unpack(r1))
                                        r6 = nil
                                        state = 2
                                    end
                                end
                            else
                                if state <= 4 then
                                    if state == 4 then
                                        state = 0
                                        r7 = allocUpvalue()
                                        upvalueValues[r7] = state
                                        state = 5
                                    end
                                else
                                    if state == 5 then
                                        ReturnVal = upvalueValues[r7]
                                        r9 = 3
                                        state = ReturnVal < r9
                                        state = state and 6 or 7
                                    end
                                end
                            end
                        else
                            if state <= 8 then
                                if state <= 7 then
                                    if state <= 6 then
                                        if state == 6 then
                                            ReturnVal = upvalueValues[r7]
                                            r9 = 1
                                            state = ReturnVal + r9
                                            upvalueValues[r7] = state
                                            r9 = upvalueValues[r7]
                                            r4 = 10
                                            ReturnVal = r9 * r4
                                            r9 = allocUpvalue()
                                            upvalueValues[r9] = ReturnVal
                                            ReturnVal = createClosure5(12, {
                                                r7,
                                                r9
                                            })
                                            r9 = releaseUpvalue(r9)
                                            r4 = ReturnVal
                                            r3 = "print"
                                            ReturnVal = _env[r3]
                                            r6 = {
                                                r4()
                                            }
                                            r2 = "capture-while"
                                            r3 = ReturnVal(r2, unpack(r6))
                                            r4 = nil
                                            state = 5
                                        end
                                    else
                                        if state == 7 then
                                            r9 = allocUpvalue()
                                            ReturnVal = 0
                                            upvalueValues[r9] = ReturnVal
                                            r4 = upvalueValues[r9]
                                            r3 = 2
                                            ReturnVal = r4 >= r3
                                            state = 8
                                        end
                                    end
                                else
                                    if state == 8 then
                                        r4 = upvalueValues[r9]
                                        r3 = 1
                                        ReturnVal = r4 + r3
                                        upvalueValues[r9] = ReturnVal
                                        r4 = createClosure4(13, {
                                            r9
                                        })
                                        r2 = "print"
                                        r3 = _env[r2]
                                        r5 = {
                                            r4()
                                        }
                                        r6 = "capture-repeat"
                                        r2 = r3(r6, unpack(r5))
                                        r4 = nil
                                        state = 9
                                    end
                                end
                            else
                                if state <= 9 then
                                    if state == 9 then
                                        r3 = upvalueValues[r9]
                                        r2 = 2
                                        r4 = r3 >= r2
                                        state = r4 and 10 or 8
                                    end
                                else
                                    if state == 10 then
                                        r7 = releaseUpvalue(r7)
                                        r9 = releaseUpvalue(r9)
                                        ReturnVal = {}
                                        r3 = "print"
                                        r4 = _env[r3]
                                        r2 = "capture-loop-end"
                                        r3 = r4(r2)
                                        state = nil
                                    end
                                end
                            end
                        end
                    else
                        -- createClosure2 entry 70402 -> 11, states 11-11
                        if state == 11 then -- entry 70402 -> 11
                            state = upvalueValues[upvalues[1]]
                            ReturnVal = {
                                state
                            }
                            state = nil
                        end
                    end
                else
                    if state <= 12 then
                        -- createClosure5 entry 6241773 -> 12, states 12-12
                        if state == 12 then -- entry 6241773 -> 12
                            state = upvalueValues[upvalues[1]]
                            ReturnVal = upvalueValues[upvalues[2]]
                            ReturnVal = {
                                state,
                                ReturnVal
                            }
                            state = nil
                        end
                    else
                        -- createClosure4 entry 12543095 -> 13, states 13-13
                        if state == 13 then -- entry 12543095 -> 13
                            state = upvalueValues[upvalues[1]]
                            ReturnVal = {
                                state
                            }
                            state = nil
                        end
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
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
        currentUpvalueId = 0
        upvalueRefCounts = {}
        upvalueValues = {}
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
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
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
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)