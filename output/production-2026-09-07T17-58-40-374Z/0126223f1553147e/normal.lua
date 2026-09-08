return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure3, allocUpvalue, upvalueRefCounts, createClosure0, createClosure1, createClosure5, createUpvalueProxy, releaseUpvalue, currentUpvalueId, createClosure4, releaseUpvalues, createClosure, createClosure2, vm, upvalueValues)
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, ReturnVal, r28, r29, r30, r31, r32, r33
            while state do
                if state <= 96 then
                    if state <= 74 then
                        if state <= 45 then
                            if state <= 43 then
                                if state <= 42 then
                                    -- root entry 16402506 -> 1, states 1-42
                                    if state <= 21 then
                                        if state <= 11 then
                                            if state <= 6 then
                                                if state <= 3 then
                                                    if state <= 2 then
                                                        if state <= 1 then
                                                            if state == 1 then -- entry 16402506 -> 1
                                                                r21 = allocUpvalue()
                                                                r15 = allocUpvalue()
                                                                state = true
                                                                upvalueValues[r21] = state
                                                                r26 = "string"
                                                                ReturnVal = _env[r26]
                                                                r26 = "gmatch"
                                                                state = ReturnVal[r26]
                                                                r26 = allocUpvalue()
                                                                r14 = allocUpvalue()
                                                                upvalueValues[r26] = state
                                                                state = createClosure1(43, {})
                                                                upvalueValues[r15] = state
                                                                state = false
                                                                upvalueValues[r14] = state
                                                                r6 = createClosure1(44, {
                                                                    r14
                                                                })
                                                                r13 = "pcall"
                                                                r3 = _env[r13]
                                                                r13 = r3(r6)
                                                                state = r13 and (2) or (3)
                                                                ReturnVal = r13
                                                                r5 = args
                                                            end
                                                        else
                                                            if state == 2 then
                                                                r3 = upvalueValues[r14]
                                                                ReturnVal = r3
                                                                state = 3
                                                            end
                                                        end
                                                    else
                                                        if state == 3 then
                                                            r3 = ReturnVal
                                                            r13 = "math"
                                                            ReturnVal = _env[r13]
                                                            r13 = "random"
                                                            state = ReturnVal[r13]
                                                            r13 = allocUpvalue()
                                                            upvalueValues[r13] = state
                                                            r6 = "table"
                                                            ReturnVal = _env[r6]
                                                            r6 = "concat"
                                                            state = ReturnVal[r6]
                                                            r31 = state
                                                            r6 = state
                                                            r32 = "table"
                                                            r2 = _env[r32]
                                                            state = r2 and (4) or (5)
                                                            r29 = r2
                                                        end
                                                    end
                                                else
                                                    if state <= 5 then
                                                        if state <= 4 then
                                                            if state == 4 then
                                                                r28 = "table"
                                                                r32 = _env[r28]
                                                                r28 = "unpack"
                                                                r2 = r32[r28]
                                                                r29 = r2
                                                                state = 5
                                                            end
                                                        else
                                                            if state == 5 then
                                                                state = r31
                                                                state = r29 and (6) or (7)
                                                                ReturnVal = r29
                                                            end
                                                        end
                                                    else
                                                        if state == 6 then
                                                            r29 = allocUpvalue()
                                                            upvalueValues[r29] = ReturnVal
                                                            state = upvalueValues[r13]
                                                            r2 = 65
                                                            r31 = 3
                                                            ReturnVal = state(r31, r2)
                                                            r31 = allocUpvalue()
                                                            upvalueValues[r31] = ReturnVal
                                                            state = 0
                                                            r2 = state
                                                            r33 = createClosure1(45, {})
                                                            r28 = "pcall"
                                                            ReturnVal = _env[r28]
                                                            r28 = {
                                                                ReturnVal(r33)
                                                            }
                                                            state = 0
                                                            r32 = state
                                                            state = {
                                                                unpack(r28)
                                                            }
                                                            r28 = state
                                                            ReturnVal = 2
                                                            state = r28[ReturnVal]
                                                            r33 = state
                                                            ReturnVal = "tonumber"
                                                            state = _env[ReturnVal]
                                                            r16 = upvalueValues[r26]
                                                            r1 = "tostring"
                                                            r12 = _env[r1]
                                                            r1 = r12(r33)
                                                            r12 = ":(%d*):"
                                                            r25 = r16(r1, r12)
                                                            r16 = {
                                                                r25()
                                                            }
                                                            ReturnVal = state(unpack(r16))
                                                            r16 = allocUpvalue()
                                                            upvalueValues[r16] = ReturnVal
                                                            r25 = upvalueValues[r31]
                                                            r12 = r25
                                                            r25 = 1
                                                            r1 = r25
                                                            r25 = 0
                                                            r4 = r1 < r25
                                                            ReturnVal = 1
                                                            r25 = ReturnVal - r1
                                                            state = 8
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 9 then
                                                    if state <= 8 then
                                                        if state <= 7 then
                                                            if state == 7 then
                                                                r31 = "unpack"
                                                                r29 = _env[r31]
                                                                ReturnVal = r29
                                                                state = 6
                                                            end
                                                        else
                                                            if state == 8 then
                                                                r18 = not r4
                                                                r25 = r25 + r1
                                                                ReturnVal = r25 <= r12
                                                                ReturnVal = r18 and ReturnVal
                                                                r18 = r25 >= r12
                                                                r18 = r4 and r18
                                                                ReturnVal = r18 or ReturnVal
                                                                r18 = (9)
                                                                state = ReturnVal and r18
                                                                ReturnVal = (10)
                                                                state = state or ReturnVal
                                                            end
                                                        end
                                                    else
                                                        if state == 9 then
                                                            r18 = allocUpvalue()
                                                            upvalueValues[r18] = r25
                                                            r24 = "math"
                                                            ReturnVal = _env[r24]
                                                            r24 = "random"
                                                            state = ReturnVal[r24]
                                                            r8 = 100
                                                            r24 = 1
                                                            ReturnVal = state(r24, r8)
                                                            r24 = allocUpvalue()
                                                            upvalueValues[r24] = ReturnVal
                                                            state = upvalueValues[r13]
                                                            r17 = 255
                                                            r8 = 0
                                                            ReturnVal = state(r8, r17)
                                                            r8 = allocUpvalue()
                                                            upvalueValues[r8] = ReturnVal
                                                            state = upvalueValues[r13]
                                                            r9 = upvalueValues[r24]
                                                            r17 = 1
                                                            ReturnVal = state(r17, r9)
                                                            r17 = allocUpvalue()
                                                            upvalueValues[r17] = ReturnVal
                                                            ReturnVal = upvalueValues[r13]
                                                            r10 = 2
                                                            r7 = 1
                                                            r9 = ReturnVal(r7, r10)
                                                            ReturnVal = 1
                                                            state = r9 == ReturnVal
                                                            r9 = allocUpvalue()
                                                            upvalueValues[r9] = state
                                                            r27 = "tostring"
                                                            r22 = _env[r27]
                                                            r19 = upvalueValues[r13]
                                                            r23 = 0
                                                            r20 = 10000
                                                            r11 = {
                                                                r19(r23, r20)
                                                            }
                                                            r27 = r22(unpack(r11))
                                                            r22 = ":"
                                                            r30 = r27 .. r22
                                                            r10 = ":"
                                                            r7 = r10 .. r30
                                                            state = "gsub"
                                                            state = r33[state]
                                                            ReturnVal = ":(%d*):"
                                                            state = state(r33, ReturnVal, r7)
                                                            r7 = allocUpvalue()
                                                            upvalueValues[r7] = state
                                                            r10 = "pcall"
                                                            ReturnVal = _env[r10]
                                                            r30 = createClosure5(46, {
                                                                r13,
                                                                r18,
                                                                r31,
                                                                r26,
                                                                r21,
                                                                r16,
                                                                r9,
                                                                r7,
                                                                r24,
                                                                r17,
                                                                r8,
                                                                r29
                                                            })
                                                            r10 = {
                                                                ReturnVal(r30)
                                                            }
                                                            state = {
                                                                unpack(r10)
                                                            }
                                                            r10 = state
                                                            state = upvalueValues[r9]
                                                            state = state and (11) or (12)
                                                        end
                                                    end
                                                else
                                                    if state <= 10 then
                                                        if state == 10 then
                                                            r12 = upvalueValues[r21]
                                                            state = r12 and (13) or (14)
                                                            r25 = r12
                                                        end
                                                    else
                                                        if state == 11 then
                                                            r30 = upvalueValues[r21]
                                                            state = r30 and (15) or (16)
                                                            ReturnVal = r30
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 16 then
                                                if state <= 14 then
                                                    if state <= 13 then
                                                        if state <= 12 then
                                                            if state == 12 then
                                                                r22 = upvalueValues[r21]
                                                                state = r22 and (17) or (18)
                                                                r30 = r22
                                                            end
                                                        else
                                                            if state == 13 then
                                                                r12 = r2 == r32
                                                                r25 = r12
                                                                state = 14
                                                            end
                                                        end
                                                    else
                                                        if state == 14 then
                                                            upvalueValues[r21] = r25
                                                            state = upvalueValues[r21]
                                                            state = state and (19) or (20)
                                                        end
                                                    end
                                                else
                                                    if state <= 15 then
                                                        if state == 15 then
                                                            r22 = state
                                                            r11 = 1
                                                            r19 = r10[r11]
                                                            r11 = false
                                                            r27 = r19 == r11
                                                            state = r27 and (21) or (22)
                                                            r30 = r27
                                                        end
                                                    else
                                                        if state == 16 then
                                                            upvalueValues[r21] = ReturnVal
                                                            state = 23
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 19 then
                                                    if state <= 18 then
                                                        if state <= 17 then
                                                            if state == 17 then
                                                                r27 = 1
                                                                r22 = r10[r27]
                                                                r30 = r22
                                                                state = 18
                                                            end
                                                        else
                                                            if state == 18 then
                                                                upvalueValues[r21] = r30
                                                                r11 = upvalueValues[r17]
                                                                r23 = 1
                                                                r19 = r11 + r23
                                                                r27 = r10[r19]
                                                                r22 = r2 + r27
                                                                r27 = 256
                                                                state = r22 % r27
                                                                r2 = state
                                                                r19 = upvalueValues[r8]
                                                                r27 = r32 + r19
                                                                r19 = 256
                                                                r22 = r27 % r19
                                                                r32 = r22
                                                                state = 23
                                                            end
                                                        end
                                                    else
                                                        if state == 19 then
                                                            state = 24
                                                        end
                                                    end
                                                else
                                                    if state <= 20 then
                                                        if state == 20 then
                                                            state = true
                                                            state = 25
                                                        end
                                                    else
                                                        if state == 21 then
                                                            r11 = 2
                                                            r19 = r10[r11]
                                                            r11 = upvalueValues[r7]
                                                            r27 = r19 == r11
                                                            r30 = r27
                                                            state = 22
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 32 then
                                            if state <= 27 then
                                                if state <= 24 then
                                                    if state <= 23 then
                                                        if state <= 22 then
                                                            if state == 22 then
                                                                state = r22
                                                                ReturnVal = r30
                                                                state = 16
                                                            end
                                                        else
                                                            if state == 23 then
                                                                r10 = nil
                                                                r17 = releaseUpvalue(r17)
                                                                r9 = releaseUpvalue(r9)
                                                                r7 = releaseUpvalue(r7)
                                                                r18 = releaseUpvalue(r18)
                                                                r24 = releaseUpvalue(r24)
                                                                r8 = releaseUpvalue(r8)
                                                                state = 8
                                                            end
                                                        end
                                                    else
                                                        if state == 24 then
                                                            r13 = releaseUpvalue(r13)
                                                            r15 = releaseUpvalue(r15)
                                                            r21 = releaseUpvalue(r21)
                                                            r14 = releaseUpvalue(r14)
                                                            r16 = releaseUpvalue(r16)
                                                            r29 = releaseUpvalue(r29)
                                                            r26 = releaseUpvalue(r26)
                                                            r31 = releaseUpvalue(r31)
                                                            r15 = allocUpvalue()
                                                            r21 = nil
                                                            upvalueValues[r15] = r21
                                                            r21 = allocUpvalue()
                                                            r26 = nil
                                                            upvalueValues[r21] = r26
                                                            r3 = nil
                                                            r3 = "math"
                                                            r14 = _env[r3]
                                                            r2 = nil
                                                            r2 = {}
                                                            r32 = nil
                                                            r32 = allocUpvalue()
                                                            r3 = "floor"
                                                            r26 = r14[r3]
                                                            r14 = allocUpvalue()
                                                            upvalueValues[r14] = r26
                                                            r13 = "math"
                                                            r3 = _env[r13]
                                                            r13 = "random"
                                                            r26 = r3[r13]
                                                            r6 = nil
                                                            r6 = "table"
                                                            r13 = _env[r6]
                                                            r6 = "remove"
                                                            r3 = r13[r6]
                                                            r29 = "string"
                                                            r6 = _env[r29]
                                                            r28 = nil
                                                            r28 = {}
                                                            r29 = "char"
                                                            r13 = r6[r29]
                                                            r29 = allocUpvalue()
                                                            r6 = 0
                                                            upvalueValues[r29] = r6
                                                            r31 = allocUpvalue()
                                                            r16 = 256
                                                            r6 = 2
                                                            upvalueValues[r31] = r6
                                                            r6 = {}
                                                            upvalueValues[r32] = r2
                                                            r4 = r16
                                                            r16 = 1
                                                            r18 = r16
                                                            r16 = 0
                                                            r24 = r18 < r16
                                                            r33 = nil
                                                            r33 = 1
                                                            r16 = r33 - r18
                                                            r2 = 0
                                                            state = 26
                                                        end
                                                    end
                                                else
                                                    if state <= 26 then
                                                        if state <= 25 then
                                                            if state == 25 then
                                                                state = createClosure2(58, {
                                                                    r15
                                                                })
                                                                r12 = {
                                                                    state()
                                                                }
                                                                ReturnVal = {
                                                                    unpack(r12)
                                                                }
                                                                state = nil
                                                            end
                                                        else
                                                            if state == 26 then
                                                                r8 = not r24
                                                                r16 = r16 + r18
                                                                r33 = r16 <= r4
                                                                r33 = r8 and r33
                                                                r8 = r16 >= r4
                                                                r8 = r24 and r8
                                                                r33 = r8 or r33
                                                                r8 = (27)
                                                                state = r33 and r8
                                                                r33 = (28)
                                                                state = state or r33
                                                            end
                                                        end
                                                    else
                                                        if state == 27 then
                                                            r33 = r16
                                                            r8 = r33
                                                            r28[r33] = r8
                                                            r33 = nil
                                                            state = 26
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 30 then
                                                    if state <= 29 then
                                                        if state <= 28 then
                                                            if state == 28 then
                                                                r16 = #r28
                                                                r4 = 0
                                                                r33 = r16 == r4
                                                                state = 29
                                                            end
                                                        else
                                                            if state == 29 then
                                                                r16 = 1
                                                                r4 = #r28
                                                                r33 = r26(r16, r4)
                                                                r16 = r3(r28, r33)
                                                                r4 = upvalueValues[r32]
                                                                r8 = 1
                                                                r24 = r16 - r8
                                                                r33 = nil
                                                                r18 = r13(r24)
                                                                r4[r16] = r18
                                                                r16 = nil
                                                                state = 30
                                                            end
                                                        end
                                                    else
                                                        if state == 30 then
                                                            r16 = #r28
                                                            r4 = 0
                                                            r33 = r16 == r4
                                                            state = r33 and (31) or (29)
                                                        end
                                                    end
                                                else
                                                    if state <= 31 then
                                                        if state == 31 then
                                                            r16 = allocUpvalue()
                                                            r4 = createClosure2(62, {
                                                                r16,
                                                                r29,
                                                                r31,
                                                                r14
                                                            })
                                                            r33 = {}
                                                            upvalueValues[r16] = r33
                                                            r8 = {}
                                                            r18 = allocUpvalue()
                                                            r33 = allocUpvalue()
                                                            upvalueValues[r33] = r4
                                                            r4 = {}
                                                            r14 = releaseUpvalue(r14)
                                                            upvalueValues[r18] = r4
                                                            r24 = "setmetatable"
                                                            r4 = _env[r24]
                                                            r7 = upvalueValues[r18]
                                                            r10 = "__metatable"
                                                            r9 = "__index"
                                                            r27 = nil
                                                            r17 = {
                                                                [r9] = r7,
                                                                [r10] = r27
                                                            }
                                                            r24 = r4(r8, r17)
                                                            r4 = createClosure2(68, {
                                                                r18,
                                                                r16,
                                                                r32,
                                                                r29,
                                                                r31,
                                                                r33
                                                            })
                                                            r32 = releaseUpvalue(r32)
                                                            upvalueValues[r21] = r24
                                                            r18 = releaseUpvalue(r18)
                                                            r14 = "game"
                                                            r13 = nil
                                                            r6 = nil
                                                            r26 = nil
                                                            r3 = nil
                                                            r2 = nil
                                                            r2 = 20252712674518
                                                            r28 = nil
                                                            r29 = releaseUpvalue(r29)
                                                            r33 = releaseUpvalue(r33)
                                                            r16 = releaseUpvalue(r16)
                                                            r31 = releaseUpvalue(r31)
                                                            upvalueValues[r15] = r4
                                                            r26 = _env[r14]
                                                            r13 = upvalueValues[r21]
                                                            r6 = upvalueValues[r15]
                                                            r31 = "\133_\233Vh\024\197"
                                                            r29 = r6(r31, r2)
                                                            r3 = r13[r29]
                                                            r14 = "GetService"
                                                            r14 = r26[r14]
                                                            r14 = r14(r26, r3)
                                                            r13 = upvalueValues[r21]
                                                            r6 = upvalueValues[r15]
                                                            r2 = 20944825067033
                                                            r31 = "\131(\141\184\220\015MEKJ"
                                                            r29 = r6(r31, r2)
                                                            r3 = r13[r29]
                                                            r26 = "FindFirstChild"
                                                            r26 = r14[r26]
                                                            r26 = r26(r14, r3)
                                                            state = r26 and (32) or (33)
                                                        end
                                                    else
                                                        if state == 32 then
                                                            r3 = "game"
                                                            r14 = _env[r3]
                                                            r6 = upvalueValues[r21]
                                                            r29 = upvalueValues[r15]
                                                            r2 = "5\171D\028\182\008\139"
                                                            r32 = 26949271810309
                                                            r31 = r29(r2, r32)
                                                            r13 = r6[r31]
                                                            r3 = "GetService"
                                                            r3 = r14[r3]
                                                            r3 = r3(r14, r13)
                                                            r13 = upvalueValues[r21]
                                                            r6 = upvalueValues[r15]
                                                            r2 = 19964489426000
                                                            r31 = "\217B\029L*\253\140:C\136"
                                                            r29 = r6(r31, r2)
                                                            r14 = r13[r29]
                                                            r26 = r3[r14]
                                                            r14 = "Destroy"
                                                            r14 = r26[r14]
                                                            r14 = r14(r26)
                                                            state = 33
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 37 then
                                                if state <= 35 then
                                                    if state <= 34 then
                                                        if state <= 33 then
                                                            if state == 33 then
                                                                r14 = "loadstring"
                                                                r26 = _env[r14]
                                                                r13 = "game"
                                                                r3 = _env[r13]
                                                                r29 = upvalueValues[r21]
                                                                r31 = upvalueValues[r15]
                                                                r32 = "#\170\222\247~\227\239\183\162\nS\230\\\200<\179\031\235\127q\182(\220c\172\236\251\nv\225\153q\173f\221[4?1\022g\162\157\174C\030O\029\251\022v-\206\215\139\006S-\244\184\195~\226\223,#]nV\231\1280\24237\209"
                                                                r28 = 32597786819403
                                                                r2 = r31(r32, r28)
                                                                r6 = r29[r2]
                                                                r31 = "HttpGet"
                                                                r31 = r3[r31]
                                                                r29 = true
                                                                r13 = {
                                                                    r31(r3, r6, r29)
                                                                }
                                                                r14 = r26(unpack(r13))
                                                                r26 = r14()
                                                                r13 = upvalueValues[r21]
                                                                r6 = upvalueValues[r15]
                                                                r2 = 27526433190417
                                                                r31 = "\217\163\137L\209\238R\1825\174=#\224MI\185Bb\2012"
                                                                r29 = r6(r31, r2)
                                                                r14 = "CreateWindow"
                                                                r14 = r26[r14]
                                                                r3 = r13[r29]
                                                                r14 = r14(r26, r3)
                                                                r13 = "getgenv"
                                                                r3 = _env[r13]
                                                                r13 = r3()
                                                                r6 = upvalueValues[r21]
                                                                r29 = upvalueValues[r15]
                                                                r32 = 8241768419069
                                                                r2 = "\129\219 \n\174\138`_Z0"
                                                                r31 = r29(r2, r32)
                                                                r3 = r6[r31]
                                                                r6 = nil
                                                                r13[r3] = r6
                                                                r6 = "workspace"
                                                                r13 = _env[r6]
                                                                r29 = upvalueValues[r21]
                                                                r31 = upvalueValues[r15]
                                                                r28 = 14423685700156
                                                                r32 = "zs4\170\152"
                                                                r2 = r31(r32, r28)
                                                                r6 = r29[r2]
                                                                r3 = r13[r6]
                                                                r13 = "GetDescendants"
                                                                r13 = r3[r13]
                                                                r13 = r13(r3)
                                                                r6 = "pairs"
                                                                r3 = _env[r6]
                                                                r2 = {
                                                                    r3(r13)
                                                                }
                                                                r31 = r2[3]
                                                                r29 = r2[2]
                                                                r6 = r2[1]
                                                                state = 34
                                                            end
                                                        else
                                                            if state == 34 then
                                                                r3 = true
                                                                state = r3 and (35) or (36)
                                                            end
                                                        end
                                                    else
                                                        if state == 35 then
                                                            r28 = {
                                                                r6(r29, r31)
                                                            }
                                                            r2 = r28[1]
                                                            r32 = r28[2]
                                                            r31 = r2
                                                            r33 = nil
                                                            r28 = r31 == r33
                                                            state = r28 and (37) or (38)
                                                            r3 = nil
                                                            r3 = r32
                                                        end
                                                    end
                                                else
                                                    if state <= 36 then
                                                        if state == 36 then
                                                            r16 = upvalueValues[r21]
                                                            r4 = upvalueValues[r15]
                                                            r8 = "v$\151\205"
                                                            r17 = 7943773802099
                                                            r18 = r4(r8, r17)
                                                            r33 = r16[r18]
                                                            r4 = upvalueValues[r21]
                                                            r18 = upvalueValues[r15]
                                                            r9 = 3165739517378
                                                            r17 = "\005\219G\145[,\218\224jQ\r\167K\182\193M'\157^\229"
                                                            r8 = r18(r17, r9)
                                                            r16 = r4[r8]
                                                            r18 = upvalueValues[r21]
                                                            r8 = upvalueValues[r15]
                                                            r7 = 10610433577804
                                                            r9 = ",\248\167\228"
                                                            r17 = r8(r9, r7)
                                                            r4 = r18[r17]
                                                            r8 = upvalueValues[r21]
                                                            r17 = upvalueValues[r15]
                                                            r10 = 33920346619315
                                                            r7 = "1hW\215!\019"
                                                            r9 = r17(r7, r10)
                                                            r18 = r8[r9]
                                                            r17 = upvalueValues[r21]
                                                            r9 = upvalueValues[r15]
                                                            r27 = 2284538692647
                                                            r10 = "\227=\030Y\240"
                                                            r7 = r9(r10, r27)
                                                            r8 = r17[r7]
                                                            r7 = upvalueValues[r21]
                                                            r10 = upvalueValues[r15]
                                                            r19 = "\002\252I\005\240\026L/"
                                                            r11 = 14023814011266
                                                            r27 = r10(r19, r11)
                                                            r9 = r7[r27]
                                                            r7 = createClosure3(75, {
                                                                r21,
                                                                r15
                                                            })
                                                            r17 = false
                                                            r28 = {
                                                                [r33] = r16,
                                                                [r4] = r18,
                                                                [r8] = r17,
                                                                [r9] = r7
                                                            }
                                                            r3 = "AddToggle"
                                                            r3 = r14[r3]
                                                            r3 = r3(r14, r28)
                                                            r3 = createClosure0(78, {
                                                                r21,
                                                                r15
                                                            })
                                                            r28 = "Steal"
                                                            _env[r28] = r3
                                                            r16 = upvalueValues[r21]
                                                            r4 = upvalueValues[r15]
                                                            r17 = 24467733638273
                                                            r8 = "\203\028P\241"
                                                            r18 = r4(r8, r17)
                                                            r33 = r16[r18]
                                                            r4 = upvalueValues[r21]
                                                            ReturnVal = {}
                                                            r18 = upvalueValues[r15]
                                                            r9 = 16407050067416
                                                            r17 = "2A3\2286\148)\022\005\020\155"
                                                            r8 = r18(r17, r9)
                                                            r16 = r4[r8]
                                                            r18 = upvalueValues[r21]
                                                            r8 = upvalueValues[r15]
                                                            r7 = 29646156330477
                                                            r9 = "\023Y\214o"
                                                            r17 = r8(r9, r7)
                                                            r4 = r18[r17]
                                                            r8 = upvalueValues[r21]
                                                            r17 = upvalueValues[r15]
                                                            r7 = "\171\129\170CF\161"
                                                            r10 = 29603863000537
                                                            r9 = r17(r7, r10)
                                                            r18 = r8[r9]
                                                            r17 = upvalueValues[r21]
                                                            r9 = upvalueValues[r15]
                                                            r27 = 19825537737743
                                                            r10 = "\183\018\247\018\150"
                                                            r7 = r9(r10, r27)
                                                            r3 = "AddToggle"
                                                            r3 = r14[r3]
                                                            r8 = r17[r7]
                                                            r7 = upvalueValues[r21]
                                                            r10 = upvalueValues[r15]
                                                            r11 = 30348509132596
                                                            r19 = "\007J\2134\176*\243\136"
                                                            r27 = r10(r19, r11)
                                                            r9 = r7[r27]
                                                            r7 = createClosure4(79, {
                                                                r21,
                                                                r15
                                                            })
                                                            r17 = false
                                                            r28 = {
                                                                [r33] = r16,
                                                                [r4] = r18,
                                                                [r8] = r17,
                                                                [r9] = r7
                                                            }
                                                            r3 = r3(r14, r28)
                                                            r3 = createClosure0(82, {
                                                                r21,
                                                                r15
                                                            })
                                                            r28 = "Locked"
                                                            _env[r28] = r3
                                                            r16 = upvalueValues[r21]
                                                            r19 = "\018\222!\168u\254\231\189"
                                                            r13 = nil
                                                            r4 = upvalueValues[r15]
                                                            r8 = "\185b{\180"
                                                            r17 = 29613073380829
                                                            r18 = r4(r8, r17)
                                                            r33 = r16[r18]
                                                            r4 = upvalueValues[r21]
                                                            r18 = upvalueValues[r15]
                                                            r9 = 21274496263858
                                                            r17 = "*^#\t]\"\229\181\176\231\167\188"
                                                            r8 = r18(r17, r9)
                                                            r16 = r4[r8]
                                                            r18 = upvalueValues[r21]
                                                            r8 = upvalueValues[r15]
                                                            r7 = 20838060402151
                                                            r9 = "\140\234\198\139"
                                                            r17 = r8(r9, r7)
                                                            r4 = r18[r17]
                                                            r8 = upvalueValues[r21]
                                                            r17 = upvalueValues[r15]
                                                            r10 = 2584132617395
                                                            r7 = "\234\022Rb\023}"
                                                            r9 = r17(r7, r10)
                                                            r18 = r8[r9]
                                                            r17 = upvalueValues[r21]
                                                            r9 = upvalueValues[r15]
                                                            r3 = "AddToggle"
                                                            r3 = r14[r3]
                                                            r10 = "\012[\153\029\202"
                                                            r27 = 27033410416940
                                                            r7 = r9(r10, r27)
                                                            r8 = r17[r7]
                                                            r7 = upvalueValues[r21]
                                                            r10 = upvalueValues[r15]
                                                            r11 = 8502506721143
                                                            r27 = r10(r19, r11)
                                                            r9 = r7[r27]
                                                            r7 = createClosure5(83, {
                                                                r21,
                                                                r15
                                                            })
                                                            r17 = false
                                                            r28 = {
                                                                [r33] = r16,
                                                                [r4] = r18,
                                                                [r8] = r17,
                                                                [r9] = r7
                                                            }
                                                            r3 = r3(r14, r28)
                                                            r3 = createClosure4(86, {
                                                                r21,
                                                                r15
                                                            })
                                                            r28 = "Cash"
                                                            _env[r28] = r3
                                                            r16 = upvalueValues[r21]
                                                            r4 = upvalueValues[r15]
                                                            r8 = "\153\171\127\138"
                                                            r17 = 12490091697848
                                                            r18 = r4(r8, r17)
                                                            r7 = 6236281916247
                                                            r9 = 28203381601101
                                                            r6 = nil
                                                            r33 = r16[r18]
                                                            r4 = upvalueValues[r21]
                                                            r18 = upvalueValues[r15]
                                                            r17 = "\1511\243\017\191\\m\219\252\213\212\196"
                                                            r8 = r18(r17, r9)
                                                            r16 = r4[r8]
                                                            r18 = upvalueValues[r21]
                                                            r8 = upvalueValues[r15]
                                                            r9 = "MT\195\146"
                                                            r17 = r8(r9, r7)
                                                            r4 = r18[r17]
                                                            r8 = upvalueValues[r21]
                                                            r17 = upvalueValues[r15]
                                                            r7 = "\138l\161\184\026\212"
                                                            r10 = 1894822036338
                                                            r9 = r17(r7, r10)
                                                            r18 = r8[r9]
                                                            r17 = upvalueValues[r21]
                                                            r9 = upvalueValues[r15]
                                                            r27 = 15564318366799
                                                            r10 = "\224\239%\"\024\028\227\145"
                                                            r7 = r9(r10, r27)
                                                            r8 = r17[r7]
                                                            r17 = createClosure2(87, {
                                                                r21,
                                                                r15
                                                            })
                                                            r28 = {
                                                                [r33] = r16,
                                                                [r4] = r18,
                                                                [r8] = r17
                                                            }
                                                            r31 = nil
                                                            r3 = "AddButton"
                                                            r3 = r14[r3]
                                                            r3 = r3(r14, r28)
                                                            r16 = upvalueValues[r21]
                                                            r4 = upvalueValues[r15]
                                                            r17 = 28544368915436
                                                            r8 = "3#J\172"
                                                            r18 = r4(r8, r17)
                                                            r33 = r16[r18]
                                                            r4 = upvalueValues[r21]
                                                            r18 = upvalueValues[r15]
                                                            r17 = "\160\231z\173\242n\219\n"
                                                            r9 = 28673167029287
                                                            r8 = r18(r17, r9)
                                                            r16 = r4[r8]
                                                            r18 = upvalueValues[r21]
                                                            r8 = upvalueValues[r15]
                                                            r7 = 31648500840849
                                                            r9 = "\145`\176\163"
                                                            r17 = r8(r9, r7)
                                                            r3 = "AddButton"
                                                            r3 = r14[r3]
                                                            r4 = r18[r17]
                                                            r8 = upvalueValues[r21]
                                                            r17 = upvalueValues[r15]
                                                            r7 = "\186\162?k\027G"
                                                            r10 = 34147523296797
                                                            r9 = r17(r7, r10)
                                                            r18 = r8[r9]
                                                            r17 = upvalueValues[r21]
                                                            r9 = upvalueValues[r15]
                                                            r27 = 5766701353597
                                                            r10 = "Y\142\142\226\191{O\224"
                                                            r7 = r9(r10, r27)
                                                            r8 = r17[r7]
                                                            r17 = createClosure2(97, {
                                                                r21,
                                                                r15
                                                            })
                                                            r28 = {
                                                                [r33] = r16,
                                                                [r4] = r18,
                                                                [r8] = r17
                                                            }
                                                            r3 = r3(r14, r28)
                                                            r16 = upvalueValues[r21]
                                                            r4 = upvalueValues[r15]
                                                            r8 = "\146x\023\241"
                                                            r17 = 20033664787568
                                                            r18 = r4(r8, r17)
                                                            r33 = r16[r18]
                                                            r4 = upvalueValues[r21]
                                                            r18 = upvalueValues[r15]
                                                            r9 = 18858308723277
                                                            r17 = "~\219\215\225NJ\241U\246\209\203\238TU\234`a\239"
                                                            r8 = r18(r17, r9)
                                                            r16 = r4[r8]
                                                            r3 = "AddLabel"
                                                            r3 = r14[r3]
                                                            r29 = nil
                                                            r28 = {
                                                                [r33] = r16
                                                            }
                                                            r3 = r3(r14, r28)
                                                            r3 = "Init"
                                                            r3 = r26[r3]
                                                            r3 = r3(r26)
                                                            r33 = "game"
                                                            r28 = _env[r33]
                                                            r4 = upvalueValues[r21]
                                                            r18 = upvalueValues[r15]
                                                            r9 = 12858260379491
                                                            r17 = "\205\128\178\232-\219\231\r\217\182pBT\147\131\184\218n\175,_\255"
                                                            r8 = r18(r17, r9)
                                                            r16 = r4[r8]
                                                            r33 = "GetService"
                                                            r33 = r28[r33]
                                                            r33 = r33(r28, r16)
                                                            r16 = upvalueValues[r21]
                                                            r4 = upvalueValues[r15]
                                                            r8 = "s4\000+K\145\017\131\n\016}d,\207\186`\167M!\192\021"
                                                            r17 = 8670429188037
                                                            r18 = r4(r8, r17)
                                                            r26 = nil
                                                            r28 = r16[r18]
                                                            r14 = nil
                                                            r3 = r33[r28]
                                                            r33 = createClosure2(98, {})
                                                            r15 = releaseUpvalue(r15)
                                                            r28 = "Connect"
                                                            r28 = r3[r28]
                                                            r21 = releaseUpvalue(r21)
                                                            r28 = r28(r3, r33)
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 37 then
                                                            r3 = nil
                                                            state = 36
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 40 then
                                                    if state <= 39 then
                                                        if state <= 38 then
                                                            if state == 38 then
                                                                r8 = upvalueValues[r21]
                                                                r17 = upvalueValues[r15]
                                                                r7 = "\193\224\162:"
                                                                r10 = 5490338990588
                                                                r9 = r17(r7, r10)
                                                                r18 = r8[r9]
                                                                r4 = r3[r18]
                                                                r8 = upvalueValues[r21]
                                                                r17 = upvalueValues[r15]
                                                                r7 = "\252\187M#\015\209\004\220"
                                                                r10 = 16509543308807
                                                                r9 = r17(r7, r10)
                                                                r18 = r8[r9]
                                                                r16 = r4 == r18
                                                                r33 = state
                                                                state = r16 and (39) or (40)
                                                                r28 = r16
                                                            end
                                                        else
                                                            if state == 39 then
                                                                r8 = upvalueValues[r21]
                                                                r17 = upvalueValues[r15]
                                                                r10 = 30106079016643
                                                                r7 = " \201\207\024\217\146E"
                                                                r9 = r17(r7, r10)
                                                                r18 = r8[r9]
                                                                r4 = r3[r18]
                                                                r18 = true
                                                                r16 = r4 == r18
                                                                r28 = r16
                                                                state = 40
                                                            end
                                                        end
                                                    else
                                                        if state == 40 then
                                                            state = r33
                                                            state = r28 and (41) or (42)
                                                        end
                                                    end
                                                else
                                                    if state <= 41 then
                                                        if state == 41 then
                                                            r33 = "getgenv"
                                                            r28 = _env[r33]
                                                            r33 = r28()
                                                            r16 = upvalueValues[r21]
                                                            r4 = upvalueValues[r15]
                                                            r17 = 18867400254033
                                                            r8 = "(zqu\2466Q\25059"
                                                            r18 = r4(r8, r17)
                                                            r28 = r16[r18]
                                                            r8 = upvalueValues[r21]
                                                            r17 = upvalueValues[r15]
                                                            r10 = 32686320286580
                                                            r7 = "\004&\226O\001!"
                                                            r9 = r17(r7, r10)
                                                            r18 = r8[r9]
                                                            r4 = r3[r18]
                                                            r8 = upvalueValues[r21]
                                                            r17 = upvalueValues[r15]
                                                            r7 = "\166\180S\137\183\136"
                                                            r10 = 33675226611009
                                                            r9 = r17(r7, r10)
                                                            r18 = r8[r9]
                                                            r16 = r4[r18]
                                                            r33[r28] = r16
                                                            state = 42
                                                        end
                                                    else
                                                        if state == 42 then
                                                            r3 = nil
                                                            state = 34
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure1 entry 9540439 -> 43, states 43-43
                                    if state == 43 then -- entry 9540439 -> 43
                                        ReturnVal = "error"
                                        state = _env[ReturnVal]
                                        r5 = "Tamper Detected!"
                                        ReturnVal = state(r5)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                if state <= 44 then
                                    -- createClosure1 entry 6553318 -> 44, states 44-44
                                    if state == 44 then -- entry 6553318 -> 44
                                        state = true
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure1 entry 5309611 -> 45, states 45-45
                                    if state == 45 then -- entry 5309611 -> 45
                                        r21 = "TfTHk7FSZYZ"
                                        r26 = 12477629
                                        r5 = r21 ^ r26
                                        ReturnVal = 14529739
                                        state = ReturnVal - r5
                                        r5 = state
                                        ReturnVal = "IFlLMI"
                                        state = ReturnVal / r5
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 61 then
                                if state <= 57 then
                                    -- createClosure5 entry 8697401 -> 46, states 46-57
                                    if state <= 51 then
                                        if state <= 48 then
                                            if state <= 47 then
                                                if state <= 46 then
                                                    if state == 46 then -- entry 8697401 -> 46
                                                        r21 = upvalueValues[upvalues[1]]
                                                        r14 = 2
                                                        r15 = 1
                                                        r26 = r21(r15, r14)
                                                        r21 = 1
                                                        r5 = r26 == r21
                                                        state = r5 and (47) or (48)
                                                        ReturnVal = r5
                                                    end
                                                else
                                                    if state == 47 then
                                                        state = ReturnVal and (49) or (50)
                                                    end
                                                end
                                            else
                                                if state == 48 then
                                                    r21 = upvalueValues[upvalues[2]]
                                                    r26 = upvalueValues[upvalues[3]]
                                                    r5 = r21 == r26
                                                    ReturnVal = r5
                                                    state = 47
                                                end
                                            end
                                        else
                                            if state <= 50 then
                                                if state <= 49 then
                                                    if state == 49 then
                                                        r29 = createClosure2(99, {})
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r5 = upvalueValues[upvalues[4]]
                                                        r15 = "tostring"
                                                        r26 = _env[r15]
                                                        r6 = "pcall"
                                                        r13 = _env[r6]
                                                        r6 = {
                                                            r13(r29)
                                                        }
                                                        r3 = {
                                                            unpack(r6)
                                                        }
                                                        r13 = 2
                                                        r14 = r3[r13]
                                                        r15 = r26(r14)
                                                        r26 = ":(%d*):"
                                                        r21 = r5(r15, r26)
                                                        r5 = {
                                                            r21()
                                                        }
                                                        ReturnVal = state(unpack(r5))
                                                        r5 = ReturnVal
                                                        r21 = upvalueValues[upvalues[5]]
                                                        state = r21 and (51) or (52)
                                                        ReturnVal = r21
                                                    end
                                                else
                                                    if state == 50 then
                                                        state = upvalueValues[upvalues[7]]
                                                        state = state and (53) or (54)
                                                    end
                                                end
                                            else
                                                if state == 51 then
                                                    r26 = upvalueValues[upvalues[6]]
                                                    r21 = r26 == r5
                                                    ReturnVal = r21
                                                    state = 52
                                                end
                                            end
                                        end
                                    else
                                        if state <= 54 then
                                            if state <= 53 then
                                                if state <= 52 then
                                                    if state == 52 then
                                                        upvalueValues[upvalues[5]] = ReturnVal
                                                        r5 = nil
                                                        state = 50
                                                    end
                                                else
                                                    if state == 53 then
                                                        r5 = "error"
                                                        state = _env[r5]
                                                        r21 = upvalueValues[upvalues[8]]
                                                        r26 = 0
                                                        r5 = state(r21, r26)
                                                        state = 54
                                                    end
                                                end
                                            else
                                                if state == 54 then
                                                    state = {}
                                                    r5 = state
                                                    r26 = upvalueValues[upvalues[9]]
                                                    r15 = r26
                                                    r26 = 1
                                                    r14 = r26
                                                    r26 = 0
                                                    r3 = r14 < r26
                                                    r21 = 1
                                                    r26 = r21 - r14
                                                    state = 55
                                                end
                                            end
                                        else
                                            if state <= 56 then
                                                if state <= 55 then
                                                    if state == 55 then
                                                        r13 = not r3
                                                        r26 = r26 + r14
                                                        r21 = r26 <= r15
                                                        r21 = r13 and r21
                                                        r13 = r26 >= r15
                                                        r13 = r3 and r13
                                                        r21 = r13 or r21
                                                        r13 = (56)
                                                        state = r21 and r13
                                                        r21 = (57)
                                                        state = state or r21
                                                    end
                                                else
                                                    if state == 56 then
                                                        state = upvalueValues[upvalues[1]]
                                                        r21 = r26
                                                        r29 = 255
                                                        r6 = 0
                                                        r13 = state(r6, r29)
                                                        r5[r21] = r13
                                                        r21 = nil
                                                        state = 55
                                                    end
                                                end
                                            else
                                                if state == 57 then
                                                    state = upvalueValues[upvalues[10]]
                                                    r21 = upvalueValues[upvalues[11]]
                                                    r5[state] = r21
                                                    state = upvalueValues[upvalues[12]]
                                                    r21 = {
                                                        state(r5)
                                                    }
                                                    ReturnVal = {
                                                        unpack(r21)
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure2 entry 3959451 -> 58, states 58-61
                                    if state <= 59 then
                                        if state <= 58 then
                                            if state == 58 then -- entry 3959451 -> 58
                                                state = 59
                                            end
                                        else
                                            if state == 59 then
                                                state = true
                                                state = state and (60) or (61)
                                            end
                                        end
                                    else
                                        if state <= 60 then
                                            if state == 60 then
                                                ReturnVal = "l2"
                                                state = _env[ReturnVal]
                                                r5 = "l1"
                                                ReturnVal = _env[r5]
                                                r5 = "l1"
                                                _env[r5] = state
                                                r5 = "l2"
                                                _env[r5] = ReturnVal
                                                r5 = upvalueValues[upvalues[1]]
                                                r21 = r5()
                                                state = 59
                                            end
                                        else
                                            if state == 61 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 67 then
                                    -- createClosure2 entry 13582477 -> 62, states 62-67
                                    if state <= 64 then
                                        if state <= 63 then
                                            if state <= 62 then
                                                if state == 62 then -- entry 13582477 -> 62
                                                    r5 = upvalueValues[upvalues[1]]
                                                    ReturnVal = #r5
                                                    r5 = 0
                                                    state = ReturnVal == r5
                                                    state = state and (63) or (64)
                                                end
                                            else
                                                if state == 63 then
                                                    r21 = upvalueValues[upvalues[2]]
                                                    r26 = 109
                                                    r5 = r21 * r26
                                                    r21 = 20275759883489
                                                    ReturnVal = r5 + r21
                                                    r5 = 35184372088832
                                                    state = ReturnVal % r5
                                                    upvalueValues[upvalues[2]] = state
                                                    r5 = upvalueValues[upvalues[3]]
                                                    r21 = 1
                                                    ReturnVal = r5 ~= r21
                                                    state = 65
                                                end
                                            end
                                        else
                                            if state == 64 then
                                                r26 = "table"
                                                r21 = _env[r26]
                                                r26 = "remove"
                                                r5 = r21[r26]
                                                r26 = upvalueValues[upvalues[1]]
                                                r21 = {
                                                    r5(r26)
                                                }
                                                ReturnVal = {
                                                    unpack(r21)
                                                }
                                                state = nil
                                            end
                                        end
                                    else
                                        if state <= 66 then
                                            if state <= 65 then
                                                if state == 65 then
                                                    r21 = upvalueValues[upvalues[3]]
                                                    r26 = 142
                                                    r5 = r21 * r26
                                                    r21 = 257
                                                    ReturnVal = r5 % r21
                                                    upvalueValues[upvalues[3]] = ReturnVal
                                                    state = 66
                                                end
                                            else
                                                if state == 66 then
                                                    r21 = upvalueValues[upvalues[3]]
                                                    r26 = 1
                                                    r5 = r21 ~= r26
                                                    state = r5 and (67) or (65)
                                                end
                                            end
                                        else
                                            if state == 67 then
                                                r21 = upvalueValues[upvalues[3]]
                                                r26 = 32
                                                r5 = r21 % r26
                                                r29 = 2
                                                r15 = upvalueValues[upvalues[4]]
                                                r13 = upvalueValues[upvalues[2]]
                                                r33 = upvalueValues[upvalues[3]]
                                                r28 = r33 - r5
                                                r33 = 32
                                                r32 = r28 / r33
                                                r2 = 13
                                                r31 = r2 - r32
                                                r6 = r29 ^ r31
                                                r3 = r13 / r6
                                                r14 = r15(r3)
                                                r15 = 4294967296
                                                r26 = r14 % r15
                                                r14 = 2
                                                r6 = 1
                                                r15 = r14 ^ r5
                                                r21 = r26 / r15
                                                r15 = upvalueValues[upvalues[4]]
                                                r13 = r21 % r6
                                                r29 = 256
                                                r6 = 4294967296
                                                r3 = r13 * r6
                                                r14 = r15(r3)
                                                r15 = upvalueValues[upvalues[4]]
                                                r3 = r15(r21)
                                                r26 = r14 + r3
                                                r13 = 65536
                                                r14 = 65536
                                                r15 = r26 % r14
                                                r3 = r26 - r15
                                                r14 = r3 / r13
                                                r13 = 256
                                                r3 = r15 % r13
                                                r2 = 256
                                                r5 = nil
                                                r6 = r15 - r3
                                                r13 = r6 / r29
                                                r29 = 256
                                                r21 = nil
                                                r26 = nil
                                                r6 = r14 % r29
                                                r31 = r14 - r6
                                                r29 = r31 / r2
                                                r15 = nil
                                                r14 = nil
                                                r31 = {
                                                    r3,
                                                    r13,
                                                    r6,
                                                    r29
                                                }
                                                r6 = nil
                                                r29 = nil
                                                r13 = nil
                                                upvalueValues[upvalues[1]] = r31
                                                r3 = nil
                                                state = 64
                                            end
                                        end
                                    end
                                else
                                    -- createClosure2 entry 5827898 -> 68, states 68-74
                                    if state <= 71 then
                                        if state <= 69 then
                                            if state <= 68 then
                                                if state == 68 then -- entry 5827898 -> 68
                                                    r21 = args[2]
                                                    state = upvalueValues[upvalues[1]]
                                                    r26 = state
                                                    r5 = args[1]
                                                    state = r26[r21]
                                                    state = state and (69) or (70)
                                                end
                                            else
                                                if state == 69 then
                                                    state = 71
                                                end
                                            end
                                        else
                                            if state <= 70 then
                                                if state == 70 then
                                                    state = {}
                                                    upvalueValues[upvalues[2]] = state
                                                    ReturnVal = upvalueValues[upvalues[3]]
                                                    r15 = ReturnVal
                                                    r14 = 35184372088832
                                                    ReturnVal = r21 % r14
                                                    upvalueValues[upvalues[4]] = ReturnVal
                                                    r31 = 1
                                                    r2 = r31
                                                    r13 = 255
                                                    r3 = r21 % r13
                                                    r13 = 2
                                                    r14 = r3 + r13
                                                    upvalueValues[upvalues[5]] = r14
                                                    r6 = "string"
                                                    r13 = _env[r6]
                                                    r6 = "len"
                                                    r3 = r13[r6]
                                                    r13 = r3(r5)
                                                    r3 = ""
                                                    r26[r21] = r3
                                                    r31 = 0
                                                    r32 = r2 < r31
                                                    r6 = 1
                                                    r31 = r6 - r2
                                                    r29 = r13
                                                    r3 = 54
                                                    state = 72
                                                end
                                            else
                                                if state == 71 then
                                                    ReturnVal = {
                                                        r21
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        if state <= 73 then
                                            if state <= 72 then
                                                if state == 72 then
                                                    r28 = not r32
                                                    r31 = r31 + r2
                                                    r6 = r31 <= r29
                                                    r6 = r28 and r6
                                                    r28 = r31 >= r29
                                                    r28 = r32 and r28
                                                    r6 = r28 or r6
                                                    r28 = (73)
                                                    state = r6 and r28
                                                    r6 = (74)
                                                    state = state or r6
                                                end
                                            else
                                                if state == 73 then
                                                    r1 = "string"
                                                    r12 = _env[r1]
                                                    r6 = r31
                                                    r1 = "byte"
                                                    r25 = r12[r1]
                                                    r12 = r25(r5, r6)
                                                    r25 = upvalueValues[upvalues[6]]
                                                    r1 = r25()
                                                    r16 = r12 + r1
                                                    r33 = r16 + r3
                                                    r16 = 256
                                                    r28 = r33 % r16
                                                    r3 = r28
                                                    r16 = r26[r21]
                                                    r1 = 1
                                                    r12 = r3 + r1
                                                    r6 = nil
                                                    r25 = r15[r12]
                                                    r33 = r16 .. r25
                                                    r26[r21] = r33
                                                    state = 72
                                                end
                                            end
                                        else
                                            if state == 74 then
                                                r13 = nil
                                                r3 = nil
                                                r15 = nil
                                                state = 71
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 82 then
                            if state <= 78 then
                                if state <= 77 then
                                    -- createClosure3 entry 2592812 -> 75, states 75-77
                                    if state <= 76 then
                                        if state <= 75 then
                                            if state == 75 then -- entry 2592812 -> 75
                                                r5 = args[1]
                                                ReturnVal = "_G"
                                                state = _env[ReturnVal]
                                                r21 = upvalueValues[upvalues[1]]
                                                r26 = upvalueValues[upvalues[2]]
                                                r3 = 18632197775844
                                                r14 = "\230\015'0\130"
                                                r15 = r26(r14, r3)
                                                ReturnVal = r21[r15]
                                                r21 = r5
                                                state[ReturnVal] = r21
                                                ReturnVal = "print"
                                                state = _env[ReturnVal]
                                                r26 = upvalueValues[upvalues[1]]
                                                r15 = upvalueValues[upvalues[2]]
                                                r13 = 33259542789247
                                                r3 = "\186\130|\022\177\014T"
                                                r14 = r15(r3, r13)
                                                r21 = r26[r14]
                                                ReturnVal = state(r21, r5)
                                                state = r5 and (76) or (77)
                                            end
                                        else
                                            if state == 76 then
                                                ReturnVal = "Steal"
                                                state = _env[ReturnVal]
                                                ReturnVal = state()
                                                state = 77
                                            end
                                        end
                                    else
                                        if state == 77 then
                                            r5 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure0 entry 16364431 -> 78, states 78-78
                                    if state == 78 then -- entry 16364431 -> 78
                                        ReturnVal = "spawn"
                                        state = _env[ReturnVal]
                                        r5 = createClosure4(100, {
                                            upvalues[1],
                                            upvalues[2]
                                        })
                                        ReturnVal = state(r5)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                if state <= 81 then
                                    -- createClosure4 entry 6838587 -> 79, states 79-81
                                    if state <= 80 then
                                        if state <= 79 then
                                            if state == 79 then -- entry 6838587 -> 79
                                                ReturnVal = "_G"
                                                state = _env[ReturnVal]
                                                r5 = args[1]
                                                r21 = upvalueValues[upvalues[1]]
                                                r26 = upvalueValues[upvalues[2]]
                                                r3 = 23281464814169
                                                r14 = "!U\167\251E\216"
                                                r15 = r26(r14, r3)
                                                ReturnVal = r21[r15]
                                                r21 = r5
                                                state[ReturnVal] = r21
                                                ReturnVal = "print"
                                                state = _env[ReturnVal]
                                                r26 = upvalueValues[upvalues[1]]
                                                r15 = upvalueValues[upvalues[2]]
                                                r13 = 14587860654729
                                                r3 = "\0302\217\156\140\020%\170"
                                                r14 = r15(r3, r13)
                                                r21 = r26[r14]
                                                ReturnVal = state(r21, r5)
                                                state = r5 and (80) or (81)
                                            end
                                        else
                                            if state == 80 then
                                                ReturnVal = "Locked"
                                                state = _env[ReturnVal]
                                                ReturnVal = state()
                                                state = 81
                                            end
                                        end
                                    else
                                        if state == 81 then
                                            r5 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure0 entry 13528938 -> 82, states 82-82
                                    if state == 82 then -- entry 13528938 -> 82
                                        r5 = createClosure1(104, {
                                            upvalues[1],
                                            upvalues[2]
                                        })
                                        ReturnVal = "spawn"
                                        state = _env[ReturnVal]
                                        ReturnVal = state(r5)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 86 then
                                if state <= 85 then
                                    -- createClosure5 entry 3767031 -> 83, states 83-85
                                    if state <= 84 then
                                        if state <= 83 then
                                            if state == 83 then -- entry 3767031 -> 83
                                                r5 = args[1]
                                                ReturnVal = "_G"
                                                state = _env[ReturnVal]
                                                r21 = upvalueValues[upvalues[1]]
                                                r26 = upvalueValues[upvalues[2]]
                                                r3 = 30061654177454
                                                r14 = "h\135\198\026"
                                                r15 = r26(r14, r3)
                                                ReturnVal = r21[r15]
                                                r21 = r5
                                                state[ReturnVal] = r21
                                                ReturnVal = "print"
                                                state = _env[ReturnVal]
                                                r26 = upvalueValues[upvalues[1]]
                                                r15 = upvalueValues[upvalues[2]]
                                                r13 = 12533206783692
                                                r3 = "\163K=\159\006\127"
                                                r14 = r15(r3, r13)
                                                r21 = r26[r14]
                                                ReturnVal = state(r21, r5)
                                                state = r5 and (84) or (85)
                                            end
                                        else
                                            if state == 84 then
                                                ReturnVal = "Cash"
                                                state = _env[ReturnVal]
                                                ReturnVal = state()
                                                state = 85
                                            end
                                        end
                                    else
                                        if state == 85 then
                                            r5 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure4 entry 8882122 -> 86, states 86-86
                                    if state == 86 then -- entry 8882122 -> 86
                                        ReturnVal = "spawn"
                                        state = _env[ReturnVal]
                                        r5 = createClosure2(108, {
                                            upvalues[1],
                                            upvalues[2]
                                        })
                                        ReturnVal = state(r5)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure2 entry 1595382 -> 87, states 87-96
                                if state <= 91 then
                                    if state <= 89 then
                                        if state <= 88 then
                                            if state <= 87 then
                                                if state == 87 then -- entry 1595382 -> 87
                                                    ReturnVal = "pairs"
                                                    state = _env[ReturnVal]
                                                    r14 = "workspace"
                                                    r15 = _env[r14]
                                                    r3 = upvalueValues[upvalues[1]]
                                                    r13 = upvalueValues[upvalues[2]]
                                                    r29 = "M\208\250o\129"
                                                    r31 = 34042069663212
                                                    r6 = r13(r29, r31)
                                                    r14 = r3[r6]
                                                    r26 = r15[r14]
                                                    r14 = "GetDescendants"
                                                    r14 = r26[r14]
                                                    r15 = {
                                                        r14(r26)
                                                    }
                                                    r26 = {
                                                        state(unpack(r15))
                                                    }
                                                    r21 = r26[3]
                                                    r5 = r26[2]
                                                    ReturnVal = r26[1]
                                                    r26 = ReturnVal
                                                    state = 88
                                                end
                                            else
                                                if state == 88 then
                                                    state = true
                                                    state = state and (89) or (90)
                                                end
                                            end
                                        else
                                            if state == 89 then
                                                r14 = {
                                                    r26(r5, r21)
                                                }
                                                ReturnVal = r14[2]
                                                state = nil
                                                r15 = state
                                                state = r14[1]
                                                r21 = state
                                                r3 = nil
                                                r14 = r21 == r3
                                                state = r14 and (91) or (92)
                                                r15 = ReturnVal
                                            end
                                        end
                                    else
                                        if state <= 90 then
                                            if state == 90 then
                                                r5 = nil
                                                r21 = nil
                                                r26 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        else
                                            if state == 91 then
                                                r15 = nil
                                                state = 90
                                            end
                                        end
                                    end
                                else
                                    if state <= 94 then
                                        if state <= 93 then
                                            if state <= 92 then
                                                if state == 92 then
                                                    r3 = state
                                                    r31 = upvalueValues[upvalues[1]]
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r28 = "\223;8\025"
                                                    r33 = 11648219043120
                                                    r32 = r2(r28, r33)
                                                    r29 = r31[r32]
                                                    r6 = r15[r29]
                                                    r31 = upvalueValues[upvalues[1]]
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r33 = 28361885463447
                                                    r28 = "S\155\244\003\180Y\220\137\201\025\206\020;\186"
                                                    r32 = r2(r28, r33)
                                                    r29 = r31[r32]
                                                    r13 = r6 == r29
                                                    state = r13 and (93) or (94)
                                                    r14 = r13
                                                end
                                            else
                                                if state == 93 then
                                                    state = r3
                                                    state = r14 and (95) or (96)
                                                end
                                            end
                                        else
                                            if state == 94 then
                                                r29 = "string"
                                                r6 = _env[r29]
                                                r31 = upvalueValues[upvalues[1]]
                                                r2 = upvalueValues[upvalues[2]]
                                                r33 = 30869226289190
                                                r28 = "\003\028r\204"
                                                r32 = r2(r28, r33)
                                                r29 = r31[r32]
                                                r13 = r6[r29]
                                                r2 = upvalueValues[upvalues[1]]
                                                r32 = upvalueValues[upvalues[2]]
                                                r16 = 4472704763938
                                                r33 = "\207\251.<"
                                                r28 = r32(r33, r16)
                                                r31 = r2[r28]
                                                r29 = r15[r31]
                                                r2 = upvalueValues[upvalues[1]]
                                                r32 = upvalueValues[upvalues[2]]
                                                r16 = 66037743646
                                                r33 = "\222\230\\3"
                                                r28 = r32(r33, r16)
                                                r31 = r2[r28]
                                                r6 = r13(r29, r31)
                                                r14 = r6
                                                state = 93
                                            end
                                        end
                                    else
                                        if state <= 95 then
                                            if state == 95 then
                                                r14 = "Destroy"
                                                r14 = r15[r14]
                                                r14 = r14(r15)
                                                state = 96
                                            end
                                        else
                                            if state == 96 then
                                                r15 = nil
                                                state = 88
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 143 then
                        if state <= 103 then
                            if state <= 98 then
                                if state <= 97 then
                                    -- createClosure2 entry 8789513 -> 97, states 97-97
                                    if state == 97 then -- entry 8789513 -> 97
                                        r5 = "game"
                                        ReturnVal = _env[r5]
                                        r26 = upvalueValues[upvalues[1]]
                                        r15 = upvalueValues[upvalues[2]]
                                        r13 = 6839216753776
                                        r3 = "\191:\163\143\2508\210Jz\149\\Z\208~C\180"
                                        r14 = r15(r3, r13)
                                        r21 = r26[r14]
                                        r5 = "GetService"
                                        r5 = ReturnVal[r5]
                                        r5 = r5(ReturnVal, r21)
                                        r21 = upvalueValues[upvalues[1]]
                                        r26 = upvalueValues[upvalues[2]]
                                        r14 = "$\137\192D\182\026\148\028\146\157\196"
                                        r3 = 8851565695001
                                        r15 = r26(r14, r3)
                                        ReturnVal = r21[r15]
                                        state = r5[ReturnVal]
                                        r5 = createClosure2(112, {
                                            upvalues[1],
                                            upvalues[2]
                                        })
                                        ReturnVal = "Connect"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state, r5)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure2 entry 15557732 -> 98, states 98-98
                                    if state == 98 then -- entry 15557732 -> 98
                                        r5 = args[1]
                                        ReturnVal = "fireproximityprompt"
                                        state = _env[ReturnVal]
                                        ReturnVal = state(r5)
                                        r5 = nil
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                if state <= 99 then
                                    -- createClosure2 entry 10354202 -> 99, states 99-99
                                    if state == 99 then -- entry 10354202 -> 99
                                        r26 = 14934802
                                        r21 = "eciS"
                                        r5 = r21 ^ r26
                                        ReturnVal = 9752963
                                        state = ReturnVal - r5
                                        r5 = state
                                        ReturnVal = "2VvOjAe7"
                                        state = ReturnVal / r5
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure4 entry 8160143 -> 100, states 100-103
                                    if state <= 101 then
                                        if state <= 100 then
                                            if state == 100 then -- entry 8160143 -> 100
                                                ReturnVal = "_G"
                                                state = _env[ReturnVal]
                                                r5 = upvalueValues[upvalues[1]]
                                                r21 = upvalueValues[upvalues[2]]
                                                r14 = 8827313197070
                                                r15 = "\029\"\143\179&"
                                                r26 = r21(r15, r14)
                                                ReturnVal = r5[r26]
                                                r5 = true
                                                state[ReturnVal] = r5
                                                state = 101
                                            end
                                        else
                                            if state == 101 then
                                                r5 = "_G"
                                                ReturnVal = _env[r5]
                                                r21 = upvalueValues[upvalues[1]]
                                                r26 = upvalueValues[upvalues[2]]
                                                r3 = 7738607570451
                                                r14 = "\1849\139$\223"
                                                r15 = r26(r14, r3)
                                                r5 = r21[r15]
                                                state = ReturnVal[r5]
                                                state = state and (102) or (103)
                                            end
                                        end
                                    else
                                        if state <= 102 then
                                            if state == 102 then
                                                ReturnVal = "wait"
                                                state = _env[ReturnVal]
                                                ReturnVal = state()
                                                r5 = createClosure2(113, {
                                                    upvalues[1],
                                                    upvalues[2]
                                                })
                                                ReturnVal = "pcall"
                                                state = _env[ReturnVal]
                                                ReturnVal = state(r5)
                                                state = 101
                                            end
                                        else
                                            if state == 103 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 111 then
                                if state <= 107 then
                                    -- createClosure1 entry 9799939 -> 104, states 104-107
                                    if state <= 105 then
                                        if state <= 104 then
                                            if state == 104 then -- entry 9799939 -> 104
                                                ReturnVal = "_G"
                                                state = _env[ReturnVal]
                                                r5 = upvalueValues[upvalues[1]]
                                                r21 = upvalueValues[upvalues[2]]
                                                r14 = 27363314872774
                                                r15 = "S\234>\014O\201"
                                                r26 = r21(r15, r14)
                                                ReturnVal = r5[r26]
                                                r5 = true
                                                state[ReturnVal] = r5
                                                state = 105
                                            end
                                        else
                                            if state == 105 then
                                                r5 = "_G"
                                                ReturnVal = _env[r5]
                                                r21 = upvalueValues[upvalues[1]]
                                                r26 = upvalueValues[upvalues[2]]
                                                r3 = 25776298962659
                                                r14 = "\235\232i\184/\234"
                                                r15 = r26(r14, r3)
                                                r5 = r21[r15]
                                                state = ReturnVal[r5]
                                                state = state and (106) or (107)
                                            end
                                        end
                                    else
                                        if state <= 106 then
                                            if state == 106 then
                                                r5 = createClosure1(144, {
                                                    upvalues[1],
                                                    upvalues[2]
                                                })
                                                ReturnVal = "wait"
                                                state = _env[ReturnVal]
                                                ReturnVal = state()
                                                ReturnVal = "pcall"
                                                state = _env[ReturnVal]
                                                ReturnVal = state(r5)
                                                state = 105
                                            end
                                        else
                                            if state == 107 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure2 entry 4039348 -> 108, states 108-111
                                    if state <= 109 then
                                        if state <= 108 then
                                            if state == 108 then -- entry 4039348 -> 108
                                                ReturnVal = "_G"
                                                state = _env[ReturnVal]
                                                r5 = upvalueValues[upvalues[1]]
                                                r21 = upvalueValues[upvalues[2]]
                                                r15 = "\"P\202,"
                                                r14 = 20414944617762
                                                r26 = r21(r15, r14)
                                                ReturnVal = r5[r26]
                                                r5 = true
                                                state[ReturnVal] = r5
                                                state = 109
                                            end
                                        else
                                            if state == 109 then
                                                r5 = "_G"
                                                ReturnVal = _env[r5]
                                                r21 = upvalueValues[upvalues[1]]
                                                r26 = upvalueValues[upvalues[2]]
                                                r14 = "\031x\016k"
                                                r3 = 24589102427322
                                                r15 = r26(r14, r3)
                                                r5 = r21[r15]
                                                state = ReturnVal[r5]
                                                state = state and (110) or (111)
                                            end
                                        end
                                    else
                                        if state <= 110 then
                                            if state == 110 then
                                                ReturnVal = "wait"
                                                state = _env[ReturnVal]
                                                ReturnVal = state()
                                                r5 = createClosure5(154, {
                                                    upvalues[1],
                                                    upvalues[2]
                                                })
                                                ReturnVal = "pcall"
                                                state = _env[ReturnVal]
                                                ReturnVal = state(r5)
                                                state = 109
                                            end
                                        else
                                            if state == 111 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 112 then
                                    -- createClosure2 entry 4428124 -> 112, states 112-112
                                    if state == 112 then -- entry 4428124 -> 112
                                        r26 = "game"
                                        r21 = _env[r26]
                                        r15 = upvalueValues[upvalues[1]]
                                        r14 = upvalueValues[upvalues[2]]
                                        r6 = 30589785585572
                                        r13 = "]\226\018\130\199E\025"
                                        r3 = r14(r13, r6)
                                        r26 = r15[r3]
                                        r5 = r21[r26]
                                        r26 = upvalueValues[upvalues[1]]
                                        r15 = upvalueValues[upvalues[2]]
                                        r13 = 12413979743892
                                        r3 = "}\163\134\253\215\028\024\022\018\007\190"
                                        r14 = r15(r3, r13)
                                        r21 = r26[r14]
                                        ReturnVal = r5[r21]
                                        r21 = upvalueValues[upvalues[1]]
                                        r26 = upvalueValues[upvalues[2]]
                                        r3 = 17487024545743
                                        r14 = "\138\165\218IG\139\180<\255"
                                        r15 = r26(r14, r3)
                                        r5 = r21[r15]
                                        state = ReturnVal[r5]
                                        r21 = upvalueValues[upvalues[1]]
                                        r26 = upvalueValues[upvalues[2]]
                                        ReturnVal = "FindFirstChildOfClass"
                                        ReturnVal = state[ReturnVal]
                                        r3 = 27193166442870
                                        r14 = "os\003\233\031.D]"
                                        r15 = r26(r14, r3)
                                        r5 = r21[r15]
                                        ReturnVal = ReturnVal(state, r5)
                                        r21 = upvalueValues[upvalues[1]]
                                        state = "ChangeState"
                                        state = ReturnVal[state]
                                        r26 = upvalueValues[upvalues[2]]
                                        r3 = 33013955476493
                                        r14 = "\011\222gO>{\127"
                                        r15 = r26(r14, r3)
                                        r5 = r21[r15]
                                        state = state(ReturnVal, r5)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure2 entry 1181950 -> 113, states 113-143
                                    if state <= 128 then
                                        if state <= 120 then
                                            if state <= 116 then
                                                if state <= 114 then
                                                    if state <= 113 then
                                                        if state == 113 then -- entry 1181950 -> 113
                                                            r5 = "game"
                                                            ReturnVal = _env[r5]
                                                            r26 = upvalueValues[upvalues[1]]
                                                            r15 = upvalueValues[upvalues[2]]
                                                            r3 = "\024\217\200@\208\246\248"
                                                            r13 = 11478867989729
                                                            r14 = r15(r3, r13)
                                                            r5 = "GetService"
                                                            r5 = ReturnVal[r5]
                                                            r21 = r26[r14]
                                                            r5 = r5(ReturnVal, r21)
                                                            r21 = upvalueValues[upvalues[1]]
                                                            r26 = upvalueValues[upvalues[2]]
                                                            r3 = 2597816960185
                                                            r14 = "d\154\006\151F\225\192?9)\234"
                                                            r15 = r26(r14, r3)
                                                            ReturnVal = r21[r15]
                                                            state = r5[ReturnVal]
                                                            r5 = state
                                                            r15 = upvalueValues[upvalues[1]]
                                                            r14 = upvalueValues[upvalues[2]]
                                                            r13 = "\197$\028)\000*~\150\255"
                                                            r6 = 23725844540200
                                                            r3 = r14(r13, r6)
                                                            r26 = r15[r3]
                                                            r21 = r5[r26]
                                                            state = r21 and (114) or (115)
                                                            ReturnVal = r21
                                                        end
                                                    else
                                                        if state == 114 then
                                                            r26 = upvalueValues[upvalues[1]]
                                                            r15 = upvalueValues[upvalues[2]]
                                                            state = "WaitForChild"
                                                            state = ReturnVal[state]
                                                            r3 = "\244\177*\240\215\145g\ts\132>\160W\138F\235"
                                                            r13 = 31496825043274
                                                            r14 = r15(r3, r13)
                                                            r21 = r26[r14]
                                                            state = state(ReturnVal, r21)
                                                            r21 = state
                                                            r15 = "math"
                                                            r26 = _env[r15]
                                                            r14 = upvalueValues[upvalues[1]]
                                                            r3 = upvalueValues[upvalues[2]]
                                                            r6 = "\159\133^%"
                                                            r29 = 8817232334857
                                                            r13 = r3(r6, r29)
                                                            r15 = r14[r13]
                                                            ReturnVal = r26[r15]
                                                            state = -ReturnVal
                                                            r26 = state
                                                            ReturnVal = "pairs"
                                                            state = _env[ReturnVal]
                                                            r6 = "workspace"
                                                            r13 = _env[r6]
                                                            r29 = upvalueValues[upvalues[1]]
                                                            r31 = upvalueValues[upvalues[2]]
                                                            r32 = "\027\156\212\158#"
                                                            r28 = 33989619842515
                                                            r2 = r31(r32, r28)
                                                            r6 = r29[r2]
                                                            r3 = r13[r6]
                                                            r6 = "GetDescendants"
                                                            r6 = r3[r6]
                                                            r13 = {
                                                                r6(r3)
                                                            }
                                                            r3 = {
                                                                state(unpack(r13))
                                                            }
                                                            ReturnVal = r3[1]
                                                            r14 = r3[3]
                                                            r15 = r3[2]
                                                            state = createClosure3(171, {
                                                                upvalues[1],
                                                                upvalues[2]
                                                            })
                                                            r13 = state
                                                            state = nil
                                                            r6 = state
                                                            state = nil
                                                            r29 = state
                                                            r3 = ReturnVal
                                                            state = 116
                                                        end
                                                    end
                                                else
                                                    if state <= 115 then
                                                        if state == 115 then
                                                            r15 = upvalueValues[upvalues[1]]
                                                            r14 = upvalueValues[upvalues[2]]
                                                            r13 = "\001&\017\162\215\141Iqv\191\015\234>\208"
                                                            r6 = 26528207368257
                                                            r3 = r14(r13, r6)
                                                            r26 = r15[r3]
                                                            r21 = r5[r26]
                                                            r26 = "Wait"
                                                            r26 = r21[r26]
                                                            r26 = r26(r21)
                                                            ReturnVal = r26
                                                            state = 114
                                                        end
                                                    else
                                                        if state == 116 then
                                                            state = true
                                                            state = state and (117) or (118)
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 118 then
                                                    if state <= 117 then
                                                        if state == 117 then
                                                            r31 = allocUpvalue()
                                                            state = nil
                                                            upvalueValues[r31] = state
                                                            r2 = {
                                                                r3(r15, r14)
                                                            }
                                                            state = r2[1]
                                                            ReturnVal = r2[2]
                                                            upvalueValues[r31] = ReturnVal
                                                            r14 = state
                                                            r32 = nil
                                                            r2 = r14 == r32
                                                            state = r2 and (119) or (120)
                                                        end
                                                    else
                                                        if state == 118 then
                                                            r2 = state
                                                            state = r6 and (121) or (122)
                                                            r31 = r6
                                                        end
                                                    end
                                                else
                                                    if state <= 119 then
                                                        if state == 119 then
                                                            r31 = releaseUpvalue(r31)
                                                            r2 = nil
                                                            state = 118
                                                        end
                                                    else
                                                        if state == 120 then
                                                            r28 = state
                                                            r32 = nil
                                                            r2 = r32
                                                            r33 = upvalueValues[r31]
                                                            r12 = upvalueValues[upvalues[1]]
                                                            r1 = upvalueValues[upvalues[2]]
                                                            r24 = 9587051368816
                                                            r18 = "\232\134&:\166+\029\182\128"
                                                            r4 = r1(r18, r24)
                                                            r25 = r12[r4]
                                                            r16 = "IsA"
                                                            r16 = r33[r16]
                                                            r16 = r16(r33, r25)
                                                            state = r16 and (123) or (124)
                                                            r32 = r16
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 124 then
                                                if state <= 122 then
                                                    if state <= 121 then
                                                        if state == 121 then
                                                            r31 = r29
                                                            state = 122
                                                        end
                                                    else
                                                        if state == 122 then
                                                            state = r2
                                                            state = r31 and (125) or (126)
                                                        end
                                                    end
                                                else
                                                    if state <= 123 then
                                                        if state == 123 then
                                                            r16 = state
                                                            r1 = upvalueValues[r31]
                                                            r18 = upvalueValues[upvalues[1]]
                                                            r24 = upvalueValues[upvalues[2]]
                                                            r9 = 6414785727403
                                                            r17 = "q\228\177f"
                                                            r8 = r24(r17, r9)
                                                            r4 = r18[r8]
                                                            r12 = r1[r4]
                                                            r4 = upvalueValues[upvalues[1]]
                                                            r18 = upvalueValues[upvalues[2]]
                                                            r17 = 23586919639783
                                                            r8 = "\224\187(Q\198"
                                                            r24 = r18(r8, r17)
                                                            r1 = r4[r24]
                                                            r25 = r12 == r1
                                                            state = r25 and (127) or (128)
                                                            r33 = r25
                                                        end
                                                    else
                                                        if state == 124 then
                                                            state = r28
                                                            state = r32 and (129) or (130)
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 126 then
                                                    if state <= 125 then
                                                        if state == 125 then
                                                            r2 = upvalueValues[upvalues[1]]
                                                            r18 = upvalueValues[upvalues[2]]
                                                            r8 = "\031\196l\179\191\030"
                                                            r17 = 2234298778640
                                                            r24 = r18(r8, r17)
                                                            r31 = r2[r24]
                                                            r8 = "Vector3"
                                                            r24 = _env[r8]
                                                            r17 = upvalueValues[upvalues[1]]
                                                            r9 = upvalueValues[upvalues[2]]
                                                            r30 = 24512305687702
                                                            r10 = "\149)\011"
                                                            r7 = r9(r10, r30)
                                                            r8 = r17[r7]
                                                            r18 = r24[r8]
                                                            r8 = 0
                                                            r17 = 3
                                                            r9 = 0
                                                            r24 = r18(r8, r17, r9)
                                                            r2 = r6 + r24
                                                            r21[r31] = r2
                                                            r18 = "task"
                                                            r2 = _env[r18]
                                                            r24 = upvalueValues[upvalues[1]]
                                                            r8 = upvalueValues[upvalues[2]]
                                                            r9 = "\018\185~K"
                                                            r7 = 30662777321414
                                                            r17 = r8(r9, r7)
                                                            r18 = r24[r17]
                                                            r31 = r2[r18]
                                                            r18 = 0.1
                                                            r2 = r31(r18)
                                                            r2 = "fireproximityprompt"
                                                            r31 = _env[r2]
                                                            r2 = r31(r29)
                                                            state = 126
                                                        end
                                                    else
                                                        if state == 126 then
                                                            r18 = "task"
                                                            ReturnVal = {}
                                                            r7 = 25821218434807
                                                            r9 = "eo\136\171\255"
                                                            r5 = nil
                                                            r14 = nil
                                                            r2 = _env[r18]
                                                            r29 = nil
                                                            r15 = nil
                                                            r26 = nil
                                                            r24 = upvalueValues[upvalues[1]]
                                                            r8 = upvalueValues[upvalues[2]]
                                                            r17 = r8(r9, r7)
                                                            r21 = nil
                                                            r6 = nil
                                                            r18 = r24[r17]
                                                            r31 = r2[r18]
                                                            r18 = createClosure1(182, {
                                                                upvalues[1],
                                                                upvalues[2]
                                                            })
                                                            r2 = r31(r18)
                                                            r2 = "wait"
                                                            r31 = _env[r2]
                                                            r3 = nil
                                                            r2 = r31()
                                                            r13 = nil
                                                            state = nil
                                                        end
                                                    end
                                                else
                                                    if state <= 127 then
                                                        if state == 127 then
                                                            r4 = upvalueValues[r31]
                                                            r24 = upvalueValues[upvalues[1]]
                                                            r8 = upvalueValues[upvalues[2]]
                                                            r9 = "\182\\\216;\005\015"
                                                            r7 = 26096594677624
                                                            r17 = r8(r9, r7)
                                                            r18 = r24[r17]
                                                            r1 = r4[r18]
                                                            r18 = upvalueValues[upvalues[1]]
                                                            r24 = upvalueValues[upvalues[2]]
                                                            r17 = "{XI\192"
                                                            r9 = 1336492638830
                                                            r8 = r24(r17, r9)
                                                            r4 = r18[r8]
                                                            r12 = r1[r4]
                                                            r4 = upvalueValues[upvalues[1]]
                                                            r18 = upvalueValues[upvalues[2]]
                                                            r17 = 7269947788601
                                                            r8 = "\170\164\157J_\230K\140?\131\157\134\140^"
                                                            r24 = r18(r8, r17)
                                                            r1 = r4[r24]
                                                            r25 = r12 == r1
                                                            r33 = r25
                                                            state = 128
                                                        end
                                                    else
                                                        if state == 128 then
                                                            state = r16
                                                            r32 = r33
                                                            state = 124
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 136 then
                                            if state <= 132 then
                                                if state <= 130 then
                                                    if state <= 129 then
                                                        if state == 129 then
                                                            r16 = createClosure0(192, {
                                                                r31,
                                                                upvalues[1],
                                                                upvalues[2]
                                                            })
                                                            r28 = "pcall"
                                                            r32 = _env[r28]
                                                            r25 = {
                                                                r32(r16)
                                                            }
                                                            r28 = r25[1]
                                                            r16 = state
                                                            state = r28 and (131) or (132)
                                                            r33 = r25[2]
                                                            r32 = r28
                                                        end
                                                    else
                                                        if state == 130 then
                                                            r28 = r26
                                                            r2 = r28
                                                            state = 133
                                                        end
                                                    end
                                                else
                                                    if state <= 131 then
                                                        if state == 131 then
                                                            r32 = r33
                                                            state = 132
                                                        end
                                                    else
                                                        if state == 132 then
                                                            state = r16
                                                            state = r32 and (134) or (135)
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 134 then
                                                    if state <= 133 then
                                                        if state == 133 then
                                                            r31 = releaseUpvalue(r31)
                                                            r33 = r2
                                                            r26 = r33
                                                            r2 = nil
                                                            state = 116
                                                        end
                                                    else
                                                        if state == 134 then
                                                            r25 = upvalueValues[r31]
                                                            r1 = upvalueValues[upvalues[1]]
                                                            r4 = upvalueValues[upvalues[2]]
                                                            r8 = 33288907947149
                                                            r24 = "\196\199\253\184"
                                                            r18 = r4(r24, r8)
                                                            r12 = r1[r18]
                                                            r16 = r25[r12]
                                                            r32 = r13(r16)
                                                            r2 = r32
                                                            r25 = state
                                                            state = r2 and (136) or (137)
                                                            r16 = r2
                                                        end
                                                    end
                                                else
                                                    if state <= 135 then
                                                        if state == 135 then
                                                            r4 = r26
                                                            r2 = r4
                                                            state = 138
                                                        end
                                                    else
                                                        if state == 136 then
                                                            r12 = r26 < r2
                                                            r16 = r12
                                                            state = 137
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 140 then
                                                if state <= 138 then
                                                    if state <= 137 then
                                                        if state == 137 then
                                                            state = r25
                                                            state = r16 and (139) or (140)
                                                        end
                                                    else
                                                        if state == 138 then
                                                            r33 = nil
                                                            r28 = nil
                                                            state = 133
                                                        end
                                                    end
                                                else
                                                    if state <= 139 then
                                                        if state == 139 then
                                                            r4 = upvalueValues[r31]
                                                            r24 = upvalueValues[upvalues[1]]
                                                            r8 = upvalueValues[upvalues[2]]
                                                            r7 = 5136129362263
                                                            r9 = ">\201~U\027%"
                                                            r17 = r8(r9, r7)
                                                            r18 = r24[r17]
                                                            r1 = r4[r18]
                                                            r18 = upvalueValues[upvalues[1]]
                                                            r24 = upvalueValues[upvalues[2]]
                                                            r9 = 3418487653943
                                                            r17 = "O\188\006\148\181f"
                                                            r8 = r24(r17, r9)
                                                            r4 = r18[r8]
                                                            r12 = r1[r4]
                                                            r4 = upvalueValues[upvalues[1]]
                                                            r18 = upvalueValues[upvalues[2]]
                                                            r8 = "\168\019\r\147\166\247"
                                                            r17 = 702352802119
                                                            r24 = r18(r8, r17)
                                                            r1 = r4[r24]
                                                            r25 = r12[r1]
                                                            r1 = upvalueValues[upvalues[1]]
                                                            r4 = upvalueValues[upvalues[2]]
                                                            r24 = "bn\022\177\229\004"
                                                            r8 = 28861973918847
                                                            r18 = r4(r24, r8)
                                                            r12 = r1[r18]
                                                            r16 = r25[r12]
                                                            r4 = upvalueValues[r31]
                                                            r24 = upvalueValues[upvalues[1]]
                                                            r8 = upvalueValues[upvalues[2]]
                                                            r7 = 29946695022201
                                                            r9 = "J0S\155\211\200"
                                                            r17 = r8(r9, r7)
                                                            r18 = r24[r17]
                                                            r1 = r4[r18]
                                                            r18 = upvalueValues[upvalues[1]]
                                                            r24 = upvalueValues[upvalues[2]]
                                                            r9 = 32199177845393
                                                            r17 = "\192\014I\001T\135"
                                                            r8 = r24(r17, r9)
                                                            r4 = r18[r8]
                                                            r12 = r1[r4]
                                                            r4 = upvalueValues[upvalues[1]]
                                                            r18 = upvalueValues[upvalues[2]]
                                                            r8 = "\247o\153q\132\216"
                                                            r17 = 2494834148489
                                                            r24 = r18(r8, r17)
                                                            r1 = r4[r24]
                                                            r25 = r12[r1]
                                                            r4 = upvalueValues[upvalues[1]]
                                                            r18 = upvalueValues[upvalues[2]]
                                                            r17 = 28751942775884
                                                            r8 = "\153\220\228\198k}\152\169t\158\145(\218\184%<"
                                                            r24 = r18(r8, r17)
                                                            r1 = r4[r24]
                                                            r12 = "FindFirstChild"
                                                            r12 = r25[r12]
                                                            r12 = r12(r25, r1)
                                                            r29 = r12
                                                            state = r29 and (141) or (142)
                                                            r6 = r16
                                                        end
                                                    else
                                                        if state == 140 then
                                                            r25 = r26
                                                            r2 = r25
                                                            state = 143
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 142 then
                                                    if state <= 141 then
                                                        if state == 141 then
                                                            r24 = upvalueValues[r31]
                                                            r17 = upvalueValues[upvalues[1]]
                                                            r9 = upvalueValues[upvalues[2]]
                                                            r30 = 13579971369139
                                                            r10 = "\228\252\186.\230\145"
                                                            r7 = r9(r10, r30)
                                                            r8 = r17[r7]
                                                            r18 = r24[r8]
                                                            r8 = upvalueValues[upvalues[1]]
                                                            r17 = upvalueValues[upvalues[2]]
                                                            r10 = 32256891550380
                                                            r7 = "Z\158\204j\223\193"
                                                            r9 = r17(r7, r10)
                                                            r24 = r8[r9]
                                                            r4 = r18[r24]
                                                            r24 = upvalueValues[upvalues[1]]
                                                            r8 = upvalueValues[upvalues[2]]
                                                            r9 = "\166\170T\232*\196"
                                                            r7 = 19322090234661
                                                            r17 = r8(r9, r7)
                                                            r18 = r24[r17]
                                                            r1 = r4[r18]
                                                            r18 = upvalueValues[upvalues[1]]
                                                            r24 = upvalueValues[upvalues[2]]
                                                            r9 = 14925254318886
                                                            r17 = "\031&\t\241\238}\155\1651![\136\215\147\187\253"
                                                            r8 = r24(r17, r9)
                                                            r4 = r18[r8]
                                                            r25 = r1[r4]
                                                            r18 = upvalueValues[upvalues[1]]
                                                            r24 = upvalueValues[upvalues[2]]
                                                            r17 = "\1626w%\168\220\135\218\170\030\\\168\225N\204"
                                                            r9 = 24247991577627
                                                            r8 = r24(r17, r9)
                                                            r4 = r18[r8]
                                                            r1 = "FindFirstChild"
                                                            r1 = r25[r1]
                                                            r1 = r1(r25, r4)
                                                            r29 = r1
                                                            state = 142
                                                        end
                                                    else
                                                        if state == 142 then
                                                            state = 143
                                                        end
                                                    end
                                                else
                                                    if state == 143 then
                                                        state = 138
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 191 then
                            if state <= 170 then
                                if state <= 153 then
                                    -- createClosure1 entry 6115969 -> 144, states 144-153
                                    if state <= 148 then
                                        if state <= 146 then
                                            if state <= 145 then
                                                if state <= 144 then
                                                    if state == 144 then -- entry 6115969 -> 144
                                                        ReturnVal = "getgenv"
                                                        state = _env[ReturnVal]
                                                        ReturnVal = state()
                                                        r5 = upvalueValues[upvalues[1]]
                                                        r21 = upvalueValues[upvalues[2]]
                                                        r14 = 8155431325397
                                                        r15 = "\211YXBj\028\026Z\175A"
                                                        r26 = r21(r15, r14)
                                                        state = r5[r26]
                                                        r5 = nil
                                                        ReturnVal[state] = r5
                                                        r5 = "workspace"
                                                        ReturnVal = _env[r5]
                                                        r21 = upvalueValues[upvalues[1]]
                                                        r26 = upvalueValues[upvalues[2]]
                                                        r14 = "\180\129\008\156\197"
                                                        r3 = 5758914153081
                                                        r15 = r26(r14, r3)
                                                        r5 = r21[r15]
                                                        state = ReturnVal[r5]
                                                        ReturnVal = "GetDescendants"
                                                        ReturnVal = state[ReturnVal]
                                                        ReturnVal = ReturnVal(state)
                                                        r5 = ReturnVal
                                                        ReturnVal = "pairs"
                                                        state = _env[ReturnVal]
                                                        r15 = {
                                                            state(r5)
                                                        }
                                                        ReturnVal = r15[1]
                                                        r26 = r15[3]
                                                        r21 = r15[2]
                                                        r15 = ReturnVal
                                                        state = 145
                                                    end
                                                else
                                                    if state == 145 then
                                                        state = true
                                                        state = state and (146) or (147)
                                                    end
                                                end
                                            else
                                                if state == 146 then
                                                    r3 = {
                                                        r15(r21, r26)
                                                    }
                                                    state = nil
                                                    r14 = state
                                                    state = r3[1]
                                                    ReturnVal = r3[2]
                                                    r26 = state
                                                    r13 = nil
                                                    r3 = r26 == r13
                                                    state = r3 and (148) or (149)
                                                    r14 = ReturnVal
                                                end
                                            end
                                        else
                                            if state <= 147 then
                                                if state == 147 then
                                                    r13 = "task"
                                                    r3 = _env[r13]
                                                    r26 = nil
                                                    r15 = nil
                                                    r2 = "\250\188\240\\\162"
                                                    r6 = upvalueValues[upvalues[1]]
                                                    ReturnVal = {}
                                                    r32 = 7390843112817
                                                    r5 = nil
                                                    r29 = upvalueValues[upvalues[2]]
                                                    r31 = r29(r2, r32)
                                                    r13 = r6[r31]
                                                    r21 = nil
                                                    r14 = r3[r13]
                                                    r13 = createClosure5(193, {
                                                        upvalues[1],
                                                        upvalues[2]
                                                    })
                                                    r3 = r14(r13)
                                                    r3 = "wait"
                                                    r14 = _env[r3]
                                                    r3 = r14()
                                                    state = nil
                                                end
                                            else
                                                if state == 148 then
                                                    r14 = nil
                                                    state = 147
                                                end
                                            end
                                        end
                                    else
                                        if state <= 151 then
                                            if state <= 150 then
                                                if state <= 149 then
                                                    if state == 149 then
                                                        r13 = state
                                                        r2 = upvalueValues[upvalues[1]]
                                                        r32 = upvalueValues[upvalues[2]]
                                                        r16 = 22848818424207
                                                        r33 = "\189\218'k"
                                                        r28 = r32(r33, r16)
                                                        r31 = r2[r28]
                                                        r29 = r14[r31]
                                                        r2 = upvalueValues[upvalues[1]]
                                                        r32 = upvalueValues[upvalues[2]]
                                                        r33 = "\n(\171\1995\240r9"
                                                        r16 = 27477521560059
                                                        r28 = r32(r33, r16)
                                                        r31 = r2[r28]
                                                        r6 = r29 == r31
                                                        state = r6 and (150) or (151)
                                                        r3 = r6
                                                    end
                                                else
                                                    if state == 150 then
                                                        r2 = upvalueValues[upvalues[1]]
                                                        r32 = upvalueValues[upvalues[2]]
                                                        r16 = 20684168471967
                                                        r33 = "l \154\020\213A\127"
                                                        r28 = r32(r33, r16)
                                                        r31 = r2[r28]
                                                        r29 = r14[r31]
                                                        r31 = true
                                                        r6 = r29 == r31
                                                        r3 = r6
                                                        state = 151
                                                    end
                                                end
                                            else
                                                if state == 151 then
                                                    state = r13
                                                    state = r3 and (152) or (153)
                                                end
                                            end
                                        else
                                            if state <= 152 then
                                                if state == 152 then
                                                    r13 = "getgenv"
                                                    r3 = _env[r13]
                                                    r13 = r3()
                                                    r6 = upvalueValues[upvalues[1]]
                                                    r29 = upvalueValues[upvalues[2]]
                                                    r32 = 11912437896619
                                                    r2 = "2V1\007N\230\134\152 B"
                                                    r31 = r29(r2, r32)
                                                    r3 = r6[r31]
                                                    r2 = upvalueValues[upvalues[1]]
                                                    r32 = upvalueValues[upvalues[2]]
                                                    r16 = 29711820355083
                                                    r33 = " 5\162\219Y\200"
                                                    r28 = r32(r33, r16)
                                                    r31 = r2[r28]
                                                    r29 = r14[r31]
                                                    r2 = upvalueValues[upvalues[1]]
                                                    r32 = upvalueValues[upvalues[2]]
                                                    r16 = 10012102070838
                                                    r33 = "\206Rf\170\198\226"
                                                    r28 = r32(r33, r16)
                                                    r31 = r2[r28]
                                                    r6 = r29[r31]
                                                    r13[r3] = r6
                                                    state = 153
                                                end
                                            else
                                                if state == 153 then
                                                    r14 = nil
                                                    state = 145
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure5 entry 1726803 -> 154, states 154-170
                                    if state <= 162 then
                                        if state <= 158 then
                                            if state <= 156 then
                                                if state <= 155 then
                                                    if state <= 154 then
                                                        if state == 154 then -- entry 1726803 -> 154
                                                            ReturnVal = "getgenv"
                                                            state = _env[ReturnVal]
                                                            ReturnVal = state()
                                                            r5 = upvalueValues[upvalues[1]]
                                                            r21 = upvalueValues[upvalues[2]]
                                                            r14 = 22545308854530
                                                            r15 = "\242\194\023M2\228M\0229R"
                                                            r26 = r21(r15, r14)
                                                            state = r5[r26]
                                                            r5 = nil
                                                            ReturnVal[state] = r5
                                                            r5 = "workspace"
                                                            ReturnVal = _env[r5]
                                                            r21 = upvalueValues[upvalues[1]]
                                                            r26 = upvalueValues[upvalues[2]]
                                                            r3 = 27805787746964
                                                            r14 = "\221\022(\023s"
                                                            r15 = r26(r14, r3)
                                                            r5 = r21[r15]
                                                            state = ReturnVal[r5]
                                                            ReturnVal = "GetDescendants"
                                                            ReturnVal = state[ReturnVal]
                                                            ReturnVal = ReturnVal(state)
                                                            r5 = ReturnVal
                                                            ReturnVal = "pairs"
                                                            state = _env[ReturnVal]
                                                            r15 = {
                                                                state(r5)
                                                            }
                                                            r26 = r15[3]
                                                            r21 = r15[2]
                                                            ReturnVal = r15[1]
                                                            r15 = ReturnVal
                                                            state = 155
                                                        end
                                                    else
                                                        if state == 155 then
                                                            state = true
                                                            state = state and (156) or (157)
                                                        end
                                                    end
                                                else
                                                    if state == 156 then
                                                        r3 = {
                                                            r15(r21, r26)
                                                        }
                                                        ReturnVal = r3[2]
                                                        state = nil
                                                        r14 = state
                                                        state = r3[1]
                                                        r26 = state
                                                        r13 = nil
                                                        r3 = r26 == r13
                                                        state = r3 and (158) or (159)
                                                        r14 = ReturnVal
                                                    end
                                                end
                                            else
                                                if state <= 157 then
                                                    if state == 157 then
                                                        r13 = "task"
                                                        r3 = _env[r13]
                                                        r6 = upvalueValues[upvalues[1]]
                                                        r29 = upvalueValues[upvalues[2]]
                                                        r2 = "x\218\217\173\019"
                                                        r32 = 24200462248965
                                                        r31 = r29(r2, r32)
                                                        r13 = r6[r31]
                                                        r14 = r3[r13]
                                                        r13 = createClosure4(205, {
                                                            upvalues[1],
                                                            upvalues[2]
                                                        })
                                                        r3 = r14(r13)
                                                        r3 = "pairs"
                                                        r14 = _env[r3]
                                                        r31 = "workspace"
                                                        r29 = _env[r31]
                                                        r2 = "GetDescendants"
                                                        r2 = r29[r2]
                                                        r31 = {
                                                            r2(r29)
                                                        }
                                                        r29 = {
                                                            r14(unpack(r31))
                                                        }
                                                        r3 = r29[1]
                                                        r6 = r29[3]
                                                        r13 = r29[2]
                                                        state = 160
                                                    end
                                                else
                                                    if state == 158 then
                                                        r14 = nil
                                                        state = 157
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 160 then
                                                if state <= 159 then
                                                    if state == 159 then
                                                        r2 = upvalueValues[upvalues[1]]
                                                        r32 = upvalueValues[upvalues[2]]
                                                        r16 = 9753397006781
                                                        r33 = "\031\156\133\206"
                                                        r28 = r32(r33, r16)
                                                        r31 = r2[r28]
                                                        r29 = r14[r31]
                                                        r2 = upvalueValues[upvalues[1]]
                                                        r32 = upvalueValues[upvalues[2]]
                                                        r16 = 12797567096647
                                                        r33 = "\024\218\133o\203\003+\140"
                                                        r28 = r32(r33, r16)
                                                        r31 = r2[r28]
                                                        r6 = r29 == r31
                                                        r13 = state
                                                        state = r6 and (161) or (162)
                                                        r3 = r6
                                                    end
                                                else
                                                    if state == 160 then
                                                        r14 = true
                                                        state = r14 and (163) or (164)
                                                    end
                                                end
                                            else
                                                if state <= 161 then
                                                    if state == 161 then
                                                        r2 = upvalueValues[upvalues[1]]
                                                        r32 = upvalueValues[upvalues[2]]
                                                        r16 = 32011528731194
                                                        r33 = "\147\240t\204\164\127g"
                                                        r28 = r32(r33, r16)
                                                        r31 = r2[r28]
                                                        r29 = r14[r31]
                                                        r31 = true
                                                        r6 = r29 == r31
                                                        r3 = r6
                                                        state = 162
                                                    end
                                                else
                                                    if state == 162 then
                                                        state = r13
                                                        state = r3 and (165) or (166)
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 166 then
                                            if state <= 164 then
                                                if state <= 163 then
                                                    if state == 163 then
                                                        r2 = {
                                                            r3(r13, r6)
                                                        }
                                                        r29 = r2[1]
                                                        r31 = r2[2]
                                                        r14 = nil
                                                        r6 = r29
                                                        r32 = nil
                                                        r2 = r6 == r32
                                                        state = r2 and (167) or (168)
                                                        r14 = r31
                                                    end
                                                else
                                                    if state == 164 then
                                                        r32 = 3
                                                        r2 = "wait"
                                                        r3 = nil
                                                        r14 = _env[r2]
                                                        r13 = nil
                                                        r5 = nil
                                                        r2 = r14(r32)
                                                        r26 = nil
                                                        r21 = nil
                                                        r15 = nil
                                                        r6 = nil
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state <= 165 then
                                                    if state == 165 then
                                                        r13 = "getgenv"
                                                        r3 = _env[r13]
                                                        r13 = r3()
                                                        r6 = upvalueValues[upvalues[1]]
                                                        r29 = upvalueValues[upvalues[2]]
                                                        r2 = "w\152\"s\226z\011?\006c"
                                                        r32 = 28008857826034
                                                        r31 = r29(r2, r32)
                                                        r3 = r6[r31]
                                                        r2 = upvalueValues[upvalues[1]]
                                                        r32 = upvalueValues[upvalues[2]]
                                                        r33 = " \188\143%\208\140"
                                                        r16 = 6888524385415
                                                        r28 = r32(r33, r16)
                                                        r31 = r2[r28]
                                                        r29 = r14[r31]
                                                        r2 = upvalueValues[upvalues[1]]
                                                        r32 = upvalueValues[upvalues[2]]
                                                        r33 = "\029<\203\158\137\236"
                                                        r16 = 32859514731461
                                                        r28 = r32(r33, r16)
                                                        r31 = r2[r28]
                                                        r6 = r29[r31]
                                                        r13[r3] = r6
                                                        state = 166
                                                    end
                                                else
                                                    if state == 166 then
                                                        r14 = nil
                                                        state = 155
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 168 then
                                                if state <= 167 then
                                                    if state == 167 then
                                                        r14 = nil
                                                        state = 164
                                                    end
                                                else
                                                    if state == 168 then
                                                        r33 = upvalueValues[upvalues[1]]
                                                        r16 = upvalueValues[upvalues[2]]
                                                        r12 = "\160H\228\026\189}\254W\195"
                                                        r1 = 17612809625609
                                                        r25 = r16(r12, r1)
                                                        r28 = r33[r25]
                                                        r32 = r14[r28]
                                                        r33 = upvalueValues[upvalues[1]]
                                                        r16 = upvalueValues[upvalues[2]]
                                                        r12 = "I)?`,\172\183'\197\249\129p\254\n@"
                                                        r1 = 15670174817408
                                                        r25 = r16(r12, r1)
                                                        r28 = r33[r25]
                                                        r2 = r32 == r28
                                                        state = r2 and (169) or (170)
                                                    end
                                                end
                                            else
                                                if state <= 169 then
                                                    if state == 169 then
                                                        r32 = upvalueValues[upvalues[1]]
                                                        r28 = upvalueValues[upvalues[2]]
                                                        r25 = 21005709403701
                                                        r16 = "\182\236\185QX\016\139_g\160\207\209"
                                                        r33 = r28(r16, r25)
                                                        r2 = r32[r33]
                                                        r32 = 0
                                                        r14[r2] = r32
                                                        state = 170
                                                    end
                                                else
                                                    if state == 170 then
                                                        r14 = nil
                                                        state = 160
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 181 then
                                    -- createClosure3 entry 6275796 -> 171, states 171-181
                                    if state <= 176 then
                                        if state <= 173 then
                                            if state <= 172 then
                                                if state <= 171 then
                                                    if state == 171 then -- entry 6275796 -> 171
                                                        r5 = args[1]
                                                        state = "upper"
                                                        state = r5[state]
                                                        state = state(r5)
                                                        r26 = upvalueValues[upvalues[1]]
                                                        r15 = upvalueValues[upvalues[2]]
                                                        r3 = "\028\205\152R\152\139\191\026\\\139\220\199"
                                                        r13 = 16565165628961
                                                        r14 = r15(r3, r13)
                                                        r21 = r26[r14]
                                                        ReturnVal = "gsub"
                                                        ReturnVal = state[ReturnVal]
                                                        r15 = upvalueValues[upvalues[1]]
                                                        r14 = upvalueValues[upvalues[2]]
                                                        r6 = 29762057401891
                                                        r13 = ""
                                                        r3 = r14(r13, r6)
                                                        r26 = r15[r3]
                                                        ReturnVal = ReturnVal(state, r21, r26)
                                                        r21 = ReturnVal
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r14 = upvalueValues[upvalues[1]]
                                                        r3 = upvalueValues[upvalues[2]]
                                                        r29 = 25754519563992
                                                        r6 = "R\148\221\007\235\225\246\251\203"
                                                        r13 = r3(r6, r29)
                                                        r15 = r14[r13]
                                                        r14 = "match"
                                                        r14 = r21[r14]
                                                        r26 = {
                                                            r14(r21, r15)
                                                        }
                                                        ReturnVal = state(unpack(r26))
                                                        r26 = ReturnVal
                                                        state = r26 and (172) or (173)
                                                    end
                                                else
                                                    if state == 172 then
                                                        r15 = upvalueValues[upvalues[1]]
                                                        r14 = upvalueValues[upvalues[2]]
                                                        r6 = 1345282949746
                                                        r13 = "\030"
                                                        r3 = r14(r13, r6)
                                                        ReturnVal = r15[r3]
                                                        state = "find"
                                                        state = r21[state]
                                                        state = state(r21, ReturnVal)
                                                        state = state and (174) or (175)
                                                    end
                                                end
                                            else
                                                if state == 173 then
                                                    state = nil
                                                    ReturnVal = {
                                                        state
                                                    }
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state <= 175 then
                                                if state <= 174 then
                                                    if state == 174 then
                                                        ReturnVal = 1000
                                                        state = r26 * ReturnVal
                                                        ReturnVal = {
                                                            state
                                                        }
                                                        state = nil
                                                    end
                                                else
                                                    if state == 175 then
                                                        r15 = upvalueValues[upvalues[1]]
                                                        r14 = upvalueValues[upvalues[2]]
                                                        r13 = "\249"
                                                        r6 = 27175472132462
                                                        r3 = r14(r13, r6)
                                                        state = "find"
                                                        state = r21[state]
                                                        ReturnVal = r15[r3]
                                                        state = state(r21, ReturnVal)
                                                        state = state and (176) or (177)
                                                    end
                                                end
                                            else
                                                if state == 176 then
                                                    ReturnVal = 1000000
                                                    state = r26 * ReturnVal
                                                    ReturnVal = {
                                                        state
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        if state <= 179 then
                                            if state <= 178 then
                                                if state <= 177 then
                                                    if state == 177 then
                                                        r15 = upvalueValues[upvalues[1]]
                                                        state = "find"
                                                        state = r21[state]
                                                        r14 = upvalueValues[upvalues[2]]
                                                        r6 = 18096580649194
                                                        r13 = "-"
                                                        r3 = r14(r13, r6)
                                                        ReturnVal = r15[r3]
                                                        state = state(r21, ReturnVal)
                                                        state = state and (178) or (179)
                                                    end
                                                else
                                                    if state == 178 then
                                                        ReturnVal = 1000000000
                                                        state = r26 * ReturnVal
                                                        ReturnVal = {
                                                            state
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state == 179 then
                                                    ReturnVal = 1000
                                                    state = r26 >= ReturnVal
                                                    state = state and (180) or (181)
                                                end
                                            end
                                        else
                                            if state <= 180 then
                                                if state == 180 then
                                                    ReturnVal = {
                                                        r26
                                                    }
                                                    state = nil
                                                end
                                            else
                                                if state == 181 then
                                                    state = nil
                                                    ReturnVal = {
                                                        state
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure1 entry 5583636 -> 182, states 182-191
                                    if state <= 186 then
                                        if state <= 184 then
                                            if state <= 183 then
                                                if state <= 182 then
                                                    if state == 182 then -- entry 5583636 -> 182
                                                        r21 = "getgenv"
                                                        r5 = _env[r21]
                                                        r21 = r5()
                                                        r26 = upvalueValues[upvalues[1]]
                                                        r15 = upvalueValues[upvalues[2]]
                                                        r13 = 15424528276494
                                                        r3 = "\229\195\182\152\020\229h\210\204;"
                                                        r14 = r15(r3, r13)
                                                        r5 = r26[r14]
                                                        ReturnVal = r21[r5]
                                                        r5 = nil
                                                        state = ReturnVal ~= r5
                                                        state = state and (183) or (184)
                                                    end
                                                else
                                                    if state == 183 then
                                                        r5 = "getgenv"
                                                        ReturnVal = _env[r5]
                                                        r5 = ReturnVal()
                                                        r21 = upvalueValues[upvalues[1]]
                                                        r26 = upvalueValues[upvalues[2]]
                                                        r14 = "\176\133\216N\128\136\170B\190\144"
                                                        r3 = 31999269960244
                                                        r15 = r26(r14, r3)
                                                        ReturnVal = r21[r15]
                                                        state = r5[ReturnVal]
                                                        r5 = state
                                                        r14 = "GetChildren"
                                                        r14 = r5[r14]
                                                        ReturnVal = "pairs"
                                                        state = _env[ReturnVal]
                                                        r15 = {
                                                            r14(r5)
                                                        }
                                                        r14 = {
                                                            state(unpack(r15))
                                                        }
                                                        ReturnVal = r14[1]
                                                        r21 = r14[2]
                                                        r15 = ReturnVal
                                                        r26 = r14[3]
                                                        state = 185
                                                    end
                                                end
                                            else
                                                if state == 184 then
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state <= 185 then
                                                if state == 185 then
                                                    state = true
                                                    state = state and (186) or (187)
                                                end
                                            else
                                                if state == 186 then
                                                    r3 = {
                                                        r15(r21, r26)
                                                    }
                                                    state = nil
                                                    r14 = state
                                                    state = r3[1]
                                                    ReturnVal = r3[2]
                                                    r26 = state
                                                    r13 = nil
                                                    r3 = r26 == r13
                                                    state = r3 and (188) or (189)
                                                    r14 = ReturnVal
                                                end
                                            end
                                        end
                                    else
                                        if state <= 189 then
                                            if state <= 188 then
                                                if state <= 187 then
                                                    if state == 187 then
                                                        r21 = nil
                                                        r26 = nil
                                                        r5 = nil
                                                        r15 = nil
                                                        state = 184
                                                    end
                                                else
                                                    if state == 188 then
                                                        r14 = nil
                                                        state = 187
                                                    end
                                                end
                                            else
                                                if state == 189 then
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r32 = "*\196\2354"
                                                    r28 = 33091166223409
                                                    r2 = r31(r32, r28)
                                                    r6 = r29[r2]
                                                    r13 = r14[r6]
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r28 = 3838699030267
                                                    r32 = "121\169\154\030Ci+XC/\231m"
                                                    r2 = r31(r32, r28)
                                                    r6 = r29[r2]
                                                    r3 = r13 == r6
                                                    state = r3 and (190) or (191)
                                                end
                                            end
                                        else
                                            if state <= 190 then
                                                if state == 190 then
                                                    r2 = "game"
                                                    r31 = _env[r2]
                                                    r32 = upvalueValues[upvalues[1]]
                                                    r28 = upvalueValues[upvalues[2]]
                                                    r16 = "\252\186\233\191\183W\195"
                                                    r25 = 31826617121252
                                                    r33 = r28(r16, r25)
                                                    r2 = r32[r33]
                                                    r29 = r31[r2]
                                                    r2 = upvalueValues[upvalues[1]]
                                                    r32 = upvalueValues[upvalues[2]]
                                                    r33 = "\139\212sZV`\139'v\146\011"
                                                    r16 = 13120515725277
                                                    r28 = r32(r33, r16)
                                                    r31 = r2[r28]
                                                    r6 = r29[r31]
                                                    r31 = upvalueValues[upvalues[1]]
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r28 = "\156\022\187^SZ\242\234\161"
                                                    r33 = 30602981423018
                                                    r32 = r2(r28, r33)
                                                    r29 = r31[r32]
                                                    r13 = r6[r29]
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r28 = 7080025738464
                                                    r32 = "\r\021f\134\228\183\237:m*\132\251\165\136S'"
                                                    r2 = r31(r32, r28)
                                                    r6 = r29[r2]
                                                    r3 = r13[r6]
                                                    r6 = upvalueValues[upvalues[1]]
                                                    r29 = upvalueValues[upvalues[2]]
                                                    r2 = "L\155R\132\207\255"
                                                    r32 = 27070211846461
                                                    r31 = r29(r2, r32)
                                                    r13 = r6[r31]
                                                    r31 = "CFrame"
                                                    r29 = _env[r31]
                                                    r2 = upvalueValues[upvalues[1]]
                                                    r32 = upvalueValues[upvalues[2]]
                                                    r16 = 24467430403201
                                                    r33 = "\184h\155"
                                                    r28 = r32(r33, r16)
                                                    r31 = r2[r28]
                                                    r6 = r29[r31]
                                                    r32 = upvalueValues[upvalues[1]]
                                                    r28 = upvalueValues[upvalues[2]]
                                                    r25 = 31541620488543
                                                    r16 = "8\213\225\192G\140\020\007"
                                                    r33 = r28(r16, r25)
                                                    r2 = r32[r33]
                                                    r31 = r14[r2]
                                                    r29 = r6(r31)
                                                    r3[r13] = r29
                                                    state = 191
                                                end
                                            else
                                                if state == 191 then
                                                    r14 = nil
                                                    state = 185
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 204 then
                                if state <= 192 then
                                    -- createClosure0 entry 8664110 -> 192, states 192-192
                                    if state == 192 then -- entry 8664110 -> 192
                                        r31 = upvalueValues[upvalues[1]]
                                        r32 = upvalueValues[upvalues[2]]
                                        r28 = upvalueValues[upvalues[3]]
                                        r25 = 23598542858988
                                        r16 = "9\175K\n\162&"
                                        r33 = r28(r16, r25)
                                        r2 = r32[r33]
                                        r29 = r31[r2]
                                        r2 = upvalueValues[upvalues[2]]
                                        r32 = upvalueValues[upvalues[3]]
                                        r33 = "\129\240\219\225t\147"
                                        r16 = 35011719249839
                                        r28 = r32(r33, r16)
                                        r31 = r2[r28]
                                        r6 = r29[r31]
                                        r31 = upvalueValues[upvalues[2]]
                                        r2 = upvalueValues[upvalues[3]]
                                        r33 = 15213721590700
                                        r28 = "\191\168Z\191\2455"
                                        r32 = r2(r28, r33)
                                        r29 = r31[r32]
                                        r13 = r6[r29]
                                        r29 = upvalueValues[upvalues[2]]
                                        r31 = upvalueValues[upvalues[3]]
                                        r28 = 26764282392751
                                        r32 = "\160N+\012\003\028"
                                        r2 = r31(r32, r28)
                                        r6 = r29[r2]
                                        r3 = r13[r6]
                                        r6 = upvalueValues[upvalues[2]]
                                        r29 = upvalueValues[upvalues[3]]
                                        r2 = "\135\002\235\229q<"
                                        r32 = 10437780722428
                                        r31 = r29(r2, r32)
                                        r13 = r6[r31]
                                        r14 = r3[r13]
                                        r13 = upvalueValues[upvalues[2]]
                                        r6 = upvalueValues[upvalues[3]]
                                        r2 = 13949696121183
                                        r31 = "]C\152\156?\225"
                                        r29 = r6(r31, r2)
                                        r3 = r13[r29]
                                        r15 = r14[r3]
                                        r3 = upvalueValues[upvalues[2]]
                                        r13 = upvalueValues[upvalues[3]]
                                        r31 = 29048821085398
                                        r29 = "\143%\"\226\211B"
                                        r6 = r13(r29, r31)
                                        r14 = r3[r6]
                                        r26 = r15[r14]
                                        r14 = upvalueValues[upvalues[2]]
                                        r3 = upvalueValues[upvalues[3]]
                                        r29 = 24461594733694
                                        r6 = "\020\254B\142\253\194\231\""
                                        r13 = r3(r6, r29)
                                        r15 = r14[r13]
                                        r21 = r26[r15]
                                        r15 = upvalueValues[upvalues[2]]
                                        r14 = upvalueValues[upvalues[3]]
                                        r6 = 32581893897028
                                        r13 = "G\207\214\197D]G\255"
                                        r3 = r14(r13, r6)
                                        r26 = r15[r3]
                                        r5 = r21[r26]
                                        r26 = upvalueValues[upvalues[2]]
                                        r15 = upvalueValues[upvalues[3]]
                                        r13 = 27123991769430
                                        r3 = "\244(\228r9\156m"
                                        r14 = r15(r3, r13)
                                        r21 = r26[r14]
                                        ReturnVal = r5[r21]
                                        r5 = false
                                        state = ReturnVal == r5
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure5 entry 466597 -> 193, states 193-204
                                    if state <= 198 then
                                        if state <= 195 then
                                            if state <= 194 then
                                                if state <= 193 then
                                                    if state == 193 then -- entry 466597 -> 193
                                                        r21 = "getgenv"
                                                        r5 = _env[r21]
                                                        r21 = r5()
                                                        r26 = upvalueValues[upvalues[1]]
                                                        r15 = upvalueValues[upvalues[2]]
                                                        r3 = "\173\187\194\160}\007\218\224\005$"
                                                        r13 = 20348666684675
                                                        r14 = r15(r3, r13)
                                                        r5 = r26[r14]
                                                        ReturnVal = r21[r5]
                                                        r5 = nil
                                                        state = ReturnVal ~= r5
                                                        state = state and (194) or (195)
                                                    end
                                                else
                                                    if state == 194 then
                                                        r26 = "getgenv"
                                                        r21 = _env[r26]
                                                        r26 = r21()
                                                        r15 = upvalueValues[upvalues[1]]
                                                        r14 = upvalueValues[upvalues[2]]
                                                        r13 = "\166d\131\210\128\242!\207\198\231"
                                                        r6 = 25436630347332
                                                        r3 = r14(r13, r6)
                                                        r21 = r15[r3]
                                                        r5 = r26[r21]
                                                        r26 = upvalueValues[upvalues[1]]
                                                        r15 = upvalueValues[upvalues[2]]
                                                        r13 = 4205740984230
                                                        r3 = "V011gJ \030\012"
                                                        r14 = r15(r3, r13)
                                                        r21 = r26[r14]
                                                        ReturnVal = r5[r21]
                                                        r21 = upvalueValues[upvalues[1]]
                                                        r26 = upvalueValues[upvalues[2]]
                                                        r14 = "\002;O\161}\230\017\228o"
                                                        r3 = 18255460802868
                                                        r15 = r26(r14, r3)
                                                        r5 = r21[r15]
                                                        state = ReturnVal[r5]
                                                        r5 = state
                                                        ReturnVal = "pairs"
                                                        state = _env[ReturnVal]
                                                        r14 = "GetChildren"
                                                        r14 = r5[r14]
                                                        r15 = {
                                                            r14(r5)
                                                        }
                                                        r14 = {
                                                            state(unpack(r15))
                                                        }
                                                        ReturnVal = r14[1]
                                                        r21 = r14[2]
                                                        r26 = r14[3]
                                                        r15 = ReturnVal
                                                        state = 196
                                                    end
                                                end
                                            else
                                                if state == 195 then
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state <= 197 then
                                                if state <= 196 then
                                                    if state == 196 then
                                                        state = true
                                                        state = state and (197) or (198)
                                                    end
                                                else
                                                    if state == 197 then
                                                        r3 = {
                                                            r15(r21, r26)
                                                        }
                                                        state = nil
                                                        r14 = state
                                                        state = r3[1]
                                                        ReturnVal = r3[2]
                                                        r26 = state
                                                        r13 = nil
                                                        r3 = r26 == r13
                                                        state = r3 and (199) or (200)
                                                        r14 = ReturnVal
                                                    end
                                                end
                                            else
                                                if state == 198 then
                                                    r26 = nil
                                                    r5 = nil
                                                    r21 = nil
                                                    r15 = nil
                                                    state = 195
                                                end
                                            end
                                        end
                                    else
                                        if state <= 201 then
                                            if state <= 200 then
                                                if state <= 199 then
                                                    if state == 199 then
                                                        r14 = nil
                                                        state = 198
                                                    end
                                                else
                                                    if state == 200 then
                                                        r2 = upvalueValues[upvalues[1]]
                                                        r32 = upvalueValues[upvalues[2]]
                                                        r33 = "U\187g\008"
                                                        r16 = 29275329377600
                                                        r28 = r32(r33, r16)
                                                        r31 = r2[r28]
                                                        r29 = r14[r31]
                                                        r2 = upvalueValues[upvalues[1]]
                                                        r32 = upvalueValues[upvalues[2]]
                                                        r33 = "\242\196I\155\236\t"
                                                        r16 = 847986000266
                                                        r28 = r32(r33, r16)
                                                        r31 = r2[r28]
                                                        r6 = r29 == r31
                                                        r13 = state
                                                        state = r6 and (201) or (202)
                                                        r3 = r6
                                                    end
                                                end
                                            else
                                                if state == 201 then
                                                    r16 = upvalueValues[upvalues[1]]
                                                    r25 = upvalueValues[upvalues[2]]
                                                    r1 = "\173\130\231\144\173\219"
                                                    r4 = 31375976528146
                                                    r12 = r25(r1, r4)
                                                    r33 = r16[r12]
                                                    r28 = r14[r33]
                                                    r16 = upvalueValues[upvalues[1]]
                                                    r25 = upvalueValues[upvalues[2]]
                                                    r4 = 24693938711787
                                                    r1 = "\155\147\204\142"
                                                    r12 = r25(r1, r4)
                                                    r33 = r16[r12]
                                                    r32 = r28[r33]
                                                    r33 = upvalueValues[upvalues[1]]
                                                    r16 = upvalueValues[upvalues[2]]
                                                    r1 = 7928011738731
                                                    r12 = "\222n\251\158\215/\211\182\136I\193\208"
                                                    r25 = r16(r12, r1)
                                                    r28 = r33[r25]
                                                    r2 = r32[r28]
                                                    r28 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r12 = 23261816269392
                                                    r25 = "\147\198\156\t\169\242"
                                                    r16 = r33(r25, r12)
                                                    r32 = r28[r16]
                                                    r31 = r2[r32]
                                                    r32 = upvalueValues[upvalues[1]]
                                                    r28 = upvalueValues[upvalues[2]]
                                                    r16 = "c\016\228\175]\003\172"
                                                    r25 = 13976997009772
                                                    r33 = r28(r16, r25)
                                                    r2 = r32[r33]
                                                    r29 = r31[r2]
                                                    r31 = false
                                                    r6 = r29 == r31
                                                    r3 = r6
                                                    state = 202
                                                end
                                            end
                                        else
                                            if state <= 203 then
                                                if state <= 202 then
                                                    if state == 202 then
                                                        state = r13
                                                        state = r3 and (203) or (204)
                                                    end
                                                else
                                                    if state == 203 then
                                                        r13 = "firetouchinterest"
                                                        r3 = _env[r13]
                                                        r28 = "game"
                                                        r32 = _env[r28]
                                                        r33 = upvalueValues[upvalues[1]]
                                                        r16 = upvalueValues[upvalues[2]]
                                                        r12 = "R\206\026b\n/K"
                                                        r1 = 4285260122059
                                                        r25 = r16(r12, r1)
                                                        r28 = r33[r25]
                                                        r2 = r32[r28]
                                                        r28 = upvalueValues[upvalues[1]]
                                                        r33 = upvalueValues[upvalues[2]]
                                                        r12 = 12545177802449
                                                        r25 = "\170\172F\143\228\0280mJ\129\184"
                                                        r16 = r33(r25, r12)
                                                        r32 = r28[r16]
                                                        r31 = r2[r32]
                                                        r32 = upvalueValues[upvalues[1]]
                                                        r28 = upvalueValues[upvalues[2]]
                                                        r25 = 30384047093572
                                                        r16 = "\162s\187\194\248\221\134\150R"
                                                        r33 = r28(r16, r25)
                                                        r2 = r32[r33]
                                                        r29 = r31[r2]
                                                        r2 = upvalueValues[upvalues[1]]
                                                        r32 = upvalueValues[upvalues[2]]
                                                        r16 = 33931416452536
                                                        r33 = "\212U\131\176\138o}n\004\020\159'V\207\222\249"
                                                        r28 = r32(r33, r16)
                                                        r31 = r2[r28]
                                                        r6 = r29[r31]
                                                        r29 = 0
                                                        r13 = r3(r6, r14, r29)
                                                        r13 = "wait"
                                                        r3 = _env[r13]
                                                        r13 = r3()
                                                        r13 = "firetouchinterest"
                                                        r3 = _env[r13]
                                                        r28 = "game"
                                                        r32 = _env[r28]
                                                        r33 = upvalueValues[upvalues[1]]
                                                        r16 = upvalueValues[upvalues[2]]
                                                        r12 = "\147Wt\241Z\0311"
                                                        r1 = 6964668714155
                                                        r25 = r16(r12, r1)
                                                        r28 = r33[r25]
                                                        r2 = r32[r28]
                                                        r28 = upvalueValues[upvalues[1]]
                                                        r33 = upvalueValues[upvalues[2]]
                                                        r25 = "\247H\211m\249\208I\179\213y\223"
                                                        r12 = 15025212726100
                                                        r16 = r33(r25, r12)
                                                        r32 = r28[r16]
                                                        r31 = r2[r32]
                                                        r32 = upvalueValues[upvalues[1]]
                                                        r28 = upvalueValues[upvalues[2]]
                                                        r25 = 29095553479916
                                                        r16 = "\185F\147f\245jl\007\163"
                                                        r33 = r28(r16, r25)
                                                        r2 = r32[r33]
                                                        r29 = r31[r2]
                                                        r2 = upvalueValues[upvalues[1]]
                                                        r32 = upvalueValues[upvalues[2]]
                                                        r33 = "\186e\021l\030]\189S\028\248\237\205\241C,P"
                                                        r16 = 30246133528324
                                                        r28 = r32(r33, r16)
                                                        r31 = r2[r28]
                                                        r6 = r29[r31]
                                                        r29 = 1
                                                        r13 = r3(r6, r14, r29)
                                                        state = 204
                                                    end
                                                end
                                            else
                                                if state == 204 then
                                                    r14 = nil
                                                    state = 196
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure4 entry 11443134 -> 205, states 205-214
                                if state <= 209 then
                                    if state <= 207 then
                                        if state <= 206 then
                                            if state <= 205 then
                                                if state == 205 then -- entry 11443134 -> 205
                                                    r21 = "getgenv"
                                                    r5 = _env[r21]
                                                    r21 = r5()
                                                    r26 = upvalueValues[upvalues[1]]
                                                    r15 = upvalueValues[upvalues[2]]
                                                    r3 = "\219\226\208f\026\219N\229\183e"
                                                    r13 = 31582463097202
                                                    r14 = r15(r3, r13)
                                                    r5 = r26[r14]
                                                    ReturnVal = r21[r5]
                                                    r5 = nil
                                                    state = ReturnVal ~= r5
                                                    state = state and (206) or (207)
                                                end
                                            else
                                                if state == 206 then
                                                    r21 = "getgenv"
                                                    r5 = _env[r21]
                                                    r21 = r5()
                                                    r26 = upvalueValues[upvalues[1]]
                                                    r15 = upvalueValues[upvalues[2]]
                                                    r13 = 5603154364977
                                                    r3 = "[D\199\002\154\218\127\183\027\198"
                                                    r14 = r15(r3, r13)
                                                    r5 = r26[r14]
                                                    ReturnVal = r21[r5]
                                                    r21 = upvalueValues[upvalues[1]]
                                                    r26 = upvalueValues[upvalues[2]]
                                                    r14 = "$#\197\011\220\128\246\232\210\145\169\137_"
                                                    r3 = 12277906429525
                                                    r15 = r26(r14, r3)
                                                    r5 = r21[r15]
                                                    state = ReturnVal[r5]
                                                    r5 = state
                                                    ReturnVal = "pairs"
                                                    state = _env[ReturnVal]
                                                    r14 = "GetDescendants"
                                                    r14 = r5[r14]
                                                    r15 = {
                                                        r14(r5)
                                                    }
                                                    r14 = {
                                                        state(unpack(r15))
                                                    }
                                                    ReturnVal = r14[1]
                                                    r21 = r14[2]
                                                    r15 = ReturnVal
                                                    r26 = r14[3]
                                                    state = 208
                                                end
                                            end
                                        else
                                            if state == 207 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        if state <= 208 then
                                            if state == 208 then
                                                state = true
                                                state = state and (209) or (210)
                                            end
                                        else
                                            if state == 209 then
                                                r3 = {
                                                    r15(r21, r26)
                                                }
                                                ReturnVal = r3[2]
                                                state = nil
                                                r14 = state
                                                state = r3[1]
                                                r26 = state
                                                r13 = nil
                                                r3 = r26 == r13
                                                state = r3 and (211) or (212)
                                                r14 = ReturnVal
                                            end
                                        end
                                    end
                                else
                                    if state <= 212 then
                                        if state <= 211 then
                                            if state <= 210 then
                                                if state == 210 then
                                                    r5 = nil
                                                    r15 = nil
                                                    r21 = nil
                                                    r26 = nil
                                                    state = 207
                                                end
                                            else
                                                if state == 211 then
                                                    r14 = nil
                                                    state = 210
                                                end
                                            end
                                        else
                                            if state == 212 then
                                                r29 = upvalueValues[upvalues[1]]
                                                r31 = upvalueValues[upvalues[2]]
                                                r28 = 10375088001759
                                                r32 = "\189\213\179\001"
                                                r2 = r31(r32, r28)
                                                r6 = r29[r2]
                                                r13 = r14[r6]
                                                r29 = upvalueValues[upvalues[1]]
                                                r31 = upvalueValues[upvalues[2]]
                                                r28 = 9888414503420
                                                r32 = "\164W7\250\203"
                                                r2 = r31(r32, r28)
                                                r6 = r29[r2]
                                                r3 = r13 == r6
                                                state = r3 and (213) or (214)
                                            end
                                        end
                                    else
                                        if state <= 213 then
                                            if state == 213 then
                                                r13 = "firetouchinterest"
                                                r3 = _env[r13]
                                                r28 = "game"
                                                r32 = _env[r28]
                                                r33 = upvalueValues[upvalues[1]]
                                                r16 = upvalueValues[upvalues[2]]
                                                r1 = 24823084231975
                                                r12 = "\0218\142\195\145\157="
                                                r25 = r16(r12, r1)
                                                r28 = r33[r25]
                                                r2 = r32[r28]
                                                r28 = upvalueValues[upvalues[1]]
                                                r33 = upvalueValues[upvalues[2]]
                                                r12 = 5574762990115
                                                r25 = "\127L\148V5\199\022\152\1656\202"
                                                r16 = r33(r25, r12)
                                                r32 = r28[r16]
                                                r31 = r2[r32]
                                                r32 = upvalueValues[upvalues[1]]
                                                r28 = upvalueValues[upvalues[2]]
                                                r25 = 8635458850741
                                                r16 = "l\027\230_\246lR\145\209"
                                                r33 = r28(r16, r25)
                                                r2 = r32[r33]
                                                r29 = r31[r2]
                                                r2 = upvalueValues[upvalues[1]]
                                                r32 = upvalueValues[upvalues[2]]
                                                r33 = "vl\029*P\255\020%<L\148\254\145\193\133\177"
                                                r16 = 31787752946130
                                                r28 = r32(r33, r16)
                                                r31 = r2[r28]
                                                r6 = r29[r31]
                                                r2 = upvalueValues[upvalues[1]]
                                                r32 = upvalueValues[upvalues[2]]
                                                r33 = "\226X)\221\250o"
                                                r16 = 20599975716216
                                                r28 = r32(r33, r16)
                                                r31 = r2[r28]
                                                r29 = r14[r31]
                                                r31 = 0
                                                r13 = r3(r6, r29, r31)
                                                r13 = "wait"
                                                r3 = _env[r13]
                                                r6 = 1
                                                r13 = r3(r6)
                                                r13 = "firetouchinterest"
                                                r3 = _env[r13]
                                                r28 = "game"
                                                r32 = _env[r28]
                                                r33 = upvalueValues[upvalues[1]]
                                                r16 = upvalueValues[upvalues[2]]
                                                r12 = "@\142\172<^bm"
                                                r1 = 2546640241825
                                                r25 = r16(r12, r1)
                                                r28 = r33[r25]
                                                r2 = r32[r28]
                                                r28 = upvalueValues[upvalues[1]]
                                                r33 = upvalueValues[upvalues[2]]
                                                r12 = 26849514385622
                                                r25 = "\t\140\031\216\183\001\131-7~\r"
                                                r16 = r33(r25, r12)
                                                r32 = r28[r16]
                                                r31 = r2[r32]
                                                r32 = upvalueValues[upvalues[1]]
                                                r28 = upvalueValues[upvalues[2]]
                                                r25 = 15028677008214
                                                r16 = "\137:\193\241\190\006B\252\246"
                                                r33 = r28(r16, r25)
                                                r2 = r32[r33]
                                                r29 = r31[r2]
                                                r2 = upvalueValues[upvalues[1]]
                                                r32 = upvalueValues[upvalues[2]]
                                                r16 = 23821136505684
                                                r33 = "{;|\030\174\016O\154\203pv\023\005\180-\024"
                                                r28 = r32(r33, r16)
                                                r31 = r2[r28]
                                                r6 = r29[r31]
                                                r2 = upvalueValues[upvalues[1]]
                                                r32 = upvalueValues[upvalues[2]]
                                                r16 = 12503202682558
                                                r33 = "!H\139\219dV"
                                                r28 = r32(r33, r16)
                                                r31 = r2[r28]
                                                r29 = r14[r31]
                                                r31 = 1
                                                r13 = r3(r6, r29, r31)
                                                state = 214
                                            end
                                        else
                                            if state == 214 then
                                                r14 = nil
                                                state = 208
                                            end
                                        end
                                    end
                                end
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
        upvalueRefCounts = {}
        createClosure1 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1)
                return vm(entryId, {
                    arg1
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
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 2987670
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 2987670
                    end
                })
            end
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
        currentUpvalueId = 0
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)