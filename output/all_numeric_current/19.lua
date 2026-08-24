return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, currentUpvalueId, createClosure2, createClosure, releaseUpvalues, upvalueRefCounts, vm, createClosure3, releaseUpvalue, createUpvalueProxy, upvalueValues, allocUpvalue)
        releaseUpvalues = function(captures)
            local captureIndex, upvalueId = 1, captures[1]
            while upvalueId do
                upvalueRefCounts[upvalueId], captureIndex = upvalueRefCounts[upvalueId] - (1), (1) + captureIndex
                if upvalueRefCounts[upvalueId] == 0 then
                    upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
                end
                upvalueId = captures[captureIndex]
            end
        end
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -2288008
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -2288008
                    end
                })
            end
        end
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
        createClosure = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(...)
                return vm(entryId, {
                    ...
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, ReturnVal
            while state do
                if state <= 2 then
                    if state <= 1 then
                        -- root entry 5188599 -> 1, states 1-1
                        if state == 1 then -- entry 5188599 -> 1
                            state = 10
                            r2 = allocUpvalue()
                            upvalueValues[r2] = state
                            state = createClosure2(2, {
                                r2
                            })
                            r1 = state
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r4 = {
                                r1()
                            }
                            ReturnVal = state(unpack(r4))
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r4 = {
                                r1()
                            }
                            ReturnVal = state(unpack(r4))
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r4 = upvalueValues[r2]
                            ReturnVal = state(r4)
                            ReturnVal = {}
                            r2 = releaseUpvalue(r2)
                            r3 = args
                            r1 = nil
                            state = nil
                        end
                    else
                        -- createClosure2 entry 2074346 -> 2, states 2-2
                        if state == 2 then -- entry 2074346 -> 2
                            state = createClosure3(3, {
                                upvalues[1]
                            })
                            r3 = state
                            state = {
                                r3()
                            }
                            ReturnVal = {
                                unpack(state)
                            }
                            state = nil
                        end
                    end
                else
                    -- createClosure3 entry 14269158 -> 3, states 3-3
                    if state == 3 then -- entry 14269158 -> 3
                        ReturnVal = upvalueValues[upvalues[1]]
                        r3 = 2
                        state = ReturnVal + r3
                        upvalueValues[upvalues[1]] = state
                        ReturnVal = upvalueValues[upvalues[1]]
                        ReturnVal = {
                            ReturnVal
                        }
                        state = nil
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
        currentUpvalueId = 0
        upvalueValues = {}
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