return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure5, releaseUpvalues, createClosure4, upvalueRefCounts, createClosure1, upvalueValues, currentUpvalueId, releaseUpvalue, createClosure3, createClosure, createClosure2, allocUpvalue, vm, createUpvalueProxy)
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        currentUpvalueId = 0
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, ReturnVal, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33
            while state do
                if state <= 49 then
                    if state <= 36 then
                        if state <= 35 then
                            if state <= 34 then
                                -- root entry 1514421 -> 1, states 1-34
                                if state <= 17 then
                                    if state <= 9 then
                                        if state <= 5 then
                                            if state <= 3 then
                                                if state <= 2 then
                                                    if state <= 1 then
                                                        if state == 1 then -- entry 1514421 -> 1
                                                            r3 = allocUpvalue()
                                                            r25 = allocUpvalue()
                                                            state = true
                                                            upvalueValues[r3] = state
                                                            r17 = createClosure3(35, {
                                                                r25
                                                            })
                                                            r16 = "string"
                                                            ReturnVal = _env[r16]
                                                            r16 = "gmatch"
                                                            state = ReturnVal[r16]
                                                            r8 = allocUpvalue()
                                                            r16 = allocUpvalue()
                                                            upvalueValues[r16] = state
                                                            state = createClosure5(36, {})
                                                            upvalueValues[r8] = state
                                                            state = false
                                                            upvalueValues[r25] = state
                                                            r7 = "pcall"
                                                            r5 = _env[r7]
                                                            r7 = r5(r17)
                                                            state = r7 and (2) or (3)
                                                            r10 = args
                                                            ReturnVal = r7
                                                        end
                                                    else
                                                        if state == 2 then
                                                            r5 = upvalueValues[r25]
                                                            ReturnVal = r5
                                                            state = 3
                                                        end
                                                    end
                                                else
                                                    if state == 3 then
                                                        r5 = ReturnVal
                                                        r7 = "math"
                                                        ReturnVal = _env[r7]
                                                        r7 = "random"
                                                        state = ReturnVal[r7]
                                                        r7 = allocUpvalue()
                                                        upvalueValues[r7] = state
                                                        r17 = "table"
                                                        ReturnVal = _env[r17]
                                                        r17 = "concat"
                                                        state = ReturnVal[r17]
                                                        r24 = state
                                                        r17 = state
                                                        r11 = "table"
                                                        r22 = _env[r11]
                                                        state = r22 and (4) or (5)
                                                        r21 = r22
                                                    end
                                                end
                                            else
                                                if state <= 4 then
                                                    if state == 4 then
                                                        r2 = "table"
                                                        r11 = _env[r2]
                                                        r2 = "unpack"
                                                        r22 = r11[r2]
                                                        r21 = r22
                                                        state = 5
                                                    end
                                                else
                                                    if state == 5 then
                                                        state = r24
                                                        state = r21 and (6) or (7)
                                                        ReturnVal = r21
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 7 then
                                                if state <= 6 then
                                                    if state == 6 then
                                                        r21 = allocUpvalue()
                                                        upvalueValues[r21] = ReturnVal
                                                        state = upvalueValues[r7]
                                                        r24 = 3
                                                        r22 = 65
                                                        ReturnVal = state(r24, r22)
                                                        r24 = allocUpvalue()
                                                        upvalueValues[r24] = ReturnVal
                                                        state = 0
                                                        r22 = state
                                                        r13 = createClosure2(37, {})
                                                        r2 = "pcall"
                                                        ReturnVal = _env[r2]
                                                        state = 0
                                                        r2 = {
                                                            ReturnVal(r13)
                                                        }
                                                        r11 = state
                                                        state = {
                                                            unpack(r2)
                                                        }
                                                        r2 = state
                                                        ReturnVal = 2
                                                        state = r2[ReturnVal]
                                                        r13 = state
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r29 = upvalueValues[r16]
                                                        r4 = "tostring"
                                                        r32 = _env[r4]
                                                        r4 = r32(r13)
                                                        r32 = ":(%d*):"
                                                        r18 = r29(r4, r32)
                                                        r29 = {
                                                            r18()
                                                        }
                                                        ReturnVal = state(unpack(r29))
                                                        r29 = allocUpvalue()
                                                        upvalueValues[r29] = ReturnVal
                                                        r18 = upvalueValues[r24]
                                                        r32 = r18
                                                        r18 = 1
                                                        r4 = r18
                                                        r18 = 0
                                                        r28 = r4 < r18
                                                        ReturnVal = 1
                                                        r18 = ReturnVal - r4
                                                        state = 8
                                                    end
                                                else
                                                    if state == 7 then
                                                        r24 = "unpack"
                                                        r21 = _env[r24]
                                                        ReturnVal = r21
                                                        state = 6
                                                    end
                                                end
                                            else
                                                if state <= 8 then
                                                    if state == 8 then
                                                        r18 = r18 + r4
                                                        r14 = not r28
                                                        ReturnVal = r18 <= r32
                                                        ReturnVal = r14 and ReturnVal
                                                        r14 = r18 >= r32
                                                        r14 = r28 and r14
                                                        ReturnVal = r14 or ReturnVal
                                                        r14 = (9)
                                                        state = ReturnVal and r14
                                                        ReturnVal = (10)
                                                        state = state or ReturnVal
                                                    end
                                                else
                                                    if state == 9 then
                                                        r14 = allocUpvalue()
                                                        upvalueValues[r14] = r18
                                                        r31 = "math"
                                                        ReturnVal = _env[r31]
                                                        r31 = "random"
                                                        state = ReturnVal[r31]
                                                        r9 = 100
                                                        r31 = 1
                                                        ReturnVal = state(r31, r9)
                                                        r31 = allocUpvalue()
                                                        upvalueValues[r31] = ReturnVal
                                                        state = upvalueValues[r7]
                                                        r30 = 255
                                                        r9 = 0
                                                        ReturnVal = state(r9, r30)
                                                        r9 = allocUpvalue()
                                                        upvalueValues[r9] = ReturnVal
                                                        state = upvalueValues[r7]
                                                        r6 = upvalueValues[r31]
                                                        r30 = 1
                                                        ReturnVal = state(r30, r6)
                                                        r30 = allocUpvalue()
                                                        upvalueValues[r30] = ReturnVal
                                                        ReturnVal = upvalueValues[r7]
                                                        r27 = 2
                                                        r15 = 1
                                                        r6 = ReturnVal(r15, r27)
                                                        ReturnVal = 1
                                                        state = r6 == ReturnVal
                                                        r6 = allocUpvalue()
                                                        upvalueValues[r6] = state
                                                        r20 = "tostring"
                                                        r23 = _env[r20]
                                                        r26 = upvalueValues[r7]
                                                        r1 = 0
                                                        r19 = 10000
                                                        r33 = {
                                                            r26(r1, r19)
                                                        }
                                                        r20 = r23(unpack(r33))
                                                        r23 = ":"
                                                        r12 = r20 .. r23
                                                        state = "gsub"
                                                        state = r13[state]
                                                        r27 = ":"
                                                        r15 = r27 .. r12
                                                        ReturnVal = ":(%d*):"
                                                        state = state(r13, ReturnVal, r15)
                                                        r15 = allocUpvalue()
                                                        r12 = createClosure2(38, {
                                                            r7,
                                                            r14,
                                                            r24,
                                                            r16,
                                                            r3,
                                                            r29,
                                                            r6,
                                                            r15,
                                                            r31,
                                                            r30,
                                                            r9,
                                                            r21
                                                        })
                                                        upvalueValues[r15] = state
                                                        r27 = "pcall"
                                                        ReturnVal = _env[r27]
                                                        r27 = {
                                                            ReturnVal(r12)
                                                        }
                                                        state = {
                                                            unpack(r27)
                                                        }
                                                        r27 = state
                                                        state = upvalueValues[r6]
                                                        state = state and (11) or (12)
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 13 then
                                            if state <= 11 then
                                                if state <= 10 then
                                                    if state == 10 then
                                                        r32 = upvalueValues[r3]
                                                        state = r32 and (13) or (14)
                                                        r18 = r32
                                                    end
                                                else
                                                    if state == 11 then
                                                        r12 = upvalueValues[r3]
                                                        state = r12 and (15) or (16)
                                                        ReturnVal = r12
                                                    end
                                                end
                                            else
                                                if state <= 12 then
                                                    if state == 12 then
                                                        r23 = upvalueValues[r3]
                                                        state = r23 and (17) or (18)
                                                        r12 = r23
                                                    end
                                                else
                                                    if state == 13 then
                                                        r32 = r22 == r11
                                                        r18 = r32
                                                        state = 14
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 15 then
                                                if state <= 14 then
                                                    if state == 14 then
                                                        upvalueValues[r3] = r18
                                                        state = upvalueValues[r3]
                                                        state = state and (19) or (20)
                                                    end
                                                else
                                                    if state == 15 then
                                                        r23 = state
                                                        r33 = 1
                                                        r26 = r27[r33]
                                                        r33 = false
                                                        r20 = r26 == r33
                                                        state = r20 and (21) or (22)
                                                        r12 = r20
                                                    end
                                                end
                                            else
                                                if state <= 16 then
                                                    if state == 16 then
                                                        upvalueValues[r3] = ReturnVal
                                                        state = 23
                                                    end
                                                else
                                                    if state == 17 then
                                                        r20 = 1
                                                        r23 = r27[r20]
                                                        r12 = r23
                                                        state = 18
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    if state <= 26 then
                                        if state <= 22 then
                                            if state <= 20 then
                                                if state <= 19 then
                                                    if state <= 18 then
                                                        if state == 18 then
                                                            upvalueValues[r3] = r12
                                                            r33 = upvalueValues[r30]
                                                            r1 = 1
                                                            r26 = r33 + r1
                                                            r20 = r27[r26]
                                                            r23 = r22 + r20
                                                            r20 = 256
                                                            state = r23 % r20
                                                            r22 = state
                                                            r26 = upvalueValues[r9]
                                                            r20 = r11 + r26
                                                            r26 = 256
                                                            r23 = r20 % r26
                                                            r11 = r23
                                                            state = 23
                                                        end
                                                    else
                                                        if state == 19 then
                                                            state = 24
                                                        end
                                                    end
                                                else
                                                    if state == 20 then
                                                        state = true
                                                        state = 25
                                                    end
                                                end
                                            else
                                                if state <= 21 then
                                                    if state == 21 then
                                                        r33 = 2
                                                        r26 = r27[r33]
                                                        r33 = upvalueValues[r15]
                                                        r20 = r26 == r33
                                                        r12 = r20
                                                        state = 22
                                                    end
                                                else
                                                    if state == 22 then
                                                        state = r23
                                                        ReturnVal = r12
                                                        state = 16
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 24 then
                                                if state <= 23 then
                                                    if state == 23 then
                                                        r15 = releaseUpvalue(r15)
                                                        r27 = nil
                                                        r9 = releaseUpvalue(r9)
                                                        r6 = releaseUpvalue(r6)
                                                        r31 = releaseUpvalue(r31)
                                                        r14 = releaseUpvalue(r14)
                                                        r30 = releaseUpvalue(r30)
                                                        state = 8
                                                    end
                                                else
                                                    if state == 24 then
                                                        r17 = nil
                                                        r21 = releaseUpvalue(r21)
                                                        r21 = "string"
                                                        r24 = releaseUpvalue(r24)
                                                        r13 = nil
                                                        r11 = nil
                                                        r11 = allocUpvalue()
                                                        r7 = releaseUpvalue(r7)
                                                        r22 = nil
                                                        r29 = releaseUpvalue(r29)
                                                        r5 = nil
                                                        r25 = releaseUpvalue(r25)
                                                        r8 = releaseUpvalue(r8)
                                                        r3 = releaseUpvalue(r3)
                                                        r2 = nil
                                                        r3 = nil
                                                        r16 = releaseUpvalue(r16)
                                                        r5 = "math"
                                                        r25 = _env[r5]
                                                        r7 = "math"
                                                        r22 = {}
                                                        r16 = nil
                                                        r5 = "floor"
                                                        r8 = r25[r5]
                                                        r25 = allocUpvalue()
                                                        upvalueValues[r25] = r8
                                                        r5 = _env[r7]
                                                        r7 = "random"
                                                        r8 = r5[r7]
                                                        r29 = 256
                                                        r17 = "table"
                                                        r7 = _env[r17]
                                                        r17 = "remove"
                                                        r5 = r7[r17]
                                                        r17 = _env[r21]
                                                        r24 = allocUpvalue()
                                                        r21 = "char"
                                                        r7 = r17[r21]
                                                        r21 = allocUpvalue()
                                                        r2 = {}
                                                        r17 = 0
                                                        upvalueValues[r21] = r17
                                                        r17 = 2
                                                        upvalueValues[r24] = r17
                                                        r17 = {}
                                                        upvalueValues[r11] = r22
                                                        r28 = r29
                                                        r29 = 1
                                                        r14 = r29
                                                        r29 = 0
                                                        r31 = r14 < r29
                                                        r13 = 1
                                                        r29 = r13 - r14
                                                        r22 = 0
                                                        state = 26
                                                    end
                                                end
                                            else
                                                if state <= 25 then
                                                    if state == 25 then
                                                        state = createClosure4(50, {
                                                            r8
                                                        })
                                                        r32 = {
                                                            state()
                                                        }
                                                        ReturnVal = {
                                                            unpack(r32)
                                                        }
                                                        state = nil
                                                    end
                                                else
                                                    if state == 26 then
                                                        r9 = not r31
                                                        r29 = r29 + r14
                                                        r13 = r29 <= r28
                                                        r13 = r9 and r13
                                                        r9 = r29 >= r28
                                                        r9 = r31 and r9
                                                        r13 = r9 or r13
                                                        r9 = (27)
                                                        state = r13 and r9
                                                        r13 = (28)
                                                        state = state or r13
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 30 then
                                            if state <= 28 then
                                                if state <= 27 then
                                                    if state == 27 then
                                                        r13 = r29
                                                        r9 = r13
                                                        r2[r13] = r9
                                                        r13 = nil
                                                        state = 26
                                                    end
                                                else
                                                    if state == 28 then
                                                        r29 = #r2
                                                        r28 = 0
                                                        r13 = r29 == r28
                                                        state = 29
                                                    end
                                                end
                                            else
                                                if state <= 29 then
                                                    if state == 29 then
                                                        r9 = 1
                                                        r28 = #r2
                                                        r29 = 1
                                                        r13 = r8(r29, r28)
                                                        r29 = r5(r2, r13)
                                                        r13 = nil
                                                        r28 = upvalueValues[r11]
                                                        r31 = r29 - r9
                                                        r14 = r7(r31)
                                                        r28[r29] = r14
                                                        r29 = nil
                                                        state = 30
                                                    end
                                                else
                                                    if state == 30 then
                                                        r29 = #r2
                                                        r28 = 0
                                                        r13 = r29 == r28
                                                        state = r13 and (31) or (29)
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 32 then
                                                if state <= 31 then
                                                    if state == 31 then
                                                        r14 = allocUpvalue()
                                                        r13 = {}
                                                        r29 = allocUpvalue()
                                                        upvalueValues[r29] = r13
                                                        r28 = createClosure1(54, {
                                                            r29,
                                                            r21,
                                                            r24,
                                                            r25
                                                        })
                                                        r7 = nil
                                                        r13 = allocUpvalue()
                                                        upvalueValues[r13] = r28
                                                        r27 = "__metatable"
                                                        r22 = nil
                                                        r28 = {}
                                                        upvalueValues[r14] = r28
                                                        r9 = {}
                                                        r25 = releaseUpvalue(r25)
                                                        r31 = "setmetatable"
                                                        r28 = _env[r31]
                                                        r15 = upvalueValues[r14]
                                                        r20 = nil
                                                        r6 = "__index"
                                                        r30 = {
                                                            [r6] = r15,
                                                            [r27] = r20
                                                        }
                                                        r5 = nil
                                                        r8 = nil
                                                        r2 = nil
                                                        r31 = r28(r9, r30)
                                                        r28 = createClosure4(60, {
                                                            r14,
                                                            r29,
                                                            r11,
                                                            r21,
                                                            r24,
                                                            r13
                                                        })
                                                        r14 = releaseUpvalue(r14)
                                                        r3 = r28
                                                        r16 = r31
                                                        r24 = releaseUpvalue(r24)
                                                        r5 = createClosure4(67, {})
                                                        r25 = "pcall"
                                                        r8 = _env[r25]
                                                        r25 = r8(r5)
                                                        r11 = releaseUpvalue(r11)
                                                        r17 = nil
                                                        state = r25 and (32) or (33)
                                                        r21 = releaseUpvalue(r21)
                                                        r29 = releaseUpvalue(r29)
                                                        r13 = releaseUpvalue(r13)
                                                    end
                                                else
                                                    if state == 32 then
                                                        r5 = "print"
                                                        r8 = _env[r5]
                                                        r21 = "ag\131\210"
                                                        r24 = 8833244811281
                                                        r17 = r3(r21, r24)
                                                        r7 = r16[r17]
                                                        r5 = r8(r7)
                                                        state = 34
                                                    end
                                                end
                                            else
                                                if state <= 33 then
                                                    if state == 33 then
                                                        r5 = "print"
                                                        r8 = _env[r5]
                                                        r24 = 7930842041965
                                                        r21 = "k\147\192\000A\166L\151"
                                                        r17 = r3(r21, r24)
                                                        r7 = r16[r17]
                                                        r5 = r8(r7)
                                                        state = 34
                                                    end
                                                else
                                                    if state == 34 then
                                                        r16 = nil
                                                        r25 = nil
                                                        r3 = nil
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure3 entry 15261030 -> 35, states 35-35
                                if state == 35 then -- entry 15261030 -> 35
                                    state = true
                                    upvalueValues[upvalues[1]] = state
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            -- createClosure5 entry 5021318 -> 36, states 36-36
                            if state == 36 then -- entry 5021318 -> 36
                                ReturnVal = "error"
                                state = _env[ReturnVal]
                                r10 = "Tamper Detected!"
                                ReturnVal = state(r10)
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    else
                        if state <= 37 then
                            -- createClosure2 entry 15511263 -> 37, states 37-37
                            if state == 37 then -- entry 15511263 -> 37
                                r3 = "Lh7H"
                                r16 = 16132933
                                r10 = r3 ^ r16
                                ReturnVal = 8933249
                                state = ReturnVal - r10
                                r10 = state
                                ReturnVal = "ycpgXgr138A"
                                state = ReturnVal / r10
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        else
                            -- createClosure2 entry 13520358 -> 38, states 38-49
                            if state <= 43 then
                                if state <= 40 then
                                    if state <= 39 then
                                        if state <= 38 then
                                            if state == 38 then -- entry 13520358 -> 38
                                                r3 = upvalueValues[upvalues[1]]
                                                r8 = 1
                                                r25 = 2
                                                r16 = r3(r8, r25)
                                                r3 = 1
                                                r10 = r16 == r3
                                                state = r10 and (39) or (40)
                                                ReturnVal = r10
                                            end
                                        else
                                            if state == 39 then
                                                state = ReturnVal and (41) or (42)
                                            end
                                        end
                                    else
                                        if state == 40 then
                                            r3 = upvalueValues[upvalues[2]]
                                            r16 = upvalueValues[upvalues[3]]
                                            r10 = r3 == r16
                                            ReturnVal = r10
                                            state = 39
                                        end
                                    end
                                else
                                    if state <= 42 then
                                        if state <= 41 then
                                            if state == 41 then
                                                ReturnVal = "tonumber"
                                                state = _env[ReturnVal]
                                                r10 = upvalueValues[upvalues[4]]
                                                r21 = createClosure1(68, {})
                                                r8 = "tostring"
                                                r16 = _env[r8]
                                                r17 = "pcall"
                                                r7 = _env[r17]
                                                r17 = {
                                                    r7(r21)
                                                }
                                                r5 = {
                                                    unpack(r17)
                                                }
                                                r7 = 2
                                                r25 = r5[r7]
                                                r8 = r16(r25)
                                                r16 = ":(%d*):"
                                                r3 = r10(r8, r16)
                                                r10 = {
                                                    r3()
                                                }
                                                ReturnVal = state(unpack(r10))
                                                r10 = ReturnVal
                                                r3 = upvalueValues[upvalues[5]]
                                                state = r3 and (43) or (44)
                                                ReturnVal = r3
                                            end
                                        else
                                            if state == 42 then
                                                state = upvalueValues[upvalues[7]]
                                                state = state and (45) or (46)
                                            end
                                        end
                                    else
                                        if state == 43 then
                                            r16 = upvalueValues[upvalues[6]]
                                            r3 = r16 == r10
                                            ReturnVal = r3
                                            state = 44
                                        end
                                    end
                                end
                            else
                                if state <= 46 then
                                    if state <= 45 then
                                        if state <= 44 then
                                            if state == 44 then
                                                r10 = nil
                                                upvalueValues[upvalues[5]] = ReturnVal
                                                state = 42
                                            end
                                        else
                                            if state == 45 then
                                                r10 = "error"
                                                state = _env[r10]
                                                r3 = upvalueValues[upvalues[8]]
                                                r16 = 0
                                                r10 = state(r3, r16)
                                                state = 46
                                            end
                                        end
                                    else
                                        if state == 46 then
                                            r16 = upvalueValues[upvalues[9]]
                                            r8 = r16
                                            state = {}
                                            r10 = state
                                            r16 = 1
                                            r25 = r16
                                            r16 = 0
                                            r5 = r25 < r16
                                            r3 = 1
                                            r16 = r3 - r25
                                            state = 47
                                        end
                                    end
                                else
                                    if state <= 48 then
                                        if state <= 47 then
                                            if state == 47 then
                                                r7 = not r5
                                                r16 = r16 + r25
                                                r3 = r16 <= r8
                                                r3 = r7 and r3
                                                r7 = r16 >= r8
                                                r7 = r5 and r7
                                                r3 = r7 or r3
                                                r7 = (48)
                                                state = r3 and r7
                                                r3 = (49)
                                                state = state or r3
                                            end
                                        else
                                            if state == 48 then
                                                state = upvalueValues[upvalues[1]]
                                                r3 = r16
                                                r21 = 255
                                                r17 = 0
                                                r7 = state(r17, r21)
                                                r10[r3] = r7
                                                r3 = nil
                                                state = 47
                                            end
                                        end
                                    else
                                        if state == 49 then
                                            state = upvalueValues[upvalues[10]]
                                            r3 = upvalueValues[upvalues[11]]
                                            r10[state] = r3
                                            state = upvalueValues[upvalues[12]]
                                            r3 = {
                                                state(r10)
                                            }
                                            ReturnVal = {
                                                unpack(r3)
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 66 then
                        if state <= 59 then
                            if state <= 53 then
                                -- createClosure4 entry 13752071 -> 50, states 50-53
                                if state <= 51 then
                                    if state <= 50 then
                                        if state == 50 then -- entry 13752071 -> 50
                                            state = 51
                                        end
                                    else
                                        if state == 51 then
                                            state = true
                                            state = state and (52) or (53)
                                        end
                                    end
                                else
                                    if state <= 52 then
                                        if state == 52 then
                                            ReturnVal = "l2"
                                            state = _env[ReturnVal]
                                            r10 = "l1"
                                            ReturnVal = _env[r10]
                                            r10 = "l1"
                                            _env[r10] = state
                                            r10 = "l2"
                                            _env[r10] = ReturnVal
                                            r10 = upvalueValues[upvalues[1]]
                                            r3 = r10()
                                            state = 51
                                        end
                                    else
                                        if state == 53 then
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            else
                                -- createClosure1 entry 6616469 -> 54, states 54-59
                                if state <= 56 then
                                    if state <= 55 then
                                        if state <= 54 then
                                            if state == 54 then -- entry 6616469 -> 54
                                                r10 = upvalueValues[upvalues[1]]
                                                ReturnVal = #r10
                                                r10 = 0
                                                state = ReturnVal == r10
                                                state = state and (55) or (56)
                                            end
                                        else
                                            if state == 55 then
                                                r3 = upvalueValues[upvalues[2]]
                                                r16 = 117
                                                r10 = r3 * r16
                                                r3 = 25994874302279
                                                ReturnVal = r10 + r3
                                                r10 = 35184372088832
                                                state = ReturnVal % r10
                                                upvalueValues[upvalues[2]] = state
                                                r10 = upvalueValues[upvalues[3]]
                                                r3 = 1
                                                ReturnVal = r10 ~= r3
                                                state = 57
                                            end
                                        end
                                    else
                                        if state == 56 then
                                            r16 = "table"
                                            r3 = _env[r16]
                                            r16 = "remove"
                                            r10 = r3[r16]
                                            r16 = upvalueValues[upvalues[1]]
                                            r3 = {
                                                r10(r16)
                                            }
                                            ReturnVal = {
                                                unpack(r3)
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    if state <= 58 then
                                        if state <= 57 then
                                            if state == 57 then
                                                r3 = upvalueValues[upvalues[3]]
                                                r16 = 48
                                                r10 = r3 * r16
                                                r3 = 257
                                                ReturnVal = r10 % r3
                                                upvalueValues[upvalues[3]] = ReturnVal
                                                state = 58
                                            end
                                        else
                                            if state == 58 then
                                                r3 = upvalueValues[upvalues[3]]
                                                r16 = 1
                                                r10 = r3 ~= r16
                                                state = r10 and (59) or (57)
                                            end
                                        end
                                    else
                                        if state == 59 then
                                            r3 = upvalueValues[upvalues[3]]
                                            r16 = 32
                                            r10 = r3 % r16
                                            r8 = upvalueValues[upvalues[4]]
                                            r21 = 2
                                            r7 = upvalueValues[upvalues[2]]
                                            r13 = upvalueValues[upvalues[3]]
                                            r2 = r13 - r10
                                            r13 = 32
                                            r11 = r2 / r13
                                            r22 = 13
                                            r24 = r22 - r11
                                            r17 = r21 ^ r24
                                            r5 = r7 / r17
                                            r25 = r8(r5)
                                            r8 = 4294967296
                                            r16 = r25 % r8
                                            r25 = 2
                                            r8 = r25 ^ r10
                                            r3 = r16 / r8
                                            r17 = 1
                                            r8 = upvalueValues[upvalues[4]]
                                            r7 = r3 % r17
                                            r17 = 4294967296
                                            r5 = r7 * r17
                                            r25 = r8(r5)
                                            r8 = upvalueValues[upvalues[4]]
                                            r5 = r8(r3)
                                            r16 = r25 + r5
                                            r25 = 65536
                                            r8 = r16 % r25
                                            r22 = 256
                                            r21 = 256
                                            r3 = nil
                                            r7 = 65536
                                            r5 = r16 - r8
                                            r25 = r5 / r7
                                            r7 = 256
                                            r5 = r8 % r7
                                            r10 = nil
                                            r17 = r8 - r5
                                            r7 = r17 / r21
                                            r16 = nil
                                            r21 = 256
                                            r17 = r25 % r21
                                            r8 = nil
                                            r24 = r25 - r17
                                            r21 = r24 / r22
                                            r24 = {
                                                r5,
                                                r7,
                                                r17,
                                                r21
                                            }
                                            upvalueValues[upvalues[1]] = r24
                                            r25 = nil
                                            r5 = nil
                                            r17 = nil
                                            r21 = nil
                                            r7 = nil
                                            state = 56
                                        end
                                    end
                                end
                            end
                        else
                            -- createClosure4 entry 14077234 -> 60, states 60-66
                            if state <= 63 then
                                if state <= 61 then
                                    if state <= 60 then
                                        if state == 60 then -- entry 14077234 -> 60
                                            r3 = args[2]
                                            r10 = args[1]
                                            state = upvalueValues[upvalues[1]]
                                            r16 = state
                                            state = r16[r3]
                                            state = state and (61) or (62)
                                        end
                                    else
                                        if state == 61 then
                                            state = 63
                                        end
                                    end
                                else
                                    if state <= 62 then
                                        if state == 62 then
                                            state = {}
                                            upvalueValues[upvalues[2]] = state
                                            ReturnVal = upvalueValues[upvalues[3]]
                                            r8 = ReturnVal
                                            r25 = 35184372088832
                                            ReturnVal = r3 % r25
                                            upvalueValues[upvalues[4]] = ReturnVal
                                            r7 = 255
                                            r5 = r3 % r7
                                            r7 = 2
                                            r25 = r5 + r7
                                            upvalueValues[upvalues[5]] = r25
                                            r17 = "string"
                                            r7 = _env[r17]
                                            r17 = "len"
                                            r5 = r7[r17]
                                            r7 = r5(r10)
                                            r5 = ""
                                            r16[r3] = r5
                                            r24 = 1
                                            r22 = r24
                                            r24 = 0
                                            r11 = r22 < r24
                                            r17 = 1
                                            r24 = r17 - r22
                                            r21 = r7
                                            r5 = 23
                                            state = 64
                                        end
                                    else
                                        if state == 63 then
                                            ReturnVal = {
                                                r3
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            else
                                if state <= 65 then
                                    if state <= 64 then
                                        if state == 64 then
                                            r2 = not r11
                                            r24 = r24 + r22
                                            r17 = r24 <= r21
                                            r17 = r2 and r17
                                            r2 = r24 >= r21
                                            r2 = r11 and r2
                                            r17 = r2 or r17
                                            r2 = (65)
                                            state = r17 and r2
                                            r17 = (66)
                                            state = state or r17
                                        end
                                    else
                                        if state == 65 then
                                            r17 = r24
                                            r4 = "string"
                                            r32 = _env[r4]
                                            r4 = "byte"
                                            r18 = r32[r4]
                                            r32 = r18(r10, r17)
                                            r18 = upvalueValues[upvalues[6]]
                                            r4 = r18()
                                            r29 = r32 + r4
                                            r13 = r29 + r5
                                            r29 = 256
                                            r2 = r13 % r29
                                            r5 = r2
                                            r29 = r16[r3]
                                            r4 = 1
                                            r17 = nil
                                            r32 = r5 + r4
                                            r18 = r8[r32]
                                            r13 = r29 .. r18
                                            r16[r3] = r13
                                            state = 64
                                        end
                                    end
                                else
                                    if state == 66 then
                                        r8 = nil
                                        r7 = nil
                                        r5 = nil
                                        state = 63
                                    end
                                end
                            end
                        end
                    else
                        if state <= 67 then
                            -- createClosure4 entry 16503299 -> 67, states 67-67
                            if state == 67 then -- entry 16503299 -> 67
                                ReturnVal = "getmetatable"
                                state = _env[ReturnVal]
                                r3 = "hookfunction"
                                r10 = _env[r3]
                                r3 = r10()
                                r10 = nil
                                ReturnVal = state(r3, r10)
                                ReturnVal = {}
                                state = nil
                            end
                        else
                            -- createClosure1 entry 10926265 -> 68, states 68-68
                            if state == 68 then -- entry 10926265 -> 68
                                r3 = "jwDZVvNwAvOXy"
                                r16 = 13468202
                                r10 = r3 ^ r16
                                ReturnVal = 991434
                                state = ReturnVal - r10
                                r10 = state
                                ReturnVal = "XCx1uTy2ZoL"
                                state = ReturnVal / r10
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
        upvalueValues = {}
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 948333
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 948333
                    end
                })
            end
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
        createClosure1 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1)
                return vm(entryId, {
                    arg1
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)