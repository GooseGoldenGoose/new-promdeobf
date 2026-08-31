return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, upvalueValues, createClosure1, vm, releaseUpvalue, createClosure, createUpvalueProxy, releaseUpvalues, allocUpvalue, currentUpvalueId, upvalueRefCounts)
        upvalueRefCounts = {}
        currentUpvalueId = 0
        upvalueValues = {}
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
        createClosure1 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1)
                return vm(entryId, {
                    arg1
                }, captures, gcProxy)
            end
            return closure
        end
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        vm = function(state, args, upvalues, gcProxy)
            local ReturnVal, r1, r2, r3, r4, r5, r6, r7
            while state do
                if state <= 1 then
                    -- root entry 15698122 -> 1, states 1-1
                    if state == 1 then -- entry 15698122 -> 1
                        state = createClosure1(2, {})
                        r5 = state
                        ReturnVal = "print"
                        state = _env[ReturnVal]
                        r1 = 3
                        r2 = {
                            r5(r1)
                        }
                        r3 = "s44-a"
                        ReturnVal = state(r3, unpack(r2))
                        ReturnVal = "print"
                        state = _env[ReturnVal]
                        r1 = 9
                        r2 = {
                            r5(r1)
                        }
                        r3 = "s44-b"
                        ReturnVal = state(r3, unpack(r2))
                        r6 = args
                        r5 = nil
                        ReturnVal = {}
                        state = nil
                    end
                else
                    -- createClosure1 entry 11491822 -> 2, states 2-11
                    if state <= 6 then
                        if state <= 4 then
                            if state <= 3 then
                                if state <= 2 then
                                    if state == 2 then -- entry 11491822 -> 2
                                        r6 = args[1]
                                        r5 = 5
                                        r3 = r5
                                        r5 = 1
                                        r2 = r5
                                        r5 = 0
                                        r1 = r2 < r5
                                        ReturnVal = 1
                                        r5 = ReturnVal - r2
                                        state = 3
                                    end
                                else
                                    if state == 3 then
                                        r5 = r5 + r2
                                        ReturnVal = r5 <= r3
                                        r4 = not r1
                                        ReturnVal = r4 and ReturnVal
                                        r4 = r5 >= r3
                                        r4 = r1 and r4
                                        ReturnVal = r4 or ReturnVal
                                        r4 = 4
                                        state = ReturnVal and r4
                                        ReturnVal = 5
                                        state = state or ReturnVal
                                    end
                                end
                            else
                                if state == 4 then
                                    r4 = r5
                                    state = r4 == r6
                                    state = state and 6 or 7
                                end
                            end
                        else
                            if state <= 5 then
                                if state == 5 then
                                    state = "done"
                                    ReturnVal = {
                                        state,
                                        r6
                                    }
                                    state = nil
                                end
                            else
                                if state == 6 then
                                    state = "ret"
                                    ReturnVal = {
                                        state,
                                        r4
                                    }
                                    state = nil
                                end
                            end
                        end
                    else
                        if state <= 9 then
                            if state <= 8 then
                                if state <= 7 then
                                    if state == 7 then
                                        ReturnVal = 2
                                        state = r4 == ReturnVal
                                        state = state and 8 or 9
                                    end
                                else
                                    if state == 8 then
                                        r4 = nil
                                        state = 3
                                    end
                                end
                            else
                                if state == 9 then
                                    ReturnVal = 4
                                    state = r4 == ReturnVal
                                    state = state and 10 or 11
                                end
                            end
                        else
                            if state <= 10 then
                                if state == 10 then
                                    r4 = nil
                                    state = 5
                                end
                            else
                                if state == 11 then
                                    ReturnVal = "print"
                                    state = _env[ReturnVal]
                                    r7 = "s44-body"
                                    ReturnVal = state(r7, r6, r4)
                                    r4 = nil
                                    state = 3
                                end
                            end
                        end
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)