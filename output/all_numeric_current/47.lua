return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, upvalueValues, currentUpvalueId, releaseUpvalues, upvalueRefCounts, createClosure3, createClosure, createUpvalueProxy, vm, releaseUpvalue, allocUpvalue, createClosure5, createClosure0)
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
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        currentUpvalueId = 0
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, ReturnVal, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33
            while state do
                if state <= 31 then
                    if state <= 29 then
                        if state <= 28 then
                            -- root entry 9970196 -> 1, states 1-28
                            if state <= 14 then
                                if state <= 7 then
                                    if state <= 4 then
                                        if state <= 2 then
                                            if state <= 1 then
                                                if state == 1 then -- entry 9970196 -> 1
                                                    r25 = allocUpvalue()
                                                    state = true
                                                    upvalueValues[r25] = state
                                                    r5 = "string"
                                                    ReturnVal = _env[r5]
                                                    r19 = allocUpvalue()
                                                    r6 = allocUpvalue()
                                                    r5 = "gmatch"
                                                    state = ReturnVal[r5]
                                                    r5 = allocUpvalue()
                                                    upvalueValues[r5] = state
                                                    state = createClosure3(29, {})
                                                    upvalueValues[r6] = state
                                                    state = false
                                                    r21 = createClosure3(30, {
                                                        r19
                                                    })
                                                    upvalueValues[r19] = state
                                                    r17 = "pcall"
                                                    r18 = _env[r17]
                                                    r17 = r18(r21)
                                                    state = r17 and 2 or 3
                                                    r31 = args
                                                    ReturnVal = r17
                                                end
                                            else
                                                if state == 2 then
                                                    r18 = upvalueValues[r19]
                                                    ReturnVal = r18
                                                    state = 3
                                                end
                                            end
                                        else
                                            if state <= 3 then
                                                if state == 3 then
                                                    r18 = ReturnVal
                                                    r17 = "math"
                                                    ReturnVal = _env[r17]
                                                    r17 = "random"
                                                    state = ReturnVal[r17]
                                                    r17 = allocUpvalue()
                                                    upvalueValues[r17] = state
                                                    r21 = "table"
                                                    ReturnVal = _env[r21]
                                                    r21 = "concat"
                                                    state = ReturnVal[r21]
                                                    r4 = state
                                                    r21 = state
                                                    r13 = "table"
                                                    r16 = _env[r13]
                                                    state = r16 and 4 or 5
                                                    r33 = r16
                                                end
                                            else
                                                if state == 4 then
                                                    r27 = "table"
                                                    r13 = _env[r27]
                                                    r27 = "unpack"
                                                    r16 = r13[r27]
                                                    r33 = r16
                                                    state = 5
                                                end
                                            end
                                        end
                                    else
                                        if state <= 6 then
                                            if state <= 5 then
                                                if state == 5 then
                                                    state = r4
                                                    state = r33 and 6 or 7
                                                    ReturnVal = r33
                                                end
                                            else
                                                if state == 6 then
                                                    r33 = allocUpvalue()
                                                    upvalueValues[r33] = ReturnVal
                                                    state = upvalueValues[r17]
                                                    r4 = 3
                                                    r16 = 65
                                                    ReturnVal = state(r4, r16)
                                                    state = 0
                                                    r16 = state
                                                    state = 0
                                                    r4 = allocUpvalue()
                                                    upvalueValues[r4] = ReturnVal
                                                    r13 = state
                                                    r24 = createClosure5(31, {})
                                                    r27 = "pcall"
                                                    ReturnVal = _env[r27]
                                                    r27 = {
                                                        ReturnVal(r24)
                                                    }
                                                    state = {
                                                        unpack(r27)
                                                    }
                                                    r27 = state
                                                    ReturnVal = 2
                                                    state = r27[ReturnVal]
                                                    r24 = state
                                                    ReturnVal = "tonumber"
                                                    state = _env[ReturnVal]
                                                    r3 = upvalueValues[r5]
                                                    r2 = "tostring"
                                                    r11 = _env[r2]
                                                    r2 = r11(r24)
                                                    r11 = ":(%d*):"
                                                    r9 = r3(r2, r11)
                                                    r3 = {
                                                        r9()
                                                    }
                                                    ReturnVal = state(unpack(r3))
                                                    r3 = allocUpvalue()
                                                    upvalueValues[r3] = ReturnVal
                                                    r9 = upvalueValues[r4]
                                                    r11 = r9
                                                    r9 = 1
                                                    r2 = r9
                                                    r9 = 0
                                                    r20 = r2 < r9
                                                    ReturnVal = 1
                                                    r9 = ReturnVal - r2
                                                    state = 8
                                                end
                                            end
                                        else
                                            if state == 7 then
                                                r4 = "unpack"
                                                r33 = _env[r4]
                                                ReturnVal = r33
                                                state = 6
                                            end
                                        end
                                    end
                                else
                                    if state <= 11 then
                                        if state <= 9 then
                                            if state <= 8 then
                                                if state == 8 then
                                                    r9 = r9 + r2
                                                    ReturnVal = r9 <= r11
                                                    r1 = not r20
                                                    ReturnVal = r1 and ReturnVal
                                                    r1 = r9 >= r11
                                                    r1 = r20 and r1
                                                    ReturnVal = r1 or ReturnVal
                                                    r1 = 9
                                                    state = ReturnVal and r1
                                                    ReturnVal = 10
                                                    state = state or ReturnVal
                                                end
                                            else
                                                if state == 9 then
                                                    r1 = allocUpvalue()
                                                    upvalueValues[r1] = r9
                                                    r28 = "math"
                                                    ReturnVal = _env[r28]
                                                    r28 = "random"
                                                    state = ReturnVal[r28]
                                                    r10 = 100
                                                    r28 = 1
                                                    ReturnVal = state(r28, r10)
                                                    r28 = allocUpvalue()
                                                    upvalueValues[r28] = ReturnVal
                                                    state = upvalueValues[r17]
                                                    r15 = 255
                                                    r10 = 0
                                                    ReturnVal = state(r10, r15)
                                                    r10 = allocUpvalue()
                                                    upvalueValues[r10] = ReturnVal
                                                    state = upvalueValues[r17]
                                                    r14 = upvalueValues[r28]
                                                    r15 = 1
                                                    ReturnVal = state(r15, r14)
                                                    r15 = allocUpvalue()
                                                    upvalueValues[r15] = ReturnVal
                                                    ReturnVal = upvalueValues[r17]
                                                    r22 = 1
                                                    r7 = 2
                                                    r14 = ReturnVal(r22, r7)
                                                    ReturnVal = 1
                                                    state = r14 == ReturnVal
                                                    r14 = allocUpvalue()
                                                    upvalueValues[r14] = state
                                                    r12 = "tostring"
                                                    r30 = _env[r12]
                                                    r29 = upvalueValues[r17]
                                                    r8 = 10000
                                                    r32 = 0
                                                    r26 = {
                                                        r29(r32, r8)
                                                    }
                                                    state = "gsub"
                                                    r12 = r30(unpack(r26))
                                                    state = r24[state]
                                                    r30 = ":"
                                                    r23 = r12 .. r30
                                                    r7 = ":"
                                                    r22 = r7 .. r23
                                                    ReturnVal = ":(%d*):"
                                                    state = state(r24, ReturnVal, r22)
                                                    r22 = allocUpvalue()
                                                    upvalueValues[r22] = state
                                                    r23 = createClosure5(32, {
                                                        r17,
                                                        r1,
                                                        r4,
                                                        r5,
                                                        r25,
                                                        r3,
                                                        r14,
                                                        r22,
                                                        r28,
                                                        r15,
                                                        r10,
                                                        r33
                                                    })
                                                    r7 = "pcall"
                                                    ReturnVal = _env[r7]
                                                    r7 = {
                                                        ReturnVal(r23)
                                                    }
                                                    state = {
                                                        unpack(r7)
                                                    }
                                                    r7 = state
                                                    state = upvalueValues[r14]
                                                    state = state and 11 or 12
                                                end
                                            end
                                        else
                                            if state <= 10 then
                                                if state == 10 then
                                                    r11 = upvalueValues[r25]
                                                    state = r11 and 13 or 14
                                                    r9 = r11
                                                end
                                            else
                                                if state == 11 then
                                                    r23 = upvalueValues[r25]
                                                    state = r23 and 15 or 16
                                                    ReturnVal = r23
                                                end
                                            end
                                        end
                                    else
                                        if state <= 13 then
                                            if state <= 12 then
                                                if state == 12 then
                                                    r30 = upvalueValues[r25]
                                                    state = r30 and 17 or 18
                                                    r23 = r30
                                                end
                                            else
                                                if state == 13 then
                                                    r11 = r16 == r13
                                                    r9 = r11
                                                    state = 14
                                                end
                                            end
                                        else
                                            if state == 14 then
                                                upvalueValues[r25] = r9
                                                state = upvalueValues[r25]
                                                state = state and 19 or 20
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 21 then
                                    if state <= 18 then
                                        if state <= 16 then
                                            if state <= 15 then
                                                if state == 15 then
                                                    r30 = state
                                                    r26 = 1
                                                    r29 = r7[r26]
                                                    r26 = false
                                                    r12 = r29 == r26
                                                    state = r12 and 21 or 22
                                                    r23 = r12
                                                end
                                            else
                                                if state == 16 then
                                                    upvalueValues[r25] = ReturnVal
                                                    state = 23
                                                end
                                            end
                                        else
                                            if state <= 17 then
                                                if state == 17 then
                                                    r12 = 1
                                                    r30 = r7[r12]
                                                    r23 = r30
                                                    state = 18
                                                end
                                            else
                                                if state == 18 then
                                                    upvalueValues[r25] = r23
                                                    r26 = upvalueValues[r15]
                                                    r32 = 1
                                                    r29 = r26 + r32
                                                    r12 = r7[r29]
                                                    r30 = r16 + r12
                                                    r12 = 256
                                                    state = r30 % r12
                                                    r16 = state
                                                    r29 = upvalueValues[r10]
                                                    r12 = r13 + r29
                                                    r29 = 256
                                                    r30 = r12 % r29
                                                    r13 = r30
                                                    state = 23
                                                end
                                            end
                                        end
                                    else
                                        if state <= 20 then
                                            if state <= 19 then
                                                if state == 19 then
                                                    state = 24
                                                end
                                            else
                                                if state == 20 then
                                                    state = true
                                                    state = 25
                                                end
                                            end
                                        else
                                            if state == 21 then
                                                r26 = 2
                                                r29 = r7[r26]
                                                r26 = upvalueValues[r22]
                                                r12 = r29 == r26
                                                r23 = r12
                                                state = 22
                                            end
                                        end
                                    end
                                else
                                    if state <= 25 then
                                        if state <= 23 then
                                            if state <= 22 then
                                                if state == 22 then
                                                    state = r30
                                                    ReturnVal = r23
                                                    state = 16
                                                end
                                            else
                                                if state == 23 then
                                                    r10 = releaseUpvalue(r10)
                                                    r14 = releaseUpvalue(r14)
                                                    r28 = releaseUpvalue(r28)
                                                    r15 = releaseUpvalue(r15)
                                                    r22 = releaseUpvalue(r22)
                                                    r1 = releaseUpvalue(r1)
                                                    r7 = nil
                                                    state = 8
                                                end
                                            end
                                        else
                                            if state <= 24 then
                                                if state == 24 then
                                                    r25 = releaseUpvalue(r25)
                                                    r4 = releaseUpvalue(r4)
                                                    r19 = releaseUpvalue(r19)
                                                    r33 = releaseUpvalue(r33)
                                                    r17 = releaseUpvalue(r17)
                                                    r3 = releaseUpvalue(r3)
                                                    r5 = releaseUpvalue(r5)
                                                    r5 = "setmetatable"
                                                    r25 = _env[r5]
                                                    r6 = releaseUpvalue(r6)
                                                    r21 = nil
                                                    r21 = "err"
                                                    r17 = _env[r21]
                                                    r6 = {}
                                                    r18 = nil
                                                    r18 = "__tostring"
                                                    r19 = {
                                                        [r18] = r17
                                                    }
                                                    r5 = r25(r6, r19)
                                                    r19 = "math"
                                                    r6 = _env[r19]
                                                    r19 = "random"
                                                    r25 = r6[r19]
                                                    r18 = 100
                                                    r19 = 1
                                                    r6 = r25(r19, r18)
                                                    r25 = r5
                                                    r5[r6] = r25
                                                    r25 = createClosure3(44, {})
                                                    r6 = r25(r5)
                                                    r6 = "valid"
                                                    r25 = _env[r6]
                                                    r13 = nil
                                                    r27 = nil
                                                    r16 = nil
                                                    r24 = nil
                                                    state = 26
                                                end
                                            else
                                                if state == 25 then
                                                    state = createClosure0(45, {
                                                        r6
                                                    })
                                                    r11 = {
                                                        state()
                                                    }
                                                    ReturnVal = {
                                                        unpack(r11)
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        if state <= 27 then
                                            if state <= 26 then
                                                if state == 26 then
                                                    state = 27
                                                end
                                            else
                                                if state == 27 then
                                                    r6 = "valid"
                                                    r25 = _env[r6]
                                                    state = r25 and 28 or 26
                                                end
                                            end
                                        else
                                            if state == 28 then
                                                r5 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            -- createClosure3 entry 4379208 -> 29, states 29-29
                            if state == 29 then -- entry 4379208 -> 29
                                ReturnVal = "error"
                                state = _env[ReturnVal]
                                r31 = "Tamper Detected!"
                                ReturnVal = state(r31)
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    else
                        if state <= 30 then
                            -- createClosure3 entry 14773719 -> 30, states 30-30
                            if state == 30 then -- entry 14773719 -> 30
                                state = true
                                upvalueValues[upvalues[1]] = state
                                ReturnVal = {}
                                state = nil
                            end
                        else
                            -- createClosure5 entry 3512164 -> 31, states 31-31
                            if state == 31 then -- entry 3512164 -> 31
                                r25 = "rLkPzM"
                                r5 = 1192387
                                r31 = r25 ^ r5
                                ReturnVal = 7348123
                                state = ReturnVal - r31
                                r31 = state
                                ReturnVal = "JwQnVe"
                                state = ReturnVal / r31
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        end
                    end
                else
                    if state <= 44 then
                        if state <= 43 then
                            -- createClosure5 entry 12006068 -> 32, states 32-43
                            if state <= 37 then
                                if state <= 34 then
                                    if state <= 33 then
                                        if state <= 32 then
                                            if state == 32 then -- entry 12006068 -> 32
                                                r25 = upvalueValues[upvalues[1]]
                                                r19 = 2
                                                r6 = 1
                                                r5 = r25(r6, r19)
                                                r25 = 1
                                                r31 = r5 == r25
                                                state = r31 and 33 or 34
                                                ReturnVal = r31
                                            end
                                        else
                                            if state == 33 then
                                                state = ReturnVal and 35 or 36
                                            end
                                        end
                                    else
                                        if state == 34 then
                                            r25 = upvalueValues[upvalues[2]]
                                            r5 = upvalueValues[upvalues[3]]
                                            r31 = r25 == r5
                                            ReturnVal = r31
                                            state = 33
                                        end
                                    end
                                else
                                    if state <= 36 then
                                        if state <= 35 then
                                            if state == 35 then
                                                r33 = createClosure5(49, {})
                                                ReturnVal = "tonumber"
                                                state = _env[ReturnVal]
                                                r31 = upvalueValues[upvalues[4]]
                                                r6 = "tostring"
                                                r5 = _env[r6]
                                                r21 = "pcall"
                                                r17 = _env[r21]
                                                r21 = {
                                                    r17(r33)
                                                }
                                                r18 = {
                                                    unpack(r21)
                                                }
                                                r17 = 2
                                                r19 = r18[r17]
                                                r6 = r5(r19)
                                                r5 = ":(%d*):"
                                                r25 = r31(r6, r5)
                                                r31 = {
                                                    r25()
                                                }
                                                ReturnVal = state(unpack(r31))
                                                r31 = ReturnVal
                                                r25 = upvalueValues[upvalues[5]]
                                                state = r25 and 37 or 38
                                                ReturnVal = r25
                                            end
                                        else
                                            if state == 36 then
                                                state = upvalueValues[upvalues[7]]
                                                state = state and 39 or 40
                                            end
                                        end
                                    else
                                        if state == 37 then
                                            r5 = upvalueValues[upvalues[6]]
                                            r25 = r5 == r31
                                            ReturnVal = r25
                                            state = 38
                                        end
                                    end
                                end
                            else
                                if state <= 40 then
                                    if state <= 39 then
                                        if state <= 38 then
                                            if state == 38 then
                                                upvalueValues[upvalues[5]] = ReturnVal
                                                r31 = nil
                                                state = 36
                                            end
                                        else
                                            if state == 39 then
                                                r31 = "error"
                                                state = _env[r31]
                                                r25 = upvalueValues[upvalues[8]]
                                                r5 = 0
                                                r31 = state(r25, r5)
                                                state = 40
                                            end
                                        end
                                    else
                                        if state == 40 then
                                            state = {}
                                            r31 = state
                                            r5 = upvalueValues[upvalues[9]]
                                            r6 = r5
                                            r5 = 1
                                            r19 = r5
                                            r5 = 0
                                            r18 = r19 < r5
                                            r25 = 1
                                            r5 = r25 - r19
                                            state = 41
                                        end
                                    end
                                else
                                    if state <= 42 then
                                        if state <= 41 then
                                            if state == 41 then
                                                r17 = not r18
                                                r5 = r5 + r19
                                                r25 = r5 <= r6
                                                r25 = r17 and r25
                                                r17 = r5 >= r6
                                                r17 = r18 and r17
                                                r25 = r17 or r25
                                                r17 = 42
                                                state = r25 and r17
                                                r25 = 43
                                                state = state or r25
                                            end
                                        else
                                            if state == 42 then
                                                state = upvalueValues[upvalues[1]]
                                                r21 = 0
                                                r33 = 255
                                                r17 = state(r21, r33)
                                                r25 = r5
                                                r31[r25] = r17
                                                r25 = nil
                                                state = 41
                                            end
                                        end
                                    else
                                        if state == 43 then
                                            state = upvalueValues[upvalues[10]]
                                            r25 = upvalueValues[upvalues[11]]
                                            r31[state] = r25
                                            state = upvalueValues[upvalues[12]]
                                            r25 = {
                                                state(r31)
                                            }
                                            ReturnVal = {
                                                unpack(r25)
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            end
                        else
                            -- createClosure3 entry 11264285 -> 44, states 44-44
                            if state == 44 then -- entry 11264285 -> 44
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    else
                        if state <= 48 then
                            -- createClosure0 entry 11818282 -> 45, states 45-48
                            if state <= 46 then
                                if state <= 45 then
                                    if state == 45 then -- entry 11818282 -> 45
                                        state = 46
                                    end
                                else
                                    if state == 46 then
                                        state = true
                                        state = state and 47 or 48
                                    end
                                end
                            else
                                if state <= 47 then
                                    if state == 47 then
                                        ReturnVal = "l2"
                                        state = _env[ReturnVal]
                                        r31 = "l1"
                                        ReturnVal = _env[r31]
                                        r31 = "l1"
                                        _env[r31] = state
                                        r31 = "l2"
                                        _env[r31] = ReturnVal
                                        r31 = upvalueValues[upvalues[1]]
                                        r25 = r31()
                                        state = 46
                                    end
                                else
                                    if state == 48 then
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        else
                            -- createClosure5 entry 674210 -> 49, states 49-49
                            if state == 49 then -- entry 674210 -> 49
                                r5 = 831271
                                r25 = "tYxBqR"
                                r31 = r25 ^ r5
                                ReturnVal = 4920137
                                state = ReturnVal - r31
                                r31 = state
                                ReturnVal = "HdMvKs"
                                state = ReturnVal / r31
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        end
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
                    return 3999764
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 3999764
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
        upvalueRefCounts = {}
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
            end
            return closure
        end
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)