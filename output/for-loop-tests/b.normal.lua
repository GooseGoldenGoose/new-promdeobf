return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, vm, upvalueValues, releaseUpvalue, currentUpvalueId, createUpvalueProxy, releaseUpvalues, createClosure, allocUpvalue, upvalueRefCounts)
        upvalueRefCounts = {}
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, ReturnVal, r2, r3, r4, r5, r6
            while state do
                -- root entry 10774943 -> 1, states 1-4
                if state <= 2 then
                    if state <= 1 then
                        if state == 1 then -- entry 10774943 -> 1
                            r6 = 2
                            r3 = r6
                            r6 = 2
                            r5 = r6
                            r6 = 0
                            r2 = r5 < r6
                            ReturnVal = 1
                            r6 = ReturnVal - r5
                            r4 = args
                            state = 2
                        end
                    else
                        if state == 2 then
                            r6 = r6 + r5
                            r1 = not r2
                            ReturnVal = r6 <= r3
                            ReturnVal = r1 and ReturnVal
                            r1 = r6 >= r3
                            r1 = r2 and r1
                            ReturnVal = r1 or ReturnVal
                            r1 = 3
                            state = ReturnVal and r1
                            ReturnVal = 4
                            state = state or ReturnVal
                        end
                    end
                else
                    if state <= 3 then
                        if state == 3 then
                            r1 = r6
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            ReturnVal = state(r1)
                            r1 = nil
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 3582028
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 3582028
                    end
                })
            end
        end
        upvalueValues = {}
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)