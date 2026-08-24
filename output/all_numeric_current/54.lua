return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalues, createClosure, upvalueRefCounts, upvalueValues, createUpvalueProxy, allocUpvalue, currentUpvalueId, releaseUpvalue, vm)
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, ReturnVal, r6, r7, r8, r9, r10
            while state do
                -- root entry 5121747 -> 1, states 1-4
                if state <= 2 then
                    if state <= 1 then
                        if state == 1 then -- entry 5121747 -> 1
                            r6 = 20
                            r2 = 30
                            ReturnVal = 10
                            state = {
                                ReturnVal,
                                r6,
                                r2
                            }
                            r6 = state
                            ReturnVal = "next"
                            state = _env[ReturnVal]
                            r2 = state
                            ReturnVal = nil
                            r10 = args
                            r7 = r6
                            r3 = ReturnVal
                            state = 2
                        end
                    else
                        if state == 2 then
                            r3, r5 = r2(r7, r3)
                            state = r3 and 3 or 4
                        end
                    end
                else
                    if state <= 3 then
                        if state == 3 then
                            r9 = "print"
                            r4 = _env[r9]
                            r8 = r3
                            r1 = "next"
                            r9 = r4(r1, r8, r5)
                            r8 = nil
                            r5 = nil
                            state = 2
                        end
                    else
                        if state == 4 then
                            r6 = nil
                            ReturnVal = {}
                            state = nil
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
        currentUpvalueId = 0
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        upvalueRefCounts = {}
        upvalueValues = {}
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)