return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, currentUpvalueId, createClosure, vm, releaseUpvalue, createClosure3, createUpvalueProxy, upvalueRefCounts, createClosure6, allocUpvalue, upvalueValues, releaseUpvalues)
        createClosure6 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1, arg2, arg3, arg4, arg5, arg6)
                return vm(entryId, {
                    arg1,
                    arg2,
                    arg3,
                    arg4,
                    arg5,
                    arg6
                }, captures, gcProxy)
            end
            return closure
        end
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, ReturnVal, r3, r4, r5, r6, r7
            while state do
                if state <= 2 then
                    if state <= 1 then
                        -- root entry 7166338 -> 1, states 1-1
                        if state == 1 then -- entry 7166338 -> 1
                            state = 1
                            r2 = allocUpvalue()
                            upvalueValues[r2] = state
                            state = 10
                            r7 = state
                            state = 2
                            r1 = state
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r5 = "block"
                            ReturnVal = state(r5, r7, r1)
                            state = createClosure6(2, {
                                r2
                            })
                            r7 = nil
                            r7 = state
                            state = createClosure3(3, {
                                r2
                            })
                            r1 = nil
                            r1 = state
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r3 = {
                                r1()
                            }
                            r2 = releaseUpvalue(r2)
                            r5 = "before"
                            ReturnVal = state(r5, unpack(r3))
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r4 = 2
                            r3 = r7(r4)
                            r4 = {
                                r1()
                            }
                            r5 = "after"
                            ReturnVal = state(r5, r3, unpack(r4))
                            r1 = nil
                            r6 = args
                            r7 = nil
                            ReturnVal = {}
                            state = nil
                        end
                    else
                        -- createClosure6 entry 3874673 -> 2, states 2-2
                        if state == 2 then -- entry 3874673 -> 2
                            r6 = args[1]
                            ReturnVal = upvalueValues[upvalues[1]]
                            state = ReturnVal + r6
                            upvalueValues[upvalues[1]] = state
                            ReturnVal = upvalueValues[upvalues[1]]
                            ReturnVal = {
                                ReturnVal
                            }
                            state = nil
                        end
                    end
                else
                    -- createClosure3 entry 5535430 -> 3, states 3-3
                    if state == 3 then -- entry 5535430 -> 3
                        state = upvalueValues[upvalues[1]]
                        ReturnVal = {
                            state
                        }
                        state = nil
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
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
        upvalueValues = {}
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        createClosure = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(...)
                return vm(entryId, {
                    ...
                }, captures, gcProxy)
            end
            return closure
        end
        currentUpvalueId = 0
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
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
        upvalueRefCounts = {}
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)