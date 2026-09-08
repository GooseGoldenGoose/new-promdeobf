return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, currentUpvalueId, releaseUpvalue, createUpvalueProxy, releaseUpvalues, createClosure5, createClosure2, createClosure0, allocUpvalue, upvalueValues, createClosure, createClosure1, createClosure4, vm, upvalueRefCounts)
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, ReturnVal, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33
            while state do
                if state <= 51 then
                    if state <= 38 then
                        if state <= 37 then
                            if state <= 36 then
                                -- root entry 2637723 -> 1, states 1-36
                                if state <= 18 then
                                    if state <= 9 then
                                        if state <= 5 then
                                            if state <= 3 then
                                                if state <= 2 then
                                                    if state <= 1 then
                                                        if state == 1 then -- entry 2637723 -> 1
                                                            r21 = allocUpvalue()
                                                            r11 = allocUpvalue()
                                                            state = true
                                                            upvalueValues[r21] = state
                                                            r9 = "string"
                                                            ReturnVal = _env[r9]
                                                            r9 = "gmatch"
                                                            state = ReturnVal[r9]
                                                            r9 = allocUpvalue()
                                                            upvalueValues[r9] = state
                                                            r15 = createClosure2(37, {
                                                                r11
                                                            })
                                                            r24 = allocUpvalue()
                                                            state = createClosure2(38, {})
                                                            upvalueValues[r24] = state
                                                            state = false
                                                            upvalueValues[r11] = state
                                                            r19 = "pcall"
                                                            r10 = _env[r19]
                                                            r19 = r10(r15)
                                                            state = r19 and (2) or (3)
                                                            r33 = args
                                                            ReturnVal = r19
                                                        end
                                                    else
                                                        if state == 2 then
                                                            r10 = upvalueValues[r11]
                                                            ReturnVal = r10
                                                            state = 3
                                                        end
                                                    end
                                                else
                                                    if state == 3 then
                                                        r10 = ReturnVal
                                                        r19 = "math"
                                                        ReturnVal = _env[r19]
                                                        r19 = "random"
                                                        state = ReturnVal[r19]
                                                        r19 = allocUpvalue()
                                                        upvalueValues[r19] = state
                                                        r15 = "table"
                                                        ReturnVal = _env[r15]
                                                        r15 = "concat"
                                                        state = ReturnVal[r15]
                                                        r15 = state
                                                        r25 = state
                                                        r29 = "table"
                                                        r8 = _env[r29]
                                                        state = r8 and (4) or (5)
                                                        r2 = r8
                                                    end
                                                end
                                            else
                                                if state <= 4 then
                                                    if state == 4 then
                                                        r5 = "table"
                                                        r29 = _env[r5]
                                                        r5 = "unpack"
                                                        r8 = r29[r5]
                                                        r2 = r8
                                                        state = 5
                                                    end
                                                else
                                                    if state == 5 then
                                                        state = r25
                                                        state = r2 and (6) or (7)
                                                        ReturnVal = r2
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 7 then
                                                if state <= 6 then
                                                    if state == 6 then
                                                        r2 = allocUpvalue()
                                                        upvalueValues[r2] = ReturnVal
                                                        state = upvalueValues[r19]
                                                        r25 = 3
                                                        r8 = 65
                                                        ReturnVal = state(r25, r8)
                                                        r25 = allocUpvalue()
                                                        upvalueValues[r25] = ReturnVal
                                                        r5 = "pcall"
                                                        ReturnVal = _env[r5]
                                                        state = 0
                                                        r14 = createClosure4(39, {})
                                                        r5 = {
                                                            ReturnVal(r14)
                                                        }
                                                        r8 = state
                                                        state = 0
                                                        r29 = state
                                                        state = {
                                                            unpack(r5)
                                                        }
                                                        r5 = state
                                                        ReturnVal = 2
                                                        state = r5[ReturnVal]
                                                        r14 = state
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r22 = upvalueValues[r9]
                                                        r12 = "tostring"
                                                        r20 = _env[r12]
                                                        r12 = r20(r14)
                                                        r20 = ":(%d*):"
                                                        r30 = r22(r12, r20)
                                                        r22 = {
                                                            r30()
                                                        }
                                                        ReturnVal = state(unpack(r22))
                                                        r22 = allocUpvalue()
                                                        upvalueValues[r22] = ReturnVal
                                                        r30 = upvalueValues[r25]
                                                        r20 = r30
                                                        r30 = 1
                                                        r12 = r30
                                                        r30 = 0
                                                        r6 = r12 < r30
                                                        ReturnVal = 1
                                                        r30 = ReturnVal - r12
                                                        state = 8
                                                    end
                                                else
                                                    if state == 7 then
                                                        r25 = "unpack"
                                                        r2 = _env[r25]
                                                        ReturnVal = r2
                                                        state = 6
                                                    end
                                                end
                                            else
                                                if state <= 8 then
                                                    if state == 8 then
                                                        r30 = r30 + r12
                                                        ReturnVal = r30 <= r20
                                                        r32 = not r6
                                                        ReturnVal = r32 and ReturnVal
                                                        r32 = r30 >= r20
                                                        r32 = r6 and r32
                                                        ReturnVal = r32 or ReturnVal
                                                        r32 = (9)
                                                        state = ReturnVal and r32
                                                        ReturnVal = (10)
                                                        state = state or ReturnVal
                                                    end
                                                else
                                                    if state == 9 then
                                                        r32 = allocUpvalue()
                                                        upvalueValues[r32] = r30
                                                        r23 = "math"
                                                        ReturnVal = _env[r23]
                                                        r23 = "random"
                                                        state = ReturnVal[r23]
                                                        r3 = 100
                                                        r23 = 1
                                                        ReturnVal = state(r23, r3)
                                                        r23 = allocUpvalue()
                                                        upvalueValues[r23] = ReturnVal
                                                        state = upvalueValues[r19]
                                                        r7 = 255
                                                        r3 = 0
                                                        ReturnVal = state(r3, r7)
                                                        r3 = allocUpvalue()
                                                        upvalueValues[r3] = ReturnVal
                                                        state = upvalueValues[r19]
                                                        r27 = upvalueValues[r23]
                                                        r7 = 1
                                                        ReturnVal = state(r7, r27)
                                                        r7 = allocUpvalue()
                                                        upvalueValues[r7] = ReturnVal
                                                        ReturnVal = upvalueValues[r19]
                                                        r28 = 1
                                                        r13 = 2
                                                        r27 = ReturnVal(r28, r13)
                                                        ReturnVal = 1
                                                        state = r27 == ReturnVal
                                                        r27 = allocUpvalue()
                                                        upvalueValues[r27] = state
                                                        r16 = "tostring"
                                                        r26 = _env[r16]
                                                        r18 = upvalueValues[r19]
                                                        r1 = 10000
                                                        r4 = 0
                                                        r17 = {
                                                            r18(r4, r1)
                                                        }
                                                        r16 = r26(unpack(r17))
                                                        r26 = ":"
                                                        r31 = r16 .. r26
                                                        state = "gsub"
                                                        state = r14[state]
                                                        r13 = ":"
                                                        r28 = r13 .. r31
                                                        ReturnVal = ":(%d*):"
                                                        state = state(r14, ReturnVal, r28)
                                                        r28 = allocUpvalue()
                                                        upvalueValues[r28] = state
                                                        r13 = "pcall"
                                                        ReturnVal = _env[r13]
                                                        r31 = createClosure1(40, {
                                                            r19,
                                                            r32,
                                                            r25,
                                                            r9,
                                                            r21,
                                                            r22,
                                                            r27,
                                                            r28,
                                                            r23,
                                                            r7,
                                                            r3,
                                                            r2
                                                        })
                                                        r13 = {
                                                            ReturnVal(r31)
                                                        }
                                                        state = {
                                                            unpack(r13)
                                                        }
                                                        r13 = state
                                                        state = upvalueValues[r27]
                                                        state = state and (11) or (12)
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 14 then
                                            if state <= 12 then
                                                if state <= 11 then
                                                    if state <= 10 then
                                                        if state == 10 then
                                                            r20 = upvalueValues[r21]
                                                            state = r20 and (13) or (14)
                                                            r30 = r20
                                                        end
                                                    else
                                                        if state == 11 then
                                                            r31 = upvalueValues[r21]
                                                            state = r31 and (15) or (16)
                                                            ReturnVal = r31
                                                        end
                                                    end
                                                else
                                                    if state == 12 then
                                                        r26 = upvalueValues[r21]
                                                        state = r26 and (17) or (18)
                                                        r31 = r26
                                                    end
                                                end
                                            else
                                                if state <= 13 then
                                                    if state == 13 then
                                                        r20 = r8 == r29
                                                        r30 = r20
                                                        state = 14
                                                    end
                                                else
                                                    if state == 14 then
                                                        upvalueValues[r21] = r30
                                                        state = upvalueValues[r21]
                                                        state = state and (19) or (20)
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 16 then
                                                if state <= 15 then
                                                    if state == 15 then
                                                        r26 = state
                                                        r17 = 1
                                                        r18 = r13[r17]
                                                        r17 = false
                                                        r16 = r18 == r17
                                                        state = r16 and (21) or (22)
                                                        r31 = r16
                                                    end
                                                else
                                                    if state == 16 then
                                                        upvalueValues[r21] = ReturnVal
                                                        state = 23
                                                    end
                                                end
                                            else
                                                if state <= 17 then
                                                    if state == 17 then
                                                        r16 = 1
                                                        r26 = r13[r16]
                                                        r31 = r26
                                                        state = 18
                                                    end
                                                else
                                                    if state == 18 then
                                                        upvalueValues[r21] = r31
                                                        r17 = upvalueValues[r7]
                                                        r4 = 1
                                                        r18 = r17 + r4
                                                        r16 = r13[r18]
                                                        r26 = r8 + r16
                                                        r16 = 256
                                                        state = r26 % r16
                                                        r8 = state
                                                        r18 = upvalueValues[r3]
                                                        r16 = r29 + r18
                                                        r18 = 256
                                                        r26 = r16 % r18
                                                        r29 = r26
                                                        state = 23
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    if state <= 27 then
                                        if state <= 23 then
                                            if state <= 21 then
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
                                                        r17 = 2
                                                        r18 = r13[r17]
                                                        r17 = upvalueValues[r28]
                                                        r16 = r18 == r17
                                                        r31 = r16
                                                        state = 22
                                                    end
                                                end
                                            else
                                                if state <= 22 then
                                                    if state == 22 then
                                                        state = r26
                                                        ReturnVal = r31
                                                        state = 16
                                                    end
                                                else
                                                    if state == 23 then
                                                        r7 = releaseUpvalue(r7)
                                                        r27 = releaseUpvalue(r27)
                                                        r23 = releaseUpvalue(r23)
                                                        r13 = nil
                                                        r32 = releaseUpvalue(r32)
                                                        r28 = releaseUpvalue(r28)
                                                        r3 = releaseUpvalue(r3)
                                                        state = 8
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 25 then
                                                if state <= 24 then
                                                    if state == 24 then
                                                        r9 = releaseUpvalue(r9)
                                                        r25 = releaseUpvalue(r25)
                                                        r21 = releaseUpvalue(r21)
                                                        r11 = releaseUpvalue(r11)
                                                        r25 = allocUpvalue()
                                                        r22 = releaseUpvalue(r22)
                                                        r2 = releaseUpvalue(r2)
                                                        r19 = releaseUpvalue(r19)
                                                        r24 = releaseUpvalue(r24)
                                                        r24 = allocUpvalue()
                                                        r21 = nil
                                                        upvalueValues[r24] = r21
                                                        r21 = allocUpvalue()
                                                        r9 = nil
                                                        upvalueValues[r21] = r9
                                                        r10 = nil
                                                        r10 = "math"
                                                        r11 = _env[r10]
                                                        r10 = "floor"
                                                        r9 = r11[r10]
                                                        r11 = allocUpvalue()
                                                        r29 = nil
                                                        r29 = allocUpvalue()
                                                        upvalueValues[r11] = r9
                                                        r19 = "math"
                                                        r10 = _env[r19]
                                                        r19 = "random"
                                                        r9 = r10[r19]
                                                        r15 = nil
                                                        r15 = "table"
                                                        r19 = _env[r15]
                                                        r8 = nil
                                                        r8 = {}
                                                        r15 = "remove"
                                                        r10 = r19[r15]
                                                        r2 = "string"
                                                        r15 = _env[r2]
                                                        r5 = nil
                                                        r5 = {}
                                                        r2 = "char"
                                                        r19 = r15[r2]
                                                        r2 = allocUpvalue()
                                                        r15 = 0
                                                        upvalueValues[r2] = r15
                                                        r15 = 2
                                                        upvalueValues[r25] = r15
                                                        upvalueValues[r29] = r8
                                                        r15 = {}
                                                        r22 = 256
                                                        r6 = r22
                                                        r22 = 1
                                                        r32 = r22
                                                        r22 = 0
                                                        r23 = r32 < r22
                                                        r14 = nil
                                                        r14 = 1
                                                        r22 = r14 - r32
                                                        r8 = 0
                                                        state = 26
                                                    end
                                                else
                                                    if state == 25 then
                                                        state = createClosure1(52, {
                                                            r24
                                                        })
                                                        r20 = {
                                                            state()
                                                        }
                                                        ReturnVal = {
                                                            unpack(r20)
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state <= 26 then
                                                    if state == 26 then
                                                        r3 = not r23
                                                        r22 = r22 + r32
                                                        r14 = r22 <= r6
                                                        r14 = r3 and r14
                                                        r3 = r22 >= r6
                                                        r3 = r23 and r3
                                                        r14 = r3 or r14
                                                        r3 = (27)
                                                        state = r14 and r3
                                                        r14 = (28)
                                                        state = state or r14
                                                    end
                                                else
                                                    if state == 27 then
                                                        r14 = r22
                                                        r3 = r14
                                                        r5[r14] = r3
                                                        r14 = nil
                                                        state = 26
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 32 then
                                            if state <= 30 then
                                                if state <= 29 then
                                                    if state <= 28 then
                                                        if state == 28 then
                                                            r22 = #r5
                                                            r6 = 0
                                                            r14 = r22 == r6
                                                            state = 29
                                                        end
                                                    else
                                                        if state == 29 then
                                                            r22 = 1
                                                            r6 = #r5
                                                            r14 = r9(r22, r6)
                                                            r22 = r10(r5, r14)
                                                            r14 = nil
                                                            r6 = upvalueValues[r29]
                                                            r3 = 1
                                                            r23 = r22 - r3
                                                            r32 = r19(r23)
                                                            r6[r22] = r32
                                                            r22 = nil
                                                            state = 30
                                                        end
                                                    end
                                                else
                                                    if state == 30 then
                                                        r22 = #r5
                                                        r6 = 0
                                                        r14 = r22 == r6
                                                        state = r14 and (31) or (29)
                                                    end
                                                end
                                            else
                                                if state <= 31 then
                                                    if state == 31 then
                                                        r14 = {}
                                                        r22 = allocUpvalue()
                                                        upvalueValues[r22] = r14
                                                        r14 = allocUpvalue()
                                                        r6 = createClosure4(56, {
                                                            r22,
                                                            r2,
                                                            r25,
                                                            r11
                                                        })
                                                        r9 = nil
                                                        r3 = {}
                                                        r11 = releaseUpvalue(r11)
                                                        r8 = nil
                                                        upvalueValues[r14] = r6
                                                        r23 = "setmetatable"
                                                        r13 = "__metatable"
                                                        r6 = {}
                                                        r5 = nil
                                                        r32 = allocUpvalue()
                                                        upvalueValues[r32] = r6
                                                        r6 = _env[r23]
                                                        r28 = upvalueValues[r32]
                                                        r27 = "__index"
                                                        r16 = nil
                                                        r7 = {
                                                            [r27] = r28,
                                                            [r13] = r16
                                                        }
                                                        r23 = r6(r3, r7)
                                                        r6 = createClosure5(62, {
                                                            r32,
                                                            r22,
                                                            r29,
                                                            r2,
                                                            r25,
                                                            r14
                                                        })
                                                        r32 = releaseUpvalue(r32)
                                                        r14 = releaseUpvalue(r14)
                                                        upvalueValues[r21] = r23
                                                        upvalueValues[r24] = r6
                                                        r22 = releaseUpvalue(r22)
                                                        r25 = releaseUpvalue(r25)
                                                        r2 = releaseUpvalue(r2)
                                                        r10 = nil
                                                        r10 = "pcall"
                                                        r11 = _env[r10]
                                                        r29 = releaseUpvalue(r29)
                                                        r15 = nil
                                                        r15 = createClosure0(69, {
                                                            r21,
                                                            r24
                                                        })
                                                        r2 = {
                                                            r11(r15)
                                                        }
                                                        r10 = r2[1]
                                                        r15 = state
                                                        state = r10 and (32) or (33)
                                                        r19 = nil
                                                        r9 = true
                                                        r19 = r2[2]
                                                        r11 = r10
                                                    end
                                                else
                                                    if state == 32 then
                                                        r11 = r19
                                                        state = 33
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 34 then
                                                if state <= 33 then
                                                    if state == 33 then
                                                        state = r15
                                                        state = r11 and (34) or (35)
                                                    end
                                                else
                                                    if state == 34 then
                                                        r15 = "error"
                                                        r11 = _env[r15]
                                                        r25 = upvalueValues[r21]
                                                        r8 = upvalueValues[r24]
                                                        r5 = "}\234\243Yj\244\017yc\030\226\246\029\014t\029\220\157\162E\137$@\237\240\185-\000\188\218\231"
                                                        r14 = 30310341850914
                                                        r29 = r8(r5, r14)
                                                        r2 = r25[r29]
                                                        r25 = 0
                                                        r15 = r11(r2, r25)
                                                        state = 36
                                                    end
                                                end
                                            else
                                                if state <= 35 then
                                                    if state == 35 then
                                                        r15 = "print"
                                                        r11 = _env[r15]
                                                        r25 = upvalueValues[r21]
                                                        r8 = upvalueValues[r24]
                                                        r5 = "\130\014\004"
                                                        r14 = 32319985793738
                                                        r29 = r8(r5, r14)
                                                        r2 = r25[r29]
                                                        r15 = r11(r2)
                                                        state = 36
                                                    end
                                                else
                                                    if state == 36 then
                                                        r21 = releaseUpvalue(r21)
                                                        r24 = releaseUpvalue(r24)
                                                        r9 = nil
                                                        r10 = nil
                                                        r19 = nil
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure2 entry 6155773 -> 37, states 37-37
                                if state == 37 then -- entry 6155773 -> 37
                                    state = true
                                    upvalueValues[upvalues[1]] = state
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            -- createClosure2 entry 6315264 -> 38, states 38-38
                            if state == 38 then -- entry 6315264 -> 38
                                ReturnVal = "error"
                                state = _env[ReturnVal]
                                r33 = "Tamper Detected!"
                                ReturnVal = state(r33)
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    else
                        if state <= 39 then
                            -- createClosure4 entry 5809594 -> 39, states 39-39
                            if state == 39 then -- entry 5809594 -> 39
                                r21 = "aTNkiaPp"
                                r9 = 8841854
                                r33 = r21 ^ r9
                                ReturnVal = 10680634
                                state = ReturnVal - r33
                                r33 = state
                                ReturnVal = "EeZ9F6oTgFI"
                                state = ReturnVal / r33
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        else
                            -- createClosure1 entry 7995554 -> 40, states 40-51
                            if state <= 45 then
                                if state <= 42 then
                                    if state <= 41 then
                                        if state <= 40 then
                                            if state == 40 then -- entry 7995554 -> 40
                                                r21 = upvalueValues[upvalues[1]]
                                                r24 = 1
                                                r11 = 2
                                                r9 = r21(r24, r11)
                                                r21 = 1
                                                r33 = r9 == r21
                                                state = r33 and (41) or (42)
                                                ReturnVal = r33
                                            end
                                        else
                                            if state == 41 then
                                                state = ReturnVal and (43) or (44)
                                            end
                                        end
                                    else
                                        if state == 42 then
                                            r21 = upvalueValues[upvalues[2]]
                                            r9 = upvalueValues[upvalues[3]]
                                            r33 = r21 == r9
                                            ReturnVal = r33
                                            state = 41
                                        end
                                    end
                                else
                                    if state <= 44 then
                                        if state <= 43 then
                                            if state == 43 then
                                                ReturnVal = "tonumber"
                                                state = _env[ReturnVal]
                                                r2 = createClosure4(74, {})
                                                r33 = upvalueValues[upvalues[4]]
                                                r24 = "tostring"
                                                r9 = _env[r24]
                                                r15 = "pcall"
                                                r19 = _env[r15]
                                                r15 = {
                                                    r19(r2)
                                                }
                                                r10 = {
                                                    unpack(r15)
                                                }
                                                r19 = 2
                                                r11 = r10[r19]
                                                r24 = r9(r11)
                                                r9 = ":(%d*):"
                                                r21 = r33(r24, r9)
                                                r33 = {
                                                    r21()
                                                }
                                                ReturnVal = state(unpack(r33))
                                                r33 = ReturnVal
                                                r21 = upvalueValues[upvalues[5]]
                                                state = r21 and (45) or (46)
                                                ReturnVal = r21
                                            end
                                        else
                                            if state == 44 then
                                                state = upvalueValues[upvalues[7]]
                                                state = state and (47) or (48)
                                            end
                                        end
                                    else
                                        if state == 45 then
                                            r9 = upvalueValues[upvalues[6]]
                                            r21 = r9 == r33
                                            ReturnVal = r21
                                            state = 46
                                        end
                                    end
                                end
                            else
                                if state <= 48 then
                                    if state <= 47 then
                                        if state <= 46 then
                                            if state == 46 then
                                                r33 = nil
                                                upvalueValues[upvalues[5]] = ReturnVal
                                                state = 44
                                            end
                                        else
                                            if state == 47 then
                                                r33 = "error"
                                                state = _env[r33]
                                                r21 = upvalueValues[upvalues[8]]
                                                r9 = 0
                                                r33 = state(r21, r9)
                                                state = 48
                                            end
                                        end
                                    else
                                        if state == 48 then
                                            r9 = upvalueValues[upvalues[9]]
                                            r24 = r9
                                            state = {}
                                            r33 = state
                                            r9 = 1
                                            r11 = r9
                                            r9 = 0
                                            r10 = r11 < r9
                                            r21 = 1
                                            r9 = r21 - r11
                                            state = 49
                                        end
                                    end
                                else
                                    if state <= 50 then
                                        if state <= 49 then
                                            if state == 49 then
                                                r19 = not r10
                                                r9 = r9 + r11
                                                r21 = r9 <= r24
                                                r21 = r19 and r21
                                                r19 = r9 >= r24
                                                r19 = r10 and r19
                                                r21 = r19 or r21
                                                r19 = (50)
                                                state = r21 and r19
                                                r21 = (51)
                                                state = state or r21
                                            end
                                        else
                                            if state == 50 then
                                                r21 = r9
                                                state = upvalueValues[upvalues[1]]
                                                r15 = 0
                                                r2 = 255
                                                r19 = state(r15, r2)
                                                r33[r21] = r19
                                                r21 = nil
                                                state = 49
                                            end
                                        end
                                    else
                                        if state == 51 then
                                            state = upvalueValues[upvalues[10]]
                                            r21 = upvalueValues[upvalues[11]]
                                            r33[state] = r21
                                            state = upvalueValues[upvalues[12]]
                                            r21 = {
                                                state(r33)
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
                    end
                else
                    if state <= 68 then
                        if state <= 61 then
                            if state <= 55 then
                                -- createClosure1 entry 14604749 -> 52, states 52-55
                                if state <= 53 then
                                    if state <= 52 then
                                        if state == 52 then -- entry 14604749 -> 52
                                            state = 53
                                        end
                                    else
                                        if state == 53 then
                                            state = true
                                            state = state and (54) or (55)
                                        end
                                    end
                                else
                                    if state <= 54 then
                                        if state == 54 then
                                            ReturnVal = "l2"
                                            state = _env[ReturnVal]
                                            r33 = "l1"
                                            ReturnVal = _env[r33]
                                            r33 = "l1"
                                            _env[r33] = state
                                            r33 = "l2"
                                            _env[r33] = ReturnVal
                                            r33 = upvalueValues[upvalues[1]]
                                            r21 = r33()
                                            state = 53
                                        end
                                    else
                                        if state == 55 then
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            else
                                -- createClosure4 entry 7534525 -> 56, states 56-61
                                if state <= 58 then
                                    if state <= 57 then
                                        if state <= 56 then
                                            if state == 56 then -- entry 7534525 -> 56
                                                r33 = upvalueValues[upvalues[1]]
                                                ReturnVal = #r33
                                                r33 = 0
                                                state = ReturnVal == r33
                                                state = state and (57) or (58)
                                            end
                                        else
                                            if state == 57 then
                                                r21 = upvalueValues[upvalues[2]]
                                                r9 = 13
                                                r33 = r21 * r9
                                                r21 = 32561706236729
                                                ReturnVal = r33 + r21
                                                r33 = 35184372088832
                                                state = ReturnVal % r33
                                                upvalueValues[upvalues[2]] = state
                                                r33 = upvalueValues[upvalues[3]]
                                                r21 = 1
                                                ReturnVal = r33 ~= r21
                                                state = 59
                                            end
                                        end
                                    else
                                        if state == 58 then
                                            r9 = "table"
                                            r21 = _env[r9]
                                            r9 = "remove"
                                            r33 = r21[r9]
                                            r9 = upvalueValues[upvalues[1]]
                                            r21 = {
                                                r33(r9)
                                            }
                                            ReturnVal = {
                                                unpack(r21)
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    if state <= 60 then
                                        if state <= 59 then
                                            if state == 59 then
                                                r21 = upvalueValues[upvalues[3]]
                                                r9 = 154
                                                r33 = r21 * r9
                                                r21 = 257
                                                ReturnVal = r33 % r21
                                                upvalueValues[upvalues[3]] = ReturnVal
                                                state = 60
                                            end
                                        else
                                            if state == 60 then
                                                r21 = upvalueValues[upvalues[3]]
                                                r9 = 1
                                                r33 = r21 ~= r9
                                                state = r33 and (61) or (59)
                                            end
                                        end
                                    else
                                        if state == 61 then
                                            r21 = upvalueValues[upvalues[3]]
                                            r9 = 32
                                            r33 = r21 % r9
                                            r2 = 2
                                            r24 = upvalueValues[upvalues[4]]
                                            r19 = upvalueValues[upvalues[2]]
                                            r14 = upvalueValues[upvalues[3]]
                                            r5 = r14 - r33
                                            r14 = 32
                                            r29 = r5 / r14
                                            r8 = 13
                                            r25 = r8 - r29
                                            r15 = r2 ^ r25
                                            r10 = r19 / r15
                                            r11 = r24(r10)
                                            r24 = 4294967296
                                            r9 = r11 % r24
                                            r11 = 2
                                            r15 = 1
                                            r24 = r11 ^ r33
                                            r21 = r9 / r24
                                            r2 = 256
                                            r24 = upvalueValues[upvalues[4]]
                                            r19 = r21 % r15
                                            r15 = 4294967296
                                            r10 = r19 * r15
                                            r11 = r24(r10)
                                            r24 = upvalueValues[upvalues[4]]
                                            r33 = nil
                                            r10 = r24(r21)
                                            r9 = r11 + r10
                                            r11 = 65536
                                            r21 = nil
                                            r19 = 65536
                                            r24 = r9 % r11
                                            r10 = r9 - r24
                                            r11 = r10 / r19
                                            r9 = nil
                                            r19 = 256
                                            r10 = r24 % r19
                                            r15 = r24 - r10
                                            r19 = r15 / r2
                                            r2 = 256
                                            r15 = r11 % r2
                                            r24 = nil
                                            r25 = r11 - r15
                                            r8 = 256
                                            r2 = r25 / r8
                                            r25 = {
                                                r10,
                                                r19,
                                                r15,
                                                r2
                                            }
                                            r11 = nil
                                            r19 = nil
                                            r2 = nil
                                            upvalueValues[upvalues[1]] = r25
                                            r15 = nil
                                            r10 = nil
                                            state = 58
                                        end
                                    end
                                end
                            end
                        else
                            -- createClosure5 entry 2149193 -> 62, states 62-68
                            if state <= 65 then
                                if state <= 63 then
                                    if state <= 62 then
                                        if state == 62 then -- entry 2149193 -> 62
                                            r21 = args[2]
                                            state = upvalueValues[upvalues[1]]
                                            r9 = state
                                            r33 = args[1]
                                            state = r9[r21]
                                            state = state and (63) or (64)
                                        end
                                    else
                                        if state == 63 then
                                            state = 65
                                        end
                                    end
                                else
                                    if state <= 64 then
                                        if state == 64 then
                                            state = {}
                                            upvalueValues[upvalues[2]] = state
                                            ReturnVal = upvalueValues[upvalues[3]]
                                            r24 = ReturnVal
                                            r11 = 35184372088832
                                            ReturnVal = r21 % r11
                                            upvalueValues[upvalues[4]] = ReturnVal
                                            r19 = 255
                                            r10 = r21 % r19
                                            r19 = 2
                                            r11 = r10 + r19
                                            upvalueValues[upvalues[5]] = r11
                                            r15 = "string"
                                            r19 = _env[r15]
                                            r15 = "len"
                                            r10 = r19[r15]
                                            r19 = r10(r33)
                                            r25 = 1
                                            r8 = r25
                                            r10 = ""
                                            r9[r21] = r10
                                            r25 = 0
                                            r29 = r8 < r25
                                            r15 = 1
                                            r25 = r15 - r8
                                            r2 = r19
                                            r10 = 199
                                            state = 66
                                        end
                                    else
                                        if state == 65 then
                                            ReturnVal = {
                                                r21
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            else
                                if state <= 67 then
                                    if state <= 66 then
                                        if state == 66 then
                                            r5 = not r29
                                            r25 = r25 + r8
                                            r15 = r25 <= r2
                                            r15 = r5 and r15
                                            r5 = r25 >= r2
                                            r5 = r29 and r5
                                            r15 = r5 or r15
                                            r5 = (67)
                                            state = r15 and r5
                                            r15 = (68)
                                            state = state or r15
                                        end
                                    else
                                        if state == 67 then
                                            r15 = r25
                                            r12 = "string"
                                            r20 = _env[r12]
                                            r12 = "byte"
                                            r30 = r20[r12]
                                            r20 = r30(r33, r15)
                                            r30 = upvalueValues[upvalues[6]]
                                            r12 = r30()
                                            r22 = r20 + r12
                                            r14 = r22 + r10
                                            r12 = 1
                                            r15 = nil
                                            r22 = 256
                                            r5 = r14 % r22
                                            r10 = r5
                                            r22 = r9[r21]
                                            r20 = r10 + r12
                                            r30 = r24[r20]
                                            r14 = r22 .. r30
                                            r9[r21] = r14
                                            state = 66
                                        end
                                    end
                                else
                                    if state == 68 then
                                        r24 = nil
                                        r10 = nil
                                        r19 = nil
                                        state = 65
                                    end
                                end
                            end
                        end
                    else
                        if state <= 73 then
                            -- createClosure0 entry 2518361 -> 69, states 69-73
                            if state <= 71 then
                                if state <= 70 then
                                    if state <= 69 then
                                        if state == 69 then -- entry 2518361 -> 69
                                            r21 = state
                                            r24 = "package"
                                            r9 = _env[r24]
                                            state = r9 and (70) or (71)
                                            r33 = r9
                                        end
                                    else
                                        if state == 70 then
                                            r24 = state
                                            r19 = "package"
                                            r10 = _env[r19]
                                            r15 = upvalueValues[upvalues[1]]
                                            r2 = upvalueValues[upvalues[2]]
                                            r29 = 24008414620587
                                            r8 = "j)\196\197"
                                            r25 = r2(r8, r29)
                                            r19 = r15[r25]
                                            r11 = r10[r19]
                                            state = r11 and (72) or (73)
                                            r9 = r11
                                        end
                                    end
                                else
                                    if state == 71 then
                                        ReturnVal = not r33
                                        state = r21
                                        state = not ReturnVal
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 72 then
                                    if state == 72 then
                                        r2 = "package"
                                        r15 = _env[r2]
                                        r25 = upvalueValues[upvalues[1]]
                                        r8 = upvalueValues[upvalues[2]]
                                        r14 = 14758587308760
                                        r5 = "\196\229\205\148"
                                        r29 = r8(r5, r14)
                                        r2 = r25[r29]
                                        r19 = r15[r2]
                                        r10 = #r19
                                        r19 = 0
                                        r11 = r10 > r19
                                        r9 = r11
                                        state = 73
                                    end
                                else
                                    if state == 73 then
                                        state = r24
                                        r33 = r9
                                        state = 71
                                    end
                                end
                            end
                        else
                            -- createClosure4 entry 1525311 -> 74, states 74-74
                            if state == 74 then -- entry 1525311 -> 74
                                r9 = 5142743
                                r21 = "xd9si8NSi"
                                r33 = r21 ^ r9
                                ReturnVal = 8633796
                                state = ReturnVal - r33
                                r33 = state
                                ReturnVal = "mQA0PiG"
                                state = ReturnVal / r33
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
        upvalueValues = {}
        createClosure1 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1)
                return vm(entryId, {
                    arg1
                }, captures, gcProxy)
            end
            return closure
        end
        currentUpvalueId = 0
        createClosure = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(...)
                return vm(entryId, {
                    ...
                }, captures, gcProxy)
            end
            return closure
        end
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
        upvalueRefCounts = {}
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
            end
            return closure
        end
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -3955507
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -3955507
                    end
                })
            end
        end
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)