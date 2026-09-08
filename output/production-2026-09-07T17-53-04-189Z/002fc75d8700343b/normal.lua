return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure2, createClosure3, currentUpvalueId, createClosure4, createClosure5, createUpvalueProxy, createClosure6, createClosure, createClosure0, releaseUpvalues, upvalueValues, upvalueRefCounts, allocUpvalue, releaseUpvalue, vm)
        upvalueValues = {}
        currentUpvalueId = 0
        upvalueRefCounts = {}
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
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, ReturnVal, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33
            while state do
                if state <= 56 then
                    if state <= 34 then
                        if state <= 32 then
                            if state <= 31 then
                                -- root entry 15189199 -> 1, states 1-31
                                if state <= 16 then
                                    if state <= 8 then
                                        if state <= 4 then
                                            if state <= 2 then
                                                if state <= 1 then
                                                    if state == 1 then -- entry 15189199 -> 1
                                                        r9 = allocUpvalue()
                                                        r12 = allocUpvalue()
                                                        r20 = allocUpvalue()
                                                        state = true
                                                        upvalueValues[r12] = state
                                                        r11 = "string"
                                                        ReturnVal = _env[r11]
                                                        r11 = "gmatch"
                                                        state = ReturnVal[r11]
                                                        r11 = allocUpvalue()
                                                        upvalueValues[r11] = state
                                                        state = createClosure5(32, {})
                                                        upvalueValues[r20] = state
                                                        state = false
                                                        upvalueValues[r9] = state
                                                        r7 = createClosure3(33, {
                                                            r9
                                                        })
                                                        r22 = "pcall"
                                                        r27 = _env[r22]
                                                        r22 = r27(r7)
                                                        state = r22 and (2) or (3)
                                                        r5 = args
                                                        ReturnVal = r22
                                                    end
                                                else
                                                    if state == 2 then
                                                        r27 = upvalueValues[r9]
                                                        ReturnVal = r27
                                                        state = 3
                                                    end
                                                end
                                            else
                                                if state <= 3 then
                                                    if state == 3 then
                                                        r27 = ReturnVal
                                                        r22 = "math"
                                                        ReturnVal = _env[r22]
                                                        r22 = "random"
                                                        state = ReturnVal[r22]
                                                        r22 = allocUpvalue()
                                                        upvalueValues[r22] = state
                                                        r7 = "table"
                                                        ReturnVal = _env[r7]
                                                        r7 = "concat"
                                                        state = ReturnVal[r7]
                                                        r7 = state
                                                        r8 = state
                                                        r25 = "table"
                                                        r30 = _env[r25]
                                                        state = r30 and (4) or (5)
                                                        r15 = r30
                                                    end
                                                else
                                                    if state == 4 then
                                                        r17 = "table"
                                                        r25 = _env[r17]
                                                        r17 = "unpack"
                                                        r30 = r25[r17]
                                                        r15 = r30
                                                        state = 5
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 6 then
                                                if state <= 5 then
                                                    if state == 5 then
                                                        state = r8
                                                        state = r15 and (6) or (7)
                                                        ReturnVal = r15
                                                    end
                                                else
                                                    if state == 6 then
                                                        r15 = allocUpvalue()
                                                        upvalueValues[r15] = ReturnVal
                                                        state = upvalueValues[r22]
                                                        r8 = 3
                                                        r30 = 65
                                                        ReturnVal = state(r8, r30)
                                                        r13 = createClosure2(34, {})
                                                        r8 = allocUpvalue()
                                                        upvalueValues[r8] = ReturnVal
                                                        state = 0
                                                        r17 = "pcall"
                                                        ReturnVal = _env[r17]
                                                        r17 = {
                                                            ReturnVal(r13)
                                                        }
                                                        r30 = state
                                                        state = 0
                                                        r25 = state
                                                        state = {
                                                            unpack(r17)
                                                        }
                                                        r17 = state
                                                        ReturnVal = 2
                                                        state = r17[ReturnVal]
                                                        r13 = state
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r4 = upvalueValues[r11]
                                                        r32 = "tostring"
                                                        r21 = _env[r32]
                                                        r32 = r21(r13)
                                                        r21 = ":(%d*):"
                                                        r2 = r4(r32, r21)
                                                        r4 = {
                                                            r2()
                                                        }
                                                        ReturnVal = state(unpack(r4))
                                                        r4 = allocUpvalue()
                                                        upvalueValues[r4] = ReturnVal
                                                        r2 = upvalueValues[r8]
                                                        r21 = r2
                                                        r2 = 1
                                                        r32 = r2
                                                        r2 = 0
                                                        r19 = r32 < r2
                                                        ReturnVal = 1
                                                        r2 = ReturnVal - r32
                                                        state = 8
                                                    end
                                                end
                                            else
                                                if state <= 7 then
                                                    if state == 7 then
                                                        r8 = "unpack"
                                                        r15 = _env[r8]
                                                        ReturnVal = r15
                                                        state = 6
                                                    end
                                                else
                                                    if state == 8 then
                                                        r2 = r2 + r32
                                                        ReturnVal = r2 <= r21
                                                        r29 = not r19
                                                        ReturnVal = r29 and ReturnVal
                                                        r29 = r2 >= r21
                                                        r29 = r19 and r29
                                                        ReturnVal = r29 or ReturnVal
                                                        r29 = (9)
                                                        state = ReturnVal and r29
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
                                                        r29 = allocUpvalue()
                                                        upvalueValues[r29] = r2
                                                        r14 = "math"
                                                        ReturnVal = _env[r14]
                                                        r14 = "random"
                                                        state = ReturnVal[r14]
                                                        r1 = 100
                                                        r14 = 1
                                                        ReturnVal = state(r14, r1)
                                                        r14 = allocUpvalue()
                                                        upvalueValues[r14] = ReturnVal
                                                        state = upvalueValues[r22]
                                                        r16 = 255
                                                        r1 = 0
                                                        ReturnVal = state(r1, r16)
                                                        r1 = allocUpvalue()
                                                        upvalueValues[r1] = ReturnVal
                                                        state = upvalueValues[r22]
                                                        r18 = upvalueValues[r14]
                                                        r16 = 1
                                                        ReturnVal = state(r16, r18)
                                                        r16 = allocUpvalue()
                                                        upvalueValues[r16] = ReturnVal
                                                        ReturnVal = upvalueValues[r22]
                                                        r3 = 1
                                                        r28 = 2
                                                        r18 = ReturnVal(r3, r28)
                                                        ReturnVal = 1
                                                        state = r18 == ReturnVal
                                                        r18 = allocUpvalue()
                                                        upvalueValues[r18] = state
                                                        r23 = "tostring"
                                                        r24 = _env[r23]
                                                        r26 = upvalueValues[r22]
                                                        r6 = 10000
                                                        r10 = 0
                                                        r31 = {
                                                            r26(r10, r6)
                                                        }
                                                        r23 = r24(unpack(r31))
                                                        r24 = ":"
                                                        r33 = r23 .. r24
                                                        r28 = ":"
                                                        r3 = r28 .. r33
                                                        state = "gsub"
                                                        state = r13[state]
                                                        ReturnVal = ":(%d*):"
                                                        state = state(r13, ReturnVal, r3)
                                                        r3 = allocUpvalue()
                                                        upvalueValues[r3] = state
                                                        r33 = createClosure4(35, {
                                                            r22,
                                                            r29,
                                                            r8,
                                                            r11,
                                                            r12,
                                                            r4,
                                                            r18,
                                                            r3,
                                                            r14,
                                                            r16,
                                                            r1,
                                                            r15
                                                        })
                                                        r28 = "pcall"
                                                        ReturnVal = _env[r28]
                                                        r28 = {
                                                            ReturnVal(r33)
                                                        }
                                                        state = {
                                                            unpack(r28)
                                                        }
                                                        r28 = state
                                                        state = upvalueValues[r18]
                                                        state = state and (11) or (12)
                                                    end
                                                else
                                                    if state == 10 then
                                                        r21 = upvalueValues[r12]
                                                        state = r21 and (13) or (14)
                                                        r2 = r21
                                                    end
                                                end
                                            else
                                                if state <= 11 then
                                                    if state == 11 then
                                                        r33 = upvalueValues[r12]
                                                        state = r33 and (15) or (16)
                                                        ReturnVal = r33
                                                    end
                                                else
                                                    if state == 12 then
                                                        r24 = upvalueValues[r12]
                                                        state = r24 and (17) or (18)
                                                        r33 = r24
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 14 then
                                                if state <= 13 then
                                                    if state == 13 then
                                                        r21 = r30 == r25
                                                        r2 = r21
                                                        state = 14
                                                    end
                                                else
                                                    if state == 14 then
                                                        upvalueValues[r12] = r2
                                                        state = upvalueValues[r12]
                                                        state = state and (19) or (20)
                                                    end
                                                end
                                            else
                                                if state <= 15 then
                                                    if state == 15 then
                                                        r24 = state
                                                        r31 = 1
                                                        r26 = r28[r31]
                                                        r31 = false
                                                        r23 = r26 == r31
                                                        state = r23 and (21) or (22)
                                                        r33 = r23
                                                    end
                                                else
                                                    if state == 16 then
                                                        upvalueValues[r12] = ReturnVal
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
                                                        r23 = 1
                                                        r24 = r28[r23]
                                                        r33 = r24
                                                        state = 18
                                                    end
                                                else
                                                    if state == 18 then
                                                        upvalueValues[r12] = r33
                                                        r31 = upvalueValues[r16]
                                                        r10 = 1
                                                        r26 = r31 + r10
                                                        r23 = r28[r26]
                                                        r24 = r30 + r23
                                                        r23 = 256
                                                        state = r24 % r23
                                                        r30 = state
                                                        r26 = upvalueValues[r1]
                                                        r23 = r25 + r26
                                                        r26 = 256
                                                        r24 = r23 % r26
                                                        r25 = r24
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
                                                        r31 = 2
                                                        r26 = r28[r31]
                                                        r31 = upvalueValues[r3]
                                                        r23 = r26 == r31
                                                        r33 = r23
                                                        state = 22
                                                    end
                                                else
                                                    if state == 22 then
                                                        state = r24
                                                        ReturnVal = r33
                                                        state = 16
                                                    end
                                                end
                                            else
                                                if state <= 23 then
                                                    if state == 23 then
                                                        r16 = releaseUpvalue(r16)
                                                        r3 = releaseUpvalue(r3)
                                                        r1 = releaseUpvalue(r1)
                                                        r28 = nil
                                                        r18 = releaseUpvalue(r18)
                                                        r14 = releaseUpvalue(r14)
                                                        r29 = releaseUpvalue(r29)
                                                        state = 8
                                                    end
                                                else
                                                    if state == 24 then
                                                        r11 = releaseUpvalue(r11)
                                                        r15 = releaseUpvalue(r15)
                                                        r8 = releaseUpvalue(r8)
                                                        r20 = releaseUpvalue(r20)
                                                        r9 = releaseUpvalue(r9)
                                                        r20 = allocUpvalue()
                                                        r12 = releaseUpvalue(r12)
                                                        r12 = nil
                                                        upvalueValues[r20] = r12
                                                        r4 = releaseUpvalue(r4)
                                                        r22 = releaseUpvalue(r22)
                                                        r12 = allocUpvalue()
                                                        r11 = nil
                                                        upvalueValues[r12] = r11
                                                        r27 = nil
                                                        r27 = "math"
                                                        r9 = _env[r27]
                                                        r27 = "floor"
                                                        r11 = r9[r27]
                                                        r9 = allocUpvalue()
                                                        upvalueValues[r9] = r11
                                                        r30 = nil
                                                        r30 = {}
                                                        r22 = "math"
                                                        r27 = _env[r22]
                                                        r22 = "random"
                                                        r11 = r27[r22]
                                                        r7 = nil
                                                        r7 = "table"
                                                        r22 = _env[r7]
                                                        r17 = nil
                                                        r17 = {}
                                                        r7 = "remove"
                                                        r27 = r22[r7]
                                                        r15 = "string"
                                                        r7 = _env[r15]
                                                        r8 = allocUpvalue()
                                                        r15 = "char"
                                                        r22 = r7[r15]
                                                        r25 = nil
                                                        r25 = allocUpvalue()
                                                        r15 = allocUpvalue()
                                                        r7 = 0
                                                        upvalueValues[r15] = r7
                                                        r7 = 2
                                                        upvalueValues[r8] = r7
                                                        r7 = {}
                                                        upvalueValues[r25] = r30
                                                        r4 = 256
                                                        r19 = r4
                                                        r4 = 1
                                                        r29 = r4
                                                        r4 = 0
                                                        r14 = r29 < r4
                                                        r13 = nil
                                                        r13 = 1
                                                        r4 = r13 - r29
                                                        r30 = 0
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
                                                        state = createClosure2(47, {
                                                            r20
                                                        })
                                                        r21 = {
                                                            state()
                                                        }
                                                        ReturnVal = {
                                                            unpack(r21)
                                                        }
                                                        state = nil
                                                    end
                                                else
                                                    if state == 26 then
                                                        r1 = not r14
                                                        r4 = r4 + r29
                                                        r13 = r4 <= r19
                                                        r13 = r1 and r13
                                                        r1 = r4 >= r19
                                                        r1 = r14 and r1
                                                        r13 = r1 or r13
                                                        r1 = (27)
                                                        state = r13 and r1
                                                        r13 = (28)
                                                        state = state or r13
                                                    end
                                                end
                                            else
                                                if state <= 27 then
                                                    if state == 27 then
                                                        r13 = r4
                                                        r1 = r13
                                                        r17[r13] = r1
                                                        r13 = nil
                                                        state = 26
                                                    end
                                                else
                                                    if state == 28 then
                                                        r4 = #r17
                                                        r19 = 0
                                                        r13 = r4 == r19
                                                        state = 29
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 30 then
                                                if state <= 29 then
                                                    if state == 29 then
                                                        r4 = 1
                                                        r19 = #r17
                                                        r13 = r11(r4, r19)
                                                        r4 = r27(r17, r13)
                                                        r1 = 1
                                                        r13 = nil
                                                        r19 = upvalueValues[r25]
                                                        r14 = r4 - r1
                                                        r29 = r22(r14)
                                                        r19[r4] = r29
                                                        r4 = nil
                                                        state = 30
                                                    end
                                                else
                                                    if state == 30 then
                                                        r4 = #r17
                                                        r19 = 0
                                                        r13 = r4 == r19
                                                        state = r13 and (31) or (29)
                                                    end
                                                end
                                            else
                                                if state == 31 then
                                                    r4 = allocUpvalue()
                                                    r13 = {}
                                                    r29 = allocUpvalue()
                                                    upvalueValues[r4] = r13
                                                    r19 = createClosure0(51, {
                                                        r4,
                                                        r15,
                                                        r8,
                                                        r9
                                                    })
                                                    r13 = allocUpvalue()
                                                    upvalueValues[r13] = r19
                                                    r9 = releaseUpvalue(r9)
                                                    r19 = {}
                                                    r30 = nil
                                                    r1 = {}
                                                    upvalueValues[r29] = r19
                                                    r14 = "setmetatable"
                                                    r19 = _env[r14]
                                                    r3 = upvalueValues[r29]
                                                    r28 = "__metatable"
                                                    r23 = nil
                                                    r18 = "__index"
                                                    r16 = {
                                                        [r18] = r3,
                                                        [r28] = r23
                                                    }
                                                    r9 = "game"
                                                    r17 = nil
                                                    r14 = r19(r1, r16)
                                                    r19 = createClosure6(57, {
                                                        r29,
                                                        r4,
                                                        r25,
                                                        r15,
                                                        r8,
                                                        r13
                                                    })
                                                    r8 = releaseUpvalue(r8)
                                                    r25 = releaseUpvalue(r25)
                                                    r4 = releaseUpvalue(r4)
                                                    r30 = 1978201605017
                                                    r25 = 7438895451528
                                                    r29 = releaseUpvalue(r29)
                                                    upvalueValues[r20] = r14
                                                    upvalueValues[r12] = r19
                                                    r11 = nil
                                                    r11 = _env[r9]
                                                    r8 = "\\Z\167lCN\182"
                                                    r13 = releaseUpvalue(r13)
                                                    r15 = releaseUpvalue(r15)
                                                    r9 = "GetService"
                                                    r22 = nil
                                                    r22 = upvalueValues[r20]
                                                    r7 = nil
                                                    r7 = upvalueValues[r12]
                                                    r15 = r7(r8, r30)
                                                    r19 = 7338450652505
                                                    r27 = nil
                                                    r27 = r22[r15]
                                                    r9 = r11[r9]
                                                    r9 = r9(r11, r27)
                                                    r27 = "game"
                                                    r11 = _env[r27]
                                                    r7 = upvalueValues[r20]
                                                    r15 = upvalueValues[r12]
                                                    r30 = "\182\130N&[\167\192n\t\156T8\127\174\199\255#A"
                                                    r8 = r15(r30, r25)
                                                    r22 = r7[r8]
                                                    r25 = "\153\154H\215\209\245\131H\235"
                                                    r27 = "GetService"
                                                    r27 = r11[r27]
                                                    r27 = r27(r11, r22)
                                                    r11 = allocUpvalue()
                                                    upvalueValues[r11] = r27
                                                    r22 = "game"
                                                    r27 = _env[r22]
                                                    r15 = upvalueValues[r20]
                                                    r17 = 27009081438497
                                                    r13 = ".C{"
                                                    r8 = upvalueValues[r12]
                                                    r30 = r8(r25, r17)
                                                    r17 = 12915152476030
                                                    r7 = r15[r30]
                                                    r22 = "GetService"
                                                    r22 = r27[r22]
                                                    r22 = r22(r27, r7)
                                                    r25 = "\160\238B^\161\015\220\161!\219#"
                                                    r27 = allocUpvalue()
                                                    upvalueValues[r27] = r22
                                                    r15 = upvalueValues[r20]
                                                    r8 = upvalueValues[r12]
                                                    r30 = r8(r25, r17)
                                                    r7 = r15[r30]
                                                    r22 = r9[r7]
                                                    r7 = allocUpvalue()
                                                    r8 = "Instance"
                                                    r29 = 23662718397194
                                                    upvalueValues[r7] = r22
                                                    r15 = _env[r8]
                                                    r30 = upvalueValues[r20]
                                                    r4 = 10405628187373
                                                    r25 = upvalueValues[r12]
                                                    r17 = r25(r13, r4)
                                                    r8 = r30[r17]
                                                    r4 = 14891405138710
                                                    r13 = ".g\169+n\197\167\031r"
                                                    r22 = r15[r8]
                                                    r30 = upvalueValues[r20]
                                                    r25 = upvalueValues[r12]
                                                    r17 = r25(r13, r4)
                                                    r8 = r30[r17]
                                                    r15 = r22(r8)
                                                    r22 = allocUpvalue()
                                                    r30 = "Instance"
                                                    upvalueValues[r22] = r15
                                                    r8 = _env[r30]
                                                    r4 = "\249\224\254"
                                                    r25 = upvalueValues[r20]
                                                    r17 = upvalueValues[r12]
                                                    r13 = r17(r4, r19)
                                                    r30 = r25[r13]
                                                    r15 = r8[r30]
                                                    r25 = upvalueValues[r20]
                                                    r19 = 24215979977740
                                                    r17 = upvalueValues[r12]
                                                    r4 = "\189n'\178\237"
                                                    r13 = r17(r4, r19)
                                                    r30 = r25[r13]
                                                    r25 = "Instance"
                                                    r8 = r15(r30)
                                                    r30 = _env[r25]
                                                    r17 = upvalueValues[r20]
                                                    r19 = "\128\164\173"
                                                    r13 = upvalueValues[r12]
                                                    r4 = r13(r19, r29)
                                                    r25 = r17[r4]
                                                    r15 = r30[r25]
                                                    r17 = upvalueValues[r20]
                                                    r13 = upvalueValues[r12]
                                                    r29 = 19499116176247
                                                    r19 = "\1411~\218pW\188\019"
                                                    r4 = r13(r19, r29)
                                                    r25 = r17[r4]
                                                    r29 = "\168!="
                                                    r30 = r15(r25)
                                                    r17 = "Instance"
                                                    r25 = _env[r17]
                                                    r13 = upvalueValues[r20]
                                                    r4 = upvalueValues[r12]
                                                    r1 = 10175002251906
                                                    r19 = r4(r29, r1)
                                                    r17 = r13[r19]
                                                    r15 = r25[r17]
                                                    r13 = upvalueValues[r20]
                                                    r4 = upvalueValues[r12]
                                                    r29 = "\218O;\142\204s\217\154"
                                                    r1 = 15363028442097
                                                    r19 = r4(r29, r1)
                                                    r17 = r13[r19]
                                                    r25 = r15(r17)
                                                    r15 = upvalueValues[r22]
                                                    r13 = upvalueValues[r20]
                                                    r29 = "D\154\031\241\248\136"
                                                    r4 = upvalueValues[r12]
                                                    r1 = 5315420195243
                                                    r19 = r4(r29, r1)
                                                    r17 = r13[r19]
                                                    r19 = "game"
                                                    r4 = _env[r19]
                                                    r29 = upvalueValues[r20]
                                                    r1 = upvalueValues[r12]
                                                    r3 = 10018930807353
                                                    r18 = "r\162\196\137#\238\170"
                                                    r16 = r1(r18, r3)
                                                    r19 = r29[r16]
                                                    r29 = "\157b\165!\022\135{\202|\189\002\229"
                                                    r13 = r4[r19]
                                                    r15[r17] = r13
                                                    r15 = upvalueValues[r22]
                                                    r13 = upvalueValues[r20]
                                                    r4 = upvalueValues[r12]
                                                    r1 = 8853434093594
                                                    r19 = r4(r29, r1)
                                                    r17 = r13[r19]
                                                    r13 = false
                                                    r19 = "\225\247\238\132"
                                                    r29 = 9302217134315
                                                    r15[r17] = r13
                                                    r17 = upvalueValues[r20]
                                                    r13 = upvalueValues[r12]
                                                    r4 = r13(r19, r29)
                                                    r15 = r17[r4]
                                                    r4 = "UDim2"
                                                    r13 = _env[r4]
                                                    r19 = upvalueValues[r20]
                                                    r29 = upvalueValues[r12]
                                                    r16 = "\243\011\139"
                                                    r18 = 29476748129694
                                                    r1 = r29(r16, r18)
                                                    r4 = r19[r1]
                                                    r29 = 0
                                                    r19 = 340
                                                    r17 = r13[r4]
                                                    r4 = 0
                                                    r1 = 280
                                                    r13 = r17(r4, r19, r29, r1)
                                                    r19 = "\170t\027\172\225\017\196\252"
                                                    r8[r15] = r13
                                                    r29 = 29024401814731
                                                    r17 = upvalueValues[r20]
                                                    r13 = upvalueValues[r12]
                                                    r4 = r13(r19, r29)
                                                    r15 = r17[r4]
                                                    r4 = "UDim2"
                                                    r13 = _env[r4]
                                                    r19 = upvalueValues[r20]
                                                    r29 = upvalueValues[r12]
                                                    r18 = 23261807716944
                                                    r16 = "\252\027\250"
                                                    r1 = r29(r16, r18)
                                                    r29 = 0.5
                                                    r4 = r19[r1]
                                                    r17 = r13[r4]
                                                    r4 = 0.5
                                                    r1 = -140
                                                    r19 = -170
                                                    r13 = r17(r4, r19, r29, r1)
                                                    r8[r15] = r13
                                                    r17 = upvalueValues[r20]
                                                    r19 = "%N\239k)\171r\225\194[\214^\005\021\237\131"
                                                    r13 = upvalueValues[r12]
                                                    r29 = 33491626343659
                                                    r4 = r13(r19, r29)
                                                    r15 = r17[r4]
                                                    r4 = "Color3"
                                                    r13 = _env[r4]
                                                    r19 = upvalueValues[r20]
                                                    r29 = upvalueValues[r12]
                                                    r18 = 32840758574012
                                                    r16 = "K<\127\230\205\196\245"
                                                    r1 = r29(r16, r18)
                                                    r4 = r19[r1]
                                                    r19 = 18
                                                    r17 = r13[r4]
                                                    r29 = 24
                                                    r4 = 18
                                                    r13 = r17(r4, r19, r29)
                                                    r19 = "F\190\252(\228\129!\005\241&`\127\182\183E"
                                                    r8[r15] = r13
                                                    r29 = 4781468125362
                                                    r17 = upvalueValues[r20]
                                                    r13 = upvalueValues[r12]
                                                    r4 = r13(r19, r29)
                                                    r15 = r17[r4]
                                                    r17 = 0
                                                    r19 = "\nt\246\249iq"
                                                    r8[r15] = r17
                                                    r17 = upvalueValues[r20]
                                                    r13 = upvalueValues[r12]
                                                    r29 = 8713425850329
                                                    r4 = r13(r19, r29)
                                                    r15 = r17[r4]
                                                    r19 = "\179Z\198C3hk\184\219"
                                                    r17 = true
                                                    r8[r15] = r17
                                                    r29 = 29385523262835
                                                    r17 = upvalueValues[r20]
                                                    r13 = upvalueValues[r12]
                                                    r4 = r13(r19, r29)
                                                    r15 = r17[r4]
                                                    r17 = true
                                                    r8[r15] = r17
                                                    r17 = upvalueValues[r20]
                                                    r29 = 20000160293985
                                                    r13 = upvalueValues[r12]
                                                    r19 = "\127\242\247\026\242\249"
                                                    r4 = r13(r19, r29)
                                                    r15 = r17[r4]
                                                    r17 = upvalueValues[r22]
                                                    r8[r15] = r17
                                                    r17 = upvalueValues[r20]
                                                    r13 = upvalueValues[r12]
                                                    r29 = 28076804092690
                                                    r19 = "\192\170*\027\140\128\254\215\012\149\132:"
                                                    r4 = r13(r19, r29)
                                                    r15 = r17[r4]
                                                    r4 = "UDim"
                                                    r13 = _env[r4]
                                                    r19 = upvalueValues[r20]
                                                    r29 = upvalueValues[r12]
                                                    r16 = "\2033\199"
                                                    r18 = 15877964913889
                                                    r1 = r29(r16, r18)
                                                    r4 = r19[r1]
                                                    r19 = 20
                                                    r17 = r13[r4]
                                                    r4 = 0
                                                    r13 = r17(r4, r19)
                                                    r30[r15] = r13
                                                    r17 = upvalueValues[r20]
                                                    r19 = "\183\190x\139\130\254"
                                                    r29 = 9149498937508
                                                    r13 = upvalueValues[r12]
                                                    r4 = r13(r19, r29)
                                                    r15 = r17[r4]
                                                    r19 = "\031\008\182/\0224\178O\227"
                                                    r29 = 14948541995824
                                                    r17 = r8
                                                    r30[r15] = r17
                                                    r17 = upvalueValues[r20]
                                                    r13 = upvalueValues[r12]
                                                    r4 = r13(r19, r29)
                                                    r29 = 5220405741950
                                                    r15 = r17[r4]
                                                    r17 = 4
                                                    r19 = "\020V\226\130N"
                                                    r25[r15] = r17
                                                    r17 = upvalueValues[r20]
                                                    r13 = upvalueValues[r12]
                                                    r4 = r13(r19, r29)
                                                    r15 = r17[r4]
                                                    r4 = "Color3"
                                                    r13 = _env[r4]
                                                    r19 = upvalueValues[r20]
                                                    r29 = upvalueValues[r12]
                                                    r18 = 26801510756544
                                                    r16 = "\177\250!\150Nd\143"
                                                    r1 = r29(r16, r18)
                                                    r29 = 255
                                                    r4 = r19[r1]
                                                    r17 = r13[r4]
                                                    r19 = 160
                                                    r4 = 0
                                                    r13 = r17(r4, r19, r29)
                                                    r25[r15] = r13
                                                    r29 = 16926743617226
                                                    r17 = upvalueValues[r20]
                                                    r13 = upvalueValues[r12]
                                                    r19 = "\141\188\255\147\017E\198ef\017\148\252"
                                                    r4 = r13(r19, r29)
                                                    r15 = r17[r4]
                                                    r17 = 0
                                                    r29 = 12659301209862
                                                    r25[r15] = r17
                                                    r19 = "\151\174\1886\188\147"
                                                    r17 = upvalueValues[r20]
                                                    r13 = upvalueValues[r12]
                                                    r4 = r13(r19, r29)
                                                    r15 = r17[r4]
                                                    r13 = "Instance"
                                                    r17 = r8
                                                    r25[r15] = r17
                                                    r17 = _env[r13]
                                                    r4 = upvalueValues[r20]
                                                    r19 = upvalueValues[r12]
                                                    r16 = 18626220089825
                                                    r1 = "\235+\144"
                                                    r29 = r19(r1, r16)
                                                    r13 = r4[r29]
                                                    r15 = r17[r13]
                                                    r4 = upvalueValues[r20]
                                                    r19 = upvalueValues[r12]
                                                    r1 = "h\017\022\235\026S\130\182\176\144"
                                                    r16 = 29841896093256
                                                    r29 = r19(r1, r16)
                                                    r13 = r4[r29]
                                                    r17 = r15(r13)
                                                    r13 = upvalueValues[r20]
                                                    r4 = upvalueValues[r12]
                                                    r29 = "\028\255j\242"
                                                    r1 = 23064929397236
                                                    r19 = r4(r29, r1)
                                                    r15 = r13[r19]
                                                    r19 = "UDim2"
                                                    r4 = _env[r19]
                                                    r29 = upvalueValues[r20]
                                                    r1 = upvalueValues[r12]
                                                    r3 = 33517625228535
                                                    r18 = "m\216/"
                                                    r16 = r1(r18, r3)
                                                    r19 = r29[r16]
                                                    r29 = 290
                                                    r13 = r4[r19]
                                                    r19 = 0
                                                    r1 = 0
                                                    r16 = 65
                                                    r4 = r13(r19, r29, r1, r16)
                                                    r17[r15] = r4
                                                    r26 = 13065241532355
                                                    r23 = 31513530906962
                                                    r31 = 7712669060615
                                                    r28 = 928356041136
                                                    r18 = "Q\176\024"
                                                    r13 = upvalueValues[r20]
                                                    r29 = "\025\176\164\171\224\206B\143"
                                                    r4 = upvalueValues[r12]
                                                    r1 = 1995974640545
                                                    r19 = r4(r29, r1)
                                                    r15 = r13[r19]
                                                    r19 = "UDim2"
                                                    r4 = _env[r19]
                                                    r3 = 12096537286144
                                                    r9 = nil
                                                    r29 = upvalueValues[r20]
                                                    r1 = upvalueValues[r12]
                                                    r16 = r1(r18, r3)
                                                    r19 = r29[r16]
                                                    r13 = r4[r19]
                                                    r29 = -145
                                                    r19 = 0.5
                                                    r1 = 0
                                                    r16 = 25
                                                    r4 = r13(r19, r29, r1, r16)
                                                    r17[r15] = r4
                                                    r29 = "h\202\199\238 7\166f\198\142L\215/[\134\242"
                                                    r13 = upvalueValues[r20]
                                                    r4 = upvalueValues[r12]
                                                    r1 = 21995971536898
                                                    r19 = r4(r29, r1)
                                                    r15 = r13[r19]
                                                    r19 = "Color3"
                                                    r4 = _env[r19]
                                                    r29 = upvalueValues[r20]
                                                    r1 = upvalueValues[r12]
                                                    r3 = 21495090816793
                                                    r18 = "S\227\136pB\154\023"
                                                    r16 = r1(r18, r3)
                                                    r19 = r29[r16]
                                                    r13 = r4[r19]
                                                    r29 = 20
                                                    r19 = 180
                                                    r1 = 20
                                                    r4 = r13(r19, r29, r1)
                                                    r17[r15] = r4
                                                    r13 = upvalueValues[r20]
                                                    r4 = upvalueValues[r12]
                                                    r29 = "\015\163\1881"
                                                    r1 = 22271539538050
                                                    r19 = r4(r29, r1)
                                                    r15 = r13[r19]
                                                    r4 = upvalueValues[r20]
                                                    r19 = upvalueValues[r12]
                                                    r16 = 2174627873780
                                                    r1 = "\215\146\211\132l\166\t\168"
                                                    r29 = r19(r1, r16)
                                                    r13 = r4[r29]
                                                    r29 = "z\128\247+\182\138\140\011uq"
                                                    r17[r15] = r13
                                                    r13 = upvalueValues[r20]
                                                    r4 = upvalueValues[r12]
                                                    r1 = 26810511012036
                                                    r19 = r4(r29, r1)
                                                    r15 = r13[r19]
                                                    r19 = "Color3"
                                                    r4 = _env[r19]
                                                    r29 = upvalueValues[r20]
                                                    r1 = upvalueValues[r12]
                                                    r3 = 32290470345404
                                                    r18 = "\224\185\001"
                                                    r16 = r1(r18, r3)
                                                    r19 = r29[r16]
                                                    r13 = r4[r19]
                                                    r19 = 1
                                                    r29 = 1
                                                    r1 = 1
                                                    r4 = r13(r19, r29, r1)
                                                    r17[r15] = r4
                                                    r13 = upvalueValues[r20]
                                                    r29 = "X\001\"\001"
                                                    r4 = upvalueValues[r12]
                                                    r1 = 11028061967375
                                                    r19 = r4(r29, r1)
                                                    r15 = r13[r19]
                                                    r29 = "Enum"
                                                    r19 = _env[r29]
                                                    r1 = upvalueValues[r20]
                                                    r16 = upvalueValues[r12]
                                                    r3 = "\229\177\220\239"
                                                    r18 = r16(r3, r28)
                                                    r29 = r1[r18]
                                                    r4 = r19[r29]
                                                    r29 = upvalueValues[r20]
                                                    r1 = upvalueValues[r12]
                                                    r18 = "'?\178W\008\237\000\157\236\005\151"
                                                    r3 = 26582846369882
                                                    r16 = r1(r18, r3)
                                                    r19 = r29[r16]
                                                    r29 = "\190~ \182\134\022\148\225"
                                                    r13 = r4[r19]
                                                    r17[r15] = r13
                                                    r13 = upvalueValues[r20]
                                                    r4 = upvalueValues[r12]
                                                    r1 = 4868091693274
                                                    r19 = r4(r29, r1)
                                                    r15 = r13[r19]
                                                    r13 = 28
                                                    r17[r15] = r13
                                                    r29 = "\163\188\138\179\158-"
                                                    r13 = upvalueValues[r20]
                                                    r4 = upvalueValues[r12]
                                                    r1 = 24190163758080
                                                    r19 = r4(r29, r1)
                                                    r15 = r13[r19]
                                                    r13 = r8
                                                    r4 = "Instance"
                                                    r17[r15] = r13
                                                    r13 = _env[r4]
                                                    r19 = upvalueValues[r20]
                                                    r29 = upvalueValues[r12]
                                                    r18 = 24890100608326
                                                    r16 = "\127%\000"
                                                    r1 = r29(r16, r18)
                                                    r4 = r19[r1]
                                                    r15 = r13[r4]
                                                    r19 = upvalueValues[r20]
                                                    r29 = upvalueValues[r12]
                                                    r18 = 2524478162071
                                                    r16 = "\246C\149T\008\154\239g"
                                                    r1 = r29(r16, r18)
                                                    r4 = r19[r1]
                                                    r13 = r15(r4, r17)
                                                    r4 = upvalueValues[r20]
                                                    r19 = upvalueValues[r12]
                                                    r1 = "\210\195Y6\240gTV\208\210e\251"
                                                    r16 = 28971631883442
                                                    r29 = r19(r1, r16)
                                                    r15 = r4[r29]
                                                    r29 = "UDim"
                                                    r19 = _env[r29]
                                                    r1 = upvalueValues[r20]
                                                    r16 = upvalueValues[r12]
                                                    r3 = "\\[K"
                                                    r28 = 33603526458655
                                                    r18 = r16(r3, r28)
                                                    r29 = r1[r18]
                                                    r4 = r19[r29]
                                                    r29 = 0
                                                    r1 = 16
                                                    r19 = r4(r29, r1)
                                                    r4 = "Instance"
                                                    r13[r15] = r19
                                                    r13 = _env[r4]
                                                    r19 = upvalueValues[r20]
                                                    r29 = upvalueValues[r12]
                                                    r16 = "V\016\249"
                                                    r18 = 31910001441291
                                                    r1 = r29(r16, r18)
                                                    r4 = r19[r1]
                                                    r15 = r13[r4]
                                                    r19 = upvalueValues[r20]
                                                    r29 = upvalueValues[r12]
                                                    r16 = "Qq~k$\234f\255\006Q"
                                                    r18 = 13787420072212
                                                    r1 = r29(r16, r18)
                                                    r4 = r19[r1]
                                                    r13 = r15(r4)
                                                    r4 = upvalueValues[r20]
                                                    r19 = upvalueValues[r12]
                                                    r16 = 26495958462514
                                                    r1 = "\234\012\019\028"
                                                    r29 = r19(r1, r16)
                                                    r15 = r4[r29]
                                                    r29 = "UDim2"
                                                    r19 = _env[r29]
                                                    r1 = upvalueValues[r20]
                                                    r16 = upvalueValues[r12]
                                                    r3 = "\021\021f"
                                                    r28 = 12603594249965
                                                    r18 = r16(r3, r28)
                                                    r29 = r1[r18]
                                                    r4 = r19[r29]
                                                    r29 = 0
                                                    r16 = 0
                                                    r1 = 290
                                                    r18 = 65
                                                    r19 = r4(r29, r1, r16, r18)
                                                    r13[r15] = r19
                                                    r4 = upvalueValues[r20]
                                                    r19 = upvalueValues[r12]
                                                    r1 = "#\2559F\026\1642K"
                                                    r16 = 22936919026104
                                                    r29 = r19(r1, r16)
                                                    r15 = r4[r29]
                                                    r29 = "UDim2"
                                                    r19 = _env[r29]
                                                    r1 = upvalueValues[r20]
                                                    r16 = upvalueValues[r12]
                                                    r3 = "\200D\014"
                                                    r28 = 6260128353123
                                                    r18 = r16(r3, r28)
                                                    r29 = r1[r18]
                                                    r4 = r19[r29]
                                                    r1 = -145
                                                    r29 = 0.5
                                                    r16 = 0
                                                    r18 = 100
                                                    r19 = r4(r29, r1, r16, r18)
                                                    r13[r15] = r19
                                                    r4 = upvalueValues[r20]
                                                    r19 = upvalueValues[r12]
                                                    r1 = "\195\014\008T\222\185-\216\224\2060t\184\141\203\184"
                                                    r16 = 17823999991915
                                                    r29 = r19(r1, r16)
                                                    r15 = r4[r29]
                                                    r29 = "Color3"
                                                    r19 = _env[r29]
                                                    r1 = upvalueValues[r20]
                                                    ReturnVal = {}
                                                    r16 = upvalueValues[r12]
                                                    r28 = 14554057677433
                                                    r3 = "\127YZ[\176g\184"
                                                    r18 = r16(r3, r28)
                                                    r29 = r1[r18]
                                                    r4 = r19[r29]
                                                    r29 = 140
                                                    r1 = 0
                                                    r16 = 0
                                                    r19 = r4(r29, r1, r16)
                                                    r13[r15] = r19
                                                    r4 = upvalueValues[r20]
                                                    r19 = upvalueValues[r12]
                                                    r16 = 23186871970349
                                                    r1 = "\170\137IF"
                                                    r29 = r19(r1, r16)
                                                    r15 = r4[r29]
                                                    r16 = "\202[\176\243\028\186\188\012"
                                                    r18 = 30483301201778
                                                    r3 = "\030\031p"
                                                    r25 = nil
                                                    r19 = upvalueValues[r20]
                                                    r29 = upvalueValues[r12]
                                                    r1 = r29(r16, r18)
                                                    r4 = r19[r1]
                                                    r13[r15] = r4
                                                    r4 = upvalueValues[r20]
                                                    r19 = upvalueValues[r12]
                                                    r16 = 33180277767258
                                                    r1 = ":R\209\213\023B\205H\173L"
                                                    r29 = r19(r1, r16)
                                                    r15 = r4[r29]
                                                    r29 = "Color3"
                                                    r19 = _env[r29]
                                                    r1 = upvalueValues[r20]
                                                    r16 = upvalueValues[r12]
                                                    r28 = 17844395974773
                                                    r18 = r16(r3, r28)
                                                    r29 = r1[r18]
                                                    r4 = r19[r29]
                                                    r29 = 1
                                                    r16 = 1
                                                    r1 = 1
                                                    r19 = r4(r29, r1, r16)
                                                    r13[r15] = r19
                                                    r4 = upvalueValues[r20]
                                                    r19 = upvalueValues[r12]
                                                    r1 = "\182&\225}"
                                                    r16 = 18363858510183
                                                    r29 = r19(r1, r16)
                                                    r15 = r4[r29]
                                                    r1 = "Enum"
                                                    r29 = _env[r1]
                                                    r16 = upvalueValues[r20]
                                                    r18 = upvalueValues[r12]
                                                    r28 = "\214\151\227H"
                                                    r3 = r18(r28, r23)
                                                    r1 = r16[r3]
                                                    r19 = r29[r1]
                                                    r1 = upvalueValues[r20]
                                                    r16 = upvalueValues[r12]
                                                    r28 = 19840370615318
                                                    r3 = "\216\012\187}L\159DX\215I\002"
                                                    r18 = r16(r3, r28)
                                                    r29 = r1[r18]
                                                    r4 = r19[r29]
                                                    r13[r15] = r4
                                                    r4 = upvalueValues[r20]
                                                    r19 = upvalueValues[r12]
                                                    r16 = 30460395796328
                                                    r1 = "(\173\197\135\229+\249."
                                                    r29 = r19(r1, r16)
                                                    r15 = r4[r29]
                                                    r4 = 28
                                                    r13[r15] = r4
                                                    r4 = upvalueValues[r20]
                                                    r19 = upvalueValues[r12]
                                                    r1 = "q> 1\026\208"
                                                    r16 = 18325130338645
                                                    r29 = r19(r1, r16)
                                                    r19 = "Instance"
                                                    r15 = r4[r29]
                                                    r4 = r8
                                                    r13[r15] = r4
                                                    r4 = _env[r19]
                                                    r29 = upvalueValues[r20]
                                                    r1 = upvalueValues[r12]
                                                    r18 = "\157C\177"
                                                    r3 = 6151089343280
                                                    r16 = r1(r18, r3)
                                                    r19 = r29[r16]
                                                    r15 = r4[r19]
                                                    r29 = upvalueValues[r20]
                                                    r1 = upvalueValues[r12]
                                                    r3 = 17547563229163
                                                    r18 = "\022\213V\228\214e`\235"
                                                    r16 = r1(r18, r3)
                                                    r19 = r29[r16]
                                                    r4 = r15(r19, r13)
                                                    r19 = upvalueValues[r20]
                                                    r29 = upvalueValues[r12]
                                                    r16 = "\188\133X\191B6\151^\000?/."
                                                    r18 = 20499758212425
                                                    r1 = r29(r16, r18)
                                                    r15 = r19[r1]
                                                    r1 = "UDim"
                                                    r29 = _env[r1]
                                                    r16 = upvalueValues[r20]
                                                    r18 = upvalueValues[r12]
                                                    r23 = 32961600355316
                                                    r28 = "0\167\000"
                                                    r3 = r18(r28, r23)
                                                    r1 = r16[r3]
                                                    r19 = r29[r1]
                                                    r16 = 16
                                                    r1 = 0
                                                    r29 = r19(r1, r16)
                                                    r4[r15] = r29
                                                    r19 = "Instance"
                                                    r4 = _env[r19]
                                                    r29 = upvalueValues[r20]
                                                    r1 = upvalueValues[r12]
                                                    r3 = 14653661469351
                                                    r18 = "\1588\230"
                                                    r16 = r1(r18, r3)
                                                    r19 = r29[r16]
                                                    r15 = r4[r19]
                                                    r29 = upvalueValues[r20]
                                                    r1 = upvalueValues[r12]
                                                    r18 = "\019\220\136\239-U\015\176:\133"
                                                    r3 = 31527820179801
                                                    r16 = r1(r18, r3)
                                                    r19 = r29[r16]
                                                    r4 = r15(r19)
                                                    r19 = upvalueValues[r20]
                                                    r29 = upvalueValues[r12]
                                                    r16 = "<H\2342"
                                                    r18 = 33889956412837
                                                    r1 = r29(r16, r18)
                                                    r15 = r19[r1]
                                                    r1 = "UDim2"
                                                    r29 = _env[r1]
                                                    r16 = upvalueValues[r20]
                                                    r18 = upvalueValues[r12]
                                                    r23 = 6052135734018
                                                    r28 = "\161\024\014"
                                                    r3 = r18(r28, r23)
                                                    r1 = r16[r3]
                                                    r19 = r29[r1]
                                                    r16 = 290
                                                    r18 = 0
                                                    r1 = 0
                                                    r3 = 65
                                                    r29 = r19(r1, r16, r18, r3)
                                                    r4[r15] = r29
                                                    r19 = upvalueValues[r20]
                                                    r29 = upvalueValues[r12]
                                                    r18 = 1211539767860
                                                    r16 = "\183\212SL\192\253\024n"
                                                    r1 = r29(r16, r18)
                                                    r15 = r19[r1]
                                                    r1 = "UDim2"
                                                    r29 = _env[r1]
                                                    r16 = upvalueValues[r20]
                                                    r18 = upvalueValues[r12]
                                                    r23 = 22895748065701
                                                    r28 = "\229\015\193"
                                                    r3 = r18(r28, r23)
                                                    r1 = r16[r3]
                                                    r19 = r29[r1]
                                                    r16 = -145
                                                    r3 = 175
                                                    r18 = 0
                                                    r1 = 0.5
                                                    r29 = r19(r1, r16, r18, r3)
                                                    r4[r15] = r29
                                                    r19 = upvalueValues[r20]
                                                    r29 = upvalueValues[r12]
                                                    r16 = "\243t\008\218\201\244\0198\020\205tj)>\\\001"
                                                    r18 = 30942236342344
                                                    r1 = r29(r16, r18)
                                                    r15 = r19[r1]
                                                    r1 = "Color3"
                                                    r29 = _env[r1]
                                                    r16 = upvalueValues[r20]
                                                    r18 = upvalueValues[r12]
                                                    r23 = 3736017946315
                                                    r28 = "\015\030\016\001\130\205\245"
                                                    r3 = r18(r28, r23)
                                                    r1 = r16[r3]
                                                    r19 = r29[r1]
                                                    r18 = 255
                                                    r16 = 100
                                                    r1 = 0
                                                    r29 = r19(r1, r16, r18)
                                                    r4[r15] = r29
                                                    r19 = upvalueValues[r20]
                                                    r29 = upvalueValues[r12]
                                                    r18 = 16683007860312
                                                    r16 = "\230\196S\136"
                                                    r1 = r29(r16, r18)
                                                    r15 = r19[r1]
                                                    r29 = upvalueValues[r20]
                                                    r1 = upvalueValues[r12]
                                                    r3 = 29361390695784
                                                    r18 = "\017\185\0169\235+\151\183^7o"
                                                    r16 = r1(r18, r3)
                                                    r19 = r29[r16]
                                                    r4[r15] = r19
                                                    r19 = upvalueValues[r20]
                                                    r29 = upvalueValues[r12]
                                                    r16 = "\147\017\236\025\188J\006Y\203\186"
                                                    r18 = 461647282390
                                                    r1 = r29(r16, r18)
                                                    r15 = r19[r1]
                                                    r1 = "Color3"
                                                    r29 = _env[r1]
                                                    r16 = upvalueValues[r20]
                                                    r18 = upvalueValues[r12]
                                                    r28 = "\251V\012"
                                                    r23 = 30470427932524
                                                    r3 = r18(r28, r23)
                                                    r1 = r16[r3]
                                                    r19 = r29[r1]
                                                    r1 = 1
                                                    r18 = 1
                                                    r16 = 1
                                                    r29 = r19(r1, r16, r18)
                                                    r4[r15] = r29
                                                    r19 = upvalueValues[r20]
                                                    r29 = upvalueValues[r12]
                                                    r16 = "9=}\188"
                                                    r18 = 20672977053082
                                                    r1 = r29(r16, r18)
                                                    r15 = r19[r1]
                                                    r16 = "Enum"
                                                    r1 = _env[r16]
                                                    r18 = upvalueValues[r20]
                                                    r3 = upvalueValues[r12]
                                                    r23 = "\233\155l\209"
                                                    r28 = r3(r23, r26)
                                                    r16 = r18[r28]
                                                    r29 = r1[r16]
                                                    r16 = upvalueValues[r20]
                                                    r18 = upvalueValues[r12]
                                                    r28 = "\019\017K\189;r\188\176\014\214\029"
                                                    r23 = 18222974853413
                                                    r3 = r18(r28, r23)
                                                    r1 = r16[r3]
                                                    r19 = r29[r1]
                                                    r4[r15] = r19
                                                    r19 = upvalueValues[r20]
                                                    r29 = upvalueValues[r12]
                                                    r16 = "\202\142\018C\200\028P\t"
                                                    r18 = 26933105422589
                                                    r1 = r29(r16, r18)
                                                    r15 = r19[r1]
                                                    r19 = 28
                                                    r4[r15] = r19
                                                    r19 = upvalueValues[r20]
                                                    r29 = upvalueValues[r12]
                                                    r16 = "\186\019&\017P\218"
                                                    r18 = 30889241524271
                                                    r1 = r29(r16, r18)
                                                    r15 = r19[r1]
                                                    r29 = "Instance"
                                                    r19 = r8
                                                    r4[r15] = r19
                                                    r19 = _env[r29]
                                                    r1 = upvalueValues[r20]
                                                    r16 = upvalueValues[r12]
                                                    r28 = 32777032530846
                                                    r3 = "\243\209\229"
                                                    r18 = r16(r3, r28)
                                                    r29 = r1[r18]
                                                    r15 = r19[r29]
                                                    r1 = upvalueValues[r20]
                                                    r16 = upvalueValues[r12]
                                                    r3 = "\129/4e6\178%\224"
                                                    r28 = 14935605287722
                                                    r18 = r16(r3, r28)
                                                    r29 = r1[r18]
                                                    r19 = r15(r29, r4)
                                                    r29 = upvalueValues[r20]
                                                    r1 = upvalueValues[r12]
                                                    r3 = 26188170637218
                                                    r18 = "P\129\193\255\248\248\205\174\166\249\014\015"
                                                    r16 = r1(r18, r3)
                                                    r15 = r29[r16]
                                                    r16 = "UDim"
                                                    r1 = _env[r16]
                                                    r18 = upvalueValues[r20]
                                                    r3 = upvalueValues[r12]
                                                    r26 = 30772938209273
                                                    r23 = "\16122"
                                                    r28 = r3(r23, r26)
                                                    r16 = r18[r28]
                                                    r29 = r1[r16]
                                                    r16 = 0
                                                    r18 = 16
                                                    r1 = r29(r16, r18)
                                                    r29 = "Instance"
                                                    r19[r15] = r1
                                                    r19 = _env[r29]
                                                    r1 = upvalueValues[r20]
                                                    r16 = upvalueValues[r12]
                                                    r28 = 32780001262496
                                                    r3 = "\238\227\157"
                                                    r18 = r16(r3, r28)
                                                    r29 = r1[r18]
                                                    r15 = r19[r29]
                                                    r1 = upvalueValues[r20]
                                                    r16 = upvalueValues[r12]
                                                    r3 = "\236oi\238=\231\187\2418\240"
                                                    r28 = 9367657042186
                                                    r18 = r16(r3, r28)
                                                    r29 = r1[r18]
                                                    r19 = r15(r29)
                                                    r18 = "\178\2510a"
                                                    r3 = 27102097011020
                                                    r26 = 17435999788983
                                                    r23 = "\136m\147"
                                                    r29 = upvalueValues[r20]
                                                    r30 = nil
                                                    r1 = upvalueValues[r12]
                                                    r16 = r1(r18, r3)
                                                    r15 = r29[r16]
                                                    r16 = "UDim2"
                                                    r1 = _env[r16]
                                                    r18 = upvalueValues[r20]
                                                    r3 = upvalueValues[r12]
                                                    r28 = r3(r23, r26)
                                                    r16 = r18[r28]
                                                    r29 = r1[r16]
                                                    r3 = 0
                                                    r28 = 38
                                                    r16 = 0
                                                    r18 = 38
                                                    r1 = r29(r16, r18, r3, r28)
                                                    r19[r15] = r1
                                                    r29 = upvalueValues[r20]
                                                    r1 = upvalueValues[r12]
                                                    r3 = 4643680733298
                                                    r18 = "b\172\131\0292A\136E"
                                                    r16 = r1(r18, r3)
                                                    r15 = r29[r16]
                                                    r16 = "UDim2"
                                                    r1 = _env[r16]
                                                    r18 = upvalueValues[r20]
                                                    r3 = upvalueValues[r12]
                                                    r26 = 10242855244449
                                                    r23 = "!\174\183"
                                                    r28 = r3(r23, r26)
                                                    r16 = r18[r28]
                                                    r18 = -50
                                                    r29 = r1[r16]
                                                    r3 = 0
                                                    r28 = 10
                                                    r16 = 1
                                                    r1 = r29(r16, r18, r3, r28)
                                                    r19[r15] = r1
                                                    r29 = upvalueValues[r20]
                                                    r1 = upvalueValues[r12]
                                                    r3 = 23587089132263
                                                    r18 = "\005\191\162\210\241\1630\223\t\234\226\213\203\139\029\197"
                                                    r16 = r1(r18, r3)
                                                    r15 = r29[r16]
                                                    r16 = "Color3"
                                                    r1 = _env[r16]
                                                    r18 = upvalueValues[r20]
                                                    r3 = upvalueValues[r12]
                                                    r26 = 22191243962461
                                                    r23 = "\151\180\147i\216\169\161"
                                                    r28 = r3(r23, r26)
                                                    r16 = r18[r28]
                                                    r29 = r1[r16]
                                                    r3 = 40
                                                    r16 = 255
                                                    r18 = 40
                                                    r1 = r29(r16, r18, r3)
                                                    r19[r15] = r1
                                                    r29 = upvalueValues[r20]
                                                    r1 = upvalueValues[r12]
                                                    r18 = "\160\191Q\231"
                                                    r3 = 30742613456875
                                                    r16 = r1(r18, r3)
                                                    r15 = r29[r16]
                                                    r1 = upvalueValues[r20]
                                                    r16 = upvalueValues[r12]
                                                    r28 = 21364317382364
                                                    r3 = "\240"
                                                    r18 = r16(r3, r28)
                                                    r29 = r1[r18]
                                                    r19[r15] = r29
                                                    r29 = upvalueValues[r20]
                                                    r1 = upvalueValues[r12]
                                                    r3 = 1660533326597
                                                    r18 = "\2359\160!\243\130\142-\1929"
                                                    r16 = r1(r18, r3)
                                                    r15 = r29[r16]
                                                    r16 = "Color3"
                                                    r1 = _env[r16]
                                                    r18 = upvalueValues[r20]
                                                    r3 = upvalueValues[r12]
                                                    r23 = "\215\148\193"
                                                    r26 = 27086061531460
                                                    r28 = r3(r23, r26)
                                                    r16 = r18[r28]
                                                    r29 = r1[r16]
                                                    r3 = 1
                                                    r18 = 1
                                                    r16 = 1
                                                    r1 = r29(r16, r18, r3)
                                                    r19[r15] = r1
                                                    r29 = upvalueValues[r20]
                                                    r1 = upvalueValues[r12]
                                                    r18 = "M\206\178\209"
                                                    r3 = 20069901689985
                                                    r16 = r1(r18, r3)
                                                    r15 = r29[r16]
                                                    r18 = "Enum"
                                                    r16 = _env[r18]
                                                    r3 = upvalueValues[r20]
                                                    r28 = upvalueValues[r12]
                                                    r26 = "\203\253V`"
                                                    r23 = r28(r26, r31)
                                                    r18 = r3[r23]
                                                    r1 = r16[r18]
                                                    r18 = upvalueValues[r20]
                                                    r3 = upvalueValues[r12]
                                                    r23 = "\012\169\233\218\233\149\145\202f\019"
                                                    r26 = 28297601315705
                                                    r28 = r3(r23, r26)
                                                    r16 = r18[r28]
                                                    r29 = r1[r16]
                                                    r19[r15] = r29
                                                    r29 = upvalueValues[r20]
                                                    r1 = upvalueValues[r12]
                                                    r18 = "\227\014\142\200\1594\179\r"
                                                    r3 = 7781277666855
                                                    r16 = r1(r18, r3)
                                                    r15 = r29[r16]
                                                    r29 = 20
                                                    r19[r15] = r29
                                                    r29 = upvalueValues[r20]
                                                    r1 = upvalueValues[r12]
                                                    r3 = 3470533297744
                                                    r18 = "\227\225E\164\199\221"
                                                    r16 = r1(r18, r3)
                                                    r15 = r29[r16]
                                                    r29 = r8
                                                    r19[r15] = r29
                                                    r1 = "Instance"
                                                    r29 = _env[r1]
                                                    r16 = upvalueValues[r20]
                                                    r18 = upvalueValues[r12]
                                                    r28 = "b\140\026"
                                                    r23 = 32033619262020
                                                    r3 = r18(r28, r23)
                                                    r1 = r16[r3]
                                                    r15 = r29[r1]
                                                    r16 = upvalueValues[r20]
                                                    r18 = upvalueValues[r12]
                                                    r23 = 24464285527168
                                                    r28 = "\179Y\201.\188\018\228}"
                                                    r3 = r18(r28, r23)
                                                    r1 = r16[r3]
                                                    r29 = r15(r1, r19)
                                                    r1 = upvalueValues[r20]
                                                    r16 = upvalueValues[r12]
                                                    r3 = "Vuj\243\029k\169\018\192\019k\211"
                                                    r28 = 32831923993528
                                                    r18 = r16(r3, r28)
                                                    r15 = r1[r18]
                                                    r18 = "UDim"
                                                    r16 = _env[r18]
                                                    r3 = upvalueValues[r20]
                                                    r28 = upvalueValues[r12]
                                                    r31 = 32495266544411
                                                    r26 = ":Qv"
                                                    r23 = r28(r26, r31)
                                                    r18 = r3[r23]
                                                    r1 = r16[r18]
                                                    r3 = 0
                                                    r18 = 1
                                                    r16 = r1(r18, r3)
                                                    r29[r15] = r16
                                                    r15 = allocUpvalue()
                                                    r29 = createClosure2(64, {
                                                        r11,
                                                        r7,
                                                        r20,
                                                        r12
                                                    })
                                                    upvalueValues[r15] = r29
                                                    r29 = createClosure3(65, {
                                                        r27,
                                                        r20,
                                                        r12,
                                                        r7
                                                    })
                                                    r18 = upvalueValues[r20]
                                                    r3 = upvalueValues[r12]
                                                    r23 = "A\238qf\020q?\152\209\167\029\0264\212N\017\003"
                                                    r26 = 22600496736540
                                                    r28 = r3(r23, r26)
                                                    r16 = r18[r28]
                                                    r18 = createClosure5(72, {
                                                        r15
                                                    })
                                                    r1 = r17[r16]
                                                    r16 = "Connect"
                                                    r16 = r1[r16]
                                                    r16 = r16(r1, r18)
                                                    r18 = upvalueValues[r20]
                                                    r3 = upvalueValues[r12]
                                                    r26 = 6452460964796
                                                    r23 = "S\177\1977\008\156a\203\150@$*\146]\209\127F"
                                                    r28 = r3(r23, r26)
                                                    r16 = r18[r28]
                                                    r18 = createClosure4(73, {
                                                        r15
                                                    })
                                                    r1 = r13[r16]
                                                    r16 = "Connect"
                                                    r16 = r1[r16]
                                                    r15 = releaseUpvalue(r15)
                                                    r16 = r16(r1, r18)
                                                    r18 = upvalueValues[r20]
                                                    r3 = upvalueValues[r12]
                                                    r23 = "5\227\215\221\207r.\145\231\0210\146\162EK\200\248"
                                                    r26 = 23072267659767
                                                    r28 = r3(r23, r26)
                                                    r16 = r18[r28]
                                                    r27 = releaseUpvalue(r27)
                                                    r23 = "\178\230'N\220\012\253p\173K\217s\"\189\254\180R"
                                                    r17 = nil
                                                    r26 = 4852124420307
                                                    r13 = nil
                                                    r7 = releaseUpvalue(r7)
                                                    r1 = r4[r16]
                                                    r16 = "Connect"
                                                    r16 = r1[r16]
                                                    r16 = r16(r1, r29)
                                                    r18 = upvalueValues[r20]
                                                    r11 = releaseUpvalue(r11)
                                                    r3 = upvalueValues[r12]
                                                    r28 = r3(r23, r26)
                                                    r16 = r18[r28]
                                                    r12 = releaseUpvalue(r12)
                                                    r4 = nil
                                                    r29 = nil
                                                    r1 = r19[r16]
                                                    r8 = nil
                                                    r18 = createClosure4(74, {
                                                        r22
                                                    })
                                                    r20 = releaseUpvalue(r20)
                                                    r22 = releaseUpvalue(r22)
                                                    r16 = "Connect"
                                                    r19 = nil
                                                    r16 = r1[r16]
                                                    r16 = r16(r1, r18)
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure5 entry 14562791 -> 32, states 32-32
                                if state == 32 then -- entry 14562791 -> 32
                                    ReturnVal = "error"
                                    state = _env[ReturnVal]
                                    r5 = "Tamper Detected!"
                                    ReturnVal = state(r5)
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            if state <= 33 then
                                -- createClosure3 entry 7719108 -> 33, states 33-33
                                if state == 33 then -- entry 7719108 -> 33
                                    state = true
                                    upvalueValues[upvalues[1]] = state
                                    ReturnVal = {}
                                    state = nil
                                end
                            else
                                -- createClosure2 entry 8524313 -> 34, states 34-34
                                if state == 34 then -- entry 8524313 -> 34
                                    r11 = 3837788
                                    r12 = "7Nm0A0fndzl4h"
                                    r5 = r12 ^ r11
                                    ReturnVal = 15885889
                                    state = ReturnVal - r5
                                    r5 = state
                                    ReturnVal = "CUIrKOCD"
                                    state = ReturnVal / r5
                                    ReturnVal = {
                                        state
                                    }
                                    state = nil
                                end
                            end
                        end
                    else
                        if state <= 50 then
                            if state <= 46 then
                                -- createClosure4 entry 1896300 -> 35, states 35-46
                                if state <= 40 then
                                    if state <= 37 then
                                        if state <= 36 then
                                            if state <= 35 then
                                                if state == 35 then -- entry 1896300 -> 35
                                                    r12 = upvalueValues[upvalues[1]]
                                                    r20 = 1
                                                    r9 = 2
                                                    r11 = r12(r20, r9)
                                                    r12 = 1
                                                    r5 = r11 == r12
                                                    state = r5 and (36) or (37)
                                                    ReturnVal = r5
                                                end
                                            else
                                                if state == 36 then
                                                    state = ReturnVal and (38) or (39)
                                                end
                                            end
                                        else
                                            if state == 37 then
                                                r12 = upvalueValues[upvalues[2]]
                                                r11 = upvalueValues[upvalues[3]]
                                                r5 = r12 == r11
                                                ReturnVal = r5
                                                state = 36
                                            end
                                        end
                                    else
                                        if state <= 39 then
                                            if state <= 38 then
                                                if state == 38 then
                                                    r15 = createClosure5(75, {})
                                                    ReturnVal = "tonumber"
                                                    state = _env[ReturnVal]
                                                    r5 = upvalueValues[upvalues[4]]
                                                    r20 = "tostring"
                                                    r11 = _env[r20]
                                                    r7 = "pcall"
                                                    r22 = _env[r7]
                                                    r7 = {
                                                        r22(r15)
                                                    }
                                                    r27 = {
                                                        unpack(r7)
                                                    }
                                                    r22 = 2
                                                    r9 = r27[r22]
                                                    r20 = r11(r9)
                                                    r11 = ":(%d*):"
                                                    r12 = r5(r20, r11)
                                                    r5 = {
                                                        r12()
                                                    }
                                                    ReturnVal = state(unpack(r5))
                                                    r5 = ReturnVal
                                                    r12 = upvalueValues[upvalues[5]]
                                                    state = r12 and (40) or (41)
                                                    ReturnVal = r12
                                                end
                                            else
                                                if state == 39 then
                                                    state = upvalueValues[upvalues[7]]
                                                    state = state and (42) or (43)
                                                end
                                            end
                                        else
                                            if state == 40 then
                                                r11 = upvalueValues[upvalues[6]]
                                                r12 = r11 == r5
                                                ReturnVal = r12
                                                state = 41
                                            end
                                        end
                                    end
                                else
                                    if state <= 43 then
                                        if state <= 42 then
                                            if state <= 41 then
                                                if state == 41 then
                                                    r5 = nil
                                                    upvalueValues[upvalues[5]] = ReturnVal
                                                    state = 39
                                                end
                                            else
                                                if state == 42 then
                                                    r5 = "error"
                                                    state = _env[r5]
                                                    r12 = upvalueValues[upvalues[8]]
                                                    r11 = 0
                                                    r5 = state(r12, r11)
                                                    state = 43
                                                end
                                            end
                                        else
                                            if state == 43 then
                                                state = {}
                                                r5 = state
                                                r11 = upvalueValues[upvalues[9]]
                                                r20 = r11
                                                r11 = 1
                                                r9 = r11
                                                r11 = 0
                                                r27 = r9 < r11
                                                r12 = 1
                                                r11 = r12 - r9
                                                state = 44
                                            end
                                        end
                                    else
                                        if state <= 45 then
                                            if state <= 44 then
                                                if state == 44 then
                                                    r11 = r11 + r9
                                                    r12 = r11 <= r20
                                                    r22 = not r27
                                                    r12 = r22 and r12
                                                    r22 = r11 >= r20
                                                    r22 = r27 and r22
                                                    r12 = r22 or r12
                                                    r22 = (45)
                                                    state = r12 and r22
                                                    r12 = (46)
                                                    state = state or r12
                                                end
                                            else
                                                if state == 45 then
                                                    state = upvalueValues[upvalues[1]]
                                                    r12 = r11
                                                    r7 = 0
                                                    r15 = 255
                                                    r22 = state(r7, r15)
                                                    r5[r12] = r22
                                                    r12 = nil
                                                    state = 44
                                                end
                                            end
                                        else
                                            if state == 46 then
                                                state = upvalueValues[upvalues[10]]
                                                r12 = upvalueValues[upvalues[11]]
                                                r5[state] = r12
                                                state = upvalueValues[upvalues[12]]
                                                r12 = {
                                                    state(r5)
                                                }
                                                ReturnVal = {
                                                    unpack(r12)
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure2 entry 4503912 -> 47, states 47-50
                                if state <= 48 then
                                    if state <= 47 then
                                        if state == 47 then -- entry 4503912 -> 47
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
                                            r5 = "l1"
                                            ReturnVal = _env[r5]
                                            r5 = "l1"
                                            _env[r5] = state
                                            r5 = "l2"
                                            _env[r5] = ReturnVal
                                            r5 = upvalueValues[upvalues[1]]
                                            r12 = r5()
                                            state = 48
                                        end
                                    else
                                        if state == 50 then
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            end
                        else
                            -- createClosure0 entry 14588389 -> 51, states 51-56
                            if state <= 53 then
                                if state <= 52 then
                                    if state <= 51 then
                                        if state == 51 then -- entry 14588389 -> 51
                                            r5 = upvalueValues[upvalues[1]]
                                            ReturnVal = #r5
                                            r5 = 0
                                            state = ReturnVal == r5
                                            state = state and (52) or (53)
                                        end
                                    else
                                        if state == 52 then
                                            r12 = upvalueValues[upvalues[2]]
                                            r11 = 177
                                            r5 = r12 * r11
                                            r12 = 24526812933275
                                            ReturnVal = r5 + r12
                                            r5 = 35184372088832
                                            state = ReturnVal % r5
                                            upvalueValues[upvalues[2]] = state
                                            r5 = upvalueValues[upvalues[3]]
                                            r12 = 1
                                            ReturnVal = r5 ~= r12
                                            state = 54
                                        end
                                    end
                                else
                                    if state == 53 then
                                        r11 = "table"
                                        r12 = _env[r11]
                                        r11 = "remove"
                                        r5 = r12[r11]
                                        r11 = upvalueValues[upvalues[1]]
                                        r12 = {
                                            r5(r11)
                                        }
                                        ReturnVal = {
                                            unpack(r12)
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 55 then
                                    if state <= 54 then
                                        if state == 54 then
                                            r12 = upvalueValues[upvalues[3]]
                                            r11 = 65
                                            r5 = r12 * r11
                                            r12 = 257
                                            ReturnVal = r5 % r12
                                            upvalueValues[upvalues[3]] = ReturnVal
                                            state = 55
                                        end
                                    else
                                        if state == 55 then
                                            r12 = upvalueValues[upvalues[3]]
                                            r11 = 1
                                            r5 = r12 ~= r11
                                            state = r5 and (56) or (54)
                                        end
                                    end
                                else
                                    if state == 56 then
                                        r11 = 32
                                        r12 = upvalueValues[upvalues[3]]
                                        r5 = r12 % r11
                                        r15 = 2
                                        r20 = upvalueValues[upvalues[4]]
                                        r22 = upvalueValues[upvalues[2]]
                                        r13 = upvalueValues[upvalues[3]]
                                        r17 = r13 - r5
                                        r13 = 32
                                        r25 = r17 / r13
                                        r30 = 13
                                        r8 = r30 - r25
                                        r7 = r15 ^ r8
                                        r27 = r22 / r7
                                        r9 = r20(r27)
                                        r20 = 4294967296
                                        r7 = 1
                                        r11 = r9 % r20
                                        r9 = 2
                                        r20 = r9 ^ r5
                                        r12 = r11 / r20
                                        r20 = upvalueValues[upvalues[4]]
                                        r22 = r12 % r7
                                        r7 = 4294967296
                                        r27 = r22 * r7
                                        r9 = r20(r27)
                                        r20 = upvalueValues[upvalues[4]]
                                        r27 = r20(r12)
                                        r11 = r9 + r27
                                        r15 = 256
                                        r9 = 65536
                                        r20 = r11 % r9
                                        r22 = 65536
                                        r27 = r11 - r20
                                        r9 = r27 / r22
                                        r22 = 256
                                        r27 = r20 % r22
                                        r7 = r20 - r27
                                        r11 = nil
                                        r12 = nil
                                        r22 = r7 / r15
                                        r15 = 256
                                        r7 = r9 % r15
                                        r8 = r9 - r7
                                        r30 = 256
                                        r20 = nil
                                        r15 = r8 / r30
                                        r9 = nil
                                        r8 = {
                                            r27,
                                            r22,
                                            r7,
                                            r15
                                        }
                                        r27 = nil
                                        r7 = nil
                                        upvalueValues[upvalues[1]] = r8
                                        r22 = nil
                                        r5 = nil
                                        r15 = nil
                                        state = 53
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 72 then
                        if state <= 64 then
                            if state <= 63 then
                                -- createClosure6 entry 8122655 -> 57, states 57-63
                                if state <= 60 then
                                    if state <= 58 then
                                        if state <= 57 then
                                            if state == 57 then -- entry 8122655 -> 57
                                                r5 = args[1]
                                                r12 = args[2]
                                                state = upvalueValues[upvalues[1]]
                                                r11 = state
                                                state = r11[r12]
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
                                                r20 = ReturnVal
                                                r9 = 35184372088832
                                                ReturnVal = r12 % r9
                                                upvalueValues[upvalues[4]] = ReturnVal
                                                r22 = 255
                                                r27 = r12 % r22
                                                r22 = 2
                                                r9 = r27 + r22
                                                upvalueValues[upvalues[5]] = r9
                                                r7 = "string"
                                                r22 = _env[r7]
                                                r7 = "len"
                                                r27 = r22[r7]
                                                r22 = r27(r5)
                                                r27 = ""
                                                r11[r12] = r27
                                                r8 = 1
                                                r30 = r8
                                                r8 = 0
                                                r25 = r30 < r8
                                                r7 = 1
                                                r8 = r7 - r30
                                                r15 = r22
                                                r27 = 128
                                                state = 61
                                            end
                                        else
                                            if state == 60 then
                                                ReturnVal = {
                                                    r12
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    if state <= 62 then
                                        if state <= 61 then
                                            if state == 61 then
                                                r8 = r8 + r30
                                                r17 = not r25
                                                r7 = r8 <= r15
                                                r7 = r17 and r7
                                                r17 = r8 >= r15
                                                r17 = r25 and r17
                                                r7 = r17 or r7
                                                r17 = (62)
                                                state = r7 and r17
                                                r7 = (63)
                                                state = state or r7
                                            end
                                        else
                                            if state == 62 then
                                                r7 = r8
                                                r32 = "string"
                                                r21 = _env[r32]
                                                r32 = "byte"
                                                r2 = r21[r32]
                                                r21 = r2(r5, r7)
                                                r2 = upvalueValues[upvalues[6]]
                                                r32 = r2()
                                                r4 = r21 + r32
                                                r13 = r4 + r27
                                                r4 = 256
                                                r17 = r13 % r4
                                                r27 = r17
                                                r32 = 1
                                                r7 = nil
                                                r4 = r11[r12]
                                                r21 = r27 + r32
                                                r2 = r20[r21]
                                                r13 = r4 .. r2
                                                r11[r12] = r13
                                                state = 61
                                            end
                                        end
                                    else
                                        if state == 63 then
                                            r20 = nil
                                            r27 = nil
                                            r22 = nil
                                            state = 60
                                        end
                                    end
                                end
                            else
                                -- createClosure2 entry 6819818 -> 64, states 64-64
                                if state == 64 then -- entry 6819818 -> 64
                                    state = upvalueValues[upvalues[1]]
                                    ReturnVal = "SignalPromptProductPurchaseFinished"
                                    ReturnVal = state[ReturnVal]
                                    r11 = upvalueValues[upvalues[2]]
                                    r5 = args[1]
                                    r9 = upvalueValues[upvalues[3]]
                                    r27 = upvalueValues[upvalues[4]]
                                    r15 = 19750341354476
                                    r7 = "\225Zv\136\167\194"
                                    r22 = r27(r7, r15)
                                    r20 = r9[r22]
                                    r12 = r11[r20]
                                    r11 = true
                                    ReturnVal = ReturnVal(state, r12, r5, r11)
                                    r5 = nil
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            if state <= 71 then
                                -- createClosure3 entry 9230409 -> 65, states 65-71
                                if state <= 68 then
                                    if state <= 66 then
                                        if state <= 65 then
                                            if state == 65 then -- entry 9230409 -> 65
                                                state = upvalueValues[upvalues[1]]
                                                r12 = upvalueValues[upvalues[2]]
                                                r11 = upvalueValues[upvalues[3]]
                                                r27 = 18320528957779
                                                r9 = "4\20975\180\143\230Fy}"
                                                r20 = r11(r9, r27)
                                                r5 = r12[r20]
                                                ReturnVal = "FindFirstChild"
                                                ReturnVal = state[ReturnVal]
                                                r12 = true
                                                ReturnVal = ReturnVal(state, r5, r12)
                                                r5 = ReturnVal
                                                state = r5 and (66) or (67)
                                                ReturnVal = r5
                                            end
                                        else
                                            if state == 66 then
                                                r9 = upvalueValues[upvalues[4]]
                                                r22 = upvalueValues[upvalues[2]]
                                                r7 = upvalueValues[upvalues[3]]
                                                r8 = "\197\251\135\015\208\0079\253\008"
                                                r30 = 10376135971551
                                                r15 = r7(r8, r30)
                                                r27 = r22[r15]
                                                r20 = r9[r27]
                                                r11 = state
                                                state = r20 and (68) or (69)
                                                r12 = r20
                                            end
                                        end
                                    else
                                        if state <= 67 then
                                            if state == 67 then
                                                state = ReturnVal and (70) or (71)
                                            end
                                        else
                                            if state == 68 then
                                                r9 = upvalueValues[upvalues[4]]
                                                r22 = upvalueValues[upvalues[2]]
                                                r7 = upvalueValues[upvalues[3]]
                                                r8 = "\229\154M\205\164t\246\194\200"
                                                r30 = 2788944119058
                                                r15 = r7(r8, r30)
                                                r27 = r22[r15]
                                                r20 = r9[r27]
                                                r22 = upvalueValues[upvalues[2]]
                                                r7 = upvalueValues[upvalues[3]]
                                                r30 = 10069262275152
                                                r8 = "\149\241\207\152\205\171\226\210\173\2089\002\245\211P\250"
                                                r15 = r7(r8, r30)
                                                r9 = "FindFirstChild"
                                                r9 = r20[r9]
                                                r27 = r22[r15]
                                                r9 = r9(r20, r27)
                                                r12 = r9
                                                state = 69
                                            end
                                        end
                                    end
                                else
                                    if state <= 70 then
                                        if state <= 69 then
                                            if state == 69 then
                                                state = r11
                                                ReturnVal = r12
                                                state = 67
                                            end
                                        else
                                            if state == 70 then
                                                r12 = upvalueValues[upvalues[4]]
                                                r20 = upvalueValues[upvalues[2]]
                                                r9 = upvalueValues[upvalues[3]]
                                                r22 = "\250M\142\249\194k\140o\167"
                                                r7 = 6081005390607
                                                r27 = r9(r22, r7)
                                                r11 = r20[r27]
                                                ReturnVal = r12[r11]
                                                r11 = upvalueValues[upvalues[2]]
                                                r20 = upvalueValues[upvalues[3]]
                                                r22 = 381604544689
                                                r27 = "\159~\190\221\179\001\183\245\003byC\169<k\140"
                                                r9 = r20(r27, r22)
                                                r12 = r11[r9]
                                                state = ReturnVal[r12]
                                                r12 = upvalueValues[upvalues[2]]
                                                r11 = upvalueValues[upvalues[3]]
                                                r27 = 25004867562875
                                                r9 = "\142p-04\164"
                                                r20 = r11(r9, r27)
                                                ReturnVal = r12[r20]
                                                r9 = upvalueValues[upvalues[2]]
                                                r27 = upvalueValues[upvalues[3]]
                                                r15 = 32269176027826
                                                r7 = "\179\139\028\169a\156"
                                                r22 = r27(r7, r15)
                                                r20 = r9[r22]
                                                r11 = r5[r20]
                                                r27 = "Vector3"
                                                r9 = _env[r27]
                                                r22 = upvalueValues[upvalues[2]]
                                                r7 = upvalueValues[upvalues[3]]
                                                r30 = 31154542753963
                                                r8 = "\224-y"
                                                r15 = r7(r8, r30)
                                                r27 = r22[r15]
                                                r20 = r9[r27]
                                                r7 = 0
                                                r27 = 0
                                                r22 = 5
                                                r9 = r20(r27, r22, r7)
                                                r12 = r11 + r9
                                                state[ReturnVal] = r12
                                                state = 71
                                            end
                                        end
                                    else
                                        if state == 71 then
                                            r5 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            else
                                -- createClosure5 entry 1869041 -> 72, states 72-72
                                if state == 72 then -- entry 1869041 -> 72
                                    state = upvalueValues[upvalues[1]]
                                    r5 = 3456021574
                                    ReturnVal = state(r5)
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        end
                    else
                        if state <= 74 then
                            if state <= 73 then
                                -- createClosure4 entry 10718280 -> 73, states 73-73
                                if state == 73 then -- entry 10718280 -> 73
                                    state = upvalueValues[upvalues[1]]
                                    r5 = 3456021927
                                    ReturnVal = state(r5)
                                    ReturnVal = {}
                                    state = nil
                                end
                            else
                                -- createClosure4 entry 14706815 -> 74, states 74-74
                                if state == 74 then -- entry 14706815 -> 74
                                    state = upvalueValues[upvalues[1]]
                                    ReturnVal = "Destroy"
                                    ReturnVal = state[ReturnVal]
                                    ReturnVal = ReturnVal(state)
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            -- createClosure5 entry 15472729 -> 75, states 75-75
                            if state == 75 then -- entry 15472729 -> 75
                                r11 = 14471508
                                r12 = "ByIuecr"
                                r5 = r12 ^ r11
                                ReturnVal = 7370444
                                state = ReturnVal - r5
                                r5 = state
                                ReturnVal = "rEXj18Pp2Nbx"
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 709700
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 709700
                    end
                })
            end
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