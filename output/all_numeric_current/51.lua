return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, vm, allocUpvalue, currentUpvalueId, upvalueValues, createClosure5, createClosure4, createUpvalueProxy, createClosure0, createClosure2, releaseUpvalues, upvalueRefCounts, releaseUpvalue, createClosure)
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
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
            end
            return closure
        end
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        upvalueValues = {}
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -3753286
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -3753286
                    end
                })
            end
        end
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, ReturnVal, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33
            while state do
                if state <= 28 then
                    if state <= 26 then
                        if state <= 25 then
                            -- root entry 9990744 -> 1, states 1-25
                            if state <= 13 then
                                if state <= 7 then
                                    if state <= 4 then
                                        if state <= 2 then
                                            if state <= 1 then
                                                if state == 1 then -- entry 9990744 -> 1
                                                    state = true
                                                    r7 = allocUpvalue()
                                                    upvalueValues[r7] = state
                                                    r10 = "string"
                                                    ReturnVal = _env[r10]
                                                    r10 = "gmatch"
                                                    state = ReturnVal[r10]
                                                    r10 = allocUpvalue()
                                                    r12 = allocUpvalue()
                                                    upvalueValues[r10] = state
                                                    r24 = allocUpvalue()
                                                    state = createClosure4(26, {})
                                                    r17 = createClosure2(27, {
                                                        r24
                                                    })
                                                    upvalueValues[r12] = state
                                                    state = false
                                                    upvalueValues[r24] = state
                                                    r6 = "pcall"
                                                    r1 = _env[r6]
                                                    r6 = r1(r17)
                                                    state = r6 and 2 or 3
                                                    r32 = args
                                                    ReturnVal = r6
                                                end
                                            else
                                                if state == 2 then
                                                    r1 = upvalueValues[r24]
                                                    ReturnVal = r1
                                                    state = 3
                                                end
                                            end
                                        else
                                            if state <= 3 then
                                                if state == 3 then
                                                    r1 = ReturnVal
                                                    r6 = "math"
                                                    ReturnVal = _env[r6]
                                                    r6 = "random"
                                                    state = ReturnVal[r6]
                                                    r6 = allocUpvalue()
                                                    upvalueValues[r6] = state
                                                    r17 = "table"
                                                    ReturnVal = _env[r17]
                                                    r17 = "concat"
                                                    state = ReturnVal[r17]
                                                    r17 = state
                                                    r20 = state
                                                    r28 = "table"
                                                    r16 = _env[r28]
                                                    state = r16 and 4 or 5
                                                    r2 = r16
                                                end
                                            else
                                                if state == 4 then
                                                    r5 = "table"
                                                    r28 = _env[r5]
                                                    r5 = "unpack"
                                                    r16 = r28[r5]
                                                    r2 = r16
                                                    state = 5
                                                end
                                            end
                                        end
                                    else
                                        if state <= 6 then
                                            if state <= 5 then
                                                if state == 5 then
                                                    state = r20
                                                    state = r2 and 6 or 7
                                                    ReturnVal = r2
                                                end
                                            else
                                                if state == 6 then
                                                    r2 = allocUpvalue()
                                                    upvalueValues[r2] = ReturnVal
                                                    state = upvalueValues[r6]
                                                    r16 = 65
                                                    r20 = 3
                                                    ReturnVal = state(r20, r16)
                                                    state = 0
                                                    r31 = createClosure2(28, {})
                                                    r20 = allocUpvalue()
                                                    upvalueValues[r20] = ReturnVal
                                                    r16 = state
                                                    state = 0
                                                    r5 = "pcall"
                                                    ReturnVal = _env[r5]
                                                    r5 = {
                                                        ReturnVal(r31)
                                                    }
                                                    r28 = state
                                                    state = {
                                                        unpack(r5)
                                                    }
                                                    r5 = state
                                                    ReturnVal = 2
                                                    state = r5[ReturnVal]
                                                    r31 = state
                                                    ReturnVal = "tonumber"
                                                    state = _env[ReturnVal]
                                                    r8 = upvalueValues[r10]
                                                    r3 = "tostring"
                                                    r21 = _env[r3]
                                                    r3 = r21(r31)
                                                    r21 = ":(%d*):"
                                                    r9 = r8(r3, r21)
                                                    r8 = {
                                                        r9()
                                                    }
                                                    ReturnVal = state(unpack(r8))
                                                    r8 = allocUpvalue()
                                                    upvalueValues[r8] = ReturnVal
                                                    r9 = upvalueValues[r20]
                                                    r21 = r9
                                                    r9 = 1
                                                    r3 = r9
                                                    r9 = 0
                                                    r26 = r3 < r9
                                                    ReturnVal = 1
                                                    r9 = ReturnVal - r3
                                                    state = 8
                                                end
                                            end
                                        else
                                            if state == 7 then
                                                r20 = "unpack"
                                                r2 = _env[r20]
                                                ReturnVal = r2
                                                state = 6
                                            end
                                        end
                                    end
                                else
                                    if state <= 10 then
                                        if state <= 9 then
                                            if state <= 8 then
                                                if state == 8 then
                                                    r30 = not r26
                                                    r9 = r9 + r3
                                                    ReturnVal = r9 <= r21
                                                    ReturnVal = r30 and ReturnVal
                                                    r30 = r9 >= r21
                                                    r30 = r26 and r30
                                                    ReturnVal = r30 or ReturnVal
                                                    r30 = 9
                                                    state = ReturnVal and r30
                                                    ReturnVal = 10
                                                    state = state or ReturnVal
                                                end
                                            else
                                                if state == 9 then
                                                    r30 = allocUpvalue()
                                                    upvalueValues[r30] = r9
                                                    r27 = "math"
                                                    ReturnVal = _env[r27]
                                                    r27 = "random"
                                                    state = ReturnVal[r27]
                                                    r27 = 1
                                                    r15 = 100
                                                    ReturnVal = state(r27, r15)
                                                    r27 = allocUpvalue()
                                                    upvalueValues[r27] = ReturnVal
                                                    state = upvalueValues[r6]
                                                    r14 = 255
                                                    r15 = 0
                                                    ReturnVal = state(r15, r14)
                                                    r15 = allocUpvalue()
                                                    upvalueValues[r15] = ReturnVal
                                                    state = upvalueValues[r6]
                                                    r23 = upvalueValues[r27]
                                                    r14 = 1
                                                    ReturnVal = state(r14, r23)
                                                    r14 = allocUpvalue()
                                                    upvalueValues[r14] = ReturnVal
                                                    ReturnVal = upvalueValues[r6]
                                                    r11 = 2
                                                    r13 = 1
                                                    r23 = ReturnVal(r13, r11)
                                                    ReturnVal = 1
                                                    state = r23 == ReturnVal
                                                    r23 = allocUpvalue()
                                                    upvalueValues[r23] = state
                                                    r22 = "tostring"
                                                    r19 = _env[r22]
                                                    r18 = upvalueValues[r6]
                                                    state = "gsub"
                                                    r25 = 0
                                                    r4 = 10000
                                                    r33 = {
                                                        r18(r25, r4)
                                                    }
                                                    r22 = r19(unpack(r33))
                                                    state = r31[state]
                                                    r19 = ":"
                                                    r29 = r22 .. r19
                                                    r11 = ":"
                                                    r13 = r11 .. r29
                                                    ReturnVal = ":(%d*):"
                                                    state = state(r31, ReturnVal, r13)
                                                    r13 = allocUpvalue()
                                                    r29 = createClosure4(29, {
                                                        r6,
                                                        r30,
                                                        r20,
                                                        r10,
                                                        r7,
                                                        r8,
                                                        r23,
                                                        r13,
                                                        r27,
                                                        r14,
                                                        r15,
                                                        r2
                                                    })
                                                    upvalueValues[r13] = state
                                                    r11 = "pcall"
                                                    ReturnVal = _env[r11]
                                                    r11 = {
                                                        ReturnVal(r29)
                                                    }
                                                    state = {
                                                        unpack(r11)
                                                    }
                                                    r11 = state
                                                    state = upvalueValues[r23]
                                                    state = state and 11 or 12
                                                end
                                            end
                                        else
                                            if state == 10 then
                                                r21 = upvalueValues[r7]
                                                state = r21 and 13 or 14
                                                r9 = r21
                                            end
                                        end
                                    else
                                        if state <= 12 then
                                            if state <= 11 then
                                                if state == 11 then
                                                    r29 = upvalueValues[r7]
                                                    state = r29 and 15 or 16
                                                    ReturnVal = r29
                                                end
                                            else
                                                if state == 12 then
                                                    r19 = upvalueValues[r7]
                                                    state = r19 and 17 or 18
                                                    r29 = r19
                                                end
                                            end
                                        else
                                            if state == 13 then
                                                r21 = r16 == r28
                                                r9 = r21
                                                state = 14
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 19 then
                                    if state <= 16 then
                                        if state <= 15 then
                                            if state <= 14 then
                                                if state == 14 then
                                                    upvalueValues[r7] = r9
                                                    state = upvalueValues[r7]
                                                    state = state and 19 or 20
                                                end
                                            else
                                                if state == 15 then
                                                    r19 = state
                                                    r33 = 1
                                                    r18 = r11[r33]
                                                    r33 = false
                                                    r22 = r18 == r33
                                                    state = r22 and 21 or 22
                                                    r29 = r22
                                                end
                                            end
                                        else
                                            if state == 16 then
                                                upvalueValues[r7] = ReturnVal
                                                state = 23
                                            end
                                        end
                                    else
                                        if state <= 18 then
                                            if state <= 17 then
                                                if state == 17 then
                                                    r22 = 1
                                                    r19 = r11[r22]
                                                    r29 = r19
                                                    state = 18
                                                end
                                            else
                                                if state == 18 then
                                                    upvalueValues[r7] = r29
                                                    r33 = upvalueValues[r14]
                                                    r25 = 1
                                                    r18 = r33 + r25
                                                    r22 = r11[r18]
                                                    r19 = r16 + r22
                                                    r22 = 256
                                                    state = r19 % r22
                                                    r16 = state
                                                    r18 = upvalueValues[r15]
                                                    r22 = r28 + r18
                                                    r18 = 256
                                                    r19 = r22 % r18
                                                    r28 = r19
                                                    state = 23
                                                end
                                            end
                                        else
                                            if state == 19 then
                                                state = 24
                                            end
                                        end
                                    end
                                else
                                    if state <= 22 then
                                        if state <= 21 then
                                            if state <= 20 then
                                                if state == 20 then
                                                    state = true
                                                    state = 25
                                                end
                                            else
                                                if state == 21 then
                                                    r33 = 2
                                                    r18 = r11[r33]
                                                    r33 = upvalueValues[r13]
                                                    r22 = r18 == r33
                                                    r29 = r22
                                                    state = 22
                                                end
                                            end
                                        else
                                            if state == 22 then
                                                state = r19
                                                ReturnVal = r29
                                                state = 16
                                            end
                                        end
                                    else
                                        if state <= 24 then
                                            if state <= 23 then
                                                if state == 23 then
                                                    r27 = releaseUpvalue(r27)
                                                    r14 = releaseUpvalue(r14)
                                                    r23 = releaseUpvalue(r23)
                                                    r30 = releaseUpvalue(r30)
                                                    r13 = releaseUpvalue(r13)
                                                    r15 = releaseUpvalue(r15)
                                                    r11 = nil
                                                    state = 8
                                                end
                                            else
                                                if state == 24 then
                                                    r24 = releaseUpvalue(r24)
                                                    r20 = releaseUpvalue(r20)
                                                    r6 = releaseUpvalue(r6)
                                                    r7 = releaseUpvalue(r7)
                                                    r10 = releaseUpvalue(r10)
                                                    r2 = releaseUpvalue(r2)
                                                    r8 = releaseUpvalue(r8)
                                                    r12 = releaseUpvalue(r12)
                                                    r10 = "print"
                                                    r7 = _env[r10]
                                                    ReturnVal = {}
                                                    r12 = "HI"
                                                    r10 = r7(r12)
                                                    r1 = nil
                                                    r16 = nil
                                                    r17 = nil
                                                    r5 = nil
                                                    r28 = nil
                                                    r31 = nil
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state == 25 then
                                                state = createClosure0(41, {
                                                    r12
                                                })
                                                r21 = {
                                                    state()
                                                }
                                                ReturnVal = {
                                                    unpack(r21)
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            -- createClosure4 entry 11167978 -> 26, states 26-26
                            if state == 26 then -- entry 11167978 -> 26
                                ReturnVal = "error"
                                state = _env[ReturnVal]
                                r32 = "Tamper Detected!"
                                ReturnVal = state(r32)
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    else
                        if state <= 27 then
                            -- createClosure2 entry 12690470 -> 27, states 27-27
                            if state == 27 then -- entry 12690470 -> 27
                                state = true
                                upvalueValues[upvalues[1]] = state
                                ReturnVal = {}
                                state = nil
                            end
                        else
                            -- createClosure2 entry 3587475 -> 28, states 28-28
                            if state == 28 then -- entry 3587475 -> 28
                                r7 = "wOWUKUPKrkxE5"
                                r10 = 4547020
                                r32 = r7 ^ r10
                                ReturnVal = 11757847
                                state = ReturnVal - r32
                                r32 = state
                                ReturnVal = "mIJJAbeQOeL"
                                state = ReturnVal / r32
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        end
                    end
                else
                    if state <= 44 then
                        if state <= 40 then
                            -- createClosure4 entry 16676646 -> 29, states 29-40
                            if state <= 34 then
                                if state <= 31 then
                                    if state <= 30 then
                                        if state <= 29 then
                                            if state == 29 then -- entry 16676646 -> 29
                                                r7 = upvalueValues[upvalues[1]]
                                                r24 = 2
                                                r12 = 1
                                                r10 = r7(r12, r24)
                                                r7 = 1
                                                r32 = r10 == r7
                                                state = r32 and 30 or 31
                                                ReturnVal = r32
                                            end
                                        else
                                            if state == 30 then
                                                state = ReturnVal and 32 or 33
                                            end
                                        end
                                    else
                                        if state == 31 then
                                            r7 = upvalueValues[upvalues[2]]
                                            r10 = upvalueValues[upvalues[3]]
                                            r32 = r7 == r10
                                            ReturnVal = r32
                                            state = 30
                                        end
                                    end
                                else
                                    if state <= 33 then
                                        if state <= 32 then
                                            if state == 32 then
                                                ReturnVal = "tonumber"
                                                state = _env[ReturnVal]
                                                r32 = upvalueValues[upvalues[4]]
                                                r12 = "tostring"
                                                r10 = _env[r12]
                                                r2 = createClosure5(45, {})
                                                r17 = "pcall"
                                                r6 = _env[r17]
                                                r17 = {
                                                    r6(r2)
                                                }
                                                r1 = {
                                                    unpack(r17)
                                                }
                                                r6 = 2
                                                r24 = r1[r6]
                                                r12 = r10(r24)
                                                r10 = ":(%d*):"
                                                r7 = r32(r12, r10)
                                                r32 = {
                                                    r7()
                                                }
                                                ReturnVal = state(unpack(r32))
                                                r32 = ReturnVal
                                                r7 = upvalueValues[upvalues[5]]
                                                state = r7 and 34 or 35
                                                ReturnVal = r7
                                            end
                                        else
                                            if state == 33 then
                                                state = upvalueValues[upvalues[7]]
                                                state = state and 36 or 37
                                            end
                                        end
                                    else
                                        if state == 34 then
                                            r10 = upvalueValues[upvalues[6]]
                                            r7 = r10 == r32
                                            ReturnVal = r7
                                            state = 35
                                        end
                                    end
                                end
                            else
                                if state <= 37 then
                                    if state <= 36 then
                                        if state <= 35 then
                                            if state == 35 then
                                                upvalueValues[upvalues[5]] = ReturnVal
                                                r32 = nil
                                                state = 33
                                            end
                                        else
                                            if state == 36 then
                                                r32 = "error"
                                                state = _env[r32]
                                                r7 = upvalueValues[upvalues[8]]
                                                r10 = 0
                                                r32 = state(r7, r10)
                                                state = 37
                                            end
                                        end
                                    else
                                        if state == 37 then
                                            r10 = upvalueValues[upvalues[9]]
                                            r12 = r10
                                            state = {}
                                            r32 = state
                                            r10 = 1
                                            r24 = r10
                                            r10 = 0
                                            r1 = r24 < r10
                                            r7 = 1
                                            r10 = r7 - r24
                                            state = 38
                                        end
                                    end
                                else
                                    if state <= 39 then
                                        if state <= 38 then
                                            if state == 38 then
                                                r6 = not r1
                                                r10 = r10 + r24
                                                r7 = r10 <= r12
                                                r7 = r6 and r7
                                                r6 = r10 >= r12
                                                r6 = r1 and r6
                                                r7 = r6 or r7
                                                r6 = 39
                                                state = r7 and r6
                                                r7 = 40
                                                state = state or r7
                                            end
                                        else
                                            if state == 39 then
                                                state = upvalueValues[upvalues[1]]
                                                r17 = 0
                                                r2 = 255
                                                r6 = state(r17, r2)
                                                r7 = r10
                                                r32[r7] = r6
                                                r7 = nil
                                                state = 38
                                            end
                                        end
                                    else
                                        if state == 40 then
                                            state = upvalueValues[upvalues[10]]
                                            r7 = upvalueValues[upvalues[11]]
                                            r32[state] = r7
                                            state = upvalueValues[upvalues[12]]
                                            r7 = {
                                                state(r32)
                                            }
                                            ReturnVal = {
                                                unpack(r7)
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            end
                        else
                            -- createClosure0 entry 16090015 -> 41, states 41-44
                            if state <= 42 then
                                if state <= 41 then
                                    if state == 41 then -- entry 16090015 -> 41
                                        state = 42
                                    end
                                else
                                    if state == 42 then
                                        state = true
                                        state = state and 43 or 44
                                    end
                                end
                            else
                                if state <= 43 then
                                    if state == 43 then
                                        ReturnVal = "l2"
                                        state = _env[ReturnVal]
                                        r32 = "l1"
                                        ReturnVal = _env[r32]
                                        r32 = "l1"
                                        _env[r32] = state
                                        r32 = "l2"
                                        _env[r32] = ReturnVal
                                        r32 = upvalueValues[upvalues[1]]
                                        r7 = r32()
                                        state = 42
                                    end
                                else
                                    if state == 44 then
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        end
                    else
                        -- createClosure5 entry 14497380 -> 45, states 45-45
                        if state == 45 then -- entry 14497380 -> 45
                            r10 = 13088272
                            r7 = "CcvDDxFNht8kA"
                            r32 = r7 ^ r10
                            ReturnVal = 174517
                            state = ReturnVal - r32
                            r32 = state
                            ReturnVal = "p5AkpEtZC9"
                            state = ReturnVal / r32
                            ReturnVal = {
                                state
                            }
                            state = nil
                        end
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
        currentUpvalueId = 0
        upvalueRefCounts = {}
        createClosure4 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1, arg2, arg3, arg4)
                return vm(entryId, {
                    arg1,
                    arg2,
                    arg3,
                    arg4
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)