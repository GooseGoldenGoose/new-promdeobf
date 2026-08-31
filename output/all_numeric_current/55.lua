return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, upvalueRefCounts, createClosure5, createClosure2, currentUpvalueId, createUpvalueProxy, allocUpvalue, upvalueValues, createClosure, releaseUpvalues, vm, releaseUpvalue)
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        upvalueValues = {}
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
        createClosure2 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1, arg2)
                return vm(entryId, {
                    arg1,
                    arg2
                }, captures, gcProxy)
            end
            return closure
        end
        upvalueRefCounts = {}
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, ReturnVal, r7, r8, r9, r10
            while state do
                if state <= 5 then
                    if state <= 4 then
                        -- root entry 5121747 -> 1, states 1-4
                        if state <= 2 then
                            if state <= 1 then
                                if state == 1 then -- entry 5121747 -> 1
                                    state = createClosure2(5, {})
                                    r8 = state
                                    r1 = {
                                        r8()
                                    }
                                    r5 = r1[3]
                                    state = r1[1]
                                    ReturnVal = r1[2]
                                    r1 = state
                                    r2 = args
                                    r7 = ReturnVal
                                    state = 2
                                end
                            else
                                if state == 2 then
                                    r5, r10 = r1(r7, r5)
                                    state = r5 and 3 or 4
                                end
                            end
                        else
                            if state <= 3 then
                                if state == 3 then
                                    r9 = r5
                                    r3 = "print"
                                    r6 = _env[r3]
                                    r4 = "custom"
                                    r3 = r6(r4, r9, r10)
                                    r10 = nil
                                    r9 = nil
                                    state = 2
                                end
                            else
                                if state == 4 then
                                    r8 = nil
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        end
                    else
                        -- createClosure2 entry 2638127 -> 5, states 5-5
                        if state == 5 then -- entry 2638127 -> 5
                            r2 = 5
                            r8 = 6
                            ReturnVal = 4
                            state = {
                                ReturnVal,
                                r2,
                                r8
                            }
                            r2 = state
                            state = createClosure5(6, {})
                            r8 = state
                            state = nil
                            ReturnVal = {
                                r8,
                                r2,
                                state
                            }
                            state = nil
                        end
                    end
                else
                    -- createClosure5 entry 15754369 -> 6, states 6-8
                    if state <= 7 then
                        if state <= 6 then
                            if state == 6 then -- entry 15754369 -> 6
                                r8 = args[2]
                                r2 = args[1]
                                r1 = 0
                                ReturnVal = r8 or r1
                                r5 = state
                                r5 = 1
                                state = ReturnVal + r5
                                r5 = state
                                ReturnVal = r2[r5]
                                r1 = ReturnVal
                                r7 = nil
                                ReturnVal = r1 ~= r7
                                state = ReturnVal and 7 or 8
                            end
                        else
                            if state == 7 then
                                ReturnVal = {
                                    r5,
                                    r1
                                }
                                state = nil
                            end
                        end
                    else
                        if state == 8 then
                            r1 = nil
                            r5 = nil
                            r8 = nil
                            r2 = nil
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
        currentUpvalueId = 0
        releaseUpvalues = function(captures)
            local captureIndex, upvalueId = 1, captures[1]
            while upvalueId do
                upvalueRefCounts[upvalueId], captureIndex = upvalueRefCounts[upvalueId] - (1), captureIndex + (1)
                if 0 == upvalueRefCounts[upvalueId] then
                    upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
                end
                upvalueId = captures[captureIndex]
            end
        end
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
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