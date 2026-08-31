return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalue, createClosure6, releaseUpvalues, allocUpvalue, upvalueValues, vm, createClosure5, createClosure, createUpvalueProxy, currentUpvalueId, upvalueRefCounts)
        upvalueValues = {}
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        upvalueRefCounts = {}
        createClosure5 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1, arg2, arg3, arg4, arg5)
                return vm(entryId, {
                    arg1,
                    arg2,
                    arg3,
                    arg4,
                    arg5
                }, captures, gcProxy)
            end
            return closure
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -3252275
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -3252275
                    end
                })
            end
        end
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, ReturnVal, r5, r6, r7
            while state do
                if state <= 8 then
                    if state <= 1 then
                        -- root entry 3471786 -> 1, states 1-1
                        if state == 1 then -- entry 3471786 -> 1
                            r7 = allocUpvalue()
                            state = 3
                            upvalueValues[r7] = state
                            state = createClosure6(2, {
                                r7
                            })
                            r5 = state
                            r1 = 2
                            r4 = {
                                r5(r1)
                            }
                            state = r4[1]
                            ReturnVal = r4[2]
                            r3 = r4[3]
                            r7 = releaseUpvalue(r7)
                            r4 = ReturnVal
                            r1 = state
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r6 = "theory"
                            ReturnVal = state(r6, r1, r4, r3)
                            r2 = args
                            r1 = nil
                            r4 = nil
                            r3 = nil
                            r5 = nil
                            ReturnVal = {}
                            state = nil
                        end
                    else
                        -- createClosure6 entry 7146503 -> 2, states 2-8
                        if state <= 5 then
                            if state <= 3 then
                                if state <= 2 then
                                    if state == 2 then -- entry 7146503 -> 2
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r2 = args[1]
                                        r7 = allocUpvalue()
                                        state = r2 + ReturnVal
                                        upvalueValues[r7] = state
                                        ReturnVal = upvalueValues[r7]
                                        r5 = 5
                                        state = ReturnVal > r5
                                        state = state and 3 or 4
                                    end
                                else
                                    if state == 3 then
                                        ReturnVal = upvalueValues[r7]
                                        r5 = 1
                                        state = ReturnVal - r5
                                        upvalueValues[r7] = state
                                        state = 5
                                    end
                                end
                            else
                                if state <= 4 then
                                    if state == 4 then
                                        r5 = upvalueValues[r7]
                                        r3 = 2
                                        ReturnVal = r5 + r3
                                        upvalueValues[r7] = ReturnVal
                                        state = 5
                                    end
                                else
                                    if state == 5 then
                                        state = 6
                                    end
                                end
                            end
                        else
                            if state <= 7 then
                                if state <= 6 then
                                    if state == 6 then
                                        r3 = upvalueValues[r7]
                                        r1 = 8
                                        r5 = r3 < r1
                                        state = r5 and 7 or 8
                                    end
                                else
                                    if state == 7 then
                                        r3 = upvalueValues[r7]
                                        r1 = 1
                                        r5 = r3 + r1
                                        upvalueValues[r7] = r5
                                        state = 6
                                    end
                                end
                            else
                                if state == 8 then
                                    r3 = createClosure5(9, {
                                        r7
                                    })
                                    r4 = 2
                                    r1 = r3(r4)
                                    r6 = 3
                                    r4 = r3(r6)
                                    r6 = upvalueValues[r7]
                                    ReturnVal = {
                                        r6,
                                        r1,
                                        r4
                                    }
                                    state = nil
                                end
                            end
                        end
                    end
                else
                    -- createClosure5 entry 2234492 -> 9, states 9-11
                    if state <= 10 then
                        if state <= 9 then
                            if state == 9 then -- entry 2234492 -> 9
                                r2 = args[1]
                                r7 = 2
                                ReturnVal = r2 % r7
                                r7 = 0
                                state = ReturnVal == r7
                                state = state and 10 or 11
                            end
                        else
                            if state == 10 then
                                ReturnVal = upvalueValues[upvalues[1]]
                                state = ReturnVal + r2
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        end
                    else
                        if state == 11 then
                            ReturnVal = upvalueValues[upvalues[1]]
                            state = ReturnVal - r2
                            ReturnVal = {
                                state
                            }
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
        createClosure6 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1, arg2, arg3, arg4, arg5, arg6)
                return vm(entryId, {
                    arg1,
                    arg2,
                    arg3,
                    arg4,
                    arg5,
                    arg6
                }, captures, gcProxy)
            end
            return closure
        end
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)