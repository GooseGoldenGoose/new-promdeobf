return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, vm, releaseUpvalue, createClosure, currentUpvalueId, createClosure5, createUpvalueProxy, allocUpvalue, upvalueRefCounts, releaseUpvalues, upvalueValues)
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
        upvalueRefCounts = {}
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        upvalueValues = {}
        createClosure = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(...)
                return vm(entryId, {
                    ...
                }, captures, gcProxy)
            end
            return closure
        end
        vm = function(state, args, upvalues, gcProxy)
            local r1, ReturnVal, r2, r3, r4, r5, r6, r7, r8, r9, r10
            while state do
                if state <= 7 then
                    -- root entry 5121747 -> 1, states 1-7
                    if state <= 4 then
                        if state <= 2 then
                            if state <= 1 then
                                if state == 1 then -- entry 5121747 -> 1
                                    ReturnVal = "ipairs"
                                    state = _env[ReturnVal]
                                    r10 = 4
                                    r9 = 6
                                    r8 = 2
                                    r1 = {
                                        r8,
                                        r10,
                                        r9
                                    }
                                    r8 = {
                                        state(r1)
                                    }
                                    r3 = r8[3]
                                    ReturnVal = r8[1]
                                    r2 = r8[2]
                                    r1 = ReturnVal
                                    r4 = args
                                    state = 2
                                end
                            else
                                if state == 2 then
                                    r3, r10 = r1(r2, r3)
                                    state = r3 and 3 or 4
                                end
                            end
                        else
                            if state <= 3 then
                                if state == 3 then
                                    r8 = r3
                                    state = allocUpvalue()
                                    upvalueValues[state] = r8
                                    r8 = state
                                    state = allocUpvalue()
                                    upvalueValues[state] = r10
                                    r10 = state
                                    state = createClosure5(8, {
                                        r8,
                                        r10
                                    })
                                    r7 = upvalueValues[r8]
                                    r9 = state
                                    r6 = 2
                                    state = r7 == r6
                                    state = state and 5 or 6
                                end
                            else
                                if state == 4 then
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        end
                    else
                        if state <= 6 then
                            if state <= 5 then
                                if state == 5 then
                                    r7 = "print"
                                    state = _env[r7]
                                    r5 = {
                                        r9()
                                    }
                                    r6 = "cap-a"
                                    r7 = state(r6, unpack(r5))
                                    state = 7
                                end
                            else
                                if state == 6 then
                                    r7 = "print"
                                    state = _env[r7]
                                    r5 = {
                                        r9()
                                    }
                                    r6 = "cap-b"
                                    r7 = state(r6, unpack(r5))
                                    state = 7
                                end
                            end
                        else
                            if state == 7 then
                                r8 = releaseUpvalue(r8)
                                r10 = releaseUpvalue(r10)
                                r9 = nil
                                state = 2
                            end
                        end
                    end
                else
                    -- createClosure5 entry 5578347 -> 8, states 8-8
                    if state == 8 then -- entry 5578347 -> 8
                        ReturnVal = upvalueValues[upvalues[1]]
                        r4 = upvalueValues[upvalues[2]]
                        state = ReturnVal + r4
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
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)