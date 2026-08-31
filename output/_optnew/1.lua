return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, allocUpvalue, releaseUpvalues, createClosure, createClosure5, upvalueValues, vm, upvalueRefCounts, releaseUpvalue, createUpvalueProxy, currentUpvalueId)
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
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -3987229
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -3987229
                    end
                })
            end
        end
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        upvalueRefCounts = {}
        vm = function(state, args, upvalues, gcProxy)
            local r1, ReturnVal, r2, r3, r4, r5, r6, r7
            while state do
                if state <= 1 then
                    -- root entry 7031306 -> 1, states 1-1
                    if state == 1 then -- entry 7031306 -> 1
                        r6 = allocUpvalue()
                        state = 4
                        upvalueValues[r6] = state
                        state = createClosure5(2, {
                            r6
                        })
                        r6 = releaseUpvalue(r6)
                        r5 = state
                        ReturnVal = "print"
                        state = _env[ReturnVal]
                        r2 = 3
                        r3 = r5(r2)
                        r4 = 1
                        r2 = {
                            r5(r4)
                        }
                        r1 = "baseline"
                        ReturnVal = state(r1, r3, unpack(r2))
                        r7 = args
                        r5 = nil
                        ReturnVal = {}
                        state = nil
                    end
                else
                    -- createClosure5 entry 15351943 -> 2, states 2-5
                    if state <= 3 then
                        if state <= 2 then
                            if state == 2 then -- entry 15351943 -> 2
                                ReturnVal = upvalueValues[upvalues[1]]
                                r7 = args[1]
                                state = ReturnVal + r7
                                r6 = state
                                ReturnVal = 6
                                state = r6 > ReturnVal
                                state = state and 3 or 4
                            end
                        else
                            if state == 3 then
                                ReturnVal = 2
                                state = r6 * ReturnVal
                                r6 = state
                                state = 5
                            end
                        end
                    else
                        if state <= 4 then
                            if state == 4 then
                                r5 = 1
                                ReturnVal = r6 - r5
                                r6 = ReturnVal
                                state = 5
                            end
                        else
                            if state == 5 then
                                ReturnVal = {
                                    r6
                                }
                                state = nil
                            end
                        end
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
        currentUpvalueId = 0
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
        upvalueValues = {}
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)