return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, allocUpvalue, createUpvalueProxy, createClosure2, upvalueRefCounts, createClosure4, upvalueValues, currentUpvalueId, releaseUpvalue, createClosure6, createClosure0, createClosure1, createClosure, createClosure3, releaseUpvalues, createClosure5, vm)
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, ReturnVal, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33
            while state do
                if state <= 50 then
                    if state <= 37 then
                        if state <= 36 then
                            if state <= 35 then
                                -- root entry 1144880 -> 1, states 1-35
                                if state <= 18 then
                                    if state <= 9 then
                                        if state <= 5 then
                                            if state <= 3 then
                                                if state <= 2 then
                                                    if state <= 1 then
                                                        if state == 1 then -- entry 1144880 -> 1
                                                            r1 = allocUpvalue()
                                                            r20 = allocUpvalue()
                                                            state = true
                                                            upvalueValues[r20] = state
                                                            r15 = "string"
                                                            ReturnVal = _env[r15]
                                                            r15 = "gmatch"
                                                            state = ReturnVal[r15]
                                                            r15 = allocUpvalue()
                                                            r2 = allocUpvalue()
                                                            upvalueValues[r15] = state
                                                            state = createClosure4(36, {})
                                                            upvalueValues[r1] = state
                                                            state = false
                                                            upvalueValues[r2] = state
                                                            r23 = "pcall"
                                                            r10 = _env[r23]
                                                            r16 = createClosure3(37, {
                                                                r2
                                                            })
                                                            r23 = r10(r16)
                                                            state = r23 and (2) or (3)
                                                            r5 = args
                                                            ReturnVal = r23
                                                        end
                                                    else
                                                        if state == 2 then
                                                            r10 = upvalueValues[r2]
                                                            ReturnVal = r10
                                                            state = 3
                                                        end
                                                    end
                                                else
                                                    if state == 3 then
                                                        r10 = ReturnVal
                                                        r23 = "math"
                                                        ReturnVal = _env[r23]
                                                        r23 = "random"
                                                        state = ReturnVal[r23]
                                                        r23 = allocUpvalue()
                                                        upvalueValues[r23] = state
                                                        r16 = "table"
                                                        ReturnVal = _env[r16]
                                                        r16 = "concat"
                                                        state = ReturnVal[r16]
                                                        r30 = state
                                                        r16 = state
                                                        r13 = "table"
                                                        r31 = _env[r13]
                                                        state = r31 and (4) or (5)
                                                        r22 = r31
                                                    end
                                                end
                                            else
                                                if state <= 4 then
                                                    if state == 4 then
                                                        r19 = "table"
                                                        r13 = _env[r19]
                                                        r19 = "unpack"
                                                        r31 = r13[r19]
                                                        r22 = r31
                                                        state = 5
                                                    end
                                                else
                                                    if state == 5 then
                                                        state = r30
                                                        state = r22 and (6) or (7)
                                                        ReturnVal = r22
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 7 then
                                                if state <= 6 then
                                                    if state == 6 then
                                                        r22 = allocUpvalue()
                                                        upvalueValues[r22] = ReturnVal
                                                        state = upvalueValues[r23]
                                                        r30 = 3
                                                        r31 = 65
                                                        ReturnVal = state(r30, r31)
                                                        r3 = createClosure1(38, {})
                                                        r30 = allocUpvalue()
                                                        upvalueValues[r30] = ReturnVal
                                                        state = 0
                                                        r31 = state
                                                        r19 = "pcall"
                                                        ReturnVal = _env[r19]
                                                        state = 0
                                                        r19 = {
                                                            ReturnVal(r3)
                                                        }
                                                        r13 = state
                                                        state = {
                                                            unpack(r19)
                                                        }
                                                        r19 = state
                                                        ReturnVal = 2
                                                        state = r19[ReturnVal]
                                                        r3 = state
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r33 = upvalueValues[r15]
                                                        r28 = "tostring"
                                                        r6 = _env[r28]
                                                        r28 = r6(r3)
                                                        r6 = ":(%d*):"
                                                        r26 = r33(r28, r6)
                                                        r33 = {
                                                            r26()
                                                        }
                                                        ReturnVal = state(unpack(r33))
                                                        r33 = allocUpvalue()
                                                        upvalueValues[r33] = ReturnVal
                                                        r26 = upvalueValues[r30]
                                                        r6 = r26
                                                        r26 = 1
                                                        r28 = r26
                                                        r26 = 0
                                                        r17 = r28 < r26
                                                        ReturnVal = 1
                                                        r26 = ReturnVal - r28
                                                        state = 8
                                                    end
                                                else
                                                    if state == 7 then
                                                        r30 = "unpack"
                                                        r22 = _env[r30]
                                                        ReturnVal = r22
                                                        state = 6
                                                    end
                                                end
                                            else
                                                if state <= 8 then
                                                    if state == 8 then
                                                        r26 = r26 + r28
                                                        ReturnVal = r26 <= r6
                                                        r25 = not r17
                                                        ReturnVal = r25 and ReturnVal
                                                        r25 = r26 >= r6
                                                        r25 = r17 and r25
                                                        ReturnVal = r25 or ReturnVal
                                                        r25 = (9)
                                                        state = ReturnVal and r25
                                                        ReturnVal = (10)
                                                        state = state or ReturnVal
                                                    end
                                                else
                                                    if state == 9 then
                                                        r25 = allocUpvalue()
                                                        upvalueValues[r25] = r26
                                                        r14 = "math"
                                                        ReturnVal = _env[r14]
                                                        r14 = "random"
                                                        state = ReturnVal[r14]
                                                        r9 = 100
                                                        r14 = 1
                                                        ReturnVal = state(r14, r9)
                                                        r14 = allocUpvalue()
                                                        upvalueValues[r14] = ReturnVal
                                                        state = upvalueValues[r23]
                                                        r11 = 255
                                                        r9 = 0
                                                        ReturnVal = state(r9, r11)
                                                        r9 = allocUpvalue()
                                                        upvalueValues[r9] = ReturnVal
                                                        state = upvalueValues[r23]
                                                        r21 = upvalueValues[r14]
                                                        r11 = 1
                                                        ReturnVal = state(r11, r21)
                                                        r11 = allocUpvalue()
                                                        upvalueValues[r11] = ReturnVal
                                                        ReturnVal = upvalueValues[r23]
                                                        r27 = 1
                                                        r18 = 2
                                                        r21 = ReturnVal(r27, r18)
                                                        ReturnVal = 1
                                                        state = r21 == ReturnVal
                                                        r21 = allocUpvalue()
                                                        upvalueValues[r21] = state
                                                        r8 = "tostring"
                                                        r32 = _env[r8]
                                                        r24 = upvalueValues[r23]
                                                        r4 = 10000
                                                        r12 = 0
                                                        r29 = {
                                                            r24(r12, r4)
                                                        }
                                                        r8 = r32(unpack(r29))
                                                        state = "gsub"
                                                        state = r3[state]
                                                        r32 = ":"
                                                        r7 = r8 .. r32
                                                        r18 = ":"
                                                        r27 = r18 .. r7
                                                        ReturnVal = ":(%d*):"
                                                        state = state(r3, ReturnVal, r27)
                                                        r27 = allocUpvalue()
                                                        upvalueValues[r27] = state
                                                        r18 = "pcall"
                                                        ReturnVal = _env[r18]
                                                        r7 = createClosure3(39, {
                                                            r23,
                                                            r25,
                                                            r30,
                                                            r15,
                                                            r20,
                                                            r33,
                                                            r21,
                                                            r27,
                                                            r14,
                                                            r11,
                                                            r9,
                                                            r22
                                                        })
                                                        r18 = {
                                                            ReturnVal(r7)
                                                        }
                                                        state = {
                                                            unpack(r18)
                                                        }
                                                        r18 = state
                                                        state = upvalueValues[r21]
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
                                                            r6 = upvalueValues[r20]
                                                            state = r6 and (13) or (14)
                                                            r26 = r6
                                                        end
                                                    else
                                                        if state == 11 then
                                                            r7 = upvalueValues[r20]
                                                            state = r7 and (15) or (16)
                                                            ReturnVal = r7
                                                        end
                                                    end
                                                else
                                                    if state == 12 then
                                                        r32 = upvalueValues[r20]
                                                        state = r32 and (17) or (18)
                                                        r7 = r32
                                                    end
                                                end
                                            else
                                                if state <= 13 then
                                                    if state == 13 then
                                                        r6 = r31 == r13
                                                        r26 = r6
                                                        state = 14
                                                    end
                                                else
                                                    if state == 14 then
                                                        upvalueValues[r20] = r26
                                                        state = upvalueValues[r20]
                                                        state = state and (19) or (20)
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 16 then
                                                if state <= 15 then
                                                    if state == 15 then
                                                        r32 = state
                                                        r29 = 1
                                                        r24 = r18[r29]
                                                        r29 = false
                                                        r8 = r24 == r29
                                                        state = r8 and (21) or (22)
                                                        r7 = r8
                                                    end
                                                else
                                                    if state == 16 then
                                                        upvalueValues[r20] = ReturnVal
                                                        state = 23
                                                    end
                                                end
                                            else
                                                if state <= 17 then
                                                    if state == 17 then
                                                        r8 = 1
                                                        r32 = r18[r8]
                                                        r7 = r32
                                                        state = 18
                                                    end
                                                else
                                                    if state == 18 then
                                                        upvalueValues[r20] = r7
                                                        r29 = upvalueValues[r11]
                                                        r12 = 1
                                                        r24 = r29 + r12
                                                        r8 = r18[r24]
                                                        r32 = r31 + r8
                                                        r8 = 256
                                                        state = r32 % r8
                                                        r31 = state
                                                        r24 = upvalueValues[r9]
                                                        r8 = r13 + r24
                                                        r24 = 256
                                                        r32 = r8 % r24
                                                        r13 = r32
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
                                                        r29 = 2
                                                        r24 = r18[r29]
                                                        r29 = upvalueValues[r27]
                                                        r8 = r24 == r29
                                                        r7 = r8
                                                        state = 22
                                                    end
                                                end
                                            else
                                                if state <= 22 then
                                                    if state == 22 then
                                                        state = r32
                                                        ReturnVal = r7
                                                        state = 16
                                                    end
                                                else
                                                    if state == 23 then
                                                        r27 = releaseUpvalue(r27)
                                                        r9 = releaseUpvalue(r9)
                                                        r14 = releaseUpvalue(r14)
                                                        r11 = releaseUpvalue(r11)
                                                        r25 = releaseUpvalue(r25)
                                                        r18 = nil
                                                        r21 = releaseUpvalue(r21)
                                                        state = 8
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 25 then
                                                if state <= 24 then
                                                    if state == 24 then
                                                        r20 = releaseUpvalue(r20)
                                                        r30 = releaseUpvalue(r30)
                                                        r23 = releaseUpvalue(r23)
                                                        r15 = releaseUpvalue(r15)
                                                        r30 = allocUpvalue()
                                                        r1 = releaseUpvalue(r1)
                                                        r1 = allocUpvalue()
                                                        r13 = nil
                                                        r13 = allocUpvalue()
                                                        r2 = releaseUpvalue(r2)
                                                        r22 = releaseUpvalue(r22)
                                                        r20 = nil
                                                        upvalueValues[r1] = r20
                                                        r33 = releaseUpvalue(r33)
                                                        r20 = allocUpvalue()
                                                        r15 = nil
                                                        upvalueValues[r20] = r15
                                                        r10 = nil
                                                        r10 = "math"
                                                        r2 = _env[r10]
                                                        r10 = "floor"
                                                        r15 = r2[r10]
                                                        r2 = allocUpvalue()
                                                        upvalueValues[r2] = r15
                                                        r23 = "math"
                                                        r10 = _env[r23]
                                                        r23 = "random"
                                                        r15 = r10[r23]
                                                        r16 = nil
                                                        r16 = "table"
                                                        r23 = _env[r16]
                                                        r16 = "remove"
                                                        r10 = r23[r16]
                                                        r19 = nil
                                                        r19 = {}
                                                        r22 = "string"
                                                        r16 = _env[r22]
                                                        r22 = "char"
                                                        r23 = r16[r22]
                                                        r33 = 256
                                                        r22 = allocUpvalue()
                                                        r31 = nil
                                                        r31 = {}
                                                        r16 = 0
                                                        upvalueValues[r22] = r16
                                                        r16 = 2
                                                        upvalueValues[r30] = r16
                                                        r17 = r33
                                                        r33 = 1
                                                        r16 = {}
                                                        upvalueValues[r13] = r31
                                                        r25 = r33
                                                        r33 = 0
                                                        r14 = r25 < r33
                                                        r3 = nil
                                                        r3 = 1
                                                        r33 = r3 - r25
                                                        r31 = 0
                                                        state = 26
                                                    end
                                                else
                                                    if state == 25 then
                                                        state = createClosure5(51, {
                                                            r1
                                                        })
                                                        r6 = {
                                                            state()
                                                        }
                                                        ReturnVal = {
                                                            unpack(r6)
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state <= 26 then
                                                    if state == 26 then
                                                        r33 = r33 + r25
                                                        r3 = r33 <= r17
                                                        r9 = not r14
                                                        r3 = r9 and r3
                                                        r9 = r33 >= r17
                                                        r9 = r14 and r9
                                                        r3 = r9 or r3
                                                        r9 = (27)
                                                        state = r3 and r9
                                                        r3 = (28)
                                                        state = state or r3
                                                    end
                                                else
                                                    if state == 27 then
                                                        r3 = r33
                                                        r9 = r3
                                                        r19[r3] = r9
                                                        r3 = nil
                                                        state = 26
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 31 then
                                            if state <= 29 then
                                                if state <= 28 then
                                                    if state == 28 then
                                                        r33 = #r19
                                                        r17 = 0
                                                        r3 = r33 == r17
                                                        state = 29
                                                    end
                                                else
                                                    if state == 29 then
                                                        r17 = #r19
                                                        r33 = 1
                                                        r3 = r15(r33, r17)
                                                        r33 = r10(r19, r3)
                                                        r17 = upvalueValues[r13]
                                                        r9 = 1
                                                        r14 = r33 - r9
                                                        r25 = r23(r14)
                                                        r17[r33] = r25
                                                        r33 = nil
                                                        r3 = nil
                                                        state = 30
                                                    end
                                                end
                                            else
                                                if state <= 30 then
                                                    if state == 30 then
                                                        r33 = #r19
                                                        r17 = 0
                                                        r3 = r33 == r17
                                                        state = r3 and (31) or (29)
                                                    end
                                                else
                                                    if state == 31 then
                                                        r9 = {}
                                                        r3 = {}
                                                        r33 = allocUpvalue()
                                                        r25 = allocUpvalue()
                                                        upvalueValues[r33] = r3
                                                        r17 = createClosure4(55, {
                                                            r33,
                                                            r22,
                                                            r30,
                                                            r2
                                                        })
                                                        r15 = nil
                                                        r15 = createClosure0(61, {
                                                            r20,
                                                            r1
                                                        })
                                                        r3 = allocUpvalue()
                                                        upvalueValues[r3] = r17
                                                        r2 = releaseUpvalue(r2)
                                                        r17 = {}
                                                        upvalueValues[r25] = r17
                                                        r14 = "setmetatable"
                                                        r17 = _env[r14]
                                                        r27 = upvalueValues[r25]
                                                        r21 = "__index"
                                                        r18 = "__metatable"
                                                        r8 = nil
                                                        r11 = {
                                                            [r21] = r27,
                                                            [r18] = r8
                                                        }
                                                        r14 = r17(r9, r11)
                                                        r17 = createClosure6(62, {
                                                            r25,
                                                            r33,
                                                            r13,
                                                            r22,
                                                            r30,
                                                            r3
                                                        })
                                                        r25 = releaseUpvalue(r25)
                                                        r30 = releaseUpvalue(r30)
                                                        r33 = releaseUpvalue(r33)
                                                        r22 = releaseUpvalue(r22)
                                                        upvalueValues[r20] = r14
                                                        r3 = releaseUpvalue(r3)
                                                        r13 = releaseUpvalue(r13)
                                                        upvalueValues[r1] = r17
                                                        r23 = nil
                                                        r23 = "tostring"
                                                        r10 = nil
                                                        r10 = _env[r23]
                                                        r23 = r10(r15)
                                                        r10 = "lower"
                                                        r10 = r23[r10]
                                                        r10 = r10(r23)
                                                        r30 = upvalueValues[r20]
                                                        r16 = nil
                                                        r16 = "find"
                                                        r16 = r10[r16]
                                                        r31 = nil
                                                        r31 = upvalueValues[r1]
                                                        r3 = 24155390209008
                                                        r19 = nil
                                                        r19 = "\017\008\252\150\207\028\184\131$\tX\209\199"
                                                        r13 = r31(r19, r3)
                                                        r22 = r30[r13]
                                                        r16 = r16(r10, r22)
                                                        state = r16 and (32) or (33)
                                                        r2 = false
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 33 then
                                                if state <= 32 then
                                                    if state == 32 then
                                                        r16 = "pcall"
                                                        r10 = _env[r16]
                                                        r30 = {
                                                            r10(r15)
                                                        }
                                                        r22 = r30[2]
                                                        r16 = r30[1]
                                                        r31 = upvalueValues[r20]
                                                        r13 = upvalueValues[r1]
                                                        r33 = 20006989177956
                                                        r3 = "\194\012\018P"
                                                        r19 = r13(r3, r33)
                                                        r30 = r31[r19]
                                                        r10 = r22 ~= r30
                                                        state = r10 and (34) or (35)
                                                    end
                                                else
                                                    if state == 33 then
                                                        r1 = releaseUpvalue(r1)
                                                        r2 = nil
                                                        r23 = nil
                                                        r15 = nil
                                                        ReturnVal = {}
                                                        r20 = releaseUpvalue(r20)
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state <= 34 then
                                                    if state == 34 then
                                                        r30 = "warn"
                                                        r10 = _env[r30]
                                                        r13 = upvalueValues[r20]
                                                        r19 = upvalueValues[r1]
                                                        r17 = 18398858699127
                                                        r33 = "\133k\211\218F\175'\223\250\027\129\245+\150\134"
                                                        r3 = r19(r33, r17)
                                                        r31 = r13[r3]
                                                        r30 = r10(r31)
                                                        r10 = true
                                                        r2 = r10
                                                        state = 35
                                                    end
                                                else
                                                    if state == 35 then
                                                        r22 = nil
                                                        r16 = nil
                                                        state = 33
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure4 entry 1274856 -> 36, states 36-36
                                if state == 36 then -- entry 1274856 -> 36
                                    ReturnVal = "error"
                                    state = _env[ReturnVal]
                                    r5 = "Tamper Detected!"
                                    ReturnVal = state(r5)
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            -- createClosure3 entry 4056272 -> 37, states 37-37
                            if state == 37 then -- entry 4056272 -> 37
                                state = true
                                upvalueValues[upvalues[1]] = state
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    else
                        if state <= 38 then
                            -- createClosure1 entry 7343564 -> 38, states 38-38
                            if state == 38 then -- entry 7343564 -> 38
                                r20 = "126s0YBVZkYQN"
                                r15 = 8137540
                                r5 = r20 ^ r15
                                ReturnVal = 1953574
                                state = ReturnVal - r5
                                r5 = state
                                ReturnVal = "EybA700DZO"
                                state = ReturnVal / r5
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        else
                            -- createClosure3 entry 8173749 -> 39, states 39-50
                            if state <= 44 then
                                if state <= 41 then
                                    if state <= 40 then
                                        if state <= 39 then
                                            if state == 39 then -- entry 8173749 -> 39
                                                r20 = upvalueValues[upvalues[1]]
                                                r1 = 1
                                                r2 = 2
                                                r15 = r20(r1, r2)
                                                r20 = 1
                                                r5 = r15 == r20
                                                state = r5 and (40) or (41)
                                                ReturnVal = r5
                                            end
                                        else
                                            if state == 40 then
                                                state = ReturnVal and (42) or (43)
                                            end
                                        end
                                    else
                                        if state == 41 then
                                            r20 = upvalueValues[upvalues[2]]
                                            r15 = upvalueValues[upvalues[3]]
                                            r5 = r20 == r15
                                            ReturnVal = r5
                                            state = 40
                                        end
                                    end
                                else
                                    if state <= 43 then
                                        if state <= 42 then
                                            if state == 42 then
                                                ReturnVal = "tonumber"
                                                state = _env[ReturnVal]
                                                r22 = createClosure2(69, {})
                                                r5 = upvalueValues[upvalues[4]]
                                                r1 = "tostring"
                                                r15 = _env[r1]
                                                r16 = "pcall"
                                                r23 = _env[r16]
                                                r16 = {
                                                    r23(r22)
                                                }
                                                r10 = {
                                                    unpack(r16)
                                                }
                                                r23 = 2
                                                r2 = r10[r23]
                                                r1 = r15(r2)
                                                r15 = ":(%d*):"
                                                r20 = r5(r1, r15)
                                                r5 = {
                                                    r20()
                                                }
                                                ReturnVal = state(unpack(r5))
                                                r5 = ReturnVal
                                                r20 = upvalueValues[upvalues[5]]
                                                state = r20 and (44) or (45)
                                                ReturnVal = r20
                                            end
                                        else
                                            if state == 43 then
                                                state = upvalueValues[upvalues[7]]
                                                state = state and (46) or (47)
                                            end
                                        end
                                    else
                                        if state == 44 then
                                            r15 = upvalueValues[upvalues[6]]
                                            r20 = r15 == r5
                                            ReturnVal = r20
                                            state = 45
                                        end
                                    end
                                end
                            else
                                if state <= 47 then
                                    if state <= 46 then
                                        if state <= 45 then
                                            if state == 45 then
                                                upvalueValues[upvalues[5]] = ReturnVal
                                                r5 = nil
                                                state = 43
                                            end
                                        else
                                            if state == 46 then
                                                r5 = "error"
                                                state = _env[r5]
                                                r20 = upvalueValues[upvalues[8]]
                                                r15 = 0
                                                r5 = state(r20, r15)
                                                state = 47
                                            end
                                        end
                                    else
                                        if state == 47 then
                                            r15 = upvalueValues[upvalues[9]]
                                            r1 = r15
                                            state = {}
                                            r5 = state
                                            r15 = 1
                                            r2 = r15
                                            r15 = 0
                                            r10 = r2 < r15
                                            r20 = 1
                                            r15 = r20 - r2
                                            state = 48
                                        end
                                    end
                                else
                                    if state <= 49 then
                                        if state <= 48 then
                                            if state == 48 then
                                                r15 = r15 + r2
                                                r23 = not r10
                                                r20 = r15 <= r1
                                                r20 = r23 and r20
                                                r23 = r15 >= r1
                                                r23 = r10 and r23
                                                r20 = r23 or r20
                                                r23 = (49)
                                                state = r20 and r23
                                                r20 = (50)
                                                state = state or r20
                                            end
                                        else
                                            if state == 49 then
                                                r20 = r15
                                                state = upvalueValues[upvalues[1]]
                                                r22 = 255
                                                r16 = 0
                                                r23 = state(r16, r22)
                                                r5[r20] = r23
                                                r20 = nil
                                                state = 48
                                            end
                                        end
                                    else
                                        if state == 50 then
                                            state = upvalueValues[upvalues[10]]
                                            r20 = upvalueValues[upvalues[11]]
                                            r5[state] = r20
                                            state = upvalueValues[upvalues[12]]
                                            r20 = {
                                                state(r5)
                                            }
                                            ReturnVal = {
                                                unpack(r20)
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 61 then
                        if state <= 60 then
                            if state <= 54 then
                                -- createClosure5 entry 2995444 -> 51, states 51-54
                                if state <= 52 then
                                    if state <= 51 then
                                        if state == 51 then -- entry 2995444 -> 51
                                            state = 52
                                        end
                                    else
                                        if state == 52 then
                                            state = true
                                            state = state and (53) or (54)
                                        end
                                    end
                                else
                                    if state <= 53 then
                                        if state == 53 then
                                            ReturnVal = "l2"
                                            state = _env[ReturnVal]
                                            r5 = "l1"
                                            ReturnVal = _env[r5]
                                            r5 = "l1"
                                            _env[r5] = state
                                            r5 = "l2"
                                            _env[r5] = ReturnVal
                                            r5 = upvalueValues[upvalues[1]]
                                            r20 = r5()
                                            state = 52
                                        end
                                    else
                                        if state == 54 then
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            else
                                -- createClosure4 entry 654466 -> 55, states 55-60
                                if state <= 57 then
                                    if state <= 56 then
                                        if state <= 55 then
                                            if state == 55 then -- entry 654466 -> 55
                                                r5 = upvalueValues[upvalues[1]]
                                                ReturnVal = #r5
                                                r5 = 0
                                                state = ReturnVal == r5
                                                state = state and (56) or (57)
                                            end
                                        else
                                            if state == 56 then
                                                r20 = upvalueValues[upvalues[2]]
                                                r15 = 157
                                                r5 = r20 * r15
                                                r20 = 23559112207065
                                                ReturnVal = r5 + r20
                                                r5 = 35184372088832
                                                state = ReturnVal % r5
                                                upvalueValues[upvalues[2]] = state
                                                r5 = upvalueValues[upvalues[3]]
                                                r20 = 1
                                                ReturnVal = r5 ~= r20
                                                state = 58
                                            end
                                        end
                                    else
                                        if state == 57 then
                                            r15 = "table"
                                            r20 = _env[r15]
                                            r15 = "remove"
                                            r5 = r20[r15]
                                            r15 = upvalueValues[upvalues[1]]
                                            r20 = {
                                                r5(r15)
                                            }
                                            ReturnVal = {
                                                unpack(r20)
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    if state <= 59 then
                                        if state <= 58 then
                                            if state == 58 then
                                                r20 = upvalueValues[upvalues[3]]
                                                r15 = 201
                                                r5 = r20 * r15
                                                r20 = 257
                                                ReturnVal = r5 % r20
                                                upvalueValues[upvalues[3]] = ReturnVal
                                                state = 59
                                            end
                                        else
                                            if state == 59 then
                                                r20 = upvalueValues[upvalues[3]]
                                                r15 = 1
                                                r5 = r20 ~= r15
                                                state = r5 and (60) or (58)
                                            end
                                        end
                                    else
                                        if state == 60 then
                                            r20 = upvalueValues[upvalues[3]]
                                            r15 = 32
                                            r5 = r20 % r15
                                            r1 = upvalueValues[upvalues[4]]
                                            r22 = 2
                                            r23 = upvalueValues[upvalues[2]]
                                            r3 = upvalueValues[upvalues[3]]
                                            r19 = r3 - r5
                                            r3 = 32
                                            r13 = r19 / r3
                                            r31 = 13
                                            r30 = r31 - r13
                                            r16 = r22 ^ r30
                                            r10 = r23 / r16
                                            r2 = r1(r10)
                                            r1 = 4294967296
                                            r15 = r2 % r1
                                            r2 = 2
                                            r1 = r2 ^ r5
                                            r16 = 1
                                            r20 = r15 / r1
                                            r1 = upvalueValues[upvalues[4]]
                                            r23 = r20 % r16
                                            r16 = 4294967296
                                            r22 = 256
                                            r5 = nil
                                            r10 = r23 * r16
                                            r2 = r1(r10)
                                            r1 = upvalueValues[upvalues[4]]
                                            r10 = r1(r20)
                                            r15 = r2 + r10
                                            r23 = 65536
                                            r2 = 65536
                                            r1 = r15 % r2
                                            r31 = 256
                                            r20 = nil
                                            r10 = r15 - r1
                                            r2 = r10 / r23
                                            r23 = 256
                                            r10 = r1 % r23
                                            r16 = r1 - r10
                                            r23 = r16 / r22
                                            r22 = 256
                                            r16 = r2 % r22
                                            r30 = r2 - r16
                                            r22 = r30 / r31
                                            r2 = nil
                                            r1 = nil
                                            r30 = {
                                                r10,
                                                r23,
                                                r16,
                                                r22
                                            }
                                            r16 = nil
                                            r15 = nil
                                            r10 = nil
                                            r23 = nil
                                            upvalueValues[upvalues[1]] = r30
                                            r22 = nil
                                            state = 57
                                        end
                                    end
                                end
                            end
                        else
                            -- createClosure0 entry 7223449 -> 61, states 61-61
                            if state == 61 then -- entry 7223449 -> 61
                                ReturnVal = upvalueValues[upvalues[1]]
                                r5 = upvalueValues[upvalues[2]]
                                r1 = 19904155935796
                                r15 = "\187\020J\210"
                                r20 = r5(r15, r1)
                                state = ReturnVal[r20]
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        end
                    else
                        if state <= 68 then
                            -- createClosure6 entry 15736416 -> 62, states 62-68
                            if state <= 65 then
                                if state <= 63 then
                                    if state <= 62 then
                                        if state == 62 then -- entry 15736416 -> 62
                                            r20 = args[2]
                                            state = upvalueValues[upvalues[1]]
                                            r15 = state
                                            state = r15[r20]
                                            r5 = args[1]
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
                                            r1 = ReturnVal
                                            r2 = 35184372088832
                                            ReturnVal = r20 % r2
                                            upvalueValues[upvalues[4]] = ReturnVal
                                            r23 = 255
                                            r10 = r20 % r23
                                            r23 = 2
                                            r2 = r10 + r23
                                            upvalueValues[upvalues[5]] = r2
                                            r16 = "string"
                                            r23 = _env[r16]
                                            r16 = "len"
                                            r10 = r23[r16]
                                            r30 = 1
                                            r23 = r10(r5)
                                            r31 = r30
                                            r10 = ""
                                            r15[r20] = r10
                                            r30 = 0
                                            r13 = r31 < r30
                                            r16 = 1
                                            r30 = r16 - r31
                                            r22 = r23
                                            r10 = 191
                                            state = 66
                                        end
                                    else
                                        if state == 65 then
                                            ReturnVal = {
                                                r20
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            else
                                if state <= 67 then
                                    if state <= 66 then
                                        if state == 66 then
                                            r30 = r30 + r31
                                            r19 = not r13
                                            r16 = r30 <= r22
                                            r16 = r19 and r16
                                            r19 = r30 >= r22
                                            r19 = r13 and r19
                                            r16 = r19 or r16
                                            r19 = (67)
                                            state = r16 and r19
                                            r16 = (68)
                                            state = state or r16
                                        end
                                    else
                                        if state == 67 then
                                            r16 = r30
                                            r28 = "string"
                                            r6 = _env[r28]
                                            r28 = "byte"
                                            r26 = r6[r28]
                                            r6 = r26(r5, r16)
                                            r26 = upvalueValues[upvalues[6]]
                                            r28 = r26()
                                            r33 = r6 + r28
                                            r3 = r33 + r10
                                            r33 = 256
                                            r19 = r3 % r33
                                            r10 = r19
                                            r33 = r15[r20]
                                            r28 = 1
                                            r6 = r10 + r28
                                            r26 = r1[r6]
                                            r16 = nil
                                            r3 = r33 .. r26
                                            r15[r20] = r3
                                            state = 66
                                        end
                                    end
                                else
                                    if state == 68 then
                                        r23 = nil
                                        r10 = nil
                                        r1 = nil
                                        state = 65
                                    end
                                end
                            end
                        else
                            -- createClosure2 entry 16436759 -> 69, states 69-69
                            if state == 69 then -- entry 16436759 -> 69
                                r15 = 14089892
                                r20 = "twQ53l"
                                r5 = r20 ^ r15
                                ReturnVal = 5047976
                                state = ReturnVal - r5
                                r5 = state
                                ReturnVal = "kc"
                                state = ReturnVal / r5
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
                    return 2975506
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 2975506
                    end
                })
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
        createClosure1 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1)
                return vm(entryId, {
                    arg1
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
        upvalueValues = {}
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
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)