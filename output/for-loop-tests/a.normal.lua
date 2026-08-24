return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalues, releaseUpvalue, upvalueRefCounts, allocUpvalue, createUpvalueProxy, vm, currentUpvalueId, upvalueValues, createClosure)
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        upvalueValues = {}
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
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
                    return -588774
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -588774
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
        currentUpvalueId = 0
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, ReturnVal, r4, r5, r6
            while state do
                -- root entry 16460529 -> 1, states 1-4
                if state <= 2 then
                    if state <= 1 then
                        if state == 1 then -- entry 16460529 -> 1
                            r4 = 10
                            r6 = r4
                            r4 = 1
                            r5 = r4
                            r4 = 0
                            r2 = r5 < r4
                            ReturnVal = 1
                            r4 = ReturnVal - r5
                            r1 = args
                            state = 2
                        end
                    else
                        if state == 2 then
                            r4 = r4 + r5
                            ReturnVal = r4 <= r6
                            r3 = not r2
                            ReturnVal = r3 and ReturnVal
                            r3 = r4 >= r6
                            r3 = r2 and r3
                            ReturnVal = r3 or ReturnVal
                            r3 = 3
                            state = ReturnVal and r3
                            ReturnVal = 4
                            state = state or ReturnVal
                        end
                    end
                else
                    if state <= 3 then
                        if state == 3 then
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r3 = r4
                            ReturnVal = state(r3)
                            r3 = nil
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
        upvalueRefCounts = {}
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)