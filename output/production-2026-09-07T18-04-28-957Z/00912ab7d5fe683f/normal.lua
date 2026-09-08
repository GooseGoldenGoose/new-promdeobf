return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure5, currentUpvalueId, releaseUpvalue, createUpvalueProxy, createClosure, createClosure0, createClosure4, vm, releaseUpvalues, createClosure2, upvalueValues, createClosure6, upvalueRefCounts, allocUpvalue)
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
        createClosure = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(...)
                return vm(entryId, {
                    ...
                }, captures, gcProxy)
            end
            return closure
        end
        upvalueRefCounts = {}
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, ReturnVal, r31, r32, r33
            while state do
                if state <= 46 then
                    if state <= 33 then
                        if state <= 32 then
                            if state <= 31 then
                                -- root entry 16253045 -> 1, states 1-31
                                if state <= 16 then
                                    if state <= 8 then
                                        if state <= 4 then
                                            if state <= 2 then
                                                if state <= 1 then
                                                    if state == 1 then -- entry 16253045 -> 1
                                                        r22 = allocUpvalue()
                                                        state = true
                                                        upvalueValues[r22] = state
                                                        r33 = allocUpvalue()
                                                        r14 = "string"
                                                        ReturnVal = _env[r14]
                                                        r28 = allocUpvalue()
                                                        r14 = "gmatch"
                                                        state = ReturnVal[r14]
                                                        r14 = allocUpvalue()
                                                        upvalueValues[r14] = state
                                                        state = createClosure4(32, {})
                                                        upvalueValues[r33] = state
                                                        r27 = createClosure2(33, {
                                                            r28
                                                        })
                                                        state = false
                                                        upvalueValues[r28] = state
                                                        r3 = "pcall"
                                                        r8 = _env[r3]
                                                        r3 = r8(r27)
                                                        state = r3 and (2) or (3)
                                                        r21 = args
                                                        ReturnVal = r3
                                                    end
                                                else
                                                    if state == 2 then
                                                        r8 = upvalueValues[r28]
                                                        ReturnVal = r8
                                                        state = 3
                                                    end
                                                end
                                            else
                                                if state <= 3 then
                                                    if state == 3 then
                                                        r8 = ReturnVal
                                                        r3 = "math"
                                                        ReturnVal = _env[r3]
                                                        r3 = "random"
                                                        state = ReturnVal[r3]
                                                        r3 = allocUpvalue()
                                                        upvalueValues[r3] = state
                                                        r27 = "table"
                                                        ReturnVal = _env[r27]
                                                        r27 = "concat"
                                                        state = ReturnVal[r27]
                                                        r26 = state
                                                        r27 = state
                                                        r17 = "table"
                                                        r6 = _env[r17]
                                                        state = r6 and (4) or (5)
                                                        r10 = r6
                                                    end
                                                else
                                                    if state == 4 then
                                                        r24 = "table"
                                                        r17 = _env[r24]
                                                        r24 = "unpack"
                                                        r6 = r17[r24]
                                                        r10 = r6
                                                        state = 5
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 6 then
                                                if state <= 5 then
                                                    if state == 5 then
                                                        state = r26
                                                        state = r10 and (6) or (7)
                                                        ReturnVal = r10
                                                    end
                                                else
                                                    if state == 6 then
                                                        r10 = allocUpvalue()
                                                        upvalueValues[r10] = ReturnVal
                                                        state = upvalueValues[r3]
                                                        r26 = 3
                                                        r6 = 65
                                                        ReturnVal = state(r26, r6)
                                                        r26 = allocUpvalue()
                                                        state = 0
                                                        upvalueValues[r26] = ReturnVal
                                                        r6 = state
                                                        r7 = createClosure4(34, {})
                                                        state = 0
                                                        r24 = "pcall"
                                                        ReturnVal = _env[r24]
                                                        r24 = {
                                                            ReturnVal(r7)
                                                        }
                                                        r17 = state
                                                        state = {
                                                            unpack(r24)
                                                        }
                                                        r24 = state
                                                        ReturnVal = 2
                                                        state = r24[ReturnVal]
                                                        r7 = state
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r9 = upvalueValues[r14]
                                                        r25 = "tostring"
                                                        r30 = _env[r25]
                                                        r25 = r30(r7)
                                                        r30 = ":(%d*):"
                                                        r20 = r9(r25, r30)
                                                        r9 = {
                                                            r20()
                                                        }
                                                        ReturnVal = state(unpack(r9))
                                                        r9 = allocUpvalue()
                                                        upvalueValues[r9] = ReturnVal
                                                        r20 = upvalueValues[r26]
                                                        r30 = r20
                                                        r20 = 1
                                                        r25 = r20
                                                        r20 = 0
                                                        r32 = r25 < r20
                                                        ReturnVal = 1
                                                        r20 = ReturnVal - r25
                                                        state = 8
                                                    end
                                                end
                                            else
                                                if state <= 7 then
                                                    if state == 7 then
                                                        r26 = "unpack"
                                                        r10 = _env[r26]
                                                        ReturnVal = r10
                                                        state = 6
                                                    end
                                                else
                                                    if state == 8 then
                                                        r29 = not r32
                                                        r20 = r20 + r25
                                                        ReturnVal = r20 <= r30
                                                        ReturnVal = r29 and ReturnVal
                                                        r29 = r20 >= r30
                                                        r29 = r32 and r29
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
                                                        upvalueValues[r29] = r20
                                                        r31 = "math"
                                                        ReturnVal = _env[r31]
                                                        r31 = "random"
                                                        state = ReturnVal[r31]
                                                        r2 = 100
                                                        r31 = 1
                                                        ReturnVal = state(r31, r2)
                                                        r31 = allocUpvalue()
                                                        upvalueValues[r31] = ReturnVal
                                                        state = upvalueValues[r3]
                                                        r4 = 255
                                                        r2 = 0
                                                        ReturnVal = state(r2, r4)
                                                        r2 = allocUpvalue()
                                                        upvalueValues[r2] = ReturnVal
                                                        state = upvalueValues[r3]
                                                        r13 = upvalueValues[r31]
                                                        r4 = 1
                                                        ReturnVal = state(r4, r13)
                                                        r4 = allocUpvalue()
                                                        upvalueValues[r4] = ReturnVal
                                                        ReturnVal = upvalueValues[r3]
                                                        r12 = 2
                                                        r11 = 1
                                                        r13 = ReturnVal(r11, r12)
                                                        ReturnVal = 1
                                                        state = r13 == ReturnVal
                                                        r13 = allocUpvalue()
                                                        upvalueValues[r13] = state
                                                        r15 = "tostring"
                                                        r23 = _env[r15]
                                                        r19 = upvalueValues[r3]
                                                        r16 = 10000
                                                        r5 = 0
                                                        r18 = {
                                                            r19(r5, r16)
                                                        }
                                                        r15 = r23(unpack(r18))
                                                        r23 = ":"
                                                        r1 = r15 .. r23
                                                        r12 = ":"
                                                        r11 = r12 .. r1
                                                        state = "gsub"
                                                        state = r7[state]
                                                        ReturnVal = ":(%d*):"
                                                        state = state(r7, ReturnVal, r11)
                                                        r11 = allocUpvalue()
                                                        upvalueValues[r11] = state
                                                        r12 = "pcall"
                                                        ReturnVal = _env[r12]
                                                        r1 = createClosure5(35, {
                                                            r3,
                                                            r29,
                                                            r26,
                                                            r14,
                                                            r22,
                                                            r9,
                                                            r13,
                                                            r11,
                                                            r31,
                                                            r4,
                                                            r2,
                                                            r10
                                                        })
                                                        r12 = {
                                                            ReturnVal(r1)
                                                        }
                                                        state = {
                                                            unpack(r12)
                                                        }
                                                        r12 = state
                                                        state = upvalueValues[r13]
                                                        state = state and (11) or (12)
                                                    end
                                                else
                                                    if state == 10 then
                                                        r30 = upvalueValues[r22]
                                                        state = r30 and (13) or (14)
                                                        r20 = r30
                                                    end
                                                end
                                            else
                                                if state <= 11 then
                                                    if state == 11 then
                                                        r1 = upvalueValues[r22]
                                                        state = r1 and (15) or (16)
                                                        ReturnVal = r1
                                                    end
                                                else
                                                    if state == 12 then
                                                        r23 = upvalueValues[r22]
                                                        state = r23 and (17) or (18)
                                                        r1 = r23
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 14 then
                                                if state <= 13 then
                                                    if state == 13 then
                                                        r30 = r6 == r17
                                                        r20 = r30
                                                        state = 14
                                                    end
                                                else
                                                    if state == 14 then
                                                        upvalueValues[r22] = r20
                                                        state = upvalueValues[r22]
                                                        state = state and (19) or (20)
                                                    end
                                                end
                                            else
                                                if state <= 15 then
                                                    if state == 15 then
                                                        r23 = state
                                                        r18 = 1
                                                        r19 = r12[r18]
                                                        r18 = false
                                                        r15 = r19 == r18
                                                        state = r15 and (21) or (22)
                                                        r1 = r15
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
                                                        r15 = 1
                                                        r23 = r12[r15]
                                                        r1 = r23
                                                        state = 18
                                                    end
                                                else
                                                    if state == 18 then
                                                        upvalueValues[r22] = r1
                                                        r18 = upvalueValues[r4]
                                                        r5 = 1
                                                        r19 = r18 + r5
                                                        r15 = r12[r19]
                                                        r23 = r6 + r15
                                                        r15 = 256
                                                        state = r23 % r15
                                                        r6 = state
                                                        r19 = upvalueValues[r2]
                                                        r15 = r17 + r19
                                                        r19 = 256
                                                        r23 = r15 % r19
                                                        r17 = r23
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
                                                        r18 = 2
                                                        r19 = r12[r18]
                                                        r18 = upvalueValues[r11]
                                                        r15 = r19 == r18
                                                        r1 = r15
                                                        state = 22
                                                    end
                                                else
                                                    if state == 22 then
                                                        state = r23
                                                        ReturnVal = r1
                                                        state = 16
                                                    end
                                                end
                                            else
                                                if state <= 23 then
                                                    if state == 23 then
                                                        r2 = releaseUpvalue(r2)
                                                        r4 = releaseUpvalue(r4)
                                                        r13 = releaseUpvalue(r13)
                                                        r12 = nil
                                                        r29 = releaseUpvalue(r29)
                                                        r11 = releaseUpvalue(r11)
                                                        r31 = releaseUpvalue(r31)
                                                        state = 8
                                                    end
                                                else
                                                    if state == 24 then
                                                        r6 = nil
                                                        r17 = nil
                                                        r26 = releaseUpvalue(r26)
                                                        r7 = nil
                                                        r3 = releaseUpvalue(r3)
                                                        r33 = releaseUpvalue(r33)
                                                        r22 = releaseUpvalue(r22)
                                                        r22 = nil
                                                        r14 = releaseUpvalue(r14)
                                                        r9 = releaseUpvalue(r9)
                                                        r17 = allocUpvalue()
                                                        r28 = releaseUpvalue(r28)
                                                        r10 = releaseUpvalue(r10)
                                                        r14 = nil
                                                        r26 = allocUpvalue()
                                                        r6 = {}
                                                        r8 = nil
                                                        r8 = "math"
                                                        r28 = _env[r8]
                                                        r8 = "floor"
                                                        r33 = r28[r8]
                                                        r24 = nil
                                                        r24 = {}
                                                        r28 = allocUpvalue()
                                                        upvalueValues[r28] = r33
                                                        r3 = "math"
                                                        r8 = _env[r3]
                                                        r3 = "random"
                                                        r33 = r8[r3]
                                                        r27 = nil
                                                        r27 = "table"
                                                        r3 = _env[r27]
                                                        r27 = "remove"
                                                        r8 = r3[r27]
                                                        r10 = "string"
                                                        r27 = _env[r10]
                                                        r10 = "char"
                                                        r3 = r27[r10]
                                                        r10 = allocUpvalue()
                                                        r27 = 0
                                                        upvalueValues[r10] = r27
                                                        r27 = 2
                                                        upvalueValues[r26] = r27
                                                        r27 = {}
                                                        upvalueValues[r17] = r6
                                                        r9 = 256
                                                        r32 = r9
                                                        r9 = 1
                                                        r29 = r9
                                                        r9 = 0
                                                        r31 = r29 < r9
                                                        r7 = 1
                                                        r9 = r7 - r29
                                                        r6 = 0
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
                                                        state = createClosure0(47, {
                                                            r33
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
                                                        r9 = r9 + r29
                                                        r7 = r9 <= r32
                                                        r2 = not r31
                                                        r7 = r2 and r7
                                                        r2 = r9 >= r32
                                                        r2 = r31 and r2
                                                        r7 = r2 or r7
                                                        r2 = (27)
                                                        state = r7 and r2
                                                        r7 = (28)
                                                        state = state or r7
                                                    end
                                                end
                                            else
                                                if state <= 27 then
                                                    if state == 27 then
                                                        r7 = r9
                                                        r2 = r7
                                                        r24[r7] = r2
                                                        r7 = nil
                                                        state = 26
                                                    end
                                                else
                                                    if state == 28 then
                                                        r9 = #r24
                                                        r32 = 0
                                                        r7 = r9 == r32
                                                        state = 29
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 30 then
                                                if state <= 29 then
                                                    if state == 29 then
                                                        r2 = 1
                                                        r32 = #r24
                                                        r9 = 1
                                                        r7 = r33(r9, r32)
                                                        r9 = r8(r24, r7)
                                                        r7 = nil
                                                        r32 = upvalueValues[r17]
                                                        r31 = r9 - r2
                                                        r29 = r3(r31)
                                                        r32[r9] = r29
                                                        r9 = nil
                                                        state = 30
                                                    end
                                                else
                                                    if state == 30 then
                                                        r9 = #r24
                                                        r32 = 0
                                                        r7 = r9 == r32
                                                        state = r7 and (31) or (29)
                                                    end
                                                end
                                            else
                                                if state == 31 then
                                                    r2 = {}
                                                    r7 = {}
                                                    r9 = allocUpvalue()
                                                    upvalueValues[r9] = r7
                                                    r7 = allocUpvalue()
                                                    r32 = createClosure5(51, {
                                                        r9,
                                                        r10,
                                                        r26,
                                                        r28
                                                    })
                                                    upvalueValues[r7] = r32
                                                    r32 = {}
                                                    r29 = allocUpvalue()
                                                    upvalueValues[r29] = r32
                                                    r31 = "setmetatable"
                                                    r32 = _env[r31]
                                                    r11 = upvalueValues[r29]
                                                    r13 = "__index"
                                                    r15 = nil
                                                    r12 = "__metatable"
                                                    r4 = {
                                                        [r13] = r11,
                                                        [r12] = r15
                                                    }
                                                    r31 = r32(r2, r4)
                                                    r6 = nil
                                                    r6 = "\250{\n\135\024o\196\151\008\1751\021\250\157\228Z\024c\145\246>L!;T\143\231\221\202\226A\188j2\166Vg\217M\243\149E\1813I\143\173\245\2011C\011{0:\182\2496{\2437\169\236i>8\028^jb/\016\182\158\163\165\t\019\003\185\1726\183}\20807\138lB"
                                                    r33 = nil
                                                    r3 = nil
                                                    r3 = 15270644849606
                                                    r24 = nil
                                                    r28 = releaseUpvalue(r28)
                                                    r22 = r31
                                                    r32 = createClosure6(57, {
                                                        r29,
                                                        r9,
                                                        r17,
                                                        r10,
                                                        r26,
                                                        r7
                                                    })
                                                    r14 = r32
                                                    r7 = releaseUpvalue(r7)
                                                    r17 = releaseUpvalue(r17)
                                                    r8 = nil
                                                    r8 = "tv\173\008\174u\210\222~\134hx\025Gh#\224Mk"
                                                    r28 = r14(r8, r3)
                                                    r26 = releaseUpvalue(r26)
                                                    r9 = releaseUpvalue(r9)
                                                    ReturnVal = {}
                                                    r29 = releaseUpvalue(r29)
                                                    r33 = r22[r28]
                                                    r10 = releaseUpvalue(r10)
                                                    r28 = "PROTECT_ID"
                                                    _env[r28] = r33
                                                    r8 = "loadstring"
                                                    r28 = _env[r8]
                                                    r27 = nil
                                                    r27 = "game"
                                                    r3 = _env[r27]
                                                    r17 = 19013016560277
                                                    r26 = r14(r6, r17)
                                                    r14 = nil
                                                    r10 = r22[r26]
                                                    r26 = "HttpGet"
                                                    r22 = nil
                                                    r26 = r3[r26]
                                                    r27 = {
                                                        r26(r3, r10)
                                                    }
                                                    r8 = r28(unpack(r27))
                                                    r28 = r8()
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure4 entry 8849042 -> 32, states 32-32
                                if state == 32 then -- entry 8849042 -> 32
                                    ReturnVal = "error"
                                    state = _env[ReturnVal]
                                    r21 = "Tamper Detected!"
                                    ReturnVal = state(r21)
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            -- createClosure2 entry 3589118 -> 33, states 33-33
                            if state == 33 then -- entry 3589118 -> 33
                                state = true
                                upvalueValues[upvalues[1]] = state
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    else
                        if state <= 34 then
                            -- createClosure4 entry 169748 -> 34, states 34-34
                            if state == 34 then -- entry 169748 -> 34
                                r22 = "kc5goFjLVhQVfD9"
                                r14 = 26420
                                r21 = r22 ^ r14
                                ReturnVal = 2214229
                                state = ReturnVal - r21
                                r21 = state
                                ReturnVal = "L8TGZTQRy2qP0"
                                state = ReturnVal / r21
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        else
                            -- createClosure5 entry 6297352 -> 35, states 35-46
                            if state <= 40 then
                                if state <= 37 then
                                    if state <= 36 then
                                        if state <= 35 then
                                            if state == 35 then -- entry 6297352 -> 35
                                                r22 = upvalueValues[upvalues[1]]
                                                r33 = 1
                                                r28 = 2
                                                r14 = r22(r33, r28)
                                                r22 = 1
                                                r21 = r14 == r22
                                                state = r21 and (36) or (37)
                                                ReturnVal = r21
                                            end
                                        else
                                            if state == 36 then
                                                state = ReturnVal and (38) or (39)
                                            end
                                        end
                                    else
                                        if state == 37 then
                                            r22 = upvalueValues[upvalues[2]]
                                            r14 = upvalueValues[upvalues[3]]
                                            r21 = r22 == r14
                                            ReturnVal = r21
                                            state = 36
                                        end
                                    end
                                else
                                    if state <= 39 then
                                        if state <= 38 then
                                            if state == 38 then
                                                ReturnVal = "tonumber"
                                                state = _env[ReturnVal]
                                                r21 = upvalueValues[upvalues[4]]
                                                r33 = "tostring"
                                                r14 = _env[r33]
                                                r27 = "pcall"
                                                r3 = _env[r27]
                                                r10 = createClosure2(64, {})
                                                r27 = {
                                                    r3(r10)
                                                }
                                                r8 = {
                                                    unpack(r27)
                                                }
                                                r3 = 2
                                                r28 = r8[r3]
                                                r33 = r14(r28)
                                                r14 = ":(%d*):"
                                                r22 = r21(r33, r14)
                                                r21 = {
                                                    r22()
                                                }
                                                ReturnVal = state(unpack(r21))
                                                r21 = ReturnVal
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
                                            r14 = upvalueValues[upvalues[6]]
                                            r22 = r14 == r21
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
                                                r21 = nil
                                                state = 39
                                            end
                                        else
                                            if state == 42 then
                                                r21 = "error"
                                                state = _env[r21]
                                                r22 = upvalueValues[upvalues[8]]
                                                r14 = 0
                                                r21 = state(r22, r14)
                                                state = 43
                                            end
                                        end
                                    else
                                        if state == 43 then
                                            r14 = upvalueValues[upvalues[9]]
                                            r33 = r14
                                            state = {}
                                            r21 = state
                                            r14 = 1
                                            r28 = r14
                                            r14 = 0
                                            r8 = r28 < r14
                                            r22 = 1
                                            r14 = r22 - r28
                                            state = 44
                                        end
                                    end
                                else
                                    if state <= 45 then
                                        if state <= 44 then
                                            if state == 44 then
                                                r14 = r14 + r28
                                                r3 = not r8
                                                r22 = r14 <= r33
                                                r22 = r3 and r22
                                                r3 = r14 >= r33
                                                r3 = r8 and r3
                                                r22 = r3 or r22
                                                r3 = (45)
                                                state = r22 and r3
                                                r22 = (46)
                                                state = state or r22
                                            end
                                        else
                                            if state == 45 then
                                                state = upvalueValues[upvalues[1]]
                                                r22 = r14
                                                r27 = 0
                                                r10 = 255
                                                r3 = state(r27, r10)
                                                r21[r22] = r3
                                                r22 = nil
                                                state = 44
                                            end
                                        end
                                    else
                                        if state == 46 then
                                            state = upvalueValues[upvalues[10]]
                                            r22 = upvalueValues[upvalues[11]]
                                            r21[state] = r22
                                            state = upvalueValues[upvalues[12]]
                                            r22 = {
                                                state(r21)
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
                    if state <= 56 then
                        if state <= 50 then
                            -- createClosure0 entry 14707470 -> 47, states 47-50
                            if state <= 48 then
                                if state <= 47 then
                                    if state == 47 then -- entry 14707470 -> 47
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
                                        r21 = "l1"
                                        ReturnVal = _env[r21]
                                        r21 = "l1"
                                        _env[r21] = state
                                        r21 = "l2"
                                        _env[r21] = ReturnVal
                                        r21 = upvalueValues[upvalues[1]]
                                        r22 = r21()
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
                            -- createClosure5 entry 8321079 -> 51, states 51-56
                            if state <= 53 then
                                if state <= 52 then
                                    if state <= 51 then
                                        if state == 51 then -- entry 8321079 -> 51
                                            r21 = upvalueValues[upvalues[1]]
                                            ReturnVal = #r21
                                            r21 = 0
                                            state = ReturnVal == r21
                                            state = state and (52) or (53)
                                        end
                                    else
                                        if state == 52 then
                                            r22 = upvalueValues[upvalues[2]]
                                            r14 = 253
                                            r21 = r22 * r14
                                            r22 = 25667546656431
                                            ReturnVal = r21 + r22
                                            r21 = 35184372088832
                                            state = ReturnVal % r21
                                            upvalueValues[upvalues[2]] = state
                                            r21 = upvalueValues[upvalues[3]]
                                            r22 = 1
                                            ReturnVal = r21 ~= r22
                                            state = 54
                                        end
                                    end
                                else
                                    if state == 53 then
                                        r14 = "table"
                                        r22 = _env[r14]
                                        r14 = "remove"
                                        r21 = r22[r14]
                                        r14 = upvalueValues[upvalues[1]]
                                        r22 = {
                                            r21(r14)
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
                                            r14 = 40
                                            r21 = r22 * r14
                                            r22 = 257
                                            ReturnVal = r21 % r22
                                            upvalueValues[upvalues[3]] = ReturnVal
                                            state = 55
                                        end
                                    else
                                        if state == 55 then
                                            r22 = upvalueValues[upvalues[3]]
                                            r14 = 1
                                            r21 = r22 ~= r14
                                            state = r21 and (56) or (54)
                                        end
                                    end
                                else
                                    if state == 56 then
                                        r22 = upvalueValues[upvalues[3]]
                                        r14 = 32
                                        r10 = 2
                                        r21 = r22 % r14
                                        r33 = upvalueValues[upvalues[4]]
                                        r3 = upvalueValues[upvalues[2]]
                                        r7 = upvalueValues[upvalues[3]]
                                        r24 = r7 - r21
                                        r7 = 32
                                        r17 = r24 / r7
                                        r6 = 13
                                        r26 = r6 - r17
                                        r27 = r10 ^ r26
                                        r8 = r3 / r27
                                        r28 = r33(r8)
                                        r33 = 4294967296
                                        r14 = r28 % r33
                                        r27 = 1
                                        r28 = 2
                                        r33 = r28 ^ r21
                                        r22 = r14 / r33
                                        r33 = upvalueValues[upvalues[4]]
                                        r3 = r22 % r27
                                        r27 = 4294967296
                                        r8 = r3 * r27
                                        r6 = 256
                                        r21 = nil
                                        r28 = r33(r8)
                                        r3 = 65536
                                        r33 = upvalueValues[upvalues[4]]
                                        r8 = r33(r22)
                                        r14 = r28 + r8
                                        r28 = 65536
                                        r33 = r14 % r28
                                        r8 = r14 - r33
                                        r28 = r8 / r3
                                        r3 = 256
                                        r8 = r33 % r3
                                        r27 = r33 - r8
                                        r10 = 256
                                        r22 = nil
                                        r3 = r27 / r10
                                        r14 = nil
                                        r10 = 256
                                        r27 = r28 % r10
                                        r33 = nil
                                        r26 = r28 - r27
                                        r10 = r26 / r6
                                        r28 = nil
                                        r26 = {
                                            r8,
                                            r3,
                                            r27,
                                            r10
                                        }
                                        r27 = nil
                                        upvalueValues[upvalues[1]] = r26
                                        r8 = nil
                                        r3 = nil
                                        r10 = nil
                                        state = 53
                                    end
                                end
                            end
                        end
                    else
                        if state <= 63 then
                            -- createClosure6 entry 16434116 -> 57, states 57-63
                            if state <= 60 then
                                if state <= 58 then
                                    if state <= 57 then
                                        if state == 57 then -- entry 16434116 -> 57
                                            state = upvalueValues[upvalues[1]]
                                            r14 = state
                                            r22 = args[2]
                                            state = r14[r22]
                                            r21 = args[1]
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
                                            r33 = ReturnVal
                                            r28 = 35184372088832
                                            ReturnVal = r22 % r28
                                            upvalueValues[upvalues[4]] = ReturnVal
                                            r3 = 255
                                            r8 = r22 % r3
                                            r3 = 2
                                            r28 = r8 + r3
                                            upvalueValues[upvalues[5]] = r28
                                            r27 = "string"
                                            r3 = _env[r27]
                                            r27 = "len"
                                            r8 = r3[r27]
                                            r3 = r8(r21)
                                            r8 = ""
                                            r14[r22] = r8
                                            r26 = 1
                                            r6 = r26
                                            r26 = 0
                                            r17 = r6 < r26
                                            r27 = 1
                                            r26 = r27 - r6
                                            r10 = r3
                                            r8 = 152
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
                                            r24 = not r17
                                            r26 = r26 + r6
                                            r27 = r26 <= r10
                                            r27 = r24 and r27
                                            r24 = r26 >= r10
                                            r24 = r17 and r24
                                            r27 = r24 or r27
                                            r24 = (62)
                                            state = r27 and r24
                                            r27 = (63)
                                            state = state or r27
                                        end
                                    else
                                        if state == 62 then
                                            r25 = "string"
                                            r30 = _env[r25]
                                            r27 = r26
                                            r25 = "byte"
                                            r20 = r30[r25]
                                            r30 = r20(r21, r27)
                                            r20 = upvalueValues[upvalues[6]]
                                            r25 = r20()
                                            r9 = r30 + r25
                                            r27 = nil
                                            r7 = r9 + r8
                                            r9 = 256
                                            r24 = r7 % r9
                                            r8 = r24
                                            r9 = r14[r22]
                                            r25 = 1
                                            r30 = r8 + r25
                                            r20 = r33[r30]
                                            r7 = r9 .. r20
                                            r14[r22] = r7
                                            state = 61
                                        end
                                    end
                                else
                                    if state == 63 then
                                        r8 = nil
                                        r33 = nil
                                        r3 = nil
                                        state = 60
                                    end
                                end
                            end
                        else
                            -- createClosure2 entry 3714912 -> 64, states 64-64
                            if state == 64 then -- entry 3714912 -> 64
                                r22 = "x3yRYcskSStNg"
                                r14 = 832074
                                r21 = r22 ^ r14
                                ReturnVal = 16174278
                                state = ReturnVal - r21
                                r21 = state
                                ReturnVal = "wCVUQUq10yLqH"
                                state = ReturnVal / r21
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
                    return 1804150
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 1804150
                    end
                })
            end
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
        upvalueValues = {}
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