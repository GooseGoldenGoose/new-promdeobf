return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalue, vm, createClosure, createUpvalueProxy, upvalueRefCounts, upvalueValues, releaseUpvalues, allocUpvalue, currentUpvalueId)
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
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, ReturnVal
            while state do
                -- root entry 6306426 -> 1, states 1-16
                if state <= 8 then
                    if state <= 4 then
                        if state <= 2 then
                            if state <= 1 then
                                if state == 1 then -- entry 6306426 -> 1
                                    ReturnVal = "print"
                                    state = _env[ReturnVal]
                                    r6 = "continue-start"
                                    ReturnVal = state(r6)
                                    state = 0
                                    r6 = state
                                    r3 = 5
                                    r4 = r3
                                    r3 = 1
                                    r9 = r3
                                    r3 = 0
                                    r8 = r9 < r3
                                    ReturnVal = 1
                                    r3 = ReturnVal - r9
                                    r1 = args
                                    state = 2
                                end
                            else
                                if state == 2 then
                                    r3 = r3 + r9
                                    ReturnVal = r3 <= r4
                                    r2 = not r8
                                    ReturnVal = r2 and ReturnVal
                                    r2 = r3 >= r4
                                    r2 = r8 and r2
                                    ReturnVal = r2 or ReturnVal
                                    r2 = 3
                                    state = ReturnVal and r2
                                    ReturnVal = 4
                                    state = state or ReturnVal
                                end
                            end
                        else
                            if state <= 3 then
                                if state == 3 then
                                    r2 = r3
                                    r7 = 2
                                    ReturnVal = r2 % r7
                                    r7 = 0
                                    state = ReturnVal == r7
                                    state = state and 5 or 6
                                end
                            else
                                if state == 4 then
                                    state = 0
                                    r3 = state
                                    state = 7
                                end
                            end
                        end
                    else
                        if state <= 6 then
                            if state <= 5 then
                                if state == 5 then
                                    r2 = nil
                                    state = 2
                                end
                            else
                                if state == 6 then
                                    state = r6 + r2
                                    r6 = state
                                    r7 = "print"
                                    ReturnVal = _env[r7]
                                    r5 = "continue-for"
                                    r7 = ReturnVal(r5, r2, r6)
                                    r2 = nil
                                    state = 2
                                end
                            end
                        else
                            if state <= 7 then
                                if state == 7 then
                                    ReturnVal = 5
                                    state = r3 < ReturnVal
                                    state = state and 8 or 9
                                end
                            else
                                if state == 8 then
                                    ReturnVal = 1
                                    state = r3 + ReturnVal
                                    r3 = state
                                    r4 = 2
                                    ReturnVal = r3 == r4
                                    state = ReturnVal and 10 or 11
                                end
                            end
                        end
                    end
                else
                    if state <= 12 then
                        if state <= 10 then
                            if state <= 9 then
                                if state == 9 then
                                    ReturnVal = 0
                                    r4 = ReturnVal
                                    r9 = 4
                                    ReturnVal = r4 >= r9
                                    state = 12
                                end
                            else
                                if state == 10 then
                                    state = 7
                                end
                            end
                        else
                            if state <= 11 then
                                if state == 11 then
                                    r4 = "print"
                                    ReturnVal = _env[r4]
                                    r9 = "continue-while"
                                    r4 = ReturnVal(r9, r3)
                                    state = 7
                                end
                            else
                                if state == 12 then
                                    r9 = 1
                                    ReturnVal = r4 + r9
                                    r4 = ReturnVal
                                    r8 = 2
                                    r9 = r4 == r8
                                    state = r9 and 13 or 14
                                end
                            end
                        end
                    else
                        if state <= 14 then
                            if state <= 13 then
                                if state == 13 then
                                    state = 15
                                end
                            else
                                if state == 14 then
                                    r8 = "print"
                                    r9 = _env[r8]
                                    r2 = "continue-repeat"
                                    r8 = r9(r2, r4)
                                    state = 15
                                end
                            end
                        else
                            if state <= 15 then
                                if state == 15 then
                                    r8 = 4
                                    r9 = r4 >= r8
                                    state = r9 and 16 or 12
                                end
                            else
                                if state == 16 then
                                    ReturnVal = {}
                                    r8 = "print"
                                    r9 = _env[r8]
                                    r2 = "continue-end"
                                    r8 = r9(r2, r6, r3, r4)
                                    r6 = nil
                                    r3 = nil
                                    r4 = nil
                                    state = nil
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
        upvalueRefCounts = {}
        upvalueValues = {}
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
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
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)