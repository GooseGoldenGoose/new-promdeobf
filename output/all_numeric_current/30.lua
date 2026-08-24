return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalues, createClosure, createUpvalueProxy, createClosure3, allocUpvalue, releaseUpvalue, vm, upvalueValues, createClosure6, currentUpvalueId, upvalueRefCounts)
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
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
        currentUpvalueId = 0
        upvalueValues = {}
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, ReturnVal, r9, r10, r11, r12, r13, r14
            while state do
                if state <= 32 then
                    if state <= 31 then
                        -- root entry 12788302 -> 1, states 1-31
                        if state <= 16 then
                            if state <= 8 then
                                if state <= 4 then
                                    if state <= 2 then
                                        if state <= 1 then
                                            if state == 1 then -- entry 12788302 -> 1
                                                ReturnVal = "print"
                                                state = _env[ReturnVal]
                                                r2 = "mixed-repeat-start"
                                                ReturnVal = state(r2)
                                                state = 0
                                                r2 = state
                                                ReturnVal = 2
                                                state = r2 >= ReturnVal
                                                r13 = args
                                                state = 2
                                            end
                                        else
                                            if state == 2 then
                                                ReturnVal = 1
                                                state = r2 + ReturnVal
                                                r2 = state
                                                r14 = "print"
                                                ReturnVal = _env[r14]
                                                r5 = "outer-repeat"
                                                r14 = ReturnVal(r5, r2)
                                                r14 = 2
                                                r5 = r14
                                                r14 = 1
                                                r10 = r14
                                                r14 = 0
                                                r1 = r10 < r14
                                                ReturnVal = 1
                                                r14 = ReturnVal - r10
                                                state = 3
                                            end
                                        end
                                    else
                                        if state <= 3 then
                                            if state == 3 then
                                                r14 = r14 + r10
                                                r3 = not r1
                                                ReturnVal = r14 <= r5
                                                ReturnVal = r3 and ReturnVal
                                                r3 = r14 >= r5
                                                r3 = r1 and r3
                                                ReturnVal = r3 or ReturnVal
                                                r3 = 4
                                                state = ReturnVal and r3
                                                ReturnVal = 5
                                                state = state or ReturnVal
                                            end
                                        else
                                            if state == 4 then
                                                r3 = r14
                                                r4 = 1
                                                ReturnVal = r3 == r4
                                                state = ReturnVal and 6 or 7
                                            end
                                        end
                                    end
                                else
                                    if state <= 6 then
                                        if state <= 5 then
                                            if state == 5 then
                                                ReturnVal = 0
                                                r14 = ReturnVal
                                                state = 8
                                            end
                                        else
                                            if state == 6 then
                                                r4 = "print"
                                                ReturnVal = _env[r4]
                                                r9 = "for-in-repeat-a"
                                                r4 = ReturnVal(r9, r2, r3)
                                                state = 9
                                            end
                                        end
                                    else
                                        if state <= 7 then
                                            if state == 7 then
                                                r4 = "print"
                                                ReturnVal = _env[r4]
                                                r9 = "for-in-repeat-b"
                                                r4 = ReturnVal(r9, r2, r3)
                                                state = 9
                                            end
                                        else
                                            if state == 8 then
                                                r5 = 2
                                                ReturnVal = r14 < r5
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
                                                r3 = nil
                                                state = 3
                                            end
                                        else
                                            if state == 10 then
                                                r5 = 1
                                                ReturnVal = r14 + r5
                                                r14 = ReturnVal
                                                r10 = "print"
                                                r5 = _env[r10]
                                                r1 = "while-in-repeat"
                                                r10 = r5(r1, r2, r14)
                                                state = 8
                                            end
                                        end
                                    else
                                        if state <= 11 then
                                            if state == 11 then
                                                r14 = nil
                                                state = 12
                                            end
                                        else
                                            if state == 12 then
                                                r5 = 2
                                                r14 = r2 >= r5
                                                state = r14 and 13 or 2
                                            end
                                        end
                                    end
                                else
                                    if state <= 14 then
                                        if state <= 13 then
                                            if state == 13 then
                                                r5 = 2
                                                r10 = r5
                                                r5 = 1
                                                r1 = r5
                                                r5 = 0
                                                r3 = r1 < r5
                                                r14 = 1
                                                r5 = r14 - r1
                                                state = 14
                                            end
                                        else
                                            if state == 14 then
                                                r4 = not r3
                                                r5 = r5 + r1
                                                r14 = r5 <= r10
                                                r14 = r4 and r14
                                                r4 = r5 >= r10
                                                r4 = r3 and r4
                                                r14 = r4 or r14
                                                r4 = 15
                                                state = r14 and r4
                                                r14 = 16
                                                state = state or r14
                                            end
                                        end
                                    else
                                        if state <= 15 then
                                            if state == 15 then
                                                r4 = 0
                                                r6 = 2
                                                r9 = r4 >= r6
                                                r14 = r5
                                                state = 17
                                            end
                                        else
                                            if state == 16 then
                                                r14 = 0
                                                state = 18
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 24 then
                                if state <= 20 then
                                    if state <= 18 then
                                        if state <= 17 then
                                            if state == 17 then
                                                r6 = 1
                                                r9 = r4 + r6
                                                r4 = r9
                                                r7 = "print"
                                                r6 = _env[r7]
                                                r8 = "repeat-in-for"
                                                r7 = r6(r8, r14, r4)
                                                state = 19
                                            end
                                        else
                                            if state == 18 then
                                                r10 = 2
                                                r5 = r14 < r10
                                                state = r5 and 20 or 21
                                            end
                                        end
                                    else
                                        if state <= 19 then
                                            if state == 19 then
                                                r7 = 2
                                                r6 = r4 >= r7
                                                state = r6 and 22 or 17
                                            end
                                        else
                                            if state == 20 then
                                                r10 = 1
                                                r5 = r14 + r10
                                                r10 = 0
                                                r3 = 2
                                                r1 = r10 >= r3
                                                r14 = r5
                                                state = 23
                                            end
                                        end
                                    end
                                else
                                    if state <= 22 then
                                        if state <= 21 then
                                            if state == 21 then
                                                r10 = 0
                                                r3 = "_REPEAT_CHECKS"
                                                _env[r3] = r10
                                                r3 = createClosure6(32, {})
                                                r6 = 2
                                                r4 = r3(r6)
                                                state = 24
                                            end
                                        else
                                            if state == 22 then
                                                r4 = nil
                                                r14 = nil
                                                state = 14
                                            end
                                        end
                                    else
                                        if state <= 23 then
                                            if state == 23 then
                                                r3 = 1
                                                r1 = r10 + r3
                                                r10 = r1
                                                r4 = 1
                                                r3 = r10 == r4
                                                state = r3 and 25 or 26
                                            end
                                        else
                                            if state == 24 then
                                                r6 = "print"
                                                r4 = _env[r6]
                                                r12 = "_REPEAT_CHECKS"
                                                r8 = _env[r12]
                                                r7 = "side-effect-repeat"
                                                r6 = r4(r7, r8)
                                                state = 27
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 28 then
                                    if state <= 26 then
                                        if state <= 25 then
                                            if state == 25 then
                                                r4 = "print"
                                                r3 = _env[r4]
                                                r6 = "repeat-in-while-a"
                                                r4 = r3(r6, r14, r10)
                                                state = 28
                                            end
                                        else
                                            if state == 26 then
                                                r4 = "print"
                                                r3 = _env[r4]
                                                r6 = "repeat-in-while-b"
                                                r4 = r3(r6, r14, r10)
                                                state = 28
                                            end
                                        end
                                    else
                                        if state <= 27 then
                                            if state == 27 then
                                                r6 = 2
                                                r4 = r3(r6)
                                                state = r4 and 29 or 24
                                            end
                                        else
                                            if state == 28 then
                                                state = 30
                                            end
                                        end
                                    end
                                else
                                    if state <= 30 then
                                        if state <= 29 then
                                            if state == 29 then
                                                r6 = "print"
                                                r4 = _env[r6]
                                                r12 = "_REPEAT_CHECKS"
                                                r8 = _env[r12]
                                                r7 = "side-effect-checks"
                                                r6 = r4(r7, r8)
                                                r7 = "print"
                                                r6 = _env[r7]
                                                r4 = createClosure3(33, {})
                                                r11 = 2
                                                r12 = {
                                                    r4(r11)
                                                }
                                                r8 = "helper-result"
                                                r7 = r6(r8, unpack(r12))
                                                r7 = "print"
                                                r6 = _env[r7]
                                                r8 = "mixed-repeat-end"
                                                r7 = r6(r8)
                                                r14 = nil
                                                r2 = nil
                                                r3 = nil
                                                r4 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        else
                                            if state == 30 then
                                                r4 = 2
                                                r3 = r10 >= r4
                                                state = r3 and 31 or 23
                                            end
                                        end
                                    else
                                        if state == 31 then
                                            r10 = nil
                                            state = 18
                                        end
                                    end
                                end
                            end
                        end
                    else
                        -- createClosure6 entry 9501593 -> 32, states 32-32
                        if state == 32 then -- entry 9501593 -> 32
                            r13 = args[1]
                            r2 = "_REPEAT_CHECKS"
                            ReturnVal = _env[r2]
                            r2 = 1
                            state = ReturnVal + r2
                            ReturnVal = "_REPEAT_CHECKS"
                            _env[ReturnVal] = state
                            r14 = "_REPEAT_CHECKS"
                            r2 = _env[r14]
                            ReturnVal = r2 >= r13
                            ReturnVal = {
                                ReturnVal
                            }
                            state = nil
                        end
                    end
                else
                    -- createClosure3 entry 3085751 -> 33, states 33-42
                    if state <= 37 then
                        if state <= 35 then
                            if state <= 34 then
                                if state <= 33 then
                                    if state == 33 then -- entry 3085751 -> 33
                                        r13 = args[1]
                                        state = 0
                                        r2 = state
                                        state = r2 >= r13
                                        state = 34
                                    end
                                else
                                    if state == 34 then
                                        ReturnVal = 1
                                        state = r2 + ReturnVal
                                        r2 = state
                                        r14 = 2
                                        r5 = r14
                                        r14 = 1
                                        r10 = r14
                                        r14 = 0
                                        r1 = r10 < r14
                                        ReturnVal = 1
                                        r14 = ReturnVal - r10
                                        state = 35
                                    end
                                end
                            else
                                if state == 35 then
                                    r3 = not r1
                                    r14 = r14 + r10
                                    ReturnVal = r14 <= r5
                                    ReturnVal = r3 and ReturnVal
                                    r3 = r14 >= r5
                                    r3 = r1 and r3
                                    ReturnVal = r3 or ReturnVal
                                    r3 = 36
                                    state = ReturnVal and r3
                                    ReturnVal = 37
                                    state = state or ReturnVal
                                end
                            end
                        else
                            if state <= 36 then
                                if state == 36 then
                                    r3 = r14
                                    r9 = r2 + r3
                                    r6 = 2
                                    r4 = r9 % r6
                                    r9 = 0
                                    ReturnVal = r4 == r9
                                    state = ReturnVal and 38 or 39
                                end
                            else
                                if state == 37 then
                                    state = 40
                                end
                            end
                        end
                    else
                        if state <= 40 then
                            if state <= 39 then
                                if state <= 38 then
                                    if state == 38 then
                                        r4 = "print"
                                        ReturnVal = _env[r4]
                                        r9 = "helper-even"
                                        r4 = ReturnVal(r9, r2, r3)
                                        state = 41
                                    end
                                else
                                    if state == 39 then
                                        r4 = "print"
                                        ReturnVal = _env[r4]
                                        r9 = "helper-odd"
                                        r4 = ReturnVal(r9, r2, r3)
                                        state = 41
                                    end
                                end
                            else
                                if state == 40 then
                                    ReturnVal = r2 >= r13
                                    state = ReturnVal and 42 or 34
                                end
                            end
                        else
                            if state <= 41 then
                                if state == 41 then
                                    r3 = nil
                                    state = 35
                                end
                            else
                                if state == 42 then
                                    ReturnVal = {
                                        r2
                                    }
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
        createClosure6 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1, arg2, arg3, arg4, arg5, arg6)
                return vm(entryId, {
                    arg1,
                    arg2,
                    arg3,
                    arg4,
                    arg5,
                    arg6
                }, captures, gcProxy)
            end
            return closure
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
                    return 3378672
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 3378672
                    end
                })
            end
        end
        upvalueRefCounts = {}
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)