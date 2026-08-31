return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalues, upvalueValues, currentUpvalueId, createClosure, vm, upvalueRefCounts, createUpvalueProxy, allocUpvalue, releaseUpvalue)
        upvalueValues = {}
        upvalueRefCounts = {}
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, ReturnVal, r7
            while state do
                -- root entry 15698122 -> 1, states 1-8
                if state <= 4 then
                    if state <= 2 then
                        if state <= 1 then
                            if state == 1 then -- entry 15698122 -> 1
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                r7 = "s39-start"
                                ReturnVal = state(r7)
                                r7 = 4
                                r5 = r7
                                r7 = 1
                                r3 = r7
                                r7 = 0
                                r1 = r3 < r7
                                ReturnVal = 1
                                r7 = ReturnVal - r3
                                r4 = args
                                state = 2
                            end
                        else
                            if state == 2 then
                                r6 = not r1
                                r7 = r7 + r3
                                ReturnVal = r7 <= r5
                                ReturnVal = r6 and ReturnVal
                                r6 = r7 >= r5
                                r6 = r1 and r6
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
                                r6 = r7
                                ReturnVal = 2
                                state = r6 == ReturnVal
                                state = state and 5 or 6
                            end
                        else
                            if state == 4 then
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                r7 = "s39-end"
                                ReturnVal = state(r7)
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    end
                else
                    if state <= 6 then
                        if state <= 5 then
                            if state == 5 then
                                r6 = nil
                                state = 2
                            end
                        else
                            if state == 6 then
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                r2 = "s39-for"
                                ReturnVal = state(r2, r6)
                                state = false
                                state = 7
                            end
                        end
                    else
                        if state <= 7 then
                            if state == 7 then
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                r2 = "s39-repeat"
                                ReturnVal = state(r2, r6)
                                state = 8
                            end
                        else
                            if state == 8 then
                                r6 = nil
                                state = 2
                            end
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
                upvalueRefCounts[upvalueId], captureIndex = upvalueRefCounts[upvalueId] - (1), (1) + captureIndex
                if 0 == upvalueRefCounts[upvalueId] then
                    upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
                end
                upvalueId = captures[captureIndex]
            end
        end
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 2107488
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 2107488
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
        currentUpvalueId = 0
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)