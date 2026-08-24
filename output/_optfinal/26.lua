return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalues, upvalueRefCounts, createClosure, allocUpvalue, currentUpvalueId, vm, releaseUpvalue, createUpvalueProxy, upvalueValues)
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, ReturnVal, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13
            while state do
                -- root entry 13346489 -> 1, states 1-16
                if state <= 8 then
                    if state <= 4 then
                        if state <= 2 then
                            if state <= 1 then
                                if state == 1 then -- entry 13346489 -> 1
                                    ReturnVal = "print"
                                    state = _env[ReturnVal]
                                    r7 = "start"
                                    ReturnVal = state(r7)
                                    r7 = 2
                                    r2 = r7
                                    r7 = 1
                                    r11 = r7
                                    r7 = 0
                                    r6 = r11 < r7
                                    ReturnVal = 1
                                    r7 = ReturnVal - r11
                                    r9 = args
                                    state = 2
                                end
                            else
                                if state == 2 then
                                    r7 = r7 + r11
                                    ReturnVal = r7 <= r2
                                    r8 = not r6
                                    ReturnVal = r8 and ReturnVal
                                    r8 = r7 >= r2
                                    r8 = r6 and r8
                                    ReturnVal = r8 or ReturnVal
                                    r8 = 3
                                    state = ReturnVal and r8
                                    ReturnVal = 4
                                    state = state or ReturnVal
                                end
                            end
                        else
                            if state <= 3 then
                                if state == 3 then
                                    r8 = r7
                                    ReturnVal = "print"
                                    state = _env[ReturnVal]
                                    r10 = "before-loop"
                                    ReturnVal = state(r10, r8)
                                    r8 = nil
                                    state = 2
                                end
                            else
                                if state == 4 then
                                    r7 = 3
                                    r2 = r7
                                    r7 = 1
                                    r11 = r7
                                    r7 = 0
                                    r6 = r11 < r7
                                    ReturnVal = 1
                                    r7 = ReturnVal - r11
                                    state = 5
                                end
                            end
                        end
                    else
                        if state <= 6 then
                            if state <= 5 then
                                if state == 5 then
                                    r8 = not r6
                                    r7 = r7 + r11
                                    ReturnVal = r7 <= r2
                                    ReturnVal = r8 and ReturnVal
                                    r8 = r7 >= r2
                                    r8 = r6 and r8
                                    ReturnVal = r8 or ReturnVal
                                    r8 = 6
                                    state = ReturnVal and r8
                                    ReturnVal = 7
                                    state = state or ReturnVal
                                end
                            else
                                if state == 6 then
                                    ReturnVal = "print"
                                    state = _env[ReturnVal]
                                    r8 = r7
                                    r10 = "outer"
                                    ReturnVal = state(r10, r8)
                                    r10 = 2
                                    r12 = r10
                                    r10 = 1
                                    r4 = r10
                                    r10 = 0
                                    r3 = r4 < r10
                                    ReturnVal = 1
                                    r10 = ReturnVal - r4
                                    state = 8
                                end
                            end
                        else
                            if state <= 7 then
                                if state == 7 then
                                    r7 = 1
                                    r2 = r7
                                    r7 = -1
                                    r11 = r7
                                    r7 = 0
                                    r6 = r11 < r7
                                    ReturnVal = 3
                                    r7 = ReturnVal - r11
                                    state = 9
                                end
                            else
                                if state == 8 then
                                    r10 = r10 + r4
                                    r13 = not r3
                                    ReturnVal = r10 <= r12
                                    ReturnVal = r13 and ReturnVal
                                    r13 = r10 >= r12
                                    r13 = r3 and r13
                                    ReturnVal = r13 or ReturnVal
                                    r13 = 10
                                    state = ReturnVal and r13
                                    ReturnVal = 11
                                    state = state or ReturnVal
                                end
                            end
                        end
                    end
                else
                    if state <= 12 then
                        if state <= 10 then
                            if state <= 9 then
                                if state == 9 then
                                    r8 = not r6
                                    r7 = r7 + r11
                                    ReturnVal = r7 <= r2
                                    ReturnVal = r8 and ReturnVal
                                    r8 = r7 >= r2
                                    r8 = r6 and r8
                                    ReturnVal = r8 or ReturnVal
                                    r8 = 12
                                    state = ReturnVal and r8
                                    ReturnVal = 13
                                    state = state or ReturnVal
                                end
                            else
                                if state == 10 then
                                    r13 = r10
                                    r1 = r8 + r13
                                    r5 = 2
                                    ReturnVal = r1 % r5
                                    r1 = 0
                                    state = ReturnVal == r1
                                    state = state and 14 or 15
                                end
                            end
                        else
                            if state <= 11 then
                                if state == 11 then
                                    ReturnVal = "print"
                                    state = _env[ReturnVal]
                                    r10 = "outer-end"
                                    ReturnVal = state(r10, r8)
                                    r8 = nil
                                    state = 5
                                end
                            else
                                if state == 12 then
                                    r8 = r7
                                    ReturnVal = "print"
                                    state = _env[ReturnVal]
                                    r10 = "after-loop"
                                    ReturnVal = state(r10, r8)
                                    r8 = nil
                                    state = 9
                                end
                            end
                        end
                    else
                        if state <= 14 then
                            if state <= 13 then
                                if state == 13 then
                                    ReturnVal = "print"
                                    state = _env[ReturnVal]
                                    r7 = "done"
                                    ReturnVal = state(r7)
                                    ReturnVal = {}
                                    state = nil
                                end
                            else
                                if state == 14 then
                                    ReturnVal = "print"
                                    state = _env[ReturnVal]
                                    r1 = "inner-even"
                                    ReturnVal = state(r1, r8, r13)
                                    state = 16
                                end
                            end
                        else
                            if state <= 15 then
                                if state == 15 then
                                    ReturnVal = "print"
                                    state = _env[ReturnVal]
                                    r1 = "inner-odd"
                                    ReturnVal = state(r1, r8, r13)
                                    state = 16
                                end
                            else
                                if state == 16 then
                                    r13 = nil
                                    state = 8
                                end
                            end
                        end
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
        currentUpvalueId = 0
        upvalueRefCounts = {}
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 468453
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 468453
                    end
                })
            end
        end
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