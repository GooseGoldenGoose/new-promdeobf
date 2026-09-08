return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, upvalueValues, createClosure0, upvalueRefCounts, createClosure1, createClosure4, createUpvalueProxy, releaseUpvalues, vm, createClosure, createClosure3, allocUpvalue, currentUpvalueId, releaseUpvalue, createClosure5)
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, ReturnVal, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42
            while state do
                if state <= 77 then
                    if state <= 60 then
                        if state <= 59 then
                            if state <= 58 then
                                -- root entry 4990554 -> 1, states 1-58
                                if state <= 29 then
                                    if state <= 15 then
                                        if state <= 8 then
                                            if state <= 4 then
                                                if state <= 2 then
                                                    if state <= 1 then
                                                        if state == 1 then -- entry 4990554 -> 1
                                                            r40 = allocUpvalue()
                                                            r39 = allocUpvalue()
                                                            r23 = createClosure3(59, {
                                                                r40
                                                            })
                                                            state = true
                                                            upvalueValues[r39] = state
                                                            r36 = "string"
                                                            ReturnVal = _env[r36]
                                                            r36 = "gmatch"
                                                            state = ReturnVal[r36]
                                                            r8 = allocUpvalue()
                                                            r36 = allocUpvalue()
                                                            upvalueValues[r36] = state
                                                            state = createClosure0(60, {})
                                                            upvalueValues[r8] = state
                                                            state = false
                                                            upvalueValues[r40] = state
                                                            r41 = "pcall"
                                                            r14 = _env[r41]
                                                            r41 = r14(r23)
                                                            state = r41 and (2) or (3)
                                                            ReturnVal = r41
                                                            r5 = args
                                                        end
                                                    else
                                                        if state == 2 then
                                                            r14 = upvalueValues[r40]
                                                            ReturnVal = r14
                                                            state = 3
                                                        end
                                                    end
                                                else
                                                    if state <= 3 then
                                                        if state == 3 then
                                                            r14 = ReturnVal
                                                            r41 = "math"
                                                            ReturnVal = _env[r41]
                                                            r41 = "random"
                                                            state = ReturnVal[r41]
                                                            r41 = allocUpvalue()
                                                            upvalueValues[r41] = state
                                                            r23 = "table"
                                                            ReturnVal = _env[r23]
                                                            r23 = "concat"
                                                            state = ReturnVal[r23]
                                                            r23 = state
                                                            r9 = state
                                                            r33 = "table"
                                                            r10 = _env[r33]
                                                            state = r10 and (4) or (5)
                                                            r21 = r10
                                                        end
                                                    else
                                                        if state == 4 then
                                                            r31 = "table"
                                                            r33 = _env[r31]
                                                            r31 = "unpack"
                                                            r10 = r33[r31]
                                                            r21 = r10
                                                            state = 5
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 6 then
                                                    if state <= 5 then
                                                        if state == 5 then
                                                            state = r9
                                                            state = r21 and (6) or (7)
                                                            ReturnVal = r21
                                                        end
                                                    else
                                                        if state == 6 then
                                                            r26 = createClosure1(61, {})
                                                            r21 = allocUpvalue()
                                                            upvalueValues[r21] = ReturnVal
                                                            state = upvalueValues[r41]
                                                            r9 = 3
                                                            r10 = 65
                                                            ReturnVal = state(r9, r10)
                                                            r9 = allocUpvalue()
                                                            upvalueValues[r9] = ReturnVal
                                                            state = 0
                                                            r10 = state
                                                            r31 = "pcall"
                                                            ReturnVal = _env[r31]
                                                            state = 0
                                                            r31 = {
                                                                ReturnVal(r26)
                                                            }
                                                            r33 = state
                                                            state = {
                                                                unpack(r31)
                                                            }
                                                            r31 = state
                                                            ReturnVal = 2
                                                            state = r31[ReturnVal]
                                                            r26 = state
                                                            ReturnVal = "tonumber"
                                                            state = _env[ReturnVal]
                                                            r17 = upvalueValues[r36]
                                                            r15 = "tostring"
                                                            r13 = _env[r15]
                                                            r15 = r13(r26)
                                                            r13 = ":(%d*):"
                                                            r27 = r17(r15, r13)
                                                            r17 = {
                                                                r27()
                                                            }
                                                            ReturnVal = state(unpack(r17))
                                                            r17 = allocUpvalue()
                                                            upvalueValues[r17] = ReturnVal
                                                            r27 = upvalueValues[r9]
                                                            r13 = r27
                                                            r27 = 1
                                                            r15 = r27
                                                            r27 = 0
                                                            r24 = r15 < r27
                                                            ReturnVal = 1
                                                            r27 = ReturnVal - r15
                                                            state = 8
                                                        end
                                                    end
                                                else
                                                    if state <= 7 then
                                                        if state == 7 then
                                                            r9 = "unpack"
                                                            r21 = _env[r9]
                                                            ReturnVal = r21
                                                            state = 6
                                                        end
                                                    else
                                                        if state == 8 then
                                                            r18 = not r24
                                                            r27 = r27 + r15
                                                            ReturnVal = r27 <= r13
                                                            ReturnVal = r18 and ReturnVal
                                                            r18 = r27 >= r13
                                                            r18 = r24 and r18
                                                            ReturnVal = r18 or ReturnVal
                                                            r18 = (9)
                                                            state = ReturnVal and r18
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
                                                            r18 = allocUpvalue()
                                                            upvalueValues[r18] = r27
                                                            r37 = "math"
                                                            ReturnVal = _env[r37]
                                                            r37 = "random"
                                                            state = ReturnVal[r37]
                                                            r12 = 100
                                                            r37 = 1
                                                            ReturnVal = state(r37, r12)
                                                            r37 = allocUpvalue()
                                                            upvalueValues[r37] = ReturnVal
                                                            state = upvalueValues[r41]
                                                            r12 = 0
                                                            r7 = 255
                                                            ReturnVal = state(r12, r7)
                                                            r12 = allocUpvalue()
                                                            upvalueValues[r12] = ReturnVal
                                                            state = upvalueValues[r41]
                                                            r1 = upvalueValues[r37]
                                                            r7 = 1
                                                            ReturnVal = state(r7, r1)
                                                            r7 = allocUpvalue()
                                                            upvalueValues[r7] = ReturnVal
                                                            ReturnVal = upvalueValues[r41]
                                                            r35 = 2
                                                            r4 = 1
                                                            r1 = ReturnVal(r4, r35)
                                                            ReturnVal = 1
                                                            state = r1 == ReturnVal
                                                            r1 = allocUpvalue()
                                                            upvalueValues[r1] = state
                                                            r30 = "tostring"
                                                            r16 = _env[r30]
                                                            r32 = upvalueValues[r41]
                                                            r3 = 10000
                                                            r11 = 0
                                                            r19 = {
                                                                r32(r11, r3)
                                                            }
                                                            r30 = r16(unpack(r19))
                                                            state = "gsub"
                                                            state = r26[state]
                                                            r16 = ":"
                                                            r42 = r30 .. r16
                                                            r35 = ":"
                                                            r4 = r35 .. r42
                                                            ReturnVal = ":(%d*):"
                                                            state = state(r26, ReturnVal, r4)
                                                            r4 = allocUpvalue()
                                                            upvalueValues[r4] = state
                                                            r42 = createClosure3(62, {
                                                                r41,
                                                                r18,
                                                                r9,
                                                                r36,
                                                                r39,
                                                                r17,
                                                                r1,
                                                                r4,
                                                                r37,
                                                                r7,
                                                                r12,
                                                                r21
                                                            })
                                                            r35 = "pcall"
                                                            ReturnVal = _env[r35]
                                                            r35 = {
                                                                ReturnVal(r42)
                                                            }
                                                            state = {
                                                                unpack(r35)
                                                            }
                                                            r35 = state
                                                            state = upvalueValues[r1]
                                                            state = state and (11) or (12)
                                                        end
                                                    else
                                                        if state == 10 then
                                                            r13 = upvalueValues[r39]
                                                            state = r13 and (13) or (14)
                                                            r27 = r13
                                                        end
                                                    end
                                                else
                                                    if state <= 11 then
                                                        if state == 11 then
                                                            r42 = upvalueValues[r39]
                                                            state = r42 and (15) or (16)
                                                            ReturnVal = r42
                                                        end
                                                    else
                                                        if state == 12 then
                                                            r16 = upvalueValues[r39]
                                                            state = r16 and (17) or (18)
                                                            r42 = r16
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 14 then
                                                    if state <= 13 then
                                                        if state == 13 then
                                                            r13 = r10 == r33
                                                            r27 = r13
                                                            state = 14
                                                        end
                                                    else
                                                        if state == 14 then
                                                            upvalueValues[r39] = r27
                                                            state = upvalueValues[r39]
                                                            state = state and (19) or (20)
                                                        end
                                                    end
                                                else
                                                    if state == 15 then
                                                        r16 = state
                                                        r19 = 1
                                                        r32 = r35[r19]
                                                        r19 = false
                                                        r30 = r32 == r19
                                                        state = r30 and (21) or (22)
                                                        r42 = r30
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 22 then
                                            if state <= 19 then
                                                if state <= 17 then
                                                    if state <= 16 then
                                                        if state == 16 then
                                                            upvalueValues[r39] = ReturnVal
                                                            state = 23
                                                        end
                                                    else
                                                        if state == 17 then
                                                            r30 = 1
                                                            r16 = r35[r30]
                                                            r42 = r16
                                                            state = 18
                                                        end
                                                    end
                                                else
                                                    if state <= 18 then
                                                        if state == 18 then
                                                            upvalueValues[r39] = r42
                                                            r19 = upvalueValues[r7]
                                                            r11 = 1
                                                            r32 = r19 + r11
                                                            r30 = r35[r32]
                                                            r16 = r10 + r30
                                                            r30 = 256
                                                            state = r16 % r30
                                                            r10 = state
                                                            r32 = upvalueValues[r12]
                                                            r30 = r33 + r32
                                                            r32 = 256
                                                            r16 = r30 % r32
                                                            r33 = r16
                                                            state = 23
                                                        end
                                                    else
                                                        if state == 19 then
                                                            state = 24
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 21 then
                                                    if state <= 20 then
                                                        if state == 20 then
                                                            state = true
                                                            state = 25
                                                        end
                                                    else
                                                        if state == 21 then
                                                            r19 = 2
                                                            r32 = r35[r19]
                                                            r19 = upvalueValues[r4]
                                                            r30 = r32 == r19
                                                            r42 = r30
                                                            state = 22
                                                        end
                                                    end
                                                else
                                                    if state == 22 then
                                                        state = r16
                                                        ReturnVal = r42
                                                        state = 16
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 26 then
                                                if state <= 24 then
                                                    if state <= 23 then
                                                        if state == 23 then
                                                            r37 = releaseUpvalue(r37)
                                                            r1 = releaseUpvalue(r1)
                                                            r12 = releaseUpvalue(r12)
                                                            r35 = nil
                                                            r7 = releaseUpvalue(r7)
                                                            r18 = releaseUpvalue(r18)
                                                            r4 = releaseUpvalue(r4)
                                                            state = 8
                                                        end
                                                    else
                                                        if state == 24 then
                                                            r41 = releaseUpvalue(r41)
                                                            r21 = releaseUpvalue(r21)
                                                            r9 = releaseUpvalue(r9)
                                                            r40 = releaseUpvalue(r40)
                                                            r8 = releaseUpvalue(r8)
                                                            r36 = releaseUpvalue(r36)
                                                            r31 = nil
                                                            r31 = {}
                                                            r17 = releaseUpvalue(r17)
                                                            r39 = releaseUpvalue(r39)
                                                            r8 = allocUpvalue()
                                                            r39 = nil
                                                            upvalueValues[r8] = r39
                                                            r39 = allocUpvalue()
                                                            r36 = nil
                                                            upvalueValues[r39] = r36
                                                            r14 = nil
                                                            r14 = "math"
                                                            r40 = _env[r14]
                                                            r14 = "floor"
                                                            r36 = r40[r14]
                                                            r40 = allocUpvalue()
                                                            r10 = nil
                                                            r10 = {}
                                                            r17 = 256
                                                            upvalueValues[r40] = r36
                                                            r41 = "math"
                                                            r14 = _env[r41]
                                                            r41 = "random"
                                                            r36 = r14[r41]
                                                            r23 = nil
                                                            r23 = "table"
                                                            r41 = _env[r23]
                                                            r33 = nil
                                                            r33 = allocUpvalue()
                                                            r23 = "remove"
                                                            r14 = r41[r23]
                                                            r21 = "string"
                                                            r23 = _env[r21]
                                                            r9 = allocUpvalue()
                                                            r21 = "char"
                                                            r41 = r23[r21]
                                                            r21 = allocUpvalue()
                                                            r23 = 0
                                                            upvalueValues[r21] = r23
                                                            r23 = 2
                                                            upvalueValues[r9] = r23
                                                            r23 = {}
                                                            upvalueValues[r33] = r10
                                                            r24 = r17
                                                            r17 = 1
                                                            r18 = r17
                                                            r17 = 0
                                                            r37 = r18 < r17
                                                            r26 = nil
                                                            r26 = 1
                                                            r17 = r26 - r18
                                                            r10 = 0
                                                            state = 26
                                                        end
                                                    end
                                                else
                                                    if state <= 25 then
                                                        if state == 25 then
                                                            state = createClosure0(74, {
                                                                r8
                                                            })
                                                            r13 = {
                                                                state()
                                                            }
                                                            ReturnVal = {
                                                                unpack(r13)
                                                            }
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 26 then
                                                            r17 = r17 + r18
                                                            r12 = not r37
                                                            r26 = r17 <= r24
                                                            r26 = r12 and r26
                                                            r12 = r17 >= r24
                                                            r12 = r37 and r12
                                                            r26 = r12 or r26
                                                            r12 = (27)
                                                            state = r26 and r12
                                                            r26 = (28)
                                                            state = state or r26
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 28 then
                                                    if state <= 27 then
                                                        if state == 27 then
                                                            r26 = r17
                                                            r12 = r26
                                                            r31[r26] = r12
                                                            r26 = nil
                                                            state = 26
                                                        end
                                                    else
                                                        if state == 28 then
                                                            r17 = #r31
                                                            r24 = 0
                                                            r26 = r17 == r24
                                                            state = 29
                                                        end
                                                    end
                                                else
                                                    if state == 29 then
                                                        r17 = 1
                                                        r24 = #r31
                                                        r26 = r36(r17, r24)
                                                        r17 = r14(r31, r26)
                                                        r24 = upvalueValues[r33]
                                                        r12 = 1
                                                        r37 = r17 - r12
                                                        r18 = r41(r37)
                                                        r26 = nil
                                                        r24[r17] = r18
                                                        r17 = nil
                                                        state = 30
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    if state <= 44 then
                                        if state <= 37 then
                                            if state <= 33 then
                                                if state <= 31 then
                                                    if state <= 30 then
                                                        if state == 30 then
                                                            r17 = #r31
                                                            r24 = 0
                                                            r26 = r17 == r24
                                                            state = r26 and (31) or (29)
                                                        end
                                                    else
                                                        if state == 31 then
                                                            r17 = allocUpvalue()
                                                            r26 = {}
                                                            upvalueValues[r17] = r26
                                                            r18 = allocUpvalue()
                                                            r26 = allocUpvalue()
                                                            r24 = createClosure0(78, {
                                                                r17,
                                                                r21,
                                                                r9,
                                                                r40
                                                            })
                                                            upvalueValues[r26] = r24
                                                            r24 = {}
                                                            upvalueValues[r18] = r24
                                                            r12 = {}
                                                            r40 = releaseUpvalue(r40)
                                                            r37 = "setmetatable"
                                                            r24 = _env[r37]
                                                            r4 = upvalueValues[r18]
                                                            r35 = "__metatable"
                                                            r1 = "__index"
                                                            r30 = nil
                                                            r7 = {
                                                                [r1] = r4,
                                                                [r35] = r30
                                                            }
                                                            r37 = r24(r12, r7)
                                                            upvalueValues[r39] = r37
                                                            r24 = createClosure5(84, {
                                                                r18,
                                                                r17,
                                                                r33,
                                                                r21,
                                                                r9,
                                                                r26
                                                            })
                                                            r26 = releaseUpvalue(r26)
                                                            r9 = releaseUpvalue(r9)
                                                            r33 = releaseUpvalue(r33)
                                                            r18 = releaseUpvalue(r18)
                                                            r21 = releaseUpvalue(r21)
                                                            upvalueValues[r8] = r24
                                                            r40 = "game"
                                                            r36 = nil
                                                            r36 = _env[r40]
                                                            r41 = nil
                                                            r41 = upvalueValues[r39]
                                                            r23 = nil
                                                            r23 = upvalueValues[r8]
                                                            r17 = releaseUpvalue(r17)
                                                            r9 = "f\150Q\219\246V%"
                                                            r10 = nil
                                                            r10 = 20239991579856
                                                            r21 = r23(r9, r10)
                                                            r40 = "GetService"
                                                            r40 = r36[r40]
                                                            r14 = nil
                                                            r14 = r41[r21]
                                                            r40 = r40(r36, r14)
                                                            r14 = "game"
                                                            r36 = _env[r14]
                                                            r23 = upvalueValues[r39]
                                                            r21 = upvalueValues[r8]
                                                            r33 = 13039104202679
                                                            r10 = "\217s>\1619\229e\131G<"
                                                            r9 = r21(r10, r33)
                                                            r41 = r23[r9]
                                                            r14 = "GetService"
                                                            r14 = r36[r14]
                                                            r14 = r14(r36, r41)
                                                            r41 = "game"
                                                            r36 = _env[r41]
                                                            r21 = upvalueValues[r39]
                                                            r9 = upvalueValues[r8]
                                                            r33 = "\183\0271b\173\202){d\2099G\219&)\024"
                                                            r31 = nil
                                                            r31 = 14046836054413
                                                            r10 = r9(r33, r31)
                                                            r23 = r21[r10]
                                                            r41 = "GetService"
                                                            r41 = r36[r41]
                                                            r41 = r41(r36, r23)
                                                            r36 = allocUpvalue()
                                                            upvalueValues[r36] = r41
                                                            r33 = "GetChildren"
                                                            r33 = r40[r33]
                                                            r23 = "pairs"
                                                            r41 = _env[r23]
                                                            r10 = {
                                                                r33(r40)
                                                            }
                                                            r33 = {
                                                                r41(unpack(r10))
                                                            }
                                                            r21 = r33[2]
                                                            r23 = r33[1]
                                                            r9 = r33[3]
                                                            state = 32
                                                        end
                                                    end
                                                else
                                                    if state <= 32 then
                                                        if state == 32 then
                                                            r9, r10 = r23(r21, r9)
                                                            state = r9 and (33) or (34)
                                                        end
                                                    else
                                                        if state == 33 then
                                                            r18 = upvalueValues[r39]
                                                            r12 = upvalueValues[r8]
                                                            r4 = 27111404974416
                                                            r1 = "bM\188\146_Wg\001\\Y"
                                                            r7 = r12(r1, r4)
                                                            r17 = "IsA"
                                                            r17 = r10[r17]
                                                            r24 = r18[r7]
                                                            r17 = r17(r10, r24)
                                                            r26 = not r17
                                                            r31 = state
                                                            state = r26 and (35) or (36)
                                                            r41 = r9
                                                            r33 = r26
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 35 then
                                                    if state <= 34 then
                                                        if state == 34 then
                                                            r21 = upvalueValues[r39]
                                                            r9 = upvalueValues[r8]
                                                            r41 = "SetCore"
                                                            r41 = r14[r41]
                                                            r31 = 21784690993056
                                                            r33 = "\157\185r\004\161\138\223b]f"
                                                            r10 = r9(r33, r31)
                                                            r23 = r21[r10]
                                                            r21 = false
                                                            r41 = r41(r14, r23, r21)
                                                            r21 = upvalueValues[r39]
                                                            r9 = upvalueValues[r8]
                                                            r31 = 26536257531972
                                                            r33 = "g\162\213\021\233S\202\019gM\213\017\214"
                                                            r10 = r9(r33, r31)
                                                            r23 = r21[r10]
                                                            r41 = "SetCore"
                                                            r41 = r14[r41]
                                                            r21 = false
                                                            r41 = r41(r14, r23, r21)
                                                            r23 = upvalueValues[r36]
                                                            r9 = upvalueValues[r39]
                                                            r10 = upvalueValues[r8]
                                                            r26 = 18977440047749
                                                            r31 = "\232\173\133\017\134\130\153\134\1992"
                                                            r33 = r10(r31, r26)
                                                            r21 = r9[r33]
                                                            r41 = r23[r21]
                                                            r21 = createClosure5(91, {
                                                                r39,
                                                                r8,
                                                                r36
                                                            })
                                                            r23 = "Connect"
                                                            r23 = r41[r23]
                                                            r23 = r23(r41, r21)
                                                            r23 = state
                                                            r9 = "jumpscare_jeffwuz_loaded"
                                                            r21 = _env[r9]
                                                            state = r21 and (37) or (38)
                                                            r41 = r21
                                                        end
                                                    else
                                                        if state == 35 then
                                                            r18 = upvalueValues[r39]
                                                            r12 = upvalueValues[r8]
                                                            r4 = 20319109686517
                                                            r1 = "\127\249\247\156D\252\253\157\025\198"
                                                            r7 = r12(r1, r4)
                                                            r24 = r18[r7]
                                                            r17 = "IsA"
                                                            r17 = r10[r17]
                                                            r17 = r17(r10, r24)
                                                            r26 = not r17
                                                            r33 = r26
                                                            state = 36
                                                        end
                                                    end
                                                else
                                                    if state <= 36 then
                                                        if state == 36 then
                                                            state = r31
                                                            state = r33 and (39) or (40)
                                                        end
                                                    else
                                                        if state == 37 then
                                                            r31 = "_G"
                                                            r33 = _env[r31]
                                                            r26 = upvalueValues[r39]
                                                            r17 = upvalueValues[r8]
                                                            r12 = 6826967174251
                                                            r18 = "\250\227\194\137D#\247\2336U\027UY\008\188>\147\239`"
                                                            r24 = r17(r18, r12)
                                                            r31 = r26[r24]
                                                            r10 = r33[r31]
                                                            r9 = not r10
                                                            r10 = true
                                                            r21 = r9 == r10
                                                            r41 = r21
                                                            state = 38
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 41 then
                                                if state <= 39 then
                                                    if state <= 38 then
                                                        if state == 38 then
                                                            state = r23
                                                            state = r41 and (41) or (42)
                                                        end
                                                    else
                                                        if state == 39 then
                                                            r33 = "Destroy"
                                                            r33 = r10[r33]
                                                            r33 = r33(r10)
                                                            state = 40
                                                        end
                                                    end
                                                else
                                                    if state <= 40 then
                                                        if state == 40 then
                                                            r41 = nil
                                                            r10 = nil
                                                            state = 32
                                                        end
                                                    else
                                                        if state == 41 then
                                                            ReturnVal = {}
                                                            r23 = "warn"
                                                            r41 = _env[r23]
                                                            r9 = upvalueValues[r39]
                                                            r10 = upvalueValues[r8]
                                                            r31 = "\"\137b\211-\236\166R8\189K1\134~\134"
                                                            r26 = 19708146623449
                                                            r33 = r10(r31, r26)
                                                            r21 = r9[r33]
                                                            r23 = r41(r21)
                                                            state = nil
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 43 then
                                                    if state <= 42 then
                                                        if state == 42 then
                                                            r21 = createClosure3(100, {
                                                                r39,
                                                                r8
                                                            })
                                                            r23 = "pcall"
                                                            r41 = _env[r23]
                                                            r23 = r41(r21)
                                                            r23 = "getgenv"
                                                            r41 = _env[r23]
                                                            r23 = r41()
                                                            r21 = upvalueValues[r39]
                                                            r9 = upvalueValues[r8]
                                                            r33 = "O~\"\018\220."
                                                            r31 = 29817341490748
                                                            r10 = r9(r33, r31)
                                                            r41 = r21[r10]
                                                            r21 = true
                                                            r23[r41] = r21
                                                            r23 = upvalueValues[r39]
                                                            r21 = upvalueValues[r8]
                                                            r10 = "\229\2066|C;\029\011M\220\246\180F\163\1618&\154\238\026\220j2\145\150\212VXi%\143+\206m\2079V\174Wb^\178w\237\016\218\019\181\190\250\213\194R\213\142#;Z$\143\020r\183\183\203\031\196\030\157(\015\228\000er\012\210=PZ\"?\160\234\163\025(\186m*1\129\209%UF\029\243\016\244,\017\204]\n\214\231#\236\185a;\157{\158\028Z\186\143\140\213"
                                                            r33 = 29297191073098
                                                            r9 = r21(r10, r33)
                                                            r41 = r23[r9]
                                                            r23 = allocUpvalue()
                                                            upvalueValues[r23] = r41
                                                            r9 = "getcustomasset"
                                                            r21 = _env[r9]
                                                            r41 = not r21
                                                            state = r41 and (43) or (44)
                                                        end
                                                    else
                                                        if state == 43 then
                                                            r21 = "game"
                                                            r41 = _env[r21]
                                                            r21 = "Shutdown"
                                                            r21 = r41[r21]
                                                            r21 = r21(r41)
                                                            state = 44
                                                        end
                                                    end
                                                else
                                                    if state == 44 then
                                                        r9 = "game"
                                                        r21 = _env[r9]
                                                        r33 = upvalueValues[r39]
                                                        r9 = "GetService"
                                                        r9 = r21[r9]
                                                        r31 = upvalueValues[r8]
                                                        r17 = "~_d\"\225\206u"
                                                        r24 = 22306769299603
                                                        r26 = r31(r17, r24)
                                                        r10 = r33[r26]
                                                        r9 = r9(r21, r10)
                                                        r10 = upvalueValues[r39]
                                                        r33 = upvalueValues[r8]
                                                        r26 = "!\149W\023\006\1281RLS\128"
                                                        r17 = 25085234752929
                                                        r31 = r33(r26, r17)
                                                        r21 = r10[r31]
                                                        r41 = r9[r21]
                                                        r21 = allocUpvalue()
                                                        upvalueValues[r21] = r41
                                                        r9 = "game"
                                                        r41 = _env[r9]
                                                        r33 = upvalueValues[r39]
                                                        r31 = upvalueValues[r8]
                                                        r17 = "\198\012\031*\133O\233\250\027+`"
                                                        r24 = 6764292213837
                                                        r26 = r31(r17, r24)
                                                        r9 = "GetService"
                                                        r9 = r41[r9]
                                                        r10 = r33[r26]
                                                        r9 = r9(r41, r10)
                                                        r41 = allocUpvalue()
                                                        upvalueValues[r41] = r9
                                                        r33 = "Instance"
                                                        r10 = _env[r33]
                                                        r31 = upvalueValues[r39]
                                                        r26 = upvalueValues[r8]
                                                        r18 = 32031077628483
                                                        r24 = "N~\223"
                                                        r17 = r26(r24, r18)
                                                        r33 = r31[r17]
                                                        r9 = r10[r33]
                                                        r31 = upvalueValues[r39]
                                                        r26 = upvalueValues[r8]
                                                        r24 = "d\190\142z\2059'\232\226"
                                                        r18 = 22779882760559
                                                        r17 = r26(r24, r18)
                                                        r33 = r31[r17]
                                                        r10 = r9(r33)
                                                        r31 = "Instance"
                                                        r33 = _env[r31]
                                                        r26 = upvalueValues[r39]
                                                        r17 = upvalueValues[r8]
                                                        r12 = 27004283793694
                                                        r18 = "\220\255\139"
                                                        r24 = r17(r18, r12)
                                                        r31 = r26[r24]
                                                        r9 = r33[r31]
                                                        r26 = upvalueValues[r39]
                                                        r17 = upvalueValues[r8]
                                                        r12 = 9885809725947
                                                        r18 = "Ed;\19985\193\028\214z"
                                                        r24 = r17(r18, r12)
                                                        r31 = r26[r24]
                                                        r33 = r9(r31)
                                                        r31 = upvalueValues[r39]
                                                        r26 = upvalueValues[r8]
                                                        r18 = 1642346709756
                                                        r24 = "\213T\017\133\159\011"
                                                        r17 = r26(r24, r18)
                                                        r9 = r31[r17]
                                                        r26 = "game"
                                                        r31 = _env[r26]
                                                        r24 = upvalueValues[r39]
                                                        r18 = upvalueValues[r8]
                                                        r1 = 18931316679279
                                                        r7 = "\222\196\002s\002\242\181"
                                                        r12 = r18(r7, r1)
                                                        r26 = "GetService"
                                                        r26 = r31[r26]
                                                        r17 = r24[r12]
                                                        r26 = r26(r31, r17)
                                                        r10[r9] = r26
                                                        r31 = upvalueValues[r39]
                                                        r26 = upvalueValues[r8]
                                                        r24 = "\224#\008I\248u\194\217\140\1975>\231\186"
                                                        r18 = 30204919412465
                                                        r17 = r26(r24, r18)
                                                        r9 = r31[r17]
                                                        r31 = true
                                                        r10[r9] = r31
                                                        r31 = upvalueValues[r39]
                                                        r26 = upvalueValues[r8]
                                                        r24 = "\130\246\017\002"
                                                        r18 = 23427037702813
                                                        r17 = r26(r24, r18)
                                                        r9 = r31[r17]
                                                        r26 = upvalueValues[r39]
                                                        r17 = upvalueValues[r8]
                                                        r18 = "\008hC\255\008\227K\253\129\148\n\146\189n/\137\137 \247\184"
                                                        r12 = 10283202106036
                                                        r24 = r17(r18, r12)
                                                        r31 = r26[r24]
                                                        r10[r9] = r31
                                                        r31 = upvalueValues[r39]
                                                        r26 = upvalueValues[r8]
                                                        r18 = 13997987354998
                                                        r24 = "\252\189\137}-\243"
                                                        r17 = r26(r24, r18)
                                                        r9 = r31[r17]
                                                        r31 = r10
                                                        r33[r9] = r31
                                                        r31 = upvalueValues[r39]
                                                        r26 = upvalueValues[r8]
                                                        r24 = "\195d7b"
                                                        r18 = 7223289941283
                                                        r17 = r26(r24, r18)
                                                        r9 = r31[r17]
                                                        r17 = "UDim2"
                                                        r26 = _env[r17]
                                                        r24 = upvalueValues[r39]
                                                        r18 = upvalueValues[r8]
                                                        r7 = "\171\137\168"
                                                        r1 = 17940773085346
                                                        r12 = r18(r7, r1)
                                                        r17 = r24[r12]
                                                        r31 = r26[r17]
                                                        r18 = 1
                                                        r24 = 0
                                                        r12 = 0
                                                        r17 = 1
                                                        r26 = r31(r17, r24, r18, r12)
                                                        r33[r9] = r26
                                                        r31 = "writefile"
                                                        r9 = _env[r31]
                                                        r17 = upvalueValues[r39]
                                                        r24 = upvalueValues[r8]
                                                        r7 = 2286546764840
                                                        r12 = "\027<\158\211\213\250\129"
                                                        r18 = r24(r12, r7)
                                                        r26 = r17[r18]
                                                        r24 = "game"
                                                        r17 = _env[r24]
                                                        r12 = upvalueValues[r39]
                                                        r7 = upvalueValues[r8]
                                                        r4 = "\190\153~D\139,\154\178,x\202+\023n\183\134\186\154\228\186\211\192\002\192\179T\228<?\014\216\217P\t\004v\219\145c9\230\188\162\189\155Y\219R+\023\252\012\217\000A!\244\188\208\000\159\144m\173j>w\144\002\158\174Ms\204\181o\145T\191@FAQ\235\004Q\232"
                                                        r35 = 17930055065757
                                                        r1 = r7(r4, r35)
                                                        r18 = r12[r1]
                                                        r12 = "HttpGet"
                                                        r12 = r17[r12]
                                                        r24 = {
                                                            r12(r17, r18)
                                                        }
                                                        r31 = r9(r26, unpack(r24))
                                                        r31 = upvalueValues[r39]
                                                        r26 = upvalueValues[r8]
                                                        r18 = 28465694700487
                                                        r24 = "\185\137{hU"
                                                        r17 = r26(r24, r18)
                                                        r9 = r31[r17]
                                                        r26 = "getcustomasset"
                                                        r31 = _env[r26]
                                                        r24 = upvalueValues[r39]
                                                        r18 = upvalueValues[r8]
                                                        r7 = "\221\127\029\017U\025t"
                                                        r1 = 18214147236129
                                                        r12 = r18(r7, r1)
                                                        r17 = r24[r12]
                                                        r26 = r31(r17)
                                                        r33[r9] = r26
                                                        r31 = upvalueValues[r39]
                                                        r26 = upvalueValues[r8]
                                                        r24 = "\244\000\191\211\1679"
                                                        r18 = 10806926906280
                                                        r17 = r26(r24, r18)
                                                        r9 = r31[r17]
                                                        r31 = true
                                                        r33[r9] = r31
                                                        r31 = upvalueValues[r39]
                                                        r26 = upvalueValues[r8]
                                                        r18 = 8351402610480
                                                        r24 = "\148V+\241\159\199\217"
                                                        r17 = r26(r24, r18)
                                                        r9 = r31[r17]
                                                        r31 = true
                                                        r33[r9] = r31
                                                        r31 = upvalueValues[r39]
                                                        r26 = upvalueValues[r8]
                                                        r18 = 29568398308808
                                                        r24 = "\230\186\224:\187\161"
                                                        r17 = r26(r24, r18)
                                                        r9 = r31[r17]
                                                        r31 = 10
                                                        r33[r9] = r31
                                                        r9 = createClosure4(101, {
                                                            r39,
                                                            r8,
                                                            r21,
                                                            r41,
                                                            r23
                                                        })
                                                        r31 = "notify_hook"
                                                        _env[r31] = r9
                                                        r17 = "getgenv"
                                                        r26 = _env[r17]
                                                        r17 = r26()
                                                        r24 = upvalueValues[r39]
                                                        r18 = upvalueValues[r8]
                                                        r7 = "\028\134z#c\131"
                                                        r1 = 1822145233744
                                                        r12 = r18(r7, r1)
                                                        r26 = r24[r12]
                                                        r31 = r17[r26]
                                                        r26 = true
                                                        r9 = r31 == r26
                                                        state = r9 and (45) or (46)
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 51 then
                                            if state <= 48 then
                                                if state <= 46 then
                                                    if state <= 45 then
                                                        if state == 45 then
                                                            r31 = upvalueValues[r23]
                                                            r17 = upvalueValues[r39]
                                                            r24 = upvalueValues[r8]
                                                            r12 = ""
                                                            r7 = 22427584309451
                                                            r18 = r24(r12, r7)
                                                            r26 = r17[r18]
                                                            r9 = r31 == r26
                                                            state = r9 and (47) or (48)
                                                        end
                                                    else
                                                        if state == 46 then
                                                            r17 = "getgenv"
                                                            r26 = _env[r17]
                                                            r17 = r26()
                                                            r24 = upvalueValues[r39]
                                                            r18 = upvalueValues[r8]
                                                            r7 = "\006\223[A\001\028"
                                                            r1 = 2242304099348
                                                            r12 = r18(r7, r1)
                                                            r26 = r24[r12]
                                                            r31 = r17[r26]
                                                            r26 = false
                                                            r9 = r31 == r26
                                                            state = r9 and (49) or (50)
                                                        end
                                                    end
                                                else
                                                    if state <= 47 then
                                                        if state == 47 then
                                                            ReturnVal = {}
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 48 then
                                                            r31 = "notify_hook"
                                                            r9 = _env[r31]
                                                            r31 = r9()
                                                            state = 51
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 50 then
                                                    if state <= 49 then
                                                        if state == 49 then
                                                            ReturnVal = {}
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 50 then
                                                            r31 = "warn"
                                                            r9 = _env[r31]
                                                            r17 = upvalueValues[r39]
                                                            r24 = upvalueValues[r8]
                                                            r12 = "W\229Y\224i\192\017\199v'\219G\204"
                                                            r7 = 14205149731286
                                                            r18 = r24(r12, r7)
                                                            r26 = r17[r18]
                                                            r31 = r9(r26)
                                                            state = 52
                                                        end
                                                    end
                                                else
                                                    if state == 51 then
                                                        state = 52
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 55 then
                                                if state <= 53 then
                                                    if state <= 52 then
                                                        if state == 52 then
                                                            state = 53
                                                        end
                                                    else
                                                        if state == 53 then
                                                            r9 = true
                                                            state = r9 and (54) or (55)
                                                        end
                                                    end
                                                else
                                                    if state <= 54 then
                                                        if state == 54 then
                                                            r31 = "print"
                                                            r9 = _env[r31]
                                                            r17 = upvalueValues[r39]
                                                            r24 = upvalueValues[r8]
                                                            r12 = "\n\195\199;\253L~\192\029T\029\129?A\0233\143!\226X\023\212:\128\172%|u\130\182M\248"
                                                            r7 = 7885544246871
                                                            r18 = r24(r12, r7)
                                                            r26 = r17[r18]
                                                            r31 = r9(r26)
                                                            r31 = "print"
                                                            r9 = _env[r31]
                                                            r17 = upvalueValues[r39]
                                                            r24 = upvalueValues[r8]
                                                            r12 = "\243\208\240vd2\019\208\217\146\134\138\221\r\0013<\158\212\238<\214\240\249\185\132w\167\217\127\142\014"
                                                            r7 = 30289571755800
                                                            r18 = r24(r12, r7)
                                                            r26 = r17[r18]
                                                            r31 = r9(r26)
                                                            r31 = "print"
                                                            r9 = _env[r31]
                                                            r17 = upvalueValues[r39]
                                                            r24 = upvalueValues[r8]
                                                            r7 = 2373434410065
                                                            r12 = "\155\236b\128\154\023\251\229^\244\152\172\"\011\143\167\145\146J\201\185\209$\216\021C\2157\248f\141\157"
                                                            r18 = r24(r12, r7)
                                                            r26 = r17[r18]
                                                            r31 = r9(r26)
                                                            r31 = "game"
                                                            r9 = _env[r31]
                                                            r17 = upvalueValues[r39]
                                                            r24 = upvalueValues[r8]
                                                            r12 = "\025\235\186\163\tI/%\227T"
                                                            r7 = 6545872325608
                                                            r18 = r24(r12, r7)
                                                            r26 = r17[r18]
                                                            r31 = "GetService"
                                                            r31 = r9[r31]
                                                            r31 = r31(r9, r26)
                                                            r17 = upvalueValues[r39]
                                                            r24 = upvalueValues[r8]
                                                            r12 = "w8\196\001J\207:\128\169\191\001\015\187\183b\171\002"
                                                            r7 = 16789251333770
                                                            r18 = r24(r12, r7)
                                                            r26 = r17[r18]
                                                            r9 = "SetCore"
                                                            r9 = r31[r9]
                                                            r17 = true
                                                            r9 = r9(r31, r26, r17)
                                                            r31 = "wait"
                                                            r9 = _env[r31]
                                                            r26 = 0.01
                                                            r31 = r9(r26)
                                                            r31 = "game"
                                                            r9 = _env[r31]
                                                            r17 = upvalueValues[r39]
                                                            r24 = upvalueValues[r8]
                                                            r12 = "\165HrXy\176JH\145;"
                                                            r7 = 9862773985776
                                                            r18 = r24(r12, r7)
                                                            r26 = r17[r18]
                                                            r31 = "GetService"
                                                            r31 = r9[r31]
                                                            r31 = r31(r9, r26)
                                                            r17 = upvalueValues[r39]
                                                            r24 = upvalueValues[r8]
                                                            r7 = 12792594749253
                                                            r12 = "\133]E\215\002\166\027\210\029\203\236\144f\161\211\253,"
                                                            r18 = r24(r12, r7)
                                                            r26 = r17[r18]
                                                            r9 = "SetCore"
                                                            r9 = r31[r9]
                                                            r17 = false
                                                            r9 = r9(r31, r26, r17)
                                                            r31 = "wait"
                                                            r9 = _env[r31]
                                                            r26 = 0.01
                                                            r31 = r9(r26)
                                                            r31 = "print"
                                                            r9 = _env[r31]
                                                            r17 = upvalueValues[r39]
                                                            r24 = upvalueValues[r8]
                                                            r7 = 1801768289095
                                                            r12 = "\132\128J\208\250Fa\163\205\156^W\254\1498\204(\177H\006\235e)\2010\141\\|zJ\178\008"
                                                            r18 = r24(r12, r7)
                                                            r26 = r17[r18]
                                                            r31 = r9(r26)
                                                            r31 = "wait"
                                                            r9 = _env[r31]
                                                            r26 = 0.01
                                                            r31 = r9(r26)
                                                            state = 53
                                                        end
                                                    else
                                                        if state == 55 then
                                                            state = 56
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 57 then
                                                    if state <= 56 then
                                                        if state == 56 then
                                                            r9 = true
                                                            state = r9 and (57) or (58)
                                                        end
                                                    else
                                                        if state == 57 then
                                                            r31 = "game"
                                                            r9 = _env[r31]
                                                            r17 = upvalueValues[r39]
                                                            r12 = "\r\211\020\"\008B<_\212\213H:i\163s"
                                                            r24 = upvalueValues[r8]
                                                            r7 = 25508358352486
                                                            r31 = "GetService"
                                                            r18 = r24(r12, r7)
                                                            r26 = r17[r18]
                                                            r7 = 19937951917124
                                                            r12 = "\248\151\253\247\200\022\184\252\214\014\017{"
                                                            r31 = r9[r31]
                                                            r31 = r31(r9, r26)
                                                            r9 = "WaitForChild"
                                                            r17 = upvalueValues[r39]
                                                            r24 = upvalueValues[r8]
                                                            r18 = r24(r12, r7)
                                                            r9 = r31[r9]
                                                            r26 = r17[r18]
                                                            r7 = 11250598728822
                                                            r4 = 5817958730389
                                                            r9 = r9(r31, r26)
                                                            r1 = "\1967\244\187\178\190Ba\214\149\165\021 \183\226"
                                                            r17 = upvalueValues[r39]
                                                            r12 = "wi\224\177\244\244'5\196c"
                                                            r24 = upvalueValues[r8]
                                                            r18 = r24(r12, r7)
                                                            r31 = "WaitForChild"
                                                            r12 = 9787972489677
                                                            r31 = r9[r31]
                                                            r26 = r17[r18]
                                                            r18 = "\153\136\194\171R\150"
                                                            r31 = r31(r9, r26)
                                                            r26 = upvalueValues[r39]
                                                            r17 = upvalueValues[r8]
                                                            r24 = r17(r18, r12)
                                                            r9 = r26[r24]
                                                            r24 = 0.01
                                                            r17 = "wait"
                                                            r26 = "SendAsync"
                                                            r26 = r31[r26]
                                                            r26 = r26(r31, r9)
                                                            r26 = _env[r17]
                                                            r30 = 14708133272257
                                                            r17 = r26(r24)
                                                            r17 = "game"
                                                            r26 = _env[r17]
                                                            r18 = upvalueValues[r39]
                                                            r12 = upvalueValues[r8]
                                                            r7 = r12(r1, r4)
                                                            r4 = 34963969687449
                                                            r17 = "GetService"
                                                            r24 = r18[r7]
                                                            r17 = r26[r17]
                                                            r17 = r17(r26, r24)
                                                            r18 = upvalueValues[r39]
                                                            r26 = "WaitForChild"
                                                            r1 = "xB\002\151\142\230\197\r\206\029ha"
                                                            r35 = "\210N\022*\190\137NO\152{\215\252\209SV"
                                                            r12 = upvalueValues[r8]
                                                            r7 = r12(r1, r4)
                                                            r24 = r18[r7]
                                                            r26 = r17[r26]
                                                            r26 = r26(r17, r24)
                                                            r18 = upvalueValues[r39]
                                                            r4 = 23365487061632
                                                            r17 = "WaitForChild"
                                                            r17 = r26[r17]
                                                            r1 = "r/\244\160|X\205F\017\212"
                                                            r12 = upvalueValues[r8]
                                                            r7 = r12(r1, r4)
                                                            r24 = r18[r7]
                                                            r17 = r17(r26, r24)
                                                            r25 = 12855629158242
                                                            r2 = "\251\144x>\246\t\011ep\149\140w\174\027\217"
                                                            r3 = 3571232147070
                                                            r1 = 12750193284913
                                                            r24 = upvalueValues[r39]
                                                            r31 = nil
                                                            r18 = upvalueValues[r8]
                                                            r7 = "\142\218(\207\022T\183\005"
                                                            r12 = r18(r7, r1)
                                                            r26 = r24[r12]
                                                            r18 = "wait"
                                                            r12 = 0.01
                                                            r24 = "SendAsync"
                                                            r24 = r17[r24]
                                                            r24 = r24(r17, r26)
                                                            r24 = _env[r18]
                                                            r18 = r24(r12)
                                                            r18 = "game"
                                                            r24 = _env[r18]
                                                            r7 = upvalueValues[r39]
                                                            r1 = upvalueValues[r8]
                                                            r4 = r1(r35, r30)
                                                            r35 = "\18887\132|X\028Y@\022\166i"
                                                            r18 = "GetService"
                                                            r12 = r7[r4]
                                                            r30 = 11252519081079
                                                            r17 = nil
                                                            r18 = r24[r18]
                                                            r18 = r18(r24, r12)
                                                            r24 = "WaitForChild"
                                                            r24 = r18[r24]
                                                            r7 = upvalueValues[r39]
                                                            r1 = upvalueValues[r8]
                                                            r4 = r1(r35, r30)
                                                            r12 = r7[r4]
                                                            r30 = 19447781696352
                                                            r24 = r24(r18, r12)
                                                            r7 = upvalueValues[r39]
                                                            r35 = "\250^\159\172\209r;\196\162\205"
                                                            r1 = upvalueValues[r8]
                                                            r4 = r1(r35, r30)
                                                            r35 = 29833535518276
                                                            r18 = "WaitForChild"
                                                            r12 = r7[r4]
                                                            r18 = r24[r18]
                                                            r18 = r18(r24, r12)
                                                            r4 = "e\022iRZ"
                                                            r12 = upvalueValues[r39]
                                                            r7 = upvalueValues[r8]
                                                            r1 = r7(r4, r35)
                                                            r24 = r12[r1]
                                                            r12 = "SendAsync"
                                                            r7 = "wait"
                                                            r1 = 0.01
                                                            r12 = r18[r12]
                                                            r12 = r12(r18, r24)
                                                            r12 = _env[r7]
                                                            r11 = "\022?\201\175\190>aM\183\127\212\174\195\238w"
                                                            r19 = 11609312564510
                                                            r32 = "b}\175=-l`\022\217\168\000\\\199\019\158"
                                                            r24 = nil
                                                            r7 = r12(r1)
                                                            r7 = "game"
                                                            r12 = _env[r7]
                                                            r4 = upvalueValues[r39]
                                                            r35 = upvalueValues[r8]
                                                            r7 = "GetService"
                                                            r26 = nil
                                                            r30 = r35(r32, r19)
                                                            r7 = r12[r7]
                                                            r1 = r4[r30]
                                                            r7 = r7(r12, r1)
                                                            r4 = upvalueValues[r39]
                                                            r12 = "WaitForChild"
                                                            r35 = upvalueValues[r8]
                                                            r32 = "j%\228\157L\141meGSs\167"
                                                            r19 = 31628133857671
                                                            r30 = r35(r32, r19)
                                                            r1 = r4[r30]
                                                            r12 = r7[r12]
                                                            r12 = r12(r7, r1)
                                                            r7 = "WaitForChild"
                                                            r4 = upvalueValues[r39]
                                                            r35 = upvalueValues[r8]
                                                            r32 = "\149:\218|<\234{\144Nw"
                                                            r19 = 28838943782005
                                                            r30 = r35(r32, r19)
                                                            r1 = r4[r30]
                                                            r7 = r12[r7]
                                                            r7 = r7(r12, r1)
                                                            r30 = "\185\160\132\131n\137\000\012"
                                                            r1 = upvalueValues[r39]
                                                            r4 = upvalueValues[r8]
                                                            r32 = 29054086083801
                                                            r35 = r4(r30, r32)
                                                            r12 = r1[r35]
                                                            r4 = "wait"
                                                            r1 = "SendAsync"
                                                            r35 = 0.01
                                                            r1 = r7[r1]
                                                            r1 = r1(r7, r12)
                                                            r1 = _env[r4]
                                                            r4 = r1(r35)
                                                            r4 = "game"
                                                            r9 = nil
                                                            r1 = _env[r4]
                                                            r30 = upvalueValues[r39]
                                                            r32 = upvalueValues[r8]
                                                            r19 = r32(r11, r3)
                                                            r4 = "GetService"
                                                            r4 = r1[r4]
                                                            r35 = r30[r19]
                                                            r4 = r4(r1, r35)
                                                            r30 = upvalueValues[r39]
                                                            r32 = upvalueValues[r8]
                                                            r1 = "WaitForChild"
                                                            r11 = ")[\016\019\148K\231~\241\232\252\129"
                                                            r3 = 25612416954006
                                                            r19 = r32(r11, r3)
                                                            r3 = 21263351768749
                                                            r18 = nil
                                                            r35 = r30[r19]
                                                            r1 = r4[r1]
                                                            r1 = r1(r4, r35)
                                                            r30 = upvalueValues[r39]
                                                            r32 = upvalueValues[r8]
                                                            r11 = "\249V\183\233\0282\174}\159{"
                                                            r19 = r32(r11, r3)
                                                            r4 = "WaitForChild"
                                                            r35 = r30[r19]
                                                            r4 = r1[r4]
                                                            r11 = 5393377380815
                                                            r12 = nil
                                                            r4 = r4(r1, r35)
                                                            r35 = upvalueValues[r39]
                                                            r30 = upvalueValues[r8]
                                                            r19 = "zYn\152\248\2425\249\195/\242p\017\204\027\202"
                                                            r32 = r30(r19, r11)
                                                            r1 = r35[r32]
                                                            r35 = "SendAsync"
                                                            r35 = r4[r35]
                                                            r30 = "wait"
                                                            r35 = r35(r4, r1)
                                                            r35 = _env[r30]
                                                            r32 = 0.01
                                                            r30 = r35(r32)
                                                            r30 = "game"
                                                            r35 = _env[r30]
                                                            r19 = upvalueValues[r39]
                                                            r11 = upvalueValues[r8]
                                                            r3 = r11(r2, r25)
                                                            r32 = r19[r3]
                                                            r30 = "GetService"
                                                            r30 = r35[r30]
                                                            r30 = r30(r35, r32)
                                                            r19 = upvalueValues[r39]
                                                            r11 = upvalueValues[r8]
                                                            r2 = "\t\2047\237\0053Ff\150P\141\165"
                                                            r25 = 23505655884481
                                                            r3 = r11(r2, r25)
                                                            r32 = r19[r3]
                                                            r35 = "WaitForChild"
                                                            r35 = r30[r35]
                                                            r35 = r35(r30, r32)
                                                            r19 = upvalueValues[r39]
                                                            r11 = upvalueValues[r8]
                                                            r30 = "WaitForChild"
                                                            r2 = "L\155\238\180\187\221\031\2428\007"
                                                            r25 = 19598527128486
                                                            r3 = r11(r2, r25)
                                                            r32 = r19[r3]
                                                            r30 = r35[r30]
                                                            r30 = r30(r35, r32)
                                                            r2 = 20741173405114
                                                            r32 = upvalueValues[r39]
                                                            r19 = upvalueValues[r8]
                                                            r3 = "X\202\218&\176\147-"
                                                            r1 = nil
                                                            r4 = nil
                                                            r11 = r19(r3, r2)
                                                            r35 = r32[r11]
                                                            r32 = "SendAsync"
                                                            r32 = r30[r32]
                                                            r19 = "wait"
                                                            r11 = 0.01
                                                            r7 = nil
                                                            r32 = r32(r30, r35)
                                                            r30 = nil
                                                            r32 = _env[r19]
                                                            r19 = r32(r11)
                                                            r35 = nil
                                                            state = 56
                                                        end
                                                    end
                                                else
                                                    if state == 58 then
                                                        r14 = nil
                                                        r10 = nil
                                                        r33 = nil
                                                        r41 = releaseUpvalue(r41)
                                                        r23 = releaseUpvalue(r23)
                                                        r8 = releaseUpvalue(r8)
                                                        r21 = releaseUpvalue(r21)
                                                        r40 = nil
                                                        r36 = releaseUpvalue(r36)
                                                        r39 = releaseUpvalue(r39)
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure3 entry 2944112 -> 59, states 59-59
                                if state == 59 then -- entry 2944112 -> 59
                                    state = true
                                    upvalueValues[upvalues[1]] = state
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            -- createClosure0 entry 2057551 -> 60, states 60-60
                            if state == 60 then -- entry 2057551 -> 60
                                ReturnVal = "error"
                                state = _env[ReturnVal]
                                r5 = "Tamper Detected!"
                                ReturnVal = state(r5)
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    else
                        if state <= 73 then
                            if state <= 61 then
                                -- createClosure1 entry 880840 -> 61, states 61-61
                                if state == 61 then -- entry 880840 -> 61
                                    r36 = 13235013
                                    r39 = "q5orFKb53vPg"
                                    r5 = r39 ^ r36
                                    ReturnVal = 10477048
                                    state = ReturnVal - r5
                                    r5 = state
                                    ReturnVal = "VFfJEeVsG7OzTo"
                                    state = ReturnVal / r5
                                    ReturnVal = {
                                        state
                                    }
                                    state = nil
                                end
                            else
                                -- createClosure3 entry 8804686 -> 62, states 62-73
                                if state <= 67 then
                                    if state <= 64 then
                                        if state <= 63 then
                                            if state <= 62 then
                                                if state == 62 then -- entry 8804686 -> 62
                                                    r39 = upvalueValues[upvalues[1]]
                                                    r40 = 2
                                                    r8 = 1
                                                    r36 = r39(r8, r40)
                                                    r39 = 1
                                                    r5 = r36 == r39
                                                    state = r5 and (63) or (64)
                                                    ReturnVal = r5
                                                end
                                            else
                                                if state == 63 then
                                                    state = ReturnVal and (65) or (66)
                                                end
                                            end
                                        else
                                            if state == 64 then
                                                r39 = upvalueValues[upvalues[2]]
                                                r36 = upvalueValues[upvalues[3]]
                                                r5 = r39 == r36
                                                ReturnVal = r5
                                                state = 63
                                            end
                                        end
                                    else
                                        if state <= 66 then
                                            if state <= 65 then
                                                if state == 65 then
                                                    ReturnVal = "tonumber"
                                                    state = _env[ReturnVal]
                                                    r21 = createClosure1(102, {})
                                                    r5 = upvalueValues[upvalues[4]]
                                                    r8 = "tostring"
                                                    r36 = _env[r8]
                                                    r23 = "pcall"
                                                    r41 = _env[r23]
                                                    r23 = {
                                                        r41(r21)
                                                    }
                                                    r14 = {
                                                        unpack(r23)
                                                    }
                                                    r41 = 2
                                                    r40 = r14[r41]
                                                    r8 = r36(r40)
                                                    r36 = ":(%d*):"
                                                    r39 = r5(r8, r36)
                                                    r5 = {
                                                        r39()
                                                    }
                                                    ReturnVal = state(unpack(r5))
                                                    r5 = ReturnVal
                                                    r39 = upvalueValues[upvalues[5]]
                                                    state = r39 and (67) or (68)
                                                    ReturnVal = r39
                                                end
                                            else
                                                if state == 66 then
                                                    state = upvalueValues[upvalues[7]]
                                                    state = state and (69) or (70)
                                                end
                                            end
                                        else
                                            if state == 67 then
                                                r36 = upvalueValues[upvalues[6]]
                                                r39 = r36 == r5
                                                ReturnVal = r39
                                                state = 68
                                            end
                                        end
                                    end
                                else
                                    if state <= 70 then
                                        if state <= 69 then
                                            if state <= 68 then
                                                if state == 68 then
                                                    upvalueValues[upvalues[5]] = ReturnVal
                                                    r5 = nil
                                                    state = 66
                                                end
                                            else
                                                if state == 69 then
                                                    r5 = "error"
                                                    state = _env[r5]
                                                    r39 = upvalueValues[upvalues[8]]
                                                    r36 = 0
                                                    r5 = state(r39, r36)
                                                    state = 70
                                                end
                                            end
                                        else
                                            if state == 70 then
                                                state = {}
                                                r5 = state
                                                r36 = upvalueValues[upvalues[9]]
                                                r8 = r36
                                                r36 = 1
                                                r40 = r36
                                                r36 = 0
                                                r14 = r40 < r36
                                                r39 = 1
                                                r36 = r39 - r40
                                                state = 71
                                            end
                                        end
                                    else
                                        if state <= 72 then
                                            if state <= 71 then
                                                if state == 71 then
                                                    r36 = r36 + r40
                                                    r39 = r36 <= r8
                                                    r41 = not r14
                                                    r39 = r41 and r39
                                                    r41 = r36 >= r8
                                                    r41 = r14 and r41
                                                    r39 = r41 or r39
                                                    r41 = (72)
                                                    state = r39 and r41
                                                    r39 = (73)
                                                    state = state or r39
                                                end
                                            else
                                                if state == 72 then
                                                    r39 = r36
                                                    state = upvalueValues[upvalues[1]]
                                                    r21 = 255
                                                    r23 = 0
                                                    r41 = state(r23, r21)
                                                    r5[r39] = r41
                                                    r39 = nil
                                                    state = 71
                                                end
                                            end
                                        else
                                            if state == 73 then
                                                state = upvalueValues[upvalues[10]]
                                                r39 = upvalueValues[upvalues[11]]
                                                r5[state] = r39
                                                state = upvalueValues[upvalues[12]]
                                                r39 = {
                                                    state(r5)
                                                }
                                                ReturnVal = {
                                                    unpack(r39)
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            -- createClosure0 entry 6891156 -> 74, states 74-77
                            if state <= 75 then
                                if state <= 74 then
                                    if state == 74 then -- entry 6891156 -> 74
                                        state = 75
                                    end
                                else
                                    if state == 75 then
                                        state = true
                                        state = state and (76) or (77)
                                    end
                                end
                            else
                                if state <= 76 then
                                    if state == 76 then
                                        ReturnVal = "l2"
                                        state = _env[ReturnVal]
                                        r5 = "l1"
                                        ReturnVal = _env[r5]
                                        r5 = "l1"
                                        _env[r5] = state
                                        r5 = "l2"
                                        _env[r5] = ReturnVal
                                        r5 = upvalueValues[upvalues[1]]
                                        r39 = r5()
                                        state = 75
                                    end
                                else
                                    if state == 77 then
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 99 then
                        if state <= 90 then
                            if state <= 83 then
                                -- createClosure0 entry 15531055 -> 78, states 78-83
                                if state <= 80 then
                                    if state <= 79 then
                                        if state <= 78 then
                                            if state == 78 then -- entry 15531055 -> 78
                                                r5 = upvalueValues[upvalues[1]]
                                                ReturnVal = #r5
                                                r5 = 0
                                                state = ReturnVal == r5
                                                state = state and (79) or (80)
                                            end
                                        else
                                            if state == 79 then
                                                r39 = upvalueValues[upvalues[2]]
                                                r36 = 221
                                                r5 = r39 * r36
                                                r39 = 9724308328879
                                                ReturnVal = r5 + r39
                                                r5 = 35184372088832
                                                state = ReturnVal % r5
                                                upvalueValues[upvalues[2]] = state
                                                r5 = upvalueValues[upvalues[3]]
                                                r39 = 1
                                                ReturnVal = r5 ~= r39
                                                state = 81
                                            end
                                        end
                                    else
                                        if state == 80 then
                                            r36 = "table"
                                            r39 = _env[r36]
                                            r36 = "remove"
                                            r5 = r39[r36]
                                            r36 = upvalueValues[upvalues[1]]
                                            r39 = {
                                                r5(r36)
                                            }
                                            ReturnVal = {
                                                unpack(r39)
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    if state <= 82 then
                                        if state <= 81 then
                                            if state == 81 then
                                                r39 = upvalueValues[upvalues[3]]
                                                r36 = 181
                                                r5 = r39 * r36
                                                r39 = 257
                                                ReturnVal = r5 % r39
                                                upvalueValues[upvalues[3]] = ReturnVal
                                                state = 82
                                            end
                                        else
                                            if state == 82 then
                                                r39 = upvalueValues[upvalues[3]]
                                                r36 = 1
                                                r5 = r39 ~= r36
                                                state = r5 and (83) or (81)
                                            end
                                        end
                                    else
                                        if state == 83 then
                                            r36 = 32
                                            r21 = 2
                                            r39 = upvalueValues[upvalues[3]]
                                            r5 = r39 % r36
                                            r8 = upvalueValues[upvalues[4]]
                                            r41 = upvalueValues[upvalues[2]]
                                            r26 = upvalueValues[upvalues[3]]
                                            r31 = r26 - r5
                                            r26 = 32
                                            r33 = r31 / r26
                                            r10 = 13
                                            r9 = r10 - r33
                                            r23 = r21 ^ r9
                                            r14 = r41 / r23
                                            r40 = r8(r14)
                                            r8 = 4294967296
                                            r36 = r40 % r8
                                            r23 = 1
                                            r40 = 2
                                            r8 = r40 ^ r5
                                            r39 = r36 / r8
                                            r8 = upvalueValues[upvalues[4]]
                                            r41 = r39 % r23
                                            r23 = 4294967296
                                            r14 = r41 * r23
                                            r40 = r8(r14)
                                            r8 = upvalueValues[upvalues[4]]
                                            r14 = r8(r39)
                                            r36 = r40 + r14
                                            r40 = 65536
                                            r5 = nil
                                            r8 = r36 % r40
                                            r41 = 65536
                                            r14 = r36 - r8
                                            r21 = 256
                                            r40 = r14 / r41
                                            r10 = 256
                                            r39 = nil
                                            r41 = 256
                                            r14 = r8 % r41
                                            r23 = r8 - r14
                                            r8 = nil
                                            r41 = r23 / r21
                                            r21 = 256
                                            r23 = r40 % r21
                                            r9 = r40 - r23
                                            r40 = nil
                                            r21 = r9 / r10
                                            r36 = nil
                                            r9 = {
                                                r14,
                                                r41,
                                                r23,
                                                r21
                                            }
                                            upvalueValues[upvalues[1]] = r9
                                            r21 = nil
                                            r14 = nil
                                            r23 = nil
                                            r41 = nil
                                            state = 80
                                        end
                                    end
                                end
                            else
                                -- createClosure5 entry 2395468 -> 84, states 84-90
                                if state <= 87 then
                                    if state <= 85 then
                                        if state <= 84 then
                                            if state == 84 then -- entry 2395468 -> 84
                                                state = upvalueValues[upvalues[1]]
                                                r36 = state
                                                r5 = args[1]
                                                r39 = args[2]
                                                state = r36[r39]
                                                state = state and (85) or (86)
                                            end
                                        else
                                            if state == 85 then
                                                state = 87
                                            end
                                        end
                                    else
                                        if state <= 86 then
                                            if state == 86 then
                                                state = {}
                                                upvalueValues[upvalues[2]] = state
                                                ReturnVal = upvalueValues[upvalues[3]]
                                                r8 = ReturnVal
                                                r40 = 35184372088832
                                                ReturnVal = r39 % r40
                                                upvalueValues[upvalues[4]] = ReturnVal
                                                r41 = 255
                                                r14 = r39 % r41
                                                r41 = 2
                                                r40 = r14 + r41
                                                upvalueValues[upvalues[5]] = r40
                                                r23 = "string"
                                                r41 = _env[r23]
                                                r23 = "len"
                                                r14 = r41[r23]
                                                r41 = r14(r5)
                                                r14 = ""
                                                r36[r39] = r14
                                                r9 = 1
                                                r10 = r9
                                                r9 = 0
                                                r33 = r10 < r9
                                                r23 = 1
                                                r9 = r23 - r10
                                                r21 = r41
                                                r14 = 239
                                                state = 88
                                            end
                                        else
                                            if state == 87 then
                                                ReturnVal = {
                                                    r39
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    if state <= 89 then
                                        if state <= 88 then
                                            if state == 88 then
                                                r9 = r9 + r10
                                                r23 = r9 <= r21
                                                r31 = not r33
                                                r23 = r31 and r23
                                                r31 = r9 >= r21
                                                r31 = r33 and r31
                                                r23 = r31 or r23
                                                r31 = (89)
                                                state = r23 and r31
                                                r23 = (90)
                                                state = state or r23
                                            end
                                        else
                                            if state == 89 then
                                                r23 = r9
                                                r15 = "string"
                                                r13 = _env[r15]
                                                r15 = "byte"
                                                r27 = r13[r15]
                                                r13 = r27(r5, r23)
                                                r27 = upvalueValues[upvalues[6]]
                                                r15 = r27()
                                                r17 = r13 + r15
                                                r26 = r17 + r14
                                                r23 = nil
                                                r17 = 256
                                                r31 = r26 % r17
                                                r14 = r31
                                                r17 = r36[r39]
                                                r15 = 1
                                                r13 = r14 + r15
                                                r27 = r8[r13]
                                                r26 = r17 .. r27
                                                r36[r39] = r26
                                                state = 88
                                            end
                                        end
                                    else
                                        if state == 90 then
                                            r41 = nil
                                            r14 = nil
                                            r8 = nil
                                            state = 87
                                        end
                                    end
                                end
                            end
                        else
                            -- createClosure5 entry 12923756 -> 91, states 91-99
                            if state <= 95 then
                                if state <= 93 then
                                    if state <= 92 then
                                        if state <= 91 then
                                            if state == 91 then -- entry 12923756 -> 91
                                                r39 = args[2]
                                                r14 = upvalueValues[upvalues[1]]
                                                r5 = args[1]
                                                r41 = upvalueValues[upvalues[2]]
                                                r21 = "7$d\185U\244\168"
                                                r9 = 18980624343686
                                                r23 = r41(r21, r9)
                                                r40 = r14[r23]
                                                r8 = r5[r40]
                                                r23 = "Enum"
                                                r41 = _env[r23]
                                                r21 = upvalueValues[upvalues[1]]
                                                r9 = upvalueValues[upvalues[2]]
                                                r33 = "O\021\007ZR\147\005"
                                                r31 = 7657570979309
                                                r10 = r9(r33, r31)
                                                r23 = r21[r10]
                                                r14 = r41[r23]
                                                r23 = upvalueValues[upvalues[1]]
                                                r21 = upvalueValues[upvalues[2]]
                                                r10 = "\185)"
                                                r33 = 23472931515058
                                                r9 = r21(r10, r33)
                                                r41 = r23[r9]
                                                r40 = r14[r41]
                                                r36 = r8 == r40
                                                state = r36 and (92) or (93)
                                                ReturnVal = r36
                                            end
                                        else
                                            if state == 92 then
                                                r36 = upvalueValues[upvalues[3]]
                                                r23 = "Enum"
                                                r41 = _env[r23]
                                                r21 = upvalueValues[upvalues[1]]
                                                r9 = upvalueValues[upvalues[2]]
                                                r33 = "\209\188VG$\2517"
                                                r31 = 10706765108089
                                                r10 = r9(r33, r31)
                                                r23 = r21[r10]
                                                r14 = r41[r23]
                                                r23 = upvalueValues[upvalues[1]]
                                                r21 = upvalueValues[upvalues[2]]
                                                r10 = "g\142Qc\004\162\004"
                                                r33 = 10524921615141
                                                r9 = r21(r10, r33)
                                                r8 = "IsKeyDown"
                                                r8 = r36[r8]
                                                r41 = r23[r9]
                                                r40 = r14[r41]
                                                r8 = r8(r36, r40)
                                                ReturnVal = r8
                                                state = 93
                                            end
                                        end
                                    else
                                        if state == 93 then
                                            state = ReturnVal and (94) or (95)
                                        end
                                    end
                                else
                                    if state <= 94 then
                                        if state == 94 then
                                            ReturnVal = "game"
                                            state = _env[ReturnVal]
                                            r8 = upvalueValues[upvalues[1]]
                                            r40 = upvalueValues[upvalues[2]]
                                            r23 = 15927600454904
                                            r41 = "Ek\0116\223\187H\132\142\145"
                                            r14 = r40(r41, r23)
                                            r36 = r8[r14]
                                            ReturnVal = "GetService"
                                            ReturnVal = state[ReturnVal]
                                            ReturnVal = ReturnVal(state, r36)
                                            state = "ClearError"
                                            state = ReturnVal[state]
                                            state = state(ReturnVal)
                                            state = 96
                                        end
                                    else
                                        if state == 95 then
                                            r14 = upvalueValues[upvalues[1]]
                                            r41 = upvalueValues[upvalues[2]]
                                            r21 = "\212\173'\012\153\164T"
                                            r9 = 28061243945739
                                            r23 = r41(r21, r9)
                                            r40 = r14[r23]
                                            r8 = r5[r40]
                                            r23 = "Enum"
                                            r41 = _env[r23]
                                            r21 = upvalueValues[upvalues[1]]
                                            r9 = upvalueValues[upvalues[2]]
                                            r33 = "\225\199A\012\245\206\131"
                                            r31 = 15070080015209
                                            r10 = r9(r33, r31)
                                            r23 = r21[r10]
                                            r14 = r41[r23]
                                            r23 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r33 = 11354251072679
                                            r10 = "\221\135\154\174\230\028"
                                            r9 = r21(r10, r33)
                                            r41 = r23[r9]
                                            r40 = r14[r41]
                                            r36 = r8 == r40
                                            state = r36 and (97) or (98)
                                            ReturnVal = r36
                                        end
                                    end
                                end
                            else
                                if state <= 97 then
                                    if state <= 96 then
                                        if state == 96 then
                                            r39 = nil
                                            r5 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    else
                                        if state == 97 then
                                            state = ReturnVal and (99) or (96)
                                        end
                                    end
                                else
                                    if state <= 98 then
                                        if state == 98 then
                                            r14 = upvalueValues[upvalues[1]]
                                            r41 = upvalueValues[upvalues[2]]
                                            r21 = "\193\153\149\139\021\145\176"
                                            r9 = 29253498533174
                                            r23 = r41(r21, r9)
                                            r40 = r14[r23]
                                            r8 = r5[r40]
                                            r23 = "Enum"
                                            r41 = _env[r23]
                                            r21 = upvalueValues[upvalues[1]]
                                            r9 = upvalueValues[upvalues[2]]
                                            r33 = "\147K\164\217\176\206n"
                                            r31 = 15668159372416
                                            r10 = r9(r33, r31)
                                            r23 = r21[r10]
                                            r14 = r41[r23]
                                            r23 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r10 = "\148I"
                                            r33 = 34112586268172
                                            r9 = r21(r10, r33)
                                            r41 = r23[r9]
                                            r40 = r14[r41]
                                            r36 = r8 == r40
                                            ReturnVal = r36
                                            state = 97
                                        end
                                    else
                                        if state == 99 then
                                            ReturnVal = "game"
                                            state = _env[ReturnVal]
                                            ReturnVal = "GetService"
                                            ReturnVal = state[ReturnVal]
                                            r8 = upvalueValues[upvalues[1]]
                                            r40 = upvalueValues[upvalues[2]]
                                            r41 = "o\148\185@\163\239\237\190\001\248"
                                            r23 = 21047422772808
                                            r14 = r40(r41, r23)
                                            r36 = r8[r14]
                                            ReturnVal = ReturnVal(state, r36)
                                            state = "ClearError"
                                            state = ReturnVal[state]
                                            state = state(ReturnVal)
                                            state = 96
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 101 then
                            if state <= 100 then
                                -- createClosure3 entry 8075148 -> 100, states 100-100
                                if state == 100 then -- entry 8075148 -> 100
                                    ReturnVal = "getgenv"
                                    state = _env[ReturnVal]
                                    ReturnVal = state()
                                    r5 = upvalueValues[upvalues[1]]
                                    r39 = upvalueValues[upvalues[2]]
                                    r40 = 34273495105111
                                    r8 = "\222\128\239U\230\022\014:\029gV2\235\028Z\166\232N\128\205X\170\016\017"
                                    r36 = r39(r8, r40)
                                    state = r5[r36]
                                    r5 = true
                                    ReturnVal[state] = r5
                                    ReturnVal = {}
                                    state = nil
                                end
                            else
                                -- createClosure4 entry 5730137 -> 101, states 101-101
                                if state == 101 then -- entry 5730137 -> 101
                                    r41 = 4876053334238
                                    ReturnVal = "game"
                                    state = _env[ReturnVal]
                                    r36 = upvalueValues[upvalues[1]]
                                    r14 = "\0242\1811\201e\251z\222\204\172+\011\029odh\255\1281Z\220];\149\029\020\215V\192\147,\163Uo(9\212\140m\011k\129\190\\%9\1730$\245\183Be\253ki\237\153c\022|\015\217"
                                    r8 = upvalueValues[upvalues[2]]
                                    r40 = r8(r14, r41)
                                    r39 = r36[r40]
                                    r40 = upvalueValues[upvalues[3]]
                                    r41 = upvalueValues[upvalues[1]]
                                    r23 = upvalueValues[upvalues[2]]
                                    r10 = 24019561999280
                                    r9 = "\155>gG\223\223"
                                    r21 = r23(r9, r10)
                                    r14 = r41[r21]
                                    r8 = r40[r14]
                                    r14 = upvalueValues[upvalues[1]]
                                    ReturnVal = "HttpGet"
                                    ReturnVal = state[ReturnVal]
                                    r21 = "\252\016\178\240\228\236\t\137\242\219\237d\n\218\242#\177\195\192!k(\008:t\185Q\227Q\150\024\233\229\197\244ep\183u\242"
                                    r41 = upvalueValues[upvalues[2]]
                                    r9 = 28496612488149
                                    r23 = r41(r21, r9)
                                    r40 = r14[r23]
                                    r36 = r8 .. r40
                                    r5 = r39 .. r36
                                    ReturnVal = ReturnVal(state, r5)
                                    state = upvalueValues[upvalues[4]]
                                    r23 = "\219#\137|"
                                    r5 = ReturnVal
                                    r21 = 25923476107047
                                    ReturnVal = "JSONDecode"
                                    ReturnVal = state[ReturnVal]
                                    ReturnVal = ReturnVal(state, r5)
                                    r40 = upvalueValues[upvalues[1]]
                                    r14 = upvalueValues[upvalues[2]]
                                    r39 = ReturnVal
                                    r41 = r14(r23, r21)
                                    r8 = r40[r41]
                                    r21 = "\172I\021h\220\160\213\145\189\188\200\139\176N\233.gD\253\127\230\205\024\180hZ(\178hA\152\168\140=j"
                                    r23 = 30846529173532
                                    r36 = r39[r8]
                                    r8 = 1
                                    ReturnVal = r36[r8]
                                    r41 = "\020\253e\155\188V\128\132"
                                    r8 = upvalueValues[upvalues[1]]
                                    r40 = upvalueValues[upvalues[2]]
                                    r14 = r40(r41, r23)
                                    r36 = r8[r14]
                                    state = ReturnVal[r36]
                                    r36 = state
                                    ReturnVal = "game"
                                    state = _env[ReturnVal]
                                    r14 = upvalueValues[upvalues[1]]
                                    r41 = upvalueValues[upvalues[2]]
                                    r9 = 13020387006383
                                    r23 = r41(r21, r9)
                                    r40 = r14[r23]
                                    r41 = upvalueValues[upvalues[3]]
                                    ReturnVal = "HttpGet"
                                    ReturnVal = state[ReturnVal]
                                    r21 = upvalueValues[upvalues[1]]
                                    r9 = upvalueValues[upvalues[2]]
                                    r31 = 25012599123327
                                    r33 = "\011\161\249\136\148\188"
                                    r10 = r9(r33, r31)
                                    r23 = r21[r10]
                                    r14 = r41[r23]
                                    r8 = r40 .. r14
                                    r21 = "\172\131\028\139\2297{\tH\220\028"
                                    ReturnVal = ReturnVal(state, r8)
                                    state = upvalueValues[upvalues[4]]
                                    r8 = ReturnVal
                                    ReturnVal = "JSONDecode"
                                    ReturnVal = state[ReturnVal]
                                    ReturnVal = ReturnVal(state, r8)
                                    r40 = ReturnVal
                                    r14 = upvalueValues[upvalues[1]]
                                    r41 = upvalueValues[upvalues[2]]
                                    r9 = 25479498575448
                                    r23 = r41(r21, r9)
                                    ReturnVal = r14[r23]
                                    state = r40[ReturnVal]
                                    r14 = state
                                    r41 = upvalueValues[upvalues[1]]
                                    r23 = upvalueValues[upvalues[2]]
                                    r10 = 7133205990649
                                    r9 = "c\233\031\241k\160Y"
                                    r21 = r23(r9, r10)
                                    ReturnVal = r41[r21]
                                    state = r40[ReturnVal]
                                    r23 = upvalueValues[upvalues[1]]
                                    r41 = state
                                    r21 = upvalueValues[upvalues[2]]
                                    r33 = 12134996317714
                                    r10 = "\140/\248h\028\1837q"
                                    r9 = r21(r10, r33)
                                    ReturnVal = r23[r9]
                                    r20 = "\212\154\018\167\251"
                                    r38 = "\173\246\228\003Z\015K\188\1850"
                                    r34 = 30172593010402
                                    r29 = "\167\165~\178"
                                    r22 = 19064378122925
                                    r21 = upvalueValues[upvalues[1]]
                                    r9 = upvalueValues[upvalues[2]]
                                    r31 = 15380361223162
                                    r33 = "\002?*\226\238\211\180K\004\008\157i_%_\235"
                                    r10 = r9(r33, r31)
                                    r23 = r21[r10]
                                    r9 = upvalueValues[upvalues[1]]
                                    r10 = upvalueValues[upvalues[2]]
                                    r26 = 13897498204487
                                    r31 = "\022\207\2413\1915\213S\247K"
                                    r33 = r10(r31, r26)
                                    r21 = r9[r33]
                                    r10 = upvalueValues[upvalues[1]]
                                    r33 = upvalueValues[upvalues[2]]
                                    r17 = 8981701840982
                                    r26 = "\192v\150\214\158{*|\227\016\207nC\170\180=\181\227\174\167^\162\226\193\019\\\241\197\154,|\164\019e\007MZ\018.#G/\134\156\140\252\164k\230\014i\012\155\195\016\tb\185;\180\246(\169\187\234p\012\136\147>Z\158S\153\173\011\227\215\024\143{\243\016\018G\2182\149w"
                                    r31 = r33(r26, r17)
                                    r9 = r10[r31]
                                    r33 = upvalueValues[upvalues[1]]
                                    r31 = upvalueValues[upvalues[2]]
                                    r27 = 2975871878505
                                    r17 = "&Z\130\137\213\250s"
                                    r26 = r31(r17, r27)
                                    r10 = r33[r26]
                                    r31 = upvalueValues[upvalues[1]]
                                    r26 = upvalueValues[upvalues[2]]
                                    r13 = 5717409909350
                                    r27 = "\191\n\147\154?ow\199\132!\225\238\160\223\150"
                                    r17 = r26(r27, r13)
                                    r33 = r31[r17]
                                    r26 = upvalueValues[upvalues[1]]
                                    r17 = upvalueValues[upvalues[2]]
                                    r15 = 18867511566929
                                    r13 = "\139}\146\241f\132"
                                    r27 = r17(r13, r15)
                                    r31 = r26[r27]
                                    r13 = upvalueValues[upvalues[1]]
                                    r15 = upvalueValues[upvalues[2]]
                                    r37 = 4618218604646
                                    r18 = "l\195Y\167-"
                                    r24 = r15(r18, r37)
                                    r27 = r13[r24]
                                    r15 = upvalueValues[upvalues[1]]
                                    r24 = upvalueValues[upvalues[2]]
                                    r12 = 24648726588629
                                    r37 = "4\237\229\205\015\016\227\151:\193"
                                    r18 = r24(r37, r12)
                                    r13 = r15[r18]
                                    r24 = upvalueValues[upvalues[1]]
                                    r18 = upvalueValues[upvalues[2]]
                                    r7 = 13888058874179
                                    r12 = "U\175\236\179]\029s\006|\193\191"
                                    r37 = r18(r12, r7)
                                    r15 = r24[r37]
                                    r37 = upvalueValues[upvalues[1]]
                                    r12 = upvalueValues[upvalues[2]]
                                    r4 = 28045256307459
                                    r1 = "rX\158\228`\139li\144\225\213[\160\008\n\193\139\135\214\252t$;\229Sp\198=\150|\245\167H5xl\229\004"
                                    r7 = r12(r1, r4)
                                    r18 = r37[r7]
                                    r1 = "game"
                                    r7 = _env[r1]
                                    r4 = upvalueValues[upvalues[1]]
                                    r35 = upvalueValues[upvalues[2]]
                                    r16 = "T\221B\173\007v\021"
                                    r30 = 34931928694666
                                    r42 = r35(r16, r30)
                                    r1 = r4[r42]
                                    r12 = r7[r1]
                                    r4 = upvalueValues[upvalues[1]]
                                    r35 = upvalueValues[upvalues[2]]
                                    r16 = "b\219\138j\185mm\186A\172\193\185\206\147if\215\247v\232\255\1997\192lle\015\023\196\005\213\149>\196\018\133>\255`\215\214_\214B"
                                    r30 = 27886046229177
                                    r42 = r35(r16, r30)
                                    r1 = r4[r42]
                                    r42 = upvalueValues[upvalues[3]]
                                    r30 = upvalueValues[upvalues[1]]
                                    r32 = upvalueValues[upvalues[2]]
                                    r3 = 84174159911
                                    r11 = "\255\234\189\130\\h"
                                    r19 = r32(r11, r3)
                                    r16 = r30[r19]
                                    r35 = r42[r16]
                                    r39 = nil
                                    r30 = upvalueValues[upvalues[1]]
                                    r32 = upvalueValues[upvalues[2]]
                                    r3 = 17688329674796
                                    r11 = "\021\003\239i\225\169\1509\241\164\209%9$\255g\244'\233.\023\200\149"
                                    r19 = r32(r11, r3)
                                    r16 = r30[r19]
                                    r11 = "game"
                                    r19 = _env[r11]
                                    r3 = upvalueValues[upvalues[1]]
                                    r2 = upvalueValues[upvalues[2]]
                                    r25 = r2(r20, r34)
                                    r11 = r3[r25]
                                    r32 = r19[r11]
                                    r11 = upvalueValues[upvalues[1]]
                                    r3 = upvalueValues[upvalues[2]]
                                    r25 = "\215G"
                                    r20 = 18014229225668
                                    r2 = r3(r25, r20)
                                    r19 = r11[r2]
                                    r30 = r32 .. r19
                                    r42 = r16 .. r30
                                    r4 = r35 .. r42
                                    r7 = r1 .. r4
                                    r37 = r12 .. r7
                                    r24 = r18 .. r37
                                    r37 = upvalueValues[upvalues[1]]
                                    r12 = upvalueValues[upvalues[2]]
                                    r1 = "'>-]\171"
                                    r4 = 10969652270068
                                    r7 = r12(r1, r4)
                                    r18 = r37[r7]
                                    r37 = 4915083
                                    r7 = upvalueValues[upvalues[1]]
                                    r1 = upvalueValues[upvalues[2]]
                                    r42 = 13202368141315
                                    r35 = "^\184\195\t\139\146"
                                    r4 = r1(r35, r42)
                                    r12 = r7[r4]
                                    r35 = upvalueValues[upvalues[1]]
                                    r42 = upvalueValues[upvalues[2]]
                                    r30 = "\004\205\178F"
                                    r32 = 28821156131948
                                    r16 = r42(r30, r32)
                                    r4 = r35[r16]
                                    r42 = upvalueValues[upvalues[1]]
                                    r32 = "ek\212\130\143\006\147\200"
                                    r25 = 33697209482571
                                    r2 = "0\152\184\223"
                                    r19 = 19321054896933
                                    r11 = 7586394344908
                                    r5 = nil
                                    r16 = upvalueValues[upvalues[2]]
                                    r30 = r16(r32, r19)
                                    r35 = r42[r30]
                                    r16 = upvalueValues[upvalues[1]]
                                    r30 = upvalueValues[upvalues[2]]
                                    r19 = "\170X\003F0"
                                    r32 = r30(r19, r11)
                                    r42 = r16[r32]
                                    r30 = upvalueValues[upvalues[3]]
                                    r19 = upvalueValues[upvalues[1]]
                                    r11 = upvalueValues[upvalues[2]]
                                    r3 = r11(r2, r25)
                                    r32 = r19[r3]
                                    r16 = r30[r32]
                                    r32 = upvalueValues[upvalues[1]]
                                    r19 = upvalueValues[upvalues[2]]
                                    r3 = "\239\128:\246hi"
                                    r2 = 8156244790998
                                    r11 = r19(r3, r2)
                                    r30 = r32[r11]
                                    r32 = true
                                    r1 = {
                                        [r4] = r35,
                                        [r42] = r16,
                                        [r30] = r32
                                    }
                                    r42 = upvalueValues[upvalues[1]]
                                    r16 = upvalueValues[upvalues[2]]
                                    r19 = 898634727842
                                    r32 = "\158bO\129"
                                    r30 = r16(r32, r19)
                                    r35 = r42[r30]
                                    r16 = upvalueValues[upvalues[1]]
                                    r30 = upvalueValues[upvalues[2]]
                                    r11 = 24436313484403
                                    r19 = "\007\2432\189\142\"!\223\129L\137."
                                    r32 = r30(r19, r11)
                                    r42 = r16[r32]
                                    r30 = upvalueValues[upvalues[1]]
                                    r32 = upvalueValues[upvalues[2]]
                                    r3 = 3818401859314
                                    r11 = "/>C\200\135"
                                    r19 = r32(r11, r3)
                                    r16 = r30[r19]
                                    r32 = upvalueValues[upvalues[3]]
                                    r11 = upvalueValues[upvalues[1]]
                                    r3 = upvalueValues[upvalues[2]]
                                    r20 = 13919021750609
                                    r25 = "\011\200\244L\231\210tL\127\232\227"
                                    r2 = r3(r25, r20)
                                    r19 = r11[r2]
                                    r30 = r32[r19]
                                    r19 = upvalueValues[upvalues[1]]
                                    r11 = upvalueValues[upvalues[2]]
                                    r2 = "l\202\255\226\195\142"
                                    r25 = 14264540502514
                                    r3 = r11(r2, r25)
                                    r32 = r19[r3]
                                    r19 = true
                                    r4 = {
                                        [r35] = r42,
                                        [r16] = r30,
                                        [r32] = r19
                                    }
                                    r16 = upvalueValues[upvalues[1]]
                                    r30 = upvalueValues[upvalues[2]]
                                    r11 = 29297900434762
                                    r19 = "i\149\008\141"
                                    r32 = r30(r19, r11)
                                    r42 = r16[r32]
                                    r30 = upvalueValues[upvalues[1]]
                                    r32 = upvalueValues[upvalues[2]]
                                    r3 = 21052227741259
                                    r11 = "n\011PV\172\189Z"
                                    r19 = r32(r11, r3)
                                    r16 = r30[r19]
                                    r32 = upvalueValues[upvalues[1]]
                                    r19 = upvalueValues[upvalues[2]]
                                    r2 = 26399536820229
                                    r3 = "\003\219H\157\184"
                                    r11 = r19(r3, r2)
                                    r30 = r32[r11]
                                    r19 = upvalueValues[upvalues[3]]
                                    r3 = upvalueValues[upvalues[1]]
                                    r2 = upvalueValues[upvalues[2]]
                                    r34 = 9493889552708
                                    r20 = "d\165\217j\1579"
                                    r25 = r2(r20, r34)
                                    r11 = r3[r25]
                                    r32 = r19[r11]
                                    r11 = upvalueValues[upvalues[1]]
                                    r3 = upvalueValues[upvalues[2]]
                                    r25 = ".\026n\001tm"
                                    r20 = 34949725945746
                                    r2 = r3(r25, r20)
                                    r19 = r11[r2]
                                    r11 = true
                                    r35 = {
                                        [r42] = r16,
                                        [r30] = r32,
                                        [r19] = r11
                                    }
                                    r6 = 25654111137450
                                    r30 = upvalueValues[upvalues[1]]
                                    r32 = upvalueValues[upvalues[2]]
                                    r3 = 196866555995
                                    r11 = "? \r\220"
                                    r19 = r32(r11, r3)
                                    r2 = 12469761447598
                                    r40 = nil
                                    r16 = r30[r19]
                                    r32 = upvalueValues[upvalues[1]]
                                    r19 = upvalueValues[upvalues[2]]
                                    r3 = "%,a7\028c\182\004\142\179\186"
                                    r11 = r19(r3, r2)
                                    r30 = r32[r11]
                                    r19 = upvalueValues[upvalues[1]]
                                    r11 = upvalueValues[upvalues[2]]
                                    r25 = 5482763749881
                                    r2 = "\212\016l\148!"
                                    r3 = r11(r2, r25)
                                    r32 = r19[r3]
                                    r3 = upvalueValues[upvalues[3]]
                                    r25 = upvalueValues[upvalues[1]]
                                    r20 = upvalueValues[upvalues[2]]
                                    r34 = r20(r38, r22)
                                    r2 = r25[r34]
                                    r11 = r3[r2]
                                    r2 = upvalueValues[upvalues[1]]
                                    r25 = upvalueValues[upvalues[2]]
                                    r38 = 17087980052245
                                    r34 = "\1437\130\025"
                                    r20 = r25(r34, r38)
                                    r3 = r2[r20]
                                    r19 = r11 .. r3
                                    r3 = upvalueValues[upvalues[1]]
                                    r2 = upvalueValues[upvalues[2]]
                                    r34 = 30131490338511
                                    r20 = "\1307\178\131\149\138"
                                    r25 = r2(r20, r34)
                                    r11 = r3[r25]
                                    r3 = true
                                    r42 = {
                                        [r16] = r30,
                                        [r32] = r19,
                                        [r11] = r3
                                    }
                                    r32 = upvalueValues[upvalues[1]]
                                    r19 = upvalueValues[upvalues[2]]
                                    r3 = "0\204o\169"
                                    r2 = 32952436997104
                                    r11 = r19(r3, r2)
                                    r30 = r32[r11]
                                    r19 = upvalueValues[upvalues[1]]
                                    r11 = upvalueValues[upvalues[2]]
                                    r25 = 9948864254488
                                    r2 = "\170\140\229\206\198\212\156\155(\178"
                                    r3 = r11(r2, r25)
                                    r32 = r19[r3]
                                    r11 = upvalueValues[upvalues[1]]
                                    r3 = upvalueValues[upvalues[2]]
                                    r20 = 29879046927961
                                    r25 = "\201px\224\143"
                                    r2 = r3(r25, r20)
                                    r19 = r11[r2]
                                    r2 = upvalueValues[upvalues[3]]
                                    r20 = upvalueValues[upvalues[1]]
                                    r34 = upvalueValues[upvalues[2]]
                                    r22 = "\208\236\250\193o5y\168\002\158\172\155C\139"
                                    r38 = r34(r22, r6)
                                    r25 = r20[r38]
                                    r3 = r2[r25]
                                    r25 = upvalueValues[upvalues[1]]
                                    r20 = upvalueValues[upvalues[2]]
                                    r22 = 10033038414399
                                    r38 = "i\174F\155"
                                    r34 = r20(r38, r22)
                                    r2 = r25[r34]
                                    r11 = r3[r2]
                                    r2 = upvalueValues[upvalues[1]]
                                    r25 = upvalueValues[upvalues[2]]
                                    r34 = "\206@\222\138C\178"
                                    r38 = 12383004497542
                                    r20 = r25(r34, r38)
                                    r3 = r2[r20]
                                    r2 = true
                                    r16 = {
                                        [r30] = r32,
                                        [r19] = r11,
                                        [r3] = r2
                                    }
                                    r19 = upvalueValues[upvalues[1]]
                                    r11 = upvalueValues[upvalues[2]]
                                    r25 = 20642332042636
                                    r2 = "B\008\237\t"
                                    r3 = r11(r2, r25)
                                    r32 = r19[r3]
                                    r11 = upvalueValues[upvalues[1]]
                                    r3 = upvalueValues[upvalues[2]]
                                    r20 = 28047267640068
                                    r25 = "\026\138[|\216\020\2186\006B\002a\142\134\239\225\207E\248"
                                    r2 = r3(r25, r20)
                                    r19 = r11[r2]
                                    r3 = upvalueValues[upvalues[1]]
                                    r2 = upvalueValues[upvalues[2]]
                                    r34 = 23352656783994
                                    r20 = "\149*NN\209"
                                    r25 = r2(r20, r34)
                                    r11 = r3[r25]
                                    r25 = "string"
                                    r2 = _env[r25]
                                    r20 = upvalueValues[upvalues[1]]
                                    r34 = upvalueValues[upvalues[2]]
                                    r6 = 33844700183952
                                    r22 = "\218R\255\210 "
                                    r38 = r34(r22, r6)
                                    r25 = r20[r38]
                                    r3 = r2[r25]
                                    r20 = upvalueValues[upvalues[1]]
                                    r34 = upvalueValues[upvalues[2]]
                                    r22 = "`\164\128\244\226t\245\191\162"
                                    r6 = 21684051683185
                                    r38 = r34(r22, r6)
                                    r25 = r20[r38]
                                    r2 = r3(r41, r25)
                                    r25 = upvalueValues[upvalues[1]]
                                    r20 = upvalueValues[upvalues[2]]
                                    r38 = "\189G\218\157\185'"
                                    r22 = 7489339575711
                                    r34 = r20(r38, r22)
                                    r3 = r25[r34]
                                    r25 = true
                                    r30 = {
                                        [r32] = r19,
                                        [r11] = r2,
                                        [r3] = r25
                                    }
                                    r11 = upvalueValues[upvalues[1]]
                                    r3 = upvalueValues[upvalues[2]]
                                    r20 = 6246722423644
                                    r25 = "y'X\246"
                                    r2 = r3(r25, r20)
                                    r19 = r11[r2]
                                    r3 = upvalueValues[upvalues[1]]
                                    r2 = upvalueValues[upvalues[2]]
                                    r20 = "^1\177\003E$\145\173\142>\255\236\231\143\134f\007\191y"
                                    r34 = 20196889060540
                                    r25 = r2(r20, r34)
                                    r11 = r3[r25]
                                    r2 = upvalueValues[upvalues[1]]
                                    r25 = upvalueValues[upvalues[2]]
                                    r38 = 15645584366709
                                    r34 = "\001\153\151\155#"
                                    r20 = r25(r34, r38)
                                    r3 = r2[r20]
                                    r20 = upvalueValues[upvalues[1]]
                                    r34 = upvalueValues[upvalues[2]]
                                    r22 = "eq\233%"
                                    r6 = 7145357167871
                                    r38 = r34(r22, r6)
                                    r25 = r20[r38]
                                    r38 = upvalueValues[upvalues[1]]
                                    r22 = upvalueValues[upvalues[2]]
                                    r28 = 9448830439727
                                    r6 = r22(r29, r28)
                                    r34 = r38[r6]
                                    r20 = r14 .. r34
                                    r2 = r25 .. r20
                                    r20 = upvalueValues[upvalues[1]]
                                    r34 = upvalueValues[upvalues[2]]
                                    r22 = "rp\170\028\136\158"
                                    r6 = 19463986226023
                                    r38 = r34(r22, r6)
                                    r25 = r20[r38]
                                    r20 = true
                                    r41 = nil
                                    r32 = {
                                        [r19] = r11,
                                        [r3] = r2,
                                        [r25] = r20
                                    }
                                    r7 = {
                                        r1,
                                        r4,
                                        r35,
                                        r42,
                                        r16,
                                        r30,
                                        r32
                                    }
                                    r4 = upvalueValues[upvalues[1]]
                                    r35 = upvalueValues[upvalues[2]]
                                    r30 = 21064378918480
                                    r16 = "\228\170\028 \237g"
                                    r42 = r35(r16, r30)
                                    r1 = r4[r42]
                                    r42 = upvalueValues[upvalues[1]]
                                    r16 = upvalueValues[upvalues[2]]
                                    r32 = "T\193\140\245"
                                    r19 = 23713370958626
                                    r30 = r16(r32, r19)
                                    r35 = r42[r30]
                                    r16 = upvalueValues[upvalues[1]]
                                    r30 = upvalueValues[upvalues[2]]
                                    r11 = 13577514571954
                                    r19 = "\192rmN`\134o"
                                    r32 = r30(r19, r11)
                                    r42 = r16[r32]
                                    r30 = upvalueValues[upvalues[1]]
                                    r32 = upvalueValues[upvalues[2]]
                                    r3 = 6932234554524
                                    r11 = "\142\141\008\151[\234\155("
                                    r19 = r32(r11, r3)
                                    r16 = r30[r19]
                                    r32 = upvalueValues[upvalues[1]]
                                    r19 = upvalueValues[upvalues[2]]
                                    r2 = 14928535673639
                                    r3 = "\183\152\138~T\027\196\2041\030\161S\249P\153\246\138v*\179~FE3\199q3\007|\183\012\138\145-^Wi\171\"\166\249A=0I\240\144\149\169\027>rb\218\203\213>21\165\173"
                                    r11 = r19(r3, r2)
                                    r30 = r32[r11]
                                    r4 = {
                                        [r35] = r42,
                                        [r16] = r30
                                    }
                                    r11 = "*\204\137"
                                    r3 = 6697588395054
                                    r42 = upvalueValues[upvalues[1]]
                                    r16 = upvalueValues[upvalues[2]]
                                    r19 = 23071404124663
                                    r32 = "P[J\228`\222\200\209\168"
                                    r30 = r16(r32, r19)
                                    r35 = r42[r30]
                                    r30 = upvalueValues[upvalues[1]]
                                    r8 = nil
                                    r32 = upvalueValues[upvalues[2]]
                                    r19 = r32(r11, r3)
                                    r16 = r30[r19]
                                    r42 = {
                                        [r16] = r36
                                    }
                                    r17 = {
                                        [r27] = r13,
                                        [r15] = r24,
                                        [r18] = r37,
                                        [r12] = r7,
                                        [r1] = r4,
                                        [r35] = r42
                                    }
                                    r26 = {
                                        r17
                                    }
                                    state = {
                                        [ReturnVal] = r23,
                                        [r21] = r9,
                                        [r10] = r33,
                                        [r31] = r26
                                    }
                                    r21 = upvalueValues[upvalues[1]]
                                    r9 = upvalueValues[upvalues[2]]
                                    r33 = "J\218\207;\163\1752\"8\252o\218"
                                    r31 = 15125402246019
                                    r10 = r9(r33, r31)
                                    r23 = state
                                    ReturnVal = r21[r10]
                                    r9 = upvalueValues[upvalues[1]]
                                    r10 = upvalueValues[upvalues[2]]
                                    r26 = 356793467046
                                    r31 = "\026\2368\187.\187\210{0\237\2047G\204\004\178"
                                    r33 = r10(r31, r26)
                                    r21 = r9[r33]
                                    state = {
                                        [ReturnVal] = r21
                                    }
                                    r21 = state
                                    r24 = 17444773519291
                                    r18 = 7127470394614
                                    r1 = 27393637790164
                                    r37 = 31957845277217
                                    ReturnVal = "request"
                                    state = _env[ReturnVal]
                                    r33 = upvalueValues[upvalues[1]]
                                    r31 = upvalueValues[upvalues[2]]
                                    r17 = "\026\175\203"
                                    r27 = 12180352161319
                                    r26 = r31(r17, r27)
                                    r10 = r33[r26]
                                    r33 = upvalueValues[upvalues[5]]
                                    r26 = upvalueValues[upvalues[1]]
                                    r7 = "\230\161\139F,o\003t2,\189"
                                    r17 = upvalueValues[upvalues[2]]
                                    r13 = "\158*;A)f"
                                    r15 = 34189780368944
                                    r27 = r17(r13, r15)
                                    r14 = nil
                                    r31 = r26[r27]
                                    r17 = upvalueValues[upvalues[1]]
                                    r27 = upvalueValues[upvalues[2]]
                                    r15 = "\148E\0175"
                                    r13 = r27(r15, r24)
                                    r26 = r17[r13]
                                    r27 = upvalueValues[upvalues[1]]
                                    r13 = upvalueValues[upvalues[2]]
                                    r24 = "\137`\192\250]D\189"
                                    r15 = r13(r24, r18)
                                    r36 = nil
                                    r17 = r27[r15]
                                    r13 = upvalueValues[upvalues[1]]
                                    r15 = upvalueValues[upvalues[2]]
                                    r18 = "N\024\159\r"
                                    r24 = r15(r18, r37)
                                    r27 = r13[r24]
                                    r15 = "game"
                                    r13 = _env[r15]
                                    r18 = upvalueValues[upvalues[1]]
                                    r37 = upvalueValues[upvalues[2]]
                                    r12 = r37(r7, r1)
                                    r24 = r18[r12]
                                    r15 = "GetService"
                                    r15 = r13[r15]
                                    r15 = r15(r13, r24)
                                    r13 = "JSONEncode"
                                    r13 = r15[r13]
                                    r13 = r13(r15, r23)
                                    r9 = {
                                        [r10] = r33,
                                        [r31] = r26,
                                        [r17] = r21,
                                        [r27] = r13
                                    }
                                    r21 = nil
                                    ReturnVal = state(r9)
                                    r23 = nil
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            -- createClosure1 entry 13014590 -> 102, states 102-102
                            if state == 102 then -- entry 13014590 -> 102
                                r39 = "52w"
                                r36 = 905030
                                r5 = r39 ^ r36
                                ReturnVal = 14243352
                                state = ReturnVal - r5
                                r5 = state
                                ReturnVal = "GCkOFGo2WwGyhx"
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
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        currentUpvalueId = 0
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
            end
            return closure
        end
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 356342
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 356342
                    end
                })
            end
        end
        upvalueValues = {}
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
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
        upvalueRefCounts = {}
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