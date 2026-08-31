return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createUpvalueProxy, createClosure, releaseUpvalues, currentUpvalueId, upvalueRefCounts, upvalueValues, vm, releaseUpvalue, allocUpvalue)
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, ReturnVal, r8, r9
            while state do
                -- root entry 15698122 -> 1, states 1-11
                if state <= 6 then
                    if state <= 3 then
                        if state <= 2 then
                            if state <= 1 then
                                if state == 1 then -- entry 15698122 -> 1
                                    ReturnVal = "print"
                                    state = _env[ReturnVal]
                                    r1 = "s43-start"
                                    ReturnVal = state(r1)
                                    r1 = 3
                                    r8 = r1
                                    r1 = 1
                                    r7 = r1
                                    r1 = 0
                                    r6 = r7 < r1
                                    ReturnVal = 1
                                    r1 = ReturnVal - r7
                                    r3 = args
                                    state = 2
                                end
                            else
                                if state == 2 then
                                    r4 = not r6
                                    r1 = r1 + r7
                                    ReturnVal = r1 <= r8
                                    ReturnVal = r4 and ReturnVal
                                    r4 = r1 >= r8
                                    r4 = r6 and r4
                                    ReturnVal = r4 or ReturnVal
                                    r4 = 3
                                    state = ReturnVal and r4
                                    ReturnVal = 4
                                    state = state or ReturnVal
                                end
                            end
                        else
                            if state == 3 then
                                state = 0
                                r2 = state
                                r4 = r1
                                state = 5
                            end
                        end
                    else
                        if state <= 5 then
                            if state <= 4 then
                                if state == 4 then
                                    ReturnVal = "print"
                                    state = _env[ReturnVal]
                                    r1 = "s43-end"
                                    ReturnVal = state(r1)
                                    ReturnVal = {}
                                    state = nil
                                end
                            else
                                if state == 5 then
                                    state = true
                                    state = state and 6 or 7
                                end
                            end
                        else
                            if state == 6 then
                                ReturnVal = 1
                                state = r2 + ReturnVal
                                r2 = state
                                r9 = 2
                                ReturnVal = r2 == r9
                                state = ReturnVal and 8 or 9
                            end
                        end
                    end
                else
                    if state <= 9 then
                        if state <= 8 then
                            if state <= 7 then
                                if state == 7 then
                                    r9 = 2
                                    ReturnVal = r4 == r9
                                    state = ReturnVal and 10 or 11
                                end
                            else
                                if state == 8 then
                                    state = 7
                                end
                            end
                        else
                            if state == 9 then
                                r9 = "print"
                                ReturnVal = _env[r9]
                                r5 = "s43-inner"
                                r9 = ReturnVal(r5, r4, r2)
                                state = 5
                            end
                        end
                    else
                        if state <= 10 then
                            if state == 10 then
                                r2 = nil
                                r4 = nil
                                state = 2
                            end
                        else
                            if state == 11 then
                                r9 = "print"
                                ReturnVal = _env[r9]
                                r5 = "s43-outer"
                                r9 = ReturnVal(r5, r4, r2)
                                r4 = nil
                                r2 = nil
                                state = 2
                            end
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
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
        currentUpvalueId = 0
        upvalueValues = {}
        upvalueRefCounts = {}
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)