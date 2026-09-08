return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure, upvalueRefCounts, createClosure5, allocUpvalue, createClosure0, releaseUpvalue, createUpvalueProxy, vm, upvalueValues, releaseUpvalues, createClosure2, currentUpvalueId)
        currentUpvalueId = 0
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        upvalueValues = {}
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, ReturnVal, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33
            while state do
                if state <= 53 then
                    if state <= 36 then
                        if state <= 35 then
                            if state <= 34 then
                                -- root entry 6207726 -> 1, states 1-34
                                if state <= 17 then
                                    if state <= 9 then
                                        if state <= 5 then
                                            if state <= 3 then
                                                if state <= 2 then
                                                    if state <= 1 then
                                                        if state == 1 then -- entry 6207726 -> 1
                                                            r14 = allocUpvalue()
                                                            r29 = allocUpvalue()
                                                            state = true
                                                            upvalueValues[r14] = state
                                                            r2 = createClosure5(35, {
                                                                r29
                                                            })
                                                            r5 = "string"
                                                            ReturnVal = _env[r5]
                                                            r5 = "gmatch"
                                                            state = ReturnVal[r5]
                                                            r5 = allocUpvalue()
                                                            r9 = allocUpvalue()
                                                            upvalueValues[r5] = state
                                                            state = createClosure0(36, {})
                                                            upvalueValues[r9] = state
                                                            state = false
                                                            upvalueValues[r29] = state
                                                            r16 = "pcall"
                                                            r6 = _env[r16]
                                                            r16 = r6(r2)
                                                            state = r16 and (2) or (3)
                                                            r27 = args
                                                            ReturnVal = r16
                                                        end
                                                    else
                                                        if state == 2 then
                                                            r6 = upvalueValues[r29]
                                                            ReturnVal = r6
                                                            state = 3
                                                        end
                                                    end
                                                else
                                                    if state == 3 then
                                                        r6 = ReturnVal
                                                        r16 = "math"
                                                        ReturnVal = _env[r16]
                                                        r16 = "random"
                                                        state = ReturnVal[r16]
                                                        r16 = allocUpvalue()
                                                        upvalueValues[r16] = state
                                                        r2 = "table"
                                                        ReturnVal = _env[r2]
                                                        r2 = "concat"
                                                        state = ReturnVal[r2]
                                                        r2 = state
                                                        r4 = state
                                                        r10 = "table"
                                                        r15 = _env[r10]
                                                        state = r15 and (4) or (5)
                                                        r1 = r15
                                                    end
                                                end
                                            else
                                                if state <= 4 then
                                                    if state == 4 then
                                                        r13 = "table"
                                                        r10 = _env[r13]
                                                        r13 = "unpack"
                                                        r15 = r10[r13]
                                                        r1 = r15
                                                        state = 5
                                                    end
                                                else
                                                    if state == 5 then
                                                        state = r4
                                                        state = r1 and (6) or (7)
                                                        ReturnVal = r1
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 7 then
                                                if state <= 6 then
                                                    if state == 6 then
                                                        r1 = allocUpvalue()
                                                        upvalueValues[r1] = ReturnVal
                                                        state = upvalueValues[r16]
                                                        r15 = 65
                                                        r4 = 3
                                                        ReturnVal = state(r4, r15)
                                                        r4 = allocUpvalue()
                                                        state = 0
                                                        upvalueValues[r4] = ReturnVal
                                                        r15 = state
                                                        r24 = createClosure5(37, {})
                                                        r13 = "pcall"
                                                        ReturnVal = _env[r13]
                                                        state = 0
                                                        r13 = {
                                                            ReturnVal(r24)
                                                        }
                                                        r10 = state
                                                        state = {
                                                            unpack(r13)
                                                        }
                                                        r13 = state
                                                        ReturnVal = 2
                                                        state = r13[ReturnVal]
                                                        r24 = state
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r21 = upvalueValues[r5]
                                                        r11 = "tostring"
                                                        r30 = _env[r11]
                                                        r11 = r30(r24)
                                                        r30 = ":(%d*):"
                                                        r19 = r21(r11, r30)
                                                        r21 = {
                                                            r19()
                                                        }
                                                        ReturnVal = state(unpack(r21))
                                                        r21 = allocUpvalue()
                                                        upvalueValues[r21] = ReturnVal
                                                        r19 = upvalueValues[r4]
                                                        r30 = r19
                                                        r19 = 1
                                                        r11 = r19
                                                        r19 = 0
                                                        r31 = r11 < r19
                                                        ReturnVal = 1
                                                        r19 = ReturnVal - r11
                                                        state = 8
                                                    end
                                                else
                                                    if state == 7 then
                                                        r4 = "unpack"
                                                        r1 = _env[r4]
                                                        ReturnVal = r1
                                                        state = 6
                                                    end
                                                end
                                            else
                                                if state <= 8 then
                                                    if state == 8 then
                                                        r19 = r19 + r11
                                                        r22 = not r31
                                                        ReturnVal = r19 <= r30
                                                        ReturnVal = r22 and ReturnVal
                                                        r22 = r19 >= r30
                                                        r22 = r31 and r22
                                                        ReturnVal = r22 or ReturnVal
                                                        r22 = (9)
                                                        state = ReturnVal and r22
                                                        ReturnVal = (10)
                                                        state = state or ReturnVal
                                                    end
                                                else
                                                    if state == 9 then
                                                        r22 = allocUpvalue()
                                                        upvalueValues[r22] = r19
                                                        r12 = "math"
                                                        ReturnVal = _env[r12]
                                                        r12 = "random"
                                                        state = ReturnVal[r12]
                                                        r12 = 1
                                                        r25 = 100
                                                        ReturnVal = state(r12, r25)
                                                        r12 = allocUpvalue()
                                                        upvalueValues[r12] = ReturnVal
                                                        state = upvalueValues[r16]
                                                        r25 = 0
                                                        r23 = 255
                                                        ReturnVal = state(r25, r23)
                                                        r25 = allocUpvalue()
                                                        upvalueValues[r25] = ReturnVal
                                                        state = upvalueValues[r16]
                                                        r17 = upvalueValues[r12]
                                                        r23 = 1
                                                        ReturnVal = state(r23, r17)
                                                        r23 = allocUpvalue()
                                                        upvalueValues[r23] = ReturnVal
                                                        ReturnVal = upvalueValues[r16]
                                                        r26 = 2
                                                        r28 = 1
                                                        r17 = ReturnVal(r28, r26)
                                                        ReturnVal = 1
                                                        state = r17 == ReturnVal
                                                        r17 = allocUpvalue()
                                                        upvalueValues[r17] = state
                                                        r32 = "tostring"
                                                        r8 = _env[r32]
                                                        r3 = upvalueValues[r16]
                                                        r20 = 0
                                                        r7 = 10000
                                                        r33 = {
                                                            r3(r20, r7)
                                                        }
                                                        r32 = r8(unpack(r33))
                                                        state = "gsub"
                                                        state = r24[state]
                                                        r8 = ":"
                                                        r18 = r32 .. r8
                                                        r26 = ":"
                                                        r28 = r26 .. r18
                                                        ReturnVal = ":(%d*):"
                                                        state = state(r24, ReturnVal, r28)
                                                        r28 = allocUpvalue()
                                                        upvalueValues[r28] = state
                                                        r18 = createClosure2(38, {
                                                            r16,
                                                            r22,
                                                            r4,
                                                            r5,
                                                            r14,
                                                            r21,
                                                            r17,
                                                            r28,
                                                            r12,
                                                            r23,
                                                            r25,
                                                            r1
                                                        })
                                                        r26 = "pcall"
                                                        ReturnVal = _env[r26]
                                                        r26 = {
                                                            ReturnVal(r18)
                                                        }
                                                        state = {
                                                            unpack(r26)
                                                        }
                                                        r26 = state
                                                        state = upvalueValues[r17]
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
                                                        r30 = upvalueValues[r14]
                                                        state = r30 and (13) or (14)
                                                        r19 = r30
                                                    end
                                                else
                                                    if state == 11 then
                                                        r18 = upvalueValues[r14]
                                                        state = r18 and (15) or (16)
                                                        ReturnVal = r18
                                                    end
                                                end
                                            else
                                                if state <= 12 then
                                                    if state == 12 then
                                                        r8 = upvalueValues[r14]
                                                        state = r8 and (17) or (18)
                                                        r18 = r8
                                                    end
                                                else
                                                    if state == 13 then
                                                        r30 = r15 == r10
                                                        r19 = r30
                                                        state = 14
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 15 then
                                                if state <= 14 then
                                                    if state == 14 then
                                                        upvalueValues[r14] = r19
                                                        state = upvalueValues[r14]
                                                        state = state and (19) or (20)
                                                    end
                                                else
                                                    if state == 15 then
                                                        r8 = state
                                                        r33 = 1
                                                        r3 = r26[r33]
                                                        r33 = false
                                                        r32 = r3 == r33
                                                        state = r32 and (21) or (22)
                                                        r18 = r32
                                                    end
                                                end
                                            else
                                                if state <= 16 then
                                                    if state == 16 then
                                                        upvalueValues[r14] = ReturnVal
                                                        state = 23
                                                    end
                                                else
                                                    if state == 17 then
                                                        r32 = 1
                                                        r8 = r26[r32]
                                                        r18 = r8
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
                                                            upvalueValues[r14] = r18
                                                            r33 = upvalueValues[r23]
                                                            r20 = 1
                                                            r3 = r33 + r20
                                                            r32 = r26[r3]
                                                            r8 = r15 + r32
                                                            r32 = 256
                                                            state = r8 % r32
                                                            r15 = state
                                                            r3 = upvalueValues[r25]
                                                            r32 = r10 + r3
                                                            r3 = 256
                                                            r8 = r32 % r3
                                                            r10 = r8
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
                                                        r3 = r26[r33]
                                                        r33 = upvalueValues[r28]
                                                        r32 = r3 == r33
                                                        r18 = r32
                                                        state = 22
                                                    end
                                                else
                                                    if state == 22 then
                                                        state = r8
                                                        ReturnVal = r18
                                                        state = 16
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 24 then
                                                if state <= 23 then
                                                    if state == 23 then
                                                        r25 = releaseUpvalue(r25)
                                                        r28 = releaseUpvalue(r28)
                                                        r23 = releaseUpvalue(r23)
                                                        r12 = releaseUpvalue(r12)
                                                        r26 = nil
                                                        r22 = releaseUpvalue(r22)
                                                        r17 = releaseUpvalue(r17)
                                                        state = 8
                                                    end
                                                else
                                                    if state == 24 then
                                                        r21 = releaseUpvalue(r21)
                                                        r9 = releaseUpvalue(r9)
                                                        r16 = releaseUpvalue(r16)
                                                        r9 = allocUpvalue()
                                                        r4 = releaseUpvalue(r4)
                                                        r14 = releaseUpvalue(r14)
                                                        r1 = releaseUpvalue(r1)
                                                        r15 = nil
                                                        r15 = {}
                                                        r29 = releaseUpvalue(r29)
                                                        r14 = nil
                                                        upvalueValues[r9] = r14
                                                        r5 = releaseUpvalue(r5)
                                                        r13 = nil
                                                        r13 = {}
                                                        r14 = allocUpvalue()
                                                        r10 = nil
                                                        r10 = allocUpvalue()
                                                        r5 = nil
                                                        upvalueValues[r14] = r5
                                                        r6 = nil
                                                        r6 = "math"
                                                        r29 = _env[r6]
                                                        r6 = "floor"
                                                        r5 = r29[r6]
                                                        r29 = allocUpvalue()
                                                        upvalueValues[r29] = r5
                                                        r16 = "math"
                                                        r6 = _env[r16]
                                                        r4 = allocUpvalue()
                                                        r16 = "random"
                                                        r5 = r6[r16]
                                                        r2 = nil
                                                        r2 = "table"
                                                        r16 = _env[r2]
                                                        r2 = "remove"
                                                        r6 = r16[r2]
                                                        r1 = "string"
                                                        r2 = _env[r1]
                                                        r1 = "char"
                                                        r16 = r2[r1]
                                                        r1 = allocUpvalue()
                                                        r2 = 0
                                                        upvalueValues[r1] = r2
                                                        r21 = 256
                                                        r2 = 2
                                                        upvalueValues[r4] = r2
                                                        upvalueValues[r10] = r15
                                                        r31 = r21
                                                        r2 = {}
                                                        r21 = 1
                                                        r22 = r21
                                                        r21 = 0
                                                        r12 = r22 < r21
                                                        r24 = nil
                                                        r24 = 1
                                                        r21 = r24 - r22
                                                        r15 = 0
                                                        state = 26
                                                    end
                                                end
                                            else
                                                if state <= 25 then
                                                    if state == 25 then
                                                        state = createClosure5(50, {
                                                            r9
                                                        })
                                                        r30 = {
                                                            state()
                                                        }
                                                        ReturnVal = {
                                                            unpack(r30)
                                                        }
                                                        state = nil
                                                    end
                                                else
                                                    if state == 26 then
                                                        r25 = not r12
                                                        r21 = r21 + r22
                                                        r24 = r21 <= r31
                                                        r24 = r25 and r24
                                                        r25 = r21 >= r31
                                                        r25 = r12 and r25
                                                        r24 = r25 or r24
                                                        r25 = (27)
                                                        state = r24 and r25
                                                        r24 = (28)
                                                        state = state or r24
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 30 then
                                            if state <= 28 then
                                                if state <= 27 then
                                                    if state == 27 then
                                                        r24 = r21
                                                        r25 = r24
                                                        r13[r24] = r25
                                                        r24 = nil
                                                        state = 26
                                                    end
                                                else
                                                    if state == 28 then
                                                        r21 = #r13
                                                        r31 = 0
                                                        r24 = r21 == r31
                                                        state = 29
                                                    end
                                                end
                                            else
                                                if state <= 29 then
                                                    if state == 29 then
                                                        r31 = #r13
                                                        r21 = 1
                                                        r24 = r5(r21, r31)
                                                        r21 = r6(r13, r24)
                                                        r31 = upvalueValues[r10]
                                                        r25 = 1
                                                        r12 = r21 - r25
                                                        r22 = r16(r12)
                                                        r24 = nil
                                                        r31[r21] = r22
                                                        r21 = nil
                                                        state = 30
                                                    end
                                                else
                                                    if state == 30 then
                                                        r21 = #r13
                                                        r31 = 0
                                                        r24 = r21 == r31
                                                        state = r24 and (31) or (29)
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 32 then
                                                if state <= 31 then
                                                    if state == 31 then
                                                        r21 = allocUpvalue()
                                                        r24 = {}
                                                        upvalueValues[r21] = r24
                                                        r25 = {}
                                                        r24 = allocUpvalue()
                                                        r31 = createClosure2(54, {
                                                            r21,
                                                            r1,
                                                            r4,
                                                            r29
                                                        })
                                                        r22 = allocUpvalue()
                                                        upvalueValues[r24] = r31
                                                        r31 = {}
                                                        upvalueValues[r22] = r31
                                                        r12 = "setmetatable"
                                                        r31 = _env[r12]
                                                        r28 = upvalueValues[r22]
                                                        r32 = nil
                                                        r26 = "__metatable"
                                                        r17 = "__index"
                                                        r23 = {
                                                            [r17] = r28,
                                                            [r26] = r32
                                                        }
                                                        r12 = r31(r25, r23)
                                                        r6 = nil
                                                        r6 = {}
                                                        r31 = createClosure2(60, {
                                                            r22,
                                                            r21,
                                                            r10,
                                                            r1,
                                                            r4,
                                                            r24
                                                        })
                                                        r29 = releaseUpvalue(r29)
                                                        r22 = releaseUpvalue(r22)
                                                        r21 = releaseUpvalue(r21)
                                                        r10 = releaseUpvalue(r10)
                                                        r1 = releaseUpvalue(r1)
                                                        upvalueValues[r9] = r12
                                                        r24 = releaseUpvalue(r24)
                                                        upvalueValues[r14] = r31
                                                        r29 = "setmetatable"
                                                        r5 = nil
                                                        r5 = _env[r29]
                                                        r4 = releaseUpvalue(r4)
                                                        r1 = upvalueValues[r9]
                                                        r4 = upvalueValues[r14]
                                                        r13 = nil
                                                        r13 = 6082244758288
                                                        r10 = "h\210\143L\002\139\"\1674."
                                                        r15 = nil
                                                        r15 = r4(r10, r13)
                                                        r2 = nil
                                                        r2 = r1[r15]
                                                        r1 = createClosure2(67, {
                                                            r9,
                                                            r14
                                                        })
                                                        r16 = nil
                                                        r16 = {
                                                            [r2] = r1
                                                        }
                                                        r29 = r5(r6, r16)
                                                        r5 = allocUpvalue()
                                                        r16 = createClosure2(68, {
                                                            r5,
                                                            r9,
                                                            r14
                                                        })
                                                        upvalueValues[r5] = r29
                                                        r6 = "pcall"
                                                        r29 = _env[r6]
                                                        r6 = r29(r16)
                                                        state = r6 and (32) or (33)
                                                    end
                                                else
                                                    if state == 32 then
                                                        r16 = "print"
                                                        r29 = _env[r16]
                                                        r1 = upvalueValues[r9]
                                                        r4 = upvalueValues[r14]
                                                        r13 = 14394889820719
                                                        r10 = "\r6\129n\195O\190\183\153!\222\185\185m"
                                                        r15 = r4(r10, r13)
                                                        r2 = r1[r15]
                                                        r16 = r29(r2)
                                                        state = 34
                                                    end
                                                end
                                            else
                                                if state <= 33 then
                                                    if state == 33 then
                                                        r16 = "print"
                                                        r29 = _env[r16]
                                                        r1 = upvalueValues[r9]
                                                        r4 = upvalueValues[r14]
                                                        r10 = "\028\129\148\016\2362\245"
                                                        r13 = 12471026439855
                                                        r15 = r4(r10, r13)
                                                        r2 = r1[r15]
                                                        r16 = r29(r2)
                                                        state = 34
                                                    end
                                                else
                                                    if state == 34 then
                                                        r9 = releaseUpvalue(r9)
                                                        r14 = releaseUpvalue(r14)
                                                        ReturnVal = {}
                                                        r5 = releaseUpvalue(r5)
                                                        r6 = nil
                                                        state = nil
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure5 entry 8950730 -> 35, states 35-35
                                if state == 35 then -- entry 8950730 -> 35
                                    state = true
                                    upvalueValues[upvalues[1]] = state
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            -- createClosure0 entry 3638493 -> 36, states 36-36
                            if state == 36 then -- entry 3638493 -> 36
                                ReturnVal = "error"
                                state = _env[ReturnVal]
                                r27 = "Tamper Detected!"
                                ReturnVal = state(r27)
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    else
                        if state <= 49 then
                            if state <= 37 then
                                -- createClosure5 entry 5661121 -> 37, states 37-37
                                if state == 37 then -- entry 5661121 -> 37
                                    r5 = 10824821
                                    r14 = "M7"
                                    r27 = r14 ^ r5
                                    ReturnVal = 282380
                                    state = ReturnVal - r27
                                    r27 = state
                                    ReturnVal = "LbbU"
                                    state = ReturnVal / r27
                                    ReturnVal = {
                                        state
                                    }
                                    state = nil
                                end
                            else
                                -- createClosure2 entry 5822612 -> 38, states 38-49
                                if state <= 43 then
                                    if state <= 40 then
                                        if state <= 39 then
                                            if state <= 38 then
                                                if state == 38 then -- entry 5822612 -> 38
                                                    r14 = upvalueValues[upvalues[1]]
                                                    r29 = 2
                                                    r9 = 1
                                                    r5 = r14(r9, r29)
                                                    r14 = 1
                                                    r27 = r5 == r14
                                                    state = r27 and (39) or (40)
                                                    ReturnVal = r27
                                                end
                                            else
                                                if state == 39 then
                                                    state = ReturnVal and (41) or (42)
                                                end
                                            end
                                        else
                                            if state == 40 then
                                                r14 = upvalueValues[upvalues[2]]
                                                r5 = upvalueValues[upvalues[3]]
                                                r27 = r14 == r5
                                                ReturnVal = r27
                                                state = 39
                                            end
                                        end
                                    else
                                        if state <= 42 then
                                            if state <= 41 then
                                                if state == 41 then
                                                    ReturnVal = "tonumber"
                                                    state = _env[ReturnVal]
                                                    r1 = createClosure2(69, {})
                                                    r27 = upvalueValues[upvalues[4]]
                                                    r9 = "tostring"
                                                    r5 = _env[r9]
                                                    r2 = "pcall"
                                                    r16 = _env[r2]
                                                    r2 = {
                                                        r16(r1)
                                                    }
                                                    r6 = {
                                                        unpack(r2)
                                                    }
                                                    r16 = 2
                                                    r29 = r6[r16]
                                                    r9 = r5(r29)
                                                    r5 = ":(%d*):"
                                                    r14 = r27(r9, r5)
                                                    r27 = {
                                                        r14()
                                                    }
                                                    ReturnVal = state(unpack(r27))
                                                    r27 = ReturnVal
                                                    r14 = upvalueValues[upvalues[5]]
                                                    state = r14 and (43) or (44)
                                                    ReturnVal = r14
                                                end
                                            else
                                                if state == 42 then
                                                    state = upvalueValues[upvalues[7]]
                                                    state = state and (45) or (46)
                                                end
                                            end
                                        else
                                            if state == 43 then
                                                r5 = upvalueValues[upvalues[6]]
                                                r14 = r5 == r27
                                                ReturnVal = r14
                                                state = 44
                                            end
                                        end
                                    end
                                else
                                    if state <= 46 then
                                        if state <= 45 then
                                            if state <= 44 then
                                                if state == 44 then
                                                    r27 = nil
                                                    upvalueValues[upvalues[5]] = ReturnVal
                                                    state = 42
                                                end
                                            else
                                                if state == 45 then
                                                    r27 = "error"
                                                    state = _env[r27]
                                                    r14 = upvalueValues[upvalues[8]]
                                                    r5 = 0
                                                    r27 = state(r14, r5)
                                                    state = 46
                                                end
                                            end
                                        else
                                            if state == 46 then
                                                state = {}
                                                r27 = state
                                                r5 = upvalueValues[upvalues[9]]
                                                r9 = r5
                                                r5 = 1
                                                r29 = r5
                                                r5 = 0
                                                r6 = r29 < r5
                                                r14 = 1
                                                r5 = r14 - r29
                                                state = 47
                                            end
                                        end
                                    else
                                        if state <= 48 then
                                            if state <= 47 then
                                                if state == 47 then
                                                    r5 = r5 + r29
                                                    r16 = not r6
                                                    r14 = r5 <= r9
                                                    r14 = r16 and r14
                                                    r16 = r5 >= r9
                                                    r16 = r6 and r16
                                                    r14 = r16 or r14
                                                    r16 = (48)
                                                    state = r14 and r16
                                                    r14 = (49)
                                                    state = state or r14
                                                end
                                            else
                                                if state == 48 then
                                                    r14 = r5
                                                    state = upvalueValues[upvalues[1]]
                                                    r1 = 255
                                                    r2 = 0
                                                    r16 = state(r2, r1)
                                                    r27[r14] = r16
                                                    r14 = nil
                                                    state = 47
                                                end
                                            end
                                        else
                                            if state == 49 then
                                                state = upvalueValues[upvalues[10]]
                                                r14 = upvalueValues[upvalues[11]]
                                                r27[state] = r14
                                                state = upvalueValues[upvalues[12]]
                                                r14 = {
                                                    state(r27)
                                                }
                                                ReturnVal = {
                                                    unpack(r14)
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            -- createClosure5 entry 10858737 -> 50, states 50-53
                            if state <= 51 then
                                if state <= 50 then
                                    if state == 50 then -- entry 10858737 -> 50
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
                                        r27 = "l1"
                                        ReturnVal = _env[r27]
                                        r27 = "l1"
                                        _env[r27] = state
                                        r27 = "l2"
                                        _env[r27] = ReturnVal
                                        r27 = upvalueValues[upvalues[1]]
                                        r14 = r27()
                                        state = 51
                                    end
                                else
                                    if state == 53 then
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 67 then
                        if state <= 66 then
                            if state <= 59 then
                                -- createClosure2 entry 16116743 -> 54, states 54-59
                                if state <= 56 then
                                    if state <= 55 then
                                        if state <= 54 then
                                            if state == 54 then -- entry 16116743 -> 54
                                                r27 = upvalueValues[upvalues[1]]
                                                ReturnVal = #r27
                                                r27 = 0
                                                state = ReturnVal == r27
                                                state = state and (55) or (56)
                                            end
                                        else
                                            if state == 55 then
                                                r14 = upvalueValues[upvalues[2]]
                                                r5 = 213
                                                r27 = r14 * r5
                                                r14 = 23987635612577
                                                ReturnVal = r27 + r14
                                                r27 = 35184372088832
                                                state = ReturnVal % r27
                                                upvalueValues[upvalues[2]] = state
                                                r27 = upvalueValues[upvalues[3]]
                                                r14 = 1
                                                ReturnVal = r27 ~= r14
                                                state = 57
                                            end
                                        end
                                    else
                                        if state == 56 then
                                            r5 = "table"
                                            r14 = _env[r5]
                                            r5 = "remove"
                                            r27 = r14[r5]
                                            r5 = upvalueValues[upvalues[1]]
                                            r14 = {
                                                r27(r5)
                                            }
                                            ReturnVal = {
                                                unpack(r14)
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    if state <= 58 then
                                        if state <= 57 then
                                            if state == 57 then
                                                r14 = upvalueValues[upvalues[3]]
                                                r5 = 192
                                                r27 = r14 * r5
                                                r14 = 257
                                                ReturnVal = r27 % r14
                                                upvalueValues[upvalues[3]] = ReturnVal
                                                state = 58
                                            end
                                        else
                                            if state == 58 then
                                                r14 = upvalueValues[upvalues[3]]
                                                r5 = 1
                                                r27 = r14 ~= r5
                                                state = r27 and (59) or (57)
                                            end
                                        end
                                    else
                                        if state == 59 then
                                            r5 = 32
                                            r14 = upvalueValues[upvalues[3]]
                                            r27 = r14 % r5
                                            r1 = 2
                                            r9 = upvalueValues[upvalues[4]]
                                            r16 = upvalueValues[upvalues[2]]
                                            r24 = upvalueValues[upvalues[3]]
                                            r13 = r24 - r27
                                            r24 = 32
                                            r10 = r13 / r24
                                            r15 = 13
                                            r4 = r15 - r10
                                            r2 = r1 ^ r4
                                            r6 = r16 / r2
                                            r29 = r9(r6)
                                            r9 = 4294967296
                                            r5 = r29 % r9
                                            r29 = 2
                                            r9 = r29 ^ r27
                                            r14 = r5 / r9
                                            r1 = 256
                                            r9 = upvalueValues[upvalues[4]]
                                            r2 = 1
                                            r16 = r14 % r2
                                            r2 = 4294967296
                                            r6 = r16 * r2
                                            r29 = r9(r6)
                                            r9 = upvalueValues[upvalues[4]]
                                            r6 = r9(r14)
                                            r5 = r29 + r6
                                            r29 = 65536
                                            r16 = 65536
                                            r9 = r5 % r29
                                            r15 = 256
                                            r14 = nil
                                            r27 = nil
                                            r6 = r5 - r9
                                            r29 = r6 / r16
                                            r16 = 256
                                            r6 = r9 % r16
                                            r2 = r9 - r6
                                            r16 = r2 / r1
                                            r5 = nil
                                            r1 = 256
                                            r2 = r29 % r1
                                            r4 = r29 - r2
                                            r1 = r4 / r15
                                            r29 = nil
                                            r9 = nil
                                            r4 = {
                                                r6,
                                                r16,
                                                r2,
                                                r1
                                            }
                                            r6 = nil
                                            r16 = nil
                                            r1 = nil
                                            upvalueValues[upvalues[1]] = r4
                                            r2 = nil
                                            state = 56
                                        end
                                    end
                                end
                            else
                                -- createClosure2 entry 14079670 -> 60, states 60-66
                                if state <= 63 then
                                    if state <= 61 then
                                        if state <= 60 then
                                            if state == 60 then -- entry 14079670 -> 60
                                                state = upvalueValues[upvalues[1]]
                                                r5 = state
                                                r27 = args[1]
                                                r14 = args[2]
                                                state = r5[r14]
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
                                                r9 = ReturnVal
                                                r29 = 35184372088832
                                                ReturnVal = r14 % r29
                                                upvalueValues[upvalues[4]] = ReturnVal
                                                r16 = 255
                                                r6 = r14 % r16
                                                r16 = 2
                                                r29 = r6 + r16
                                                upvalueValues[upvalues[5]] = r29
                                                r2 = "string"
                                                r16 = _env[r2]
                                                r2 = "len"
                                                r6 = r16[r2]
                                                r16 = r6(r27)
                                                r6 = ""
                                                r5[r14] = r6
                                                r4 = 1
                                                r15 = r4
                                                r4 = 0
                                                r10 = r15 < r4
                                                r2 = 1
                                                r4 = r2 - r15
                                                r1 = r16
                                                r6 = 242
                                                state = 64
                                            end
                                        else
                                            if state == 63 then
                                                ReturnVal = {
                                                    r14
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    if state <= 65 then
                                        if state <= 64 then
                                            if state == 64 then
                                                r4 = r4 + r15
                                                r13 = not r10
                                                r2 = r4 <= r1
                                                r2 = r13 and r2
                                                r13 = r4 >= r1
                                                r13 = r10 and r13
                                                r2 = r13 or r2
                                                r13 = (65)
                                                state = r2 and r13
                                                r2 = (66)
                                                state = state or r2
                                            end
                                        else
                                            if state == 65 then
                                                r2 = r4
                                                r11 = "string"
                                                r30 = _env[r11]
                                                r11 = "byte"
                                                r19 = r30[r11]
                                                r30 = r19(r27, r2)
                                                r19 = upvalueValues[upvalues[6]]
                                                r11 = r19()
                                                r2 = nil
                                                r21 = r30 + r11
                                                r24 = r21 + r6
                                                r21 = 256
                                                r13 = r24 % r21
                                                r6 = r13
                                                r21 = r5[r14]
                                                r11 = 1
                                                r30 = r6 + r11
                                                r19 = r9[r30]
                                                r24 = r21 .. r19
                                                r5[r14] = r24
                                                state = 64
                                            end
                                        end
                                    else
                                        if state == 66 then
                                            r6 = nil
                                            r9 = nil
                                            r16 = nil
                                            state = 63
                                        end
                                    end
                                end
                            end
                        else
                            -- createClosure2 entry 14806107 -> 67, states 67-67
                            if state == 67 then -- entry 14806107 -> 67
                                ReturnVal = "error"
                                state = _env[ReturnVal]
                                r14 = upvalueValues[upvalues[1]]
                                r5 = upvalueValues[upvalues[2]]
                                r29 = " k\232\161\025\012\237\138\136"
                                r6 = 19898003104817
                                r9 = r5(r29, r6)
                                r27 = r14[r9]
                                ReturnVal = state(r27)
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    else
                        if state <= 68 then
                            -- createClosure2 entry 2308346 -> 68, states 68-68
                            if state == 68 then -- entry 2308346 -> 68
                                state = upvalueValues[upvalues[1]]
                                r27 = upvalueValues[upvalues[2]]
                                r14 = upvalueValues[upvalues[3]]
                                r29 = 13518350768278
                                r9 = "n\176\207\185"
                                r5 = r14(r9, r29)
                                ReturnVal = r27[r5]
                                r27 = true
                                state[ReturnVal] = r27
                                ReturnVal = {}
                                state = nil
                            end
                        else
                            -- createClosure2 entry 4607437 -> 69, states 69-69
                            if state == 69 then -- entry 4607437 -> 69
                                r5 = 16266623
                                r14 = "PHj80kst"
                                r27 = r14 ^ r5
                                ReturnVal = 7018267
                                state = ReturnVal - r27
                                r27 = state
                                ReturnVal = "dG"
                                state = ReturnVal / r27
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
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 3897646
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 3897646
                    end
                })
            end
        end
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)