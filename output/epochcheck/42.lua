return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure, currentUpvalueId, allocUpvalue, vm, createUpvalueProxy, releaseUpvalues, upvalueValues, upvalueRefCounts, releaseUpvalue)
        vm = function(state, args, upvalues, gcProxy)
            local ReturnVal, r1, r2, r3, r4
            while state do
                -- root entry 15698122 -> 1, states 1-6
                if state <= 3 then
                    if state <= 2 then
                        if state <= 1 then
                            if state == 1 then -- entry 15698122 -> 1
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                r4 = "s42-start"
                                ReturnVal = state(r4)
                                state = 0
                                r4 = state
                                ReturnVal = 4
                                state = r4 >= ReturnVal
                                r1 = args
                                state = 2
                            end
                        else
                            if state == 2 then
                                ReturnVal = 1
                                state = r4 + ReturnVal
                                r4 = state
                                r2 = 3
                                ReturnVal = r4 < r2
                                state = ReturnVal and 3 or 4
                            end
                        end
                    else
                        if state == 3 then
                            state = 5
                        end
                    end
                else
                    if state <= 5 then
                        if state <= 4 then
                            if state == 4 then
                                r2 = "print"
                                ReturnVal = _env[r2]
                                r3 = "s42-body"
                                r2 = ReturnVal(r3, r4)
                                state = 5
                            end
                        else
                            if state == 5 then
                                r2 = 4
                                ReturnVal = r4 >= r2
                                state = ReturnVal and 6 or 2
                            end
                        end
                    else
                        if state == 6 then
                            r2 = "print"
                            ReturnVal = _env[r2]
                            r3 = "s42-end"
                            r2 = ReturnVal(r3, r4)
                            r4 = nil
                            ReturnVal = {}
                            state = nil
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
        currentUpvalueId = 0
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
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        upvalueRefCounts = {}
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)