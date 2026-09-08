return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalue, createClosure0, createClosure1, createClosure3, upvalueValues, createClosure5, allocUpvalue, createClosure, createClosure2, createClosure4, releaseUpvalues, upvalueRefCounts, vm, currentUpvalueId, createUpvalueProxy)
        createClosure1 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1)
                return vm(entryId, {
                    arg1
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
        releaseUpvalues = function(captures)
            local captureIndex, upvalueId = 1, captures[1]
            while upvalueId do
                upvalueRefCounts[upvalueId], captureIndex = upvalueRefCounts[upvalueId] - (1), (1) + captureIndex
                if upvalueRefCounts[upvalueId] == 0 then
                    upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
                end
                upvalueId = captures[captureIndex]
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, ReturnVal, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33
            while state do
                if state <= 46 then
                    if state <= 33 then
                        if state <= 32 then
                            if state <= 31 then
                                -- root entry 11155956 -> 1, states 1-31
                                if state <= 16 then
                                    if state <= 8 then
                                        if state <= 4 then
                                            if state <= 2 then
                                                if state <= 1 then
                                                    if state == 1 then -- entry 11155956 -> 1
                                                        r22 = allocUpvalue()
                                                        state = true
                                                        upvalueValues[r22] = state
                                                        r24 = allocUpvalue()
                                                        r7 = "string"
                                                        ReturnVal = _env[r7]
                                                        r7 = "gmatch"
                                                        state = ReturnVal[r7]
                                                        r7 = allocUpvalue()
                                                        upvalueValues[r7] = state
                                                        state = createClosure3(32, {})
                                                        upvalueValues[r24] = state
                                                        r29 = allocUpvalue()
                                                        r10 = createClosure0(33, {
                                                            r29
                                                        })
                                                        state = false
                                                        upvalueValues[r29] = state
                                                        r2 = "pcall"
                                                        r14 = _env[r2]
                                                        r2 = r14(r10)
                                                        state = r2 and (2) or (3)
                                                        r3 = args
                                                        ReturnVal = r2
                                                    end
                                                else
                                                    if state == 2 then
                                                        r14 = upvalueValues[r29]
                                                        ReturnVal = r14
                                                        state = 3
                                                    end
                                                end
                                            else
                                                if state <= 3 then
                                                    if state == 3 then
                                                        r14 = ReturnVal
                                                        r2 = "math"
                                                        ReturnVal = _env[r2]
                                                        r2 = "random"
                                                        state = ReturnVal[r2]
                                                        r2 = allocUpvalue()
                                                        upvalueValues[r2] = state
                                                        r10 = "table"
                                                        ReturnVal = _env[r10]
                                                        r10 = "concat"
                                                        state = ReturnVal[r10]
                                                        r10 = state
                                                        r12 = state
                                                        r17 = "table"
                                                        r28 = _env[r17]
                                                        state = r28 and (4) or (5)
                                                        r26 = r28
                                                    end
                                                else
                                                    if state == 4 then
                                                        r30 = "table"
                                                        r17 = _env[r30]
                                                        r30 = "unpack"
                                                        r28 = r17[r30]
                                                        r26 = r28
                                                        state = 5
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 6 then
                                                if state <= 5 then
                                                    if state == 5 then
                                                        state = r12
                                                        state = r26 and (6) or (7)
                                                        ReturnVal = r26
                                                    end
                                                else
                                                    if state == 6 then
                                                        r26 = allocUpvalue()
                                                        upvalueValues[r26] = ReturnVal
                                                        state = upvalueValues[r2]
                                                        r28 = 65
                                                        r12 = 3
                                                        ReturnVal = state(r12, r28)
                                                        r12 = allocUpvalue()
                                                        state = 0
                                                        r15 = createClosure2(34, {})
                                                        upvalueValues[r12] = ReturnVal
                                                        r28 = state
                                                        state = 0
                                                        r30 = "pcall"
                                                        ReturnVal = _env[r30]
                                                        r30 = {
                                                            ReturnVal(r15)
                                                        }
                                                        r17 = state
                                                        state = {
                                                            unpack(r30)
                                                        }
                                                        r30 = state
                                                        ReturnVal = 2
                                                        state = r30[ReturnVal]
                                                        r15 = state
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r23 = upvalueValues[r7]
                                                        r20 = "tostring"
                                                        r21 = _env[r20]
                                                        r20 = r21(r15)
                                                        r21 = ":(%d*):"
                                                        r31 = r23(r20, r21)
                                                        r23 = {
                                                            r31()
                                                        }
                                                        ReturnVal = state(unpack(r23))
                                                        r23 = allocUpvalue()
                                                        upvalueValues[r23] = ReturnVal
                                                        r31 = upvalueValues[r12]
                                                        r21 = r31
                                                        r31 = 1
                                                        r20 = r31
                                                        r31 = 0
                                                        r4 = r20 < r31
                                                        ReturnVal = 1
                                                        r31 = ReturnVal - r20
                                                        state = 8
                                                    end
                                                end
                                            else
                                                if state <= 7 then
                                                    if state == 7 then
                                                        r12 = "unpack"
                                                        r26 = _env[r12]
                                                        ReturnVal = r26
                                                        state = 6
                                                    end
                                                else
                                                    if state == 8 then
                                                        r31 = r31 + r20
                                                        r1 = not r4
                                                        ReturnVal = r31 <= r21
                                                        ReturnVal = r1 and ReturnVal
                                                        r1 = r31 >= r21
                                                        r1 = r4 and r1
                                                        ReturnVal = r1 or ReturnVal
                                                        r1 = (9)
                                                        state = ReturnVal and r1
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
                                                        r1 = allocUpvalue()
                                                        upvalueValues[r1] = r31
                                                        r16 = "math"
                                                        ReturnVal = _env[r16]
                                                        r16 = "random"
                                                        state = ReturnVal[r16]
                                                        r9 = 100
                                                        r16 = 1
                                                        ReturnVal = state(r16, r9)
                                                        r16 = allocUpvalue()
                                                        upvalueValues[r16] = ReturnVal
                                                        state = upvalueValues[r2]
                                                        r6 = 255
                                                        r9 = 0
                                                        ReturnVal = state(r9, r6)
                                                        r9 = allocUpvalue()
                                                        upvalueValues[r9] = ReturnVal
                                                        state = upvalueValues[r2]
                                                        r18 = upvalueValues[r16]
                                                        r6 = 1
                                                        ReturnVal = state(r6, r18)
                                                        r6 = allocUpvalue()
                                                        upvalueValues[r6] = ReturnVal
                                                        ReturnVal = upvalueValues[r2]
                                                        r11 = 1
                                                        r33 = 2
                                                        r18 = ReturnVal(r11, r33)
                                                        ReturnVal = 1
                                                        state = r18 == ReturnVal
                                                        r18 = allocUpvalue()
                                                        upvalueValues[r18] = state
                                                        r19 = "tostring"
                                                        r13 = _env[r19]
                                                        r27 = upvalueValues[r2]
                                                        r5 = 0
                                                        r25 = 10000
                                                        r8 = {
                                                            r27(r5, r25)
                                                        }
                                                        r19 = r13(unpack(r8))
                                                        r13 = ":"
                                                        r32 = r19 .. r13
                                                        state = "gsub"
                                                        state = r15[state]
                                                        r33 = ":"
                                                        r11 = r33 .. r32
                                                        ReturnVal = ":(%d*):"
                                                        state = state(r15, ReturnVal, r11)
                                                        r11 = allocUpvalue()
                                                        upvalueValues[r11] = state
                                                        r32 = createClosure2(35, {
                                                            r2,
                                                            r1,
                                                            r12,
                                                            r7,
                                                            r22,
                                                            r23,
                                                            r18,
                                                            r11,
                                                            r16,
                                                            r6,
                                                            r9,
                                                            r26
                                                        })
                                                        r33 = "pcall"
                                                        ReturnVal = _env[r33]
                                                        r33 = {
                                                            ReturnVal(r32)
                                                        }
                                                        state = {
                                                            unpack(r33)
                                                        }
                                                        r33 = state
                                                        state = upvalueValues[r18]
                                                        state = state and (11) or (12)
                                                    end
                                                else
                                                    if state == 10 then
                                                        r21 = upvalueValues[r22]
                                                        state = r21 and (13) or (14)
                                                        r31 = r21
                                                    end
                                                end
                                            else
                                                if state <= 11 then
                                                    if state == 11 then
                                                        r32 = upvalueValues[r22]
                                                        state = r32 and (15) or (16)
                                                        ReturnVal = r32
                                                    end
                                                else
                                                    if state == 12 then
                                                        r13 = upvalueValues[r22]
                                                        state = r13 and (17) or (18)
                                                        r32 = r13
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 14 then
                                                if state <= 13 then
                                                    if state == 13 then
                                                        r21 = r28 == r17
                                                        r31 = r21
                                                        state = 14
                                                    end
                                                else
                                                    if state == 14 then
                                                        upvalueValues[r22] = r31
                                                        state = upvalueValues[r22]
                                                        state = state and (19) or (20)
                                                    end
                                                end
                                            else
                                                if state <= 15 then
                                                    if state == 15 then
                                                        r13 = state
                                                        r8 = 1
                                                        r27 = r33[r8]
                                                        r8 = false
                                                        r19 = r27 == r8
                                                        state = r19 and (21) or (22)
                                                        r32 = r19
                                                    end
                                                else
                                                    if state == 16 then
                                                        upvalueValues[r22] = ReturnVal
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
                                                        r19 = 1
                                                        r13 = r33[r19]
                                                        r32 = r13
                                                        state = 18
                                                    end
                                                else
                                                    if state == 18 then
                                                        upvalueValues[r22] = r32
                                                        r8 = upvalueValues[r6]
                                                        r5 = 1
                                                        r27 = r8 + r5
                                                        r19 = r33[r27]
                                                        r13 = r28 + r19
                                                        r19 = 256
                                                        state = r13 % r19
                                                        r28 = state
                                                        r27 = upvalueValues[r9]
                                                        r19 = r17 + r27
                                                        r27 = 256
                                                        r13 = r19 % r27
                                                        r17 = r13
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
                                                        r8 = 2
                                                        r27 = r33[r8]
                                                        r8 = upvalueValues[r11]
                                                        r19 = r27 == r8
                                                        r32 = r19
                                                        state = 22
                                                    end
                                                else
                                                    if state == 22 then
                                                        state = r13
                                                        ReturnVal = r32
                                                        state = 16
                                                    end
                                                end
                                            else
                                                if state <= 23 then
                                                    if state == 23 then
                                                        r16 = releaseUpvalue(r16)
                                                        r1 = releaseUpvalue(r1)
                                                        r9 = releaseUpvalue(r9)
                                                        r6 = releaseUpvalue(r6)
                                                        r33 = nil
                                                        r11 = releaseUpvalue(r11)
                                                        r18 = releaseUpvalue(r18)
                                                        state = 8
                                                    end
                                                else
                                                    if state == 24 then
                                                        r29 = releaseUpvalue(r29)
                                                        r26 = releaseUpvalue(r26)
                                                        r2 = releaseUpvalue(r2)
                                                        r12 = releaseUpvalue(r12)
                                                        r7 = releaseUpvalue(r7)
                                                        r22 = releaseUpvalue(r22)
                                                        r24 = releaseUpvalue(r24)
                                                        r23 = releaseUpvalue(r23)
                                                        r24 = allocUpvalue()
                                                        r22 = nil
                                                        upvalueValues[r24] = r22
                                                        r22 = allocUpvalue()
                                                        r7 = nil
                                                        upvalueValues[r22] = r7
                                                        r14 = nil
                                                        r14 = "math"
                                                        r29 = _env[r14]
                                                        r14 = "floor"
                                                        r7 = r29[r14]
                                                        r29 = allocUpvalue()
                                                        upvalueValues[r29] = r7
                                                        r2 = "math"
                                                        r14 = _env[r2]
                                                        r2 = "random"
                                                        r7 = r14[r2]
                                                        r10 = nil
                                                        r10 = "table"
                                                        r2 = _env[r10]
                                                        r28 = nil
                                                        r28 = {}
                                                        r12 = allocUpvalue()
                                                        r17 = nil
                                                        r17 = allocUpvalue()
                                                        r10 = "remove"
                                                        r14 = r2[r10]
                                                        r30 = nil
                                                        r30 = {}
                                                        r26 = "string"
                                                        r10 = _env[r26]
                                                        r26 = "char"
                                                        r2 = r10[r26]
                                                        r26 = allocUpvalue()
                                                        r23 = 256
                                                        r10 = 0
                                                        upvalueValues[r26] = r10
                                                        r10 = 2
                                                        upvalueValues[r12] = r10
                                                        r4 = r23
                                                        r10 = {}
                                                        r23 = 1
                                                        upvalueValues[r17] = r28
                                                        r1 = r23
                                                        r23 = 0
                                                        r16 = r1 < r23
                                                        r15 = nil
                                                        r15 = 1
                                                        r23 = r15 - r1
                                                        r28 = 0
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
                                                            r24
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
                                                        r9 = not r16
                                                        r23 = r23 + r1
                                                        r15 = r23 <= r4
                                                        r15 = r9 and r15
                                                        r9 = r23 >= r4
                                                        r9 = r16 and r9
                                                        r15 = r9 or r15
                                                        r9 = (27)
                                                        state = r15 and r9
                                                        r15 = (28)
                                                        state = state or r15
                                                    end
                                                end
                                            else
                                                if state <= 27 then
                                                    if state == 27 then
                                                        r15 = r23
                                                        r9 = r15
                                                        r30[r15] = r9
                                                        r15 = nil
                                                        state = 26
                                                    end
                                                else
                                                    if state == 28 then
                                                        r23 = #r30
                                                        r4 = 0
                                                        r15 = r23 == r4
                                                        state = 29
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 30 then
                                                if state <= 29 then
                                                    if state == 29 then
                                                        r23 = 1
                                                        r4 = #r30
                                                        r15 = r7(r23, r4)
                                                        r23 = r14(r30, r15)
                                                        r4 = upvalueValues[r17]
                                                        r9 = 1
                                                        r16 = r23 - r9
                                                        r1 = r2(r16)
                                                        r15 = nil
                                                        r4[r23] = r1
                                                        r23 = nil
                                                        state = 30
                                                    end
                                                else
                                                    if state == 30 then
                                                        r23 = #r30
                                                        r4 = 0
                                                        r15 = r23 == r4
                                                        state = r15 and (31) or (29)
                                                    end
                                                end
                                            else
                                                if state == 31 then
                                                    r15 = {}
                                                    r23 = allocUpvalue()
                                                    r4 = createClosure0(51, {
                                                        r23,
                                                        r26,
                                                        r12,
                                                        r29
                                                    })
                                                    r1 = allocUpvalue()
                                                    upvalueValues[r23] = r15
                                                    r15 = allocUpvalue()
                                                    ReturnVal = {}
                                                    upvalueValues[r15] = r4
                                                    r19 = nil
                                                    r14 = nil
                                                    r2 = nil
                                                    r28 = nil
                                                    r16 = "setmetatable"
                                                    r33 = "__metatable"
                                                    r30 = nil
                                                    r4 = {}
                                                    r9 = {}
                                                    upvalueValues[r1] = r4
                                                    r29 = releaseUpvalue(r29)
                                                    r4 = _env[r16]
                                                    r11 = upvalueValues[r1]
                                                    r18 = "__index"
                                                    r6 = {
                                                        [r18] = r11,
                                                        [r33] = r19
                                                    }
                                                    r29 = "game"
                                                    r16 = r4(r9, r6)
                                                    r4 = createClosure5(57, {
                                                        r1,
                                                        r23,
                                                        r17,
                                                        r26,
                                                        r12,
                                                        r15
                                                    })
                                                    r15 = releaseUpvalue(r15)
                                                    r23 = releaseUpvalue(r23)
                                                    r26 = releaseUpvalue(r26)
                                                    r17 = releaseUpvalue(r17)
                                                    r1 = releaseUpvalue(r1)
                                                    upvalueValues[r22] = r16
                                                    r12 = releaseUpvalue(r12)
                                                    upvalueValues[r24] = r4
                                                    r7 = nil
                                                    r7 = _env[r29]
                                                    r2 = upvalueValues[r22]
                                                    r29 = "GetService"
                                                    r10 = nil
                                                    r10 = upvalueValues[r24]
                                                    r28 = 26580410478681
                                                    r12 = "\201\142\255\229\011\246\167\194\230\228.\222\016^\129"
                                                    r26 = r10(r12, r28)
                                                    r14 = r2[r26]
                                                    r29 = r7[r29]
                                                    r29 = r29(r7, r14)
                                                    r7 = allocUpvalue()
                                                    upvalueValues[r7] = r29
                                                    r29 = 556928
                                                    r14 = allocUpvalue()
                                                    upvalueValues[r14] = r29
                                                    r29 = createClosure4(64, {
                                                        r22,
                                                        r24,
                                                        r7,
                                                        r14
                                                    })
                                                    r14 = releaseUpvalue(r14)
                                                    r2 = r29()
                                                    r7 = releaseUpvalue(r7)
                                                    r22 = releaseUpvalue(r22)
                                                    r29 = nil
                                                    r24 = releaseUpvalue(r24)
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure3 entry 2247813 -> 32, states 32-32
                                if state == 32 then -- entry 2247813 -> 32
                                    ReturnVal = "error"
                                    state = _env[ReturnVal]
                                    r3 = "Tamper Detected!"
                                    ReturnVal = state(r3)
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            -- createClosure0 entry 10455241 -> 33, states 33-33
                            if state == 33 then -- entry 10455241 -> 33
                                state = true
                                upvalueValues[upvalues[1]] = state
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    else
                        if state <= 34 then
                            -- createClosure2 entry 7735615 -> 34, states 34-34
                            if state == 34 then -- entry 7735615 -> 34
                                r7 = 13678260
                                r22 = "R5Pgh2VMVw4Dm"
                                r3 = r22 ^ r7
                                ReturnVal = 2609723
                                state = ReturnVal - r3
                                r3 = state
                                ReturnVal = "gqFCBeW0e"
                                state = ReturnVal / r3
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        else
                            -- createClosure2 entry 14218492 -> 35, states 35-46
                            if state <= 40 then
                                if state <= 37 then
                                    if state <= 36 then
                                        if state <= 35 then
                                            if state == 35 then -- entry 14218492 -> 35
                                                r22 = upvalueValues[upvalues[1]]
                                                r29 = 2
                                                r24 = 1
                                                r7 = r22(r24, r29)
                                                r22 = 1
                                                r3 = r7 == r22
                                                state = r3 and (36) or (37)
                                                ReturnVal = r3
                                            end
                                        else
                                            if state == 36 then
                                                state = ReturnVal and (38) or (39)
                                            end
                                        end
                                    else
                                        if state == 37 then
                                            r22 = upvalueValues[upvalues[2]]
                                            r7 = upvalueValues[upvalues[3]]
                                            r3 = r22 == r7
                                            ReturnVal = r3
                                            state = 36
                                        end
                                    end
                                else
                                    if state <= 39 then
                                        if state <= 38 then
                                            if state == 38 then
                                                ReturnVal = "tonumber"
                                                state = _env[ReturnVal]
                                                r3 = upvalueValues[upvalues[4]]
                                                r26 = createClosure1(68, {})
                                                r24 = "tostring"
                                                r7 = _env[r24]
                                                r10 = "pcall"
                                                r2 = _env[r10]
                                                r10 = {
                                                    r2(r26)
                                                }
                                                r14 = {
                                                    unpack(r10)
                                                }
                                                r2 = 2
                                                r29 = r14[r2]
                                                r24 = r7(r29)
                                                r7 = ":(%d*):"
                                                r22 = r3(r24, r7)
                                                r3 = {
                                                    r22()
                                                }
                                                ReturnVal = state(unpack(r3))
                                                r3 = ReturnVal
                                                r22 = upvalueValues[upvalues[5]]
                                                state = r22 and (40) or (41)
                                                ReturnVal = r22
                                            end
                                        else
                                            if state == 39 then
                                                state = upvalueValues[upvalues[7]]
                                                state = state and (42) or (43)
                                            end
                                        end
                                    else
                                        if state == 40 then
                                            r7 = upvalueValues[upvalues[6]]
                                            r22 = r7 == r3
                                            ReturnVal = r22
                                            state = 41
                                        end
                                    end
                                end
                            else
                                if state <= 43 then
                                    if state <= 42 then
                                        if state <= 41 then
                                            if state == 41 then
                                                upvalueValues[upvalues[5]] = ReturnVal
                                                r3 = nil
                                                state = 39
                                            end
                                        else
                                            if state == 42 then
                                                r3 = "error"
                                                state = _env[r3]
                                                r22 = upvalueValues[upvalues[8]]
                                                r7 = 0
                                                r3 = state(r22, r7)
                                                state = 43
                                            end
                                        end
                                    else
                                        if state == 43 then
                                            r7 = upvalueValues[upvalues[9]]
                                            r24 = r7
                                            state = {}
                                            r3 = state
                                            r7 = 1
                                            r29 = r7
                                            r7 = 0
                                            r14 = r29 < r7
                                            r22 = 1
                                            r7 = r22 - r29
                                            state = 44
                                        end
                                    end
                                else
                                    if state <= 45 then
                                        if state <= 44 then
                                            if state == 44 then
                                                r7 = r7 + r29
                                                r22 = r7 <= r24
                                                r2 = not r14
                                                r22 = r2 and r22
                                                r2 = r7 >= r24
                                                r2 = r14 and r2
                                                r22 = r2 or r22
                                                r2 = (45)
                                                state = r22 and r2
                                                r22 = (46)
                                                state = state or r22
                                            end
                                        else
                                            if state == 45 then
                                                r22 = r7
                                                state = upvalueValues[upvalues[1]]
                                                r10 = 0
                                                r26 = 255
                                                r2 = state(r10, r26)
                                                r3[r22] = r2
                                                r22 = nil
                                                state = 44
                                            end
                                        end
                                    else
                                        if state == 46 then
                                            state = upvalueValues[upvalues[10]]
                                            r22 = upvalueValues[upvalues[11]]
                                            r3[state] = r22
                                            state = upvalueValues[upvalues[12]]
                                            r22 = {
                                                state(r3)
                                            }
                                            ReturnVal = {
                                                unpack(r22)
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 63 then
                        if state <= 56 then
                            if state <= 50 then
                                -- createClosure5 entry 11715666 -> 47, states 47-50
                                if state <= 48 then
                                    if state <= 47 then
                                        if state == 47 then -- entry 11715666 -> 47
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
                                            r3 = "l1"
                                            ReturnVal = _env[r3]
                                            r3 = "l1"
                                            _env[r3] = state
                                            r3 = "l2"
                                            _env[r3] = ReturnVal
                                            r3 = upvalueValues[upvalues[1]]
                                            r22 = r3()
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
                                -- createClosure0 entry 9517456 -> 51, states 51-56
                                if state <= 53 then
                                    if state <= 52 then
                                        if state <= 51 then
                                            if state == 51 then -- entry 9517456 -> 51
                                                r3 = upvalueValues[upvalues[1]]
                                                ReturnVal = #r3
                                                r3 = 0
                                                state = ReturnVal == r3
                                                state = state and (52) or (53)
                                            end
                                        else
                                            if state == 52 then
                                                r22 = upvalueValues[upvalues[2]]
                                                r7 = 49
                                                r3 = r22 * r7
                                                r22 = 235147542637
                                                ReturnVal = r3 + r22
                                                r3 = 35184372088832
                                                state = ReturnVal % r3
                                                upvalueValues[upvalues[2]] = state
                                                r3 = upvalueValues[upvalues[3]]
                                                r22 = 1
                                                ReturnVal = r3 ~= r22
                                                state = 54
                                            end
                                        end
                                    else
                                        if state == 53 then
                                            r7 = "table"
                                            r22 = _env[r7]
                                            r7 = "remove"
                                            r3 = r22[r7]
                                            r7 = upvalueValues[upvalues[1]]
                                            r22 = {
                                                r3(r7)
                                            }
                                            ReturnVal = {
                                                unpack(r22)
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    if state <= 55 then
                                        if state <= 54 then
                                            if state == 54 then
                                                r22 = upvalueValues[upvalues[3]]
                                                r7 = 86
                                                r3 = r22 * r7
                                                r22 = 257
                                                ReturnVal = r3 % r22
                                                upvalueValues[upvalues[3]] = ReturnVal
                                                state = 55
                                            end
                                        else
                                            if state == 55 then
                                                r22 = upvalueValues[upvalues[3]]
                                                r7 = 1
                                                r3 = r22 ~= r7
                                                state = r3 and (56) or (54)
                                            end
                                        end
                                    else
                                        if state == 56 then
                                            r26 = 2
                                            r7 = 32
                                            r22 = upvalueValues[upvalues[3]]
                                            r3 = r22 % r7
                                            r24 = upvalueValues[upvalues[4]]
                                            r2 = upvalueValues[upvalues[2]]
                                            r15 = upvalueValues[upvalues[3]]
                                            r30 = r15 - r3
                                            r15 = 32
                                            r17 = r30 / r15
                                            r28 = 13
                                            r12 = r28 - r17
                                            r10 = r26 ^ r12
                                            r14 = r2 / r10
                                            r29 = r24(r14)
                                            r24 = 4294967296
                                            r7 = r29 % r24
                                            r29 = 2
                                            r24 = r29 ^ r3
                                            r22 = r7 / r24
                                            r28 = 256
                                            r3 = nil
                                            r10 = 1
                                            r24 = upvalueValues[upvalues[4]]
                                            r26 = 256
                                            r2 = r22 % r10
                                            r10 = 4294967296
                                            r14 = r2 * r10
                                            r29 = r24(r14)
                                            r24 = upvalueValues[upvalues[4]]
                                            r2 = 65536
                                            r14 = r24(r22)
                                            r7 = r29 + r14
                                            r29 = 65536
                                            r24 = r7 % r29
                                            r22 = nil
                                            r14 = r7 - r24
                                            r29 = r14 / r2
                                            r2 = 256
                                            r14 = r24 % r2
                                            r10 = r24 - r14
                                            r2 = r10 / r26
                                            r24 = nil
                                            r26 = 256
                                            r10 = r29 % r26
                                            r12 = r29 - r10
                                            r26 = r12 / r28
                                            r29 = nil
                                            r12 = {
                                                r14,
                                                r2,
                                                r10,
                                                r26
                                            }
                                            r14 = nil
                                            r26 = nil
                                            r10 = nil
                                            upvalueValues[upvalues[1]] = r12
                                            r2 = nil
                                            r7 = nil
                                            state = 53
                                        end
                                    end
                                end
                            end
                        else
                            -- createClosure5 entry 11590331 -> 57, states 57-63
                            if state <= 60 then
                                if state <= 58 then
                                    if state <= 57 then
                                        if state == 57 then -- entry 11590331 -> 57
                                            state = upvalueValues[upvalues[1]]
                                            r7 = state
                                            r22 = args[2]
                                            state = r7[r22]
                                            state = state and (58) or (59)
                                            r3 = args[1]
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
                                            r24 = ReturnVal
                                            r29 = 35184372088832
                                            ReturnVal = r22 % r29
                                            upvalueValues[upvalues[4]] = ReturnVal
                                            r2 = 255
                                            r14 = r22 % r2
                                            r2 = 2
                                            r29 = r14 + r2
                                            upvalueValues[upvalues[5]] = r29
                                            r12 = 1
                                            r28 = r12
                                            r10 = "string"
                                            r2 = _env[r10]
                                            r10 = "len"
                                            r14 = r2[r10]
                                            r2 = r14(r3)
                                            r14 = ""
                                            r7[r22] = r14
                                            r12 = 0
                                            r17 = r28 < r12
                                            r10 = 1
                                            r12 = r10 - r28
                                            r26 = r2
                                            r14 = 32
                                            state = 61
                                        end
                                    else
                                        if state == 60 then
                                            ReturnVal = {
                                                r22
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            else
                                if state <= 62 then
                                    if state <= 61 then
                                        if state == 61 then
                                            r30 = not r17
                                            r12 = r12 + r28
                                            r10 = r12 <= r26
                                            r10 = r30 and r10
                                            r30 = r12 >= r26
                                            r30 = r17 and r30
                                            r10 = r30 or r10
                                            r30 = (62)
                                            state = r10 and r30
                                            r10 = (63)
                                            state = state or r10
                                        end
                                    else
                                        if state == 62 then
                                            r20 = "string"
                                            r21 = _env[r20]
                                            r10 = r12
                                            r20 = "byte"
                                            r31 = r21[r20]
                                            r21 = r31(r3, r10)
                                            r10 = nil
                                            r31 = upvalueValues[upvalues[6]]
                                            r20 = r31()
                                            r23 = r21 + r20
                                            r15 = r23 + r14
                                            r23 = 256
                                            r30 = r15 % r23
                                            r14 = r30
                                            r23 = r7[r22]
                                            r20 = 1
                                            r21 = r14 + r20
                                            r31 = r24[r21]
                                            r15 = r23 .. r31
                                            r7[r22] = r15
                                            state = 61
                                        end
                                    end
                                else
                                    if state == 63 then
                                        r2 = nil
                                        r24 = nil
                                        r14 = nil
                                        state = 60
                                    end
                                end
                            end
                        end
                    else
                        if state <= 67 then
                            -- createClosure4 entry 15059480 -> 64, states 64-67
                            if state <= 65 then
                                if state <= 64 then
                                    if state == 64 then -- entry 15059480 -> 64
                                        ReturnVal = "pairs"
                                        state = _env[ReturnVal]
                                        r29 = "game"
                                        r24 = _env[r29]
                                        r14 = upvalueValues[upvalues[1]]
                                        r2 = upvalueValues[upvalues[2]]
                                        r26 = "\233\252\184\181C\0240"
                                        r12 = 18345328402782
                                        r10 = r2(r26, r12)
                                        r29 = r14[r10]
                                        r7 = r24[r29]
                                        r29 = "GetPlayers"
                                        r29 = r7[r29]
                                        r24 = {
                                            r29(r7)
                                        }
                                        r7 = {
                                            state(unpack(r24))
                                        }
                                        ReturnVal = r7[1]
                                        r22 = r7[3]
                                        r3 = r7[2]
                                        r7 = ReturnVal
                                        state = 65
                                    end
                                else
                                    if state == 65 then
                                        r22, r29 = r7(r3, r22)
                                        state = r22 and (66) or (67)
                                    end
                                end
                            else
                                if state <= 66 then
                                    if state == 66 then
                                        r24 = r22
                                        state = upvalueValues[upvalues[3]]
                                        r14 = "Teleport"
                                        r14 = state[r14]
                                        r24 = nil
                                        r2 = upvalueValues[upvalues[4]]
                                        r14 = r14(state, r2, r29)
                                        r29 = nil
                                        state = 65
                                    end
                                else
                                    if state == 67 then
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        else
                            -- createClosure1 entry 3481433 -> 68, states 68-68
                            if state == 68 then -- entry 3481433 -> 68
                                r22 = "B9t"
                                r7 = 16053679
                                r3 = r22 ^ r7
                                ReturnVal = 7676704
                                state = ReturnVal - r3
                                r3 = state
                                ReturnVal = "O2xBidP89A1A"
                                state = ReturnVal / r3
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
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
            end
            return closure
        end
        upvalueRefCounts = {}
        currentUpvalueId = 0
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -4185641
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -4185641
                    end
                })
            end
        end
        upvalueValues = {}
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)