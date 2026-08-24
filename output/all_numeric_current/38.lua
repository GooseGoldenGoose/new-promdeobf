return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalue, releaseUpvalues, createUpvalueProxy, upvalueRefCounts, currentUpvalueId, vm, createClosure, upvalueValues, allocUpvalue)
        currentUpvalueId = 0
        upvalueRefCounts = {}
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        upvalueValues = {}
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
        createClosure = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(...)
                return vm(entryId, {
                    ...
                }, captures, gcProxy)
            end
            return closure
        end
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, ReturnVal, r5, r6, r7, r8, r9
            while state do
                -- root entry 6306426 -> 1, states 1-33
                if state <= 17 then
                    if state <= 9 then
                        if state <= 5 then
                            if state <= 3 then
                                if state <= 2 then
                                    if state <= 1 then
                                        if state == 1 then -- entry 6306426 -> 1
                                            ReturnVal = "print"
                                            state = _env[ReturnVal]
                                            r3 = "branch-heavy-start"
                                            ReturnVal = state(r3)
                                            state = 0
                                            r3 = state
                                            r5 = args
                                            state = 2
                                        end
                                    else
                                        if state == 2 then
                                            ReturnVal = 4
                                            state = r3 < ReturnVal
                                            state = state and 3 or 4
                                        end
                                    end
                                else
                                    if state == 3 then
                                        ReturnVal = 1
                                        state = r3 + ReturnVal
                                        r3 = state
                                        r1 = 2
                                        r8 = r3 % r1
                                        r1 = 0
                                        ReturnVal = r8 == r1
                                        state = ReturnVal and 5 or 6
                                    end
                                end
                            else
                                if state <= 4 then
                                    if state == 4 then
                                        r8 = 4
                                        r1 = r8
                                        r8 = 1
                                        r2 = r8
                                        r8 = 0
                                        r7 = r2 < r8
                                        ReturnVal = 1
                                        r8 = ReturnVal - r2
                                        state = 7
                                    end
                                else
                                    if state == 5 then
                                        r8 = 2
                                        ReturnVal = r3 == r8
                                        state = ReturnVal and 8 or 9
                                    end
                                end
                            end
                        else
                            if state <= 7 then
                                if state <= 6 then
                                    if state == 6 then
                                        r8 = 1
                                        ReturnVal = r3 == r8
                                        state = ReturnVal and 10 or 11
                                    end
                                else
                                    if state == 7 then
                                        r4 = not r7
                                        r8 = r8 + r2
                                        ReturnVal = r8 <= r1
                                        ReturnVal = r4 and ReturnVal
                                        r4 = r8 >= r1
                                        r4 = r7 and r4
                                        ReturnVal = r4 or ReturnVal
                                        r4 = 12
                                        state = ReturnVal and r4
                                        ReturnVal = 13
                                        state = state or ReturnVal
                                    end
                                end
                            else
                                if state <= 8 then
                                    if state == 8 then
                                        r8 = "print"
                                        ReturnVal = _env[r8]
                                        r1 = "while-a"
                                        r8 = ReturnVal(r1, r3)
                                        state = 14
                                    end
                                else
                                    if state == 9 then
                                        r8 = "print"
                                        ReturnVal = _env[r8]
                                        r1 = "while-b"
                                        r8 = ReturnVal(r1, r3)
                                        state = 14
                                    end
                                end
                            end
                        end
                    else
                        if state <= 13 then
                            if state <= 11 then
                                if state <= 10 then
                                    if state == 10 then
                                        r8 = "print"
                                        ReturnVal = _env[r8]
                                        r1 = "while-c"
                                        r8 = ReturnVal(r1, r3)
                                        state = 15
                                    end
                                else
                                    if state == 11 then
                                        r8 = "print"
                                        ReturnVal = _env[r8]
                                        r1 = "while-d"
                                        r8 = ReturnVal(r1, r3)
                                        state = 15
                                    end
                                end
                            else
                                if state <= 12 then
                                    if state == 12 then
                                        r4 = r8
                                        r9 = 2
                                        ReturnVal = r4 <= r9
                                        state = ReturnVal and 16 or 17
                                    end
                                else
                                    if state == 13 then
                                        ReturnVal = 0
                                        r8 = ReturnVal
                                        r1 = 3
                                        ReturnVal = r8 >= r1
                                        state = 18
                                    end
                                end
                            end
                        else
                            if state <= 15 then
                                if state <= 14 then
                                    if state == 14 then
                                        state = 19
                                    end
                                else
                                    if state == 15 then
                                        state = 19
                                    end
                                end
                            else
                                if state <= 16 then
                                    if state == 16 then
                                        r9 = 1
                                        ReturnVal = r4 == r9
                                        state = ReturnVal and 20 or 21
                                    end
                                else
                                    if state == 17 then
                                        r9 = 3
                                        ReturnVal = r4 == r9
                                        state = ReturnVal and 22 or 23
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 25 then
                        if state <= 21 then
                            if state <= 19 then
                                if state <= 18 then
                                    if state == 18 then
                                        r1 = 1
                                        ReturnVal = r8 + r1
                                        r8 = ReturnVal
                                        r2 = 1
                                        r1 = r8 == r2
                                        state = r1 and 24 or 25
                                    end
                                else
                                    if state == 19 then
                                        r8 = "print"
                                        ReturnVal = _env[r8]
                                        r1 = "while-tail"
                                        r8 = ReturnVal(r1, r3)
                                        state = 2
                                    end
                                end
                            else
                                if state <= 20 then
                                    if state == 20 then
                                        r9 = "print"
                                        ReturnVal = _env[r9]
                                        r6 = "for-a"
                                        r9 = ReturnVal(r6, r4)
                                        state = 26
                                    end
                                else
                                    if state == 21 then
                                        r9 = "print"
                                        ReturnVal = _env[r9]
                                        r6 = "for-b"
                                        r9 = ReturnVal(r6, r4)
                                        state = 26
                                    end
                                end
                            end
                        else
                            if state <= 23 then
                                if state <= 22 then
                                    if state == 22 then
                                        r9 = "print"
                                        ReturnVal = _env[r9]
                                        r6 = "for-c"
                                        r9 = ReturnVal(r6, r4)
                                        state = 27
                                    end
                                else
                                    if state == 23 then
                                        r9 = "print"
                                        ReturnVal = _env[r9]
                                        r6 = "for-d"
                                        r9 = ReturnVal(r6, r4)
                                        state = 27
                                    end
                                end
                            else
                                if state <= 24 then
                                    if state == 24 then
                                        r2 = "print"
                                        r1 = _env[r2]
                                        r7 = "repeat-a"
                                        r2 = r1(r7, r8)
                                        state = 28
                                    end
                                else
                                    if state == 25 then
                                        r2 = 2
                                        r1 = r8 == r2
                                        state = r1 and 29 or 30
                                    end
                                end
                            end
                        end
                    else
                        if state <= 29 then
                            if state <= 27 then
                                if state <= 26 then
                                    if state == 26 then
                                        state = 31
                                    end
                                else
                                    if state == 27 then
                                        state = 31
                                    end
                                end
                            else
                                if state <= 28 then
                                    if state == 28 then
                                        r2 = "print"
                                        r1 = _env[r2]
                                        r7 = "repeat-tail"
                                        r2 = r1(r7, r8)
                                        state = 32
                                    end
                                else
                                    if state == 29 then
                                        r2 = "print"
                                        r1 = _env[r2]
                                        r7 = "repeat-b"
                                        r2 = r1(r7, r8)
                                        state = 28
                                    end
                                end
                            end
                        else
                            if state <= 31 then
                                if state <= 30 then
                                    if state == 30 then
                                        r2 = "print"
                                        r1 = _env[r2]
                                        r7 = "repeat-c"
                                        r2 = r1(r7, r8)
                                        state = 28
                                    end
                                else
                                    if state == 31 then
                                        r9 = "print"
                                        ReturnVal = _env[r9]
                                        r6 = "for-tail"
                                        r9 = ReturnVal(r6, r4)
                                        r4 = nil
                                        state = 7
                                    end
                                end
                            else
                                if state <= 32 then
                                    if state == 32 then
                                        r2 = 3
                                        r1 = r8 >= r2
                                        state = r1 and 33 or 18
                                    end
                                else
                                    if state == 33 then
                                        ReturnVal = {}
                                        r2 = "print"
                                        r1 = _env[r2]
                                        r7 = "branch-heavy-end"
                                        r2 = r1(r7)
                                        r3 = nil
                                        r8 = nil
                                        state = nil
                                    end
                                end
                            end
                        end
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)