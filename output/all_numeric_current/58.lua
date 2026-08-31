return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, upvalueRefCounts, upvalueValues, createUpvalueProxy, allocUpvalue, releaseUpvalue, releaseUpvalues, createClosure, currentUpvalueId, vm)
        currentUpvalueId = 0
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, ReturnVal
            while state do
                -- root entry 5121747 -> 1, states 1-6
                if state <= 3 then
                    if state <= 2 then
                        if state <= 1 then
                            if state == 1 then -- entry 5121747 -> 1
                                ReturnVal = "ipairs"
                                state = _env[ReturnVal]
                                r8 = 2
                                r1 = 4
                                r5 = 1
                                r2 = 3
                                r4 = {
                                    r5,
                                    r8,
                                    r2,
                                    r1
                                }
                                r5 = {
                                    state(r4)
                                }
                                ReturnVal = r5[1]
                                r3 = r5[2]
                                r6 = r5[3]
                                r7 = args
                                r4 = ReturnVal
                                state = 2
                            end
                        else
                            if state == 2 then
                                r6, r8 = r4(r3, r6)
                                state = r6 and 3 or 4
                            end
                        end
                    else
                        if state == 3 then
                            r5 = r6
                            r2 = 2
                            state = r5 == r2
                            state = state and 5 or 6
                        end
                    end
                else
                    if state <= 5 then
                        if state <= 4 then
                            if state == 4 then
                                r3 = "print"
                                state = _env[r3]
                                r6 = "after-continue"
                                r3 = state(r6)
                                ReturnVal = {}
                                state = nil
                            end
                        else
                            if state == 5 then
                                r8 = nil
                                r5 = nil
                                state = 2
                            end
                        end
                    else
                        if state == 6 then
                            r2 = "print"
                            state = _env[r2]
                            r1 = "keep"
                            r2 = state(r1, r5, r8)
                            r5 = nil
                            r8 = nil
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
        upvalueValues = {}
        upvalueRefCounts = {}
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -3225309
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -3225309
                    end
                })
            end
        end
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)