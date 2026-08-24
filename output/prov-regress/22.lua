return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure3, currentUpvalueId, allocUpvalue, releaseUpvalue, upvalueRefCounts, createClosure, vm, upvalueValues, createClosure5, createClosure4, releaseUpvalues, createUpvalueProxy)
        upvalueRefCounts = {}
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, ReturnVal, r3
            while state do
                if state <= 2 then
                    if state <= 1 then
                        -- root entry 8411032 -> 1, states 1-1
                        if state == 1 then -- entry 8411032 -> 1
                            state = createClosure4(2, {})
                            r2 = state
                            state = {}
                            r3 = state
                            state = createClosure5(3, {})
                            ReturnVal = "hee"
                            r3[ReturnVal] = state
                            ReturnVal = createClosure3(4, {})
                            state = "yai"
                            r3[state] = ReturnVal
                            state = "yai"
                            state = r3[state]
                            state = state(r3)
                            state = "hee"
                            state = r3[state]
                            ReturnVal = {}
                            state = state(r3)
                            r1 = args
                            r2 = nil
                            r3 = nil
                            state = nil
                        end
                    else
                        -- createClosure4 entry 11922475 -> 2, states 2-2
                        if state == 2 then -- entry 11922475 -> 2
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r1 = "g"
                            ReturnVal = state(r1)
                            ReturnVal = {}
                            state = nil
                        end
                    end
                else
                    if state <= 3 then
                        -- createClosure5 entry 14386416 -> 3, states 3-3
                        if state == 3 then -- entry 14386416 -> 3
                            r1 = args[1]
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r2 = "hee"
                            ReturnVal = state(r2, r1)
                            r1 = nil
                            ReturnVal = {}
                            state = nil
                        end
                    else
                        -- createClosure3 entry 11788429 -> 4, states 4-4
                        if state == 4 then -- entry 11788429 -> 4
                            r1 = args[1]
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r2 = "yai"
                            ReturnVal = state(r2, r1)
                            r1 = nil
                            ReturnVal = {}
                            state = nil
                        end
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
        createClosure4 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1, arg2, arg3, arg4)
                return vm(entryId, {
                    arg1,
                    arg2,
                    arg3,
                    arg4
                }, captures, gcProxy)
            end
            return closure
        end
        upvalueValues = {}
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
        createClosure3 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1, arg2, arg3)
                return vm(entryId, {
                    arg1,
                    arg2,
                    arg3
                }, captures, gcProxy)
            end
            return closure
        end
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 978288
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 978288
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