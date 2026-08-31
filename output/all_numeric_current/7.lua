return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure0, releaseUpvalue, releaseUpvalues, createUpvalueProxy, upvalueValues, allocUpvalue, vm, upvalueRefCounts, currentUpvalueId, createClosure)
        upvalueValues = {}
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
            end
            return closure
        end
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        currentUpvalueId = 0
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
        upvalueRefCounts = {}
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 237482
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 237482
                    end
                })
            end
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, ReturnVal
            while state do
                if state <= 3 then
                    -- root entry 4779749 -> 1, states 1-3
                    if state <= 2 then
                        if state <= 1 then
                            if state == 1 then -- entry 4779749 -> 1
                                state = 3
                                r6 = state
                                state = 1
                                r5 = allocUpvalue()
                                upvalueValues[r5] = state
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                r3 = upvalueValues[r5]
                                ReturnVal = state(r3)
                                r2 = "math"
                                r3 = _env[r2]
                                r2 = "random"
                                ReturnVal = r3[r2]
                                r4 = 2
                                r2 = 1
                                r3 = ReturnVal(r2, r4)
                                ReturnVal = 1
                                state = r3 == ReturnVal
                                state = state and 2 or 3
                                r1 = args
                            end
                        else
                            if state == 2 then
                                state = 2
                                r3 = state
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                ReturnVal = state(r3)
                                state = 123
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        end
                    else
                        if state == 3 then
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            ReturnVal = state(r6)
                            state = createClosure0(4, {
                                r5
                            })
                            r3 = state
                            ReturnVal = {}
                            state = r3()
                            r5 = releaseUpvalue(r5)
                            r6 = nil
                            r3 = nil
                            state = nil
                        end
                    end
                else
                    -- createClosure0 entry 4300829 -> 4, states 4-4
                    if state == 4 then -- entry 4300829 -> 4
                        ReturnVal = "print"
                        state = _env[ReturnVal]
                        r1 = upvalueValues[upvalues[1]]
                        ReturnVal = state(r1)
                        state = 1
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)