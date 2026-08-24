return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, allocUpvalue, createClosure, upvalueValues, releaseUpvalue, vm, currentUpvalueId, createUpvalueProxy, upvalueRefCounts, releaseUpvalues)
        createClosure = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(...)
                return vm(entryId, {
                    ...
                }, captures, gcProxy)
            end
            return closure
        end
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
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
        upvalueRefCounts = {}
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, ReturnVal, r6
            while state do
                -- root entry 5113365 -> 1, states 1-4
                if state <= 2 then
                    if state <= 1 then
                        if state == 1 then -- entry 5113365 -> 1
                            r1 = 10
                            r2 = r1
                            r1 = 1
                            r3 = r1
                            r1 = 0
                            r4 = r3 < r1
                            ReturnVal = 1
                            r1 = ReturnVal - r3
                            r6 = args
                            state = 2
                        end
                    else
                        if state == 2 then
                            r5 = not r4
                            r1 = r1 + r3
                            ReturnVal = r1 <= r2
                            ReturnVal = r5 and ReturnVal
                            r5 = r1 >= r2
                            r5 = r4 and r5
                            ReturnVal = r5 or ReturnVal
                            r5 = 3
                            state = ReturnVal and r5
                            ReturnVal = 4
                            state = state or ReturnVal
                        end
                    end
                else
                    if state <= 3 then
                        if state == 3 then
                            r5 = r1
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            ReturnVal = state(r5)
                            r5 = nil
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -1577928
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -1577928
                    end
                })
            end
        end
        upvalueValues = {}
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)