return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, upvalueRefCounts, createClosure, releaseUpvalue, releaseUpvalues, upvalueValues, createUpvalueProxy, currentUpvalueId, vm, allocUpvalue)
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -2257460
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -2257460
                    end
                })
            end
        end
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
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
        upvalueValues = {}
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, ReturnVal
            while state do
                -- root entry 13092931 -> 1, states 1-5
                if state <= 3 then
                    if state <= 2 then
                        if state <= 1 then
                            if state == 1 then -- entry 13092931 -> 1
                                state = 1
                                r6 = state
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                ReturnVal = state(r6)
                                r2 = "math"
                                r5 = _env[r2]
                                r2 = "random"
                                ReturnVal = r5[r2]
                                r2 = 1
                                r1 = 2
                                r5 = ReturnVal(r2, r1)
                                ReturnVal = 1
                                state = r5 == ReturnVal
                                state = state and 2 or 3
                                r4 = args
                            end
                        else
                            if state == 2 then
                                state = 2
                                r6 = state
                                state = 3
                            end
                        end
                    else
                        if state == 3 then
                            r1 = "math"
                            r2 = _env[r1]
                            r1 = "random"
                            r5 = r2[r1]
                            r3 = 3
                            r1 = 2
                            r2 = r5(r1, r3)
                            r5 = 3
                            ReturnVal = r2 == r5
                            state = ReturnVal and 4 or 5
                        end
                    end
                else
                    if state <= 4 then
                        if state == 4 then
                            r5 = "print"
                            ReturnVal = _env[r5]
                            r5 = ReturnVal(r6)
                            ReturnVal = {}
                            state = nil
                        end
                    else
                        if state == 5 then
                            ReturnVal = 3
                            r6 = ReturnVal
                            r2 = "print"
                            r5 = _env[r2]
                            ReturnVal = {}
                            r2 = r5(r6)
                            r6 = nil
                            state = nil
                        end
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
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