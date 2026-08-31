return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalue, vm, createClosure, releaseUpvalues, upvalueRefCounts, upvalueValues, allocUpvalue, currentUpvalueId, createUpvalueProxy)
        currentUpvalueId = 0
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        upvalueRefCounts = {}
        upvalueValues = {}
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, ReturnVal, r6, r7, r8, r9, r10
            while state do
                -- root entry 6306426 -> 1, states 1-17
                if state <= 9 then
                    if state <= 5 then
                        if state <= 3 then
                            if state <= 2 then
                                if state <= 1 then
                                    if state == 1 then -- entry 6306426 -> 1
                                        ReturnVal = "print"
                                        state = _env[ReturnVal]
                                        r8 = "nested-control-start"
                                        ReturnVal = state(r8)
                                        r8 = 3
                                        r9 = r8
                                        r8 = 1
                                        r3 = r8
                                        r8 = 0
                                        r6 = r3 < r8
                                        ReturnVal = 1
                                        r8 = ReturnVal - r3
                                        r1 = args
                                        state = 2
                                    end
                                else
                                    if state == 2 then
                                        r10 = not r6
                                        r8 = r8 + r3
                                        ReturnVal = r8 <= r9
                                        ReturnVal = r10 and ReturnVal
                                        r10 = r8 >= r9
                                        r10 = r6 and r10
                                        ReturnVal = r10 or ReturnVal
                                        r10 = 3
                                        state = ReturnVal and r10
                                        ReturnVal = 4
                                        state = state or ReturnVal
                                    end
                                end
                            else
                                if state == 3 then
                                    state = 0
                                    r4 = state
                                    r10 = r8
                                    state = 5
                                end
                            end
                        else
                            if state <= 4 then
                                if state == 4 then
                                    ReturnVal = "print"
                                    state = _env[ReturnVal]
                                    r8 = "nested-control-end"
                                    ReturnVal = state(r8)
                                    ReturnVal = {}
                                    state = nil
                                end
                            else
                                if state == 5 then
                                    ReturnVal = 4
                                    state = r4 < ReturnVal
                                    state = state and 6 or 7
                                end
                            end
                        end
                    else
                        if state <= 7 then
                            if state <= 6 then
                                if state == 6 then
                                    ReturnVal = 1
                                    state = r4 + ReturnVal
                                    r4 = state
                                    r5 = 2
                                    ReturnVal = r4 == r5
                                    state = ReturnVal and 8 or 9
                                end
                            else
                                if state == 7 then
                                    r5 = 2
                                    ReturnVal = r10 == r5
                                    state = ReturnVal and 10 or 11
                                end
                            end
                        else
                            if state <= 8 then
                                if state == 8 then
                                    state = 5
                                end
                            else
                                if state == 9 then
                                    r2 = 2
                                    r7 = r10 == r2
                                    r5 = state
                                    state = r7 and 12 or 13
                                    ReturnVal = r7
                                end
                            end
                        end
                    end
                else
                    if state <= 13 then
                        if state <= 11 then
                            if state <= 10 then
                                if state == 10 then
                                    r4 = nil
                                    r10 = nil
                                    state = 2
                                end
                            else
                                if state == 11 then
                                    ReturnVal = false
                                    state = 14
                                end
                            end
                        else
                            if state <= 12 then
                                if state == 12 then
                                    r2 = 3
                                    r7 = r4 == r2
                                    ReturnVal = r7
                                    state = 13
                                end
                            else
                                if state == 13 then
                                    state = r5
                                    state = ReturnVal and 15 or 16
                                end
                            end
                        end
                    else
                        if state <= 15 then
                            if state <= 14 then
                                if state == 14 then
                                    r5 = "print"
                                    ReturnVal = _env[r5]
                                    r7 = "nested-repeat"
                                    r5 = ReturnVal(r7, r10)
                                    state = 17
                                end
                            else
                                if state == 15 then
                                    state = 7
                                end
                            end
                        else
                            if state <= 16 then
                                if state == 16 then
                                    r5 = "print"
                                    ReturnVal = _env[r5]
                                    r7 = "nested-control"
                                    r5 = ReturnVal(r7, r10, r4)
                                    state = 5
                                end
                            else
                                if state == 17 then
                                    r10 = nil
                                    r4 = nil
                                    state = 2
                                end
                            end
                        end
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
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
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 84540
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 84540
                    end
                })
            end
        end
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)