return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure1, vm, createUpvalueProxy, createClosure, currentUpvalueId, upvalueRefCounts, releaseUpvalue, upvalueValues, createClosure0, createClosure4, createClosure5, createClosure7, allocUpvalue, releaseUpvalues)
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, ReturnVal, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33
            while state do
                if state <= 46 then
                    if state <= 33 then
                        if state <= 32 then
                            if state <= 31 then
                                -- root entry 10137948 -> 1, states 1-31
                                if state <= 16 then
                                    if state <= 8 then
                                        if state <= 4 then
                                            if state <= 2 then
                                                if state <= 1 then
                                                    if state == 1 then -- entry 10137948 -> 1
                                                        r13 = allocUpvalue()
                                                        state = true
                                                        upvalueValues[r13] = state
                                                        r18 = "string"
                                                        ReturnVal = _env[r18]
                                                        r18 = "gmatch"
                                                        state = ReturnVal[r18]
                                                        r18 = allocUpvalue()
                                                        upvalueValues[r18] = state
                                                        r23 = allocUpvalue()
                                                        r5 = allocUpvalue()
                                                        state = createClosure4(32, {})
                                                        upvalueValues[r5] = state
                                                        state = false
                                                        upvalueValues[r23] = state
                                                        r31 = "pcall"
                                                        r32 = _env[r31]
                                                        r21 = createClosure0(33, {
                                                            r23
                                                        })
                                                        r31 = r32(r21)
                                                        state = r31 and (2) or (3)
                                                        r26 = args
                                                        ReturnVal = r31
                                                    end
                                                else
                                                    if state == 2 then
                                                        r32 = upvalueValues[r23]
                                                        ReturnVal = r32
                                                        state = 3
                                                    end
                                                end
                                            else
                                                if state <= 3 then
                                                    if state == 3 then
                                                        r32 = ReturnVal
                                                        r31 = "math"
                                                        ReturnVal = _env[r31]
                                                        r31 = "random"
                                                        state = ReturnVal[r31]
                                                        r31 = allocUpvalue()
                                                        upvalueValues[r31] = state
                                                        r21 = "table"
                                                        ReturnVal = _env[r21]
                                                        r21 = "concat"
                                                        state = ReturnVal[r21]
                                                        r21 = state
                                                        r17 = state
                                                        r27 = "table"
                                                        r8 = _env[r27]
                                                        state = r8 and (4) or (5)
                                                        r15 = r8
                                                    end
                                                else
                                                    if state == 4 then
                                                        r16 = "table"
                                                        r27 = _env[r16]
                                                        r16 = "unpack"
                                                        r8 = r27[r16]
                                                        r15 = r8
                                                        state = 5
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 6 then
                                                if state <= 5 then
                                                    if state == 5 then
                                                        state = r17
                                                        state = r15 and (6) or (7)
                                                        ReturnVal = r15
                                                    end
                                                else
                                                    if state == 6 then
                                                        r15 = allocUpvalue()
                                                        upvalueValues[r15] = ReturnVal
                                                        state = upvalueValues[r31]
                                                        r17 = 3
                                                        r8 = 65
                                                        ReturnVal = state(r17, r8)
                                                        r17 = allocUpvalue()
                                                        r6 = createClosure1(34, {})
                                                        upvalueValues[r17] = ReturnVal
                                                        state = 0
                                                        r16 = "pcall"
                                                        ReturnVal = _env[r16]
                                                        r16 = {
                                                            ReturnVal(r6)
                                                        }
                                                        r8 = state
                                                        state = 0
                                                        r27 = state
                                                        state = {
                                                            unpack(r16)
                                                        }
                                                        r16 = state
                                                        ReturnVal = 2
                                                        state = r16[ReturnVal]
                                                        r6 = state
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r33 = upvalueValues[r18]
                                                        r3 = "tostring"
                                                        r9 = _env[r3]
                                                        r3 = r9(r6)
                                                        r9 = ":(%d*):"
                                                        r4 = r33(r3, r9)
                                                        r33 = {
                                                            r4()
                                                        }
                                                        ReturnVal = state(unpack(r33))
                                                        r33 = allocUpvalue()
                                                        upvalueValues[r33] = ReturnVal
                                                        r4 = upvalueValues[r17]
                                                        r9 = r4
                                                        r4 = 1
                                                        r3 = r4
                                                        r4 = 0
                                                        r24 = r3 < r4
                                                        ReturnVal = 1
                                                        r4 = ReturnVal - r3
                                                        state = 8
                                                    end
                                                end
                                            else
                                                if state <= 7 then
                                                    if state == 7 then
                                                        r17 = "unpack"
                                                        r15 = _env[r17]
                                                        ReturnVal = r15
                                                        state = 6
                                                    end
                                                else
                                                    if state == 8 then
                                                        r4 = r4 + r3
                                                        ReturnVal = r4 <= r9
                                                        r14 = not r24
                                                        ReturnVal = r14 and ReturnVal
                                                        r14 = r4 >= r9
                                                        r14 = r24 and r14
                                                        ReturnVal = r14 or ReturnVal
                                                        r14 = (9)
                                                        state = ReturnVal and r14
                                                        ReturnVal = (10)
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
                                                        r14 = allocUpvalue()
                                                        upvalueValues[r14] = r4
                                                        r22 = "math"
                                                        ReturnVal = _env[r22]
                                                        r22 = "random"
                                                        state = ReturnVal[r22]
                                                        r30 = 100
                                                        r22 = 1
                                                        ReturnVal = state(r22, r30)
                                                        r22 = allocUpvalue()
                                                        upvalueValues[r22] = ReturnVal
                                                        state = upvalueValues[r31]
                                                        r7 = 255
                                                        r30 = 0
                                                        ReturnVal = state(r30, r7)
                                                        r30 = allocUpvalue()
                                                        upvalueValues[r30] = ReturnVal
                                                        state = upvalueValues[r31]
                                                        r2 = upvalueValues[r22]
                                                        r7 = 1
                                                        ReturnVal = state(r7, r2)
                                                        r7 = allocUpvalue()
                                                        upvalueValues[r7] = ReturnVal
                                                        ReturnVal = upvalueValues[r31]
                                                        r29 = 2
                                                        r20 = 1
                                                        r2 = ReturnVal(r20, r29)
                                                        ReturnVal = 1
                                                        state = r2 == ReturnVal
                                                        r2 = allocUpvalue()
                                                        upvalueValues[r2] = state
                                                        r10 = "tostring"
                                                        r25 = _env[r10]
                                                        r28 = upvalueValues[r31]
                                                        r19 = 10000
                                                        r1 = 0
                                                        r11 = {
                                                            r28(r1, r19)
                                                        }
                                                        r10 = r25(unpack(r11))
                                                        r25 = ":"
                                                        r12 = r10 .. r25
                                                        state = "gsub"
                                                        state = r6[state]
                                                        r29 = ":"
                                                        r20 = r29 .. r12
                                                        ReturnVal = ":(%d*):"
                                                        state = state(r6, ReturnVal, r20)
                                                        r20 = allocUpvalue()
                                                        upvalueValues[r20] = state
                                                        r29 = "pcall"
                                                        ReturnVal = _env[r29]
                                                        r12 = createClosure4(35, {
                                                            r31,
                                                            r14,
                                                            r17,
                                                            r18,
                                                            r13,
                                                            r33,
                                                            r2,
                                                            r20,
                                                            r22,
                                                            r7,
                                                            r30,
                                                            r15
                                                        })
                                                        r29 = {
                                                            ReturnVal(r12)
                                                        }
                                                        state = {
                                                            unpack(r29)
                                                        }
                                                        r29 = state
                                                        state = upvalueValues[r2]
                                                        state = state and (11) or (12)
                                                    end
                                                else
                                                    if state == 10 then
                                                        r9 = upvalueValues[r13]
                                                        state = r9 and (13) or (14)
                                                        r4 = r9
                                                    end
                                                end
                                            else
                                                if state <= 11 then
                                                    if state == 11 then
                                                        r12 = upvalueValues[r13]
                                                        state = r12 and (15) or (16)
                                                        ReturnVal = r12
                                                    end
                                                else
                                                    if state == 12 then
                                                        r25 = upvalueValues[r13]
                                                        state = r25 and (17) or (18)
                                                        r12 = r25
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 14 then
                                                if state <= 13 then
                                                    if state == 13 then
                                                        r9 = r8 == r27
                                                        r4 = r9
                                                        state = 14
                                                    end
                                                else
                                                    if state == 14 then
                                                        upvalueValues[r13] = r4
                                                        state = upvalueValues[r13]
                                                        state = state and (19) or (20)
                                                    end
                                                end
                                            else
                                                if state <= 15 then
                                                    if state == 15 then
                                                        r25 = state
                                                        r11 = 1
                                                        r28 = r29[r11]
                                                        r11 = false
                                                        r10 = r28 == r11
                                                        state = r10 and (21) or (22)
                                                        r12 = r10
                                                    end
                                                else
                                                    if state == 16 then
                                                        upvalueValues[r13] = ReturnVal
                                                        state = 23
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
                                                        r10 = 1
                                                        r25 = r29[r10]
                                                        r12 = r25
                                                        state = 18
                                                    end
                                                else
                                                    if state == 18 then
                                                        upvalueValues[r13] = r12
                                                        r11 = upvalueValues[r7]
                                                        r1 = 1
                                                        r28 = r11 + r1
                                                        r10 = r29[r28]
                                                        r25 = r8 + r10
                                                        r10 = 256
                                                        state = r25 % r10
                                                        r8 = state
                                                        r28 = upvalueValues[r30]
                                                        r10 = r27 + r28
                                                        r28 = 256
                                                        r25 = r10 % r28
                                                        r27 = r25
                                                        state = 23
                                                    end
                                                end
                                            else
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
                                            end
                                        else
                                            if state <= 22 then
                                                if state <= 21 then
                                                    if state == 21 then
                                                        r11 = 2
                                                        r28 = r29[r11]
                                                        r11 = upvalueValues[r20]
                                                        r10 = r28 == r11
                                                        r12 = r10
                                                        state = 22
                                                    end
                                                else
                                                    if state == 22 then
                                                        state = r25
                                                        ReturnVal = r12
                                                        state = 16
                                                    end
                                                end
                                            else
                                                if state <= 23 then
                                                    if state == 23 then
                                                        r14 = releaseUpvalue(r14)
                                                        r7 = releaseUpvalue(r7)
                                                        r22 = releaseUpvalue(r22)
                                                        r20 = releaseUpvalue(r20)
                                                        r29 = nil
                                                        r2 = releaseUpvalue(r2)
                                                        r30 = releaseUpvalue(r30)
                                                        state = 8
                                                    end
                                                else
                                                    if state == 24 then
                                                        r8 = nil
                                                        r31 = releaseUpvalue(r31)
                                                        r33 = releaseUpvalue(r33)
                                                        r18 = releaseUpvalue(r18)
                                                        r5 = releaseUpvalue(r5)
                                                        r16 = nil
                                                        r6 = nil
                                                        r17 = releaseUpvalue(r17)
                                                        r23 = releaseUpvalue(r23)
                                                        r13 = releaseUpvalue(r13)
                                                        r27 = nil
                                                        r18 = nil
                                                        r21 = nil
                                                        r32 = nil
                                                        r13 = nil
                                                        r15 = releaseUpvalue(r15)
                                                        r17 = allocUpvalue()
                                                        r32 = "math"
                                                        r23 = _env[r32]
                                                        r32 = "floor"
                                                        r5 = r23[r32]
                                                        r23 = allocUpvalue()
                                                        upvalueValues[r23] = r5
                                                        r31 = "math"
                                                        r32 = _env[r31]
                                                        r31 = "random"
                                                        r5 = r32[r31]
                                                        r21 = "table"
                                                        r31 = _env[r21]
                                                        r8 = {}
                                                        r27 = allocUpvalue()
                                                        r21 = "remove"
                                                        r32 = r31[r21]
                                                        r15 = "string"
                                                        r21 = _env[r15]
                                                        r15 = "char"
                                                        r31 = r21[r15]
                                                        r15 = allocUpvalue()
                                                        r21 = 0
                                                        upvalueValues[r15] = r21
                                                        r21 = 2
                                                        upvalueValues[r17] = r21
                                                        r21 = {}
                                                        r33 = 256
                                                        upvalueValues[r27] = r8
                                                        r24 = r33
                                                        r33 = 1
                                                        r14 = r33
                                                        r33 = 0
                                                        r22 = r14 < r33
                                                        r6 = 1
                                                        r33 = r6 - r14
                                                        r16 = {}
                                                        r8 = 0
                                                        state = 26
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 28 then
                                            if state <= 26 then
                                                if state <= 25 then
                                                    if state == 25 then
                                                        state = createClosure5(47, {
                                                            r5
                                                        })
                                                        r9 = {
                                                            state()
                                                        }
                                                        ReturnVal = {
                                                            unpack(r9)
                                                        }
                                                        state = nil
                                                    end
                                                else
                                                    if state == 26 then
                                                        r30 = not r22
                                                        r33 = r33 + r14
                                                        r6 = r33 <= r24
                                                        r6 = r30 and r6
                                                        r30 = r33 >= r24
                                                        r30 = r22 and r30
                                                        r6 = r30 or r6
                                                        r30 = (27)
                                                        state = r6 and r30
                                                        r6 = (28)
                                                        state = state or r6
                                                    end
                                                end
                                            else
                                                if state <= 27 then
                                                    if state == 27 then
                                                        r6 = r33
                                                        r30 = r6
                                                        r16[r6] = r30
                                                        r6 = nil
                                                        state = 26
                                                    end
                                                else
                                                    if state == 28 then
                                                        r33 = #r16
                                                        r24 = 0
                                                        r6 = r33 == r24
                                                        state = 29
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 30 then
                                                if state <= 29 then
                                                    if state == 29 then
                                                        r33 = 1
                                                        r24 = #r16
                                                        r6 = r5(r33, r24)
                                                        r33 = r32(r16, r6)
                                                        r24 = upvalueValues[r27]
                                                        r30 = 1
                                                        r22 = r33 - r30
                                                        r6 = nil
                                                        r14 = r31(r22)
                                                        r24[r33] = r14
                                                        r33 = nil
                                                        state = 30
                                                    end
                                                else
                                                    if state == 30 then
                                                        r33 = #r16
                                                        r24 = 0
                                                        r6 = r33 == r24
                                                        state = r6 and (31) or (29)
                                                    end
                                                end
                                            else
                                                if state == 31 then
                                                    r8 = nil
                                                    r6 = {}
                                                    r33 = allocUpvalue()
                                                    upvalueValues[r33] = r6
                                                    r24 = createClosure4(51, {
                                                        r33,
                                                        r15,
                                                        r17,
                                                        r23
                                                    })
                                                    r6 = allocUpvalue()
                                                    r30 = {}
                                                    r23 = releaseUpvalue(r23)
                                                    upvalueValues[r6] = r24
                                                    r5 = nil
                                                    r21 = nil
                                                    r29 = "__metatable"
                                                    r31 = nil
                                                    r10 = nil
                                                    r14 = allocUpvalue()
                                                    r24 = {}
                                                    upvalueValues[r14] = r24
                                                    r16 = nil
                                                    r22 = "setmetatable"
                                                    r24 = _env[r22]
                                                    r20 = upvalueValues[r14]
                                                    r2 = "__index"
                                                    r7 = {
                                                        [r2] = r20,
                                                        [r29] = r10
                                                    }
                                                    r22 = r24(r30, r7)
                                                    r13 = r22
                                                    r24 = createClosure7(57, {
                                                        r14,
                                                        r33,
                                                        r27,
                                                        r15,
                                                        r17,
                                                        r6
                                                    })
                                                    r14 = releaseUpvalue(r14)
                                                    r18 = r24
                                                    r27 = releaseUpvalue(r27)
                                                    r23 = "loadstring"
                                                    r5 = _env[r23]
                                                    r17 = releaseUpvalue(r17)
                                                    r6 = releaseUpvalue(r6)
                                                    r31 = "game"
                                                    r32 = nil
                                                    r32 = _env[r31]
                                                    r33 = releaseUpvalue(r33)
                                                    r15 = releaseUpvalue(r15)
                                                    r8 = 27203652530555
                                                    r17 = "u\"\203\180\254cD\249bG\157\128V\164w\232V\149O\132\138\220\214\235M\225G\128\207\164\165\135`uVA\222x\187\224\020\175\191\226\128\193\014\162\179\021@\191\206\236\146\165\136\018*1\184\162x\t*\167c\184n\028\t\178\132\234\003\252\225\012JrK\235#9\156\029\204\014\167n\245\198\182"
                                                    r15 = r18(r17, r8)
                                                    r18 = nil
                                                    r21 = r13[r15]
                                                    r15 = "HttpGet"
                                                    r15 = r32[r15]
                                                    r13 = nil
                                                    ReturnVal = {}
                                                    r31 = {
                                                        r15(r32, r21)
                                                    }
                                                    r23 = r5(unpack(r31))
                                                    r5 = r23()
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure4 entry 7681906 -> 32, states 32-32
                                if state == 32 then -- entry 7681906 -> 32
                                    ReturnVal = "error"
                                    state = _env[ReturnVal]
                                    r26 = "Tamper Detected!"
                                    ReturnVal = state(r26)
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            -- createClosure0 entry 2656902 -> 33, states 33-33
                            if state == 33 then -- entry 2656902 -> 33
                                state = true
                                upvalueValues[upvalues[1]] = state
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    else
                        if state <= 34 then
                            -- createClosure1 entry 9028751 -> 34, states 34-34
                            if state == 34 then -- entry 9028751 -> 34
                                r13 = "3MTmCeNKe0Wttq"
                                r18 = 16522817
                                r26 = r13 ^ r18
                                ReturnVal = 14700949
                                state = ReturnVal - r26
                                r26 = state
                                ReturnVal = "SI"
                                state = ReturnVal / r26
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        else
                            -- createClosure4 entry 6707526 -> 35, states 35-46
                            if state <= 40 then
                                if state <= 37 then
                                    if state <= 36 then
                                        if state <= 35 then
                                            if state == 35 then -- entry 6707526 -> 35
                                                r13 = upvalueValues[upvalues[1]]
                                                r23 = 2
                                                r5 = 1
                                                r18 = r13(r5, r23)
                                                r13 = 1
                                                r26 = r18 == r13
                                                state = r26 and (36) or (37)
                                                ReturnVal = r26
                                            end
                                        else
                                            if state == 36 then
                                                state = ReturnVal and (38) or (39)
                                            end
                                        end
                                    else
                                        if state == 37 then
                                            r13 = upvalueValues[upvalues[2]]
                                            r18 = upvalueValues[upvalues[3]]
                                            r26 = r13 == r18
                                            ReturnVal = r26
                                            state = 36
                                        end
                                    end
                                else
                                    if state <= 39 then
                                        if state <= 38 then
                                            if state == 38 then
                                                ReturnVal = "tonumber"
                                                state = _env[ReturnVal]
                                                r26 = upvalueValues[upvalues[4]]
                                                r15 = createClosure1(64, {})
                                                r5 = "tostring"
                                                r18 = _env[r5]
                                                r21 = "pcall"
                                                r31 = _env[r21]
                                                r21 = {
                                                    r31(r15)
                                                }
                                                r32 = {
                                                    unpack(r21)
                                                }
                                                r31 = 2
                                                r23 = r32[r31]
                                                r5 = r18(r23)
                                                r18 = ":(%d*):"
                                                r13 = r26(r5, r18)
                                                r26 = {
                                                    r13()
                                                }
                                                ReturnVal = state(unpack(r26))
                                                r26 = ReturnVal
                                                r13 = upvalueValues[upvalues[5]]
                                                state = r13 and (40) or (41)
                                                ReturnVal = r13
                                            end
                                        else
                                            if state == 39 then
                                                state = upvalueValues[upvalues[7]]
                                                state = state and (42) or (43)
                                            end
                                        end
                                    else
                                        if state == 40 then
                                            r18 = upvalueValues[upvalues[6]]
                                            r13 = r18 == r26
                                            ReturnVal = r13
                                            state = 41
                                        end
                                    end
                                end
                            else
                                if state <= 43 then
                                    if state <= 42 then
                                        if state <= 41 then
                                            if state == 41 then
                                                r26 = nil
                                                upvalueValues[upvalues[5]] = ReturnVal
                                                state = 39
                                            end
                                        else
                                            if state == 42 then
                                                r26 = "error"
                                                state = _env[r26]
                                                r13 = upvalueValues[upvalues[8]]
                                                r18 = 0
                                                r26 = state(r13, r18)
                                                state = 43
                                            end
                                        end
                                    else
                                        if state == 43 then
                                            state = {}
                                            r26 = state
                                            r18 = upvalueValues[upvalues[9]]
                                            r5 = r18
                                            r18 = 1
                                            r23 = r18
                                            r18 = 0
                                            r32 = r23 < r18
                                            r13 = 1
                                            r18 = r13 - r23
                                            state = 44
                                        end
                                    end
                                else
                                    if state <= 45 then
                                        if state <= 44 then
                                            if state == 44 then
                                                r31 = not r32
                                                r18 = r18 + r23
                                                r13 = r18 <= r5
                                                r13 = r31 and r13
                                                r31 = r18 >= r5
                                                r31 = r32 and r31
                                                r13 = r31 or r13
                                                r31 = (45)
                                                state = r13 and r31
                                                r13 = (46)
                                                state = state or r13
                                            end
                                        else
                                            if state == 45 then
                                                r13 = r18
                                                state = upvalueValues[upvalues[1]]
                                                r15 = 255
                                                r21 = 0
                                                r31 = state(r21, r15)
                                                r26[r13] = r31
                                                r13 = nil
                                                state = 44
                                            end
                                        end
                                    else
                                        if state == 46 then
                                            state = upvalueValues[upvalues[10]]
                                            r13 = upvalueValues[upvalues[11]]
                                            r26[state] = r13
                                            state = upvalueValues[upvalues[12]]
                                            r13 = {
                                                state(r26)
                                            }
                                            ReturnVal = {
                                                unpack(r13)
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 56 then
                        if state <= 50 then
                            -- createClosure5 entry 15290900 -> 47, states 47-50
                            if state <= 48 then
                                if state <= 47 then
                                    if state == 47 then -- entry 15290900 -> 47
                                        state = 48
                                    end
                                else
                                    if state == 48 then
                                        state = true
                                        state = state and (49) or (50)
                                    end
                                end
                            else
                                if state <= 49 then
                                    if state == 49 then
                                        ReturnVal = "l2"
                                        state = _env[ReturnVal]
                                        r26 = "l1"
                                        ReturnVal = _env[r26]
                                        r26 = "l1"
                                        _env[r26] = state
                                        r26 = "l2"
                                        _env[r26] = ReturnVal
                                        r26 = upvalueValues[upvalues[1]]
                                        r13 = r26()
                                        state = 48
                                    end
                                else
                                    if state == 50 then
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        else
                            -- createClosure4 entry 609384 -> 51, states 51-56
                            if state <= 53 then
                                if state <= 52 then
                                    if state <= 51 then
                                        if state == 51 then -- entry 609384 -> 51
                                            r26 = upvalueValues[upvalues[1]]
                                            ReturnVal = #r26
                                            r26 = 0
                                            state = ReturnVal == r26
                                            state = state and (52) or (53)
                                        end
                                    else
                                        if state == 52 then
                                            r13 = upvalueValues[upvalues[2]]
                                            r18 = 213
                                            r26 = r13 * r18
                                            r13 = 5580491033127
                                            ReturnVal = r26 + r13
                                            r26 = 35184372088832
                                            state = ReturnVal % r26
                                            upvalueValues[upvalues[2]] = state
                                            r26 = upvalueValues[upvalues[3]]
                                            r13 = 1
                                            ReturnVal = r26 ~= r13
                                            state = 54
                                        end
                                    end
                                else
                                    if state == 53 then
                                        r18 = "table"
                                        r13 = _env[r18]
                                        r18 = "remove"
                                        r26 = r13[r18]
                                        r18 = upvalueValues[upvalues[1]]
                                        r13 = {
                                            r26(r18)
                                        }
                                        ReturnVal = {
                                            unpack(r13)
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 55 then
                                    if state <= 54 then
                                        if state == 54 then
                                            r13 = upvalueValues[upvalues[3]]
                                            r18 = 247
                                            r26 = r13 * r18
                                            r13 = 257
                                            ReturnVal = r26 % r13
                                            upvalueValues[upvalues[3]] = ReturnVal
                                            state = 55
                                        end
                                    else
                                        if state == 55 then
                                            r13 = upvalueValues[upvalues[3]]
                                            r18 = 1
                                            r26 = r13 ~= r18
                                            state = r26 and (56) or (54)
                                        end
                                    end
                                else
                                    if state == 56 then
                                        r13 = upvalueValues[upvalues[3]]
                                        r18 = 32
                                        r15 = 2
                                        r26 = r13 % r18
                                        r5 = upvalueValues[upvalues[4]]
                                        r31 = upvalueValues[upvalues[2]]
                                        r6 = upvalueValues[upvalues[3]]
                                        r16 = r6 - r26
                                        r6 = 32
                                        r27 = r16 / r6
                                        r8 = 13
                                        r17 = r8 - r27
                                        r21 = r15 ^ r17
                                        r32 = r31 / r21
                                        r21 = 1
                                        r23 = r5(r32)
                                        r5 = 4294967296
                                        r18 = r23 % r5
                                        r23 = 2
                                        r5 = r23 ^ r26
                                        r13 = r18 / r5
                                        r5 = upvalueValues[upvalues[4]]
                                        r26 = nil
                                        r31 = r13 % r21
                                        r21 = 4294967296
                                        r32 = r31 * r21
                                        r15 = 256
                                        r23 = r5(r32)
                                        r5 = upvalueValues[upvalues[4]]
                                        r32 = r5(r13)
                                        r13 = nil
                                        r31 = 65536
                                        r18 = r23 + r32
                                        r23 = 65536
                                        r5 = r18 % r23
                                        r32 = r18 - r5
                                        r23 = r32 / r31
                                        r8 = 256
                                        r31 = 256
                                        r18 = nil
                                        r32 = r5 % r31
                                        r21 = r5 - r32
                                        r31 = r21 / r15
                                        r15 = 256
                                        r21 = r23 % r15
                                        r17 = r23 - r21
                                        r15 = r17 / r8
                                        r5 = nil
                                        r17 = {
                                            r32,
                                            r31,
                                            r21,
                                            r15
                                        }
                                        r15 = nil
                                        r31 = nil
                                        upvalueValues[upvalues[1]] = r17
                                        r21 = nil
                                        r23 = nil
                                        r32 = nil
                                        state = 53
                                    end
                                end
                            end
                        end
                    else
                        if state <= 63 then
                            -- createClosure7 entry 7591697 -> 57, states 57-63
                            if state <= 60 then
                                if state <= 58 then
                                    if state <= 57 then
                                        if state == 57 then -- entry 7591697 -> 57
                                            state = upvalueValues[upvalues[1]]
                                            r18 = state
                                            r26 = args[1]
                                            r13 = args[2]
                                            state = r18[r13]
                                            state = state and (58) or (59)
                                        end
                                    else
                                        if state == 58 then
                                            state = 60
                                        end
                                    end
                                else
                                    if state <= 59 then
                                        if state == 59 then
                                            state = {}
                                            upvalueValues[upvalues[2]] = state
                                            ReturnVal = upvalueValues[upvalues[3]]
                                            r5 = ReturnVal
                                            r23 = 35184372088832
                                            ReturnVal = r13 % r23
                                            upvalueValues[upvalues[4]] = ReturnVal
                                            r31 = 255
                                            r32 = r13 % r31
                                            r31 = 2
                                            r23 = r32 + r31
                                            upvalueValues[upvalues[5]] = r23
                                            r21 = "string"
                                            r31 = _env[r21]
                                            r17 = 1
                                            r21 = "len"
                                            r32 = r31[r21]
                                            r31 = r32(r26)
                                            r8 = r17
                                            r32 = ""
                                            r18[r13] = r32
                                            r17 = 0
                                            r27 = r8 < r17
                                            r21 = 1
                                            r17 = r21 - r8
                                            r15 = r31
                                            r32 = 227
                                            state = 61
                                        end
                                    else
                                        if state == 60 then
                                            ReturnVal = {
                                                r13
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            else
                                if state <= 62 then
                                    if state <= 61 then
                                        if state == 61 then
                                            r16 = not r27
                                            r17 = r17 + r8
                                            r21 = r17 <= r15
                                            r21 = r16 and r21
                                            r16 = r17 >= r15
                                            r16 = r27 and r16
                                            r21 = r16 or r21
                                            r16 = (62)
                                            state = r21 and r16
                                            r21 = (63)
                                            state = state or r21
                                        end
                                    else
                                        if state == 62 then
                                            r21 = r17
                                            r3 = "string"
                                            r9 = _env[r3]
                                            r3 = "byte"
                                            r4 = r9[r3]
                                            r9 = r4(r26, r21)
                                            r21 = nil
                                            r4 = upvalueValues[upvalues[6]]
                                            r3 = r4()
                                            r33 = r9 + r3
                                            r6 = r33 + r32
                                            r33 = 256
                                            r16 = r6 % r33
                                            r32 = r16
                                            r33 = r18[r13]
                                            r3 = 1
                                            r9 = r32 + r3
                                            r4 = r5[r9]
                                            r6 = r33 .. r4
                                            r18[r13] = r6
                                            state = 61
                                        end
                                    end
                                else
                                    if state == 63 then
                                        r31 = nil
                                        r32 = nil
                                        r5 = nil
                                        state = 60
                                    end
                                end
                            end
                        else
                            -- createClosure1 entry 6685471 -> 64, states 64-64
                            if state == 64 then -- entry 6685471 -> 64
                                r13 = "jhpupz06L2MS"
                                r18 = 11732242
                                r26 = r13 ^ r18
                                ReturnVal = 8576234
                                state = ReturnVal - r26
                                r26 = state
                                ReturnVal = "qEvNpn"
                                state = ReturnVal / r26
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
        createClosure1 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1)
                return vm(entryId, {
                    arg1
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 2569878
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 2569878
                    end
                })
            end
        end
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        upvalueRefCounts = {}
        createClosure = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(...)
                return vm(entryId, {
                    ...
                }, captures, gcProxy)
            end
            return closure
        end
        currentUpvalueId = 0
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
        upvalueValues = {}
        createClosure7 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
                return vm(entryId, {
                    arg1,
                    arg2,
                    arg3,
                    arg4,
                    arg5,
                    arg6,
                    arg7
                }, captures, gcProxy)
            end
            return closure
        end
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)