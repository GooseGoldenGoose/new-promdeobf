return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, allocUpvalue, createClosure, upvalueValues, upvalueRefCounts, releaseUpvalues, vm, releaseUpvalue, createUpvalueProxy, createClosure0, currentUpvalueId)
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
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
                    return -994847
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -994847
                    end
                })
            end
        end
        upvalueValues = {}
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
        currentUpvalueId = 0
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        vm = function(state, args, upvalues, gcProxy)
            local ReturnVal, r1, r2, r3, r4, r5, r6, r7, r8
            while state do
                if state <= 4 then
                    -- root entry 5980939 -> 1, states 1-4
                    if state <= 2 then
                        if state <= 1 then
                            if state == 1 then -- entry 5980939 -> 1
                                r5 = 2
                                r2 = r5
                                r5 = 1
                                r8 = r5
                                r5 = 0
                                r3 = r8 < r5
                                ReturnVal = 1
                                r5 = ReturnVal - r8
                                r1 = args
                                state = 2
                            end
                        else
                            if state == 2 then
                                r5 = r5 + r8
                                r6 = not r3
                                ReturnVal = r5 <= r2
                                ReturnVal = r6 and ReturnVal
                                r6 = r5 >= r2
                                r6 = r3 and r6
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
                                r6 = allocUpvalue()
                                state = createClosure0(5, {
                                    r6
                                })
                                upvalueValues[r6] = r5
                                r6 = releaseUpvalue(r6)
                                r7 = state
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                r4 = {
                                    r7()
                                }
                                ReturnVal = state(unpack(r4))
                                r7 = nil
                                state = 2
                            end
                        else
                            if state == 4 then
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    end
                else
                    -- createClosure0 entry 1392556 -> 5, states 5-5
                    if state == 5 then -- entry 1392556 -> 5
                        state = upvalueValues[upvalues[1]]
                        ReturnVal = {
                            state
                        }
                        state = nil
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)