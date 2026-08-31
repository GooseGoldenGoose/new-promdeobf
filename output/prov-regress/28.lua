return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createUpvalueProxy, releaseUpvalues, releaseUpvalue, createClosure, createClosure5, upvalueRefCounts, allocUpvalue, upvalueValues, currentUpvalueId, vm)
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -350880
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -350880
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
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        upvalueValues = {}
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, ReturnVal, r5, r6, r7, r8, r9, r10, r11
            while state do
                if state <= 22 then
                    -- root entry 1465295 -> 1, states 1-22
                    if state <= 11 then
                        if state <= 6 then
                            if state <= 3 then
                                if state <= 2 then
                                    if state <= 1 then
                                        if state == 1 then -- entry 1465295 -> 1
                                            ReturnVal = "print"
                                            state = _env[ReturnVal]
                                            r4 = "start"
                                            ReturnVal = state(r4)
                                            state = 1
                                            r4 = state
                                            r7 = args
                                            state = 2
                                        end
                                    else
                                        if state == 2 then
                                            ReturnVal = 2
                                            state = r4 <= ReturnVal
                                            state = state and 3 or 4
                                        end
                                    end
                                else
                                    if state == 3 then
                                        ReturnVal = "print"
                                        state = _env[ReturnVal]
                                        r3 = "while"
                                        ReturnVal = state(r3, r4)
                                        ReturnVal = 10
                                        state = r4 * ReturnVal
                                        r3 = state
                                        r11 = 2
                                        ReturnVal = r4 % r11
                                        r11 = 0
                                        state = ReturnVal == r11
                                        state = state and 5 or 6
                                    end
                                end
                            else
                                if state <= 5 then
                                    if state <= 4 then
                                        if state == 4 then
                                            r3 = 2
                                            r11 = r3
                                            r3 = 1
                                            r9 = r3
                                            r3 = 0
                                            r5 = r9 < r3
                                            ReturnVal = 1
                                            r3 = ReturnVal - r9
                                            state = 7
                                        end
                                    else
                                        if state == 5 then
                                            ReturnVal = "print"
                                            state = _env[ReturnVal]
                                            r11 = "while-even"
                                            ReturnVal = state(r11, r3)
                                            state = 8
                                        end
                                    end
                                else
                                    if state == 6 then
                                        ReturnVal = "print"
                                        state = _env[ReturnVal]
                                        r11 = "while-odd"
                                        ReturnVal = state(r11, r3)
                                        state = 8
                                    end
                                end
                            end
                        else
                            if state <= 9 then
                                if state <= 8 then
                                    if state <= 7 then
                                        if state == 7 then
                                            r3 = r3 + r9
                                            r2 = not r5
                                            ReturnVal = r3 <= r11
                                            ReturnVal = r2 and ReturnVal
                                            r2 = r3 >= r11
                                            r2 = r5 and r2
                                            ReturnVal = r2 or ReturnVal
                                            r2 = 9
                                            state = ReturnVal and r2
                                            ReturnVal = 10
                                            state = state or ReturnVal
                                        end
                                    else
                                        if state == 8 then
                                            r3 = nil
                                            r3 = 2
                                            r11 = r3
                                            r3 = 1
                                            r9 = r3
                                            r3 = 0
                                            r5 = r9 < r3
                                            ReturnVal = 1
                                            r3 = ReturnVal - r9
                                            state = 11
                                        end
                                    end
                                else
                                    if state == 9 then
                                        r2 = r3
                                        r8 = "print"
                                        ReturnVal = _env[r8]
                                        r10 = "outer-for"
                                        r8 = ReturnVal(r10, r2)
                                        ReturnVal = 1
                                        r8 = ReturnVal
                                        state = 12
                                    end
                                end
                            else
                                if state <= 10 then
                                    if state == 10 then
                                        r3 = createClosure5(23, {})
                                        r9 = "print"
                                        r11 = _env[r9]
                                        r8 = 5
                                        r2 = {
                                            r3(r8)
                                        }
                                        r5 = "helper"
                                        r9 = r11(r5, unpack(r2))
                                        r9 = "print"
                                        r11 = _env[r9]
                                        ReturnVal = {}
                                        r5 = "done"
                                        r9 = r11(r5)
                                        r4 = nil
                                        r3 = nil
                                        state = nil
                                    end
                                else
                                    if state == 11 then
                                        r2 = not r5
                                        r3 = r3 + r9
                                        ReturnVal = r3 <= r11
                                        ReturnVal = r2 and ReturnVal
                                        r2 = r3 >= r11
                                        r2 = r5 and r2
                                        ReturnVal = r2 or ReturnVal
                                        r2 = 13
                                        state = ReturnVal and r2
                                        ReturnVal = 14
                                        state = state or ReturnVal
                                    end
                                end
                            end
                        end
                    else
                        if state <= 17 then
                            if state <= 14 then
                                if state <= 13 then
                                    if state <= 12 then
                                        if state == 12 then
                                            r10 = 2
                                            ReturnVal = r8 <= r10
                                            state = ReturnVal and 15 or 16
                                        end
                                    else
                                        if state == 13 then
                                            r2 = r3
                                            ReturnVal = "print"
                                            state = _env[ReturnVal]
                                            r8 = "for-in-while"
                                            ReturnVal = state(r8, r4, r2)
                                            ReturnVal = 1
                                            state = r2 == ReturnVal
                                            state = state and 17 or 18
                                        end
                                    end
                                else
                                    if state == 14 then
                                        ReturnVal = 1
                                        state = r4 + ReturnVal
                                        r4 = state
                                        state = 2
                                    end
                                end
                            else
                                if state <= 16 then
                                    if state <= 15 then
                                        if state == 15 then
                                            r10 = "print"
                                            ReturnVal = _env[r10]
                                            r1 = "while-in-for"
                                            r10 = ReturnVal(r1, r2, r8)
                                            r1 = r2 + r8
                                            r6 = 2
                                            r10 = r1 % r6
                                            r1 = 0
                                            ReturnVal = r10 == r1
                                            state = ReturnVal and 19 or 20
                                        end
                                    else
                                        if state == 16 then
                                            r2 = nil
                                            r8 = nil
                                            state = 7
                                        end
                                    end
                                else
                                    if state == 17 then
                                        state = r4 + r2
                                        r8 = state
                                        ReturnVal = "print"
                                        state = _env[ReturnVal]
                                        r10 = "for-a"
                                        ReturnVal = state(r10, r8)
                                        r8 = nil
                                        state = 21
                                    end
                                end
                            end
                        else
                            if state <= 20 then
                                if state <= 19 then
                                    if state <= 18 then
                                        if state == 18 then
                                            state = r4 * r2
                                            r8 = state
                                            ReturnVal = "print"
                                            state = _env[ReturnVal]
                                            r10 = "for-b"
                                            ReturnVal = state(r10, r8)
                                            r8 = nil
                                            state = 21
                                        end
                                    else
                                        if state == 19 then
                                            r10 = "print"
                                            ReturnVal = _env[r10]
                                            r1 = "nested-even"
                                            r10 = ReturnVal(r1, r2, r8)
                                            state = 22
                                        end
                                    end
                                else
                                    if state == 20 then
                                        r10 = "print"
                                        ReturnVal = _env[r10]
                                        r1 = "nested-odd"
                                        r10 = ReturnVal(r1, r2, r8)
                                        state = 22
                                    end
                                end
                            else
                                if state <= 21 then
                                    if state == 21 then
                                        r2 = nil
                                        state = 11
                                    end
                                else
                                    if state == 22 then
                                        r10 = 1
                                        ReturnVal = r8 + r10
                                        r8 = ReturnVal
                                        state = 12
                                    end
                                end
                            end
                        end
                    end
                else
                    -- createClosure5 entry 11639357 -> 23, states 23-32
                    if state <= 27 then
                        if state <= 25 then
                            if state <= 24 then
                                if state <= 23 then
                                    if state == 23 then -- entry 11639357 -> 23
                                        r7 = args[1]
                                        state = 1
                                        r4 = state
                                        state = 24
                                    end
                                else
                                    if state == 24 then
                                        ReturnVal = 2
                                        state = r4 <= ReturnVal
                                        state = state and 25 or 26
                                    end
                                end
                            else
                                if state == 25 then
                                    r3 = 2
                                    r11 = r3
                                    r3 = 1
                                    r9 = r3
                                    r3 = 0
                                    r5 = r9 < r3
                                    ReturnVal = 1
                                    r3 = ReturnVal - r9
                                    state = 27
                                end
                            end
                        else
                            if state <= 26 then
                                if state == 26 then
                                    r3 = 10
                                    ReturnVal = r7 + r3
                                    ReturnVal = {
                                        ReturnVal
                                    }
                                    state = nil
                                end
                            else
                                if state == 27 then
                                    r2 = not r5
                                    r3 = r3 + r9
                                    ReturnVal = r3 <= r11
                                    ReturnVal = r2 and ReturnVal
                                    r2 = r3 >= r11
                                    r2 = r5 and r2
                                    ReturnVal = r2 or ReturnVal
                                    r2 = 28
                                    state = ReturnVal and r2
                                    ReturnVal = 29
                                    state = state or ReturnVal
                                end
                            end
                        end
                    else
                        if state <= 30 then
                            if state <= 29 then
                                if state <= 28 then
                                    if state == 28 then
                                        r2 = r3
                                        ReturnVal = 1
                                        state = r2 == ReturnVal
                                        state = state and 30 or 31
                                    end
                                else
                                    if state == 29 then
                                        ReturnVal = 1
                                        state = r4 + ReturnVal
                                        r4 = state
                                        state = 24
                                    end
                                end
                            else
                                if state == 30 then
                                    ReturnVal = "print"
                                    state = _env[ReturnVal]
                                    r8 = "helper-a"
                                    ReturnVal = state(r8, r7, r4, r2)
                                    state = 32
                                end
                            end
                        else
                            if state <= 31 then
                                if state == 31 then
                                    ReturnVal = "print"
                                    state = _env[ReturnVal]
                                    r8 = "helper-b"
                                    ReturnVal = state(r8, r7, r4, r2)
                                    state = 32
                                end
                            else
                                if state == 32 then
                                    r2 = nil
                                    state = 27
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
        upvalueRefCounts = {}
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
        currentUpvalueId = 0
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)