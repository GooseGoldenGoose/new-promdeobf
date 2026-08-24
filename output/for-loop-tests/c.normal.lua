return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalues, createClosure, createUpvalueProxy, allocUpvalue, upvalueRefCounts, vm, releaseUpvalue, upvalueValues, currentUpvalueId)
        upvalueValues = {}
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, ReturnVal, r6
            while state do
                -- root entry 9491315 -> 1, states 1-4
                if state <= 2 then
                    if state <= 1 then
                        if state == 1 then -- entry 9491315 -> 1
                            r6 = 1
                            r1 = r6
                            r6 = -1
                            r2 = r6
                            r6 = 0
                            r5 = r2 < r6
                            ReturnVal = 3
                            r6 = ReturnVal - r2
                            r3 = args
                            state = 2
                        end
                    else
                        if state == 2 then
                            r4 = not r5
                            r6 = r6 + r2
                            ReturnVal = r6 <= r1
                            ReturnVal = r4 and ReturnVal
                            r4 = r6 >= r1
                            r4 = r5 and r4
                            ReturnVal = r4 or ReturnVal
                            r4 = 3
                            state = ReturnVal and r4
                            ReturnVal = 4
                            state = state or ReturnVal
                        end
                    end
                else
                    if state <= 3 then
                        if state == 3 then
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r4 = r6
                            ReturnVal = state(r4)
                            r4 = nil
                            state = 2
                        end
                    else
                        if state == 4 then
                            ReturnVal = {}
                            state = nil
                        end
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -869558
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -869558
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