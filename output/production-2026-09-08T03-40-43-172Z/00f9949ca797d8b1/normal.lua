return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure, upvalueValues, createClosure1, releaseUpvalues, createClosure3, createClosure5, releaseUpvalue, vm, currentUpvalueId, allocUpvalue, createClosure4, upvalueRefCounts, createClosure2, createUpvalueProxy)
        upvalueRefCounts = {}
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
            local r1, r2, r3, r4, r5, r6, r7, ReturnVal, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33
            while state do
                if state <= 56 then
                    if state <= 34 then
                        if state <= 32 then
                            if state <= 31 then
                                -- root entry 1298546 -> 1, states 1-31
                                if state <= 16 then
                                    if state <= 8 then
                                        if state <= 4 then
                                            if state <= 2 then
                                                if state <= 1 then
                                                    if state == 1 then -- entry 1298546 -> 1
                                                        r12 = allocUpvalue()
                                                        r33 = allocUpvalue()
                                                        r14 = allocUpvalue()
                                                        state = true
                                                        upvalueValues[r33] = state
                                                        r18 = "string"
                                                        ReturnVal = _env[r18]
                                                        r18 = "gmatch"
                                                        state = ReturnVal[r18]
                                                        r18 = allocUpvalue()
                                                        upvalueValues[r18] = state
                                                        state = createClosure4(32, {})
                                                        upvalueValues[r12] = state
                                                        r26 = createClosure4(33, {
                                                            r14
                                                        })
                                                        state = false
                                                        upvalueValues[r14] = state
                                                        r4 = "pcall"
                                                        r16 = _env[r4]
                                                        r4 = r16(r26)
                                                        state = r4 and (2) or (3)
                                                        r6 = args
                                                        ReturnVal = r4
                                                    end
                                                else
                                                    if state == 2 then
                                                        r16 = upvalueValues[r14]
                                                        ReturnVal = r16
                                                        state = 3
                                                    end
                                                end
                                            else
                                                if state <= 3 then
                                                    if state == 3 then
                                                        r16 = ReturnVal
                                                        r4 = "math"
                                                        ReturnVal = _env[r4]
                                                        r4 = "random"
                                                        state = ReturnVal[r4]
                                                        r4 = allocUpvalue()
                                                        upvalueValues[r4] = state
                                                        r26 = "table"
                                                        ReturnVal = _env[r26]
                                                        r26 = "concat"
                                                        state = ReturnVal[r26]
                                                        r26 = state
                                                        r3 = state
                                                        r24 = "table"
                                                        r13 = _env[r24]
                                                        state = r13 and (4) or (5)
                                                        r25 = r13
                                                    end
                                                else
                                                    if state == 4 then
                                                        r1 = "table"
                                                        r24 = _env[r1]
                                                        r1 = "unpack"
                                                        r13 = r24[r1]
                                                        r25 = r13
                                                        state = 5
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 6 then
                                                if state <= 5 then
                                                    if state == 5 then
                                                        state = r3
                                                        state = r25 and (6) or (7)
                                                        ReturnVal = r25
                                                    end
                                                else
                                                    if state == 6 then
                                                        r25 = allocUpvalue()
                                                        upvalueValues[r25] = ReturnVal
                                                        state = upvalueValues[r4]
                                                        r3 = 3
                                                        r13 = 65
                                                        ReturnVal = state(r3, r13)
                                                        r3 = allocUpvalue()
                                                        r17 = createClosure4(34, {})
                                                        upvalueValues[r3] = ReturnVal
                                                        state = 0
                                                        r13 = state
                                                        state = 0
                                                        r1 = "pcall"
                                                        ReturnVal = _env[r1]
                                                        r1 = {
                                                            ReturnVal(r17)
                                                        }
                                                        r24 = state
                                                        state = {
                                                            unpack(r1)
                                                        }
                                                        r1 = state
                                                        ReturnVal = 2
                                                        state = r1[ReturnVal]
                                                        r17 = state
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r28 = upvalueValues[r18]
                                                        r8 = "tostring"
                                                        r27 = _env[r8]
                                                        r8 = r27(r17)
                                                        r27 = ":(%d*):"
                                                        r9 = r28(r8, r27)
                                                        r28 = {
                                                            r9()
                                                        }
                                                        ReturnVal = state(unpack(r28))
                                                        r28 = allocUpvalue()
                                                        upvalueValues[r28] = ReturnVal
                                                        r9 = upvalueValues[r3]
                                                        r27 = r9
                                                        r9 = 1
                                                        r8 = r9
                                                        r9 = 0
                                                        r22 = r8 < r9
                                                        ReturnVal = 1
                                                        r9 = ReturnVal - r8
                                                        state = 8
                                                    end
                                                end
                                            else
                                                if state <= 7 then
                                                    if state == 7 then
                                                        r3 = "unpack"
                                                        r25 = _env[r3]
                                                        ReturnVal = r25
                                                        state = 6
                                                    end
                                                else
                                                    if state == 8 then
                                                        r9 = r9 + r8
                                                        r29 = not r22
                                                        ReturnVal = r9 <= r27
                                                        ReturnVal = r29 and ReturnVal
                                                        r29 = r9 >= r27
                                                        r29 = r22 and r29
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
                                                        upvalueValues[r29] = r9
                                                        r7 = "math"
                                                        ReturnVal = _env[r7]
                                                        r7 = "random"
                                                        state = ReturnVal[r7]
                                                        r5 = 100
                                                        r7 = 1
                                                        ReturnVal = state(r7, r5)
                                                        r7 = allocUpvalue()
                                                        upvalueValues[r7] = ReturnVal
                                                        state = upvalueValues[r4]
                                                        r32 = 255
                                                        r5 = 0
                                                        ReturnVal = state(r5, r32)
                                                        r5 = allocUpvalue()
                                                        upvalueValues[r5] = ReturnVal
                                                        state = upvalueValues[r4]
                                                        r2 = upvalueValues[r7]
                                                        r32 = 1
                                                        ReturnVal = state(r32, r2)
                                                        r32 = allocUpvalue()
                                                        upvalueValues[r32] = ReturnVal
                                                        ReturnVal = upvalueValues[r4]
                                                        r11 = 1
                                                        r19 = 2
                                                        r2 = ReturnVal(r11, r19)
                                                        ReturnVal = 1
                                                        state = r2 == ReturnVal
                                                        r2 = allocUpvalue()
                                                        upvalueValues[r2] = state
                                                        r31 = "tostring"
                                                        r21 = _env[r31]
                                                        r10 = upvalueValues[r4]
                                                        state = "gsub"
                                                        state = r17[state]
                                                        r23 = 0
                                                        r15 = 10000
                                                        r30 = {
                                                            r10(r23, r15)
                                                        }
                                                        r31 = r21(unpack(r30))
                                                        r21 = ":"
                                                        r20 = r31 .. r21
                                                        r19 = ":"
                                                        r11 = r19 .. r20
                                                        ReturnVal = ":(%d*):"
                                                        state = state(r17, ReturnVal, r11)
                                                        r11 = allocUpvalue()
                                                        r20 = createClosure2(35, {
                                                            r4,
                                                            r29,
                                                            r3,
                                                            r18,
                                                            r33,
                                                            r28,
                                                            r2,
                                                            r11,
                                                            r7,
                                                            r32,
                                                            r5,
                                                            r25
                                                        })
                                                        upvalueValues[r11] = state
                                                        r19 = "pcall"
                                                        ReturnVal = _env[r19]
                                                        r19 = {
                                                            ReturnVal(r20)
                                                        }
                                                        state = {
                                                            unpack(r19)
                                                        }
                                                        r19 = state
                                                        state = upvalueValues[r2]
                                                        state = state and (11) or (12)
                                                    end
                                                else
                                                    if state == 10 then
                                                        r27 = upvalueValues[r33]
                                                        state = r27 and (13) or (14)
                                                        r9 = r27
                                                    end
                                                end
                                            else
                                                if state <= 11 then
                                                    if state == 11 then
                                                        r20 = upvalueValues[r33]
                                                        state = r20 and (15) or (16)
                                                        ReturnVal = r20
                                                    end
                                                else
                                                    if state == 12 then
                                                        r21 = upvalueValues[r33]
                                                        state = r21 and (17) or (18)
                                                        r20 = r21
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 14 then
                                                if state <= 13 then
                                                    if state == 13 then
                                                        r27 = r13 == r24
                                                        r9 = r27
                                                        state = 14
                                                    end
                                                else
                                                    if state == 14 then
                                                        upvalueValues[r33] = r9
                                                        state = upvalueValues[r33]
                                                        state = state and (19) or (20)
                                                    end
                                                end
                                            else
                                                if state <= 15 then
                                                    if state == 15 then
                                                        r21 = state
                                                        r30 = 1
                                                        r10 = r19[r30]
                                                        r30 = false
                                                        r31 = r10 == r30
                                                        state = r31 and (21) or (22)
                                                        r20 = r31
                                                    end
                                                else
                                                    if state == 16 then
                                                        upvalueValues[r33] = ReturnVal
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
                                                        r31 = 1
                                                        r21 = r19[r31]
                                                        r20 = r21
                                                        state = 18
                                                    end
                                                else
                                                    if state == 18 then
                                                        upvalueValues[r33] = r20
                                                        r30 = upvalueValues[r32]
                                                        r23 = 1
                                                        r10 = r30 + r23
                                                        r31 = r19[r10]
                                                        r21 = r13 + r31
                                                        r31 = 256
                                                        state = r21 % r31
                                                        r13 = state
                                                        r10 = upvalueValues[r5]
                                                        r31 = r24 + r10
                                                        r10 = 256
                                                        r21 = r31 % r10
                                                        r24 = r21
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
                                                        r30 = 2
                                                        r10 = r19[r30]
                                                        r30 = upvalueValues[r11]
                                                        r31 = r10 == r30
                                                        r20 = r31
                                                        state = 22
                                                    end
                                                else
                                                    if state == 22 then
                                                        state = r21
                                                        ReturnVal = r20
                                                        state = 16
                                                    end
                                                end
                                            else
                                                if state <= 23 then
                                                    if state == 23 then
                                                        r2 = releaseUpvalue(r2)
                                                        r29 = releaseUpvalue(r29)
                                                        r7 = releaseUpvalue(r7)
                                                        r5 = releaseUpvalue(r5)
                                                        r19 = nil
                                                        r11 = releaseUpvalue(r11)
                                                        r32 = releaseUpvalue(r32)
                                                        state = 8
                                                    end
                                                else
                                                    if state == 24 then
                                                        r28 = releaseUpvalue(r28)
                                                        r25 = releaseUpvalue(r25)
                                                        r4 = releaseUpvalue(r4)
                                                        r18 = releaseUpvalue(r18)
                                                        r12 = releaseUpvalue(r12)
                                                        r33 = releaseUpvalue(r33)
                                                        r12 = allocUpvalue()
                                                        r24 = nil
                                                        r24 = allocUpvalue()
                                                        r14 = releaseUpvalue(r14)
                                                        r33 = nil
                                                        upvalueValues[r12] = r33
                                                        r33 = allocUpvalue()
                                                        r3 = releaseUpvalue(r3)
                                                        r18 = nil
                                                        upvalueValues[r33] = r18
                                                        r16 = nil
                                                        r16 = "math"
                                                        r14 = _env[r16]
                                                        r28 = 256
                                                        r1 = nil
                                                        r1 = {}
                                                        r16 = "floor"
                                                        r18 = r14[r16]
                                                        r14 = allocUpvalue()
                                                        upvalueValues[r14] = r18
                                                        r22 = r28
                                                        r4 = "math"
                                                        r16 = _env[r4]
                                                        r4 = "random"
                                                        r18 = r16[r4]
                                                        r26 = nil
                                                        r26 = "table"
                                                        r4 = _env[r26]
                                                        r3 = allocUpvalue()
                                                        r26 = "remove"
                                                        r16 = r4[r26]
                                                        r25 = "string"
                                                        r26 = _env[r25]
                                                        r13 = nil
                                                        r13 = {}
                                                        r25 = "char"
                                                        r4 = r26[r25]
                                                        r28 = 1
                                                        r25 = allocUpvalue()
                                                        r26 = 0
                                                        upvalueValues[r25] = r26
                                                        r26 = 2
                                                        upvalueValues[r3] = r26
                                                        upvalueValues[r24] = r13
                                                        r29 = r28
                                                        r28 = 0
                                                        r7 = r29 < r28
                                                        r26 = {}
                                                        r17 = nil
                                                        r17 = 1
                                                        r28 = r17 - r29
                                                        r13 = 0
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
                                                            r12
                                                        })
                                                        r27 = {
                                                            state()
                                                        }
                                                        ReturnVal = {
                                                            unpack(r27)
                                                        }
                                                        state = nil
                                                    end
                                                else
                                                    if state == 26 then
                                                        r5 = not r7
                                                        r28 = r28 + r29
                                                        r17 = r28 <= r22
                                                        r17 = r5 and r17
                                                        r5 = r28 >= r22
                                                        r5 = r7 and r5
                                                        r17 = r5 or r17
                                                        r5 = (27)
                                                        state = r17 and r5
                                                        r17 = (28)
                                                        state = state or r17
                                                    end
                                                end
                                            else
                                                if state <= 27 then
                                                    if state == 27 then
                                                        r17 = r28
                                                        r5 = r17
                                                        r1[r17] = r5
                                                        r17 = nil
                                                        state = 26
                                                    end
                                                else
                                                    if state == 28 then
                                                        r28 = #r1
                                                        r22 = 0
                                                        r17 = r28 == r22
                                                        state = 29
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 30 then
                                                if state <= 29 then
                                                    if state == 29 then
                                                        r22 = #r1
                                                        r28 = 1
                                                        r17 = r18(r28, r22)
                                                        r28 = r16(r1, r17)
                                                        r5 = 1
                                                        r17 = nil
                                                        r22 = upvalueValues[r24]
                                                        r7 = r28 - r5
                                                        r29 = r4(r7)
                                                        r22[r28] = r29
                                                        r28 = nil
                                                        state = 30
                                                    end
                                                else
                                                    if state == 30 then
                                                        r28 = #r1
                                                        r22 = 0
                                                        r17 = r28 == r22
                                                        state = r17 and (31) or (29)
                                                    end
                                                end
                                            else
                                                if state == 31 then
                                                    r17 = {}
                                                    r28 = allocUpvalue()
                                                    r18 = nil
                                                    r31 = nil
                                                    r16 = nil
                                                    r26 = nil
                                                    r1 = nil
                                                    upvalueValues[r28] = r17
                                                    r17 = allocUpvalue()
                                                    r22 = createClosure2(51, {
                                                        r28,
                                                        r25,
                                                        r3,
                                                        r14
                                                    })
                                                    r5 = {}
                                                    r29 = allocUpvalue()
                                                    ReturnVal = {}
                                                    upvalueValues[r17] = r22
                                                    r22 = {}
                                                    upvalueValues[r29] = r22
                                                    r7 = "setmetatable"
                                                    r22 = _env[r7]
                                                    r11 = upvalueValues[r29]
                                                    r2 = "__index"
                                                    r19 = "__metatable"
                                                    r32 = {
                                                        [r2] = r11,
                                                        [r19] = r31
                                                    }
                                                    r7 = r22(r5, r32)
                                                    upvalueValues[r12] = r7
                                                    r22 = createClosure2(57, {
                                                        r29,
                                                        r28,
                                                        r24,
                                                        r25,
                                                        r3,
                                                        r17
                                                    })
                                                    r3 = releaseUpvalue(r3)
                                                    upvalueValues[r33] = r22
                                                    r28 = releaseUpvalue(r28)
                                                    r17 = releaseUpvalue(r17)
                                                    r14 = releaseUpvalue(r14)
                                                    r25 = releaseUpvalue(r25)
                                                    r16 = "task"
                                                    r14 = _env[r16]
                                                    r24 = releaseUpvalue(r24)
                                                    r29 = releaseUpvalue(r29)
                                                    r4 = nil
                                                    r4 = upvalueValues[r12]
                                                    r26 = upvalueValues[r33]
                                                    r13 = nil
                                                    r13 = 29215932036388
                                                    r3 = "\195d|\148\159"
                                                    r25 = r26(r3, r13)
                                                    r16 = r4[r25]
                                                    r18 = r14[r16]
                                                    r16 = createClosure2(64, {
                                                        r12,
                                                        r33
                                                    })
                                                    r14 = r18(r16)
                                                    r16 = "task"
                                                    r14 = _env[r16]
                                                    r4 = upvalueValues[r12]
                                                    r26 = upvalueValues[r33]
                                                    r3 = "\216\187q1&"
                                                    r13 = 737367376215
                                                    r25 = r26(r3, r13)
                                                    r16 = r4[r25]
                                                    r18 = r14[r16]
                                                    r16 = createClosure2(65, {
                                                        r12,
                                                        r33
                                                    })
                                                    r33 = releaseUpvalue(r33)
                                                    r12 = releaseUpvalue(r12)
                                                    r14 = r18(r16)
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure4 entry 14638745 -> 32, states 32-32
                                if state == 32 then -- entry 14638745 -> 32
                                    ReturnVal = "error"
                                    state = _env[ReturnVal]
                                    r6 = "Tamper Detected!"
                                    ReturnVal = state(r6)
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            if state <= 33 then
                                -- createClosure4 entry 9008437 -> 33, states 33-33
                                if state == 33 then -- entry 9008437 -> 33
                                    state = true
                                    upvalueValues[upvalues[1]] = state
                                    ReturnVal = {}
                                    state = nil
                                end
                            else
                                -- createClosure4 entry 10534914 -> 34, states 34-34
                                if state == 34 then -- entry 10534914 -> 34
                                    r33 = "7JNwMj8E"
                                    r18 = 13110878
                                    r6 = r33 ^ r18
                                    ReturnVal = 5676979
                                    state = ReturnVal - r6
                                    r6 = state
                                    ReturnVal = "2LFLEVzPW"
                                    state = ReturnVal / r6
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
                                -- createClosure2 entry 11756459 -> 35, states 35-46
                                if state <= 40 then
                                    if state <= 37 then
                                        if state <= 36 then
                                            if state <= 35 then
                                                if state == 35 then -- entry 11756459 -> 35
                                                    r33 = upvalueValues[upvalues[1]]
                                                    r14 = 2
                                                    r12 = 1
                                                    r18 = r33(r12, r14)
                                                    r33 = 1
                                                    r6 = r18 == r33
                                                    state = r6 and (36) or (37)
                                                    ReturnVal = r6
                                                end
                                            else
                                                if state == 36 then
                                                    state = ReturnVal and (38) or (39)
                                                end
                                            end
                                        else
                                            if state == 37 then
                                                r33 = upvalueValues[upvalues[2]]
                                                r18 = upvalueValues[upvalues[3]]
                                                r6 = r33 == r18
                                                ReturnVal = r6
                                                state = 36
                                            end
                                        end
                                    else
                                        if state <= 39 then
                                            if state <= 38 then
                                                if state == 38 then
                                                    ReturnVal = "tonumber"
                                                    state = _env[ReturnVal]
                                                    r6 = upvalueValues[upvalues[4]]
                                                    r25 = createClosure4(66, {})
                                                    r12 = "tostring"
                                                    r18 = _env[r12]
                                                    r26 = "pcall"
                                                    r4 = _env[r26]
                                                    r26 = {
                                                        r4(r25)
                                                    }
                                                    r16 = {
                                                        unpack(r26)
                                                    }
                                                    r4 = 2
                                                    r14 = r16[r4]
                                                    r12 = r18(r14)
                                                    r18 = ":(%d*):"
                                                    r33 = r6(r12, r18)
                                                    r6 = {
                                                        r33()
                                                    }
                                                    ReturnVal = state(unpack(r6))
                                                    r6 = ReturnVal
                                                    r33 = upvalueValues[upvalues[5]]
                                                    state = r33 and (40) or (41)
                                                    ReturnVal = r33
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
                                                r33 = r18 == r6
                                                ReturnVal = r33
                                                state = 41
                                            end
                                        end
                                    end
                                else
                                    if state <= 43 then
                                        if state <= 42 then
                                            if state <= 41 then
                                                if state == 41 then
                                                    r6 = nil
                                                    upvalueValues[upvalues[5]] = ReturnVal
                                                    state = 39
                                                end
                                            else
                                                if state == 42 then
                                                    r6 = "error"
                                                    state = _env[r6]
                                                    r33 = upvalueValues[upvalues[8]]
                                                    r18 = 0
                                                    r6 = state(r33, r18)
                                                    state = 43
                                                end
                                            end
                                        else
                                            if state == 43 then
                                                state = {}
                                                r6 = state
                                                r18 = upvalueValues[upvalues[9]]
                                                r12 = r18
                                                r18 = 1
                                                r14 = r18
                                                r18 = 0
                                                r16 = r14 < r18
                                                r33 = 1
                                                r18 = r33 - r14
                                                state = 44
                                            end
                                        end
                                    else
                                        if state <= 45 then
                                            if state <= 44 then
                                                if state == 44 then
                                                    r18 = r18 + r14
                                                    r4 = not r16
                                                    r33 = r18 <= r12
                                                    r33 = r4 and r33
                                                    r4 = r18 >= r12
                                                    r4 = r16 and r4
                                                    r33 = r4 or r33
                                                    r4 = (45)
                                                    state = r33 and r4
                                                    r33 = (46)
                                                    state = state or r33
                                                end
                                            else
                                                if state == 45 then
                                                    r33 = r18
                                                    state = upvalueValues[upvalues[1]]
                                                    r26 = 0
                                                    r25 = 255
                                                    r4 = state(r26, r25)
                                                    r6[r33] = r4
                                                    r33 = nil
                                                    state = 44
                                                end
                                            end
                                        else
                                            if state == 46 then
                                                state = upvalueValues[upvalues[10]]
                                                r33 = upvalueValues[upvalues[11]]
                                                r6[state] = r33
                                                state = upvalueValues[upvalues[12]]
                                                r33 = {
                                                    state(r6)
                                                }
                                                ReturnVal = {
                                                    unpack(r33)
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure5 entry 10832782 -> 47, states 47-50
                                if state <= 48 then
                                    if state <= 47 then
                                        if state == 47 then -- entry 10832782 -> 47
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
                                            r6 = "l1"
                                            ReturnVal = _env[r6]
                                            r6 = "l1"
                                            _env[r6] = state
                                            r6 = "l2"
                                            _env[r6] = ReturnVal
                                            r6 = upvalueValues[upvalues[1]]
                                            r33 = r6()
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
                            -- createClosure2 entry 3471448 -> 51, states 51-56
                            if state <= 53 then
                                if state <= 52 then
                                    if state <= 51 then
                                        if state == 51 then -- entry 3471448 -> 51
                                            r6 = upvalueValues[upvalues[1]]
                                            ReturnVal = #r6
                                            r6 = 0
                                            state = ReturnVal == r6
                                            state = state and (52) or (53)
                                        end
                                    else
                                        if state == 52 then
                                            r33 = upvalueValues[upvalues[2]]
                                            r18 = 169
                                            r6 = r33 * r18
                                            r33 = 9611351544187
                                            ReturnVal = r6 + r33
                                            r6 = 35184372088832
                                            state = ReturnVal % r6
                                            upvalueValues[upvalues[2]] = state
                                            r6 = upvalueValues[upvalues[3]]
                                            r33 = 1
                                            ReturnVal = r6 ~= r33
                                            state = 54
                                        end
                                    end
                                else
                                    if state == 53 then
                                        r18 = "table"
                                        r33 = _env[r18]
                                        r18 = "remove"
                                        r6 = r33[r18]
                                        r18 = upvalueValues[upvalues[1]]
                                        r33 = {
                                            r6(r18)
                                        }
                                        ReturnVal = {
                                            unpack(r33)
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 55 then
                                    if state <= 54 then
                                        if state == 54 then
                                            r33 = upvalueValues[upvalues[3]]
                                            r18 = 216
                                            r6 = r33 * r18
                                            r33 = 257
                                            ReturnVal = r6 % r33
                                            upvalueValues[upvalues[3]] = ReturnVal
                                            state = 55
                                        end
                                    else
                                        if state == 55 then
                                            r33 = upvalueValues[upvalues[3]]
                                            r18 = 1
                                            r6 = r33 ~= r18
                                            state = r6 and (56) or (54)
                                        end
                                    end
                                else
                                    if state == 56 then
                                        r33 = upvalueValues[upvalues[3]]
                                        r18 = 32
                                        r6 = r33 % r18
                                        r12 = upvalueValues[upvalues[4]]
                                        r4 = upvalueValues[upvalues[2]]
                                        r25 = 2
                                        r17 = upvalueValues[upvalues[3]]
                                        r1 = r17 - r6
                                        r17 = 32
                                        r24 = r1 / r17
                                        r13 = 13
                                        r3 = r13 - r24
                                        r26 = r25 ^ r3
                                        r16 = r4 / r26
                                        r14 = r12(r16)
                                        r12 = 4294967296
                                        r26 = 1
                                        r18 = r14 % r12
                                        r14 = 2
                                        r12 = r14 ^ r6
                                        r33 = r18 / r12
                                        r13 = 256
                                        r6 = nil
                                        r12 = upvalueValues[upvalues[4]]
                                        r4 = r33 % r26
                                        r26 = 4294967296
                                        r16 = r4 * r26
                                        r14 = r12(r16)
                                        r12 = upvalueValues[upvalues[4]]
                                        r16 = r12(r33)
                                        r18 = r14 + r16
                                        r14 = 65536
                                        r4 = 65536
                                        r12 = r18 % r14
                                        r16 = r18 - r12
                                        r25 = 256
                                        r14 = r16 / r4
                                        r4 = 256
                                        r16 = r12 % r4
                                        r18 = nil
                                        r26 = r12 - r16
                                        r33 = nil
                                        r4 = r26 / r25
                                        r25 = 256
                                        r26 = r14 % r25
                                        r3 = r14 - r26
                                        r12 = nil
                                        r25 = r3 / r13
                                        r3 = {
                                            r16,
                                            r4,
                                            r26,
                                            r25
                                        }
                                        upvalueValues[upvalues[1]] = r3
                                        r14 = nil
                                        r26 = nil
                                        r4 = nil
                                        r16 = nil
                                        r25 = nil
                                        state = 53
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 65 then
                        if state <= 64 then
                            if state <= 63 then
                                -- createClosure2 entry 4639871 -> 57, states 57-63
                                if state <= 60 then
                                    if state <= 58 then
                                        if state <= 57 then
                                            if state == 57 then -- entry 4639871 -> 57
                                                state = upvalueValues[upvalues[1]]
                                                r18 = state
                                                r6 = args[1]
                                                r33 = args[2]
                                                state = r18[r33]
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
                                                r12 = ReturnVal
                                                r14 = 35184372088832
                                                ReturnVal = r33 % r14
                                                upvalueValues[upvalues[4]] = ReturnVal
                                                r4 = 255
                                                r16 = r33 % r4
                                                r4 = 2
                                                r14 = r16 + r4
                                                upvalueValues[upvalues[5]] = r14
                                                r26 = "string"
                                                r4 = _env[r26]
                                                r26 = "len"
                                                r16 = r4[r26]
                                                r4 = r16(r6)
                                                r3 = 1
                                                r13 = r3
                                                r16 = ""
                                                r18[r33] = r16
                                                r3 = 0
                                                r24 = r13 < r3
                                                r26 = 1
                                                r3 = r26 - r13
                                                r25 = r4
                                                r16 = 93
                                                state = 61
                                            end
                                        else
                                            if state == 60 then
                                                ReturnVal = {
                                                    r33
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    if state <= 62 then
                                        if state <= 61 then
                                            if state == 61 then
                                                r3 = r3 + r13
                                                r26 = r3 <= r25
                                                r1 = not r24
                                                r26 = r1 and r26
                                                r1 = r3 >= r25
                                                r1 = r24 and r1
                                                r26 = r1 or r26
                                                r1 = (62)
                                                state = r26 and r1
                                                r26 = (63)
                                                state = state or r26
                                            end
                                        else
                                            if state == 62 then
                                                r8 = "string"
                                                r27 = _env[r8]
                                                r8 = "byte"
                                                r9 = r27[r8]
                                                r26 = r3
                                                r27 = r9(r6, r26)
                                                r9 = upvalueValues[upvalues[6]]
                                                r8 = r9()
                                                r28 = r27 + r8
                                                r26 = nil
                                                r17 = r28 + r16
                                                r28 = 256
                                                r1 = r17 % r28
                                                r16 = r1
                                                r28 = r18[r33]
                                                r8 = 1
                                                r27 = r16 + r8
                                                r9 = r12[r27]
                                                r17 = r28 .. r9
                                                r18[r33] = r17
                                                state = 61
                                            end
                                        end
                                    else
                                        if state == 63 then
                                            r12 = nil
                                            r4 = nil
                                            r16 = nil
                                            state = 60
                                        end
                                    end
                                end
                            else
                                -- createClosure2 entry 2747700 -> 64, states 64-64
                                if state == 64 then -- entry 2747700 -> 64
                                    ReturnVal = "loadstring"
                                    state = _env[ReturnVal]
                                    r33 = "game"
                                    r6 = _env[r33]
                                    r12 = upvalueValues[upvalues[1]]
                                    r14 = upvalueValues[upvalues[2]]
                                    r26 = 15585358306393
                                    r4 = "?\170pl\025\195\208\226.G\146-U\252\205\129\1754%\027\156>\154\028\030v\029\025s\002\1507W+A\179\132\185\224\168\161V\024\175%\130\197\143\230\242\164s\1346A\141\196\246\193\248\229\198]1\158\172V\250\129%\019\199"
                                    r16 = r14(r4, r26)
                                    r18 = r12[r16]
                                    r12 = "HttpGet"
                                    r12 = r6[r12]
                                    r33 = {
                                        r12(r6, r18)
                                    }
                                    ReturnVal = state(unpack(r33))
                                    state = ReturnVal()
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            -- createClosure2 entry 2914167 -> 65, states 65-65
                            if state == 65 then -- entry 2914167 -> 65
                                ReturnVal = "loadstring"
                                state = _env[ReturnVal]
                                r18 = createClosure3(67, {
                                    upvalues[1],
                                    upvalues[2]
                                })
                                r33 = "game"
                                r6 = _env[r33]
                                r16 = upvalueValues[upvalues[1]]
                                r4 = upvalueValues[upvalues[2]]
                                r25 = "\205Rw\020\011o\241\177/\137\236\153\195|\016P\142\025I(\187\222\169s\214\002\140\127\159\236\187\232\215\184\227\150n~\206\173A\171I0\023\178\254F\001V\152\220\163\142Gp\253\236\011\022\218\131\215U\207="
                                r3 = 8751066566635
                                r26 = r4(r25, r3)
                                r14 = r16[r26]
                                r12 = {
                                    r18(r14)
                                }
                                r18 = "HttpGet"
                                r18 = r6[r18]
                                r33 = {
                                    r18(r6, unpack(r12))
                                }
                                ReturnVal = state(unpack(r33))
                                state = ReturnVal()
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    else
                        if state <= 67 then
                            if state <= 66 then
                                -- createClosure4 entry 15459065 -> 66, states 66-66
                                if state == 66 then -- entry 15459065 -> 66
                                    r33 = "NLkMCHyaqUiJx"
                                    r18 = 2280835
                                    r6 = r33 ^ r18
                                    ReturnVal = 14904857
                                    state = ReturnVal - r6
                                    r6 = state
                                    ReturnVal = "Sy9bGMulO"
                                    state = ReturnVal / r6
                                    ReturnVal = {
                                        state
                                    }
                                    state = nil
                                end
                            else
                                -- createClosure3 entry 6755597 -> 67, states 67-67
                                if state == 67 then -- entry 6755597 -> 67
                                    r33 = upvalueValues[upvalues[1]]
                                    r18 = upvalueValues[upvalues[2]]
                                    r6 = args[1]
                                    r14 = "c|"
                                    r16 = 1740666241834
                                    r12 = r18(r14, r16)
                                    ReturnVal = r33[r12]
                                    r33 = createClosure1(68, {
                                        upvalues[1],
                                        upvalues[2]
                                    })
                                    r18 = "gsub"
                                    r18 = r6[r18]
                                    state = {
                                        r18(r6, ReturnVal, r33)
                                    }
                                    ReturnVal = {
                                        unpack(state)
                                    }
                                    state = nil
                                end
                            end
                        else
                            -- createClosure1 entry 6333644 -> 68, states 68-68
                            if state == 68 then -- entry 6333644 -> 68
                                r6 = args[1]
                                r33 = "string"
                                ReturnVal = _env[r33]
                                r18 = upvalueValues[upvalues[1]]
                                r12 = upvalueValues[upvalues[2]]
                                r16 = "l\240\170\250"
                                r4 = 13494449330315
                                r14 = r12(r16, r4)
                                r33 = r18[r14]
                                state = ReturnVal[r33]
                                r18 = "tonumber"
                                r33 = _env[r18]
                                r12 = 16
                                r18 = {
                                    r33(r6, r12)
                                }
                                ReturnVal = {
                                    state(unpack(r18))
                                }
                                ReturnVal = {
                                    unpack(ReturnVal)
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
                upvalueRefCounts[upvalueId], captureIndex = upvalueRefCounts[upvalueId] - (1), (1) + captureIndex
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
        upvalueValues = {}
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
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        currentUpvalueId = 0
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 553906
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 553906
                    end
                })
            end
        end
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)