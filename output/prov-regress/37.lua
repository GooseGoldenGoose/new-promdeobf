return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, upvalueRefCounts, allocUpvalue, createClosure, releaseUpvalues, vm, currentUpvalueId, createUpvalueProxy, upvalueValues, releaseUpvalue)
        upvalueValues = {}
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, ReturnVal, r3, r4, r5, r6, r7, r8
            while state do
                -- root entry 6306426 -> 1, states 1-4
                if state <= 2 then
                    if state <= 1 then
                        if state == 1 then -- entry 6306426 -> 1
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r2 = "mutate-for-start"
                            ReturnVal = state(r2)
                            r2 = 3
                            r1 = r2
                            r2 = 1
                            r8 = r2
                            r2 = 0
                            r5 = r8 < r2
                            ReturnVal = 1
                            r2 = ReturnVal - r8
                            r3 = args
                            state = 2
                        end
                    else
                        if state == 2 then
                            r6 = not r5
                            r2 = r2 + r8
                            ReturnVal = r2 <= r1
                            ReturnVal = r6 and ReturnVal
                            r6 = r2 >= r1
                            r6 = r5 and r6
                            ReturnVal = r6 or ReturnVal
                            r6 = 3
                            state = ReturnVal and r6
                            ReturnVal = 4
                            state = state or ReturnVal
                        end
                    end
                else
                    if state <= 3 then
                        if state == 3 then
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r6 = r2
                            r7 = "mutate-before"
                            ReturnVal = state(r7, r6)
                            ReturnVal = 10
                            state = r6 + ReturnVal
                            r6 = state
                            r7 = "print"
                            ReturnVal = _env[r7]
                            r4 = "mutate-after"
                            r7 = ReturnVal(r4, r6)
                            r6 = nil
                            state = 2
                        end
                    else
                        if state == 4 then
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r2 = "mutate-for-end"
                            ReturnVal = state(r2)
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
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        currentUpvalueId = 0
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)