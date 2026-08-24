return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, allocUpvalue, createUpvalueProxy, createClosure, releaseUpvalue, currentUpvalueId, upvalueValues, vm, releaseUpvalues, upvalueRefCounts)
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
            local r1, ReturnVal, r2, r3, r4, r5, r6, r7, r8
            while state do
                -- root entry 16515400 -> 1, states 1-7
                if state <= 4 then
                    if state <= 2 then
                        if state <= 1 then
                            if state == 1 then -- entry 16515400 -> 1
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                r5 = "before"
                                ReturnVal = state(r5)
                                state = 5
                                r5 = state
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                r3 = "outer-do"
                                ReturnVal = state(r3, r5)
                                r5 = nil
                                r5 = 5
                                r3 = r5
                                r5 = 1
                                r6 = r5
                                r5 = 0
                                r1 = r6 < r5
                                ReturnVal = 1
                                r5 = ReturnVal - r6
                                r7 = args
                                state = 2
                            end
                        else
                            if state == 2 then
                                r2 = not r1
                                r5 = r5 + r6
                                ReturnVal = r5 <= r3
                                ReturnVal = r2 and ReturnVal
                                r2 = r5 >= r3
                                r2 = r1 and r2
                                ReturnVal = r2 or ReturnVal
                                r2 = 3
                                state = ReturnVal and r2
                                ReturnVal = 4
                                state = state or ReturnVal
                            end
                        end
                    else
                        if state <= 3 then
                            if state == 3 then
                                r2 = r5
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                r8 = "loop"
                                ReturnVal = state(r8, r2)
                                ReturnVal = 2
                                state = r2 * ReturnVal
                                r8 = state
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                r4 = "inner-do"
                                ReturnVal = state(r4, r8)
                                r8 = nil
                                r8 = 2
                                ReturnVal = r2 % r8
                                r8 = 0
                                state = ReturnVal == r8
                                state = state and 5 or 6
                            end
                        else
                            if state == 4 then
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                r5 = "after"
                                ReturnVal = state(r5)
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    end
                else
                    if state <= 6 then
                        if state <= 5 then
                            if state == 5 then
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                r8 = "even"
                                ReturnVal = state(r8, r2)
                                state = 7
                            end
                        else
                            if state == 6 then
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                r8 = "odd"
                                ReturnVal = state(r8, r2)
                                state = 7
                            end
                        end
                    else
                        if state == 7 then
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r8 = "after-if"
                            ReturnVal = state(r8, r2)
                            r2 = nil
                            state = 2
                        end
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        upvalueRefCounts = {}
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 3294426
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 3294426
                    end
                })
            end
        end
        currentUpvalueId = 0
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)