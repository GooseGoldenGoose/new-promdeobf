return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalue, currentUpvalueId, allocUpvalue, upvalueRefCounts, upvalueValues, createClosure, vm, createUpvalueProxy, releaseUpvalues)
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
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
            local r1, r2, r3, ReturnVal, r4, r5, r6, r7
            while state do
                -- root entry 6058829 -> 1, states 1-10
                if state <= 5 then
                    if state <= 3 then
                        if state <= 2 then
                            if state <= 1 then
                                if state == 1 then -- entry 6058829 -> 1
                                    r4 = 10
                                    r3 = r4
                                    r4 = 1
                                    r2 = r4
                                    r4 = 0
                                    r6 = r2 < r4
                                    ReturnVal = 1
                                    r4 = ReturnVal - r2
                                    r5 = args
                                    state = 2
                                end
                            else
                                if state == 2 then
                                    r4 = r4 + r2
                                    r7 = not r6
                                    ReturnVal = r4 <= r3
                                    ReturnVal = r7 and ReturnVal
                                    r7 = r4 >= r3
                                    r7 = r6 and r7
                                    ReturnVal = r7 or ReturnVal
                                    r7 = 3
                                    state = ReturnVal and r7
                                    ReturnVal = 4
                                    state = state or ReturnVal
                                end
                            end
                        else
                            if state == 3 then
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                r7 = r4
                                r1 = "a"
                                ReturnVal = state(r1, r7)
                                r7 = nil
                                state = 2
                            end
                        end
                    else
                        if state <= 4 then
                            if state == 4 then
                                r4 = 2
                                r3 = r4
                                r4 = 2
                                r2 = r4
                                r4 = 0
                                r6 = r2 < r4
                                ReturnVal = 1
                                r4 = ReturnVal - r2
                                state = 5
                            end
                        else
                            if state == 5 then
                                r4 = r4 + r2
                                ReturnVal = r4 <= r3
                                r7 = not r6
                                ReturnVal = r7 and ReturnVal
                                r7 = r4 >= r3
                                r7 = r6 and r7
                                ReturnVal = r7 or ReturnVal
                                r7 = 6
                                state = ReturnVal and r7
                                ReturnVal = 7
                                state = state or ReturnVal
                            end
                        end
                    end
                else
                    if state <= 8 then
                        if state <= 7 then
                            if state <= 6 then
                                if state == 6 then
                                    ReturnVal = "print"
                                    state = _env[ReturnVal]
                                    r7 = r4
                                    r1 = "b"
                                    ReturnVal = state(r1, r7)
                                    r7 = nil
                                    state = 5
                                end
                            else
                                if state == 7 then
                                    r4 = 1
                                    r3 = r4
                                    r4 = -1
                                    r2 = r4
                                    r4 = 0
                                    r6 = r2 < r4
                                    ReturnVal = 3
                                    r4 = ReturnVal - r2
                                    state = 8
                                end
                            end
                        else
                            if state == 8 then
                                r7 = not r6
                                r4 = r4 + r2
                                ReturnVal = r4 <= r3
                                ReturnVal = r7 and ReturnVal
                                r7 = r4 >= r3
                                r7 = r6 and r7
                                ReturnVal = r7 or ReturnVal
                                r7 = 9
                                state = ReturnVal and r7
                                ReturnVal = 10
                                state = state or ReturnVal
                            end
                        end
                    else
                        if state <= 9 then
                            if state == 9 then
                                r7 = r4
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                r1 = "c"
                                ReturnVal = state(r1, r7)
                                r7 = nil
                                state = 8
                            end
                        else
                            if state == 10 then
                                ReturnVal = {}
                                state = nil
                            end
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
        upvalueValues = {}
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 214072
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 214072
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