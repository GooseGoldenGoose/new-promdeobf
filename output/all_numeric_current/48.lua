return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure1, allocUpvalue, createUpvalueProxy, upvalueValues, createClosure, releaseUpvalues, vm, currentUpvalueId, upvalueRefCounts, releaseUpvalue)
        currentUpvalueId = 0
        createClosure1 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1)
                return vm(entryId, {
                    arg1
                }, captures, gcProxy)
            end
            return closure
        end
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, ReturnVal, r4, r5, r6, r7, r8
            while state do
                if state <= 9 then
                    -- root entry 4195707 -> 1, states 1-9
                    if state <= 5 then
                        if state <= 3 then
                            if state <= 2 then
                                if state <= 1 then
                                    if state == 1 then -- entry 4195707 -> 1
                                        r3 = allocUpvalue()
                                        state = 0
                                        upvalueValues[r3] = state
                                        state = createClosure1(10, {
                                            r3
                                        })
                                        r1 = state
                                        r8 = false
                                        r7 = r1(r8)
                                        state = r7 and 2 or 3
                                        ReturnVal = r7
                                        r2 = args
                                    end
                                else
                                    if state == 2 then
                                        r7 = ReturnVal
                                        r6 = true
                                        r8 = r1(r6)
                                        state = r8 and 4 or 5
                                        ReturnVal = r8
                                    end
                                end
                            else
                                if state == 3 then
                                    r8 = true
                                    r7 = r1(r8)
                                    ReturnVal = r7
                                    state = 2
                                end
                            end
                        else
                            if state <= 4 then
                                if state == 4 then
                                    r6 = false
                                    r8 = r1(r6)
                                    ReturnVal = r8
                                    state = 5
                                end
                            else
                                if state == 5 then
                                    r5 = false
                                    r6 = r1(r5)
                                    state = r6 and 6 or 7
                                    r8 = ReturnVal
                                    ReturnVal = r6
                                end
                            end
                        end
                    else
                        if state <= 7 then
                            if state <= 6 then
                                if state == 6 then
                                    state = ReturnVal and 8 or 9
                                end
                            else
                                if state == 7 then
                                    r5 = upvalueValues[r3]
                                    r4 = 5
                                    r6 = r5 == r4
                                    ReturnVal = r6
                                    state = 6
                                end
                            end
                        else
                            if state <= 8 then
                                if state == 8 then
                                    ReturnVal = "print"
                                    state = _env[ReturnVal]
                                    r5 = upvalueValues[r3]
                                    r6 = "if-or"
                                    ReturnVal = state(r6, r7, r8, r5)
                                    state = 9
                                end
                            else
                                if state == 9 then
                                    ReturnVal = "print"
                                    state = _env[ReturnVal]
                                    r5 = upvalueValues[r3]
                                    r6 = "done"
                                    ReturnVal = state(r6, r7, r8, r5)
                                    ReturnVal = {}
                                    r3 = releaseUpvalue(r3)
                                    r1 = nil
                                    r8 = nil
                                    r7 = nil
                                    state = nil
                                end
                            end
                        end
                    end
                else
                    -- createClosure1 entry 4988788 -> 10, states 10-10
                    if state == 10 then -- entry 4988788 -> 10
                        ReturnVal = upvalueValues[upvalues[1]]
                        r2 = args[1]
                        r3 = 1
                        state = ReturnVal + r3
                        upvalueValues[upvalues[1]] = state
                        ReturnVal = {
                            r2
                        }
                        state = nil
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -3863437
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -3863437
                    end
                })
            end
        end
        upvalueRefCounts = {}
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
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)