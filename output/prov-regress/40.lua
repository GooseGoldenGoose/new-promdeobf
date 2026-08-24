return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, upvalueValues, releaseUpvalues, createClosure, createUpvalueProxy, releaseUpvalue, currentUpvalueId, allocUpvalue, vm, upvalueRefCounts)
        currentUpvalueId = 0
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, ReturnVal, r7, r8
            while state do
                -- root entry 15698122 -> 1, states 1-6
                if state <= 3 then
                    if state <= 2 then
                        if state <= 1 then
                            if state == 1 then -- entry 15698122 -> 1
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                r1 = "s40-start"
                                ReturnVal = state(r1)
                                r1 = 3
                                r3 = r1
                                r1 = 1
                                r7 = r1
                                r1 = 0
                                r8 = r7 < r1
                                ReturnVal = 1
                                r1 = ReturnVal - r7
                                r5 = args
                                state = 2
                            end
                        else
                            if state == 2 then
                                r4 = not r8
                                r1 = r1 + r7
                                ReturnVal = r1 <= r3
                                ReturnVal = r4 and ReturnVal
                                r4 = r1 >= r3
                                r4 = r8 and r4
                                ReturnVal = r4 or ReturnVal
                                r4 = 3
                                state = ReturnVal and r4
                                ReturnVal = 4
                                state = state or ReturnVal
                            end
                        end
                    else
                        if state == 3 then
                            r4 = r1
                            ReturnVal = 10
                            state = r4 * ReturnVal
                            r6 = state
                            ReturnVal = 2
                            state = r4 == ReturnVal
                            state = state and 5 or 6
                        end
                    end
                else
                    if state <= 5 then
                        if state <= 4 then
                            if state == 4 then
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                r1 = "s40-end"
                                ReturnVal = state(r1)
                                ReturnVal = {}
                                state = nil
                            end
                        else
                            if state == 5 then
                                r6 = nil
                                r4 = nil
                                state = 2
                            end
                        end
                    else
                        if state == 6 then
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r2 = "s40-do"
                            ReturnVal = state(r2, r4, r6)
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r6 = nil
                            r6 = "s40-after"
                            ReturnVal = state(r6, r4)
                            r4 = nil
                            state = 2
                        end
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
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
        releaseUpvalues = function(captures)
            local captureIndex, upvalueId = 1, captures[1]
            while upvalueId do
                upvalueRefCounts[upvalueId], captureIndex = upvalueRefCounts[upvalueId] - (1), captureIndex + (1)
                if upvalueRefCounts[upvalueId] == 0 then
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
        upvalueValues = {}
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)