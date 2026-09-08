return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalue, vm, createClosure, allocUpvalue, createClosure3, createClosure0, upvalueValues, createUpvalueProxy, createClosure1, createClosure5, createClosure2, createClosure4, upvalueRefCounts, createClosure6, createClosure7, releaseUpvalues, currentUpvalueId)
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, ReturnVal, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68
            while state do
                if state <= 139 then
                    if state <= 57 then
                        if state <= 40 then
                            if state <= 39 then
                                if state <= 38 then
                                    -- root entry 12832489 -> 1, states 1-38
                                    if state <= 19 then
                                        if state <= 10 then
                                            if state <= 5 then
                                                if state <= 3 then
                                                    if state <= 2 then
                                                        if state <= 1 then
                                                            if state == 1 then -- entry 12832489 -> 1
                                                                r23 = allocUpvalue()
                                                                r7 = allocUpvalue()
                                                                r20 = createClosure0(39, {
                                                                    r7
                                                                })
                                                                r41 = allocUpvalue()
                                                                state = true
                                                                upvalueValues[r23] = state
                                                                r2 = "string"
                                                                ReturnVal = _env[r2]
                                                                r2 = "gmatch"
                                                                state = ReturnVal[r2]
                                                                r2 = allocUpvalue()
                                                                upvalueValues[r2] = state
                                                                state = createClosure4(40, {})
                                                                upvalueValues[r41] = state
                                                                state = false
                                                                upvalueValues[r7] = state
                                                                r43 = "pcall"
                                                                r9 = _env[r43]
                                                                r43 = r9(r20)
                                                                state = r43 and (2) or (3)
                                                                r22 = args
                                                                ReturnVal = r43
                                                            end
                                                        else
                                                            if state == 2 then
                                                                r9 = upvalueValues[r7]
                                                                ReturnVal = r9
                                                                state = 3
                                                            end
                                                        end
                                                    else
                                                        if state == 3 then
                                                            r9 = ReturnVal
                                                            r43 = "math"
                                                            ReturnVal = _env[r43]
                                                            r43 = "random"
                                                            state = ReturnVal[r43]
                                                            r43 = allocUpvalue()
                                                            upvalueValues[r43] = state
                                                            r20 = "table"
                                                            ReturnVal = _env[r20]
                                                            r20 = "concat"
                                                            state = ReturnVal[r20]
                                                            r20 = state
                                                            r3 = state
                                                            r26 = "table"
                                                            r60 = _env[r26]
                                                            state = r60 and (4) or (5)
                                                            r28 = r60
                                                        end
                                                    end
                                                else
                                                    if state <= 4 then
                                                        if state == 4 then
                                                            r38 = "table"
                                                            r26 = _env[r38]
                                                            r38 = "unpack"
                                                            r60 = r26[r38]
                                                            r28 = r60
                                                            state = 5
                                                        end
                                                    else
                                                        if state == 5 then
                                                            state = r3
                                                            state = r28 and (6) or (7)
                                                            ReturnVal = r28
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 8 then
                                                    if state <= 7 then
                                                        if state <= 6 then
                                                            if state == 6 then
                                                                r28 = allocUpvalue()
                                                                upvalueValues[r28] = ReturnVal
                                                                state = upvalueValues[r43]
                                                                r60 = 65
                                                                r3 = 3
                                                                ReturnVal = state(r3, r60)
                                                                r3 = allocUpvalue()
                                                                r54 = createClosure2(41, {})
                                                                upvalueValues[r3] = ReturnVal
                                                                state = 0
                                                                r60 = state
                                                                state = 0
                                                                r38 = "pcall"
                                                                ReturnVal = _env[r38]
                                                                r38 = {
                                                                    ReturnVal(r54)
                                                                }
                                                                r26 = state
                                                                state = {
                                                                    unpack(r38)
                                                                }
                                                                r38 = state
                                                                ReturnVal = 2
                                                                state = r38[ReturnVal]
                                                                r54 = state
                                                                ReturnVal = "tonumber"
                                                                state = _env[ReturnVal]
                                                                r68 = upvalueValues[r2]
                                                                r49 = "tostring"
                                                                r11 = _env[r49]
                                                                r49 = r11(r54)
                                                                r11 = ":(%d*):"
                                                                r18 = r68(r49, r11)
                                                                r68 = {
                                                                    r18()
                                                                }
                                                                ReturnVal = state(unpack(r68))
                                                                r68 = allocUpvalue()
                                                                upvalueValues[r68] = ReturnVal
                                                                r18 = upvalueValues[r3]
                                                                r11 = r18
                                                                r18 = 1
                                                                r49 = r18
                                                                r18 = 0
                                                                r25 = r49 < r18
                                                                ReturnVal = 1
                                                                r18 = ReturnVal - r49
                                                                state = 8
                                                            end
                                                        else
                                                            if state == 7 then
                                                                r3 = "unpack"
                                                                r28 = _env[r3]
                                                                ReturnVal = r28
                                                                state = 6
                                                            end
                                                        end
                                                    else
                                                        if state == 8 then
                                                            r18 = r18 + r49
                                                            r65 = not r25
                                                            ReturnVal = r18 <= r11
                                                            ReturnVal = r65 and ReturnVal
                                                            r65 = r18 >= r11
                                                            r65 = r25 and r65
                                                            ReturnVal = r65 or ReturnVal
                                                            r65 = (9)
                                                            state = ReturnVal and r65
                                                            ReturnVal = (10)
                                                            state = state or ReturnVal
                                                        end
                                                    end
                                                else
                                                    if state <= 9 then
                                                        if state == 9 then
                                                            r65 = allocUpvalue()
                                                            upvalueValues[r65] = r18
                                                            r31 = "math"
                                                            ReturnVal = _env[r31]
                                                            r31 = "random"
                                                            state = ReturnVal[r31]
                                                            r21 = 100
                                                            r31 = 1
                                                            ReturnVal = state(r31, r21)
                                                            r31 = allocUpvalue()
                                                            upvalueValues[r31] = ReturnVal
                                                            state = upvalueValues[r43]
                                                            r35 = 255
                                                            r21 = 0
                                                            ReturnVal = state(r21, r35)
                                                            r21 = allocUpvalue()
                                                            upvalueValues[r21] = ReturnVal
                                                            state = upvalueValues[r43]
                                                            r55 = upvalueValues[r31]
                                                            r35 = 1
                                                            ReturnVal = state(r35, r55)
                                                            r35 = allocUpvalue()
                                                            upvalueValues[r35] = ReturnVal
                                                            ReturnVal = upvalueValues[r43]
                                                            r14 = 1
                                                            r33 = 2
                                                            r55 = ReturnVal(r14, r33)
                                                            ReturnVal = 1
                                                            state = r55 == ReturnVal
                                                            r55 = allocUpvalue()
                                                            upvalueValues[r55] = state
                                                            state = "gsub"
                                                            state = r54[state]
                                                            r59 = "tostring"
                                                            r1 = _env[r59]
                                                            r46 = upvalueValues[r43]
                                                            r57 = 0
                                                            r67 = 10000
                                                            r17 = {
                                                                r46(r57, r67)
                                                            }
                                                            r59 = r1(unpack(r17))
                                                            r1 = ":"
                                                            r12 = r59 .. r1
                                                            r33 = ":"
                                                            r14 = r33 .. r12
                                                            ReturnVal = ":(%d*):"
                                                            state = state(r54, ReturnVal, r14)
                                                            r14 = allocUpvalue()
                                                            upvalueValues[r14] = state
                                                            r33 = "pcall"
                                                            ReturnVal = _env[r33]
                                                            r12 = createClosure2(42, {
                                                                r43,
                                                                r65,
                                                                r3,
                                                                r2,
                                                                r23,
                                                                r68,
                                                                r55,
                                                                r14,
                                                                r31,
                                                                r35,
                                                                r21,
                                                                r28
                                                            })
                                                            r33 = {
                                                                ReturnVal(r12)
                                                            }
                                                            state = {
                                                                unpack(r33)
                                                            }
                                                            r33 = state
                                                            state = upvalueValues[r55]
                                                            state = state and (11) or (12)
                                                        end
                                                    else
                                                        if state == 10 then
                                                            r11 = upvalueValues[r23]
                                                            state = r11 and (13) or (14)
                                                            r18 = r11
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 15 then
                                                if state <= 13 then
                                                    if state <= 12 then
                                                        if state <= 11 then
                                                            if state == 11 then
                                                                r12 = upvalueValues[r23]
                                                                state = r12 and (15) or (16)
                                                                ReturnVal = r12
                                                            end
                                                        else
                                                            if state == 12 then
                                                                r1 = upvalueValues[r23]
                                                                state = r1 and (17) or (18)
                                                                r12 = r1
                                                            end
                                                        end
                                                    else
                                                        if state == 13 then
                                                            r11 = r60 == r26
                                                            r18 = r11
                                                            state = 14
                                                        end
                                                    end
                                                else
                                                    if state <= 14 then
                                                        if state == 14 then
                                                            upvalueValues[r23] = r18
                                                            state = upvalueValues[r23]
                                                            state = state and (19) or (20)
                                                        end
                                                    else
                                                        if state == 15 then
                                                            r17 = 1
                                                            r46 = r33[r17]
                                                            r17 = false
                                                            r59 = r46 == r17
                                                            r1 = state
                                                            state = r59 and (21) or (22)
                                                            r12 = r59
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 17 then
                                                    if state <= 16 then
                                                        if state == 16 then
                                                            upvalueValues[r23] = ReturnVal
                                                            state = 23
                                                        end
                                                    else
                                                        if state == 17 then
                                                            r59 = 1
                                                            r1 = r33[r59]
                                                            r12 = r1
                                                            state = 18
                                                        end
                                                    end
                                                else
                                                    if state <= 18 then
                                                        if state == 18 then
                                                            upvalueValues[r23] = r12
                                                            r17 = upvalueValues[r35]
                                                            r57 = 1
                                                            r46 = r17 + r57
                                                            r59 = r33[r46]
                                                            r1 = r60 + r59
                                                            r59 = 256
                                                            state = r1 % r59
                                                            r60 = state
                                                            r46 = upvalueValues[r21]
                                                            r59 = r26 + r46
                                                            r46 = 256
                                                            r1 = r59 % r46
                                                            r26 = r1
                                                            state = 23
                                                        end
                                                    else
                                                        if state == 19 then
                                                            state = 24
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 29 then
                                            if state <= 24 then
                                                if state <= 22 then
                                                    if state <= 21 then
                                                        if state <= 20 then
                                                            if state == 20 then
                                                                state = true
                                                                state = 25
                                                            end
                                                        else
                                                            if state == 21 then
                                                                r17 = 2
                                                                r46 = r33[r17]
                                                                r17 = upvalueValues[r14]
                                                                r59 = r46 == r17
                                                                r12 = r59
                                                                state = 22
                                                            end
                                                        end
                                                    else
                                                        if state == 22 then
                                                            state = r1
                                                            ReturnVal = r12
                                                            state = 16
                                                        end
                                                    end
                                                else
                                                    if state <= 23 then
                                                        if state == 23 then
                                                            r65 = releaseUpvalue(r65)
                                                            r35 = releaseUpvalue(r35)
                                                            r31 = releaseUpvalue(r31)
                                                            r33 = nil
                                                            r55 = releaseUpvalue(r55)
                                                            r14 = releaseUpvalue(r14)
                                                            r21 = releaseUpvalue(r21)
                                                            state = 8
                                                        end
                                                    else
                                                        if state == 24 then
                                                            r2 = releaseUpvalue(r2)
                                                            r43 = releaseUpvalue(r43)
                                                            r26 = nil
                                                            r26 = allocUpvalue()
                                                            r23 = releaseUpvalue(r23)
                                                            r28 = releaseUpvalue(r28)
                                                            r68 = releaseUpvalue(r68)
                                                            r3 = releaseUpvalue(r3)
                                                            r7 = releaseUpvalue(r7)
                                                            r41 = releaseUpvalue(r41)
                                                            r41 = allocUpvalue()
                                                            r60 = nil
                                                            r60 = {}
                                                            r23 = nil
                                                            upvalueValues[r41] = r23
                                                            r3 = allocUpvalue()
                                                            r23 = allocUpvalue()
                                                            r2 = nil
                                                            upvalueValues[r23] = r2
                                                            r9 = nil
                                                            r9 = "math"
                                                            r7 = _env[r9]
                                                            r9 = "floor"
                                                            r2 = r7[r9]
                                                            r7 = allocUpvalue()
                                                            upvalueValues[r7] = r2
                                                            r43 = "math"
                                                            r9 = _env[r43]
                                                            r43 = "random"
                                                            r2 = r9[r43]
                                                            r20 = nil
                                                            r20 = "table"
                                                            r43 = _env[r20]
                                                            r38 = nil
                                                            r38 = {}
                                                            r20 = "remove"
                                                            r9 = r43[r20]
                                                            r28 = "string"
                                                            r20 = _env[r28]
                                                            r28 = "char"
                                                            r43 = r20[r28]
                                                            r28 = allocUpvalue()
                                                            r20 = 0
                                                            upvalueValues[r28] = r20
                                                            r20 = 2
                                                            upvalueValues[r3] = r20
                                                            upvalueValues[r26] = r60
                                                            r20 = {}
                                                            r68 = 256
                                                            r25 = r68
                                                            r68 = 1
                                                            r65 = r68
                                                            r68 = 0
                                                            r31 = r65 < r68
                                                            r54 = nil
                                                            r54 = 1
                                                            r68 = r54 - r65
                                                            r60 = 0
                                                            state = 26
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 27 then
                                                    if state <= 26 then
                                                        if state <= 25 then
                                                            if state == 25 then
                                                                state = createClosure2(54, {
                                                                    r41
                                                                })
                                                                r11 = {
                                                                    state()
                                                                }
                                                                ReturnVal = {
                                                                    unpack(r11)
                                                                }
                                                                state = nil
                                                            end
                                                        else
                                                            if state == 26 then
                                                                r21 = not r31
                                                                r68 = r68 + r65
                                                                r54 = r68 <= r25
                                                                r54 = r21 and r54
                                                                r21 = r68 >= r25
                                                                r21 = r31 and r21
                                                                r54 = r21 or r54
                                                                r21 = (27)
                                                                state = r54 and r21
                                                                r54 = (28)
                                                                state = state or r54
                                                            end
                                                        end
                                                    else
                                                        if state == 27 then
                                                            r54 = r68
                                                            r21 = r54
                                                            r38[r54] = r21
                                                            r54 = nil
                                                            state = 26
                                                        end
                                                    end
                                                else
                                                    if state <= 28 then
                                                        if state == 28 then
                                                            r68 = #r38
                                                            r25 = 0
                                                            r54 = r68 == r25
                                                            state = 29
                                                        end
                                                    else
                                                        if state == 29 then
                                                            r25 = #r38
                                                            r68 = 1
                                                            r54 = r2(r68, r25)
                                                            r68 = r9(r38, r54)
                                                            r25 = upvalueValues[r26]
                                                            r21 = 1
                                                            r31 = r68 - r21
                                                            r65 = r43(r31)
                                                            r25[r68] = r65
                                                            r54 = nil
                                                            r68 = nil
                                                            state = 30
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 34 then
                                                if state <= 32 then
                                                    if state <= 31 then
                                                        if state <= 30 then
                                                            if state == 30 then
                                                                r68 = #r38
                                                                r25 = 0
                                                                r54 = r68 == r25
                                                                state = r54 and (31) or (29)
                                                            end
                                                        else
                                                            if state == 31 then
                                                                r54 = {}
                                                                r65 = allocUpvalue()
                                                                r68 = allocUpvalue()
                                                                r25 = createClosure5(58, {
                                                                    r68,
                                                                    r28,
                                                                    r3,
                                                                    r7
                                                                })
                                                                upvalueValues[r68] = r54
                                                                r54 = allocUpvalue()
                                                                r7 = releaseUpvalue(r7)
                                                                upvalueValues[r54] = r25
                                                                r21 = {}
                                                                r25 = {}
                                                                upvalueValues[r65] = r25
                                                                r31 = "setmetatable"
                                                                r25 = _env[r31]
                                                                r14 = upvalueValues[r65]
                                                                r59 = nil
                                                                r55 = "__index"
                                                                r33 = "__metatable"
                                                                r35 = {
                                                                    [r55] = r14,
                                                                    [r33] = r59
                                                                }
                                                                r31 = r25(r21, r35)
                                                                upvalueValues[r41] = r31
                                                                r25 = createClosure7(64, {
                                                                    r65,
                                                                    r68,
                                                                    r26,
                                                                    r28,
                                                                    r3,
                                                                    r54
                                                                })
                                                                r26 = releaseUpvalue(r26)
                                                                r68 = releaseUpvalue(r68)
                                                                r3 = releaseUpvalue(r3)
                                                                upvalueValues[r23] = r25
                                                                r7 = "game"
                                                                r2 = nil
                                                                r2 = _env[r7]
                                                                r54 = releaseUpvalue(r54)
                                                                r65 = releaseUpvalue(r65)
                                                                r28 = releaseUpvalue(r28)
                                                                r43 = nil
                                                                r43 = upvalueValues[r41]
                                                                r20 = nil
                                                                r20 = upvalueValues[r23]
                                                                r60 = nil
                                                                r60 = 30495721305976
                                                                r3 = "\011&/x\r\212\138"
                                                                r28 = r20(r3, r60)
                                                                r7 = "GetService"
                                                                r7 = r2[r7]
                                                                r9 = nil
                                                                r9 = r43[r28]
                                                                r7 = r7(r2, r9)
                                                                r2 = allocUpvalue()
                                                                upvalueValues[r2] = r7
                                                                r9 = "game"
                                                                r7 = _env[r9]
                                                                r20 = upvalueValues[r41]
                                                                r28 = upvalueValues[r23]
                                                                r26 = 34214241926716
                                                                r60 = "+\166\190\023\026q\252\029K\\\130"
                                                                r3 = r28(r60, r26)
                                                                r43 = r20[r3]
                                                                r9 = "GetService"
                                                                r9 = r7[r9]
                                                                r9 = r9(r7, r43)
                                                                r7 = allocUpvalue()
                                                                upvalueValues[r7] = r9
                                                                r43 = "game"
                                                                r9 = _env[r43]
                                                                r28 = upvalueValues[r41]
                                                                r3 = upvalueValues[r23]
                                                                r38 = nil
                                                                r38 = 23411822520981
                                                                r26 = "\169\169\171\189\237\030\153i\140\145\208\181"
                                                                r60 = r3(r26, r38)
                                                                r43 = "GetService"
                                                                r43 = r9[r43]
                                                                r20 = r28[r60]
                                                                r43 = r43(r9, r20)
                                                                r9 = allocUpvalue()
                                                                upvalueValues[r9] = r43
                                                                r20 = "game"
                                                                r43 = _env[r20]
                                                                r3 = upvalueValues[r41]
                                                                r60 = upvalueValues[r23]
                                                                r20 = "GetService"
                                                                r20 = r43[r20]
                                                                r54 = 22423413532873
                                                                r38 = "\1412\1876wv\228\246\204\228\000}\239\0065\008\002="
                                                                r26 = r60(r38, r54)
                                                                r28 = r3[r26]
                                                                r20 = r20(r43, r28)
                                                                r43 = allocUpvalue()
                                                                upvalueValues[r43] = r20
                                                                r28 = "game"
                                                                r20 = _env[r28]
                                                                r60 = upvalueValues[r41]
                                                                r26 = upvalueValues[r23]
                                                                r68 = 8137961344717
                                                                r54 = "Qs\002f\210\233b\1825\141\020yT\1364\011"
                                                                r38 = r26(r54, r68)
                                                                r3 = r60[r38]
                                                                r28 = "GetService"
                                                                r28 = r20[r28]
                                                                r28 = r28(r20, r3)
                                                                r20 = allocUpvalue()
                                                                upvalueValues[r20] = r28
                                                                r3 = "game"
                                                                r28 = _env[r3]
                                                                r26 = upvalueValues[r41]
                                                                r38 = upvalueValues[r23]
                                                                r25 = 27727746593391
                                                                r68 = "\152\178&\026\002"
                                                                r54 = r38(r68, r25)
                                                                r60 = r26[r54]
                                                                r3 = "GetService"
                                                                r3 = r28[r3]
                                                                r3 = r3(r28, r60)
                                                                r28 = allocUpvalue()
                                                                upvalueValues[r28] = r3
                                                                r60 = upvalueValues[r2]
                                                                r38 = upvalueValues[r41]
                                                                r54 = upvalueValues[r23]
                                                                r65 = 32421511068409
                                                                r25 = "o\163\1874\250\228X\136\225\197\168"
                                                                r68 = r54(r25, r65)
                                                                r26 = r38[r68]
                                                                r3 = r60[r26]
                                                                r60 = allocUpvalue()
                                                                upvalueValues[r60] = r3
                                                                r3 = upvalueValues[r60]
                                                                r54 = upvalueValues[r41]
                                                                r68 = upvalueValues[r23]
                                                                r21 = 31892466399747
                                                                r65 = "gYh\199O\023\163S\138"
                                                                r25 = r68(r65, r21)
                                                                r38 = r54[r25]
                                                                r26 = "WaitForChild"
                                                                r26 = r3[r26]
                                                                r54 = 10
                                                                r26 = r26(r3, r38, r54)
                                                                r3 = allocUpvalue()
                                                                upvalueValues[r3] = r26
                                                                r38 = upvalueValues[r3]
                                                                r26 = not r38
                                                                state = r26 and (32) or (33)
                                                            end
                                                        end
                                                    else
                                                        if state == 32 then
                                                            r38 = "warn"
                                                            r26 = _env[r38]
                                                            r68 = upvalueValues[r41]
                                                            ReturnVal = {}
                                                            r25 = upvalueValues[r23]
                                                            r35 = 28003768693488
                                                            r21 = ",\127\17654\020\187\141g2\031\nZFo\162\169\011\128l"
                                                            r65 = r25(r21, r35)
                                                            r54 = r68[r65]
                                                            r38 = r26(r54)
                                                            state = nil
                                                        end
                                                    end
                                                else
                                                    if state <= 33 then
                                                        if state == 33 then
                                                            r38 = "getgenv"
                                                            r26 = _env[r38]
                                                            r38 = r26()
                                                            r54 = upvalueValues[r41]
                                                            r68 = upvalueValues[r23]
                                                            r65 = "\171~\016C\160\016\018\187"
                                                            r21 = 5716943686246
                                                            r25 = r68(r65, r21)
                                                            r26 = r54[r25]
                                                            r68 = upvalueValues[r41]
                                                            r25 = upvalueValues[r23]
                                                            r35 = 11929309631923
                                                            r21 = "\001A2\140'd\140%\158"
                                                            r65 = r25(r21, r35)
                                                            r54 = r68[r65]
                                                            r38[r26] = r54
                                                            r38 = "getgenv"
                                                            r26 = _env[r38]
                                                            r38 = r26()
                                                            r54 = upvalueValues[r41]
                                                            r68 = upvalueValues[r23]
                                                            r65 = "GnuO\186!`'\146f\148\222\185\210"
                                                            r21 = 15121925528449
                                                            r25 = r68(r65, r21)
                                                            r26 = r54[r25]
                                                            r68 = upvalueValues[r41]
                                                            r25 = upvalueValues[r23]
                                                            r21 = "&\158\022]|5\149n@qI\237E\221\205\173/d\tL\181\239\236\004 \001t\138H\184s~?;\173l\195\202 \225\213\128\012+\222\128F\015\233-s2\175\197\241\156\198\253\128\176\231\216\246%\224\143-\130D\137=\199\199(K\167\235\197\199\144\166\243&\142\250]G\173T \139\1835\175\244\020f$\234N\020 %\227d\017\211\151\139m\030\251\230\003\225\015R\139z\233\127"
                                                            r35 = 7018945793220
                                                            r65 = r25(r21, r35)
                                                            r54 = r68[r65]
                                                            r38[r26] = r54
                                                            r38 = "getgenv"
                                                            r26 = _env[r38]
                                                            r38 = r26()
                                                            r54 = upvalueValues[r41]
                                                            r68 = upvalueValues[r23]
                                                            r65 = "O\031\214\179\249\146\203!#\205\198R\240"
                                                            r21 = 34949558157202
                                                            r25 = r68(r65, r21)
                                                            r26 = r54[r25]
                                                            r54 = false
                                                            r38[r26] = r54
                                                            r38 = upvalueValues[r41]
                                                            r54 = upvalueValues[r23]
                                                            r25 = "%\232\240Z/\159i\184\029\014\214 $B\239\180\224>\181s\n\1485\021R@]\221\015z\248\195c\222N\225\143=!:G\172\190\\Xr\197\190\tZ\2127\001\201\026o/\224\011\1359\219@\182\131u\201\140\154\023"
                                                            r65 = 8940324163651
                                                            r68 = r54(r25, r65)
                                                            r26 = r38[r68]
                                                            r38 = allocUpvalue()
                                                            upvalueValues[r38] = r26
                                                            r54 = allocUpvalue()
                                                            r26 = 0
                                                            upvalueValues[r54] = r26
                                                            r68 = allocUpvalue()
                                                            r26 = false
                                                            upvalueValues[r68] = r26
                                                            r25 = upvalueValues[r41]
                                                            r65 = upvalueValues[r23]
                                                            r55 = 30504089188220
                                                            r35 = "\154\027\r\206\132;"
                                                            r21 = r65(r35, r55)
                                                            r26 = r25[r21]
                                                            r21 = "Instance"
                                                            r65 = _env[r21]
                                                            r35 = upvalueValues[r41]
                                                            r55 = upvalueValues[r23]
                                                            r33 = "v\197\015"
                                                            r59 = 27501190164998
                                                            r14 = r55(r33, r59)
                                                            r21 = r35[r14]
                                                            r25 = r65[r21]
                                                            r35 = upvalueValues[r41]
                                                            r55 = upvalueValues[r23]
                                                            r59 = 13781173115153
                                                            r33 = "\249G\220\130\206\155"
                                                            r14 = r55(r33, r59)
                                                            r21 = r35[r14]
                                                            r65 = r25(r21)
                                                            r21 = upvalueValues[r41]
                                                            r35 = upvalueValues[r23]
                                                            r14 = "l\025\172\211"
                                                            r33 = 28949771957416
                                                            r55 = r35(r14, r33)
                                                            r25 = r21[r55]
                                                            r21 = r26
                                                            r65[r25] = r21
                                                            r21 = upvalueValues[r41]
                                                            r35 = upvalueValues[r23]
                                                            r33 = 24515209276567
                                                            r14 = "}\137\127\134R\154"
                                                            r55 = r35(r14, r33)
                                                            r25 = r21[r55]
                                                            r35 = "gethui"
                                                            r21 = _env[r35]
                                                            r35 = r21()
                                                            r65[r25] = r35
                                                            r21 = "gethui"
                                                            r25 = _env[r21]
                                                            r21 = r25()
                                                            r25 = "FindFirstChild"
                                                            r25 = r21[r25]
                                                            r25 = r25(r21, r26)
                                                            state = r25 and (34) or (35)
                                                        end
                                                    else
                                                        if state == 34 then
                                                            r21 = "print"
                                                            r25 = _env[r21]
                                                            r55 = upvalueValues[r41]
                                                            r14 = upvalueValues[r23]
                                                            r46 = 364173181097
                                                            r59 = "\163x6\129\023\228\177|\241V\182\028X\183\193\204\208\246\142p\029\160}\249\"\008:,on#8\171[\161\214\136\164\233\157\154\158[H\0000\193\151\132\19782"
                                                            r33 = r14(r59, r46)
                                                            r35 = r55[r33]
                                                            r21 = r25(r35)
                                                            r21 = upvalueValues[r41]
                                                            r35 = upvalueValues[r23]
                                                            r14 = "\017\128\022y\156Bq"
                                                            r33 = 22080282896425
                                                            r55 = r35(r14, r33)
                                                            r25 = r21[r55]
                                                            r55 = "Instance"
                                                            r35 = _env[r55]
                                                            r14 = upvalueValues[r41]
                                                            r33 = upvalueValues[r23]
                                                            r46 = "\197\247\004"
                                                            r17 = 22607953242399
                                                            r59 = r33(r46, r17)
                                                            r55 = r14[r59]
                                                            r21 = r35[r55]
                                                            r14 = upvalueValues[r41]
                                                            r33 = upvalueValues[r23]
                                                            r46 = "\151\221$c\001\170"
                                                            r17 = 14295741143552
                                                            r59 = r33(r46, r17)
                                                            r55 = r14[r59]
                                                            r35 = r21(r55)
                                                            r55 = upvalueValues[r41]
                                                            r14 = upvalueValues[r23]
                                                            r59 = ",3C_"
                                                            r46 = 4374016624628
                                                            r33 = r14(r59, r46)
                                                            r21 = r55[r33]
                                                            r55 = r25
                                                            r35[r21] = r55
                                                            r55 = "gethui"
                                                            r21 = _env[r55]
                                                            r55 = r21()
                                                            r21 = "FindFirstChild"
                                                            r21 = r55[r21]
                                                            r21 = r21(r55, r25)
                                                            state = r21 and (36) or (37)
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 36 then
                                                    if state <= 35 then
                                                        if state == 35 then
                                                            r46 = "m\213k"
                                                            r25 = allocUpvalue()
                                                            r55 = "Instance"
                                                            r21 = createClosure6(71, {
                                                                r60,
                                                                r41,
                                                                r23,
                                                                r43,
                                                                r20,
                                                                r28,
                                                                r2,
                                                                r7
                                                            })
                                                            upvalueValues[r25] = r21
                                                            r35 = _env[r55]
                                                            r14 = upvalueValues[r41]
                                                            r33 = upvalueValues[r23]
                                                            r17 = 15641872505971
                                                            r59 = r33(r46, r17)
                                                            r55 = r14[r59]
                                                            r46 = "u\138\153\186\243\161X#\204"
                                                            r21 = r35[r55]
                                                            r14 = upvalueValues[r41]
                                                            r33 = upvalueValues[r23]
                                                            r17 = 21640162043740
                                                            r59 = r33(r46, r17)
                                                            r55 = r14[r59]
                                                            r46 = "\197\011\246\245"
                                                            r35 = r21(r55)
                                                            r21 = allocUpvalue()
                                                            upvalueValues[r21] = r35
                                                            r35 = upvalueValues[r21]
                                                            r14 = upvalueValues[r41]
                                                            r33 = upvalueValues[r23]
                                                            r17 = 28956876158124
                                                            r59 = r33(r46, r17)
                                                            r55 = r14[r59]
                                                            r33 = upvalueValues[r41]
                                                            r59 = upvalueValues[r23]
                                                            r57 = 24577473178804
                                                            r17 = " \205\028\212\\,\198\186\024\200\164\181\158\204/X"
                                                            r46 = r59(r17, r57)
                                                            r14 = r33[r46]
                                                            r35[r55] = r14
                                                            r35 = upvalueValues[r21]
                                                            r14 = upvalueValues[r41]
                                                            r33 = upvalueValues[r23]
                                                            r46 = "Dy\200\177\165\027\148\156R\207\"\001"
                                                            r2 = releaseUpvalue(r2)
                                                            r17 = 19779664897018
                                                            r59 = r33(r46, r17)
                                                            r55 = r14[r59]
                                                            r14 = false
                                                            r35[r55] = r14
                                                            r35 = upvalueValues[r21]
                                                            r14 = upvalueValues[r41]
                                                            r46 = ";g\165]gf"
                                                            r33 = upvalueValues[r23]
                                                            r17 = 27415937741278
                                                            r59 = r33(r46, r17)
                                                            r55 = r14[r59]
                                                            r14 = upvalueValues[r3]
                                                            r35[r55] = r14
                                                            r14 = "Instance"
                                                            r55 = _env[r14]
                                                            r33 = upvalueValues[r41]
                                                            r59 = upvalueValues[r23]
                                                            r57 = 5235812272518
                                                            r17 = "\127C3"
                                                            r46 = r59(r17, r57)
                                                            r14 = r33[r46]
                                                            r35 = r55[r14]
                                                            r33 = upvalueValues[r41]
                                                            r59 = upvalueValues[r23]
                                                            r57 = 14821662677749
                                                            r17 = "\135\252\178\225\186"
                                                            r46 = r59(r17, r57)
                                                            r14 = r33[r46]
                                                            r55 = r35(r14)
                                                            r46 = "\184\225\231S)\163|\000\25214"
                                                            r14 = upvalueValues[r41]
                                                            r33 = upvalueValues[r23]
                                                            r17 = 29381210731889
                                                            r59 = r33(r46, r17)
                                                            r35 = r14[r59]
                                                            r59 = "Vector2"
                                                            r33 = _env[r59]
                                                            r46 = upvalueValues[r41]
                                                            r17 = upvalueValues[r23]
                                                            r67 = "\007r\176"
                                                            r39 = 13683727472867
                                                            r57 = r17(r67, r39)
                                                            r59 = r46[r57]
                                                            r14 = r33[r59]
                                                            r46 = 0.5
                                                            r59 = 0.5
                                                            r33 = r14(r59, r46)
                                                            r55[r35] = r33
                                                            r46 = "\254O\025\003\254\197\252\014"
                                                            r14 = upvalueValues[r41]
                                                            r33 = upvalueValues[r23]
                                                            r17 = 12127128344079
                                                            r59 = r33(r46, r17)
                                                            r35 = r14[r59]
                                                            r59 = "UDim2"
                                                            r33 = _env[r59]
                                                            r46 = upvalueValues[r41]
                                                            r17 = upvalueValues[r23]
                                                            r67 = "\149$."
                                                            r39 = 13907896015180
                                                            r57 = r17(r67, r39)
                                                            r59 = r46[r57]
                                                            r14 = r33[r59]
                                                            r46 = 0
                                                            r17 = 0.5
                                                            r57 = 0
                                                            r59 = 0.5
                                                            r33 = r14(r59, r46, r17, r57)
                                                            r46 = "\006u\254D"
                                                            r55[r35] = r33
                                                            r14 = upvalueValues[r41]
                                                            r33 = upvalueValues[r23]
                                                            r17 = 10029446091326
                                                            r59 = r33(r46, r17)
                                                            r35 = r14[r59]
                                                            r59 = "UDim2"
                                                            r33 = _env[r59]
                                                            r46 = upvalueValues[r41]
                                                            r17 = upvalueValues[r23]
                                                            r67 = ".\242W"
                                                            r39 = 14990768216900
                                                            r57 = r17(r67, r39)
                                                            r59 = r46[r57]
                                                            r46 = 0
                                                            r14 = r33[r59]
                                                            r17 = 0.2
                                                            r59 = 0.3
                                                            r57 = 0
                                                            r33 = r14(r59, r46, r17, r57)
                                                            r46 = "\0186\004\161\223\229\188\214\180\213R\190\179\145*\020"
                                                            r55[r35] = r33
                                                            r14 = upvalueValues[r41]
                                                            r33 = upvalueValues[r23]
                                                            r17 = 19124629414601
                                                            r59 = r33(r46, r17)
                                                            r35 = r14[r59]
                                                            r59 = "Color3"
                                                            r33 = _env[r59]
                                                            r46 = upvalueValues[r41]
                                                            r17 = upvalueValues[r23]
                                                            r39 = 33435841789137
                                                            r67 = "\164\246N\193\152\182&"
                                                            r57 = r17(r67, r39)
                                                            r59 = r46[r57]
                                                            r46 = 20
                                                            r14 = r33[r59]
                                                            r17 = 40
                                                            r59 = 20
                                                            r33 = r14(r59, r46, r17)
                                                            r55[r35] = r33
                                                            r14 = upvalueValues[r41]
                                                            r46 = "\147>\235\177z\142\022AOV\196\\W\019o\205@)ap\220\023"
                                                            r33 = upvalueValues[r23]
                                                            r17 = 15499219770417
                                                            r59 = r33(r46, r17)
                                                            r35 = r14[r59]
                                                            r46 = "<\021T\142\236="
                                                            r14 = 0.1
                                                            r55[r35] = r14
                                                            r14 = upvalueValues[r41]
                                                            r33 = upvalueValues[r23]
                                                            r17 = 25302005411334
                                                            r59 = r33(r46, r17)
                                                            r35 = r14[r59]
                                                            r14 = upvalueValues[r21]
                                                            r33 = "Instance"
                                                            r55[r35] = r14
                                                            r14 = _env[r33]
                                                            r59 = upvalueValues[r41]
                                                            r46 = upvalueValues[r23]
                                                            r67 = 18526466941363
                                                            r57 = "\151\152["
                                                            r17 = r46(r57, r67)
                                                            r33 = r59[r17]
                                                            r35 = r14[r33]
                                                            r59 = upvalueValues[r41]
                                                            r46 = upvalueValues[r23]
                                                            r67 = 15311600442330
                                                            r57 = "\158Q\237F\180\028E."
                                                            r17 = r46(r57, r67)
                                                            r33 = r59[r17]
                                                            r14 = r35(r33)
                                                            r33 = upvalueValues[r41]
                                                            r59 = upvalueValues[r23]
                                                            r17 = "_\031i\251\183%\185\232\008\019'd"
                                                            r57 = 10777306813338
                                                            r46 = r59(r17, r57)
                                                            r35 = r33[r46]
                                                            r46 = "UDim"
                                                            r59 = _env[r46]
                                                            r17 = upvalueValues[r41]
                                                            r57 = upvalueValues[r23]
                                                            r62 = 10715182355325
                                                            r39 = "\244c'"
                                                            r67 = r57(r39, r62)
                                                            r46 = r17[r67]
                                                            r33 = r59[r46]
                                                            r46 = 0
                                                            r17 = 14
                                                            r59 = r33(r46, r17)
                                                            r14[r35] = r59
                                                            r33 = upvalueValues[r41]
                                                            r59 = upvalueValues[r23]
                                                            r17 = "\207\232j\217\146["
                                                            r57 = 27422306038241
                                                            r46 = r59(r17, r57)
                                                            r35 = r33[r46]
                                                            r33 = r55
                                                            r14[r35] = r33
                                                            r59 = "Instance"
                                                            r33 = _env[r59]
                                                            r46 = upvalueValues[r41]
                                                            r17 = upvalueValues[r23]
                                                            r39 = 16046529961264
                                                            r67 = "\247*\133"
                                                            r57 = r17(r67, r39)
                                                            r59 = r46[r57]
                                                            r35 = r33[r59]
                                                            r46 = upvalueValues[r41]
                                                            r17 = upvalueValues[r23]
                                                            r39 = 12301247092320
                                                            r67 = "\247[V\235\003TzQ\221"
                                                            r57 = r17(r67, r39)
                                                            r59 = r46[r57]
                                                            r33 = r35(r59)
                                                            r59 = upvalueValues[r41]
                                                            r46 = upvalueValues[r23]
                                                            r67 = 18103918715118
                                                            r57 = "\190\139P\183"
                                                            r17 = r46(r57, r67)
                                                            r35 = r59[r17]
                                                            r17 = "UDim2"
                                                            r46 = _env[r17]
                                                            r57 = upvalueValues[r41]
                                                            r67 = upvalueValues[r23]
                                                            r13 = 8693798031312
                                                            r62 = "mu\197"
                                                            r39 = r67(r62, r13)
                                                            r17 = r57[r39]
                                                            r59 = r46[r17]
                                                            r67 = 0.3
                                                            r39 = 0
                                                            r57 = 0
                                                            r17 = 1
                                                            r46 = r59(r17, r57, r67, r39)
                                                            r33[r35] = r46
                                                            r59 = upvalueValues[r41]
                                                            r46 = upvalueValues[r23]
                                                            r57 = "\001\191\181\180\185\001\211y0\218\011\156\021\224\192~e|\249\241\165b"
                                                            r67 = 25415010217530
                                                            r17 = r46(r57, r67)
                                                            r35 = r59[r17]
                                                            r59 = 1
                                                            r33[r35] = r59
                                                            r59 = upvalueValues[r41]
                                                            r46 = upvalueValues[r23]
                                                            r67 = 26411155435530
                                                            r57 = "~A\202&"
                                                            r17 = r46(r57, r67)
                                                            r35 = r59[r17]
                                                            r46 = upvalueValues[r41]
                                                            r17 = upvalueValues[r23]
                                                            r67 = "/\149\238}l\157\238\252/\232\255\135\144\207\002\209\181\148\026"
                                                            r39 = 3150720763323
                                                            r57 = r17(r67, r39)
                                                            r59 = r46[r57]
                                                            r33[r35] = r59
                                                            r59 = upvalueValues[r41]
                                                            r46 = upvalueValues[r23]
                                                            r67 = 19191359234792
                                                            r57 = "s\140D\153>\"\148\023\132\200"
                                                            r17 = r46(r57, r67)
                                                            r35 = r59[r17]
                                                            r17 = "Color3"
                                                            r46 = _env[r17]
                                                            ReturnVal = {}
                                                            r57 = upvalueValues[r41]
                                                            r67 = upvalueValues[r23]
                                                            r13 = 6868655836286
                                                            r62 = "\233\023\230^\225\178\192"
                                                            r39 = r67(r62, r13)
                                                            r17 = r57[r39]
                                                            r59 = r46[r17]
                                                            r17 = 180
                                                            r57 = 180
                                                            r67 = 255
                                                            r46 = r59(r17, r57, r67)
                                                            r33[r35] = r46
                                                            r59 = upvalueValues[r41]
                                                            r46 = upvalueValues[r23]
                                                            r67 = 24790882823448
                                                            r57 = "|1\205\tj\011U\015"
                                                            r17 = r46(r57, r67)
                                                            r35 = r59[r17]
                                                            r59 = 24
                                                            r33[r35] = r59
                                                            r59 = upvalueValues[r41]
                                                            r46 = upvalueValues[r23]
                                                            r57 = "kAK\182"
                                                            r67 = 12963863304084
                                                            r17 = r46(r57, r67)
                                                            r35 = r59[r17]
                                                            r57 = "Enum"
                                                            r17 = _env[r57]
                                                            r67 = upvalueValues[r41]
                                                            r39 = upvalueValues[r23]
                                                            r64 = 31446129031475
                                                            r13 = "\177\135\207\137"
                                                            r62 = r39(r13, r64)
                                                            r57 = r67[r62]
                                                            r46 = r17[r57]
                                                            r57 = upvalueValues[r41]
                                                            r67 = upvalueValues[r23]
                                                            r13 = 9386175615250
                                                            r62 = "\147!\134\165\244;@"
                                                            r39 = r67(r62, r13)
                                                            r17 = r57[r39]
                                                            r59 = r46[r17]
                                                            r33[r35] = r59
                                                            r59 = upvalueValues[r41]
                                                            r46 = upvalueValues[r23]
                                                            r7 = releaseUpvalue(r7)
                                                            r67 = 5195428940147
                                                            r57 = "\237\219\001\226\2212"
                                                            r17 = r46(r57, r67)
                                                            r35 = r59[r17]
                                                            r59 = r55
                                                            r33[r35] = r59
                                                            r46 = "Instance"
                                                            r59 = _env[r46]
                                                            r17 = upvalueValues[r41]
                                                            r57 = upvalueValues[r23]
                                                            r39 = "\136C\200"
                                                            r62 = 1497569198777
                                                            r67 = r57(r39, r62)
                                                            r46 = r17[r67]
                                                            r35 = r59[r46]
                                                            r17 = upvalueValues[r41]
                                                            r57 = upvalueValues[r23]
                                                            r62 = 24207838293000
                                                            r39 = "ov\136\203r\148\255mP\155"
                                                            r67 = r57(r39, r62)
                                                            r46 = r17[r67]
                                                            r59 = r35(r46)
                                                            r35 = allocUpvalue()
                                                            upvalueValues[r35] = r59
                                                            r59 = upvalueValues[r35]
                                                            r17 = upvalueValues[r41]
                                                            r57 = upvalueValues[r23]
                                                            r62 = 34576639672037
                                                            r39 = "\222\249\"L"
                                                            r67 = r57(r39, r62)
                                                            r46 = r17[r67]
                                                            r67 = "UDim2"
                                                            r57 = _env[r67]
                                                            r39 = upvalueValues[r41]
                                                            r62 = upvalueValues[r23]
                                                            r58 = 15181296688029
                                                            r64 = "U\176\162"
                                                            r13 = r62(r64, r58)
                                                            r67 = r39[r13]
                                                            r17 = r57[r67]
                                                            r13 = 0
                                                            r67 = 0.8
                                                            r62 = 0.3
                                                            r39 = 0
                                                            r57 = r17(r67, r39, r62, r13)
                                                            r59[r46] = r57
                                                            r59 = upvalueValues[r35]
                                                            r17 = upvalueValues[r41]
                                                            r57 = upvalueValues[r23]
                                                            r39 = "\005\200\244=cV\183\179"
                                                            r62 = 1150594531863
                                                            r67 = r57(r39, r62)
                                                            r46 = r17[r67]
                                                            r67 = "UDim2"
                                                            r57 = _env[r67]
                                                            r39 = upvalueValues[r41]
                                                            r62 = upvalueValues[r23]
                                                            r58 = 13300163582001
                                                            r64 = "\022\028\131"
                                                            r13 = r62(r64, r58)
                                                            r67 = r39[r13]
                                                            r17 = r57[r67]
                                                            r62 = 0.5
                                                            r39 = 0
                                                            r67 = 0.1
                                                            r13 = 0
                                                            r57 = r17(r67, r39, r62, r13)
                                                            r59[r46] = r57
                                                            r59 = upvalueValues[r35]
                                                            r17 = upvalueValues[r41]
                                                            r57 = upvalueValues[r23]
                                                            r39 = "YD\000\241\240dSt\142\204\2335\193\170\170\207"
                                                            r62 = 25210742779355
                                                            r67 = r57(r39, r62)
                                                            r46 = r17[r67]
                                                            r67 = "Color3"
                                                            r57 = _env[r67]
                                                            r39 = upvalueValues[r41]
                                                            r62 = upvalueValues[r23]
                                                            r58 = 16141362748764
                                                            r64 = "\233\020%1\1999F"
                                                            r13 = r62(r64, r58)
                                                            r67 = r39[r13]
                                                            r17 = r57[r67]
                                                            r39 = 170
                                                            r62 = 255
                                                            r67 = 0
                                                            r57 = r17(r67, r39, r62)
                                                            r59[r46] = r57
                                                            r59 = upvalueValues[r35]
                                                            r17 = upvalueValues[r41]
                                                            r57 = upvalueValues[r23]
                                                            r62 = 32424792996602
                                                            r39 = "\209\te\196"
                                                            r67 = r57(r39, r62)
                                                            r46 = r17[r67]
                                                            r57 = upvalueValues[r41]
                                                            r67 = upvalueValues[r23]
                                                            r13 = 23462212463277
                                                            r62 = "d|\223\029k\246\168\031\004\133#TG\188\151<:"
                                                            r39 = r67(r62, r13)
                                                            r17 = r57[r39]
                                                            r59[r46] = r17
                                                            r59 = upvalueValues[r35]
                                                            r17 = upvalueValues[r41]
                                                            r57 = upvalueValues[r23]
                                                            r62 = 31640582519181
                                                            r39 = "&\216hi\029\244\199\1593\180"
                                                            r67 = r57(r39, r62)
                                                            r46 = r17[r67]
                                                            r67 = "Color3"
                                                            r57 = _env[r67]
                                                            r39 = upvalueValues[r41]
                                                            r62 = upvalueValues[r23]
                                                            r64 = "\227\211\165\239krO"
                                                            r58 = 22542426319105
                                                            r13 = r62(r64, r58)
                                                            r67 = r39[r13]
                                                            r17 = r57[r67]
                                                            r62 = 255
                                                            r39 = 255
                                                            r67 = 255
                                                            r57 = r17(r67, r39, r62)
                                                            r59[r46] = r57
                                                            r59 = upvalueValues[r35]
                                                            r17 = upvalueValues[r41]
                                                            r57 = upvalueValues[r23]
                                                            r39 = "\197\159,\026mp|e"
                                                            r62 = 6804307299424
                                                            r67 = r57(r39, r62)
                                                            r46 = r17[r67]
                                                            r17 = 18
                                                            r59[r46] = r17
                                                            r59 = upvalueValues[r35]
                                                            r17 = upvalueValues[r41]
                                                            r57 = upvalueValues[r23]
                                                            r39 = "0\172\002\185"
                                                            r62 = 11767810856295
                                                            r67 = r57(r39, r62)
                                                            r46 = r17[r67]
                                                            r39 = "Enum"
                                                            r67 = _env[r39]
                                                            r62 = upvalueValues[r41]
                                                            r13 = upvalueValues[r23]
                                                            r48 = 33319733132443
                                                            r58 = "\159\001\134S"
                                                            r64 = r13(r58, r48)
                                                            r39 = r62[r64]
                                                            r57 = r67[r39]
                                                            r39 = upvalueValues[r41]
                                                            r62 = upvalueValues[r23]
                                                            r58 = 17519489671134
                                                            r64 = "\027W\129\031\190\132|tO*"
                                                            r13 = r62(r64, r58)
                                                            r67 = r39[r13]
                                                            r17 = r57[r67]
                                                            r59[r46] = r17
                                                            r59 = upvalueValues[r35]
                                                            r17 = upvalueValues[r41]
                                                            r57 = upvalueValues[r23]
                                                            r39 = ")Y\176\029\"p"
                                                            r62 = 4005744789321
                                                            r67 = r57(r39, r62)
                                                            r46 = r17[r67]
                                                            r17 = r55
                                                            r59[r46] = r17
                                                            r17 = "Instance"
                                                            r46 = _env[r17]
                                                            r57 = upvalueValues[r41]
                                                            r67 = upvalueValues[r23]
                                                            r13 = 14181890988491
                                                            r62 = "\167(\172"
                                                            r39 = r67(r62, r13)
                                                            r17 = r57[r39]
                                                            r59 = r46[r17]
                                                            r57 = upvalueValues[r41]
                                                            r67 = upvalueValues[r23]
                                                            r62 = "\210\148\138\143\021/\199q"
                                                            r13 = 29820736763454
                                                            r39 = r67(r62, r13)
                                                            r17 = r57[r39]
                                                            r46 = r59(r17)
                                                            r17 = upvalueValues[r41]
                                                            r43 = releaseUpvalue(r43)
                                                            r57 = upvalueValues[r23]
                                                            r39 = "\189\254\221\129=\190a\218I\203\008\211"
                                                            r62 = 22109663504439
                                                            r67 = r57(r39, r62)
                                                            r59 = r17[r67]
                                                            r67 = "UDim"
                                                            r57 = _env[r67]
                                                            r39 = upvalueValues[r41]
                                                            r62 = upvalueValues[r23]
                                                            r58 = 22875689019804
                                                            r64 = "\245*\030"
                                                            r13 = r62(r64, r58)
                                                            r67 = r39[r13]
                                                            r17 = r57[r67]
                                                            r39 = 8
                                                            r67 = 0
                                                            r57 = r17(r67, r39)
                                                            r46[r59] = r57
                                                            r17 = upvalueValues[r41]
                                                            r57 = upvalueValues[r23]
                                                            r62 = 20051374892153
                                                            r39 = "\180KEmE\197"
                                                            r67 = r57(r39, r62)
                                                            r59 = r17[r67]
                                                            r17 = upvalueValues[r35]
                                                            r46[r59] = r17
                                                            r56 = 19517129499520
                                                            r5 = 15193156852642
                                                            r57 = "Instance"
                                                            r17 = _env[r57]
                                                            r67 = upvalueValues[r41]
                                                            r39 = upvalueValues[r23]
                                                            r13 = "\017\168\158"
                                                            r64 = 13336446851138
                                                            r62 = r39(r13, r64)
                                                            r57 = r67[r62]
                                                            r59 = r17[r57]
                                                            r67 = upvalueValues[r41]
                                                            r39 = upvalueValues[r23]
                                                            r64 = 26026409799511
                                                            r13 = "k6\027\142\248\178\158\228\025"
                                                            r62 = r39(r13, r64)
                                                            r57 = r67[r62]
                                                            r17 = r59(r57)
                                                            r59 = allocUpvalue()
                                                            upvalueValues[r59] = r17
                                                            r17 = upvalueValues[r59]
                                                            r67 = upvalueValues[r41]
                                                            r39 = upvalueValues[r23]
                                                            r13 = "3o\156\128"
                                                            r64 = 4058362021729
                                                            r62 = r39(r13, r64)
                                                            r57 = r67[r62]
                                                            r62 = "UDim2"
                                                            r39 = _env[r62]
                                                            r13 = upvalueValues[r41]
                                                            r64 = upvalueValues[r23]
                                                            r16 = 20205102687424
                                                            r48 = "w\234I"
                                                            r58 = r64(r48, r16)
                                                            r62 = r13[r58]
                                                            r67 = r39[r62]
                                                            r13 = 0
                                                            r58 = 0
                                                            r64 = 0.2
                                                            r62 = 1
                                                            r39 = r67(r62, r13, r64, r58)
                                                            r17[r57] = r39
                                                            r17 = upvalueValues[r59]
                                                            r67 = upvalueValues[r41]
                                                            r39 = upvalueValues[r23]
                                                            r64 = 15632920517743
                                                            r13 = "\015du\2524x\238\203"
                                                            r62 = r39(r13, r64)
                                                            r57 = r67[r62]
                                                            r62 = "UDim2"
                                                            r39 = _env[r62]
                                                            r13 = upvalueValues[r41]
                                                            r64 = upvalueValues[r23]
                                                            r48 = "\230^\201"
                                                            r16 = 17022225325814
                                                            r58 = r64(r48, r16)
                                                            r62 = r13[r58]
                                                            r67 = r39[r62]
                                                            r58 = 0
                                                            r62 = 0
                                                            r13 = 0
                                                            r64 = 0.8
                                                            r39 = r67(r62, r13, r64, r58)
                                                            r17[r57] = r39
                                                            r17 = upvalueValues[r59]
                                                            r67 = upvalueValues[r41]
                                                            r39 = upvalueValues[r23]
                                                            r64 = 16466859613683
                                                            r13 = "9\152\248\237u_\246\231\191\018/\163\252\203\031\135\169d\175\204\179\029"
                                                            r62 = r39(r13, r64)
                                                            r57 = r67[r62]
                                                            r67 = 1
                                                            r17[r57] = r67
                                                            r33 = nil
                                                            r17 = upvalueValues[r59]
                                                            r64 = 25019096132994
                                                            r16 = 14042562320779
                                                            r58 = 22217654282345
                                                            r65 = nil
                                                            r67 = upvalueValues[r41]
                                                            r39 = upvalueValues[r23]
                                                            r13 = "\205E\154\223"
                                                            r62 = r39(r13, r64)
                                                            r57 = r67[r62]
                                                            r39 = upvalueValues[r41]
                                                            r62 = upvalueValues[r23]
                                                            r64 = ""
                                                            r13 = r62(r64, r58)
                                                            r67 = r39[r13]
                                                            r17[r57] = r67
                                                            r17 = upvalueValues[r59]
                                                            r67 = upvalueValues[r41]
                                                            r39 = upvalueValues[r23]
                                                            r64 = 17964428828845
                                                            r13 = "\014e\016\004\146\"\203)U6"
                                                            r62 = r39(r13, r64)
                                                            r57 = r67[r62]
                                                            r62 = "Color3"
                                                            r39 = _env[r62]
                                                            r13 = upvalueValues[r41]
                                                            r64 = upvalueValues[r23]
                                                            r48 = "\0124\243|\192\131b"
                                                            r58 = r64(r48, r16)
                                                            r62 = r13[r58]
                                                            r67 = r39[r62]
                                                            r13 = 100
                                                            r64 = 100
                                                            r62 = 255
                                                            r39 = r67(r62, r13, r64)
                                                            r17[r57] = r39
                                                            r17 = upvalueValues[r59]
                                                            r67 = upvalueValues[r41]
                                                            r39 = upvalueValues[r23]
                                                            r13 = "N\198\002\231\228\185\204b"
                                                            r64 = 21609921849166
                                                            r62 = r39(r13, r64)
                                                            r57 = r67[r62]
                                                            r67 = 14
                                                            r17[r57] = r67
                                                            r17 = upvalueValues[r59]
                                                            r67 = upvalueValues[r41]
                                                            r39 = upvalueValues[r23]
                                                            r64 = 33145725516874
                                                            r13 = "7\234\187\179"
                                                            r62 = r39(r13, r64)
                                                            r57 = r67[r62]
                                                            r13 = "Enum"
                                                            r62 = _env[r13]
                                                            r28 = releaseUpvalue(r28)
                                                            r64 = upvalueValues[r41]
                                                            r58 = upvalueValues[r23]
                                                            r16 = "K\180\\\237"
                                                            r48 = r58(r16, r5)
                                                            r13 = r64[r48]
                                                            r39 = r62[r13]
                                                            r13 = upvalueValues[r41]
                                                            r64 = upvalueValues[r23]
                                                            r48 = "\154\209Iqg|"
                                                            r16 = 34910085447552
                                                            r58 = r64(r48, r16)
                                                            r62 = r13[r58]
                                                            r67 = r39[r62]
                                                            r17[r57] = r67
                                                            r17 = upvalueValues[r59]
                                                            r67 = upvalueValues[r41]
                                                            r39 = upvalueValues[r23]
                                                            r64 = 23172096191014
                                                            r13 = "\240\029\005d\241\162"
                                                            r62 = r39(r13, r64)
                                                            r57 = r67[r62]
                                                            r67 = r55
                                                            r17[r57] = r67
                                                            r67 = "Instance"
                                                            r57 = _env[r67]
                                                            r39 = upvalueValues[r41]
                                                            r62 = upvalueValues[r23]
                                                            r58 = 31334519601407
                                                            r64 = "\016\245\198"
                                                            r13 = r62(r64, r58)
                                                            r67 = r39[r13]
                                                            r17 = r57[r67]
                                                            r39 = upvalueValues[r41]
                                                            r62 = upvalueValues[r23]
                                                            r58 = 32150506338939
                                                            r64 = "\173 $\230\224\214Z8,"
                                                            r13 = r62(r64, r58)
                                                            r67 = r39[r13]
                                                            r57 = r17(r67)
                                                            r17 = allocUpvalue()
                                                            upvalueValues[r17] = r57
                                                            r57 = upvalueValues[r17]
                                                            r39 = upvalueValues[r41]
                                                            r62 = upvalueValues[r23]
                                                            r64 = "ak\193\139"
                                                            r58 = 11449936549075
                                                            r13 = r62(r64, r58)
                                                            r67 = r39[r13]
                                                            r13 = "UDim2"
                                                            r62 = _env[r13]
                                                            r64 = upvalueValues[r41]
                                                            r58 = upvalueValues[r23]
                                                            r5 = 27790730015373
                                                            r16 = "(Ae"
                                                            r48 = r58(r16, r5)
                                                            r13 = r64[r48]
                                                            r39 = r62[r13]
                                                            r58 = 0.2
                                                            r48 = 0
                                                            r13 = 1
                                                            r64 = 0
                                                            r62 = r39(r13, r64, r58, r48)
                                                            r57[r67] = r62
                                                            r57 = upvalueValues[r17]
                                                            r39 = upvalueValues[r41]
                                                            r62 = upvalueValues[r23]
                                                            r58 = 19508560552828
                                                            r64 = "\004\236\227T\206O\007L"
                                                            r13 = r62(r64, r58)
                                                            r67 = r39[r13]
                                                            r13 = "UDim2"
                                                            r62 = _env[r13]
                                                            r64 = upvalueValues[r41]
                                                            r58 = upvalueValues[r23]
                                                            r5 = 18254243848500
                                                            r16 = "G\r\235"
                                                            r48 = r58(r16, r5)
                                                            r13 = r64[r48]
                                                            r39 = r62[r13]
                                                            r48 = 0
                                                            r64 = 0
                                                            r13 = 0
                                                            r58 = 0.3
                                                            r62 = r39(r13, r64, r58, r48)
                                                            r57[r67] = r62
                                                            r57 = upvalueValues[r17]
                                                            r39 = upvalueValues[r41]
                                                            r62 = upvalueValues[r23]
                                                            r58 = 4374168766452
                                                            r64 = "m1\254\014C\184L\197\135\215\018W\244\181lZ\018\210\223\023\191\146"
                                                            r13 = r62(r64, r58)
                                                            r67 = r39[r13]
                                                            r39 = 1
                                                            r57[r67] = r39
                                                            r57 = upvalueValues[r17]
                                                            r39 = upvalueValues[r41]
                                                            r62 = upvalueValues[r23]
                                                            r64 = "s\227C\141"
                                                            r58 = 17643921580056
                                                            r13 = r62(r64, r58)
                                                            r67 = r39[r13]
                                                            r62 = upvalueValues[r41]
                                                            r13 = upvalueValues[r23]
                                                            r48 = 589361414418
                                                            r58 = "N\025.\023U\n\207\190>l~\235\156"
                                                            r64 = r13(r58, r48)
                                                            r39 = r62[r64]
                                                            r57[r67] = r39
                                                            r57 = upvalueValues[r17]
                                                            r39 = upvalueValues[r41]
                                                            r62 = upvalueValues[r23]
                                                            r64 = "\209g\199\155U\217\223EG\164"
                                                            r58 = 8379913555774
                                                            r13 = r62(r64, r58)
                                                            r67 = r39[r13]
                                                            r13 = "Color3"
                                                            r62 = _env[r13]
                                                            r64 = upvalueValues[r41]
                                                            r58 = upvalueValues[r23]
                                                            r5 = 31825812584932
                                                            r16 = "\012\014(\189S\128\\"
                                                            r48 = r58(r16, r5)
                                                            r13 = r64[r48]
                                                            r39 = r62[r13]
                                                            r58 = 255
                                                            r13 = 200
                                                            r64 = 200
                                                            r62 = r39(r13, r64, r58)
                                                            r57[r67] = r62
                                                            r57 = upvalueValues[r17]
                                                            r39 = upvalueValues[r41]
                                                            r62 = upvalueValues[r23]
                                                            r64 = "\020\153'\211k\130}\212"
                                                            r58 = 30410098194256
                                                            r13 = r62(r64, r58)
                                                            r67 = r39[r13]
                                                            r39 = 16
                                                            r57[r67] = r39
                                                            r57 = upvalueValues[r17]
                                                            r39 = upvalueValues[r41]
                                                            r62 = upvalueValues[r23]
                                                            r64 = "\136M\186*"
                                                            r58 = 30489577076597
                                                            r13 = r62(r64, r58)
                                                            r67 = r39[r13]
                                                            r64 = "Enum"
                                                            r13 = _env[r64]
                                                            r58 = upvalueValues[r41]
                                                            r48 = upvalueValues[r23]
                                                            r5 = "\176\235_\232"
                                                            r16 = r48(r5, r56)
                                                            r20 = releaseUpvalue(r20)
                                                            r64 = r58[r16]
                                                            r62 = r13[r64]
                                                            r64 = upvalueValues[r41]
                                                            r58 = upvalueValues[r23]
                                                            r5 = 15277100981193
                                                            r16 = "@a\144a\163\167\176\160\231\178"
                                                            r48 = r58(r16, r5)
                                                            r13 = r64[r48]
                                                            r26 = nil
                                                            r39 = r62[r13]
                                                            r57[r67] = r39
                                                            r57 = upvalueValues[r17]
                                                            r39 = upvalueValues[r41]
                                                            r62 = upvalueValues[r23]
                                                            r58 = 8641651822520
                                                            r64 = "\148\214\177\004\001*"
                                                            r13 = r62(r64, r58)
                                                            r67 = r39[r13]
                                                            r39 = r55
                                                            r57[r67] = r39
                                                            r16 = "e#[g(\194&8\152\170\139\149\012\214-9\148"
                                                            r39 = allocUpvalue()
                                                            r57 = allocUpvalue()
                                                            r67 = createClosure1(126, {
                                                                r41,
                                                                r23,
                                                                r3,
                                                                r9,
                                                                r38
                                                            })
                                                            r38 = releaseUpvalue(r38)
                                                            r5 = 25195299352020
                                                            r3 = releaseUpvalue(r3)
                                                            r14 = nil
                                                            upvalueValues[r57] = r67
                                                            r67 = false
                                                            r55 = nil
                                                            r46 = nil
                                                            upvalueValues[r39] = r67
                                                            r9 = releaseUpvalue(r9)
                                                            r62 = upvalueValues[r35]
                                                            r64 = upvalueValues[r41]
                                                            r58 = upvalueValues[r23]
                                                            r48 = r58(r16, r5)
                                                            r13 = r64[r48]
                                                            r67 = r62[r13]
                                                            r62 = "Connect"
                                                            r62 = r67[r62]
                                                            r13 = createClosure5(127, {
                                                                r39,
                                                                r68,
                                                                r41,
                                                                r23,
                                                                r35,
                                                                r54,
                                                                r17,
                                                                r25,
                                                                r60,
                                                                r59,
                                                                r21,
                                                                r57
                                                            })
                                                            r57 = releaseUpvalue(r57)
                                                            r25 = releaseUpvalue(r25)
                                                            r23 = releaseUpvalue(r23)
                                                            r41 = releaseUpvalue(r41)
                                                            r68 = releaseUpvalue(r68)
                                                            r21 = releaseUpvalue(r21)
                                                            r35 = releaseUpvalue(r35)
                                                            r62 = r62(r67, r13)
                                                            r60 = releaseUpvalue(r60)
                                                            r39 = releaseUpvalue(r39)
                                                            r17 = releaseUpvalue(r17)
                                                            r54 = releaseUpvalue(r54)
                                                            r59 = releaseUpvalue(r59)
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 36 then
                                                            r21 = upvalueValues[r60]
                                                            ReturnVal = {}
                                                            r33 = upvalueValues[r41]
                                                            r59 = upvalueValues[r23]
                                                            r17 = "\157\018B\rK\207e\028\012\185\177\2332\203\133\164i\140\143p\173\253\244\173\t\206\242\194T=\244\238 \148y8\226\t\208\207\174\174\183\201\251\015\024D\187\234?\146x\228\237XiW{\160\219\204\179"
                                                            r57 = 33217151876203
                                                            r46 = r59(r17, r57)
                                                            r14 = r33[r46]
                                                            r55 = "Kick"
                                                            r55 = r21[r55]
                                                            r55 = r55(r21, r14)
                                                            state = nil
                                                        end
                                                    end
                                                else
                                                    if state <= 37 then
                                                        if state == 37 then
                                                            r55 = upvalueValues[r41]
                                                            r14 = upvalueValues[r23]
                                                            r46 = 28793263699039
                                                            r59 = "\143QS\130\162\254"
                                                            r33 = r14(r59, r46)
                                                            r21 = r55[r33]
                                                            r14 = "gethui"
                                                            r55 = _env[r14]
                                                            r14 = r55()
                                                            r35[r21] = r14
                                                            state = 38
                                                        end
                                                    else
                                                        if state == 38 then
                                                            r25 = nil
                                                            r35 = nil
                                                            state = 35
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure0 entry 14798832 -> 39, states 39-39
                                    if state == 39 then -- entry 14798832 -> 39
                                        state = true
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure4 entry 5426331 -> 40, states 40-40
                                if state == 40 then -- entry 5426331 -> 40
                                    ReturnVal = "error"
                                    state = _env[ReturnVal]
                                    r22 = "Tamper Detected!"
                                    ReturnVal = state(r22)
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            if state <= 53 then
                                if state <= 41 then
                                    -- createClosure2 entry 6613437 -> 41, states 41-41
                                    if state == 41 then -- entry 6613437 -> 41
                                        r23 = "rZPYUxQ"
                                        r2 = 1423791
                                        r22 = r23 ^ r2
                                        ReturnVal = 13505727
                                        state = ReturnVal - r22
                                        r22 = state
                                        ReturnVal = "MRTNdd"
                                        state = ReturnVal / r22
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure2 entry 8135678 -> 42, states 42-53
                                    if state <= 47 then
                                        if state <= 44 then
                                            if state <= 43 then
                                                if state <= 42 then
                                                    if state == 42 then -- entry 8135678 -> 42
                                                        r23 = upvalueValues[upvalues[1]]
                                                        r41 = 1
                                                        r7 = 2
                                                        r2 = r23(r41, r7)
                                                        r23 = 1
                                                        r22 = r2 == r23
                                                        state = r22 and (43) or (44)
                                                        ReturnVal = r22
                                                    end
                                                else
                                                    if state == 43 then
                                                        state = ReturnVal and (45) or (46)
                                                    end
                                                end
                                            else
                                                if state == 44 then
                                                    r23 = upvalueValues[upvalues[2]]
                                                    r2 = upvalueValues[upvalues[3]]
                                                    r22 = r23 == r2
                                                    ReturnVal = r22
                                                    state = 43
                                                end
                                            end
                                        else
                                            if state <= 46 then
                                                if state <= 45 then
                                                    if state == 45 then
                                                        r28 = createClosure4(139, {})
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r22 = upvalueValues[upvalues[4]]
                                                        r41 = "tostring"
                                                        r2 = _env[r41]
                                                        r20 = "pcall"
                                                        r43 = _env[r20]
                                                        r20 = {
                                                            r43(r28)
                                                        }
                                                        r9 = {
                                                            unpack(r20)
                                                        }
                                                        r43 = 2
                                                        r7 = r9[r43]
                                                        r41 = r2(r7)
                                                        r2 = ":(%d*):"
                                                        r23 = r22(r41, r2)
                                                        r22 = {
                                                            r23()
                                                        }
                                                        ReturnVal = state(unpack(r22))
                                                        r22 = ReturnVal
                                                        r23 = upvalueValues[upvalues[5]]
                                                        state = r23 and (47) or (48)
                                                        ReturnVal = r23
                                                    end
                                                else
                                                    if state == 46 then
                                                        state = upvalueValues[upvalues[7]]
                                                        state = state and (49) or (50)
                                                    end
                                                end
                                            else
                                                if state == 47 then
                                                    r2 = upvalueValues[upvalues[6]]
                                                    r23 = r2 == r22
                                                    ReturnVal = r23
                                                    state = 48
                                                end
                                            end
                                        end
                                    else
                                        if state <= 50 then
                                            if state <= 49 then
                                                if state <= 48 then
                                                    if state == 48 then
                                                        upvalueValues[upvalues[5]] = ReturnVal
                                                        r22 = nil
                                                        state = 46
                                                    end
                                                else
                                                    if state == 49 then
                                                        r22 = "error"
                                                        state = _env[r22]
                                                        r23 = upvalueValues[upvalues[8]]
                                                        r2 = 0
                                                        r22 = state(r23, r2)
                                                        state = 50
                                                    end
                                                end
                                            else
                                                if state == 50 then
                                                    state = {}
                                                    r22 = state
                                                    r2 = upvalueValues[upvalues[9]]
                                                    r41 = r2
                                                    r2 = 1
                                                    r7 = r2
                                                    r2 = 0
                                                    r9 = r7 < r2
                                                    r23 = 1
                                                    r2 = r23 - r7
                                                    state = 51
                                                end
                                            end
                                        else
                                            if state <= 52 then
                                                if state <= 51 then
                                                    if state == 51 then
                                                        r2 = r2 + r7
                                                        r43 = not r9
                                                        r23 = r2 <= r41
                                                        r23 = r43 and r23
                                                        r43 = r2 >= r41
                                                        r43 = r9 and r43
                                                        r23 = r43 or r23
                                                        r43 = (52)
                                                        state = r23 and r43
                                                        r23 = (53)
                                                        state = state or r23
                                                    end
                                                else
                                                    if state == 52 then
                                                        state = upvalueValues[upvalues[1]]
                                                        r23 = r2
                                                        r28 = 255
                                                        r20 = 0
                                                        r43 = state(r20, r28)
                                                        r22[r23] = r43
                                                        r23 = nil
                                                        state = 51
                                                    end
                                                end
                                            else
                                                if state == 53 then
                                                    state = upvalueValues[upvalues[10]]
                                                    r23 = upvalueValues[upvalues[11]]
                                                    r22[state] = r23
                                                    state = upvalueValues[upvalues[12]]
                                                    r23 = {
                                                        state(r22)
                                                    }
                                                    ReturnVal = {
                                                        unpack(r23)
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure2 entry 6577021 -> 54, states 54-57
                                if state <= 55 then
                                    if state <= 54 then
                                        if state == 54 then -- entry 6577021 -> 54
                                            state = 55
                                        end
                                    else
                                        if state == 55 then
                                            state = true
                                            state = state and (56) or (57)
                                        end
                                    end
                                else
                                    if state <= 56 then
                                        if state == 56 then
                                            ReturnVal = "l2"
                                            state = _env[ReturnVal]
                                            r22 = "l1"
                                            ReturnVal = _env[r22]
                                            r22 = "l1"
                                            _env[r22] = state
                                            r22 = "l2"
                                            _env[r22] = ReturnVal
                                            r22 = upvalueValues[upvalues[1]]
                                            r23 = r22()
                                            state = 55
                                        end
                                    else
                                        if state == 57 then
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 125 then
                            if state <= 70 then
                                if state <= 63 then
                                    -- createClosure5 entry 12867739 -> 58, states 58-63
                                    if state <= 60 then
                                        if state <= 59 then
                                            if state <= 58 then
                                                if state == 58 then -- entry 12867739 -> 58
                                                    r22 = upvalueValues[upvalues[1]]
                                                    ReturnVal = #r22
                                                    r22 = 0
                                                    state = ReturnVal == r22
                                                    state = state and (59) or (60)
                                                end
                                            else
                                                if state == 59 then
                                                    r23 = upvalueValues[upvalues[2]]
                                                    r2 = 61
                                                    r22 = r23 * r2
                                                    r23 = 28789881353309
                                                    ReturnVal = r22 + r23
                                                    r22 = 35184372088832
                                                    state = ReturnVal % r22
                                                    upvalueValues[upvalues[2]] = state
                                                    r22 = upvalueValues[upvalues[3]]
                                                    r23 = 1
                                                    ReturnVal = r22 ~= r23
                                                    state = 61
                                                end
                                            end
                                        else
                                            if state == 60 then
                                                r2 = "table"
                                                r23 = _env[r2]
                                                r2 = "remove"
                                                r22 = r23[r2]
                                                r2 = upvalueValues[upvalues[1]]
                                                r23 = {
                                                    r22(r2)
                                                }
                                                ReturnVal = {
                                                    unpack(r23)
                                                }
                                                state = nil
                                            end
                                        end
                                    else
                                        if state <= 62 then
                                            if state <= 61 then
                                                if state == 61 then
                                                    r23 = upvalueValues[upvalues[3]]
                                                    r2 = 212
                                                    r22 = r23 * r2
                                                    r23 = 257
                                                    ReturnVal = r22 % r23
                                                    upvalueValues[upvalues[3]] = ReturnVal
                                                    state = 62
                                                end
                                            else
                                                if state == 62 then
                                                    r23 = upvalueValues[upvalues[3]]
                                                    r2 = 1
                                                    r22 = r23 ~= r2
                                                    state = r22 and (63) or (61)
                                                end
                                            end
                                        else
                                            if state == 63 then
                                                r28 = 2
                                                r2 = 32
                                                r23 = upvalueValues[upvalues[3]]
                                                r22 = r23 % r2
                                                r41 = upvalueValues[upvalues[4]]
                                                r43 = upvalueValues[upvalues[2]]
                                                r54 = upvalueValues[upvalues[3]]
                                                r38 = r54 - r22
                                                r54 = 32
                                                r26 = r38 / r54
                                                r60 = 13
                                                r3 = r60 - r26
                                                r20 = r28 ^ r3
                                                r9 = r43 / r20
                                                r7 = r41(r9)
                                                r20 = 1
                                                r41 = 4294967296
                                                r28 = 256
                                                r2 = r7 % r41
                                                r7 = 2
                                                r41 = r7 ^ r22
                                                r23 = r2 / r41
                                                r41 = upvalueValues[upvalues[4]]
                                                r43 = r23 % r20
                                                r20 = 4294967296
                                                r9 = r43 * r20
                                                r7 = r41(r9)
                                                r41 = upvalueValues[upvalues[4]]
                                                r9 = r41(r23)
                                                r2 = r7 + r9
                                                r7 = 65536
                                                r43 = 65536
                                                r41 = r2 % r7
                                                r9 = r2 - r41
                                                r7 = r9 / r43
                                                r43 = 256
                                                r9 = r41 % r43
                                                r20 = r41 - r9
                                                r43 = r20 / r28
                                                r28 = 256
                                                r20 = r7 % r28
                                                r60 = 256
                                                r22 = nil
                                                r3 = r7 - r20
                                                r28 = r3 / r60
                                                r3 = {
                                                    r9,
                                                    r43,
                                                    r20,
                                                    r28
                                                }
                                                r23 = nil
                                                r43 = nil
                                                r2 = nil
                                                r41 = nil
                                                r28 = nil
                                                r20 = nil
                                                r9 = nil
                                                upvalueValues[upvalues[1]] = r3
                                                r7 = nil
                                                state = 60
                                            end
                                        end
                                    end
                                else
                                    -- createClosure7 entry 3307310 -> 64, states 64-70
                                    if state <= 67 then
                                        if state <= 65 then
                                            if state <= 64 then
                                                if state == 64 then -- entry 3307310 -> 64
                                                    r22 = args[1]
                                                    r23 = args[2]
                                                    state = upvalueValues[upvalues[1]]
                                                    r2 = state
                                                    state = r2[r23]
                                                    state = state and (65) or (66)
                                                end
                                            else
                                                if state == 65 then
                                                    state = 67
                                                end
                                            end
                                        else
                                            if state <= 66 then
                                                if state == 66 then
                                                    state = {}
                                                    upvalueValues[upvalues[2]] = state
                                                    ReturnVal = upvalueValues[upvalues[3]]
                                                    r41 = ReturnVal
                                                    r3 = 1
                                                    r60 = r3
                                                    r7 = 35184372088832
                                                    ReturnVal = r23 % r7
                                                    upvalueValues[upvalues[4]] = ReturnVal
                                                    r43 = 255
                                                    r9 = r23 % r43
                                                    r43 = 2
                                                    r7 = r9 + r43
                                                    upvalueValues[upvalues[5]] = r7
                                                    r20 = "string"
                                                    r43 = _env[r20]
                                                    r20 = "len"
                                                    r9 = r43[r20]
                                                    r43 = r9(r22)
                                                    r9 = ""
                                                    r2[r23] = r9
                                                    r3 = 0
                                                    r26 = r60 < r3
                                                    r20 = 1
                                                    r3 = r20 - r60
                                                    r28 = r43
                                                    r9 = 73
                                                    state = 68
                                                end
                                            else
                                                if state == 67 then
                                                    ReturnVal = {
                                                        r23
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        if state <= 69 then
                                            if state <= 68 then
                                                if state == 68 then
                                                    r3 = r3 + r60
                                                    r20 = r3 <= r28
                                                    r38 = not r26
                                                    r20 = r38 and r20
                                                    r38 = r3 >= r28
                                                    r38 = r26 and r38
                                                    r20 = r38 or r20
                                                    r38 = (69)
                                                    state = r20 and r38
                                                    r20 = (70)
                                                    state = state or r20
                                                end
                                            else
                                                if state == 69 then
                                                    r20 = r3
                                                    r49 = "string"
                                                    r11 = _env[r49]
                                                    r49 = "byte"
                                                    r18 = r11[r49]
                                                    r11 = r18(r22, r20)
                                                    r18 = upvalueValues[upvalues[6]]
                                                    r49 = r18()
                                                    r68 = r11 + r49
                                                    r54 = r68 + r9
                                                    r68 = 256
                                                    r38 = r54 % r68
                                                    r9 = r38
                                                    r68 = r2[r23]
                                                    r49 = 1
                                                    r11 = r9 + r49
                                                    r18 = r41[r11]
                                                    r20 = nil
                                                    r54 = r68 .. r18
                                                    r2[r23] = r54
                                                    state = 68
                                                end
                                            end
                                        else
                                            if state == 70 then
                                                r9 = nil
                                                r43 = nil
                                                r41 = nil
                                                state = 67
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure6 entry 1579062 -> 71, states 71-125
                                if state <= 98 then
                                    if state <= 84 then
                                        if state <= 77 then
                                            if state <= 74 then
                                                if state <= 72 then
                                                    if state <= 71 then
                                                        if state == 71 then -- entry 1579062 -> 71
                                                            r2 = args[3]
                                                            r23 = args[2]
                                                            r22 = allocUpvalue()
                                                            upvalueValues[r22] = args[1]
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r7 = upvalueValues[upvalues[2]]
                                                            r9 = upvalueValues[upvalues[3]]
                                                            r28 = 12887095629681
                                                            r20 = "xi0\196\201\157"
                                                            r43 = r9(r20, r28)
                                                            r41 = r7[r43]
                                                            state = ReturnVal[r41]
                                                            r41 = state
                                                            r7 = "game"
                                                            ReturnVal = _env[r7]
                                                            r9 = upvalueValues[upvalues[2]]
                                                            r43 = upvalueValues[upvalues[3]]
                                                            r3 = 23347658418808
                                                            r28 = "H\254\153\190\244Z\149"
                                                            r20 = r43(r28, r3)
                                                            r7 = r9[r20]
                                                            state = ReturnVal[r7]
                                                            r7 = state
                                                            ReturnVal = "tostring"
                                                            state = _env[ReturnVal]
                                                            r20 = "game"
                                                            r43 = _env[r20]
                                                            r28 = upvalueValues[upvalues[2]]
                                                            r3 = upvalueValues[upvalues[3]]
                                                            r38 = 22398772963518
                                                            r26 = "\155\006OA\219"
                                                            r60 = r3(r26, r38)
                                                            r20 = r28[r60]
                                                            r9 = r43[r20]
                                                            ReturnVal = state(r9)
                                                            r9 = ReturnVal
                                                            ReturnVal = upvalueValues[upvalues[4]]
                                                            r3 = "game"
                                                            r28 = _env[r3]
                                                            r60 = upvalueValues[upvalues[2]]
                                                            r26 = upvalueValues[upvalues[3]]
                                                            r54 = "\178\14782\230H\n"
                                                            r68 = 23005499910616
                                                            r38 = r26(r54, r68)
                                                            r3 = r60[r38]
                                                            r43 = "GetProductInfo"
                                                            r43 = ReturnVal[r43]
                                                            r20 = r28[r3]
                                                            r43 = r43(ReturnVal, r20)
                                                            r20 = upvalueValues[upvalues[2]]
                                                            r28 = upvalueValues[upvalues[3]]
                                                            r26 = 18659007619568
                                                            r60 = "HQ.\228"
                                                            r3 = r28(r60, r26)
                                                            ReturnVal = r20[r3]
                                                            state = r43[ReturnVal]
                                                            r28 = state
                                                            r43 = state
                                                            r60 = upvalueValues[upvalues[5]]
                                                            r26 = "GetPlatform"
                                                            r26 = r60[r26]
                                                            r26 = r26(r60)
                                                            r68 = "Enum"
                                                            r54 = _env[r68]
                                                            r18 = upvalueValues[upvalues[2]]
                                                            r11 = upvalueValues[upvalues[3]]
                                                            r65 = 21428642785018
                                                            r25 = "\207^\214+\134J[G"
                                                            r49 = r11(r25, r65)
                                                            r68 = r18[r49]
                                                            r38 = r54[r68]
                                                            r68 = upvalueValues[upvalues[2]]
                                                            r18 = upvalueValues[upvalues[3]]
                                                            r49 = "\003\130\172\149\247\026<"
                                                            r25 = 11232950342766
                                                            r11 = r18(r49, r25)
                                                            r54 = r68[r11]
                                                            r60 = r38[r54]
                                                            r3 = r26 == r60
                                                            state = r3 and (72) or (73)
                                                            r20 = r3
                                                        end
                                                    else
                                                        if state == 72 then
                                                            r60 = upvalueValues[upvalues[2]]
                                                            r26 = upvalueValues[upvalues[3]]
                                                            r68 = 5898049063610
                                                            r54 = "\252W\n\025\206\247\189"
                                                            r38 = r26(r54, r68)
                                                            r3 = r60[r38]
                                                            r20 = r3
                                                            state = 73
                                                        end
                                                    end
                                                else
                                                    if state <= 73 then
                                                        if state == 73 then
                                                            state = r28
                                                            state = r20 and (74) or (75)
                                                            ReturnVal = r20
                                                        end
                                                    else
                                                        if state == 74 then
                                                            r20 = ReturnVal
                                                            r28 = upvalueValues[upvalues[2]]
                                                            r3 = upvalueValues[upvalues[3]]
                                                            r38 = 3776324830942
                                                            r26 = "\153\135\252\006vF\219\172\219\018;&\204\170\024\238^\026\179\185\193\201P\196Q\168o\231N\176\129\142\191\154\2133\219\181]\025li\245\128a\147Q\016X\0266\195\169\171\2490\152=X"
                                                            r60 = r3(r26, r38)
                                                            ReturnVal = r28[r60]
                                                            r26 = upvalueValues[upvalues[2]]
                                                            r38 = upvalueValues[upvalues[3]]
                                                            r68 = "\212Z\195"
                                                            r18 = 3135188026803
                                                            r54 = r38(r68, r18)
                                                            r60 = r26[r54]
                                                            r54 = upvalueValues[upvalues[2]]
                                                            r68 = upvalueValues[upvalues[3]]
                                                            r11 = "]\214.X\130\r\198\139\199\020"
                                                            r49 = 26274698440651
                                                            r18 = r68(r11, r49)
                                                            r38 = r54[r18]
                                                            r26 = r9 .. r38
                                                            r3 = r60 .. r26
                                                            r28 = r7 .. r3
                                                            state = ReturnVal .. r28
                                                            r28 = state
                                                            r3 = "os"
                                                            ReturnVal = _env[r3]
                                                            r60 = upvalueValues[upvalues[2]]
                                                            r26 = upvalueValues[upvalues[3]]
                                                            r68 = 31780093524430
                                                            r54 = "1s|<"
                                                            r38 = r26(r54, r68)
                                                            r3 = r60[r38]
                                                            state = ReturnVal[r3]
                                                            r60 = upvalueValues[upvalues[2]]
                                                            r26 = upvalueValues[upvalues[3]]
                                                            r54 = "\017$\t\2383<\218\182\0077\0161\237\178\r\216\027"
                                                            r68 = 8852131713050
                                                            r38 = r26(r54, r68)
                                                            r3 = r60[r38]
                                                            ReturnVal = state(r3)
                                                            r3 = ReturnVal
                                                            r60 = "math"
                                                            ReturnVal = _env[r60]
                                                            r26 = upvalueValues[upvalues[2]]
                                                            r38 = upvalueValues[upvalues[3]]
                                                            r18 = 3019635967358
                                                            r68 = "\154X33A"
                                                            r54 = r38(r68, r18)
                                                            r60 = r26[r54]
                                                            state = ReturnVal[r60]
                                                            r68 = "workspace"
                                                            r54 = _env[r68]
                                                            r18 = upvalueValues[upvalues[2]]
                                                            r11 = upvalueValues[upvalues[3]]
                                                            r65 = 11717646947664
                                                            r25 = "\188<\219\216\222\145\t\139\171\239+v\191"
                                                            r49 = r11(r25, r65)
                                                            r68 = r18[r49]
                                                            r38 = r54[r68]
                                                            r68 = upvalueValues[upvalues[2]]
                                                            r18 = upvalueValues[upvalues[3]]
                                                            r49 = "\179H\169\217. 2\252\246$\139\237"
                                                            r25 = 15871077506270
                                                            r11 = r18(r49, r25)
                                                            r54 = r68[r11]
                                                            r26 = r38[r54]
                                                            r54 = upvalueValues[upvalues[2]]
                                                            r68 = upvalueValues[upvalues[3]]
                                                            r11 = "{"
                                                            r49 = 2784822019344
                                                            r18 = r68(r11, r49)
                                                            r38 = r54[r18]
                                                            r60 = r26[r38]
                                                            ReturnVal = state(r60)
                                                            r60 = ReturnVal
                                                            r26 = "math"
                                                            ReturnVal = _env[r26]
                                                            r38 = upvalueValues[upvalues[2]]
                                                            r54 = upvalueValues[upvalues[3]]
                                                            r18 = "\012\167%\182\174"
                                                            r11 = 20657971111315
                                                            r68 = r54(r18, r11)
                                                            r26 = r38[r68]
                                                            state = ReturnVal[r26]
                                                            r18 = "workspace"
                                                            r68 = _env[r18]
                                                            r11 = upvalueValues[upvalues[2]]
                                                            r49 = upvalueValues[upvalues[3]]
                                                            r31 = 11190794605659
                                                            r65 = "4\194\171o\251\021n\138\020p\135\157\148"
                                                            r25 = r49(r65, r31)
                                                            r18 = r11[r25]
                                                            r54 = r68[r18]
                                                            r18 = upvalueValues[upvalues[2]]
                                                            r11 = upvalueValues[upvalues[3]]
                                                            r65 = 30286012200727
                                                            r25 = "b\221LHM\016T\005 \167\215\142"
                                                            r49 = r11(r25, r65)
                                                            r68 = r18[r49]
                                                            r38 = r54[r68]
                                                            r68 = upvalueValues[upvalues[2]]
                                                            r18 = upvalueValues[upvalues[3]]
                                                            r25 = 34439144226468
                                                            r49 = "T"
                                                            r11 = r18(r49, r25)
                                                            r54 = r68[r11]
                                                            r26 = r38[r54]
                                                            ReturnVal = state(r26)
                                                            r26 = ReturnVal
                                                            state = upvalueValues[upvalues[6]]
                                                            ReturnVal = "GetTotalMemoryUsageMb"
                                                            ReturnVal = state[ReturnVal]
                                                            ReturnVal = ReturnVal(state)
                                                            r38 = ReturnVal
                                                            ReturnVal = upvalueValues[upvalues[7]]
                                                            r54 = "GetPlayers"
                                                            r54 = ReturnVal[r54]
                                                            r54 = r54(ReturnVal)
                                                            state = #r54
                                                            r54 = state
                                                            ReturnVal = upvalueValues[upvalues[7]]
                                                            r18 = upvalueValues[upvalues[2]]
                                                            r11 = upvalueValues[upvalues[3]]
                                                            r65 = 4956194457859
                                                            r25 = "\021\224\203\"\233\155\129;\156("
                                                            r49 = r11(r25, r65)
                                                            r68 = r18[r49]
                                                            state = ReturnVal[r68]
                                                            r11 = state
                                                            r68 = state
                                                            r25 = upvalueValues[upvalues[1]]
                                                            r31 = upvalueValues[upvalues[2]]
                                                            r21 = upvalueValues[upvalues[3]]
                                                            r14 = 19616849372078
                                                            r55 = "\239\252\203'\145RG\024\181"
                                                            r35 = r21(r55, r14)
                                                            r65 = r31[r35]
                                                            r49 = r25[r65]
                                                            state = r49 and (76) or (77)
                                                            r18 = r49
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 76 then
                                                    if state <= 75 then
                                                        if state == 75 then
                                                            r28 = upvalueValues[upvalues[2]]
                                                            r3 = upvalueValues[upvalues[3]]
                                                            r38 = 29566604129736
                                                            r26 = "\137jS\183\0299\021\152\160\144\148"
                                                            r60 = r3(r26, r38)
                                                            r20 = r28[r60]
                                                            ReturnVal = r20
                                                            state = 74
                                                        end
                                                    else
                                                        if state == 76 then
                                                            r25 = state
                                                            r31 = upvalueValues[upvalues[1]]
                                                            r35 = upvalueValues[upvalues[2]]
                                                            r55 = upvalueValues[upvalues[3]]
                                                            r33 = "d\205H~dF$\180\207"
                                                            r12 = 34803317423950
                                                            r14 = r55(r33, r12)
                                                            r21 = r35[r14]
                                                            r65 = r31[r21]
                                                            r35 = upvalueValues[upvalues[2]]
                                                            r55 = upvalueValues[upvalues[3]]
                                                            r33 = "{\131\248\2397\181\0167"
                                                            r12 = 27036477354285
                                                            r14 = r55(r33, r12)
                                                            r31 = "FindFirstChild"
                                                            r31 = r65[r31]
                                                            r21 = r35[r14]
                                                            r31 = r31(r65, r21)
                                                            state = r31 and (78) or (79)
                                                            r49 = r31
                                                        end
                                                    end
                                                else
                                                    if state == 77 then
                                                        state = r11
                                                        state = r18 and (80) or (81)
                                                        ReturnVal = r18
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 81 then
                                                if state <= 79 then
                                                    if state <= 78 then
                                                        if state == 78 then
                                                            r35 = upvalueValues[upvalues[1]]
                                                            r14 = upvalueValues[upvalues[2]]
                                                            r33 = upvalueValues[upvalues[3]]
                                                            r1 = "x\149\212\230\t\237\158\187\t"
                                                            r59 = 7040430509262
                                                            r12 = r33(r1, r59)
                                                            r55 = r14[r12]
                                                            r21 = r35[r55]
                                                            r55 = upvalueValues[upvalues[2]]
                                                            r14 = upvalueValues[upvalues[3]]
                                                            r1 = 13914686462287
                                                            r12 = "\0315U\136`e\198\204"
                                                            r33 = r14(r12, r1)
                                                            r35 = r55[r33]
                                                            r31 = r21[r35]
                                                            r35 = upvalueValues[upvalues[2]]
                                                            r55 = upvalueValues[upvalues[3]]
                                                            r12 = 31410493978914
                                                            r33 = "\238\149\020\008as"
                                                            r14 = r55(r33, r12)
                                                            r21 = r35[r14]
                                                            r65 = r31[r21]
                                                            r49 = r65
                                                            state = 79
                                                        end
                                                    else
                                                        if state == 79 then
                                                            state = r25
                                                            r18 = r49
                                                            state = 77
                                                        end
                                                    end
                                                else
                                                    if state <= 80 then
                                                        if state == 80 then
                                                            r49 = state
                                                            r65 = upvalueValues[upvalues[1]]
                                                            r21 = upvalueValues[upvalues[2]]
                                                            r35 = upvalueValues[upvalues[3]]
                                                            r33 = 7523578056111
                                                            r14 = "9O\171\031;\207OEE"
                                                            r55 = r35(r14, r33)
                                                            r31 = r21[r55]
                                                            r25 = r65[r31]
                                                            state = r25 and (82) or (83)
                                                            r18 = ReturnVal
                                                            r11 = r25
                                                        end
                                                    else
                                                        if state == 81 then
                                                            r11 = upvalueValues[upvalues[2]]
                                                            r49 = upvalueValues[upvalues[3]]
                                                            r31 = 5073210280250
                                                            r65 = "!X\167"
                                                            r25 = r49(r65, r31)
                                                            r18 = r11[r25]
                                                            ReturnVal = r18
                                                            state = 80
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 83 then
                                                    if state <= 82 then
                                                        if state == 82 then
                                                            r65 = state
                                                            r21 = upvalueValues[upvalues[1]]
                                                            r55 = upvalueValues[upvalues[2]]
                                                            r14 = upvalueValues[upvalues[3]]
                                                            r1 = 9113217519763
                                                            r12 = "\023\142\208X[0\248\175\129"
                                                            r33 = r14(r12, r1)
                                                            r35 = r55[r33]
                                                            r31 = r21[r35]
                                                            r55 = upvalueValues[upvalues[2]]
                                                            r14 = upvalueValues[upvalues[3]]
                                                            r1 = 28420868715442
                                                            r12 = "\207o\141E\004I\0244"
                                                            r33 = r14(r12, r1)
                                                            r35 = r55[r33]
                                                            r21 = "FindFirstChild"
                                                            r21 = r31[r21]
                                                            r21 = r21(r31, r35)
                                                            state = r21 and (84) or (85)
                                                            r25 = r21
                                                        end
                                                    else
                                                        if state == 83 then
                                                            state = r49
                                                            state = r11 and (86) or (87)
                                                            ReturnVal = r11
                                                        end
                                                    end
                                                else
                                                    if state == 84 then
                                                        r55 = upvalueValues[upvalues[1]]
                                                        r33 = upvalueValues[upvalues[2]]
                                                        r12 = upvalueValues[upvalues[3]]
                                                        r59 = "\253\234\233\247o\162 \213\146"
                                                        r46 = 29922351019629
                                                        r1 = r12(r59, r46)
                                                        r14 = r33[r1]
                                                        r35 = r55[r14]
                                                        r14 = upvalueValues[upvalues[2]]
                                                        r33 = upvalueValues[upvalues[3]]
                                                        r1 = "\242\214\251\164PM\228\201"
                                                        r59 = 32118717430380
                                                        r12 = r33(r1, r59)
                                                        r55 = r14[r12]
                                                        r21 = r35[r55]
                                                        r55 = upvalueValues[upvalues[2]]
                                                        r14 = upvalueValues[upvalues[3]]
                                                        r1 = 11895504229795
                                                        r12 = "\200\206\239kr\158\131Y\244"
                                                        r33 = r14(r12, r1)
                                                        r35 = r55[r33]
                                                        r31 = r21[r35]
                                                        r25 = r31
                                                        state = 85
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 91 then
                                            if state <= 88 then
                                                if state <= 86 then
                                                    if state <= 85 then
                                                        if state == 85 then
                                                            state = r65
                                                            r11 = r25
                                                            state = 83
                                                        end
                                                    else
                                                        if state == 86 then
                                                            r31 = upvalueValues[upvalues[1]]
                                                            r35 = upvalueValues[upvalues[2]]
                                                            r55 = upvalueValues[upvalues[3]]
                                                            r12 = 8167295667931
                                                            r33 = "\178\187zkR\133[<\208"
                                                            r14 = r55(r33, r12)
                                                            r21 = r35[r14]
                                                            r65 = r31[r21]
                                                            r25 = state
                                                            state = r65 and (88) or (89)
                                                            r11 = ReturnVal
                                                            r49 = r65
                                                        end
                                                    end
                                                else
                                                    if state <= 87 then
                                                        if state == 87 then
                                                            r49 = upvalueValues[upvalues[2]]
                                                            r25 = upvalueValues[upvalues[3]]
                                                            r31 = "\214p\141"
                                                            r21 = 16166621699432
                                                            r65 = r25(r31, r21)
                                                            r11 = r49[r65]
                                                            ReturnVal = r11
                                                            state = 86
                                                        end
                                                    else
                                                        if state == 88 then
                                                            r31 = state
                                                            r35 = upvalueValues[upvalues[1]]
                                                            r14 = upvalueValues[upvalues[2]]
                                                            r33 = upvalueValues[upvalues[3]]
                                                            r1 = "M\185\128+\020\186d'a"
                                                            r59 = 17793553293405
                                                            r12 = r33(r1, r59)
                                                            r55 = r14[r12]
                                                            r21 = r35[r55]
                                                            r14 = upvalueValues[upvalues[2]]
                                                            r33 = upvalueValues[upvalues[3]]
                                                            r59 = 10548853740336
                                                            r1 = "\207\168\223@\161U\192\169\232<H3\138\247\002\135"
                                                            r12 = r33(r1, r59)
                                                            r35 = "FindFirstChild"
                                                            r35 = r21[r35]
                                                            r55 = r14[r12]
                                                            r35 = r35(r21, r55)
                                                            state = r35 and (90) or (91)
                                                            r65 = r35
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 90 then
                                                    if state <= 89 then
                                                        if state == 89 then
                                                            state = r25
                                                            state = r49 and (92) or (93)
                                                            ReturnVal = r49
                                                        end
                                                    else
                                                        if state == 90 then
                                                            r14 = upvalueValues[upvalues[1]]
                                                            r12 = upvalueValues[upvalues[2]]
                                                            r1 = upvalueValues[upvalues[3]]
                                                            r17 = 11943620515257
                                                            r46 = "\130\242\\\184\148\202\201\246\153"
                                                            r59 = r1(r46, r17)
                                                            r33 = r12[r59]
                                                            r55 = r14[r33]
                                                            r33 = upvalueValues[upvalues[2]]
                                                            r12 = upvalueValues[upvalues[3]]
                                                            r59 = "\189G\222\155\006\021\155\216N\016\005\152}\031\ta"
                                                            r46 = 20928741320209
                                                            r1 = r12(r59, r46)
                                                            r14 = r33[r1]
                                                            r35 = r55[r14]
                                                            r14 = upvalueValues[upvalues[2]]
                                                            r33 = upvalueValues[upvalues[3]]
                                                            r59 = 1639180075771
                                                            r1 = "\020\n\202g\167t\165\255"
                                                            r12 = r33(r1, r59)
                                                            r55 = r14[r12]
                                                            r21 = r35[r55]
                                                            r65 = r21
                                                            state = 91
                                                        end
                                                    end
                                                else
                                                    if state == 91 then
                                                        state = r31
                                                        r49 = r65
                                                        state = 89
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 95 then
                                                if state <= 93 then
                                                    if state <= 92 then
                                                        if state == 92 then
                                                            r49 = ReturnVal
                                                            r25 = "game"
                                                            ReturnVal = _env[r25]
                                                            r65 = upvalueValues[upvalues[2]]
                                                            r31 = upvalueValues[upvalues[3]]
                                                            r55 = 29780873033259
                                                            r35 = "\134\000N\244$\"Z\203\240\234J\177"
                                                            r21 = r31(r35, r55)
                                                            r25 = r65[r21]
                                                            state = ReturnVal[r25]
                                                            r25 = state
                                                            r31 = "tonumber"
                                                            r65 = _env[r31]
                                                            r14 = upvalueValues[upvalues[6]]
                                                            r12 = upvalueValues[upvalues[2]]
                                                            r1 = upvalueValues[upvalues[3]]
                                                            r17 = 4658816043129
                                                            r46 = "\014N\217\178\245FN"
                                                            r59 = r1(r46, r17)
                                                            r33 = r12[r59]
                                                            r55 = r14[r33]
                                                            r33 = upvalueValues[upvalues[2]]
                                                            r12 = upvalueValues[upvalues[3]]
                                                            r46 = 20256988898520
                                                            r59 = "KR>\167\153 S\132\167,\183v^\184\244"
                                                            r1 = r12(r59, r46)
                                                            r14 = r33[r1]
                                                            r35 = r55[r14]
                                                            r14 = upvalueValues[upvalues[2]]
                                                            r33 = upvalueValues[upvalues[3]]
                                                            r59 = 10467578450698
                                                            r1 = "\134\193\191\142K\133\170%\215"
                                                            r12 = r33(r1, r59)
                                                            r55 = r14[r12]
                                                            r21 = r35[r55]
                                                            r35 = "GetValueString"
                                                            r35 = r21[r35]
                                                            r35 = r35(r21)
                                                            r14 = upvalueValues[upvalues[2]]
                                                            r33 = upvalueValues[upvalues[3]]
                                                            r1 = "\170k\030V\140"
                                                            r59 = 7443638078858
                                                            r12 = r33(r1, r59)
                                                            r55 = r14[r12]
                                                            r14 = "match"
                                                            r14 = r35[r14]
                                                            r21 = {
                                                                r14(r35, r55)
                                                            }
                                                            r31 = r65(unpack(r21))
                                                            state = r31 and (94) or (95)
                                                            ReturnVal = r31
                                                        end
                                                    else
                                                        if state == 93 then
                                                            r25 = upvalueValues[upvalues[2]]
                                                            r65 = upvalueValues[upvalues[3]]
                                                            r21 = "\184\1541"
                                                            r35 = 8539341934472
                                                            r31 = r65(r21, r35)
                                                            r49 = r25[r31]
                                                            ReturnVal = r49
                                                            state = 92
                                                        end
                                                    end
                                                else
                                                    if state <= 94 then
                                                        if state == 94 then
                                                            r65 = ReturnVal
                                                            state = createClosure4(140, {
                                                                upvalues[1],
                                                                upvalues[2],
                                                                upvalues[3]
                                                            })
                                                            r31 = state
                                                            state = r31()
                                                            r21 = state
                                                            r35 = upvalueValues[upvalues[2]]
                                                            r55 = upvalueValues[upvalues[3]]
                                                            r33 = "\180@Y0-\159\163"
                                                            r12 = 18466672779671
                                                            r14 = r55(r33, r12)
                                                            ReturnVal = r35[r14]
                                                            r55 = upvalueValues[upvalues[2]]
                                                            r14 = upvalueValues[upvalues[3]]
                                                            r12 = "\005\154\1403.\021\0223\228"
                                                            r1 = 29202558055710
                                                            r33 = r14(r12, r1)
                                                            r35 = r55[r33]
                                                            r14 = upvalueValues[upvalues[2]]
                                                            r33 = upvalueValues[upvalues[3]]
                                                            r59 = 18518991823279
                                                            r1 = "\140^\250\207\204\141"
                                                            r12 = r33(r1, r59)
                                                            r55 = r14[r12]
                                                            r1 = upvalueValues[upvalues[2]]
                                                            r59 = upvalueValues[upvalues[3]]
                                                            r17 = "\157c\129X0"
                                                            r57 = 14692794653369
                                                            r46 = r59(r17, r57)
                                                            r12 = r1[r46]
                                                            r59 = upvalueValues[upvalues[2]]
                                                            r46 = upvalueValues[upvalues[3]]
                                                            r57 = "V\190W\140\163\255\023b\130\202\216\199\20228lJ\007\255\241RQ\233I\016\132\169 \184\005\155\236\156\253\248\193\131'\244-\006\241\223&\003"
                                                            r67 = 34275768335960
                                                            r17 = r46(r57, r67)
                                                            r1 = r59[r17]
                                                            r46 = upvalueValues[upvalues[2]]
                                                            r17 = upvalueValues[upvalues[3]]
                                                            r67 = "\239\160\208\239U\168\185-;\1612"
                                                            r39 = 26042569879391
                                                            r57 = r17(r67, r39)
                                                            r59 = r46[r57]
                                                            r17 = upvalueValues[upvalues[2]]
                                                            r57 = upvalueValues[upvalues[3]]
                                                            r62 = 23806012173133
                                                            r39 = " \192\239\005\236qF\2480\212\223\135;\235\138\162\179\016\240f(U\1871\134\215k\150\221V\136z^I\155\021+\206\226\135\223\185\238\154k\184\022\196\243\1780k\235\163\201y\000\170p\197\241"
                                                            r67 = r57(r39, r62)
                                                            r46 = r17[r67]
                                                            r57 = upvalueValues[upvalues[2]]
                                                            r67 = upvalueValues[upvalues[3]]
                                                            r13 = 27512264946187
                                                            r62 = "]\253K\179"
                                                            r39 = r67(r62, r13)
                                                            r17 = r57[r39]
                                                            r67 = upvalueValues[upvalues[2]]
                                                            r39 = upvalueValues[upvalues[3]]
                                                            r64 = 20780548810188
                                                            r13 = "\023\138K\144"
                                                            r62 = r39(r13, r64)
                                                            r57 = r67[r62]
                                                            r39 = upvalueValues[upvalues[2]]
                                                            r62 = upvalueValues[upvalues[3]]
                                                            r58 = 20740357514681
                                                            r64 = "DusG\229"
                                                            r13 = r62(r64, r58)
                                                            r67 = r39[r13]
                                                            r62 = "tonumber"
                                                            r39 = _env[r62]
                                                            r13 = 3447003
                                                            r62 = r39(r13)
                                                            r13 = upvalueValues[upvalues[2]]
                                                            r64 = upvalueValues[upvalues[3]]
                                                            r16 = 4223397087150
                                                            r48 = "\187\196\166+\220R"
                                                            r58 = r64(r48, r16)
                                                            r39 = r13[r58]
                                                            r48 = upvalueValues[upvalues[2]]
                                                            r16 = upvalueValues[upvalues[3]]
                                                            r61 = 1762798404404
                                                            r56 = "F\016m\028"
                                                            r5 = r16(r56, r61)
                                                            r58 = r48[r5]
                                                            r16 = upvalueValues[upvalues[2]]
                                                            r5 = upvalueValues[upvalues[3]]
                                                            r61 = "\200_\229\230\020\235g#\154\176:\204\205I\249\180\2375N\152"
                                                            r36 = 28907653182613
                                                            r56 = r5(r61, r36)
                                                            r48 = r16[r56]
                                                            r5 = upvalueValues[upvalues[2]]
                                                            r56 = upvalueValues[upvalues[3]]
                                                            r4 = 22016950380556
                                                            r36 = "\167\189\015_\146"
                                                            r61 = r56(r36, r4)
                                                            r16 = r5[r61]
                                                            r61 = upvalueValues[upvalues[2]]
                                                            r36 = upvalueValues[upvalues[3]]
                                                            r66 = "\154\137\251W\165\210)\"\148\156G\022]\203\162\001\143\215v\180\128"
                                                            r44 = 12311652144741
                                                            r4 = r36(r66, r44)
                                                            r56 = r61[r4]
                                                            r66 = "getgenv"
                                                            r4 = _env[r66]
                                                            r66 = r4()
                                                            r44 = upvalueValues[upvalues[2]]
                                                            r47 = upvalueValues[upvalues[3]]
                                                            r37 = 5666901592654
                                                            r27 = "}\201w\165\148I\215^"
                                                            r15 = r47(r27, r37)
                                                            r4 = r44[r15]
                                                            r36 = r66[r4]
                                                            r44 = upvalueValues[upvalues[2]]
                                                            r47 = upvalueValues[upvalues[3]]
                                                            r37 = 7761319611934
                                                            r27 = "\186\145\147\164/\151\137\029\143\223\150\177\201\253\203\1736\230"
                                                            r15 = r47(r27, r37)
                                                            r66 = r44[r15]
                                                            r27 = upvalueValues[upvalues[2]]
                                                            r37 = upvalueValues[upvalues[3]]
                                                            r50 = 13950832220512
                                                            r29 = "i\225h\214\014\001\169f\\\192\192\215\195\223\011\200V\159\235\181y\172\031"
                                                            r51 = r37(r29, r50)
                                                            r15 = r27[r51]
                                                            r51 = upvalueValues[upvalues[2]]
                                                            r29 = upvalueValues[upvalues[3]]
                                                            r32 = 14206243543511
                                                            r24 = "`(\245"
                                                            r50 = r29(r24, r32)
                                                            r37 = r51[r50]
                                                            r27 = r23 .. r37
                                                            r47 = r15 .. r27
                                                            r44 = r3 .. r47
                                                            r4 = r66 .. r44
                                                            r61 = r36 .. r4
                                                            r5 = r56 .. r61
                                                            r61 = upvalueValues[upvalues[2]]
                                                            r36 = upvalueValues[upvalues[3]]
                                                            r66 = "-\008\248\228\1619"
                                                            r44 = 2357820539977
                                                            r4 = r36(r66, r44)
                                                            r56 = r61[r4]
                                                            r61 = false
                                                            r64 = {
                                                                [r58] = r48,
                                                                [r16] = r5,
                                                                [r56] = r61
                                                            }
                                                            r16 = upvalueValues[upvalues[2]]
                                                            r5 = upvalueValues[upvalues[3]]
                                                            r36 = 18609648280025
                                                            r61 = "\017\171h\189"
                                                            r56 = r5(r61, r36)
                                                            r48 = r16[r56]
                                                            r5 = upvalueValues[upvalues[2]]
                                                            r56 = upvalueValues[upvalues[3]]
                                                            r4 = 34463232442032
                                                            r36 = "-m\"#'+D\185\0239q\191\255F\"u\190\193\025i3M\140"
                                                            r61 = r56(r36, r4)
                                                            r16 = r5[r61]
                                                            r56 = upvalueValues[upvalues[2]]
                                                            r61 = upvalueValues[upvalues[3]]
                                                            r66 = 12825398990676
                                                            r4 = "\011\205\005\149\""
                                                            r36 = r61(r4, r66)
                                                            r5 = r56[r36]
                                                            r36 = upvalueValues[upvalues[2]]
                                                            r4 = upvalueValues[upvalues[3]]
                                                            r44 = "\248!4\224\148Wt\244\006\004\022\200}\024T\004\189\225"
                                                            r47 = 26053286358884
                                                            r66 = r4(r44, r47)
                                                            r61 = r36[r66]
                                                            r66 = upvalueValues[upvalues[1]]
                                                            r47 = upvalueValues[upvalues[2]]
                                                            r15 = upvalueValues[upvalues[3]]
                                                            r37 = "X\019T\242"
                                                            r51 = 5009448241436
                                                            r27 = r15(r37, r51)
                                                            r44 = r47[r27]
                                                            r4 = r66[r44]
                                                            r47 = upvalueValues[upvalues[2]]
                                                            r15 = upvalueValues[upvalues[3]]
                                                            r37 = " Yi\174\157\173=-I7\0247\128(\244zx\190\196\153"
                                                            r51 = 34483772047033
                                                            r27 = r15(r37, r51)
                                                            r44 = r47[r27]
                                                            r27 = upvalueValues[upvalues[1]]
                                                            r51 = upvalueValues[upvalues[2]]
                                                            r29 = upvalueValues[upvalues[3]]
                                                            r24 = "\n:Aa\157\144G\243\181>\129"
                                                            r32 = 28598564533253
                                                            r50 = r29(r24, r32)
                                                            r37 = r51[r50]
                                                            r15 = r27[r37]
                                                            r51 = upvalueValues[upvalues[2]]
                                                            r29 = upvalueValues[upvalues[3]]
                                                            r32 = 9994808283694
                                                            r24 = "\003BW\216.A,tZ\236\030&\255\244"
                                                            r50 = r29(r24, r32)
                                                            r37 = r51[r50]
                                                            r24 = upvalueValues[upvalues[2]]
                                                            r32 = upvalueValues[upvalues[3]]
                                                            r19 = "\177y\254\173\181a\143\152\027P\156\174\215/\224\217"
                                                            r30 = 25913967472419
                                                            r42 = r32(r19, r30)
                                                            r50 = r24[r42]
                                                            r19 = upvalueValues[upvalues[2]]
                                                            r30 = upvalueValues[upvalues[3]]
                                                            r53 = 15576319974485
                                                            r6 = "\ty\210"
                                                            r8 = r30(r6, r53)
                                                            r42 = r19[r8]
                                                            r6 = upvalueValues[upvalues[2]]
                                                            r53 = upvalueValues[upvalues[3]]
                                                            r40 = "^\192\014\237:H\195\199\219\234\249M\170g\203\209\172\016\143\017N\161\178\196\199\130\211Vu\131:\207Gz\196\026\192\251\012[\251\137\019\178uA\2542\196N9\186D\008?\244\016\195"
                                                            r45 = 14599113644686
                                                            r52 = r53(r40, r45)
                                                            r8 = r6[r52]
                                                            r52 = upvalueValues[upvalues[2]]
                                                            r40 = upvalueValues[upvalues[3]]
                                                            r10 = "\208S\246\166R8r\195.jS\222"
                                                            r34 = 9196268146874
                                                            r45 = r40(r10, r34)
                                                            r53 = r52[r45]
                                                            r6 = r41 .. r53
                                                            r30 = r8 .. r6
                                                            r19 = r11 .. r30
                                                            r32 = r42 .. r19
                                                            r24 = r18 .. r32
                                                            r29 = r50 .. r24
                                                            r51 = r41 .. r29
                                                            r27 = r37 .. r51
                                                            r47 = r15 .. r27
                                                            r66 = r44 .. r47
                                                            r36 = r4 .. r66
                                                            r56 = r61 .. r36
                                                            r36 = upvalueValues[upvalues[2]]
                                                            r4 = upvalueValues[upvalues[3]]
                                                            r44 = "l\206\224MR\157"
                                                            r47 = 9594505924979
                                                            r66 = r4(r44, r47)
                                                            r61 = r36[r66]
                                                            r36 = false
                                                            r58 = {
                                                                [r48] = r16,
                                                                [r5] = r56,
                                                                [r61] = r36
                                                            }
                                                            r5 = upvalueValues[upvalues[2]]
                                                            r56 = upvalueValues[upvalues[3]]
                                                            r4 = 33118105467965
                                                            r36 = "\130\201z\165"
                                                            r61 = r56(r36, r4)
                                                            r16 = r5[r61]
                                                            r56 = upvalueValues[upvalues[2]]
                                                            r61 = upvalueValues[upvalues[3]]
                                                            r66 = 23889062800244
                                                            r4 = "\027s\214sz*]W5\206\1573\175\216R8\187Bu\020\027\144\201\165\245\253\163\020"
                                                            r36 = r61(r4, r66)
                                                            r5 = r56[r36]
                                                            r61 = upvalueValues[upvalues[2]]
                                                            r36 = upvalueValues[upvalues[3]]
                                                            r44 = 8685902155724
                                                            r66 = "k\205\002\245H"
                                                            r4 = r36(r66, r44)
                                                            r56 = r61[r4]
                                                            r4 = upvalueValues[upvalues[2]]
                                                            r66 = upvalueValues[upvalues[3]]
                                                            r15 = 23976303258524
                                                            r47 = "\020(\162\228\183Z\183&\224S1J\198*\t0_\139C#\175^\194@"
                                                            r44 = r66(r47, r15)
                                                            r36 = r4[r44]
                                                            r44 = upvalueValues[upvalues[1]]
                                                            r15 = upvalueValues[upvalues[2]]
                                                            r27 = upvalueValues[upvalues[3]]
                                                            r29 = 12510702884545
                                                            r51 = "\152\222vQ\221d\214F\145\166"
                                                            r37 = r27(r51, r29)
                                                            r47 = r15[r37]
                                                            r66 = r44[r47]
                                                            r15 = upvalueValues[upvalues[2]]
                                                            r27 = upvalueValues[upvalues[3]]
                                                            r29 = 1013795013080
                                                            r51 = "\234\129\243\180\168\135\135\132\208\195\237\198\003S\rV\231@\211\221\237w\031\139\169D\241"
                                                            r37 = r27(r51, r29)
                                                            r47 = r15[r37]
                                                            r51 = upvalueValues[upvalues[2]]
                                                            r29 = upvalueValues[upvalues[3]]
                                                            r24 = "\215|\160}O\251z\134ga\234\166\235=\229\228>o\133<\180\135\022"
                                                            r32 = 9572479963497
                                                            r50 = r29(r24, r32)
                                                            r37 = r51[r50]
                                                            r24 = "os"
                                                            r50 = _env[r24]
                                                            r32 = upvalueValues[upvalues[2]]
                                                            r42 = upvalueValues[upvalues[3]]
                                                            r30 = "\162\031DC"
                                                            r8 = 33251060399227
                                                            r19 = r42(r30, r8)
                                                            r24 = r32[r19]
                                                            r29 = r50[r24]
                                                            r32 = upvalueValues[upvalues[2]]
                                                            r42 = upvalueValues[upvalues[3]]
                                                            r8 = 5237192100230
                                                            r30 = "E`s1-\211\005\214"
                                                            r19 = r42(r30, r8)
                                                            r24 = r32[r19]
                                                            r30 = "os"
                                                            r19 = _env[r30]
                                                            r8 = upvalueValues[upvalues[2]]
                                                            r6 = upvalueValues[upvalues[3]]
                                                            r52 = "\012\231\164\165"
                                                            r40 = 11335278367902
                                                            r53 = r6(r52, r40)
                                                            r30 = r8[r53]
                                                            r42 = r19[r30]
                                                            r19 = r42()
                                                            r8 = upvalueValues[upvalues[1]]
                                                            r53 = upvalueValues[upvalues[2]]
                                                            r52 = upvalueValues[upvalues[3]]
                                                            r10 = 26974341476624
                                                            r45 = "\198<N;\218\234\233\1385\236"
                                                            r40 = r52(r45, r10)
                                                            r6 = r53[r40]
                                                            r30 = r8[r6]
                                                            r8 = 86400
                                                            r42 = r30 * r8
                                                            r32 = r19 - r42
                                                            r50 = r29(r24, r32)
                                                            r24 = upvalueValues[upvalues[2]]
                                                            r32 = upvalueValues[upvalues[3]]
                                                            r19 = "\015\015\134"
                                                            r30 = 27254142480787
                                                            r42 = r32(r19, r30)
                                                            r29 = r24[r42]
                                                            r51 = r50 .. r29
                                                            r27 = r37 .. r51
                                                            r15 = r21 .. r27
                                                            r44 = r47 .. r15
                                                            r4 = r66 .. r44
                                                            r61 = r36 .. r4
                                                            r4 = upvalueValues[upvalues[2]]
                                                            r66 = upvalueValues[upvalues[3]]
                                                            r15 = 23646930529027
                                                            r47 = "\238K\230J\142\195"
                                                            r44 = r66(r47, r15)
                                                            r36 = r4[r44]
                                                            r4 = false
                                                            r48 = {
                                                                [r16] = r5,
                                                                [r56] = r61,
                                                                [r36] = r4
                                                            }
                                                            r56 = upvalueValues[upvalues[2]]
                                                            r61 = upvalueValues[upvalues[3]]
                                                            r66 = 32641243085663
                                                            r4 = "\166\207CW"
                                                            r36 = r61(r4, r66)
                                                            r5 = r56[r36]
                                                            r61 = upvalueValues[upvalues[2]]
                                                            r36 = upvalueValues[upvalues[3]]
                                                            r44 = 35015462092721
                                                            r66 = "Dv\172\128\163w\224n\1608!\155x+\014'.B\156\160\191"
                                                            r4 = r36(r66, r44)
                                                            r56 = r61[r4]
                                                            r36 = upvalueValues[upvalues[2]]
                                                            r4 = upvalueValues[upvalues[3]]
                                                            r47 = 2413390644323
                                                            r44 = "\222\230.\017\226"
                                                            r66 = r4(r44, r47)
                                                            r61 = r36[r66]
                                                            r66 = upvalueValues[upvalues[2]]
                                                            r44 = upvalueValues[upvalues[3]]
                                                            r27 = 11663114523959
                                                            r15 = "\178\144\237\168d\152\150\179\011\019\234\217\129\131\017\203\191\169\153\229\024\144"
                                                            r47 = r44(r15, r27)
                                                            r4 = r66[r47]
                                                            r15 = upvalueValues[upvalues[2]]
                                                            r27 = upvalueValues[upvalues[3]]
                                                            r29 = 2188910543867
                                                            r51 = "\192m\224\"\191\244\189\\\233^\tx\195\004\\"
                                                            r37 = r27(r51, r29)
                                                            r47 = r15[r37]
                                                            r51 = upvalueValues[upvalues[2]]
                                                            r29 = upvalueValues[upvalues[3]]
                                                            r24 = "\211\132\159(\012g\241\212\175h\195\026oZq\028\141J>F/;\243\142g\171i\251\211i,\202\211\006\127*\177\000*\205\028%H\141\195\232"
                                                            r32 = 21023038924349
                                                            r50 = r29(r24, r32)
                                                            r37 = r51[r50]
                                                            r24 = upvalueValues[upvalues[2]]
                                                            r32 = upvalueValues[upvalues[3]]
                                                            r30 = 10941974860775
                                                            r19 = "\132C\177[\028\217\234\147\184\178o\024{\203\159\218R(\205\029\137"
                                                            r42 = r32(r19, r30)
                                                            r50 = r24[r42]
                                                            r42 = upvalueValues[upvalues[2]]
                                                            r19 = upvalueValues[upvalues[3]]
                                                            r6 = 15014309534543
                                                            r8 = "\130\200\203"
                                                            r30 = r19(r8, r6)
                                                            r32 = r42[r30]
                                                            r24 = r25 .. r32
                                                            r29 = r50 .. r24
                                                            r51 = r7 .. r29
                                                            r27 = r37 .. r51
                                                            r15 = r7 .. r27
                                                            r44 = r47 .. r15
                                                            r66 = r43 .. r44
                                                            r36 = r4 .. r66
                                                            r66 = upvalueValues[upvalues[2]]
                                                            r44 = upvalueValues[upvalues[3]]
                                                            r15 = "'R\029\180~4"
                                                            r27 = 11891953178017
                                                            r47 = r44(r15, r27)
                                                            r4 = r66[r47]
                                                            r66 = false
                                                            r16 = {
                                                                [r5] = r56,
                                                                [r61] = r36,
                                                                [r4] = r66
                                                            }
                                                            r61 = upvalueValues[upvalues[2]]
                                                            r36 = upvalueValues[upvalues[3]]
                                                            r44 = 15951423102211
                                                            r66 = "\133\205\027\185"
                                                            r4 = r36(r66, r44)
                                                            r56 = r61[r4]
                                                            r36 = upvalueValues[upvalues[2]]
                                                            r4 = upvalueValues[upvalues[3]]
                                                            r47 = 14313709492745
                                                            r44 = "\031\2390\170s\222\156($\155\017\147\182\183\192\237\181\134q\n\162\007\148"
                                                            r66 = r4(r44, r47)
                                                            r61 = r36[r66]
                                                            r4 = upvalueValues[upvalues[2]]
                                                            r66 = upvalueValues[upvalues[3]]
                                                            r15 = 5306145606054
                                                            r47 = "\157\179\002\000\178"
                                                            r44 = r66(r47, r15)
                                                            r36 = r4[r44]
                                                            r44 = upvalueValues[upvalues[2]]
                                                            r47 = upvalueValues[upvalues[3]]
                                                            r37 = 25946231402290
                                                            r27 = "\131\140\1397\0207\159'w$\005\231*\210\027\249\215vXU\t\140\175I\143\215\023"
                                                            r15 = r47(r27, r37)
                                                            r66 = r44[r15]
                                                            r27 = upvalueValues[upvalues[2]]
                                                            r37 = upvalueValues[upvalues[3]]
                                                            r29 = "\251\154\""
                                                            r50 = 5043304859948
                                                            r51 = r37(r29, r50)
                                                            r15 = r27[r51]
                                                            r29 = upvalueValues[upvalues[2]]
                                                            r50 = upvalueValues[upvalues[3]]
                                                            r42 = 20882465580540
                                                            r32 = "\166H\2536\205\167p\208\148\148\237\177\024n\171\012\201\017'"
                                                            r24 = r50(r32, r42)
                                                            r51 = r29[r24]
                                                            r32 = "os"
                                                            r24 = _env[r32]
                                                            r42 = upvalueValues[upvalues[2]]
                                                            r19 = upvalueValues[upvalues[3]]
                                                            r8 = "\255\144\232\180"
                                                            r6 = 5360972941760
                                                            r30 = r19(r8, r6)
                                                            r32 = r42[r30]
                                                            r50 = r24[r32]
                                                            r42 = upvalueValues[upvalues[2]]
                                                            r19 = upvalueValues[upvalues[3]]
                                                            r6 = 14239573006822
                                                            r8 = "<\244\214!\027\016-\\"
                                                            r30 = r19(r8, r6)
                                                            r32 = r42[r30]
                                                            r24 = r50(r32)
                                                            r32 = upvalueValues[upvalues[2]]
                                                            r42 = upvalueValues[upvalues[3]]
                                                            r8 = 30476971505519
                                                            r30 = "k\174\245"
                                                            r19 = r42(r30, r8)
                                                            r50 = r32[r19]
                                                            r29 = r24 .. r50
                                                            r37 = r51 .. r29
                                                            r27 = r68 .. r37
                                                            r47 = r15 .. r27
                                                            r44 = r54 .. r47
                                                            r4 = r66 .. r44
                                                            r44 = upvalueValues[upvalues[2]]
                                                            r47 = upvalueValues[upvalues[3]]
                                                            r27 = "\210\201\223\228\202<"
                                                            r37 = 3294706320894
                                                            r15 = r47(r27, r37)
                                                            r66 = r44[r15]
                                                            r44 = true
                                                            r5 = {
                                                                [r56] = r61,
                                                                [r36] = r4,
                                                                [r66] = r44
                                                            }
                                                            r36 = upvalueValues[upvalues[2]]
                                                            r4 = upvalueValues[upvalues[3]]
                                                            r47 = 2944263701851
                                                            r44 = "\233dO\012"
                                                            r66 = r4(r44, r47)
                                                            r61 = r36[r66]
                                                            r4 = upvalueValues[upvalues[2]]
                                                            r66 = upvalueValues[upvalues[3]]
                                                            r47 = "m\193l\235\028\251\143+\193\244\192\021T\184<\0072\211:\180\011"
                                                            r15 = 3978501572412
                                                            r44 = r66(r47, r15)
                                                            r36 = r4[r44]
                                                            r66 = upvalueValues[upvalues[2]]
                                                            r44 = upvalueValues[upvalues[3]]
                                                            r27 = 27271009579419
                                                            r15 = ":*A\247\021"
                                                            r47 = r44(r15, r27)
                                                            r4 = r66[r47]
                                                            r47 = upvalueValues[upvalues[2]]
                                                            r15 = upvalueValues[upvalues[3]]
                                                            r37 = "3\2321W6@\n\029\219\019\157Ok\209"
                                                            r51 = 15454966586396
                                                            r27 = r15(r37, r51)
                                                            r44 = r47[r27]
                                                            r27 = upvalueValues[upvalues[2]]
                                                            r37 = upvalueValues[upvalues[3]]
                                                            r50 = 4992296585492
                                                            r29 = "z\017j\131\144\187"
                                                            r51 = r37(r29, r50)
                                                            r15 = r27[r51]
                                                            r47 = r65 .. r15
                                                            r66 = r44 .. r47
                                                            r47 = upvalueValues[upvalues[2]]
                                                            r15 = upvalueValues[upvalues[3]]
                                                            r51 = 1659117437700
                                                            r37 = "\003}\243\199\008\240"
                                                            r27 = r15(r37, r51)
                                                            r44 = r47[r27]
                                                            r47 = true
                                                            r56 = {
                                                                [r61] = r36,
                                                                [r4] = r66,
                                                                [r44] = r47
                                                            }
                                                            r4 = upvalueValues[upvalues[2]]
                                                            r66 = upvalueValues[upvalues[3]]
                                                            r15 = 13521654880408
                                                            r47 = "\248\146\237\240"
                                                            r44 = r66(r47, r15)
                                                            r36 = r4[r44]
                                                            r66 = upvalueValues[upvalues[2]]
                                                            r44 = upvalueValues[upvalues[3]]
                                                            r27 = 10229488685723
                                                            r15 = "\242y\234\222=\155R\173U\014~\178\230\238\021t\024\177\170\005y\015\227"
                                                            r47 = r44(r15, r27)
                                                            r4 = r66[r47]
                                                            r44 = upvalueValues[upvalues[2]]
                                                            r47 = upvalueValues[upvalues[3]]
                                                            r37 = 12994395805602
                                                            r27 = "\210\136\195Q\221"
                                                            r15 = r47(r27, r37)
                                                            r66 = r44[r15]
                                                            r15 = upvalueValues[upvalues[2]]
                                                            r27 = upvalueValues[upvalues[3]]
                                                            r29 = 5311624268201
                                                            r51 = "\139\\\227\170\247i\198\n\149\210\163;\007\172\251'\139\171\008\146"
                                                            r37 = r27(r51, r29)
                                                            r47 = r15[r37]
                                                            r51 = upvalueValues[upvalues[2]]
                                                            r29 = upvalueValues[upvalues[3]]
                                                            r24 = "\025"
                                                            r32 = 2299259061294
                                                            r50 = r29(r24, r32)
                                                            r37 = r51[r50]
                                                            r24 = upvalueValues[upvalues[2]]
                                                            r32 = upvalueValues[upvalues[3]]
                                                            r30 = 1456954229414
                                                            r19 = "2\002\239\002_\191\255yc/\203\208]\249[\169;q*\145"
                                                            r42 = r32(r19, r30)
                                                            r50 = r24[r42]
                                                            r19 = upvalueValues[upvalues[2]]
                                                            r30 = upvalueValues[upvalues[3]]
                                                            r53 = 2768495248649
                                                            r6 = "\022\170&\172\030\164I\031\144\172\199\132\024\249\201\201ue\165\1381"
                                                            r8 = r30(r6, r53)
                                                            r42 = r19[r8]
                                                            r8 = "identifyexecutor"
                                                            r30 = _env[r8]
                                                            r8 = r30()
                                                            r53 = upvalueValues[upvalues[2]]
                                                            r52 = upvalueValues[upvalues[3]]
                                                            r45 = "\216\018\164\251\002\236\012\023\205b\n\194\199f"
                                                            r10 = 2130349065184
                                                            r40 = r52(r45, r10)
                                                            r6 = r53[r40]
                                                            r40 = upvalueValues[upvalues[2]]
                                                            r45 = upvalueValues[upvalues[3]]
                                                            r34 = "#\227\244"
                                                            r63 = 3870344890122
                                                            r10 = r45(r34, r63)
                                                            r52 = r40[r10]
                                                            r53 = r20 .. r52
                                                            r30 = r6 .. r53
                                                            r19 = r8 .. r30
                                                            r32 = r42 .. r19
                                                            r24 = r38 .. r32
                                                            r29 = r50 .. r24
                                                            r51 = r26 .. r29
                                                            r27 = r37 .. r51
                                                            r15 = r60 .. r27
                                                            r44 = r47 .. r15
                                                            r15 = upvalueValues[upvalues[2]]
                                                            r27 = upvalueValues[upvalues[3]]
                                                            r29 = 14431609772608
                                                            r51 = "\184D\235\176\029K"
                                                            r37 = r27(r51, r29)
                                                            r47 = r15[r37]
                                                            r15 = true
                                                            r61 = {
                                                                [r36] = r4,
                                                                [r66] = r44,
                                                                [r47] = r15
                                                            }
                                                            r66 = upvalueValues[upvalues[2]]
                                                            r44 = upvalueValues[upvalues[3]]
                                                            r27 = 4319259609051
                                                            r15 = "kH\189\184"
                                                            r47 = r44(r15, r27)
                                                            r4 = r66[r47]
                                                            r44 = upvalueValues[upvalues[2]]
                                                            r47 = upvalueValues[upvalues[3]]
                                                            r27 = "T\216\246{\n\217\150z\001K\199\"o\166\030<\193\217\199xar\210Vs\194J"
                                                            r37 = 24893383814471
                                                            r15 = r47(r27, r37)
                                                            r66 = r44[r15]
                                                            r47 = upvalueValues[upvalues[2]]
                                                            r15 = upvalueValues[upvalues[3]]
                                                            r37 = "J\031\248\214 "
                                                            r51 = 25373584633383
                                                            r27 = r15(r37, r51)
                                                            r44 = r47[r27]
                                                            r27 = upvalueValues[upvalues[2]]
                                                            r37 = upvalueValues[upvalues[3]]
                                                            r50 = 19333569143594
                                                            r29 = "\224V[\214\011<\200\236\225W\175\025\249\192\193\167\191\215"
                                                            r51 = r37(r29, r50)
                                                            r15 = r27[r51]
                                                            r51 = "tostring"
                                                            r37 = _env[r51]
                                                            r51 = r37(r49)
                                                            r29 = upvalueValues[upvalues[2]]
                                                            r50 = upvalueValues[upvalues[3]]
                                                            r42 = 1600964903657
                                                            r32 = "\005\128n"
                                                            r24 = r50(r32, r42)
                                                            r37 = r29[r24]
                                                            r27 = r51 .. r37
                                                            r47 = r15 .. r27
                                                            r27 = upvalueValues[upvalues[2]]
                                                            r37 = upvalueValues[upvalues[3]]
                                                            r50 = 6140635630379
                                                            r29 = "\200~G\216\246n"
                                                            r51 = r37(r29, r50)
                                                            r15 = r27[r51]
                                                            r27 = true
                                                            r36 = {
                                                                [r4] = r66,
                                                                [r44] = r47,
                                                                [r15] = r27
                                                            }
                                                            r44 = upvalueValues[upvalues[2]]
                                                            r47 = upvalueValues[upvalues[3]]
                                                            r37 = 33647278636340
                                                            r27 = "\003\127\225\224"
                                                            r15 = r47(r27, r37)
                                                            r66 = r44[r15]
                                                            r47 = upvalueValues[upvalues[2]]
                                                            r15 = upvalueValues[upvalues[3]]
                                                            r51 = 6907110509712
                                                            r37 = "\184\137\226\212\163\253\189\221\018\227:b:/G\135\185\007\231E"
                                                            r27 = r15(r37, r51)
                                                            r44 = r47[r27]
                                                            r15 = upvalueValues[upvalues[2]]
                                                            r27 = upvalueValues[upvalues[3]]
                                                            r29 = 32086867032669
                                                            r51 = "\144\187\153W\190"
                                                            r37 = r27(r51, r29)
                                                            r47 = r15[r37]
                                                            r37 = upvalueValues[upvalues[2]]
                                                            r51 = upvalueValues[upvalues[3]]
                                                            r50 = "\175\135\151\152\226\251\134"
                                                            r24 = 3506211391072
                                                            r29 = r51(r50, r24)
                                                            r27 = r37[r29]
                                                            r29 = upvalueValues[upvalues[2]]
                                                            r50 = upvalueValues[upvalues[3]]
                                                            r32 = "\2033\001"
                                                            r42 = 27789576106636
                                                            r24 = r50(r32, r42)
                                                            r51 = r29[r24]
                                                            r37 = r28 .. r51
                                                            r15 = r27 .. r37
                                                            r37 = upvalueValues[upvalues[2]]
                                                            r51 = upvalueValues[upvalues[3]]
                                                            r50 = "\156\030a\158\164\132"
                                                            r24 = 2263467885598
                                                            r29 = r51(r50, r24)
                                                            r27 = r37[r29]
                                                            r37 = false
                                                            r4 = {
                                                                [r66] = r44,
                                                                [r47] = r15,
                                                                [r27] = r37
                                                            }
                                                            r13 = {
                                                                r64,
                                                                r58,
                                                                r48,
                                                                r16,
                                                                r5,
                                                                r56,
                                                                r61,
                                                                r36,
                                                                r4
                                                            }
                                                            r58 = upvalueValues[upvalues[2]]
                                                            r48 = upvalueValues[upvalues[3]]
                                                            r56 = 17745784397895
                                                            r5 = "\153\"\\\152~\189\199\144\234"
                                                            r16 = r48(r5, r56)
                                                            r64 = r58[r16]
                                                            r16 = upvalueValues[upvalues[2]]
                                                            r5 = upvalueValues[upvalues[3]]
                                                            r36 = 23082175506940
                                                            r61 = "\216\195="
                                                            r56 = r5(r61, r36)
                                                            r48 = r16[r56]
                                                            r5 = upvalueValues[upvalues[2]]
                                                            r56 = upvalueValues[upvalues[3]]
                                                            r4 = 5558174206492
                                                            r36 = "\130<?\195t\241\165\175|Gm\218\2500\211\"@?\132l\204sl\246{q\006\238\002\202\134\151\255\222I\2457x\"\207\235\187\136r\165#kG\001e4S\146\245\145\211\159;a9_\011\187fM1\247\251\253\215I\143\028\213F\229\"\181\1370\019\222\145\178\209\130-\147\253\128Y,\195\204\020\159\152\169D"
                                                            r61 = r56(r36, r4)
                                                            r16 = r5[r61]
                                                            r58 = {
                                                                [r48] = r16
                                                            }
                                                            r16 = upvalueValues[upvalues[2]]
                                                            r5 = upvalueValues[upvalues[3]]
                                                            r61 = "7\128$\208=@"
                                                            r36 = 20690048116130
                                                            r56 = r5(r61, r36)
                                                            r48 = r16[r56]
                                                            r56 = upvalueValues[upvalues[2]]
                                                            r61 = upvalueValues[upvalues[3]]
                                                            r66 = 27060677079353
                                                            r4 = "7\228\145_"
                                                            r36 = r61(r4, r66)
                                                            r5 = r56[r36]
                                                            r36 = upvalueValues[upvalues[2]]
                                                            r4 = upvalueValues[upvalues[3]]
                                                            r47 = 32829183785911
                                                            r44 = "\147\175\142\244\173\024\150\215=\130\207k\163\144p2"
                                                            r66 = r4(r44, r47)
                                                            r61 = r36[r66]
                                                            r66 = "os"
                                                            r4 = _env[r66]
                                                            r44 = upvalueValues[upvalues[2]]
                                                            r47 = upvalueValues[upvalues[3]]
                                                            r27 = "\175\194\150\006"
                                                            r37 = 960642597311
                                                            r15 = r47(r27, r37)
                                                            r66 = r44[r15]
                                                            r36 = r4[r66]
                                                            r44 = upvalueValues[upvalues[2]]
                                                            r47 = upvalueValues[upvalues[3]]
                                                            r37 = 32052973664845
                                                            r27 = "ka\007\179v\179\21176\017\228\130N\187\255dM"
                                                            r15 = r47(r27, r37)
                                                            r66 = r44[r15]
                                                            r4 = r36(r66)
                                                            r56 = r61 .. r4
                                                            r36 = upvalueValues[upvalues[2]]
                                                            r4 = upvalueValues[upvalues[3]]
                                                            r47 = 34488301223611
                                                            r44 = "\218n\148\027\1568\234\182"
                                                            r66 = r4(r44, r47)
                                                            r61 = r36[r66]
                                                            r4 = upvalueValues[upvalues[2]]
                                                            r66 = upvalueValues[upvalues[3]]
                                                            r15 = 14482297494103
                                                            r47 = "\134B+\016\007&\210\241\169\185\151!\211\128\136\182\169\247\236h\017\237\140n\000\144\002^\188\t\130<d\217\024\233\187\154dV\003\162\191yi_\178\1400\1596\184% \174V\159U\218[\249\2239,I\153Y\222\214\161\146\176\226\031*q\005\191*\189\147\199D\217uOU\209\132\213\247!\246\128\001\179\026?/"
                                                            r44 = r66(r47, r15)
                                                            r36 = r4[r44]
                                                            r16 = {
                                                                [r5] = r56,
                                                                [r61] = r36
                                                            }
                                                            r33 = {
                                                                [r12] = r1,
                                                                [r59] = r46,
                                                                [r17] = r57,
                                                                [r67] = r62,
                                                                [r39] = r13,
                                                                [r64] = r58,
                                                                [r48] = r16
                                                            }
                                                            r14 = {
                                                                r33
                                                            }
                                                            state = {
                                                                [ReturnVal] = r35,
                                                                [r55] = r14
                                                            }
                                                            r35 = state
                                                            r55 = "getgenv"
                                                            ReturnVal = _env[r55]
                                                            r55 = ReturnVal()
                                                            r14 = upvalueValues[upvalues[2]]
                                                            r33 = upvalueValues[upvalues[3]]
                                                            r59 = 7098090245353
                                                            r1 = "%>\169\223\170\173\197%\177\169&\244\249"
                                                            r12 = r33(r1, r59)
                                                            ReturnVal = r14[r12]
                                                            state = r55[ReturnVal]
                                                            state = state and (96) or (97)
                                                        end
                                                    else
                                                        if state == 95 then
                                                            r31 = upvalueValues[upvalues[2]]
                                                            r21 = upvalueValues[upvalues[3]]
                                                            r55 = "\004\021\023"
                                                            r14 = 5730587904620
                                                            r35 = r21(r55, r14)
                                                            r65 = r31[r35]
                                                            ReturnVal = r65
                                                            state = 94
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 97 then
                                                    if state <= 96 then
                                                        if state == 96 then
                                                            ReturnVal = "game"
                                                            state = _env[ReturnVal]
                                                            r14 = upvalueValues[upvalues[2]]
                                                            ReturnVal = "HttpGet"
                                                            ReturnVal = state[ReturnVal]
                                                            r33 = upvalueValues[upvalues[3]]
                                                            r59 = 12298324923998
                                                            r1 = ">c\n\182\181\130\018\019\166+\218\137 .\228\175\030\018n\186y"
                                                            r12 = r33(r1, r59)
                                                            r55 = r14[r12]
                                                            ReturnVal = ReturnVal(state, r55)
                                                            r55 = ReturnVal
                                                            ReturnVal = "game"
                                                            state = _env[ReturnVal]
                                                            r12 = upvalueValues[upvalues[2]]
                                                            r1 = upvalueValues[upvalues[3]]
                                                            r46 = "\015a\159J\030\235\204\\\188-\128\026f?\138\131\\\150"
                                                            r17 = 19793921762305
                                                            r59 = r1(r46, r17)
                                                            r33 = r12[r59]
                                                            r59 = upvalueValues[upvalues[2]]
                                                            r46 = upvalueValues[upvalues[3]]
                                                            r57 = "u\148\238\210\129"
                                                            r67 = 9397349323031
                                                            r17 = r46(r57, r67)
                                                            r1 = r59[r17]
                                                            r12 = r55 .. r1
                                                            ReturnVal = "HttpGet"
                                                            ReturnVal = state[ReturnVal]
                                                            r14 = r33 .. r12
                                                            ReturnVal = ReturnVal(state, r14)
                                                            r14 = ReturnVal
                                                            state = upvalueValues[upvalues[8]]
                                                            ReturnVal = "JSONDecode"
                                                            ReturnVal = state[ReturnVal]
                                                            ReturnVal = ReturnVal(state, r14)
                                                            r33 = ReturnVal
                                                            r12 = "table"
                                                            ReturnVal = _env[r12]
                                                            r1 = upvalueValues[upvalues[2]]
                                                            r59 = upvalueValues[upvalues[3]]
                                                            r17 = "C\179\234\214\241L"
                                                            r57 = 13755279169797
                                                            r46 = r59(r17, r57)
                                                            r12 = r1[r46]
                                                            state = ReturnVal[r12]
                                                            r17 = upvalueValues[upvalues[2]]
                                                            r57 = upvalueValues[upvalues[3]]
                                                            r62 = 22562417010954
                                                            r39 = "\246\145\026\150Q "
                                                            r67 = r57(r39, r62)
                                                            r46 = r17[r67]
                                                            r59 = r35[r46]
                                                            r46 = 1
                                                            r1 = r59[r46]
                                                            r46 = upvalueValues[upvalues[2]]
                                                            r17 = upvalueValues[upvalues[3]]
                                                            r67 = "\025\1896\026\t\212"
                                                            r39 = 11527698388216
                                                            r57 = r17(r67, r39)
                                                            r59 = r46[r57]
                                                            r12 = r1[r59]
                                                            r46 = upvalueValues[upvalues[2]]
                                                            r17 = upvalueValues[upvalues[3]]
                                                            r67 = "fD\248\210"
                                                            r39 = 17625624059919
                                                            r57 = r17(r67, r39)
                                                            r59 = r46[r57]
                                                            r17 = upvalueValues[upvalues[2]]
                                                            r57 = upvalueValues[upvalues[3]]
                                                            r62 = 1809654678346
                                                            r39 = "9A\195\2120\194\142i\182\165V\170\153$\221KI\151i"
                                                            r67 = r57(r39, r62)
                                                            r46 = r17[r67]
                                                            r57 = upvalueValues[upvalues[2]]
                                                            r67 = upvalueValues[upvalues[3]]
                                                            r13 = 15846957997267
                                                            r62 = "\127!)\225\186"
                                                            r39 = r67(r62, r13)
                                                            r17 = r57[r39]
                                                            r39 = upvalueValues[upvalues[2]]
                                                            r62 = upvalueValues[upvalues[3]]
                                                            r64 = "#,\024\025\151\149}\002\162\n\233r=*\230\231\\\161|\129\129"
                                                            r58 = 7334635769175
                                                            r13 = r62(r64, r58)
                                                            r67 = r39[r13]
                                                            r64 = upvalueValues[upvalues[2]]
                                                            r58 = upvalueValues[upvalues[3]]
                                                            r16 = "\161\227"
                                                            r5 = 27183239311730
                                                            r48 = r58(r16, r5)
                                                            r13 = r64[r48]
                                                            r62 = r33[r13]
                                                            r58 = upvalueValues[upvalues[2]]
                                                            r48 = upvalueValues[upvalues[3]]
                                                            r56 = 35180527140862
                                                            r5 = "e\193}\151\\\218]_\177\217\207\2320^2Z\0005Y8\207"
                                                            r16 = r48(r5, r56)
                                                            r64 = r58[r16]
                                                            r5 = upvalueValues[upvalues[2]]
                                                            r56 = upvalueValues[upvalues[3]]
                                                            r4 = 8935600672832
                                                            r36 = "\233\187\026m\128\204\190"
                                                            r61 = r56(r36, r4)
                                                            r16 = r5[r61]
                                                            r48 = r33[r16]
                                                            r56 = upvalueValues[upvalues[2]]
                                                            r61 = upvalueValues[upvalues[3]]
                                                            r66 = 33323874942109
                                                            r4 = "\163\167\003\150P\173\139\235\142\023\187a\000\218\247\175\199\022\031\006\157R\199\188\008\164"
                                                            r36 = r61(r4, r66)
                                                            r5 = r56[r36]
                                                            r4 = upvalueValues[upvalues[2]]
                                                            r66 = upvalueValues[upvalues[3]]
                                                            r15 = 33643433688370
                                                            r47 = "\216v!"
                                                            r44 = r66(r47, r15)
                                                            r36 = r4[r44]
                                                            r61 = r33[r36]
                                                            r66 = upvalueValues[upvalues[2]]
                                                            r44 = upvalueValues[upvalues[3]]
                                                            r27 = 15842711198929
                                                            r15 = "\194\\O\138zjf\206\189qM\183\213\160mu\201\212>;,"
                                                            r47 = r44(r15, r27)
                                                            r4 = r66[r47]
                                                            r15 = upvalueValues[upvalues[2]]
                                                            r27 = upvalueValues[upvalues[3]]
                                                            r51 = "\195\234\146\209"
                                                            r29 = 30226369885947
                                                            r37 = r27(r51, r29)
                                                            r47 = r15[r37]
                                                            r44 = r33[r47]
                                                            r6 = 19711057388506
                                                            r8 = "\143\182\246"
                                                            r19 = 32489837771545
                                                            r27 = upvalueValues[upvalues[2]]
                                                            r37 = upvalueValues[upvalues[3]]
                                                            r50 = 1965272974227
                                                            r29 = "j2\1656j\187'\215_r\177i\236\214\150c-\238h?"
                                                            r51 = r37(r29, r50)
                                                            r15 = r27[r51]
                                                            r29 = upvalueValues[upvalues[2]]
                                                            r50 = upvalueValues[upvalues[3]]
                                                            r42 = 8447915200349
                                                            r32 = "\240\135EF\002\202"
                                                            r24 = r50(r32, r42)
                                                            r55 = nil
                                                            r51 = r29[r24]
                                                            r37 = r33[r51]
                                                            r42 = "\014t\221\132\001\242\203lO\205@\219\2428\228\132\186o\242a"
                                                            r50 = upvalueValues[upvalues[2]]
                                                            r14 = nil
                                                            r24 = upvalueValues[upvalues[3]]
                                                            r32 = r24(r42, r19)
                                                            r29 = r50[r32]
                                                            r42 = upvalueValues[upvalues[2]]
                                                            r19 = upvalueValues[upvalues[3]]
                                                            r30 = r19(r8, r6)
                                                            r32 = r42[r30]
                                                            r24 = r33[r32]
                                                            r42 = upvalueValues[upvalues[2]]
                                                            r19 = upvalueValues[upvalues[3]]
                                                            r8 = "\212\142"
                                                            r6 = 31530090707290
                                                            r30 = r19(r8, r6)
                                                            r32 = r42[r30]
                                                            r50 = r24 .. r32
                                                            r51 = r29 .. r50
                                                            r27 = r37 .. r51
                                                            r47 = r15 .. r27
                                                            r66 = r44 .. r47
                                                            r36 = r4 .. r66
                                                            r56 = r61 .. r36
                                                            r16 = r5 .. r56
                                                            r58 = r48 .. r16
                                                            r13 = r64 .. r58
                                                            r39 = r62 .. r13
                                                            r33 = nil
                                                            r57 = r67 .. r39
                                                            r1 = {
                                                                [r59] = r46,
                                                                [r17] = r57
                                                            }
                                                            ReturnVal = state(r12, r1)
                                                            state = 97
                                                        end
                                                    else
                                                        if state == 97 then
                                                            state = upvalueValues[upvalues[8]]
                                                            r55 = allocUpvalue()
                                                            ReturnVal = "JSONEncode"
                                                            ReturnVal = state[ReturnVal]
                                                            ReturnVal = ReturnVal(state, r35)
                                                            upvalueValues[r55] = ReturnVal
                                                            r14 = upvalueValues[upvalues[2]]
                                                            r33 = upvalueValues[upvalues[3]]
                                                            r59 = 2863639872821
                                                            r1 = "K(\200\229ma)N$\179\186\195"
                                                            r12 = r33(r1, r59)
                                                            ReturnVal = r14[r12]
                                                            r33 = upvalueValues[upvalues[2]]
                                                            r12 = upvalueValues[upvalues[3]]
                                                            r46 = 5216733399421
                                                            r59 = "Fj\"\146y\238\248\248\207\214p\152\008\025\138\234"
                                                            r1 = r12(r59, r46)
                                                            r14 = r33[r1]
                                                            state = {
                                                                [ReturnVal] = r14
                                                            }
                                                            r14 = allocUpvalue()
                                                            upvalueValues[r14] = state
                                                            r12 = "http_request"
                                                            r33 = _env[r12]
                                                            state = r33 and (98) or (99)
                                                            ReturnVal = r33
                                                        end
                                                    end
                                                else
                                                    if state == 98 then
                                                        r33 = allocUpvalue()
                                                        upvalueValues[r33] = ReturnVal
                                                        ReturnVal = upvalueValues[r33]
                                                        state = not ReturnVal
                                                        state = state and (100) or (101)
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    if state <= 112 then
                                        if state <= 105 then
                                            if state <= 102 then
                                                if state <= 100 then
                                                    if state <= 99 then
                                                        if state == 99 then
                                                            r12 = state
                                                            r59 = "request"
                                                            r1 = _env[r59]
                                                            state = r1 and (102) or (103)
                                                            r33 = r1
                                                        end
                                                    else
                                                        if state == 100 then
                                                            ReturnVal = "warn"
                                                            state = _env[ReturnVal]
                                                            r1 = upvalueValues[upvalues[2]]
                                                            r59 = upvalueValues[upvalues[3]]
                                                            r17 = ">:\154Ha\2422\209\182Q\252\132\161\129\187D\205]\019\224_~\232mY"
                                                            r57 = 20274997257441
                                                            r46 = r59(r17, r57)
                                                            r12 = r1[r46]
                                                            ReturnVal = state(r12)
                                                            r12 = upvalueValues[upvalues[2]]
                                                            r1 = upvalueValues[upvalues[3]]
                                                            r17 = 34996752777128
                                                            r46 = "\219I5\012\1641\134\156]\148\184\228\252\218\245S\131\2152\147\237+\218\254l\214(B\007h"
                                                            r59 = r1(r46, r17)
                                                            ReturnVal = r12[r59]
                                                            state = false
                                                            ReturnVal = {
                                                                state,
                                                                ReturnVal
                                                            }
                                                            state = nil
                                                        end
                                                    end
                                                else
                                                    if state <= 101 then
                                                        if state == 101 then
                                                            r1 = createClosure3(149, {
                                                                r33,
                                                                upvalues[2],
                                                                upvalues[3],
                                                                r22,
                                                                r55,
                                                                r14
                                                            })
                                                            ReturnVal = "pcall"
                                                            state = _env[ReturnVal]
                                                            r59 = {
                                                                state(r1)
                                                            }
                                                            ReturnVal = r59[1]
                                                            r12 = r59[2]
                                                            r1 = ReturnVal
                                                            r59 = not r1
                                                            state = r59 and (104) or (105)
                                                            ReturnVal = r59
                                                        end
                                                    else
                                                        if state == 102 then
                                                            state = r12
                                                            ReturnVal = r33
                                                            state = 98
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 104 then
                                                    if state <= 103 then
                                                        if state == 103 then
                                                            r59 = state
                                                            r17 = state
                                                            r67 = "syn"
                                                            r57 = _env[r67]
                                                            state = r57 and (106) or (107)
                                                            r46 = r57
                                                        end
                                                    else
                                                        if state == 104 then
                                                            state = ReturnVal and (108) or (109)
                                                        end
                                                    end
                                                else
                                                    if state == 105 then
                                                        r46 = state
                                                        state = r12 and (110) or (111)
                                                        r59 = r12
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 109 then
                                                if state <= 107 then
                                                    if state <= 106 then
                                                        if state == 106 then
                                                            r39 = "syn"
                                                            r67 = _env[r39]
                                                            r62 = upvalueValues[upvalues[2]]
                                                            r13 = upvalueValues[upvalues[3]]
                                                            r48 = 23406395697811
                                                            r58 = "<\185Z\132p\tJ"
                                                            r64 = r13(r58, r48)
                                                            r39 = r62[r64]
                                                            r57 = r67[r39]
                                                            r46 = r57
                                                            state = 107
                                                        end
                                                    else
                                                        if state == 107 then
                                                            state = r17
                                                            state = r46 and (112) or (113)
                                                            r1 = r46
                                                        end
                                                    end
                                                else
                                                    if state <= 108 then
                                                        if state == 108 then
                                                            ReturnVal = "warn"
                                                            state = _env[ReturnVal]
                                                            r17 = upvalueValues[upvalues[2]]
                                                            r57 = upvalueValues[upvalues[3]]
                                                            r39 = "\005\004\001FC\234C\158\012%\183\175>\205\004+"
                                                            r62 = 27831640158880
                                                            r67 = r57(r39, r62)
                                                            r46 = r17[r67]
                                                            r57 = state
                                                            r39 = state
                                                            state = r12 and (114) or (115)
                                                            r67 = r12
                                                        end
                                                    else
                                                        if state == 109 then
                                                            ReturnVal = "warn"
                                                            state = _env[ReturnVal]
                                                            r46 = upvalueValues[upvalues[2]]
                                                            r17 = upvalueValues[upvalues[3]]
                                                            r67 = "\030\165P\145\200\172[\1855=\173\171"
                                                            r39 = 28960721122477
                                                            r57 = r17(r67, r39)
                                                            r59 = r46[r57]
                                                            ReturnVal = state(r59)
                                                            state = true
                                                            ReturnVal = {
                                                                state
                                                            }
                                                            state = nil
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 111 then
                                                    if state <= 110 then
                                                        if state == 110 then
                                                            r39 = upvalueValues[upvalues[2]]
                                                            r62 = upvalueValues[upvalues[3]]
                                                            r64 = "d{\189\205J\017{\165\156r"
                                                            r58 = 25865984765708
                                                            r13 = r62(r64, r58)
                                                            r67 = r39[r13]
                                                            r57 = r12[r67]
                                                            r67 = 204
                                                            r17 = r57 ~= r67
                                                            r59 = r17
                                                            state = 111
                                                        end
                                                    else
                                                        if state == 111 then
                                                            state = r46
                                                            ReturnVal = r59
                                                            state = 104
                                                        end
                                                    end
                                                else
                                                    if state == 112 then
                                                        state = r59
                                                        r33 = r1
                                                        state = 102
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 119 then
                                            if state <= 116 then
                                                if state <= 114 then
                                                    if state <= 113 then
                                                        if state == 113 then
                                                            r67 = state
                                                            r17 = state
                                                            r62 = "fluxus"
                                                            r39 = _env[r62]
                                                            state = r39 and (116) or (117)
                                                            r57 = r39
                                                        end
                                                    else
                                                        if state == 114 then
                                                            r13 = state
                                                            r48 = upvalueValues[upvalues[2]]
                                                            r16 = upvalueValues[upvalues[3]]
                                                            r56 = "<\187\019\235\219\172'K\r>\131\212\180"
                                                            r61 = 13113763125210
                                                            r5 = r16(r56, r61)
                                                            r58 = r48[r5]
                                                            r64 = r12[r58]
                                                            state = r64 and (118) or (119)
                                                            r62 = r64
                                                        end
                                                    end
                                                else
                                                    if state <= 115 then
                                                        if state == 115 then
                                                            state = r39
                                                            state = r67 and (120) or (121)
                                                            r17 = r67
                                                        end
                                                    else
                                                        if state == 116 then
                                                            r13 = "fluxus"
                                                            r62 = _env[r13]
                                                            r64 = upvalueValues[upvalues[2]]
                                                            r58 = upvalueValues[upvalues[3]]
                                                            r5 = 508451553516
                                                            r16 = "\151\021>\188\028N`"
                                                            r48 = r58(r16, r5)
                                                            r13 = r64[r48]
                                                            r39 = r62[r13]
                                                            r57 = r39
                                                            state = 117
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 118 then
                                                    if state <= 117 then
                                                        if state == 117 then
                                                            state = r67
                                                            state = r57 and (122) or (123)
                                                            r46 = r57
                                                        end
                                                    else
                                                        if state == 118 then
                                                            state = r13
                                                            r67 = r62
                                                            state = 115
                                                        end
                                                    end
                                                else
                                                    if state == 119 then
                                                        r58 = "tostring"
                                                        r64 = _env[r58]
                                                        r58 = r64(r12)
                                                        r62 = r58
                                                        state = 118
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 122 then
                                                if state <= 121 then
                                                    if state <= 120 then
                                                        if state == 120 then
                                                            state = r57
                                                            r59 = r46 .. r17
                                                            ReturnVal = state(r59)
                                                            r59 = upvalueValues[upvalues[2]]
                                                            r46 = upvalueValues[upvalues[3]]
                                                            r57 = "\171P\148\193\189\208\219\028j\203\239\011\192"
                                                            r67 = 29641294837226
                                                            r17 = r46(r57, r67)
                                                            ReturnVal = r59[r17]
                                                            state = false
                                                            ReturnVal = {
                                                                state,
                                                                ReturnVal
                                                            }
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 121 then
                                                            r39 = upvalueValues[upvalues[2]]
                                                            r62 = upvalueValues[upvalues[3]]
                                                            r64 = "\254\t\227\215\161x\161@\136+\006\031L"
                                                            r58 = 8307236720412
                                                            r13 = r62(r64, r58)
                                                            r67 = r39[r13]
                                                            r17 = r67
                                                            state = 120
                                                        end
                                                    end
                                                else
                                                    if state == 122 then
                                                        state = r17
                                                        r1 = r46
                                                        state = 112
                                                    end
                                                end
                                            else
                                                if state <= 124 then
                                                    if state <= 123 then
                                                        if state == 123 then
                                                            r62 = "http"
                                                            r39 = _env[r62]
                                                            r67 = state
                                                            state = r39 and (124) or (125)
                                                            r57 = r39
                                                        end
                                                    else
                                                        if state == 124 then
                                                            r13 = "http"
                                                            r62 = _env[r13]
                                                            r64 = upvalueValues[upvalues[2]]
                                                            r58 = upvalueValues[upvalues[3]]
                                                            r16 = "\156l\217\220I\019\186"
                                                            r5 = 6177375996732
                                                            r48 = r58(r16, r5)
                                                            r13 = r64[r48]
                                                            r39 = r62[r13]
                                                            r57 = r39
                                                            state = 125
                                                        end
                                                    end
                                                else
                                                    if state == 125 then
                                                        state = r67
                                                        r46 = r57
                                                        state = 122
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 138 then
                                if state <= 126 then
                                    -- createClosure1 entry 5303909 -> 126, states 126-126
                                    if state == 126 then -- entry 5303909 -> 126
                                        r22 = "Instance"
                                        ReturnVal = _env[r22]
                                        r23 = upvalueValues[upvalues[1]]
                                        r2 = upvalueValues[upvalues[2]]
                                        r7 = "\1728\148"
                                        r9 = 10359167193815
                                        r41 = r2(r7, r9)
                                        r22 = r23[r41]
                                        r7 = "\151\227\235F\143\t\001\153\183"
                                        state = ReturnVal[r22]
                                        r23 = upvalueValues[upvalues[1]]
                                        r2 = upvalueValues[upvalues[2]]
                                        r9 = 19335463002923
                                        r41 = r2(r7, r9)
                                        r22 = r23[r41]
                                        ReturnVal = state(r22)
                                        r22 = allocUpvalue()
                                        upvalueValues[r22] = ReturnVal
                                        r7 = "\227\197g\243"
                                        state = upvalueValues[r22]
                                        r23 = upvalueValues[upvalues[1]]
                                        r2 = upvalueValues[upvalues[2]]
                                        r9 = 28846754509944
                                        r41 = r2(r7, r9)
                                        ReturnVal = r23[r41]
                                        r2 = upvalueValues[upvalues[1]]
                                        r28 = "\216]\146"
                                        r41 = upvalueValues[upvalues[2]]
                                        r43 = 25992087711559
                                        r9 = "\233\156\210\2094\153\2002\030\157-\207\213\178\236ly,\135"
                                        r7 = r41(r9, r43)
                                        r23 = r2[r7]
                                        state[ReturnVal] = r23
                                        state = upvalueValues[r22]
                                        r23 = upvalueValues[upvalues[1]]
                                        r7 = "\166w\215\171\160\004\007\242r\232\128\254"
                                        r2 = upvalueValues[upvalues[2]]
                                        r9 = 1173316239906
                                        r41 = r2(r7, r9)
                                        ReturnVal = r23[r41]
                                        r7 = "&8\225\169\217\151"
                                        r23 = false
                                        state[ReturnVal] = r23
                                        state = upvalueValues[r22]
                                        r23 = upvalueValues[upvalues[1]]
                                        r2 = upvalueValues[upvalues[2]]
                                        r9 = 10129242034796
                                        r41 = r2(r7, r9)
                                        ReturnVal = r23[r41]
                                        r23 = upvalueValues[upvalues[3]]
                                        state[ReturnVal] = r23
                                        r23 = "Instance"
                                        ReturnVal = _env[r23]
                                        r2 = upvalueValues[upvalues[1]]
                                        r41 = upvalueValues[upvalues[2]]
                                        r43 = 15826811739337
                                        r9 = "\253\216\001"
                                        r7 = r41(r9, r43)
                                        r23 = r2[r7]
                                        state = ReturnVal[r23]
                                        r2 = upvalueValues[upvalues[1]]
                                        r41 = upvalueValues[upvalues[2]]
                                        r9 = "\018:>\208\021"
                                        r43 = 23390970522252
                                        r7 = r41(r9, r43)
                                        r23 = r2[r7]
                                        ReturnVal = state(r23)
                                        r23 = allocUpvalue()
                                        upvalueValues[r23] = ReturnVal
                                        state = upvalueValues[r23]
                                        r60 = "\014\230s"
                                        r2 = upvalueValues[upvalues[1]]
                                        r41 = upvalueValues[upvalues[2]]
                                        r9 = "\172\020l\253\"K\0260\231J\251"
                                        r43 = 28093670863642
                                        r7 = r41(r9, r43)
                                        ReturnVal = r2[r7]
                                        r7 = "Vector2"
                                        r41 = _env[r7]
                                        r9 = upvalueValues[upvalues[1]]
                                        r43 = upvalueValues[upvalues[2]]
                                        r3 = 29869374060117
                                        r20 = r43(r28, r3)
                                        r7 = r9[r20]
                                        r2 = r41[r7]
                                        r7 = 0.5
                                        r9 = 0.5
                                        r41 = r2(r7, r9)
                                        state[ReturnVal] = r41
                                        state = upvalueValues[r23]
                                        r2 = upvalueValues[upvalues[1]]
                                        r41 = upvalueValues[upvalues[2]]
                                        r43 = 9816520266203
                                        r9 = "p5\231\017:\228 \025"
                                        r7 = r41(r9, r43)
                                        ReturnVal = r2[r7]
                                        r28 = "?\182/"
                                        r7 = "UDim2"
                                        r41 = _env[r7]
                                        r9 = upvalueValues[upvalues[1]]
                                        r43 = upvalueValues[upvalues[2]]
                                        r3 = 26055024275300
                                        r20 = r43(r28, r3)
                                        r7 = r9[r20]
                                        r2 = r41[r7]
                                        r20 = 0
                                        r7 = 0.5
                                        r43 = 0.5
                                        r9 = 0
                                        r41 = r2(r7, r9, r43, r20)
                                        state[ReturnVal] = r41
                                        state = upvalueValues[r23]
                                        r2 = upvalueValues[upvalues[1]]
                                        r41 = upvalueValues[upvalues[2]]
                                        r43 = 9878158807543
                                        r9 = "\239eD\172"
                                        r7 = r41(r9, r43)
                                        ReturnVal = r2[r7]
                                        r28 = "pl\219"
                                        r7 = "UDim2"
                                        r41 = _env[r7]
                                        r9 = upvalueValues[upvalues[1]]
                                        r43 = upvalueValues[upvalues[2]]
                                        r3 = 9542233608539
                                        r20 = r43(r28, r3)
                                        r7 = r9[r20]
                                        r2 = r41[r7]
                                        r28 = "\133k\200\240\002\012("
                                        r7 = 0.45
                                        r20 = 0
                                        r9 = 0
                                        r43 = 0.3
                                        r41 = r2(r7, r9, r43, r20)
                                        state[ReturnVal] = r41
                                        state = upvalueValues[r23]
                                        r2 = upvalueValues[upvalues[1]]
                                        r41 = upvalueValues[upvalues[2]]
                                        r43 = 14042748361099
                                        r9 = "D\192\205\250\030\231\1293\011\160\002\255\008x.\240"
                                        r7 = r41(r9, r43)
                                        ReturnVal = r2[r7]
                                        r7 = "Color3"
                                        r41 = _env[r7]
                                        r9 = upvalueValues[upvalues[1]]
                                        r43 = upvalueValues[upvalues[2]]
                                        r3 = 6028306303735
                                        r20 = r43(r28, r3)
                                        r7 = r9[r20]
                                        r2 = r41[r7]
                                        r7 = 20
                                        r43 = 40
                                        r9 = 20
                                        r41 = r2(r7, r9, r43)
                                        state[ReturnVal] = r41
                                        state = upvalueValues[r23]
                                        r2 = upvalueValues[upvalues[1]]
                                        r41 = upvalueValues[upvalues[2]]
                                        r9 = "@fv\130,\143\174\244J\143j\146\023\021\178\19798\202\254\132\153"
                                        r43 = 6508367858646
                                        r7 = r41(r9, r43)
                                        ReturnVal = r2[r7]
                                        r2 = 0.1
                                        state[ReturnVal] = r2
                                        r28 = "\235\n\143"
                                        state = upvalueValues[r23]
                                        r2 = upvalueValues[upvalues[1]]
                                        r41 = upvalueValues[upvalues[2]]
                                        r43 = 25492684910174
                                        r9 = "C\227\000\248\237\215\029=\233\136\028\016U\000\212"
                                        r7 = r41(r9, r43)
                                        ReturnVal = r2[r7]
                                        r2 = 0
                                        state[ReturnVal] = r2
                                        r20 = 26016928411475
                                        state = upvalueValues[r23]
                                        r2 = upvalueValues[upvalues[1]]
                                        r41 = upvalueValues[upvalues[2]]
                                        r43 = 33819036319108
                                        r9 = "\2081\135,\201S"
                                        r7 = r41(r9, r43)
                                        ReturnVal = r2[r7]
                                        r2 = upvalueValues[r22]
                                        state[ReturnVal] = r2
                                        r2 = "Instance"
                                        ReturnVal = _env[r2]
                                        r41 = upvalueValues[upvalues[1]]
                                        r7 = upvalueValues[upvalues[2]]
                                        r43 = "\134\146\211"
                                        r9 = r7(r43, r20)
                                        r2 = r41[r9]
                                        state = ReturnVal[r2]
                                        r20 = 8562556653459
                                        r41 = upvalueValues[upvalues[1]]
                                        r7 = upvalueValues[upvalues[2]]
                                        r43 = "\"\167\172\152\189\127\132\136"
                                        r9 = r7(r43, r20)
                                        r2 = r41[r9]
                                        ReturnVal = state(r2)
                                        r2 = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r41 = upvalueValues[upvalues[2]]
                                        r9 = "\222\140\175:H\161a\015\161\216\225="
                                        r43 = 3008832980345
                                        r7 = r41(r9, r43)
                                        state = ReturnVal[r7]
                                        r7 = "UDim"
                                        r41 = _env[r7]
                                        r9 = upvalueValues[upvalues[1]]
                                        r43 = upvalueValues[upvalues[2]]
                                        r3 = 8476477902699
                                        r20 = r43(r28, r3)
                                        r7 = r9[r20]
                                        ReturnVal = r41[r7]
                                        r7 = 0
                                        r9 = 14
                                        r41 = ReturnVal(r7, r9)
                                        r2[state] = r41
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r41 = upvalueValues[upvalues[2]]
                                        r43 = 9151918084261
                                        r9 = "]\241\186\154z8"
                                        r7 = r41(r9, r43)
                                        state = ReturnVal[r7]
                                        ReturnVal = upvalueValues[r23]
                                        r2[state] = ReturnVal
                                        state = upvalueValues[upvalues[4]]
                                        r41 = upvalueValues[r23]
                                        r43 = "TweenInfo"
                                        r9 = _env[r43]
                                        r20 = upvalueValues[upvalues[1]]
                                        r28 = upvalueValues[upvalues[2]]
                                        r26 = 11388746552503
                                        r3 = r28(r60, r26)
                                        r43 = r20[r3]
                                        r60 = "Enum"
                                        r7 = r9[r43]
                                        r3 = _env[r60]
                                        r26 = upvalueValues[upvalues[1]]
                                        r38 = upvalueValues[upvalues[2]]
                                        r18 = 5117918382415
                                        r68 = ";(\198X\145\168\020\162\016\\M"
                                        r54 = r38(r68, r18)
                                        r60 = r26[r54]
                                        r28 = r3[r60]
                                        r60 = upvalueValues[upvalues[1]]
                                        ReturnVal = "Create"
                                        ReturnVal = state[ReturnVal]
                                        r26 = upvalueValues[upvalues[2]]
                                        r54 = "\199\220\235+"
                                        r68 = 4377644173302
                                        r38 = r26(r54, r68)
                                        r3 = r60[r38]
                                        r20 = r28[r3]
                                        r26 = "Enum"
                                        r60 = _env[r26]
                                        r38 = upvalueValues[upvalues[1]]
                                        r54 = upvalueValues[upvalues[2]]
                                        r11 = 6693951523885
                                        r18 = "d*\188I\219\192\012\143gh\186E-\181^"
                                        r68 = r54(r18, r11)
                                        r26 = r38[r68]
                                        r3 = r60[r26]
                                        r26 = upvalueValues[upvalues[1]]
                                        r38 = upvalueValues[upvalues[2]]
                                        r18 = 24635047881935
                                        r68 = "?P\172\238\167"
                                        r54 = r38(r68, r18)
                                        r60 = r26[r54]
                                        r28 = r3[r60]
                                        r60 = true
                                        r3 = -1
                                        r43 = 2
                                        r9 = r7(r43, r20, r28, r3, r60)
                                        r20 = upvalueValues[upvalues[1]]
                                        r60 = "7\240\253-.\002v\167"
                                        r28 = upvalueValues[upvalues[2]]
                                        r26 = 19654745154496
                                        r3 = r28(r60, r26)
                                        r43 = r20[r3]
                                        r3 = upvalueValues[r23]
                                        r26 = upvalueValues[upvalues[1]]
                                        r38 = upvalueValues[upvalues[2]]
                                        r18 = 15335603346405
                                        r68 = "\164)X\007\028\"\193\190"
                                        r54 = r38(r68, r18)
                                        r60 = r26[r54]
                                        r28 = r3[r60]
                                        r26 = "UDim2"
                                        r60 = _env[r26]
                                        r38 = upvalueValues[upvalues[1]]
                                        r54 = upvalueValues[upvalues[2]]
                                        r11 = 34994215092135
                                        r18 = "(\228\163"
                                        r68 = r54(r18, r11)
                                        r26 = r38[r68]
                                        r3 = r60[r26]
                                        r68 = 0
                                        r26 = 0
                                        r54 = 0.05
                                        r38 = 0
                                        r60 = r3(r26, r38, r54, r68)
                                        r20 = r28 + r60
                                        r7 = {
                                            [r43] = r20
                                        }
                                        ReturnVal = ReturnVal(state, r41, r9, r7)
                                        r41 = allocUpvalue()
                                        upvalueValues[r41] = ReturnVal
                                        r7 = "Instance"
                                        state = upvalueValues[r41]
                                        ReturnVal = "Play"
                                        ReturnVal = state[ReturnVal]
                                        r28 = "\213|h"
                                        ReturnVal = ReturnVal(state)
                                        ReturnVal = _env[r7]
                                        r9 = upvalueValues[upvalues[1]]
                                        r43 = upvalueValues[upvalues[2]]
                                        r3 = 3805836052204
                                        r20 = r43(r28, r3)
                                        r28 = "\237\219N\210\163\188\163\131\180"
                                        r7 = r9[r20]
                                        state = ReturnVal[r7]
                                        r9 = upvalueValues[upvalues[1]]
                                        r43 = upvalueValues[upvalues[2]]
                                        r3 = 8997985751134
                                        r20 = r43(r28, r3)
                                        r7 = r9[r20]
                                        ReturnVal = state(r7)
                                        r28 = 25801930698478
                                        r20 = "\188.H\168"
                                        r7 = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r9 = upvalueValues[upvalues[2]]
                                        r43 = r9(r20, r28)
                                        state = ReturnVal[r43]
                                        r43 = "UDim2"
                                        r9 = _env[r43]
                                        r20 = upvalueValues[upvalues[1]]
                                        r28 = upvalueValues[upvalues[2]]
                                        r60 = "@\148\183"
                                        r26 = 4979152292110
                                        r3 = r28(r60, r26)
                                        r43 = r20[r3]
                                        r28 = 0.25
                                        ReturnVal = r9[r43]
                                        r20 = 0
                                        r3 = 0
                                        r43 = 1
                                        r9 = ReturnVal(r43, r20, r28, r3)
                                        r28 = 19127227785930
                                        r7[state] = r9
                                        r60 = "O\212\023"
                                        r20 = "\tnNM0\134\204m"
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r9 = upvalueValues[upvalues[2]]
                                        r43 = r9(r20, r28)
                                        state = ReturnVal[r43]
                                        r43 = "UDim2"
                                        r9 = _env[r43]
                                        r20 = upvalueValues[upvalues[1]]
                                        r28 = upvalueValues[upvalues[2]]
                                        r26 = 6444370348984
                                        r3 = r28(r60, r26)
                                        r43 = r20[r3]
                                        ReturnVal = r9[r43]
                                        r28 = 0
                                        r20 = 0
                                        r3 = 0
                                        r43 = 0
                                        r9 = ReturnVal(r43, r20, r28, r3)
                                        r7[state] = r9
                                        r28 = 28370122814362
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r9 = upvalueValues[upvalues[2]]
                                        r20 = "\249\218\188o\233*\203\150o\184{\014F\239NNA\197\138b\241\186"
                                        r43 = r9(r20, r28)
                                        state = ReturnVal[r43]
                                        ReturnVal = 1
                                        r7[state] = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r28 = 12036526544356
                                        r9 = upvalueValues[upvalues[2]]
                                        r20 = "D\006\180M"
                                        r43 = r9(r20, r28)
                                        r28 = "\208\008}9\133\163\143\175\247\007u\221\007=9\162y\165\228\r"
                                        state = ReturnVal[r43]
                                        r9 = upvalueValues[upvalues[1]]
                                        r43 = upvalueValues[upvalues[2]]
                                        r3 = 1129372303885
                                        r20 = r43(r28, r3)
                                        ReturnVal = r9[r20]
                                        r28 = 3002270991734
                                        r7[state] = ReturnVal
                                        r60 = "\168\238 \027\135U~"
                                        r20 = "\158\225\164!Zf\135\161\n\211"
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r9 = upvalueValues[upvalues[2]]
                                        r43 = r9(r20, r28)
                                        state = ReturnVal[r43]
                                        r43 = "Color3"
                                        r9 = _env[r43]
                                        r20 = upvalueValues[upvalues[1]]
                                        r28 = upvalueValues[upvalues[2]]
                                        r26 = 2907178714441
                                        r3 = r28(r60, r26)
                                        r43 = r20[r3]
                                        ReturnVal = r9[r43]
                                        r28 = 255
                                        r20 = 180
                                        r43 = 180
                                        r9 = ReturnVal(r43, r20, r28)
                                        r7[state] = r9
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r28 = 11007531127813
                                        r9 = upvalueValues[upvalues[2]]
                                        r20 = ",\148{\000\199\252\230{"
                                        r43 = r9(r20, r28)
                                        r20 = "t\002\139\030"
                                        state = ReturnVal[r43]
                                        r28 = 12544504600273
                                        ReturnVal = 32
                                        r7[state] = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r9 = upvalueValues[upvalues[2]]
                                        r43 = r9(r20, r28)
                                        state = ReturnVal[r43]
                                        r20 = "Enum"
                                        r43 = _env[r20]
                                        r28 = upvalueValues[upvalues[1]]
                                        r3 = upvalueValues[upvalues[2]]
                                        r38 = 16949927075540
                                        r26 = "\203\244\128#"
                                        r60 = r3(r26, r38)
                                        r20 = r28[r60]
                                        r60 = "\155\027\216r\"vt"
                                        r9 = r43[r20]
                                        r20 = upvalueValues[upvalues[1]]
                                        r28 = upvalueValues[upvalues[2]]
                                        r26 = 17035837431548
                                        r3 = r28(r60, r26)
                                        r43 = r20[r3]
                                        r20 = "nK\145\166:\148"
                                        ReturnVal = r9[r43]
                                        r28 = 19052872458920
                                        r7[state] = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r9 = upvalueValues[upvalues[2]]
                                        r43 = r9(r20, r28)
                                        state = ReturnVal[r43]
                                        ReturnVal = upvalueValues[r23]
                                        r7[state] = ReturnVal
                                        r9 = "Instance"
                                        ReturnVal = _env[r9]
                                        r43 = upvalueValues[upvalues[1]]
                                        r60 = 7258239880499
                                        r20 = upvalueValues[upvalues[2]]
                                        r3 = "\025\2235"
                                        r28 = r20(r3, r60)
                                        r9 = r43[r28]
                                        state = ReturnVal[r9]
                                        r60 = 15670501661825
                                        r43 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r3 = "\r\201\154>\216\170\186\199\199"
                                        r28 = r20(r3, r60)
                                        r60 = 9885428781563
                                        r9 = r43[r28]
                                        ReturnVal = state(r9)
                                        r9 = allocUpvalue()
                                        upvalueValues[r9] = ReturnVal
                                        state = upvalueValues[r9]
                                        r43 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r3 = "\205\206O\238"
                                        r28 = r20(r3, r60)
                                        ReturnVal = r43[r28]
                                        r28 = "UDim2"
                                        r20 = _env[r28]
                                        r3 = upvalueValues[upvalues[1]]
                                        r60 = upvalueValues[upvalues[2]]
                                        r54 = 15820796550343
                                        r38 = "T\141\215"
                                        r26 = r60(r38, r54)
                                        r60 = 0.2
                                        r28 = r3[r26]
                                        r43 = r20[r28]
                                        r28 = 1
                                        r26 = 0
                                        r3 = 0
                                        r20 = r43(r28, r3, r60, r26)
                                        state[ReturnVal] = r20
                                        r60 = 18679334642170
                                        state = upvalueValues[r9]
                                        r43 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r3 = "A\160p\217S\228\212Q"
                                        r28 = r20(r3, r60)
                                        ReturnVal = r43[r28]
                                        r28 = "UDim2"
                                        r20 = _env[r28]
                                        r3 = upvalueValues[upvalues[1]]
                                        r60 = upvalueValues[upvalues[2]]
                                        r38 = "\196T\133"
                                        r54 = 18361906684262
                                        r26 = r60(r38, r54)
                                        r28 = r3[r26]
                                        r60 = 0.3
                                        r43 = r20[r28]
                                        r28 = 0
                                        r3 = 0
                                        r26 = 0
                                        r20 = r43(r28, r3, r60, r26)
                                        state[ReturnVal] = r20
                                        state = upvalueValues[r9]
                                        r43 = upvalueValues[upvalues[1]]
                                        r60 = 24972714634604
                                        r20 = upvalueValues[upvalues[2]]
                                        r3 = "{\002\244o\165\241\128J\143\240\181h\198\023\196\016\219\221WI\183b"
                                        r28 = r20(r3, r60)
                                        ReturnVal = r43[r28]
                                        r60 = 30068081194673
                                        r43 = 1
                                        state[ReturnVal] = r43
                                        state = upvalueValues[r9]
                                        r43 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r3 = "_\182V\000\168)\228\231\130\141"
                                        r28 = r20(r3, r60)
                                        ReturnVal = r43[r28]
                                        r28 = "Color3"
                                        r20 = _env[r28]
                                        r3 = upvalueValues[upvalues[1]]
                                        r60 = upvalueValues[upvalues[2]]
                                        r54 = 23479825066677
                                        r38 = "\169\242\146\151F\133?"
                                        r26 = r60(r38, r54)
                                        r28 = r3[r26]
                                        r43 = r20[r28]
                                        r60 = 200
                                        r28 = 200
                                        r3 = 200
                                        r20 = r43(r28, r3, r60)
                                        state[ReturnVal] = r20
                                        state = upvalueValues[r9]
                                        r43 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r60 = 29350358807907
                                        r3 = "\198\129\128\156wif\203"
                                        r28 = r20(r3, r60)
                                        ReturnVal = r43[r28]
                                        r43 = 20
                                        state[ReturnVal] = r43
                                        state = upvalueValues[r9]
                                        r60 = 1577660613342
                                        r43 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r3 = "\174\155'd"
                                        r28 = r20(r3, r60)
                                        ReturnVal = r43[r28]
                                        r3 = "Enum"
                                        r28 = _env[r3]
                                        r60 = upvalueValues[upvalues[1]]
                                        r26 = upvalueValues[upvalues[2]]
                                        r54 = "\246b\154u"
                                        r68 = 12930500843397
                                        r38 = r26(r54, r68)
                                        r3 = r60[r38]
                                        r20 = r28[r3]
                                        r3 = upvalueValues[upvalues[1]]
                                        r60 = upvalueValues[upvalues[2]]
                                        r38 = "\166!\216Q\207\218\248\179"
                                        r54 = 13820731857187
                                        r26 = r60(r38, r54)
                                        r28 = r3[r26]
                                        r43 = r20[r28]
                                        r60 = 16913263959747
                                        state[ReturnVal] = r43
                                        state = upvalueValues[r9]
                                        r43 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r3 = "\195\205\238\179"
                                        r28 = r20(r3, r60)
                                        ReturnVal = r43[r28]
                                        r20 = upvalueValues[upvalues[1]]
                                        r28 = upvalueValues[upvalues[2]]
                                        r60 = "\252\183\187\25406X\206\252\156\227\219\2556\156\235\004\r\210"
                                        r26 = 12740343830316
                                        r3 = r28(r60, r26)
                                        r43 = r20[r3]
                                        state[ReturnVal] = r43
                                        r60 = 17626567909392
                                        state = upvalueValues[r9]
                                        r43 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r3 = "\204\015\"\144\024'"
                                        r28 = r20(r3, r60)
                                        r60 = ">\245\158"
                                        ReturnVal = r43[r28]
                                        r43 = upvalueValues[r23]
                                        state[ReturnVal] = r43
                                        r43 = "Instance"
                                        ReturnVal = _env[r43]
                                        r20 = upvalueValues[upvalues[1]]
                                        r28 = upvalueValues[upvalues[2]]
                                        r26 = 25911249727265
                                        r3 = r28(r60, r26)
                                        r43 = r20[r3]
                                        state = ReturnVal[r43]
                                        r60 = "f\143\129m\158`V\237\015"
                                        r20 = upvalueValues[upvalues[1]]
                                        r28 = upvalueValues[upvalues[2]]
                                        r26 = 3357902439963
                                        r3 = r28(r60, r26)
                                        r43 = r20[r3]
                                        ReturnVal = state(r43)
                                        r60 = "\027'\015\153"
                                        r43 = allocUpvalue()
                                        upvalueValues[r43] = ReturnVal
                                        state = upvalueValues[r43]
                                        r20 = upvalueValues[upvalues[1]]
                                        r28 = upvalueValues[upvalues[2]]
                                        r26 = 22605720217886
                                        r3 = r28(r60, r26)
                                        ReturnVal = r20[r3]
                                        r3 = "UDim2"
                                        r28 = _env[r3]
                                        r60 = upvalueValues[upvalues[1]]
                                        r26 = upvalueValues[upvalues[2]]
                                        r68 = 9854105407980
                                        r54 = "i\022N"
                                        r38 = r26(r54, r68)
                                        r3 = r60[r38]
                                        r20 = r28[r3]
                                        r60 = 0
                                        r38 = 0
                                        r3 = 1
                                        r26 = 0.1
                                        r28 = r20(r3, r60, r26, r38)
                                        state[ReturnVal] = r28
                                        state = upvalueValues[r43]
                                        r20 = upvalueValues[upvalues[1]]
                                        r28 = upvalueValues[upvalues[2]]
                                        r60 = "\251H\223f\130c>\183"
                                        r26 = 9802272788948
                                        r3 = r28(r60, r26)
                                        ReturnVal = r20[r3]
                                        r3 = "UDim2"
                                        r28 = _env[r3]
                                        r60 = upvalueValues[upvalues[1]]
                                        r26 = upvalueValues[upvalues[2]]
                                        r54 = "\031e\201"
                                        r68 = 15791470927033
                                        r38 = r26(r54, r68)
                                        r3 = r60[r38]
                                        r60 = 0
                                        r20 = r28[r3]
                                        r26 = 0.65
                                        r3 = 0
                                        r38 = 0
                                        r28 = r20(r3, r60, r26, r38)
                                        state[ReturnVal] = r28
                                        state = upvalueValues[r43]
                                        r60 = "\176\219*\180\135 \163\241\166\211\0179<aiw\021\214\206\181y\153"
                                        r20 = upvalueValues[upvalues[1]]
                                        r28 = upvalueValues[upvalues[2]]
                                        r26 = 21890631968721
                                        r3 = r28(r60, r26)
                                        ReturnVal = r20[r3]
                                        r20 = 1
                                        state[ReturnVal] = r20
                                        state = upvalueValues[r43]
                                        r20 = upvalueValues[upvalues[1]]
                                        r28 = upvalueValues[upvalues[2]]
                                        r60 = "d/\192\147\150\188\003\250\029\138"
                                        r26 = 10931645092834
                                        r3 = r28(r60, r26)
                                        ReturnVal = r20[r3]
                                        r3 = "Color3"
                                        r28 = _env[r3]
                                        r60 = upvalueValues[upvalues[1]]
                                        r26 = upvalueValues[upvalues[2]]
                                        r68 = 18793741918767
                                        r54 = "\156\169\156 jt\195"
                                        r38 = r26(r54, r68)
                                        r3 = r60[r38]
                                        r60 = 255
                                        r20 = r28[r3]
                                        r26 = 255
                                        r3 = 255
                                        r28 = r20(r3, r60, r26)
                                        state[ReturnVal] = r28
                                        state = upvalueValues[r43]
                                        r60 = "B\253i-1|\180\179"
                                        r20 = upvalueValues[upvalues[1]]
                                        r28 = upvalueValues[upvalues[2]]
                                        r26 = 24797810683163
                                        r3 = r28(r60, r26)
                                        ReturnVal = r20[r3]
                                        r20 = 18
                                        state[ReturnVal] = r20
                                        state = upvalueValues[r43]
                                        r20 = upvalueValues[upvalues[1]]
                                        r28 = upvalueValues[upvalues[2]]
                                        r60 = "H\137\131\163"
                                        r26 = 21939176220648
                                        r3 = r28(r60, r26)
                                        r60 = "Enum"
                                        ReturnVal = r20[r3]
                                        r3 = _env[r60]
                                        r26 = upvalueValues[upvalues[1]]
                                        r38 = upvalueValues[upvalues[2]]
                                        r18 = 31338246535425
                                        r68 = "\138\175H\228"
                                        r54 = r38(r68, r18)
                                        r60 = r26[r54]
                                        r28 = r3[r60]
                                        r60 = upvalueValues[upvalues[1]]
                                        r26 = upvalueValues[upvalues[2]]
                                        r68 = 6563365669872
                                        r54 = "\011\015\196\0114\155l\160\154\137"
                                        r38 = r26(r54, r68)
                                        r3 = r60[r38]
                                        r20 = r28[r3]
                                        state[ReturnVal] = r20
                                        state = upvalueValues[r43]
                                        r60 = "\141\223\131\208"
                                        r20 = upvalueValues[upvalues[1]]
                                        r28 = upvalueValues[upvalues[2]]
                                        r26 = 3790641563365
                                        r3 = r28(r60, r26)
                                        ReturnVal = r20[r3]
                                        r28 = upvalueValues[upvalues[1]]
                                        r3 = upvalueValues[upvalues[2]]
                                        r26 = "\207\211"
                                        r38 = 15206746889129
                                        r60 = r3(r26, r38)
                                        r20 = r28[r60]
                                        state[ReturnVal] = r20
                                        r60 = "\246\138\027\020\2043"
                                        state = upvalueValues[r43]
                                        r20 = upvalueValues[upvalues[1]]
                                        r28 = upvalueValues[upvalues[2]]
                                        r26 = 13821605550372
                                        r3 = r28(r60, r26)
                                        ReturnVal = r20[r3]
                                        r20 = upvalueValues[r23]
                                        state[ReturnVal] = r20
                                        r20 = "Instance"
                                        ReturnVal = _env[r20]
                                        r28 = upvalueValues[upvalues[1]]
                                        r3 = upvalueValues[upvalues[2]]
                                        r38 = 19461143225190
                                        r26 = "u\008f"
                                        r60 = r3(r26, r38)
                                        r20 = r28[r60]
                                        state = ReturnVal[r20]
                                        r28 = upvalueValues[upvalues[1]]
                                        r3 = upvalueValues[upvalues[2]]
                                        r38 = 25092175670692
                                        r26 = "8\027-\146k"
                                        r60 = r3(r26, r38)
                                        r20 = r28[r60]
                                        ReturnVal = state(r20)
                                        r20 = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r60 = "\165S\223!"
                                        r28 = upvalueValues[upvalues[2]]
                                        r26 = 29642402100715
                                        r3 = r28(r60, r26)
                                        state = ReturnVal[r3]
                                        r3 = "UDim2"
                                        r28 = _env[r3]
                                        r60 = upvalueValues[upvalues[1]]
                                        r26 = upvalueValues[upvalues[2]]
                                        r68 = 2956105762144
                                        r54 = "\000\2280"
                                        r38 = r26(r54, r68)
                                        r3 = r60[r38]
                                        ReturnVal = r28[r3]
                                        r60 = 0
                                        r26 = 0.12
                                        r38 = 0
                                        r3 = 1
                                        r28 = ReturnVal(r3, r60, r26, r38)
                                        r20[state] = r28
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r60 = "\201W\241\149\251\029K["
                                        r28 = upvalueValues[upvalues[2]]
                                        r26 = 8269710249738
                                        r3 = r28(r60, r26)
                                        state = ReturnVal[r3]
                                        r3 = "UDim2"
                                        r28 = _env[r3]
                                        r60 = upvalueValues[upvalues[1]]
                                        r26 = upvalueValues[upvalues[2]]
                                        r68 = 19430744630104
                                        r54 = "[O\007"
                                        r38 = r26(r54, r68)
                                        r3 = r60[r38]
                                        r60 = 0
                                        ReturnVal = r28[r3]
                                        r38 = 0
                                        r26 = 0.8
                                        r3 = 0
                                        r28 = ReturnVal(r3, r60, r26, r38)
                                        r20[state] = r28
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r28 = upvalueValues[upvalues[2]]
                                        r60 = "\150\006\167\2428\011%y\140\020\210B\208\157\243\190"
                                        r26 = 33024186973202
                                        r3 = r28(r60, r26)
                                        state = ReturnVal[r3]
                                        r3 = "Color3"
                                        r28 = _env[r3]
                                        r60 = upvalueValues[upvalues[1]]
                                        r26 = upvalueValues[upvalues[2]]
                                        r54 = "(\254\214\133\131\158\242"
                                        r68 = 31749535316416
                                        r38 = r26(r54, r68)
                                        r3 = r60[r38]
                                        r60 = 50
                                        ReturnVal = r28[r3]
                                        r26 = 70
                                        r3 = 50
                                        r28 = ReturnVal(r3, r60, r26)
                                        r60 = "\135\025\214\023\156+\252\030f\172\238d\216dT"
                                        r20[state] = r28
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r28 = upvalueValues[upvalues[2]]
                                        r26 = 13596731332795
                                        r3 = r28(r60, r26)
                                        state = ReturnVal[r3]
                                        ReturnVal = 0
                                        r20[state] = ReturnVal
                                        r60 = "\235\226\131\005)\208"
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r28 = upvalueValues[upvalues[2]]
                                        r26 = 34601847586544
                                        r3 = r28(r60, r26)
                                        r28 = "Instance"
                                        state = ReturnVal[r3]
                                        ReturnVal = upvalueValues[r23]
                                        r20[state] = ReturnVal
                                        ReturnVal = _env[r28]
                                        r3 = upvalueValues[upvalues[1]]
                                        r60 = upvalueValues[upvalues[2]]
                                        r38 = "G\204Y"
                                        r54 = 9495664070981
                                        r26 = r60(r38, r54)
                                        r28 = r3[r26]
                                        state = ReturnVal[r28]
                                        r3 = upvalueValues[upvalues[1]]
                                        r60 = upvalueValues[upvalues[2]]
                                        r38 = "\235\164\199\210b&\148\162"
                                        r54 = 27417463189983
                                        r26 = r60(r38, r54)
                                        r28 = r3[r26]
                                        ReturnVal = state(r28)
                                        r28 = ReturnVal
                                        r64 = "\127\1300%"
                                        r17 = "$\021'\212"
                                        r13 = 1791103140674
                                        r67 = "\235/Y\142"
                                        r46 = 6465613990850
                                        r57 = 25940610740015
                                        r21 = 21850722461631
                                        r55 = 12077556995576
                                        r11 = "j\229\226"
                                        r49 = 16911722487491
                                        r39 = 23452890147497
                                        r33 = "S\167\171\004Xn\029"
                                        r62 = "\163\23598"
                                        r31 = "+\nb5"
                                        r35 = 23871314602859
                                        r58 = 31801270483416
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r3 = upvalueValues[upvalues[2]]
                                        r38 = 16330739457460
                                        r26 = "\185\146\243\186\254\1489\021t\165\026\195"
                                        r60 = r3(r26, r38)
                                        state = ReturnVal[r60]
                                        r60 = "UDim"
                                        r3 = _env[r60]
                                        r26 = upvalueValues[upvalues[1]]
                                        r38 = upvalueValues[upvalues[2]]
                                        r18 = 22236007901298
                                        r68 = "1\130\202"
                                        r54 = r38(r68, r18)
                                        r7 = nil
                                        r60 = r26[r54]
                                        ReturnVal = r3[r60]
                                        r60 = 0
                                        r26 = 8
                                        r3 = ReturnVal(r60, r26)
                                        r28[state] = r3
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r3 = upvalueValues[upvalues[2]]
                                        r26 = "\166\201\018\255]\161"
                                        r38 = 9859659010543
                                        r60 = r3(r26, r38)
                                        state = ReturnVal[r60]
                                        ReturnVal = r20
                                        r28[state] = ReturnVal
                                        r3 = "Instance"
                                        ReturnVal = _env[r3]
                                        r60 = upvalueValues[upvalues[1]]
                                        r26 = upvalueValues[upvalues[2]]
                                        r54 = "\031\007g"
                                        r68 = 7057617079510
                                        r38 = r26(r54, r68)
                                        r3 = r60[r38]
                                        state = ReturnVal[r3]
                                        r60 = upvalueValues[upvalues[1]]
                                        r26 = upvalueValues[upvalues[2]]
                                        r68 = 25593910341262
                                        r54 = "\177k\031\226\224"
                                        r38 = r26(r54, r68)
                                        r3 = r60[r38]
                                        ReturnVal = state(r3)
                                        r3 = allocUpvalue()
                                        upvalueValues[r3] = ReturnVal
                                        state = upvalueValues[r3]
                                        r60 = upvalueValues[upvalues[1]]
                                        r26 = upvalueValues[upvalues[2]]
                                        r68 = 32465379228429
                                        r54 = "\\n\247:"
                                        r38 = r26(r54, r68)
                                        ReturnVal = r60[r38]
                                        r38 = "UDim2"
                                        r26 = _env[r38]
                                        r54 = upvalueValues[upvalues[1]]
                                        r68 = upvalueValues[upvalues[2]]
                                        r18 = r68(r11, r49)
                                        r38 = r54[r18]
                                        r60 = r26[r38]
                                        r54 = 0
                                        r18 = 0
                                        r68 = 1
                                        r38 = 0
                                        r26 = r60(r38, r54, r68, r18)
                                        state[ReturnVal] = r26
                                        state = upvalueValues[r3]
                                        r60 = upvalueValues[upvalues[1]]
                                        r26 = upvalueValues[upvalues[2]]
                                        r68 = 211811024994
                                        r54 = "E=\135,\012\021\225\203!\157\166\184N\161\139\231"
                                        r38 = r26(r54, r68)
                                        ReturnVal = r60[r38]
                                        r38 = "Color3"
                                        r26 = _env[r38]
                                        r54 = upvalueValues[upvalues[1]]
                                        r68 = upvalueValues[upvalues[2]]
                                        r49 = 13072478050247
                                        r11 = "\162P\2559o\203\254"
                                        r18 = r68(r11, r49)
                                        r38 = r54[r18]
                                        r60 = r26[r38]
                                        r68 = 255
                                        r38 = 0
                                        r54 = 170
                                        r26 = r60(r38, r54, r68)
                                        state[ReturnVal] = r26
                                        state = upvalueValues[r3]
                                        r60 = upvalueValues[upvalues[1]]
                                        r26 = upvalueValues[upvalues[2]]
                                        r68 = 3617982350996
                                        r54 = "\227\254!~\165\000\246P*\008\193\012\189^\132"
                                        r38 = r26(r54, r68)
                                        ReturnVal = r60[r38]
                                        r60 = 0
                                        state[ReturnVal] = r60
                                        state = upvalueValues[r3]
                                        r60 = upvalueValues[upvalues[1]]
                                        r26 = upvalueValues[upvalues[2]]
                                        r54 = "\184)\145\172\134K"
                                        r68 = 11143456134213
                                        r38 = r26(r54, r68)
                                        ReturnVal = r60[r38]
                                        r60 = r20
                                        state[ReturnVal] = r60
                                        r60 = "Instance"
                                        ReturnVal = _env[r60]
                                        r26 = upvalueValues[upvalues[1]]
                                        r38 = upvalueValues[upvalues[2]]
                                        r18 = 31866219985398
                                        r68 = "\226\230{"
                                        r54 = r38(r68, r18)
                                        r60 = r26[r54]
                                        state = ReturnVal[r60]
                                        r26 = upvalueValues[upvalues[1]]
                                        r38 = upvalueValues[upvalues[2]]
                                        r68 = "P3\176[\178\029X+"
                                        r18 = 28415793050544
                                        r54 = r38(r68, r18)
                                        r60 = r26[r54]
                                        ReturnVal = state(r60)
                                        r60 = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r26 = upvalueValues[upvalues[2]]
                                        r54 = "\196\161!\151\133\1423\133\179\002[\146"
                                        r68 = 33082632354861
                                        r38 = r26(r54, r68)
                                        state = ReturnVal[r38]
                                        r38 = "UDim"
                                        r26 = _env[r38]
                                        r54 = upvalueValues[upvalues[1]]
                                        r68 = upvalueValues[upvalues[2]]
                                        r11 = "\162\1335"
                                        r49 = 28020094415607
                                        r18 = r68(r11, r49)
                                        r38 = r54[r18]
                                        ReturnVal = r26[r38]
                                        r54 = 8
                                        r38 = 0
                                        r26 = ReturnVal(r38, r54)
                                        r60[state] = r26
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r26 = upvalueValues[upvalues[2]]
                                        r54 = "\188\173\130\141wK"
                                        r68 = 34979158720416
                                        r38 = r26(r54, r68)
                                        state = ReturnVal[r38]
                                        ReturnVal = upvalueValues[r3]
                                        r60[state] = ReturnVal
                                        r12 = 20052814734457
                                        r26 = "Instance"
                                        ReturnVal = _env[r26]
                                        r38 = upvalueValues[upvalues[1]]
                                        r54 = upvalueValues[upvalues[2]]
                                        r11 = 1688901813010
                                        r18 = "'\214\201"
                                        r68 = r54(r18, r11)
                                        r26 = r38[r68]
                                        state = ReturnVal[r26]
                                        r38 = upvalueValues[upvalues[1]]
                                        r54 = upvalueValues[upvalues[2]]
                                        r11 = 8042469199521
                                        r18 = "X\193\214Z\004"
                                        r68 = r54(r18, r11)
                                        r26 = r38[r68]
                                        ReturnVal = state(r26)
                                        r11 = 13616392165572
                                        r49 = 21150045038200
                                        r2 = nil
                                        r26 = allocUpvalue()
                                        upvalueValues[r26] = ReturnVal
                                        state = upvalueValues[r26]
                                        r38 = upvalueValues[upvalues[1]]
                                        r54 = upvalueValues[upvalues[2]]
                                        r18 = "\175\000\191\004\031_V"
                                        r68 = r54(r18, r11)
                                        ReturnVal = r38[r68]
                                        r54 = upvalueValues[upvalues[1]]
                                        r68 = upvalueValues[upvalues[2]]
                                        r11 = "\133k]\172\129mi\207S)\180\152\0283&\r7\202c\192\186\171(S\014)B"
                                        r18 = r68(r11, r49)
                                        r38 = r54[r18]
                                        state[ReturnVal] = r38
                                        state = upvalueValues[r26]
                                        r38 = upvalueValues[upvalues[1]]
                                        r54 = upvalueValues[upvalues[2]]
                                        r18 = "US\137p#L"
                                        r11 = 33134644886597
                                        r68 = r54(r18, r11)
                                        ReturnVal = r38[r68]
                                        r38 = true
                                        state[ReturnVal] = r38
                                        state = upvalueValues[r26]
                                        r38 = upvalueValues[upvalues[1]]
                                        r54 = upvalueValues[upvalues[2]]
                                        r11 = 8074422177455
                                        r18 = "Ii\137\011\014i"
                                        r68 = r54(r18, r11)
                                        ReturnVal = r38[r68]
                                        r38 = 0.5
                                        state[ReturnVal] = r38
                                        state = upvalueValues[r26]
                                        r38 = upvalueValues[upvalues[1]]
                                        r54 = upvalueValues[upvalues[2]]
                                        r18 = "\219C\236>\031\233"
                                        r11 = 24106150816729
                                        r68 = r54(r18, r11)
                                        ReturnVal = r38[r68]
                                        r38 = upvalueValues[r23]
                                        state[ReturnVal] = r38
                                        state = upvalueValues[r26]
                                        r38 = allocUpvalue()
                                        ReturnVal = "Play"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state)
                                        r68 = allocUpvalue()
                                        r54 = allocUpvalue()
                                        state = createClosure1(150, {
                                            upvalues[1],
                                            upvalues[2],
                                            r23,
                                            upvalues[4]
                                        })
                                        upvalueValues[r38] = state
                                        state = createClosure3(151, {
                                            upvalues[1],
                                            upvalues[2],
                                            r23,
                                            upvalues[4]
                                        })
                                        upvalueValues[r54] = state
                                        state = createClosure0(155, {
                                            upvalues[1],
                                            upvalues[2],
                                            r23,
                                            upvalues[4]
                                        })
                                        upvalueValues[r68] = state
                                        r49 = upvalueValues[upvalues[1]]
                                        r25 = upvalueValues[upvalues[2]]
                                        r65 = r25(r31, r21)
                                        r11 = r49[r65]
                                        r25 = upvalueValues[upvalues[1]]
                                        r65 = upvalueValues[upvalues[2]]
                                        r21 = "I\156\179:\160\136\n\149\195\171\198\158bb\197\144R\1599"
                                        r31 = r65(r21, r35)
                                        r49 = r25[r31]
                                        r65 = upvalueValues[upvalues[1]]
                                        r31 = upvalueValues[upvalues[2]]
                                        r35 = "(1\188#]"
                                        r21 = r31(r35, r55)
                                        r25 = r65[r21]
                                        r21 = "Color3"
                                        r31 = _env[r21]
                                        r35 = upvalueValues[upvalues[1]]
                                        r55 = upvalueValues[upvalues[2]]
                                        r14 = r55(r33, r12)
                                        r21 = r35[r14]
                                        r65 = r31[r21]
                                        r55 = 255
                                        r35 = 200
                                        r21 = 200
                                        r31 = r65(r21, r35, r55)
                                        r21 = upvalueValues[upvalues[1]]
                                        r35 = upvalueValues[upvalues[2]]
                                        r14 = "\139b\215I"
                                        r33 = 1365195227771
                                        r55 = r35(r14, r33)
                                        r65 = r21[r55]
                                        r14 = "Enum"
                                        r55 = _env[r14]
                                        r33 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r59 = "\246\008\217\186"
                                        r1 = r12(r59, r46)
                                        r14 = r33[r1]
                                        r35 = r55[r14]
                                        r14 = upvalueValues[upvalues[1]]
                                        r33 = upvalueValues[upvalues[2]]
                                        r59 = 5434645367266
                                        r1 = "\149R<\026\201f\238"
                                        r12 = r33(r1, r59)
                                        r55 = r14[r12]
                                        r21 = r35[r55]
                                        r18 = {
                                            [r11] = r49,
                                            [r25] = r31,
                                            [r65] = r21
                                        }
                                        r65 = upvalueValues[upvalues[1]]
                                        r31 = upvalueValues[upvalues[2]]
                                        r35 = "3\132{\008"
                                        r55 = 33772985695598
                                        r21 = r31(r35, r55)
                                        r25 = r65[r21]
                                        r31 = upvalueValues[upvalues[1]]
                                        r21 = upvalueValues[upvalues[2]]
                                        r14 = 11526936909047
                                        r55 = "\199m\029\205\180>d\236\171,\189\134e^\205\017B\226\173-"
                                        r35 = r21(r55, r14)
                                        r65 = r31[r35]
                                        r21 = upvalueValues[upvalues[1]]
                                        r35 = upvalueValues[upvalues[2]]
                                        r33 = 14951251221298
                                        r14 = "\196O\000\134\019"
                                        r55 = r35(r14, r33)
                                        r31 = r21[r55]
                                        r55 = "Color3"
                                        r35 = _env[r55]
                                        r14 = upvalueValues[upvalues[1]]
                                        r33 = upvalueValues[upvalues[2]]
                                        r1 = "\250}\217\219\181\184h"
                                        r59 = 17430178176948
                                        r12 = r33(r1, r59)
                                        r55 = r14[r12]
                                        r21 = r35[r55]
                                        r14 = 255
                                        r33 = 200
                                        r55 = 150
                                        r35 = r21(r55, r14, r33)
                                        r55 = upvalueValues[upvalues[1]]
                                        r14 = upvalueValues[upvalues[2]]
                                        r12 = "\128\248\227\030"
                                        r1 = 9703650365862
                                        r33 = r14(r12, r1)
                                        r21 = r55[r33]
                                        r12 = "Enum"
                                        r33 = _env[r12]
                                        r1 = upvalueValues[upvalues[1]]
                                        r59 = upvalueValues[upvalues[2]]
                                        r46 = r59(r17, r57)
                                        r12 = r1[r46]
                                        r14 = r33[r12]
                                        r12 = upvalueValues[upvalues[1]]
                                        r1 = upvalueValues[upvalues[2]]
                                        r46 = "\222\233\022HHX\1418\2463"
                                        r17 = 5572550052386
                                        r59 = r1(r46, r17)
                                        r33 = r12[r59]
                                        r55 = r14[r33]
                                        r49 = {
                                            [r25] = r65,
                                            [r31] = r35,
                                            [r21] = r55
                                        }
                                        r11 = 25
                                        ReturnVal = 0
                                        r25 = 50
                                        r21 = upvalueValues[upvalues[1]]
                                        r35 = upvalueValues[upvalues[2]]
                                        r14 = "jf\146\t"
                                        r33 = 1874497209192
                                        r55 = r35(r14, r33)
                                        r31 = r21[r55]
                                        r35 = upvalueValues[upvalues[1]]
                                        r55 = upvalueValues[upvalues[2]]
                                        r12 = 13561298360490
                                        r33 = "\212\014iV\132\192Rn\0281\181\145J\134\131\174\151\223\185\145\150~\"\014"
                                        r14 = r55(r33, r12)
                                        r21 = r35[r14]
                                        r55 = upvalueValues[upvalues[1]]
                                        r14 = upvalueValues[upvalues[2]]
                                        r1 = 11418170299589
                                        r12 = "\171\189\174\176\190"
                                        r33 = r14(r12, r1)
                                        r35 = r55[r33]
                                        r33 = "Color3"
                                        r14 = _env[r33]
                                        r12 = upvalueValues[upvalues[1]]
                                        r1 = upvalueValues[upvalues[2]]
                                        r17 = 9854505275884
                                        r46 = "*r\134\221-\199!"
                                        r59 = r1(r46, r17)
                                        r33 = r12[r59]
                                        r55 = r14[r33]
                                        r46 = 3142897206711
                                        r1 = 150
                                        r59 = "R\230\134\254"
                                        r33 = 255
                                        r60 = nil
                                        r12 = 220
                                        r14 = r55(r33, r12, r1)
                                        r33 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r1 = r12(r59, r46)
                                        r55 = r33[r1]
                                        r59 = "Enum"
                                        r1 = _env[r59]
                                        r46 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r57 = r17(r67, r39)
                                        r59 = r46[r57]
                                        r12 = r1[r59]
                                        r59 = upvalueValues[upvalues[1]]
                                        r46 = upvalueValues[upvalues[2]]
                                        r67 = 23571519351520
                                        r57 = "%Z\181\r:\190\195"
                                        r17 = r46(r57, r67)
                                        r1 = r59[r17]
                                        r33 = r12[r1]
                                        r65 = {
                                            [r31] = r21,
                                            [r35] = r14,
                                            [r55] = r33
                                        }
                                        r31 = 75
                                        r55 = upvalueValues[upvalues[1]]
                                        r14 = upvalueValues[upvalues[2]]
                                        r12 = "56\170\197"
                                        r1 = 5127474809171
                                        r33 = r14(r12, r1)
                                        r35 = r55[r33]
                                        r14 = upvalueValues[upvalues[1]]
                                        r33 = upvalueValues[upvalues[2]]
                                        r59 = 19711345451994
                                        r1 = "\205\220\t\229\175x\255N\229\216=\253\200\221\189@\188/\249xw?q"
                                        r12 = r33(r1, r59)
                                        r55 = r14[r12]
                                        r33 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r46 = 26492808671280
                                        r59 = "\027\148z\222\163"
                                        r1 = r12(r59, r46)
                                        r14 = r33[r1]
                                        r1 = "Color3"
                                        r12 = _env[r1]
                                        r59 = upvalueValues[upvalues[1]]
                                        r46 = upvalueValues[upvalues[2]]
                                        r67 = 8318768942881
                                        r57 = "\223\2051\131h\017\230"
                                        r17 = r46(r57, r67)
                                        r1 = r59[r17]
                                        r33 = r12[r1]
                                        r59 = 100
                                        r46 = 180
                                        r1 = 255
                                        r12 = r33(r1, r59, r46)
                                        r17 = "\161K4\158"
                                        r1 = upvalueValues[upvalues[1]]
                                        r59 = upvalueValues[upvalues[2]]
                                        r20 = nil
                                        r57 = 17926744842395
                                        r46 = r59(r17, r57)
                                        r33 = r1[r46]
                                        r17 = "Enum"
                                        r46 = _env[r17]
                                        r57 = upvalueValues[upvalues[1]]
                                        r67 = upvalueValues[upvalues[2]]
                                        r39 = r67(r62, r13)
                                        r17 = r57[r39]
                                        r59 = r46[r17]
                                        r17 = upvalueValues[upvalues[1]]
                                        r57 = upvalueValues[upvalues[2]]
                                        r39 = "X5\167@\129\246\161\202\208\165"
                                        r62 = 9871103660532
                                        r67 = r57(r39, r62)
                                        r46 = r17[r67]
                                        r1 = r59[r46]
                                        r21 = {
                                            [r35] = r55,
                                            [r14] = r12,
                                            [r33] = r1
                                        }
                                        r33 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r59 = "]\162\152t"
                                        r46 = 6777628150868
                                        r1 = r12(r59, r46)
                                        r14 = r33[r1]
                                        r12 = upvalueValues[upvalues[1]]
                                        r1 = upvalueValues[upvalues[2]]
                                        r17 = 22753447307619
                                        r46 = "3\231\235\136\014c\184\001r\152\182\249\238\159\239!d"
                                        r59 = r1(r46, r17)
                                        r33 = r12[r59]
                                        r1 = upvalueValues[upvalues[1]]
                                        r59 = upvalueValues[upvalues[2]]
                                        r57 = 19723713487840
                                        r17 = "\019\004A\247\020"
                                        r46 = r59(r17, r57)
                                        r12 = r1[r46]
                                        r46 = "Color3"
                                        r59 = _env[r46]
                                        r17 = upvalueValues[upvalues[1]]
                                        r57 = upvalueValues[upvalues[2]]
                                        r62 = 28628350612499
                                        r39 = "U\153%Y`\1380"
                                        r67 = r57(r39, r62)
                                        r46 = r17[r67]
                                        r1 = r59[r46]
                                        r57 = 100
                                        r17 = 255
                                        r46 = 0
                                        r59 = r1(r46, r17, r57)
                                        r46 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r67 = "\145\021\002`"
                                        r39 = 11440389805263
                                        r57 = r17(r67, r39)
                                        r1 = r46[r57]
                                        r67 = "Enum"
                                        r57 = _env[r67]
                                        r39 = upvalueValues[upvalues[1]]
                                        r62 = upvalueValues[upvalues[2]]
                                        r13 = r62(r64, r58)
                                        r67 = r39[r13]
                                        r17 = r57[r67]
                                        r67 = upvalueValues[upvalues[1]]
                                        r39 = upvalueValues[upvalues[2]]
                                        r13 = "z\142\"U\r\187\167o"
                                        r64 = 13496793258124
                                        r62 = r39(r13, r64)
                                        r57 = r67[r62]
                                        r46 = r17[r57]
                                        r35 = 100
                                        r28 = nil
                                        r55 = {
                                            [r14] = r33,
                                            [r12] = r59,
                                            [r1] = r46
                                        }
                                        state = {
                                            [ReturnVal] = r18,
                                            [r11] = r49,
                                            [r25] = r65,
                                            [r31] = r21,
                                            [r35] = r55
                                        }
                                        r18 = allocUpvalue()
                                        upvalueValues[r18] = state
                                        r11 = "task"
                                        ReturnVal = _env[r11]
                                        r49 = upvalueValues[upvalues[1]]
                                        r25 = upvalueValues[upvalues[2]]
                                        r21 = 12805585049419
                                        r31 = "\022\235\231\152\161"
                                        r65 = r25(r31, r21)
                                        r11 = r49[r65]
                                        state = ReturnVal[r11]
                                        r11 = createClosure3(172, {
                                            upvalues[1],
                                            upvalues[2],
                                            r3,
                                            r9,
                                            r43,
                                            upvalues[4],
                                            r18,
                                            r38,
                                            r41,
                                            r26,
                                            r23,
                                            r54,
                                            r68,
                                            r22,
                                            upvalues[5]
                                        })
                                        r41 = releaseUpvalue(r41)
                                        r38 = releaseUpvalue(r38)
                                        r54 = releaseUpvalue(r54)
                                        r18 = releaseUpvalue(r18)
                                        r68 = releaseUpvalue(r68)
                                        r26 = releaseUpvalue(r26)
                                        r9 = releaseUpvalue(r9)
                                        r22 = releaseUpvalue(r22)
                                        r3 = releaseUpvalue(r3)
                                        ReturnVal = state(r11)
                                        r23 = releaseUpvalue(r23)
                                        r43 = releaseUpvalue(r43)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure5 entry 15337062 -> 127, states 127-138
                                    if state <= 132 then
                                        if state <= 129 then
                                            if state <= 128 then
                                                if state <= 127 then
                                                    if state == 127 then -- entry 15337062 -> 127
                                                        r22 = upvalueValues[upvalues[1]]
                                                        state = r22 and (128) or (129)
                                                        ReturnVal = r22
                                                    end
                                                else
                                                    if state == 128 then
                                                        state = ReturnVal and (130) or (131)
                                                    end
                                                end
                                            else
                                                if state == 129 then
                                                    r22 = upvalueValues[upvalues[2]]
                                                    ReturnVal = r22
                                                    state = 128
                                                end
                                            end
                                        else
                                            if state <= 131 then
                                                if state <= 130 then
                                                    if state == 130 then
                                                        ReturnVal = "warn"
                                                        state = _env[ReturnVal]
                                                        r23 = upvalueValues[upvalues[3]]
                                                        r2 = upvalueValues[upvalues[4]]
                                                        r7 = "9\199\213F}Q\165\182\022\026\029\147\187\159\001\t\156]O?\147b,\229jZ\163vq\193d\232\147?\182\193"
                                                        r9 = 1474949055150
                                                        r41 = r2(r7, r9)
                                                        r22 = r23[r41]
                                                        ReturnVal = state(r22)
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                else
                                                    if state == 131 then
                                                        state = true
                                                        upvalueValues[upvalues[1]] = state
                                                        ReturnVal = true
                                                        upvalueValues[upvalues[2]] = ReturnVal
                                                        r22 = upvalueValues[upvalues[5]]
                                                        r2 = upvalueValues[upvalues[3]]
                                                        r41 = upvalueValues[upvalues[4]]
                                                        r43 = 14872738142989
                                                        r9 = "5I@\r"
                                                        r7 = r41(r9, r43)
                                                        r23 = r2[r7]
                                                        r41 = upvalueValues[upvalues[3]]
                                                        r7 = upvalueValues[upvalues[4]]
                                                        r20 = 33015420910606
                                                        r43 = "1\236Z\235\1319\151\209\169\129\182\149"
                                                        r9 = r7(r43, r20)
                                                        r2 = r41[r9]
                                                        r22[r23] = r2
                                                        r22 = upvalueValues[upvalues[5]]
                                                        r2 = upvalueValues[upvalues[3]]
                                                        r41 = upvalueValues[upvalues[4]]
                                                        r9 = "\213)\244\246\169\227"
                                                        r43 = 20000308782177
                                                        r7 = r41(r9, r43)
                                                        r23 = r2[r7]
                                                        r2 = false
                                                        r22[r23] = r2
                                                        r23 = "warn"
                                                        r22 = _env[r23]
                                                        r41 = upvalueValues[upvalues[3]]
                                                        r7 = upvalueValues[upvalues[4]]
                                                        r43 = "\020\224\135\148\136\158\197Y\022\209\003\232\156\155"
                                                        r20 = 22128976537664
                                                        r9 = r7(r43, r20)
                                                        r2 = r41[r9]
                                                        r23 = r22(r2)
                                                        r23 = upvalueValues[upvalues[6]]
                                                        r2 = 1
                                                        r22 = r23 + r2
                                                        upvalueValues[upvalues[6]] = r22
                                                        r23 = upvalueValues[upvalues[7]]
                                                        r41 = upvalueValues[upvalues[3]]
                                                        r7 = upvalueValues[upvalues[4]]
                                                        r43 = "\155\015\001\233"
                                                        r20 = 23298216667745
                                                        r9 = r7(r43, r20)
                                                        r2 = r41[r9]
                                                        r9 = upvalueValues[upvalues[3]]
                                                        r43 = upvalueValues[upvalues[4]]
                                                        r3 = 17168359579450
                                                        r28 = "r\133!\181=\231\031\254\230_=6"
                                                        r20 = r43(r28, r3)
                                                        r7 = r9[r20]
                                                        r9 = upvalueValues[upvalues[6]]
                                                        r41 = r7 .. r9
                                                        r23[r2] = r41
                                                        r23 = upvalueValues[upvalues[8]]
                                                        r43 = "getgenv"
                                                        r9 = _env[r43]
                                                        r43 = r9()
                                                        r20 = upvalueValues[upvalues[3]]
                                                        r28 = upvalueValues[upvalues[4]]
                                                        r26 = 11384727983285
                                                        r60 = "\016\137s+\rJF?k\247\027\180^\027"
                                                        r3 = r28(r60, r26)
                                                        r9 = r20[r3]
                                                        r7 = r43[r9]
                                                        r9 = upvalueValues[upvalues[6]]
                                                        r20 = upvalueValues[upvalues[9]]
                                                        r3 = upvalueValues[upvalues[3]]
                                                        r60 = upvalueValues[upvalues[4]]
                                                        r38 = "\195\164H\155"
                                                        r54 = 13496714975372
                                                        r26 = r60(r38, r54)
                                                        r28 = r3[r26]
                                                        r43 = r20[r28]
                                                        r20 = {
                                                            r23(r7, r9, r43)
                                                        }
                                                        r2 = r20[1]
                                                        r23 = not r2
                                                        state = r23 and (132) or (133)
                                                        r41 = r20[2]
                                                    end
                                                end
                                            else
                                                if state == 132 then
                                                    r23 = upvalueValues[upvalues[10]]
                                                    r9 = upvalueValues[upvalues[3]]
                                                    r43 = upvalueValues[upvalues[4]]
                                                    r28 = "\149\185\248,"
                                                    r3 = 15134775450503
                                                    r20 = r43(r28, r3)
                                                    r7 = r9[r20]
                                                    r9 = r41
                                                    r23[r7] = r9
                                                    state = 133
                                                end
                                            end
                                        end
                                    else
                                        if state <= 135 then
                                            if state <= 134 then
                                                if state <= 133 then
                                                    if state == 133 then
                                                        r7 = state
                                                        r9 = upvalueValues[upvalues[11]]
                                                        state = r9 and (134) or (135)
                                                        r23 = r9
                                                    end
                                                else
                                                    if state == 134 then
                                                        r43 = upvalueValues[upvalues[11]]
                                                        r28 = upvalueValues[upvalues[3]]
                                                        r3 = upvalueValues[upvalues[4]]
                                                        r38 = 16230589783429
                                                        r26 = "G\210\191\133x\230"
                                                        r60 = r3(r26, r38)
                                                        r20 = r28[r60]
                                                        r9 = r43[r20]
                                                        r23 = r9
                                                        state = 135
                                                    end
                                                end
                                            else
                                                if state == 135 then
                                                    state = r7
                                                    state = r23 and (136) or (137)
                                                end
                                            end
                                        else
                                            if state <= 137 then
                                                if state <= 136 then
                                                    if state == 136 then
                                                        r7 = "warn"
                                                        r23 = _env[r7]
                                                        r43 = upvalueValues[upvalues[3]]
                                                        r20 = upvalueValues[upvalues[4]]
                                                        r60 = 12067168949747
                                                        r3 = "@\164\197\153\194\192\140\007H\250\216\202\2492Id\245\214-\t\148x\205VjzC"
                                                        r28 = r20(r3, r60)
                                                        r9 = r43[r28]
                                                        r7 = r23(r9)
                                                        r23 = upvalueValues[upvalues[11]]
                                                        r7 = "Destroy"
                                                        r7 = r23[r7]
                                                        r7 = r7(r23)
                                                        state = 138
                                                    end
                                                else
                                                    if state == 137 then
                                                        r7 = "warn"
                                                        r23 = _env[r7]
                                                        r43 = upvalueValues[upvalues[3]]
                                                        r20 = upvalueValues[upvalues[4]]
                                                        r3 = "Rj4kw\129\030\189S\238e\165\169+<%W*c\186\198\211\183\234c\019\153"
                                                        r60 = 3886713046801
                                                        r28 = r20(r3, r60)
                                                        r9 = r43[r28]
                                                        r7 = r23(r9)
                                                        state = 138
                                                    end
                                                end
                                            else
                                                if state == 138 then
                                                    r23 = upvalueValues[upvalues[12]]
                                                    ReturnVal = {}
                                                    r41 = nil
                                                    r2 = nil
                                                    r7 = r23()
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure4 entry 14107772 -> 139, states 139-139
                                if state == 139 then -- entry 14107772 -> 139
                                    r23 = "oQhB5PsceU"
                                    r2 = 7592417
                                    r22 = r23 ^ r2
                                    ReturnVal = 14353294
                                    state = ReturnVal - r22
                                    r22 = state
                                    ReturnVal = "x3nrW4"
                                    state = ReturnVal / r22
                                    ReturnVal = {
                                        state
                                    }
                                    state = nil
                                end
                            end
                        end
                    end
                else
                    if state <= 238 then
                        if state <= 150 then
                            if state <= 149 then
                                if state <= 148 then
                                    -- createClosure4 entry 11815437 -> 140, states 140-148
                                    if state <= 144 then
                                        if state <= 142 then
                                            if state <= 141 then
                                                if state <= 140 then
                                                    if state == 140 then -- entry 11815437 -> 140
                                                        r23 = createClosure2(239, {
                                                            upvalues[1],
                                                            upvalues[2],
                                                            upvalues[3]
                                                        })
                                                        ReturnVal = "pcall"
                                                        state = _env[ReturnVal]
                                                        r2 = {
                                                            state(r23)
                                                        }
                                                        ReturnVal = r2[1]
                                                        r22 = r2[2]
                                                        r23 = ReturnVal
                                                        r41 = state
                                                        state = r23 and (141) or (142)
                                                        r2 = r23
                                                    end
                                                else
                                                    if state == 141 then
                                                        r20 = state
                                                        r9 = state
                                                        r38 = "Enum"
                                                        r26 = _env[r38]
                                                        r54 = upvalueValues[upvalues[2]]
                                                        r68 = upvalueValues[upvalues[3]]
                                                        r11 = "\225\137\164\012C\016L \212\253\175\233\171J"
                                                        r49 = 2545278174369
                                                        r18 = r68(r11, r49)
                                                        r38 = r54[r18]
                                                        r60 = r26[r38]
                                                        r38 = upvalueValues[upvalues[2]]
                                                        r54 = upvalueValues[upvalues[3]]
                                                        r18 = "\190\208\218o"
                                                        r11 = 4985360042257
                                                        r68 = r54(r18, r11)
                                                        r26 = r38[r68]
                                                        r3 = r60[r26]
                                                        r28 = r22 == r3
                                                        state = r28 and (143) or (144)
                                                        r43 = r28
                                                    end
                                                end
                                            else
                                                if state == 142 then
                                                    state = r41
                                                    state = r2 and (145) or (146)
                                                    ReturnVal = r2
                                                end
                                            end
                                        else
                                            if state <= 143 then
                                                if state == 143 then
                                                    r3 = upvalueValues[upvalues[2]]
                                                    r60 = upvalueValues[upvalues[3]]
                                                    r38 = "\166$i\230\128"
                                                    r54 = 26614567514217
                                                    r26 = r60(r38, r54)
                                                    r28 = r3[r26]
                                                    r43 = r28
                                                    state = 144
                                                end
                                            else
                                                if state == 144 then
                                                    state = r20
                                                    state = r43 and (147) or (148)
                                                    r7 = r43
                                                end
                                            end
                                        end
                                    else
                                        if state <= 146 then
                                            if state <= 145 then
                                                if state == 145 then
                                                    ReturnVal = {
                                                        ReturnVal
                                                    }
                                                    state = nil
                                                end
                                            else
                                                if state == 146 then
                                                    r41 = upvalueValues[upvalues[2]]
                                                    r7 = upvalueValues[upvalues[3]]
                                                    r20 = 4604305360992
                                                    r43 = "\023\218\217|$\234\210\216\167*>\147\251\213\181\016Qp_2\252t\183{\140\249N\002v"
                                                    r9 = r7(r43, r20)
                                                    r2 = r41[r9]
                                                    ReturnVal = r2
                                                    state = 145
                                                end
                                            end
                                        else
                                            if state <= 147 then
                                                if state == 147 then
                                                    state = r9
                                                    r2 = r7
                                                    state = 142
                                                end
                                            else
                                                if state == 148 then
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r28 = upvalueValues[upvalues[3]]
                                                    r26 = 22162127546448
                                                    r60 = "g\184\191s"
                                                    r3 = r28(r60, r26)
                                                    r43 = r20[r3]
                                                    r7 = r43
                                                    state = 147
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure3 entry 11278678 -> 149, states 149-149
                                    if state == 149 then -- entry 11278678 -> 149
                                        state = upvalueValues[upvalues[1]]
                                        r2 = upvalueValues[upvalues[2]]
                                        r41 = upvalueValues[upvalues[3]]
                                        r43 = 20659673490836
                                        r9 = "\161\213\224"
                                        r7 = r41(r9, r43)
                                        r23 = r2[r7]
                                        r2 = upvalueValues[upvalues[4]]
                                        r7 = upvalueValues[upvalues[2]]
                                        r9 = upvalueValues[upvalues[3]]
                                        r28 = 27373087519178
                                        r20 = "U\007bt"
                                        r43 = r9(r20, r28)
                                        r41 = r7[r43]
                                        r7 = upvalueValues[upvalues[5]]
                                        r43 = upvalueValues[upvalues[2]]
                                        r20 = upvalueValues[upvalues[3]]
                                        r3 = "\129\215\027\225\220:"
                                        r60 = 12110705595911
                                        r28 = r20(r3, r60)
                                        r9 = r43[r28]
                                        r20 = upvalueValues[upvalues[2]]
                                        r28 = upvalueValues[upvalues[3]]
                                        r26 = 5269223147925
                                        r60 = "\197\230cC"
                                        r3 = r28(r60, r26)
                                        r43 = r20[r3]
                                        r28 = upvalueValues[upvalues[2]]
                                        r3 = upvalueValues[upvalues[3]]
                                        r38 = 1586064736994
                                        r26 = "\192\181q\162\212O\242"
                                        r60 = r3(r26, r38)
                                        r20 = r28[r60]
                                        r28 = upvalueValues[upvalues[6]]
                                        r22 = {
                                            [r23] = r2,
                                            [r41] = r7,
                                            [r9] = r43,
                                            [r20] = r28
                                        }
                                        ReturnVal = {
                                            state(r22)
                                        }
                                        ReturnVal = {
                                            unpack(ReturnVal)
                                        }
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure1 entry 3195453 -> 150, states 150-150
                                if state == 150 then -- entry 3195453 -> 150
                                    r22 = "Instance"
                                    ReturnVal = _env[r22]
                                    r23 = upvalueValues[upvalues[1]]
                                    r2 = upvalueValues[upvalues[2]]
                                    r7 = "\190\180\139"
                                    r9 = 6219983031120
                                    r41 = r2(r7, r9)
                                    r22 = r23[r41]
                                    state = ReturnVal[r22]
                                    r23 = upvalueValues[upvalues[1]]
                                    r2 = upvalueValues[upvalues[2]]
                                    r9 = 27505166807560
                                    r7 = "\251\205\173NQ"
                                    r41 = r2(r7, r9)
                                    r22 = r23[r41]
                                    ReturnVal = state(r22)
                                    r22 = allocUpvalue()
                                    upvalueValues[r22] = ReturnVal
                                    state = upvalueValues[r22]
                                    r23 = upvalueValues[upvalues[1]]
                                    r2 = upvalueValues[upvalues[2]]
                                    r7 = ",-<\007"
                                    r9 = 21945965684715
                                    r41 = r2(r7, r9)
                                    ReturnVal = r23[r41]
                                    r41 = "UDim2"
                                    r2 = _env[r41]
                                    r7 = upvalueValues[upvalues[1]]
                                    r9 = upvalueValues[upvalues[2]]
                                    r28 = 2785146258704
                                    r20 = "d\229\185"
                                    r43 = r9(r20, r28)
                                    r41 = r7[r43]
                                    r23 = r2[r41]
                                    r9 = 0.03
                                    r7 = 0
                                    r43 = 0
                                    r41 = 0.03
                                    r2 = r23(r41, r7, r9, r43)
                                    state[ReturnVal] = r2
                                    state = upvalueValues[r22]
                                    r23 = upvalueValues[upvalues[1]]
                                    r2 = upvalueValues[upvalues[2]]
                                    r7 = "\004\224\001\202\0276\150Q\136~\194w\001\186\130\211"
                                    r9 = 5917526051523
                                    r41 = r2(r7, r9)
                                    ReturnVal = r23[r41]
                                    r41 = "Color3"
                                    r2 = _env[r41]
                                    r7 = upvalueValues[upvalues[1]]
                                    r9 = upvalueValues[upvalues[2]]
                                    r28 = 21363441166044
                                    r20 = "\139\191C\187\162\221\181"
                                    r43 = r9(r20, r28)
                                    r41 = r7[r43]
                                    r23 = r2[r41]
                                    r41 = 255
                                    r9 = 255
                                    r7 = 255
                                    r2 = r23(r41, r7, r9)
                                    state[ReturnVal] = r2
                                    state = upvalueValues[r22]
                                    r23 = upvalueValues[upvalues[1]]
                                    r2 = upvalueValues[upvalues[2]]
                                    r9 = 12280810329686
                                    r7 = "\139\152\218\152\216\235\134\243\239h\135\0120\214J\177;\203LX$\236"
                                    r41 = r2(r7, r9)
                                    ReturnVal = r23[r41]
                                    r23 = 0.5
                                    state[ReturnVal] = r23
                                    state = upvalueValues[r22]
                                    r23 = upvalueValues[upvalues[1]]
                                    r2 = upvalueValues[upvalues[2]]
                                    r9 = 33334989241506
                                    r7 = "\t\175\238_7\n"
                                    r41 = r2(r7, r9)
                                    ReturnVal = r23[r41]
                                    r23 = upvalueValues[upvalues[3]]
                                    state[ReturnVal] = r23
                                    r23 = "Instance"
                                    ReturnVal = _env[r23]
                                    r2 = upvalueValues[upvalues[1]]
                                    r41 = upvalueValues[upvalues[2]]
                                    r43 = 2509808518288
                                    r9 = "oeE"
                                    r7 = r41(r9, r43)
                                    r23 = r2[r7]
                                    state = ReturnVal[r23]
                                    r2 = upvalueValues[upvalues[1]]
                                    r41 = upvalueValues[upvalues[2]]
                                    r9 = "nP7V\019[v\239"
                                    r43 = 34516818230985
                                    r7 = r41(r9, r43)
                                    r23 = r2[r7]
                                    ReturnVal = state(r23)
                                    r23 = ReturnVal
                                    ReturnVal = upvalueValues[upvalues[1]]
                                    r2 = upvalueValues[upvalues[2]]
                                    r7 = "Jx\170\028\017w%\203e\011\235\187"
                                    r9 = 8010276146834
                                    r41 = r2(r7, r9)
                                    state = ReturnVal[r41]
                                    r41 = "UDim"
                                    r2 = _env[r41]
                                    r7 = upvalueValues[upvalues[1]]
                                    r9 = upvalueValues[upvalues[2]]
                                    r20 = "\231(A"
                                    r28 = 9567425597799
                                    r43 = r9(r20, r28)
                                    r41 = r7[r43]
                                    ReturnVal = r2[r41]
                                    r7 = 0
                                    r41 = 1
                                    r2 = ReturnVal(r41, r7)
                                    r23[state] = r2
                                    ReturnVal = upvalueValues[upvalues[1]]
                                    r2 = upvalueValues[upvalues[2]]
                                    r7 = "\255\1947'&G"
                                    r9 = 24926356483415
                                    r41 = r2(r7, r9)
                                    state = ReturnVal[r41]
                                    ReturnVal = upvalueValues[r22]
                                    r23[state] = ReturnVal
                                    r2 = "Instance"
                                    ReturnVal = _env[r2]
                                    r41 = upvalueValues[upvalues[1]]
                                    r7 = upvalueValues[upvalues[2]]
                                    r20 = 5291283270047
                                    r43 = "r\252:"
                                    r9 = r7(r43, r20)
                                    r2 = r41[r9]
                                    state = ReturnVal[r2]
                                    r41 = upvalueValues[upvalues[1]]
                                    r7 = upvalueValues[upvalues[2]]
                                    r20 = 26479148101674
                                    r43 = "\021\217p\188\170c\167\192\138?"
                                    r9 = r7(r43, r20)
                                    r2 = r41[r9]
                                    ReturnVal = state(r2)
                                    r2 = ReturnVal
                                    ReturnVal = upvalueValues[upvalues[1]]
                                    r41 = upvalueValues[upvalues[2]]
                                    r43 = 25138167508409
                                    r9 = "\139@\147\228A"
                                    r7 = r41(r9, r43)
                                    state = ReturnVal[r7]
                                    r7 = "ColorSequence"
                                    r41 = _env[r7]
                                    r9 = upvalueValues[upvalues[1]]
                                    r43 = upvalueValues[upvalues[2]]
                                    r3 = 18363761336679
                                    r28 = "\145P\028"
                                    r20 = r43(r28, r3)
                                    r7 = r9[r20]
                                    ReturnVal = r41[r7]
                                    r20 = "ColorSequenceKeypoint"
                                    r43 = _env[r20]
                                    r28 = upvalueValues[upvalues[1]]
                                    r3 = upvalueValues[upvalues[2]]
                                    r38 = 30097130452671
                                    r26 = "db\147"
                                    r60 = r3(r26, r38)
                                    r20 = r28[r60]
                                    r9 = r43[r20]
                                    r60 = "Color3"
                                    r3 = _env[r60]
                                    r26 = upvalueValues[upvalues[1]]
                                    r38 = upvalueValues[upvalues[2]]
                                    r18 = 1097251537406
                                    r68 = "\251\153#\224\142\175\199"
                                    r54 = r38(r68, r18)
                                    r60 = r26[r54]
                                    r28 = r3[r60]
                                    r26 = 170
                                    r60 = 0
                                    r38 = 255
                                    r3 = {
                                        r28(r60, r26, r38)
                                    }
                                    r20 = 0
                                    r43 = r9(r20, unpack(r3))
                                    r28 = "ColorSequenceKeypoint"
                                    r20 = _env[r28]
                                    r3 = upvalueValues[upvalues[1]]
                                    r60 = upvalueValues[upvalues[2]]
                                    r54 = 15045609216862
                                    r38 = "2*\030"
                                    r26 = r60(r38, r54)
                                    r28 = r3[r26]
                                    r9 = r20[r28]
                                    r26 = "Color3"
                                    r60 = _env[r26]
                                    r38 = upvalueValues[upvalues[1]]
                                    r54 = upvalueValues[upvalues[2]]
                                    r11 = 23328551397999
                                    r18 = "c\186\240#q(\213"
                                    r68 = r54(r18, r11)
                                    r26 = r38[r68]
                                    r3 = r60[r26]
                                    r54 = 255
                                    r38 = 255
                                    r26 = 255
                                    r60 = {
                                        r3(r26, r38, r54)
                                    }
                                    r28 = 1
                                    r20 = {
                                        r9(r28, unpack(r60))
                                    }
                                    r7 = {
                                        r43,
                                        unpack(r20)
                                    }
                                    r41 = ReturnVal(r7)
                                    r2[state] = r41
                                    ReturnVal = upvalueValues[upvalues[1]]
                                    r41 = upvalueValues[upvalues[2]]
                                    r43 = 34179883908652
                                    r9 = "\231\194\197\230\008\234"
                                    r7 = r41(r9, r43)
                                    state = ReturnVal[r7]
                                    ReturnVal = upvalueValues[r22]
                                    r2[state] = ReturnVal
                                    r41 = "UDim2"
                                    ReturnVal = _env[r41]
                                    r7 = upvalueValues[upvalues[1]]
                                    r9 = upvalueValues[upvalues[2]]
                                    r28 = 7881331527254
                                    r20 = "\147n%"
                                    r43 = r9(r20, r28)
                                    r41 = r7[r43]
                                    state = ReturnVal[r41]
                                    r9 = "math"
                                    r7 = _env[r9]
                                    r43 = upvalueValues[upvalues[1]]
                                    r20 = upvalueValues[upvalues[2]]
                                    r3 = "\218\194%\148\1276"
                                    r60 = 23123338013199
                                    r28 = r20(r3, r60)
                                    r9 = r43[r28]
                                    r41 = r7[r9]
                                    r7 = r41()
                                    r20 = "math"
                                    r43 = _env[r20]
                                    r28 = upvalueValues[upvalues[1]]
                                    r3 = upvalueValues[upvalues[2]]
                                    r26 = "?B\141\237A\209"
                                    r38 = 684413616446
                                    r60 = r3(r26, r38)
                                    r20 = r28[r60]
                                    r9 = r43[r20]
                                    r43 = r9()
                                    r41 = 0
                                    r9 = 0
                                    ReturnVal = state(r7, r41, r43, r9)
                                    r41 = ReturnVal
                                    r7 = "UDim2"
                                    ReturnVal = _env[r7]
                                    r9 = upvalueValues[upvalues[1]]
                                    r43 = upvalueValues[upvalues[2]]
                                    r28 = "\242\003\137"
                                    r3 = 15923800726775
                                    r20 = r43(r28, r3)
                                    r7 = r9[r20]
                                    state = ReturnVal[r7]
                                    r43 = "math"
                                    r9 = _env[r43]
                                    r20 = upvalueValues[upvalues[1]]
                                    r28 = upvalueValues[upvalues[2]]
                                    r60 = "0\136\217\150\170\238"
                                    r26 = 1555358089940
                                    r3 = r28(r60, r26)
                                    r43 = r20[r3]
                                    r7 = r9[r43]
                                    r9 = r7()
                                    r28 = "math"
                                    r20 = _env[r28]
                                    r3 = upvalueValues[upvalues[1]]
                                    r60 = upvalueValues[upvalues[2]]
                                    r54 = 21834458671031
                                    r38 = "\018\022\185\160\019\223"
                                    r26 = r60(r38, r54)
                                    r28 = r3[r26]
                                    r43 = r20[r28]
                                    r20 = r43()
                                    r7 = 0
                                    r43 = 0
                                    ReturnVal = state(r9, r7, r20, r43)
                                    state = upvalueValues[r22]
                                    r7 = ReturnVal
                                    r9 = upvalueValues[upvalues[1]]
                                    r43 = upvalueValues[upvalues[2]]
                                    r28 = "\218\025%V$\144\201>"
                                    r3 = 13874073508156
                                    r20 = r43(r28, r3)
                                    ReturnVal = r9[r20]
                                    r9 = r41
                                    state[ReturnVal] = r9
                                    state = upvalueValues[upvalues[4]]
                                    r9 = upvalueValues[r22]
                                    r28 = "TweenInfo"
                                    r20 = _env[r28]
                                    r3 = upvalueValues[upvalues[1]]
                                    r60 = upvalueValues[upvalues[2]]
                                    r54 = 9629780267396
                                    r38 = "\031C\245"
                                    r26 = r60(r38, r54)
                                    r28 = r3[r26]
                                    r43 = r20[r28]
                                    r28 = 0.5
                                    r20 = r43(r28)
                                    r3 = upvalueValues[upvalues[1]]
                                    r60 = upvalueValues[upvalues[2]]
                                    r54 = 10756237382544
                                    r38 = "\0292\143r\147\235\236\231sg\161P\134\189\159<\133V\216\188C\205"
                                    r26 = r60(r38, r54)
                                    r28 = r3[r26]
                                    ReturnVal = "Create"
                                    ReturnVal = state[ReturnVal]
                                    r3 = 0
                                    r43 = {
                                        [r28] = r3
                                    }
                                    ReturnVal = ReturnVal(state, r9, r20, r43)
                                    state = upvalueValues[upvalues[4]]
                                    r43 = upvalueValues[r22]
                                    r9 = ReturnVal
                                    r3 = "TweenInfo"
                                    r28 = _env[r3]
                                    r60 = upvalueValues[upvalues[1]]
                                    r26 = upvalueValues[upvalues[2]]
                                    r68 = 20094056555661
                                    r54 = "\190\007n"
                                    r38 = r26(r54, r68)
                                    r3 = r60[r38]
                                    r20 = r28[r3]
                                    r54 = "Enum"
                                    r38 = _env[r54]
                                    r68 = upvalueValues[upvalues[1]]
                                    r18 = upvalueValues[upvalues[2]]
                                    r49 = "V\147gj~\189O)\184hy"
                                    r25 = 1950574969740
                                    r11 = r18(r49, r25)
                                    r54 = r68[r11]
                                    r26 = r38[r54]
                                    r54 = upvalueValues[upvalues[1]]
                                    r68 = upvalueValues[upvalues[2]]
                                    r49 = 32702203067260
                                    r11 = "\243\225' \154W"
                                    r18 = r68(r11, r49)
                                    r38 = r54[r18]
                                    r60 = r26[r38]
                                    r3 = 2
                                    r28 = r20(r3, r60)
                                    r60 = upvalueValues[upvalues[1]]
                                    r26 = upvalueValues[upvalues[2]]
                                    r54 = "\023\002\171s\006\002xZ"
                                    r68 = 22879202814365
                                    r38 = r26(r54, r68)
                                    r3 = r60[r38]
                                    r26 = upvalueValues[upvalues[1]]
                                    ReturnVal = "Create"
                                    ReturnVal = state[ReturnVal]
                                    r38 = upvalueValues[upvalues[2]]
                                    r18 = 7868101021263
                                    r68 = "\214\221\248\026\166@\149\184"
                                    r54 = r38(r68, r18)
                                    r60 = r26[r54]
                                    r54 = "math"
                                    r38 = _env[r54]
                                    r68 = upvalueValues[upvalues[1]]
                                    r18 = upvalueValues[upvalues[2]]
                                    r25 = 18881272128088
                                    r49 = "\239\219\247\187B\139"
                                    r11 = r18(r49, r25)
                                    r54 = r68[r11]
                                    r26 = r38[r54]
                                    r54 = -30
                                    r68 = 30
                                    r38 = r26(r54, r68)
                                    r20 = {
                                        [r3] = r7,
                                        [r60] = r38
                                    }
                                    ReturnVal = ReturnVal(state, r43, r28, r20)
                                    state = "Play"
                                    state = r9[state]
                                    state = state(r9)
                                    r43 = ReturnVal
                                    state = "Play"
                                    state = r43[state]
                                    state = state(r43)
                                    r20 = "task"
                                    ReturnVal = _env[r20]
                                    r28 = upvalueValues[upvalues[1]]
                                    r3 = upvalueValues[upvalues[2]]
                                    r26 = "&{^S\225"
                                    r38 = 35160013144052
                                    r60 = r3(r26, r38)
                                    r20 = r28[r60]
                                    state = ReturnVal[r20]
                                    r28 = createClosure1(240, {
                                        r22,
                                        upvalues[1],
                                        upvalues[2],
                                        upvalues[4]
                                    })
                                    r20 = 2
                                    ReturnVal = state(r20, r28)
                                    ReturnVal = {
                                        r9,
                                        r43
                                    }
                                    state = nil
                                end
                            end
                        else
                            if state <= 171 then
                                if state <= 154 then
                                    -- createClosure3 entry 8361491 -> 151, states 151-154
                                    if state <= 152 then
                                        if state <= 151 then
                                            if state == 151 then -- entry 8361491 -> 151
                                                state = {}
                                                r22 = state
                                                r23 = 10
                                                r2 = r23
                                                r23 = 1
                                                r41 = r23
                                                r23 = 0
                                                r7 = r41 < r23
                                                ReturnVal = 1
                                                r23 = ReturnVal - r41
                                                state = 152
                                            end
                                        else
                                            if state == 152 then
                                                r9 = not r7
                                                r23 = r23 + r41
                                                ReturnVal = r23 <= r2
                                                ReturnVal = r9 and ReturnVal
                                                r9 = r23 >= r2
                                                r9 = r7 and r9
                                                ReturnVal = r9 or ReturnVal
                                                r9 = (153)
                                                state = ReturnVal and r9
                                                ReturnVal = (154)
                                                state = state or ReturnVal
                                            end
                                        end
                                    else
                                        if state <= 153 then
                                            if state == 153 then
                                                r9 = r23
                                                r43 = "Instance"
                                                ReturnVal = _env[r43]
                                                r20 = upvalueValues[upvalues[1]]
                                                r28 = upvalueValues[upvalues[2]]
                                                r60 = "T\141@"
                                                r26 = 24234443648021
                                                r3 = r28(r60, r26)
                                                r43 = r20[r3]
                                                state = ReturnVal[r43]
                                                r60 = "\162A\187\239\188"
                                                r20 = upvalueValues[upvalues[1]]
                                                r28 = upvalueValues[upvalues[2]]
                                                r26 = 19320277607204
                                                r3 = r28(r60, r26)
                                                r60 = "t\192\133H"
                                                r43 = r20[r3]
                                                ReturnVal = state(r43)
                                                r43 = allocUpvalue()
                                                upvalueValues[r43] = ReturnVal
                                                state = upvalueValues[r43]
                                                r20 = upvalueValues[upvalues[1]]
                                                r28 = upvalueValues[upvalues[2]]
                                                r26 = 22253282257018
                                                r3 = r28(r60, r26)
                                                ReturnVal = r20[r3]
                                                r3 = "UDim2"
                                                r28 = _env[r3]
                                                r60 = upvalueValues[upvalues[1]]
                                                r26 = upvalueValues[upvalues[2]]
                                                r54 = "y\230\235"
                                                r68 = 14188239067598
                                                r38 = r26(r54, r68)
                                                r3 = r60[r38]
                                                r60 = 0
                                                r20 = r28[r3]
                                                r3 = 0.02
                                                r26 = 0.02
                                                r38 = 0
                                                r28 = r20(r3, r60, r26, r38)
                                                state[ReturnVal] = r28
                                                state = upvalueValues[r43]
                                                r20 = upvalueValues[upvalues[1]]
                                                r28 = upvalueValues[upvalues[2]]
                                                r60 = "f\012\142\154'\158@\133\213\021N\226d\004\240\246"
                                                r26 = 2499666838667
                                                r3 = r28(r60, r26)
                                                ReturnVal = r20[r3]
                                                r3 = "Color3"
                                                r28 = _env[r3]
                                                r60 = upvalueValues[upvalues[1]]
                                                r26 = upvalueValues[upvalues[2]]
                                                r54 = "\230G\232w\237\028s"
                                                r68 = 17166040620857
                                                r38 = r26(r54, r68)
                                                r3 = r60[r38]
                                                r60 = 255
                                                r20 = r28[r3]
                                                r3 = 255
                                                r26 = 255
                                                r28 = r20(r3, r60, r26)
                                                state[ReturnVal] = r28
                                                state = upvalueValues[r43]
                                                r20 = upvalueValues[upvalues[1]]
                                                r28 = upvalueValues[upvalues[2]]
                                                r60 = "\236\1649C[\231\0316\134\146\127\193\005\168x\161>(\188\244\002\r"
                                                r26 = 15285490605005
                                                r3 = r28(r60, r26)
                                                ReturnVal = r20[r3]
                                                r20 = 0.5
                                                state[ReturnVal] = r20
                                                state = upvalueValues[r43]
                                                r20 = upvalueValues[upvalues[1]]
                                                r28 = upvalueValues[upvalues[2]]
                                                r60 = "\022\209N~6\141\188\134"
                                                r26 = 17545276055530
                                                r3 = r28(r60, r26)
                                                ReturnVal = r20[r3]
                                                r3 = "UDim2"
                                                r28 = _env[r3]
                                                r60 = upvalueValues[upvalues[1]]
                                                r26 = upvalueValues[upvalues[2]]
                                                r54 = "\017P\167"
                                                r68 = 5310219913640
                                                r38 = r26(r54, r68)
                                                r3 = r60[r38]
                                                r20 = r28[r3]
                                                r3 = 0.475
                                                r60 = 0
                                                r38 = 0
                                                r26 = 0.475
                                                r28 = r20(r3, r60, r26, r38)
                                                r60 = "\213\170Y\159\1496"
                                                state[ReturnVal] = r28
                                                state = upvalueValues[r43]
                                                r20 = upvalueValues[upvalues[1]]
                                                r28 = upvalueValues[upvalues[2]]
                                                r26 = 14281002408442
                                                r3 = r28(r60, r26)
                                                ReturnVal = r20[r3]
                                                r20 = upvalueValues[upvalues[3]]
                                                state[ReturnVal] = r20
                                                r20 = "Instance"
                                                ReturnVal = _env[r20]
                                                r28 = upvalueValues[upvalues[1]]
                                                r3 = upvalueValues[upvalues[2]]
                                                r38 = 25426607582784
                                                r26 = "\208\169\157"
                                                r60 = r3(r26, r38)
                                                r20 = r28[r60]
                                                state = ReturnVal[r20]
                                                r28 = upvalueValues[upvalues[1]]
                                                r3 = upvalueValues[upvalues[2]]
                                                r26 = "\160\130\129\204/t\165\210"
                                                r38 = 28433557943224
                                                r60 = r3(r26, r38)
                                                r20 = r28[r60]
                                                ReturnVal = state(r20)
                                                r20 = ReturnVal
                                                r60 = "\237\169c\209O(\005t\144b\184\181"
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r28 = upvalueValues[upvalues[2]]
                                                r26 = 14965416041272
                                                r3 = r28(r60, r26)
                                                state = ReturnVal[r3]
                                                r3 = "UDim"
                                                r28 = _env[r3]
                                                r60 = upvalueValues[upvalues[1]]
                                                r26 = upvalueValues[upvalues[2]]
                                                r68 = 6166036204343
                                                r54 = "\155JB"
                                                r38 = r26(r54, r68)
                                                r3 = r60[r38]
                                                ReturnVal = r28[r3]
                                                r60 = 0
                                                r3 = 1
                                                r28 = ReturnVal(r3, r60)
                                                r60 = "\182BJ\169xS"
                                                r20[state] = r28
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r28 = upvalueValues[upvalues[2]]
                                                r26 = 29988916033164
                                                r3 = r28(r60, r26)
                                                state = ReturnVal[r3]
                                                r28 = "Instance"
                                                ReturnVal = upvalueValues[r43]
                                                r20[state] = ReturnVal
                                                ReturnVal = _env[r28]
                                                r3 = upvalueValues[upvalues[1]]
                                                r60 = upvalueValues[upvalues[2]]
                                                r38 = "VZl"
                                                r54 = 1615502607088
                                                r26 = r60(r38, r54)
                                                r28 = r3[r26]
                                                state = ReturnVal[r28]
                                                r3 = upvalueValues[upvalues[1]]
                                                r60 = upvalueValues[upvalues[2]]
                                                r38 = "){\216\236tA\157t\135\243"
                                                r54 = 20040109728883
                                                r26 = r60(r38, r54)
                                                r28 = r3[r26]
                                                ReturnVal = state(r28)
                                                r28 = ReturnVal
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r3 = upvalueValues[upvalues[2]]
                                                r38 = 4434324195344
                                                r26 = "\248\168\247\182\197"
                                                r60 = r3(r26, r38)
                                                state = ReturnVal[r60]
                                                r60 = "ColorSequence"
                                                r3 = _env[r60]
                                                r26 = upvalueValues[upvalues[1]]
                                                r38 = upvalueValues[upvalues[2]]
                                                r18 = 12371739989633
                                                r68 = "\020\027W"
                                                r54 = r38(r68, r18)
                                                r60 = r26[r54]
                                                ReturnVal = r3[r60]
                                                r54 = "ColorSequenceKeypoint"
                                                r38 = _env[r54]
                                                r68 = upvalueValues[upvalues[1]]
                                                r18 = upvalueValues[upvalues[2]]
                                                r49 = "\202Q\170"
                                                r25 = 4949794179328
                                                r11 = r18(r49, r25)
                                                r54 = r68[r11]
                                                r26 = r38[r54]
                                                r11 = "Color3"
                                                r18 = _env[r11]
                                                r49 = upvalueValues[upvalues[1]]
                                                r25 = upvalueValues[upvalues[2]]
                                                r31 = "\159\216\026r\239.\196"
                                                r21 = 6384899165085
                                                r65 = r25(r31, r21)
                                                r11 = r49[r65]
                                                r68 = r18[r11]
                                                r49 = 255
                                                r25 = 100
                                                r11 = 0
                                                r18 = {
                                                    r68(r11, r49, r25)
                                                }
                                                r54 = 0
                                                r38 = r26(r54, unpack(r18))
                                                r68 = "ColorSequenceKeypoint"
                                                r54 = _env[r68]
                                                r18 = upvalueValues[upvalues[1]]
                                                r11 = upvalueValues[upvalues[2]]
                                                r65 = 9889570951677
                                                r25 = "\214\004\173"
                                                r49 = r11(r25, r65)
                                                r68 = r18[r49]
                                                r26 = r54[r68]
                                                r49 = "Color3"
                                                r11 = _env[r49]
                                                r25 = upvalueValues[upvalues[1]]
                                                r65 = upvalueValues[upvalues[2]]
                                                r35 = 27828996993694
                                                r21 = "8\004\195\149\143\172k"
                                                r31 = r65(r21, r35)
                                                r49 = r25[r31]
                                                r18 = r11[r49]
                                                r65 = 255
                                                r25 = 255
                                                r49 = 255
                                                r11 = {
                                                    r18(r49, r25, r65)
                                                }
                                                r68 = 1
                                                r54 = {
                                                    r26(r68, unpack(r11))
                                                }
                                                r60 = {
                                                    r38,
                                                    unpack(r54)
                                                }
                                                r3 = ReturnVal(r60)
                                                r28[state] = r3
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r3 = upvalueValues[upvalues[2]]
                                                r26 = "\026A\143\146\206\207"
                                                r38 = 14253000202733
                                                r60 = r3(r26, r38)
                                                state = ReturnVal[r60]
                                                r3 = "Vector2"
                                                ReturnVal = upvalueValues[r43]
                                                r68 = 28770843079765
                                                r18 = "\246\006Y\234p\173"
                                                r33 = 20936285038101
                                                r35 = 27112725197137
                                                r12 = "o"
                                                r11 = 27804638032531
                                                r25 = 14977551637310
                                                r9 = nil
                                                r28[state] = ReturnVal
                                                ReturnVal = _env[r3]
                                                r60 = upvalueValues[upvalues[1]]
                                                r26 = upvalueValues[upvalues[2]]
                                                r54 = "\014|7"
                                                r38 = r26(r54, r68)
                                                r3 = r60[r38]
                                                state = ReturnVal[r3]
                                                r26 = "math"
                                                r60 = _env[r26]
                                                r38 = upvalueValues[upvalues[1]]
                                                r54 = upvalueValues[upvalues[2]]
                                                r68 = r54(r18, r11)
                                                r26 = r38[r68]
                                                r3 = r60[r26]
                                                r26 = -50
                                                r38 = 50
                                                r60 = r3(r26, r38)
                                                r38 = "math"
                                                r26 = _env[r38]
                                                r54 = upvalueValues[upvalues[1]]
                                                r68 = upvalueValues[upvalues[2]]
                                                r49 = 20271718376671
                                                r11 = "S$\014\139\147\176"
                                                r18 = r68(r11, r49)
                                                r38 = r54[r18]
                                                r3 = r26[r38]
                                                r38 = -50
                                                r54 = 50
                                                r26 = {
                                                    r3(r38, r54)
                                                }
                                                ReturnVal = state(r60, unpack(r26))
                                                r3 = ReturnVal
                                                state = upvalueValues[upvalues[4]]
                                                r60 = upvalueValues[r43]
                                                r54 = "TweenInfo"
                                                r38 = _env[r54]
                                                r68 = upvalueValues[upvalues[1]]
                                                r18 = upvalueValues[upvalues[2]]
                                                r49 = "\001\235\243"
                                                r11 = r18(r49, r25)
                                                r54 = r68[r11]
                                                r26 = r38[r54]
                                                r49 = "Enum"
                                                r11 = _env[r49]
                                                r25 = upvalueValues[upvalues[1]]
                                                r65 = upvalueValues[upvalues[2]]
                                                r21 = "\158\208\011n\255\190\223\235,\149v"
                                                r31 = r65(r21, r35)
                                                r49 = r25[r31]
                                                r18 = r11[r49]
                                                r49 = upvalueValues[upvalues[1]]
                                                r25 = upvalueValues[upvalues[2]]
                                                r31 = "G\140\163\189"
                                                r21 = 34300712697444
                                                r65 = r25(r31, r21)
                                                r11 = r49[r65]
                                                r68 = r18[r11]
                                                r25 = "Enum"
                                                r49 = _env[r25]
                                                r65 = upvalueValues[upvalues[1]]
                                                r31 = upvalueValues[upvalues[2]]
                                                r55 = 10751685809038
                                                r35 = "\022-\004`\225\011w\215\160~x\229\160\183>"
                                                r21 = r31(r35, r55)
                                                r25 = r65[r21]
                                                r11 = r49[r25]
                                                r25 = upvalueValues[upvalues[1]]
                                                r65 = upvalueValues[upvalues[2]]
                                                r35 = 16162796756326
                                                r21 = "\004+\132"
                                                r31 = r65(r21, r35)
                                                r49 = r25[r31]
                                                r18 = r11[r49]
                                                r54 = 0.8
                                                r38 = r26(r54, r68, r18)
                                                r68 = upvalueValues[upvalues[1]]
                                                r18 = upvalueValues[upvalues[2]]
                                                r49 = "\230\020\150\159\"\255\201&"
                                                r25 = 18436618199433
                                                r11 = r18(r49, r25)
                                                r54 = r68[r11]
                                                r11 = upvalueValues[r43]
                                                r25 = upvalueValues[upvalues[1]]
                                                r65 = upvalueValues[upvalues[2]]
                                                r21 = "\002\148e-\158\239\147\171"
                                                r35 = 33004968066057
                                                r31 = r65(r21, r35)
                                                r49 = r25[r31]
                                                r18 = r11[r49]
                                                r25 = "UDim2"
                                                r49 = _env[r25]
                                                r65 = upvalueValues[upvalues[1]]
                                                r31 = upvalueValues[upvalues[2]]
                                                r35 = "\133i\212"
                                                r55 = 30351035823925
                                                r21 = r31(r35, r55)
                                                r25 = r65[r21]
                                                r11 = r49[r25]
                                                r21 = upvalueValues[upvalues[1]]
                                                r35 = upvalueValues[upvalues[2]]
                                                r14 = "w"
                                                r55 = r35(r14, r33)
                                                r31 = r21[r55]
                                                r65 = r3[r31]
                                                r55 = upvalueValues[upvalues[1]]
                                                ReturnVal = "Create"
                                                ReturnVal = state[ReturnVal]
                                                r14 = upvalueValues[upvalues[2]]
                                                r1 = 14986636581698
                                                r33 = r14(r12, r1)
                                                r35 = r55[r33]
                                                r21 = r3[r35]
                                                r25 = 0
                                                r31 = 0
                                                r49 = r11(r25, r65, r31, r21)
                                                r68 = r18 + r49
                                                r11 = upvalueValues[upvalues[1]]
                                                r49 = upvalueValues[upvalues[2]]
                                                r31 = 10452154323715
                                                r65 = "\t\225a\180$\247T\235\240T\250\157[\254\026\141T \192d\176 "
                                                r25 = r49(r65, r31)
                                                r18 = r11[r25]
                                                r11 = 1
                                                r26 = {
                                                    [r54] = r68,
                                                    [r18] = r11
                                                }
                                                ReturnVal = ReturnVal(state, r60, r38, r26)
                                                r60 = ReturnVal
                                                state = "Play"
                                                state = r60[state]
                                                state = state(r60)
                                                r11 = 3297188988415
                                                r26 = "table"
                                                ReturnVal = _env[r26]
                                                r38 = upvalueValues[upvalues[1]]
                                                r18 = "\015E3\204vR"
                                                r54 = upvalueValues[upvalues[2]]
                                                r20 = nil
                                                r68 = r54(r18, r11)
                                                r26 = r38[r68]
                                                state = ReturnVal[r26]
                                                ReturnVal = state(r22, r60)
                                                r26 = "task"
                                                ReturnVal = _env[r26]
                                                r38 = upvalueValues[upvalues[1]]
                                                r54 = upvalueValues[upvalues[2]]
                                                r18 = "\223M\028u\246"
                                                r11 = 20296856511723
                                                r68 = r54(r18, r11)
                                                r26 = r38[r68]
                                                state = ReturnVal[r26]
                                                r28 = nil
                                                r3 = nil
                                                r60 = nil
                                                r38 = createClosure1(245, {
                                                    r43,
                                                    upvalues[1],
                                                    upvalues[2]
                                                })
                                                r26 = 0.8
                                                ReturnVal = state(r26, r38)
                                                r43 = releaseUpvalue(r43)
                                                state = 152
                                            end
                                        else
                                            if state == 154 then
                                                ReturnVal = {
                                                    r22
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure0 entry 958796 -> 155, states 155-171
                                    if state <= 163 then
                                        if state <= 159 then
                                            if state <= 157 then
                                                if state <= 156 then
                                                    if state <= 155 then
                                                        if state == 155 then -- entry 958796 -> 155
                                                            r22 = "Instance"
                                                            ReturnVal = _env[r22]
                                                            r23 = upvalueValues[upvalues[1]]
                                                            r2 = upvalueValues[upvalues[2]]
                                                            r7 = "\132(\143"
                                                            r9 = 28723796571199
                                                            r41 = r2(r7, r9)
                                                            r22 = r23[r41]
                                                            state = ReturnVal[r22]
                                                            r23 = upvalueValues[upvalues[1]]
                                                            r2 = upvalueValues[upvalues[2]]
                                                            r9 = 13546042349731
                                                            r7 = "\t:iP\181"
                                                            r41 = r2(r7, r9)
                                                            r22 = r23[r41]
                                                            ReturnVal = state(r22)
                                                            r22 = ReturnVal
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r23 = upvalueValues[upvalues[2]]
                                                            r41 = "\253B<_\247\179Z"
                                                            r7 = 4514200684598
                                                            r2 = r23(r41, r7)
                                                            state = ReturnVal[r2]
                                                            r23 = upvalueValues[upvalues[1]]
                                                            r2 = upvalueValues[upvalues[2]]
                                                            r9 = 34889832791926
                                                            r7 = "\200\228x*iJJt%F\015\229+\146\158\182'\191\219\252\230\152)\249is(#"
                                                            r41 = r2(r7, r9)
                                                            ReturnVal = r23[r41]
                                                            r22[state] = ReturnVal
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r23 = upvalueValues[upvalues[2]]
                                                            r7 = 8350586277680
                                                            r41 = "\169^\025\252\238\r"
                                                            r2 = r23(r41, r7)
                                                            state = ReturnVal[r2]
                                                            ReturnVal = 1
                                                            r22[state] = ReturnVal
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r23 = upvalueValues[upvalues[2]]
                                                            r7 = 6129703291686
                                                            r41 = "\253\140\171\129\150k"
                                                            r2 = r23(r41, r7)
                                                            state = ReturnVal[r2]
                                                            ReturnVal = upvalueValues[upvalues[3]]
                                                            r22[state] = ReturnVal
                                                            state = "Play"
                                                            state = r22[state]
                                                            state = state(r22)
                                                            r2 = 10
                                                            r41 = r2
                                                            state = {}
                                                            r23 = state
                                                            r2 = 1
                                                            r7 = r2
                                                            r2 = 0
                                                            r9 = r7 < r2
                                                            ReturnVal = 1
                                                            r2 = ReturnVal - r7
                                                            state = 156
                                                        end
                                                    else
                                                        if state == 156 then
                                                            r2 = r2 + r7
                                                            ReturnVal = r2 <= r41
                                                            r43 = not r9
                                                            ReturnVal = r43 and ReturnVal
                                                            r43 = r2 >= r41
                                                            r43 = r9 and r43
                                                            ReturnVal = r43 or ReturnVal
                                                            r43 = (157)
                                                            state = ReturnVal and r43
                                                            ReturnVal = (158)
                                                            state = state or ReturnVal
                                                        end
                                                    end
                                                else
                                                    if state == 157 then
                                                        r43 = r2
                                                        r20 = "UDim2"
                                                        ReturnVal = _env[r20]
                                                        r28 = upvalueValues[upvalues[1]]
                                                        r3 = upvalueValues[upvalues[2]]
                                                        r26 = "-\233w"
                                                        r38 = 19745570415594
                                                        r60 = r3(r26, r38)
                                                        r20 = r28[r60]
                                                        state = ReturnVal[r20]
                                                        r60 = "math"
                                                        r3 = _env[r60]
                                                        r20 = 0
                                                        r26 = upvalueValues[upvalues[1]]
                                                        r38 = upvalueValues[upvalues[2]]
                                                        r68 = "\139.\171\231<\015"
                                                        r18 = 12784910473025
                                                        r54 = r38(r68, r18)
                                                        r60 = r26[r54]
                                                        r28 = r3[r60]
                                                        r60 = -15
                                                        r26 = 15
                                                        r3 = r28(r60, r26)
                                                        r38 = "math"
                                                        r26 = _env[r38]
                                                        r28 = 0
                                                        r54 = upvalueValues[upvalues[1]]
                                                        r68 = upvalueValues[upvalues[2]]
                                                        r11 = "9\243\189q\130\183"
                                                        r49 = 18501443281319
                                                        r18 = r68(r11, r49)
                                                        r38 = r54[r18]
                                                        r60 = r26[r38]
                                                        r38 = -15
                                                        r54 = 15
                                                        r26 = {
                                                            r60(r38, r54)
                                                        }
                                                        ReturnVal = state(r20, r3, r28, unpack(r26))
                                                        r20 = ReturnVal
                                                        r49 = 19169809638110
                                                        r31 = "\162\r\209\171\029\231\138\217[.7"
                                                        r28 = "math"
                                                        ReturnVal = _env[r28]
                                                        r3 = upvalueValues[upvalues[1]]
                                                        r60 = upvalueValues[upvalues[2]]
                                                        r54 = 24695364594923
                                                        r38 = "Y&\243\230y\200"
                                                        r26 = r60(r38, r54)
                                                        r28 = r3[r26]
                                                        r38 = "TweenInfo"
                                                        r43 = nil
                                                        r3 = 15
                                                        state = ReturnVal[r28]
                                                        r28 = -15
                                                        ReturnVal = state(r28, r3)
                                                        r28 = ReturnVal
                                                        state = upvalueValues[upvalues[4]]
                                                        r3 = upvalueValues[upvalues[3]]
                                                        r26 = _env[r38]
                                                        r54 = upvalueValues[upvalues[1]]
                                                        r68 = upvalueValues[upvalues[2]]
                                                        r11 = "\025!\139"
                                                        r18 = r68(r11, r49)
                                                        r38 = r54[r18]
                                                        r60 = r26[r38]
                                                        r11 = "Enum"
                                                        r18 = _env[r11]
                                                        r49 = upvalueValues[upvalues[1]]
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r21 = 28391014232996
                                                        r65 = r25(r31, r21)
                                                        r11 = r49[r65]
                                                        r68 = r18[r11]
                                                        r11 = upvalueValues[upvalues[1]]
                                                        r49 = upvalueValues[upvalues[2]]
                                                        r31 = 17339989483402
                                                        r65 = "G,\138i"
                                                        r25 = r49(r65, r31)
                                                        r18 = r11[r25]
                                                        r54 = r68[r18]
                                                        r49 = "Enum"
                                                        r11 = _env[r49]
                                                        r25 = upvalueValues[upvalues[1]]
                                                        r65 = upvalueValues[upvalues[2]]
                                                        r35 = 33422809840843
                                                        r21 = "\020\141f\149\231\181R \016\159\232\233+2["
                                                        r31 = r65(r21, r35)
                                                        r49 = r25[r31]
                                                        r18 = r11[r49]
                                                        r49 = upvalueValues[upvalues[1]]
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r31 = "yt\227H\223"
                                                        r21 = 21977485207546
                                                        r65 = r25(r31, r21)
                                                        r11 = r49[r65]
                                                        r68 = r18[r11]
                                                        r38 = 0.05
                                                        r26 = r60(r38, r54, r68)
                                                        r54 = upvalueValues[upvalues[1]]
                                                        r68 = upvalueValues[upvalues[2]]
                                                        r49 = 9960255410718
                                                        r11 = "\165oa\212\179\144\193\200"
                                                        r18 = r68(r11, r49)
                                                        r38 = r54[r18]
                                                        r18 = upvalueValues[upvalues[3]]
                                                        r49 = upvalueValues[upvalues[1]]
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r21 = 18510156112299
                                                        r31 = "\221?\016\131\202\134\245n"
                                                        r65 = r25(r31, r21)
                                                        r11 = r49[r65]
                                                        r68 = r18[r11]
                                                        r54 = r68 + r20
                                                        ReturnVal = "Create"
                                                        r25 = "\018\147P\156-\169\023{"
                                                        r20 = nil
                                                        r18 = upvalueValues[upvalues[1]]
                                                        r11 = upvalueValues[upvalues[2]]
                                                        r65 = 1770664756024
                                                        r49 = r11(r25, r65)
                                                        ReturnVal = state[ReturnVal]
                                                        r68 = r18[r49]
                                                        r60 = {
                                                            [r38] = r54,
                                                            [r68] = r28
                                                        }
                                                        ReturnVal = ReturnVal(state, r3, r26, r60)
                                                        r3 = ReturnVal
                                                        state = "Play"
                                                        r60 = "table"
                                                        r28 = nil
                                                        state = r3[state]
                                                        state = state(r3)
                                                        ReturnVal = _env[r60]
                                                        r26 = upvalueValues[upvalues[1]]
                                                        r38 = upvalueValues[upvalues[2]]
                                                        r68 = "zz\025\r\027K"
                                                        r18 = 1888608502639
                                                        r54 = r38(r68, r18)
                                                        r60 = r26[r54]
                                                        state = ReturnVal[r60]
                                                        ReturnVal = state(r23, r3)
                                                        r68 = "\144\217\225\006"
                                                        r3 = nil
                                                        r60 = "task"
                                                        ReturnVal = _env[r60]
                                                        r26 = upvalueValues[upvalues[1]]
                                                        r38 = upvalueValues[upvalues[2]]
                                                        r18 = 17626496720911
                                                        r54 = r38(r68, r18)
                                                        r60 = r26[r54]
                                                        state = ReturnVal[r60]
                                                        r60 = 0.05
                                                        ReturnVal = state(r60)
                                                        state = 156
                                                    end
                                                end
                                            else
                                                if state <= 158 then
                                                    if state == 158 then
                                                        state = upvalueValues[upvalues[4]]
                                                        r2 = upvalueValues[upvalues[3]]
                                                        r9 = "TweenInfo"
                                                        r7 = _env[r9]
                                                        r43 = upvalueValues[upvalues[1]]
                                                        r20 = upvalueValues[upvalues[2]]
                                                        r3 = "\230\2376"
                                                        r60 = 12522350565063
                                                        r28 = r20(r3, r60)
                                                        r9 = r43[r28]
                                                        r41 = r7[r9]
                                                        r3 = "Enum"
                                                        r28 = _env[r3]
                                                        r60 = upvalueValues[upvalues[1]]
                                                        r26 = upvalueValues[upvalues[2]]
                                                        r54 = "\211\206\239o\161k\248^z\144\169"
                                                        r68 = 18051405258965
                                                        r38 = r26(r54, r68)
                                                        r3 = r60[r38]
                                                        r20 = r28[r3]
                                                        r3 = upvalueValues[upvalues[1]]
                                                        r60 = upvalueValues[upvalues[2]]
                                                        r54 = 878742815129
                                                        r38 = "\232\250\015\014"
                                                        r26 = r60(r38, r54)
                                                        r28 = r3[r26]
                                                        r43 = r20[r28]
                                                        r60 = "Enum"
                                                        r3 = _env[r60]
                                                        r26 = upvalueValues[upvalues[1]]
                                                        r38 = upvalueValues[upvalues[2]]
                                                        r18 = 10342946525904
                                                        r68 = "$\198\146\237L\202\243\204N\026/\001\203=\246"
                                                        r54 = r38(r68, r18)
                                                        r60 = r26[r54]
                                                        r28 = r3[r60]
                                                        r60 = upvalueValues[upvalues[1]]
                                                        r26 = upvalueValues[upvalues[2]]
                                                        ReturnVal = "Create"
                                                        ReturnVal = state[ReturnVal]
                                                        r54 = "\030\246\138"
                                                        r68 = 13218068977675
                                                        r38 = r26(r54, r68)
                                                        r3 = r60[r38]
                                                        r20 = r28[r3]
                                                        r9 = 0.2
                                                        r7 = r41(r9, r43, r20)
                                                        r43 = upvalueValues[upvalues[1]]
                                                        r20 = upvalueValues[upvalues[2]]
                                                        r60 = 21815027869614
                                                        r3 = "\154\203\201\145\023\250\005~"
                                                        r28 = r20(r3, r60)
                                                        r9 = r43[r28]
                                                        r28 = "UDim2"
                                                        r20 = _env[r28]
                                                        r3 = upvalueValues[upvalues[1]]
                                                        r60 = upvalueValues[upvalues[2]]
                                                        r54 = 25329583123987
                                                        r38 = "\181\t-"
                                                        r26 = r60(r38, r54)
                                                        r28 = r3[r26]
                                                        r43 = r20[r28]
                                                        r3 = 0
                                                        r60 = 0.6
                                                        r26 = 0
                                                        r28 = 0.5
                                                        r20 = r43(r28, r3, r60, r26)
                                                        r28 = upvalueValues[upvalues[1]]
                                                        r3 = upvalueValues[upvalues[2]]
                                                        r38 = 23670223317774
                                                        r26 = "\250\166\162h\025F\029\209"
                                                        r60 = r3(r26, r38)
                                                        r43 = r28[r60]
                                                        r28 = 0
                                                        r41 = {
                                                            [r9] = r20,
                                                            [r43] = r28
                                                        }
                                                        ReturnVal = ReturnVal(state, r2, r7, r41)
                                                        r2 = ReturnVal
                                                        state = "Play"
                                                        state = r2[state]
                                                        state = state(r2)
                                                        r41 = "task"
                                                        ReturnVal = _env[r41]
                                                        r7 = upvalueValues[upvalues[1]]
                                                        r9 = upvalueValues[upvalues[2]]
                                                        r28 = 25112216858029
                                                        r20 = "\212>rD"
                                                        r43 = r9(r20, r28)
                                                        r41 = r7[r43]
                                                        state = ReturnVal[r41]
                                                        r41 = 0.2
                                                        ReturnVal = state(r41)
                                                        state = {}
                                                        r41 = state
                                                        state = {}
                                                        r7 = state
                                                        r9 = 80
                                                        r43 = r9
                                                        r9 = 1
                                                        r20 = r9
                                                        r9 = 0
                                                        r28 = r20 < r9
                                                        ReturnVal = 1
                                                        r9 = ReturnVal - r20
                                                        state = 159
                                                    end
                                                else
                                                    if state == 159 then
                                                        r9 = r9 + r20
                                                        r3 = not r28
                                                        ReturnVal = r9 <= r43
                                                        ReturnVal = r3 and ReturnVal
                                                        r3 = r9 >= r43
                                                        r3 = r28 and r3
                                                        ReturnVal = r3 or ReturnVal
                                                        r3 = (160)
                                                        state = ReturnVal and r3
                                                        ReturnVal = (161)
                                                        state = state or ReturnVal
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 161 then
                                                if state <= 160 then
                                                    if state == 160 then
                                                        r60 = "Instance"
                                                        ReturnVal = _env[r60]
                                                        r26 = upvalueValues[upvalues[1]]
                                                        r38 = upvalueValues[upvalues[2]]
                                                        r68 = "/\250\210"
                                                        r18 = 10442067530494
                                                        r54 = r38(r68, r18)
                                                        r60 = r26[r54]
                                                        state = ReturnVal[r60]
                                                        r26 = upvalueValues[upvalues[1]]
                                                        r38 = upvalueValues[upvalues[2]]
                                                        r18 = 13219007961099
                                                        r68 = "R\223\253\001\172"
                                                        r54 = r38(r68, r18)
                                                        r60 = r26[r54]
                                                        ReturnVal = state(r60)
                                                        r60 = allocUpvalue()
                                                        upvalueValues[r60] = ReturnVal
                                                        state = upvalueValues[r60]
                                                        r26 = upvalueValues[upvalues[1]]
                                                        r38 = upvalueValues[upvalues[2]]
                                                        r18 = 18651641340397
                                                        r68 = "\198\155\240\171"
                                                        r54 = r38(r68, r18)
                                                        ReturnVal = r26[r54]
                                                        r54 = "UDim2"
                                                        r38 = _env[r54]
                                                        r68 = upvalueValues[upvalues[1]]
                                                        r18 = upvalueValues[upvalues[2]]
                                                        r49 = "\192?\217"
                                                        r25 = 23988109880226
                                                        r11 = r18(r49, r25)
                                                        r54 = r68[r11]
                                                        r26 = r38[r54]
                                                        r11 = "math"
                                                        r18 = _env[r11]
                                                        r49 = upvalueValues[upvalues[1]]
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r31 = "\201\141\011\230\017J"
                                                        r21 = 17733208645697
                                                        r65 = r25(r31, r21)
                                                        r11 = r49[r65]
                                                        r68 = r18[r11]
                                                        r49 = 10
                                                        r11 = 1
                                                        r18 = r68(r11, r49)
                                                        r68 = 100
                                                        r54 = r18 / r68
                                                        r25 = "math"
                                                        r49 = _env[r25]
                                                        r65 = upvalueValues[upvalues[1]]
                                                        r31 = upvalueValues[upvalues[2]]
                                                        r35 = "\173\224]P\218`"
                                                        r55 = 18357102027108
                                                        r21 = r31(r35, r55)
                                                        r25 = r65[r21]
                                                        r11 = r49[r25]
                                                        r65 = 10
                                                        r25 = 1
                                                        r49 = r11(r25, r65)
                                                        r11 = 100
                                                        r18 = r49 / r11
                                                        r68 = 0
                                                        r11 = 0
                                                        r38 = r26(r54, r68, r18, r11)
                                                        state[ReturnVal] = r38
                                                        state = upvalueValues[r60]
                                                        r26 = upvalueValues[upvalues[1]]
                                                        r38 = upvalueValues[upvalues[2]]
                                                        r18 = 32338696157906
                                                        r68 = "\0220\148Y1\027\186\248"
                                                        r54 = r38(r68, r18)
                                                        ReturnVal = r26[r54]
                                                        r54 = "UDim2"
                                                        r38 = _env[r54]
                                                        r68 = upvalueValues[upvalues[1]]
                                                        r18 = upvalueValues[upvalues[2]]
                                                        r49 = "Y&\144"
                                                        r25 = 23862911937384
                                                        r11 = r18(r49, r25)
                                                        r54 = r68[r11]
                                                        r26 = r38[r54]
                                                        r49 = "math"
                                                        r11 = _env[r49]
                                                        r25 = upvalueValues[upvalues[1]]
                                                        r65 = upvalueValues[upvalues[2]]
                                                        r21 = "\152N]@#\219"
                                                        r35 = 2918300337486
                                                        r31 = r65(r21, r35)
                                                        r49 = r25[r31]
                                                        r18 = r11[r49]
                                                        r11 = r18()
                                                        r18 = 0.8
                                                        r68 = r11 * r18
                                                        r18 = 0.1
                                                        r54 = r68 + r18
                                                        r65 = "math"
                                                        r25 = _env[r65]
                                                        r31 = upvalueValues[upvalues[1]]
                                                        r21 = upvalueValues[upvalues[2]]
                                                        r55 = "\130[\n\193\230."
                                                        r14 = 9939234525716
                                                        r35 = r21(r55, r14)
                                                        r65 = r31[r35]
                                                        r49 = r25[r65]
                                                        r25 = r49()
                                                        r49 = 0.8
                                                        r11 = r25 * r49
                                                        r49 = 0.1
                                                        r18 = r11 + r49
                                                        r68 = 0
                                                        r11 = 0
                                                        r38 = r26(r54, r68, r18, r11)
                                                        state[ReturnVal] = r38
                                                        state = upvalueValues[r60]
                                                        r26 = upvalueValues[upvalues[1]]
                                                        r38 = upvalueValues[upvalues[2]]
                                                        r18 = 7179983113487
                                                        r68 = "e\155\210Li\233\219>\004:\131\180\179c\246\253"
                                                        r54 = r38(r68, r18)
                                                        ReturnVal = r26[r54]
                                                        r54 = "Color3"
                                                        r38 = _env[r54]
                                                        r68 = upvalueValues[upvalues[1]]
                                                        r18 = upvalueValues[upvalues[2]]
                                                        r49 = ";^R\224|\222\240"
                                                        r25 = 27613664932410
                                                        r11 = r18(r49, r25)
                                                        r54 = r68[r11]
                                                        r26 = r38[r54]
                                                        r18 = "math"
                                                        r68 = _env[r18]
                                                        r11 = upvalueValues[upvalues[1]]
                                                        r49 = upvalueValues[upvalues[2]]
                                                        r65 = "\253x\201q\171\030"
                                                        r31 = 29109044163826
                                                        r25 = r49(r65, r31)
                                                        r18 = r11[r25]
                                                        r54 = r68[r18]
                                                        r11 = 255
                                                        r18 = 100
                                                        r68 = r54(r18, r11)
                                                        r11 = "math"
                                                        r18 = _env[r11]
                                                        r49 = upvalueValues[upvalues[1]]
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r21 = 386625241268
                                                        r31 = "\005\129P\252\135\200"
                                                        r65 = r25(r31, r21)
                                                        r11 = r49[r65]
                                                        r54 = r18[r11]
                                                        r11 = 100
                                                        r49 = 255
                                                        r18 = r54(r11, r49)
                                                        r49 = "math"
                                                        r11 = _env[r49]
                                                        r25 = upvalueValues[upvalues[1]]
                                                        r65 = upvalueValues[upvalues[2]]
                                                        r35 = 9769282310597
                                                        r21 = "\237\228\202\159\210\128"
                                                        r31 = r65(r21, r35)
                                                        r49 = r25[r31]
                                                        r54 = r11[r49]
                                                        r25 = 255
                                                        r49 = 100
                                                        r11 = {
                                                            r54(r49, r25)
                                                        }
                                                        r38 = r26(r68, r18, unpack(r11))
                                                        state[ReturnVal] = r38
                                                        state = upvalueValues[r60]
                                                        r26 = upvalueValues[upvalues[1]]
                                                        r38 = upvalueValues[upvalues[2]]
                                                        r68 = "\197\249[\181\184l\152\133a\244\005\1638\129\135\247i\003\228r\199\181"
                                                        r18 = 27347481915838
                                                        r54 = r38(r68, r18)
                                                        ReturnVal = r26[r54]
                                                        r26 = 0
                                                        state[ReturnVal] = r26
                                                        state = upvalueValues[r60]
                                                        r26 = upvalueValues[upvalues[1]]
                                                        r38 = upvalueValues[upvalues[2]]
                                                        r18 = 22364110448814
                                                        r68 = "\211z]\007\220Y"
                                                        r54 = r38(r68, r18)
                                                        ReturnVal = r26[r54]
                                                        r26 = upvalueValues[upvalues[3]]
                                                        state[ReturnVal] = r26
                                                        r26 = "Instance"
                                                        ReturnVal = _env[r26]
                                                        r38 = upvalueValues[upvalues[1]]
                                                        r54 = upvalueValues[upvalues[2]]
                                                        r11 = 19729537721315
                                                        r18 = " \234\003"
                                                        r68 = r54(r18, r11)
                                                        r26 = r38[r68]
                                                        state = ReturnVal[r26]
                                                        r38 = upvalueValues[upvalues[1]]
                                                        r54 = upvalueValues[upvalues[2]]
                                                        r11 = 10673265922922
                                                        r18 = "\019O\186\168Z\208\015\027"
                                                        r68 = r54(r18, r11)
                                                        r26 = r38[r68]
                                                        ReturnVal = state(r26)
                                                        r26 = ReturnVal
                                                        ReturnVal = upvalueValues[upvalues[1]]
                                                        r38 = upvalueValues[upvalues[2]]
                                                        r68 = "d\212\165J2U\232\007\023\214\252\129"
                                                        r18 = 24134775204838
                                                        r54 = r38(r68, r18)
                                                        state = ReturnVal[r54]
                                                        r54 = "UDim"
                                                        r38 = _env[r54]
                                                        r68 = upvalueValues[upvalues[1]]
                                                        r18 = upvalueValues[upvalues[2]]
                                                        r49 = "\196\175\198"
                                                        r25 = 21618146223954
                                                        r11 = r18(r49, r25)
                                                        r54 = r68[r11]
                                                        ReturnVal = r38[r54]
                                                        r11 = "math"
                                                        r18 = _env[r11]
                                                        r49 = upvalueValues[upvalues[1]]
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r21 = 28299762643834
                                                        r31 = "z\132,\028\026m"
                                                        r65 = r25(r31, r21)
                                                        r11 = r49[r65]
                                                        r68 = r18[r11]
                                                        r49 = 6
                                                        r11 = 2
                                                        r18 = {
                                                            r68(r11, r49)
                                                        }
                                                        r54 = 0
                                                        r38 = ReturnVal(r54, unpack(r18))
                                                        r26[state] = r38
                                                        ReturnVal = upvalueValues[upvalues[1]]
                                                        r38 = upvalueValues[upvalues[2]]
                                                        r18 = 1472753664685
                                                        r68 = ",-\222\205\172\004"
                                                        r54 = r38(r68, r18)
                                                        state = ReturnVal[r54]
                                                        ReturnVal = upvalueValues[r60]
                                                        r26[state] = ReturnVal
                                                        r38 = "Instance"
                                                        ReturnVal = _env[r38]
                                                        r54 = upvalueValues[upvalues[1]]
                                                        r68 = upvalueValues[upvalues[2]]
                                                        r11 = "d\204)"
                                                        r49 = 4485179394088
                                                        r18 = r68(r11, r49)
                                                        r38 = r54[r18]
                                                        state = ReturnVal[r38]
                                                        r54 = upvalueValues[upvalues[1]]
                                                        r68 = upvalueValues[upvalues[2]]
                                                        r11 = "^C\007\131`+\164A\154\132"
                                                        r49 = 29178505475347
                                                        r18 = r68(r11, r49)
                                                        r38 = r54[r18]
                                                        ReturnVal = state(r38)
                                                        r38 = ReturnVal
                                                        ReturnVal = upvalueValues[upvalues[1]]
                                                        r54 = upvalueValues[upvalues[2]]
                                                        r18 = "T\0244N\027"
                                                        r11 = 11815700206974
                                                        r68 = r54(r18, r11)
                                                        state = ReturnVal[r68]
                                                        r68 = "ColorSequence"
                                                        r54 = _env[r68]
                                                        r18 = upvalueValues[upvalues[1]]
                                                        r11 = upvalueValues[upvalues[2]]
                                                        r25 = "t\223q"
                                                        r65 = 17703248371763
                                                        r49 = r11(r25, r65)
                                                        r68 = r18[r49]
                                                        ReturnVal = r54[r68]
                                                        r49 = "ColorSequenceKeypoint"
                                                        r11 = _env[r49]
                                                        r25 = upvalueValues[upvalues[1]]
                                                        r65 = upvalueValues[upvalues[2]]
                                                        r35 = 15809161239745
                                                        r21 = "\030VX"
                                                        r31 = r65(r21, r35)
                                                        r49 = r25[r31]
                                                        r18 = r11[r49]
                                                        r31 = "Color3"
                                                        r65 = _env[r31]
                                                        r21 = upvalueValues[upvalues[1]]
                                                        r35 = upvalueValues[upvalues[2]]
                                                        r33 = 1960911225745
                                                        r14 = "v\144Rs\180\031\147"
                                                        r55 = r35(r14, r33)
                                                        r31 = r21[r55]
                                                        r25 = r65[r31]
                                                        r35 = 0
                                                        r21 = 255
                                                        r31 = 255
                                                        r65 = {
                                                            r25(r31, r21, r35)
                                                        }
                                                        r49 = 0
                                                        r11 = r18(r49, unpack(r65))
                                                        r25 = "ColorSequenceKeypoint"
                                                        r49 = _env[r25]
                                                        r65 = upvalueValues[upvalues[1]]
                                                        r31 = upvalueValues[upvalues[2]]
                                                        r35 = "|i\223"
                                                        r55 = 6189099584322
                                                        r21 = r31(r35, r55)
                                                        r25 = r65[r21]
                                                        r18 = r49[r25]
                                                        r21 = "Color3"
                                                        r31 = _env[r21]
                                                        r35 = upvalueValues[upvalues[1]]
                                                        r55 = upvalueValues[upvalues[2]]
                                                        r12 = 5737005992559
                                                        r33 = "\172K\030\"\128\196\184"
                                                        r14 = r55(r33, r12)
                                                        r21 = r35[r14]
                                                        r65 = r31[r21]
                                                        r21 = 255
                                                        r55 = 0
                                                        r35 = 0
                                                        r31 = {
                                                            r65(r21, r35, r55)
                                                        }
                                                        r25 = 1
                                                        r49 = {
                                                            r18(r25, unpack(r31))
                                                        }
                                                        r68 = {
                                                            r11,
                                                            unpack(r49)
                                                        }
                                                        r54 = ReturnVal(r68)
                                                        r38[state] = r54
                                                        ReturnVal = upvalueValues[upvalues[1]]
                                                        r54 = upvalueValues[upvalues[2]]
                                                        r18 = "\188?H\161\136\160"
                                                        r11 = 12402978756239
                                                        r68 = r54(r18, r11)
                                                        state = ReturnVal[r68]
                                                        ReturnVal = upvalueValues[r60]
                                                        r38[state] = ReturnVal
                                                        r54 = "table"
                                                        ReturnVal = _env[r54]
                                                        r68 = upvalueValues[upvalues[1]]
                                                        r18 = upvalueValues[upvalues[2]]
                                                        r49 = "\154\174~7Z\161"
                                                        r25 = 19408107545421
                                                        r11 = r18(r49, r25)
                                                        r54 = r68[r11]
                                                        state = ReturnVal[r54]
                                                        r54 = upvalueValues[r60]
                                                        ReturnVal = state(r41, r54)
                                                        r3 = r9
                                                        state = nil
                                                        r54 = state
                                                        ReturnVal = 64
                                                        state = r3 <= ReturnVal
                                                        state = state and (162) or (163)
                                                    end
                                                else
                                                    if state == 161 then
                                                        state = upvalueValues[upvalues[4]]
                                                        r43 = upvalueValues[upvalues[3]]
                                                        r3 = "TweenInfo"
                                                        r28 = _env[r3]
                                                        r60 = upvalueValues[upvalues[1]]
                                                        r26 = upvalueValues[upvalues[2]]
                                                        r54 = "\190-\237"
                                                        r18 = 27355218932162
                                                        r38 = r26(r54, r18)
                                                        r3 = r60[r38]
                                                        r20 = r28[r3]
                                                        r54 = "Enum"
                                                        r38 = _env[r54]
                                                        r18 = upvalueValues[upvalues[1]]
                                                        r11 = upvalueValues[upvalues[2]]
                                                        r25 = "\190\234>@\185\133\145\165\208jx"
                                                        r65 = 22805059725691
                                                        r49 = r11(r25, r65)
                                                        r54 = r18[r49]
                                                        r26 = r38[r54]
                                                        r54 = upvalueValues[upvalues[1]]
                                                        r18 = upvalueValues[upvalues[2]]
                                                        r25 = 5845620247202
                                                        r49 = "\202\165\163\020"
                                                        r11 = r18(r49, r25)
                                                        r38 = r54[r11]
                                                        r60 = r26[r38]
                                                        r18 = "Enum"
                                                        r54 = _env[r18]
                                                        r11 = upvalueValues[upvalues[1]]
                                                        r49 = upvalueValues[upvalues[2]]
                                                        r31 = 7980008066691
                                                        r65 = "s\205\164(#\r\008\218\137\224\228\128G_\015"
                                                        r25 = r49(r65, r31)
                                                        r18 = r11[r25]
                                                        r38 = r54[r18]
                                                        r18 = upvalueValues[upvalues[1]]
                                                        r11 = upvalueValues[upvalues[2]]
                                                        r65 = 24765970951436
                                                        r25 = "\231\235\031"
                                                        r49 = r11(r25, r65)
                                                        r9 = "Create"
                                                        r9 = state[r9]
                                                        r54 = r18[r49]
                                                        r26 = r38[r54]
                                                        r3 = 0.5
                                                        r28 = r20(r3, r60, r26)
                                                        r60 = upvalueValues[upvalues[1]]
                                                        r26 = upvalueValues[upvalues[2]]
                                                        r18 = 12034719847908
                                                        r54 = "\023\160w\170\207\174O\207\2358\026\212\166\171O\219\026\165\190\202\169g"
                                                        r38 = r26(r54, r18)
                                                        r3 = r60[r38]
                                                        r60 = 1
                                                        r20 = {
                                                            [r3] = r60
                                                        }
                                                        r9 = r9(state, r43, r28, r20)
                                                        state = "Play"
                                                        state = r9[state]
                                                        state = state(r9)
                                                        state = {}
                                                        r43 = state
                                                        r20 = "ipairs"
                                                        state = _env[r20]
                                                        r60 = upvalueValues[upvalues[3]]
                                                        r38 = "GetChildren"
                                                        r38 = r60[r38]
                                                        r26 = {
                                                            r38(r60)
                                                        }
                                                        r60 = {
                                                            state(unpack(r26))
                                                        }
                                                        r20 = r60[1]
                                                        r3 = r60[3]
                                                        r28 = r60[2]
                                                        state = 164
                                                    end
                                                end
                                            else
                                                if state <= 162 then
                                                    if state == 162 then
                                                        r68 = "Vector2"
                                                        ReturnVal = _env[r68]
                                                        r18 = upvalueValues[upvalues[1]]
                                                        r11 = upvalueValues[upvalues[2]]
                                                        r25 = "\158|\241"
                                                        r65 = 24388647332956
                                                        r49 = r11(r25, r65)
                                                        r68 = r18[r49]
                                                        state = ReturnVal[r68]
                                                        r11 = "math"
                                                        r18 = _env[r11]
                                                        r49 = upvalueValues[upvalues[1]]
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r21 = 1206716531249
                                                        r31 = "\147\210\253\021[<"
                                                        r65 = r25(r31, r21)
                                                        r11 = r49[r65]
                                                        r68 = r18[r11]
                                                        r11 = -100
                                                        r49 = 100
                                                        r18 = r68(r11, r49)
                                                        r49 = "math"
                                                        r11 = _env[r49]
                                                        r25 = upvalueValues[upvalues[1]]
                                                        r65 = upvalueValues[upvalues[2]]
                                                        r35 = 1956944085903
                                                        r21 = "\168\241\252\233\142{"
                                                        r31 = r65(r21, r35)
                                                        r49 = r25[r31]
                                                        r68 = r11[r49]
                                                        r49 = 200
                                                        r25 = 300
                                                        r11 = {
                                                            r68(r49, r25)
                                                        }
                                                        ReturnVal = state(r18, unpack(r11))
                                                        r54 = ReturnVal
                                                        state = 165
                                                    end
                                                else
                                                    if state == 163 then
                                                        r18 = "Vector2"
                                                        r68 = _env[r18]
                                                        r11 = upvalueValues[upvalues[1]]
                                                        r49 = upvalueValues[upvalues[2]]
                                                        r65 = "\194\030\155"
                                                        r31 = 7561377254849
                                                        r25 = r49(r65, r31)
                                                        r18 = r11[r25]
                                                        state = r68[r18]
                                                        r49 = "math"
                                                        r11 = _env[r49]
                                                        r25 = upvalueValues[upvalues[1]]
                                                        r65 = upvalueValues[upvalues[2]]
                                                        r35 = 33545412689156
                                                        r21 = "\158\006\027\234\197\151"
                                                        r31 = r65(r21, r35)
                                                        r49 = r25[r31]
                                                        r18 = r11[r49]
                                                        r49 = -100
                                                        r25 = 100
                                                        r11 = r18(r49, r25)
                                                        r25 = "math"
                                                        r49 = _env[r25]
                                                        r65 = upvalueValues[upvalues[1]]
                                                        r31 = upvalueValues[upvalues[2]]
                                                        r55 = 25819856023287
                                                        r35 = "\163\149\173J\172 "
                                                        r21 = r31(r35, r55)
                                                        r25 = r65[r21]
                                                        r18 = r49[r25]
                                                        r25 = -50
                                                        r65 = 50
                                                        r49 = {
                                                            r18(r25, r65)
                                                        }
                                                        r68 = state(r11, unpack(r49))
                                                        r54 = r68
                                                        state = 165
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 167 then
                                            if state <= 165 then
                                                if state <= 164 then
                                                    if state == 164 then
                                                        r3, r26 = r20(r28, r3)
                                                        state = r3 and (166) or (167)
                                                    end
                                                else
                                                    if state == 165 then
                                                        state = upvalueValues[upvalues[4]]
                                                        r11 = upvalueValues[r60]
                                                        r65 = "TweenInfo"
                                                        r25 = _env[r65]
                                                        r31 = upvalueValues[upvalues[1]]
                                                        r21 = upvalueValues[upvalues[2]]
                                                        r55 = "3&\027"
                                                        r14 = 10479677592335
                                                        r35 = r21(r55, r14)
                                                        r65 = r31[r35]
                                                        r49 = r25[r65]
                                                        r18 = "Create"
                                                        r55 = "Enum"
                                                        r35 = _env[r55]
                                                        r14 = upvalueValues[upvalues[1]]
                                                        r33 = upvalueValues[upvalues[2]]
                                                        r1 = "\211wk\164A\203)9\239J\189"
                                                        r59 = 8300275109657
                                                        r12 = r33(r1, r59)
                                                        r55 = r14[r12]
                                                        r21 = r35[r55]
                                                        r55 = upvalueValues[upvalues[1]]
                                                        r14 = upvalueValues[upvalues[2]]
                                                        r12 = "\r\"\174\202\198"
                                                        r1 = 32999839136774
                                                        r33 = r14(r12, r1)
                                                        r35 = r55[r33]
                                                        r31 = r21[r35]
                                                        r14 = "Enum"
                                                        r55 = _env[r14]
                                                        r33 = upvalueValues[upvalues[1]]
                                                        r12 = upvalueValues[upvalues[2]]
                                                        r46 = 2908970419530
                                                        r59 = "\021\248s\139\164\177\201\197\221\n\175\r\201\156m"
                                                        r1 = r12(r59, r46)
                                                        r14 = r33[r1]
                                                        r35 = r55[r14]
                                                        r14 = upvalueValues[upvalues[1]]
                                                        r33 = upvalueValues[upvalues[2]]
                                                        r59 = 2224947168268
                                                        r1 = "\200q\r"
                                                        r12 = r33(r1, r59)
                                                        r55 = r14[r12]
                                                        r21 = r35[r55]
                                                        r65 = 1
                                                        r25 = r49(r65, r31, r21)
                                                        r39 = 32407790451443
                                                        r57 = 20566202738024
                                                        r3 = nil
                                                        r31 = upvalueValues[upvalues[1]]
                                                        r21 = upvalueValues[upvalues[2]]
                                                        r55 = "\0213$\207\175xdL"
                                                        r14 = 33386464378042
                                                        r35 = r21(r55, r14)
                                                        r65 = r31[r35]
                                                        r35 = upvalueValues[r60]
                                                        r14 = upvalueValues[upvalues[1]]
                                                        r33 = upvalueValues[upvalues[2]]
                                                        r1 = "D\230\001\208V\019;d"
                                                        r59 = 12678252730127
                                                        r12 = r33(r1, r59)
                                                        r55 = r14[r12]
                                                        r21 = r35[r55]
                                                        r14 = "UDim2"
                                                        r55 = _env[r14]
                                                        r33 = upvalueValues[upvalues[1]]
                                                        r12 = upvalueValues[upvalues[2]]
                                                        r46 = 29572429084106
                                                        r59 = "\217\1681"
                                                        r1 = r12(r59, r46)
                                                        r14 = r33[r1]
                                                        r35 = r55[r14]
                                                        r1 = upvalueValues[upvalues[1]]
                                                        r59 = upvalueValues[upvalues[2]]
                                                        r18 = state[r18]
                                                        r17 = "\237"
                                                        r46 = r59(r17, r57)
                                                        r14 = 0
                                                        r67 = "\236"
                                                        r26 = nil
                                                        r12 = r1[r46]
                                                        r33 = r54[r12]
                                                        r46 = upvalueValues[upvalues[1]]
                                                        r17 = upvalueValues[upvalues[2]]
                                                        r57 = r17(r67, r39)
                                                        r59 = r46[r57]
                                                        r1 = r54[r59]
                                                        r12 = 0
                                                        r55 = r35(r14, r33, r12, r1)
                                                        r31 = r21 + r55
                                                        r59 = "\129\159O\1512\242"
                                                        r35 = upvalueValues[upvalues[1]]
                                                        r55 = upvalueValues[upvalues[2]]
                                                        r12 = 5061322918196
                                                        r33 = "0\251n\000DDv-"
                                                        r14 = r55(r33, r12)
                                                        r54 = nil
                                                        r21 = r35[r14]
                                                        r14 = "math"
                                                        r55 = _env[r14]
                                                        r33 = upvalueValues[upvalues[1]]
                                                        r12 = upvalueValues[upvalues[2]]
                                                        r46 = 9516605837647
                                                        r1 = r12(r59, r46)
                                                        r14 = r33[r1]
                                                        r35 = r55[r14]
                                                        r14 = -180
                                                        r33 = 180
                                                        r55 = r35(r14, r33)
                                                        r14 = upvalueValues[upvalues[1]]
                                                        r33 = upvalueValues[upvalues[2]]
                                                        r1 = "\n*Z}/R\005a\160\201\127P ip\2436\004g\147\167\152"
                                                        r59 = 18841564586565
                                                        r12 = r33(r1, r59)
                                                        r35 = r14[r12]
                                                        r14 = 1
                                                        r49 = {
                                                            [r65] = r31,
                                                            [r21] = r55,
                                                            [r35] = r14
                                                        }
                                                        r18 = r18(state, r11, r25, r49)
                                                        state = "Play"
                                                        state = r18[state]
                                                        state = state(r18)
                                                        r49 = "table"
                                                        r11 = _env[r49]
                                                        r25 = upvalueValues[upvalues[1]]
                                                        r65 = upvalueValues[upvalues[2]]
                                                        r21 = "\000\017\212\005\141\174"
                                                        r35 = 33361085562030
                                                        r31 = r65(r21, r35)
                                                        r49 = r25[r31]
                                                        state = r11[r49]
                                                        r11 = state(r7, r18)
                                                        r21 = "5\006[\254\229"
                                                        r35 = 10989359518717
                                                        r49 = "task"
                                                        r11 = _env[r49]
                                                        r25 = upvalueValues[upvalues[1]]
                                                        r65 = upvalueValues[upvalues[2]]
                                                        r38 = nil
                                                        r31 = r65(r21, r35)
                                                        r49 = r25[r31]
                                                        state = r11[r49]
                                                        r25 = createClosure0(250, {
                                                            r60,
                                                            upvalues[1],
                                                            upvalues[2]
                                                        })
                                                        r18 = nil
                                                        r60 = releaseUpvalue(r60)
                                                        r49 = 1
                                                        r11 = state(r49, r25)
                                                        state = 159
                                                    end
                                                end
                                            else
                                                if state <= 166 then
                                                    if state == 166 then
                                                        r11 = upvalueValues[upvalues[1]]
                                                        r49 = upvalueValues[upvalues[2]]
                                                        r65 = "\204\161\228-\127"
                                                        r31 = 13717014075635
                                                        r25 = r49(r65, r31)
                                                        r18 = r11[r25]
                                                        r54 = "IsA"
                                                        r54 = r26[r54]
                                                        r54 = r54(r26, r18)
                                                        state = r54 and (168) or (169)
                                                        r60 = r3
                                                        r38 = r54
                                                    end
                                                else
                                                    if state == 167 then
                                                        ReturnVal = {
                                                            r23,
                                                            r2,
                                                            r7,
                                                            r9,
                                                            r43
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 169 then
                                                if state <= 168 then
                                                    if state == 168 then
                                                        state = r38 and (170) or (171)
                                                    end
                                                else
                                                    if state == 169 then
                                                        r11 = upvalueValues[upvalues[1]]
                                                        r49 = upvalueValues[upvalues[2]]
                                                        r65 = "\219\127%o\022\188%o\252"
                                                        r31 = 1984577602460
                                                        r25 = r49(r65, r31)
                                                        r18 = r11[r25]
                                                        r54 = "IsA"
                                                        r54 = r26[r54]
                                                        r54 = r54(r26, r18)
                                                        r38 = r54
                                                        state = 168
                                                    end
                                                end
                                            else
                                                if state <= 170 then
                                                    if state == 170 then
                                                        state = upvalueValues[upvalues[4]]
                                                        r38 = "Create"
                                                        r11 = "TweenInfo"
                                                        r18 = _env[r11]
                                                        r49 = upvalueValues[upvalues[1]]
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r31 = "\231OH"
                                                        r21 = 31442827393329
                                                        r65 = r25(r31, r21)
                                                        r11 = r49[r65]
                                                        r54 = r18[r11]
                                                        r31 = "Enum"
                                                        r65 = _env[r31]
                                                        r21 = upvalueValues[upvalues[1]]
                                                        r35 = upvalueValues[upvalues[2]]
                                                        r14 = "\207;P\236\229\240}\239\166C\164"
                                                        r33 = 2921289303376
                                                        r55 = r35(r14, r33)
                                                        r31 = r21[r55]
                                                        r25 = r65[r31]
                                                        r31 = upvalueValues[upvalues[1]]
                                                        r21 = upvalueValues[upvalues[2]]
                                                        r55 = "oDn\163"
                                                        r14 = 3191294133710
                                                        r35 = r21(r55, r14)
                                                        r65 = r31[r35]
                                                        r49 = r25[r65]
                                                        r21 = "Enum"
                                                        r31 = _env[r21]
                                                        r35 = upvalueValues[upvalues[1]]
                                                        r55 = upvalueValues[upvalues[2]]
                                                        r33 = "\214\2336\156\204\003\130;(\2216\182[\245\246"
                                                        r12 = 33399771495616
                                                        r14 = r55(r33, r12)
                                                        r21 = r35[r14]
                                                        r65 = r31[r21]
                                                        r21 = upvalueValues[upvalues[1]]
                                                        r35 = upvalueValues[upvalues[2]]
                                                        r14 = "2\215/"
                                                        r33 = 10482666574609
                                                        r55 = r35(r14, r33)
                                                        r31 = r21[r55]
                                                        r38 = state[r38]
                                                        r25 = r65[r31]
                                                        r11 = 0.5
                                                        r18 = r54(r11, r49, r25)
                                                        r49 = upvalueValues[upvalues[1]]
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r31 = "\247\172Nms\178;/\"+?\023 \005\178c\154\137 \198\224\139"
                                                        r21 = 1552334717650
                                                        r65 = r25(r31, r21)
                                                        r11 = r49[r65]
                                                        r65 = upvalueValues[upvalues[1]]
                                                        r31 = upvalueValues[upvalues[2]]
                                                        r35 = "h\030\231\157\221\151\195\149\192\197z\179\217\191\189\185"
                                                        r55 = 24035255413688
                                                        r21 = r31(r35, r55)
                                                        r25 = r65[r21]
                                                        r33 = upvalueValues[upvalues[1]]
                                                        r55 = "IsA"
                                                        r55 = r26[r55]
                                                        r12 = upvalueValues[upvalues[2]]
                                                        r59 = "A\247\250\218\030\200\001Z\208"
                                                        r46 = 20962344166945
                                                        r1 = r12(r59, r46)
                                                        r14 = r33[r1]
                                                        r55 = r55(r26, r14)
                                                        r14 = 1
                                                        r21 = r55 and r14
                                                        r35 = state
                                                        r35 = nil
                                                        r65 = r21 or r35
                                                        r49 = 1
                                                        r54 = {
                                                            [r11] = r49,
                                                            [r25] = r65
                                                        }
                                                        r38 = r38(state, r26, r18, r54)
                                                        r54 = "Play"
                                                        r54 = r38[r54]
                                                        r54 = r54(r38)
                                                        r11 = "table"
                                                        r18 = _env[r11]
                                                        r49 = upvalueValues[upvalues[1]]
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r21 = 9852609827307
                                                        r31 = state
                                                        r31 = "\163\t9l\215W"
                                                        r65 = r25(r31, r21)
                                                        r11 = r49[r65]
                                                        r54 = r18[r11]
                                                        r18 = r54(r43, r38)
                                                        r38 = nil
                                                        state = 171
                                                    end
                                                else
                                                    if state == 171 then
                                                        r60 = nil
                                                        r26 = nil
                                                        state = 164
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure3 entry 1691616 -> 172, states 172-238
                                if state <= 205 then
                                    if state <= 188 then
                                        if state <= 180 then
                                            if state <= 176 then
                                                if state <= 174 then
                                                    if state <= 173 then
                                                        if state <= 172 then
                                                            if state == 172 then -- entry 1691616 -> 172
                                                                state = {}
                                                                r22 = state
                                                                r23 = 215
                                                                r2 = r23
                                                                r23 = 1
                                                                r41 = r23
                                                                r23 = 0
                                                                r7 = r41 < r23
                                                                ReturnVal = 1
                                                                r23 = ReturnVal - r41
                                                                state = 173
                                                            end
                                                        else
                                                            if state == 173 then
                                                                r9 = not r7
                                                                r23 = r23 + r41
                                                                ReturnVal = r23 <= r2
                                                                ReturnVal = r9 and ReturnVal
                                                                r9 = r23 >= r2
                                                                r9 = r7 and r9
                                                                ReturnVal = r9 or ReturnVal
                                                                r9 = (174)
                                                                state = ReturnVal and r9
                                                                ReturnVal = (175)
                                                                state = state or ReturnVal
                                                            end
                                                        end
                                                    else
                                                        if state == 174 then
                                                            r43 = "math"
                                                            ReturnVal = _env[r43]
                                                            r20 = upvalueValues[upvalues[1]]
                                                            r28 = upvalueValues[upvalues[2]]
                                                            r60 = "\156\253\000"
                                                            r26 = 3082512369051
                                                            r3 = r28(r60, r26)
                                                            r43 = r20[r3]
                                                            state = ReturnVal[r43]
                                                            r9 = r23
                                                            r20 = 2
                                                            r43 = r9 / r20
                                                            r20 = 100
                                                            ReturnVal = state(r43, r20)
                                                            r43 = ReturnVal
                                                            r20 = upvalueValues[upvalues[3]]
                                                            state = r20 and (176) or (177)
                                                            ReturnVal = r20
                                                        end
                                                    end
                                                else
                                                    if state <= 175 then
                                                        if state == 175 then
                                                            state = upvalueValues[upvalues[9]]
                                                            ReturnVal = "Cancel"
                                                            ReturnVal = state[ReturnVal]
                                                            ReturnVal = ReturnVal(state)
                                                            state = upvalueValues[upvalues[10]]
                                                            ReturnVal = "Stop"
                                                            ReturnVal = state[ReturnVal]
                                                            ReturnVal = ReturnVal(state)
                                                            r23 = upvalueValues[upvalues[11]]
                                                            state = r23 and (178) or (179)
                                                            ReturnVal = r23
                                                        end
                                                    else
                                                        if state == 176 then
                                                            r3 = upvalueValues[upvalues[4]]
                                                            r28 = state
                                                            state = r3 and (180) or (181)
                                                            r20 = r3
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 178 then
                                                    if state <= 177 then
                                                        if state == 177 then
                                                            state = ReturnVal and (182) or (183)
                                                        end
                                                    else
                                                        if state == 178 then
                                                            r2 = upvalueValues[upvalues[11]]
                                                            r7 = upvalueValues[upvalues[1]]
                                                            r9 = upvalueValues[upvalues[2]]
                                                            r28 = 15071361244010
                                                            r20 = "mz\217\012\201\186"
                                                            r43 = r9(r20, r28)
                                                            r41 = r7[r43]
                                                            r23 = r2[r41]
                                                            ReturnVal = r23
                                                            state = 179
                                                        end
                                                    end
                                                else
                                                    if state <= 179 then
                                                        if state == 179 then
                                                            state = ReturnVal and (184) or (185)
                                                        end
                                                    else
                                                        if state == 180 then
                                                            r26 = upvalueValues[upvalues[5]]
                                                            r60 = state
                                                            state = r26 and (186) or (187)
                                                            r3 = r26
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 184 then
                                                if state <= 182 then
                                                    if state <= 181 then
                                                        if state == 181 then
                                                            state = r28
                                                            ReturnVal = r20
                                                            state = 177
                                                        end
                                                    else
                                                        if state == 182 then
                                                            state = upvalueValues[upvalues[6]]
                                                            r20 = upvalueValues[upvalues[3]]
                                                            r60 = "TweenInfo"
                                                            r3 = _env[r60]
                                                            r26 = upvalueValues[upvalues[1]]
                                                            r38 = upvalueValues[upvalues[2]]
                                                            r68 = "\173_\021"
                                                            r18 = 33882689846689
                                                            r54 = r38(r68, r18)
                                                            r60 = r26[r54]
                                                            r28 = r3[r60]
                                                            r68 = "Enum"
                                                            r54 = _env[r68]
                                                            r18 = upvalueValues[upvalues[1]]
                                                            r11 = upvalueValues[upvalues[2]]
                                                            r25 = "C\198\209\028\141\145\181\134a\\5"
                                                            r65 = 28824376816750
                                                            r49 = r11(r25, r65)
                                                            ReturnVal = "Create"
                                                            ReturnVal = state[ReturnVal]
                                                            r68 = r18[r49]
                                                            r38 = r54[r68]
                                                            r68 = upvalueValues[upvalues[1]]
                                                            r18 = upvalueValues[upvalues[2]]
                                                            r49 = "\233\157\226\203"
                                                            r25 = 24313099660345
                                                            r11 = r18(r49, r25)
                                                            r54 = r68[r11]
                                                            r26 = r38[r54]
                                                            r18 = "Enum"
                                                            r68 = _env[r18]
                                                            r11 = upvalueValues[upvalues[1]]
                                                            r49 = upvalueValues[upvalues[2]]
                                                            r65 = "\251\244\138\136\174+\2215\018\219\173\016\138\188\217"
                                                            r31 = 24638928481489
                                                            r25 = r49(r65, r31)
                                                            r18 = r11[r25]
                                                            r54 = r68[r18]
                                                            r18 = upvalueValues[upvalues[1]]
                                                            r11 = upvalueValues[upvalues[2]]
                                                            r65 = 34396926869137
                                                            r25 = "M(P"
                                                            r49 = r11(r25, r65)
                                                            r68 = r18[r49]
                                                            r38 = r54[r68]
                                                            r60 = 0.1
                                                            r3 = r28(r60, r26, r38)
                                                            r26 = upvalueValues[upvalues[1]]
                                                            r38 = upvalueValues[upvalues[2]]
                                                            r68 = "\206\176\238\136"
                                                            r18 = 26187596869538
                                                            r54 = r38(r68, r18)
                                                            r60 = r26[r54]
                                                            r54 = "UDim2"
                                                            r38 = _env[r54]
                                                            r68 = upvalueValues[upvalues[1]]
                                                            r18 = upvalueValues[upvalues[2]]
                                                            r25 = 3015854736764
                                                            r49 = "\172\236\017"
                                                            r11 = r18(r49, r25)
                                                            r54 = r68[r11]
                                                            r26 = r38[r54]
                                                            r68 = 100
                                                            r54 = r43 / r68
                                                            r18 = 1
                                                            r11 = 0
                                                            r68 = 0
                                                            r38 = r26(r54, r68, r18, r11)
                                                            r28 = {
                                                                [r60] = r38
                                                            }
                                                            ReturnVal = ReturnVal(state, r20, r3, r28)
                                                            r20 = ReturnVal
                                                            state = "Play"
                                                            state = r20[state]
                                                            state = state(r20)
                                                            r28 = "table"
                                                            ReturnVal = _env[r28]
                                                            r3 = upvalueValues[upvalues[1]]
                                                            r60 = upvalueValues[upvalues[2]]
                                                            r38 = "\145\014/=\029\197"
                                                            r54 = 10630725063510
                                                            r26 = r60(r38, r54)
                                                            r28 = r3[r26]
                                                            state = ReturnVal[r28]
                                                            ReturnVal = state(r22, r20)
                                                            state = upvalueValues[upvalues[3]]
                                                            r28 = upvalueValues[upvalues[1]]
                                                            r3 = upvalueValues[upvalues[2]]
                                                            r26 = "\220\003\175x\250I8N<\249\160\202c\174\1704"
                                                            r38 = 857730040207
                                                            r60 = r3(r26, r38)
                                                            ReturnVal = r28[r60]
                                                            r60 = "Color3"
                                                            r3 = _env[r60]
                                                            r26 = upvalueValues[upvalues[1]]
                                                            r38 = upvalueValues[upvalues[2]]
                                                            r68 = "&\148r7\026J\007"
                                                            r18 = 6158751943475
                                                            r54 = r38(r68, r18)
                                                            r60 = r26[r54]
                                                            r28 = r3[r60]
                                                            r26 = 100
                                                            r60 = r43 / r26
                                                            r38 = 1
                                                            r26 = 1
                                                            r3 = r28(r60, r26, r38)
                                                            state[ReturnVal] = r3
                                                            state = upvalueValues[upvalues[5]]
                                                            r28 = upvalueValues[upvalues[1]]
                                                            r3 = upvalueValues[upvalues[2]]
                                                            r26 = "Y\nr%"
                                                            r38 = 34083615227391
                                                            r60 = r3(r26, r38)
                                                            ReturnVal = r28[r60]
                                                            r60 = "string"
                                                            r3 = _env[r60]
                                                            r26 = upvalueValues[upvalues[1]]
                                                            r38 = upvalueValues[upvalues[2]]
                                                            r68 = "'\030*\140\000\237"
                                                            r18 = 24429249408111
                                                            r54 = r38(r68, r18)
                                                            r60 = r26[r54]
                                                            r28 = r3[r60]
                                                            r26 = upvalueValues[upvalues[1]]
                                                            r38 = upvalueValues[upvalues[2]]
                                                            r68 = "\222'V\131B\182"
                                                            r18 = 11286226752647
                                                            r54 = r38(r68, r18)
                                                            r60 = r26[r54]
                                                            r3 = r28(r60, r43)
                                                            state[ReturnVal] = r3
                                                            r3 = "math"
                                                            r28 = _env[r3]
                                                            r60 = upvalueValues[upvalues[1]]
                                                            r26 = upvalueValues[upvalues[2]]
                                                            r68 = 18610588574170
                                                            r54 = "\008\141h\136\144"
                                                            r38 = r26(r54, r68)
                                                            r3 = r60[r38]
                                                            ReturnVal = r28[r3]
                                                            r60 = 25
                                                            r3 = r43 / r60
                                                            r28 = ReturnVal(r3)
                                                            ReturnVal = 25
                                                            state = r28 * ReturnVal
                                                            r28 = state
                                                            ReturnVal = upvalueValues[upvalues[7]]
                                                            state = ReturnVal[r28]
                                                            state = state and (188) or (189)
                                                        end
                                                    end
                                                else
                                                    if state <= 183 then
                                                        if state == 183 then
                                                            r38 = 10632339133271
                                                            ReturnVal = "warn"
                                                            state = _env[ReturnVal]
                                                            r26 = "N= \212\162\204\207\188\184\242\137\164\128U.\142\024\133\133<\183;\155\177\192]\252]\152\166f\135\219\154\157\190\007\2382Q"
                                                            r43 = nil
                                                            r28 = upvalueValues[upvalues[1]]
                                                            r9 = nil
                                                            r3 = upvalueValues[upvalues[2]]
                                                            r60 = r3(r26, r38)
                                                            r20 = r28[r60]
                                                            ReturnVal = state(r20)
                                                            state = 175
                                                        end
                                                    else
                                                        if state == 184 then
                                                            r23 = "Instance"
                                                            ReturnVal = _env[r23]
                                                            r2 = upvalueValues[upvalues[1]]
                                                            r41 = upvalueValues[upvalues[2]]
                                                            r43 = 29343839188320
                                                            r9 = "Cw\236"
                                                            r7 = r41(r9, r43)
                                                            r23 = r2[r7]
                                                            state = ReturnVal[r23]
                                                            r2 = upvalueValues[upvalues[1]]
                                                            r41 = upvalueValues[upvalues[2]]
                                                            r9 = ")J\154\185\181"
                                                            r43 = 13714851502322
                                                            r7 = r41(r9, r43)
                                                            r23 = r2[r7]
                                                            ReturnVal = state(r23)
                                                            r23 = ReturnVal
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r2 = upvalueValues[upvalues[2]]
                                                            r9 = 34002799869401
                                                            r7 = "3\"\025\155"
                                                            r41 = r2(r7, r9)
                                                            state = ReturnVal[r41]
                                                            r41 = "UDim2"
                                                            r2 = _env[r41]
                                                            r7 = upvalueValues[upvalues[1]]
                                                            r9 = upvalueValues[upvalues[2]]
                                                            r20 = "\164\143\023"
                                                            r28 = 5553665722906
                                                            r43 = r9(r20, r28)
                                                            r41 = r7[r43]
                                                            ReturnVal = r2[r41]
                                                            r41 = 0.15
                                                            r9 = 0.15
                                                            r43 = 0
                                                            r7 = 0
                                                            r2 = ReturnVal(r41, r7, r9, r43)
                                                            r23[state] = r2
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r2 = upvalueValues[upvalues[2]]
                                                            r7 = "\tT\025\018\253:\219p"
                                                            r9 = 28324300796805
                                                            r41 = r2(r7, r9)
                                                            state = ReturnVal[r41]
                                                            r41 = "UDim2"
                                                            r2 = _env[r41]
                                                            r7 = upvalueValues[upvalues[1]]
                                                            r9 = upvalueValues[upvalues[2]]
                                                            r20 = "\143ui"
                                                            r28 = 32701117627259
                                                            r43 = r9(r20, r28)
                                                            r41 = r7[r43]
                                                            ReturnVal = r2[r41]
                                                            r43 = 0
                                                            r41 = 0.425
                                                            r9 = 0.425
                                                            r7 = 0
                                                            r2 = ReturnVal(r41, r7, r9, r43)
                                                            r23[state] = r2
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r2 = upvalueValues[upvalues[2]]
                                                            r7 = "\230A+o\018\188\204\242\016\014\129d\180h\189^"
                                                            r9 = 34378042539656
                                                            r41 = r2(r7, r9)
                                                            state = ReturnVal[r41]
                                                            r41 = "Color3"
                                                            r2 = _env[r41]
                                                            r7 = upvalueValues[upvalues[1]]
                                                            r9 = upvalueValues[upvalues[2]]
                                                            r28 = 17453028351935
                                                            r20 = "'Ky\186B`s"
                                                            r43 = r9(r20, r28)
                                                            r41 = r7[r43]
                                                            ReturnVal = r2[r41]
                                                            r9 = 100
                                                            r7 = 255
                                                            r41 = 0
                                                            r2 = ReturnVal(r41, r7, r9)
                                                            r23[state] = r2
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r2 = upvalueValues[upvalues[2]]
                                                            r9 = 22155674003533
                                                            r7 = "\134\1581\2051]K\242,Y\025f)n\176\138\226h\201\027\138\226"
                                                            r41 = r2(r7, r9)
                                                            state = ReturnVal[r41]
                                                            ReturnVal = 1
                                                            r23[state] = ReturnVal
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r2 = upvalueValues[upvalues[2]]
                                                            r7 = " \002\004\182\180\191"
                                                            r9 = 33590597303577
                                                            r41 = r2(r7, r9)
                                                            state = ReturnVal[r41]
                                                            ReturnVal = upvalueValues[upvalues[11]]
                                                            r23[state] = ReturnVal
                                                            r2 = "Instance"
                                                            ReturnVal = _env[r2]
                                                            r41 = upvalueValues[upvalues[1]]
                                                            r7 = upvalueValues[upvalues[2]]
                                                            r20 = 8456253116257
                                                            r43 = "\184\002\202"
                                                            r9 = r7(r43, r20)
                                                            r2 = r41[r9]
                                                            state = ReturnVal[r2]
                                                            r41 = upvalueValues[upvalues[1]]
                                                            r7 = upvalueValues[upvalues[2]]
                                                            r43 = "\136\2143\001\190\253\205\163"
                                                            r20 = 25171528756681
                                                            r9 = r7(r43, r20)
                                                            r2 = r41[r9]
                                                            ReturnVal = state(r2)
                                                            r2 = ReturnVal
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r41 = upvalueValues[upvalues[2]]
                                                            r43 = 9036950261872
                                                            r9 = "\207;\132\141B\249\179\235K\161\251\150"
                                                            r7 = r41(r9, r43)
                                                            state = ReturnVal[r7]
                                                            r7 = "UDim"
                                                            r41 = _env[r7]
                                                            r9 = upvalueValues[upvalues[1]]
                                                            r43 = upvalueValues[upvalues[2]]
                                                            r3 = 9313983156465
                                                            r28 = "*\"\229"
                                                            r20 = r43(r28, r3)
                                                            r7 = r9[r20]
                                                            ReturnVal = r41[r7]
                                                            r9 = 0
                                                            r7 = 1
                                                            r41 = ReturnVal(r7, r9)
                                                            r2[state] = r41
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r41 = upvalueValues[upvalues[2]]
                                                            r43 = 31330280700157
                                                            r9 = "C\227\173\242\188\r"
                                                            r7 = r41(r9, r43)
                                                            state = ReturnVal[r7]
                                                            ReturnVal = r23
                                                            r2[state] = ReturnVal
                                                            r41 = "Instance"
                                                            ReturnVal = _env[r41]
                                                            r7 = upvalueValues[upvalues[1]]
                                                            r9 = upvalueValues[upvalues[2]]
                                                            r28 = 7936193384047
                                                            r20 = ",\185\128"
                                                            r43 = r9(r20, r28)
                                                            r41 = r7[r43]
                                                            state = ReturnVal[r41]
                                                            r7 = upvalueValues[upvalues[1]]
                                                            r9 = upvalueValues[upvalues[2]]
                                                            r20 = "\168\133\188\164\249\218\235\130jT"
                                                            r28 = 33743232564576
                                                            r43 = r9(r20, r28)
                                                            r41 = r7[r43]
                                                            ReturnVal = state(r41)
                                                            r41 = ReturnVal
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r7 = upvalueValues[upvalues[2]]
                                                            r20 = 7432135363972
                                                            r43 = "\008r\240\181\027"
                                                            r9 = r7(r43, r20)
                                                            state = ReturnVal[r9]
                                                            r9 = "ColorSequence"
                                                            r7 = _env[r9]
                                                            r43 = upvalueValues[upvalues[1]]
                                                            r20 = upvalueValues[upvalues[2]]
                                                            r60 = 26546781958217
                                                            r3 = "\207\218\149"
                                                            r28 = r20(r3, r60)
                                                            r9 = r43[r28]
                                                            ReturnVal = r7[r9]
                                                            r28 = "ColorSequenceKeypoint"
                                                            r20 = _env[r28]
                                                            r3 = upvalueValues[upvalues[1]]
                                                            r60 = upvalueValues[upvalues[2]]
                                                            r54 = 14296546433537
                                                            r38 = "a\012\t"
                                                            r26 = r60(r38, r54)
                                                            r28 = r3[r26]
                                                            r43 = r20[r28]
                                                            r26 = "Color3"
                                                            r60 = _env[r26]
                                                            r38 = upvalueValues[upvalues[1]]
                                                            r54 = upvalueValues[upvalues[2]]
                                                            r11 = 27037131059502
                                                            r18 = "_J\020r\225,\\"
                                                            r68 = r54(r18, r11)
                                                            r26 = r38[r68]
                                                            r3 = r60[r26]
                                                            r54 = 100
                                                            r26 = 0
                                                            r38 = 255
                                                            r60 = {
                                                                r3(r26, r38, r54)
                                                            }
                                                            r28 = 0
                                                            r20 = r43(r28, unpack(r60))
                                                            r3 = "ColorSequenceKeypoint"
                                                            r28 = _env[r3]
                                                            r60 = upvalueValues[upvalues[1]]
                                                            r26 = upvalueValues[upvalues[2]]
                                                            r68 = 27899743269567
                                                            r54 = "\014\228\022"
                                                            r38 = r26(r54, r68)
                                                            r3 = r60[r38]
                                                            r43 = r28[r3]
                                                            r38 = "Color3"
                                                            r26 = _env[r38]
                                                            r54 = upvalueValues[upvalues[1]]
                                                            r68 = upvalueValues[upvalues[2]]
                                                            r49 = 31825335548387
                                                            r11 = "6\018\129\201\142\019*"
                                                            r18 = r68(r11, r49)
                                                            r38 = r54[r18]
                                                            r60 = r26[r38]
                                                            r54 = 255
                                                            r38 = 255
                                                            r68 = 255
                                                            r26 = {
                                                                r60(r38, r54, r68)
                                                            }
                                                            r3 = 1
                                                            r28 = {
                                                                r43(r3, unpack(r26))
                                                            }
                                                            r9 = {
                                                                r20,
                                                                unpack(r28)
                                                            }
                                                            r7 = ReturnVal(r9)
                                                            r41[state] = r7
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r7 = upvalueValues[upvalues[2]]
                                                            r20 = 21328858326732
                                                            r43 = "\144,\026g\165M"
                                                            r9 = r7(r43, r20)
                                                            state = ReturnVal[r9]
                                                            ReturnVal = r23
                                                            r41[state] = ReturnVal
                                                            r7 = "Instance"
                                                            ReturnVal = _env[r7]
                                                            r9 = upvalueValues[upvalues[1]]
                                                            r43 = upvalueValues[upvalues[2]]
                                                            r3 = 845960642953
                                                            r28 = "D\234q"
                                                            r20 = r43(r28, r3)
                                                            r7 = r9[r20]
                                                            state = ReturnVal[r7]
                                                            r9 = upvalueValues[upvalues[1]]
                                                            r43 = upvalueValues[upvalues[2]]
                                                            r28 = "e\191I`\212P\138\002\140"
                                                            r3 = 1738827776809
                                                            r20 = r43(r28, r3)
                                                            r7 = r9[r20]
                                                            ReturnVal = state(r7)
                                                            r7 = ReturnVal
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r9 = upvalueValues[upvalues[2]]
                                                            r20 = ")SnQ"
                                                            r28 = 159926960202
                                                            r43 = r9(r20, r28)
                                                            state = ReturnVal[r43]
                                                            r43 = "UDim2"
                                                            r9 = _env[r43]
                                                            r20 = upvalueValues[upvalues[1]]
                                                            r28 = upvalueValues[upvalues[2]]
                                                            r26 = 2420528628839
                                                            r60 = "\143\215\244"
                                                            r3 = r28(r60, r26)
                                                            r43 = r20[r3]
                                                            ReturnVal = r9[r43]
                                                            r28 = 1
                                                            r3 = 0
                                                            r43 = 1
                                                            r20 = 0
                                                            r9 = ReturnVal(r43, r20, r28, r3)
                                                            r7[state] = r9
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r9 = upvalueValues[upvalues[2]]
                                                            r20 = "\199\194\252\178\218\204T\232"
                                                            r28 = 18277081915710
                                                            r43 = r9(r20, r28)
                                                            state = ReturnVal[r43]
                                                            r43 = "UDim2"
                                                            r9 = _env[r43]
                                                            r20 = upvalueValues[upvalues[1]]
                                                            r28 = upvalueValues[upvalues[2]]
                                                            r60 = "I\169\250"
                                                            r26 = 10792266093473
                                                            r3 = r28(r60, r26)
                                                            r43 = r20[r3]
                                                            ReturnVal = r9[r43]
                                                            r3 = 0
                                                            r20 = 0
                                                            r28 = 0
                                                            r43 = 0
                                                            r9 = ReturnVal(r43, r20, r28, r3)
                                                            r7[state] = r9
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r9 = upvalueValues[upvalues[2]]
                                                            r20 = "\151-\249\203B\205\012G/\152\208@~\161\145\249\017\168\255\199\226\025"
                                                            r28 = 17491889872849
                                                            r43 = r9(r20, r28)
                                                            state = ReturnVal[r43]
                                                            ReturnVal = 1
                                                            r7[state] = ReturnVal
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r9 = upvalueValues[upvalues[2]]
                                                            r28 = 12436548998815
                                                            r20 = "\242;\029F"
                                                            r43 = r9(r20, r28)
                                                            state = ReturnVal[r43]
                                                            r9 = upvalueValues[upvalues[1]]
                                                            r43 = upvalueValues[upvalues[2]]
                                                            r3 = 24507117612180
                                                            r28 = "\251-\192"
                                                            r20 = r43(r28, r3)
                                                            ReturnVal = r9[r20]
                                                            r7[state] = ReturnVal
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r9 = upvalueValues[upvalues[2]]
                                                            r28 = 16310317637035
                                                            r20 = "\243\2059HK\136\217<\253\027"
                                                            r43 = r9(r20, r28)
                                                            state = ReturnVal[r43]
                                                            r43 = "Color3"
                                                            r9 = _env[r43]
                                                            r20 = upvalueValues[upvalues[1]]
                                                            r28 = upvalueValues[upvalues[2]]
                                                            r60 = ",\028\252\238\022Dg"
                                                            r26 = 17990214721721
                                                            r3 = r28(r60, r26)
                                                            r43 = r20[r3]
                                                            ReturnVal = r9[r43]
                                                            r28 = 255
                                                            r43 = 255
                                                            r20 = 255
                                                            r9 = ReturnVal(r43, r20, r28)
                                                            r7[state] = r9
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r9 = upvalueValues[upvalues[2]]
                                                            r28 = 17647046303769
                                                            r20 = "\183\234\198\194\166Nh+"
                                                            r43 = r9(r20, r28)
                                                            state = ReturnVal[r43]
                                                            ReturnVal = 40
                                                            r7[state] = ReturnVal
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r9 = upvalueValues[upvalues[2]]
                                                            r20 = "\204\173\141="
                                                            r28 = 13827063159078
                                                            r43 = r9(r20, r28)
                                                            state = ReturnVal[r43]
                                                            r20 = "Enum"
                                                            r43 = _env[r20]
                                                            r28 = upvalueValues[upvalues[1]]
                                                            r3 = upvalueValues[upvalues[2]]
                                                            r38 = 17183885156161
                                                            r26 = "\188\135\240\234"
                                                            r60 = r3(r26, r38)
                                                            r20 = r28[r60]
                                                            r9 = r43[r20]
                                                            r20 = upvalueValues[upvalues[1]]
                                                            r28 = upvalueValues[upvalues[2]]
                                                            r26 = 35100074655704
                                                            r60 = "|\182E\255W\202(\002\016h"
                                                            r3 = r28(r60, r26)
                                                            r43 = r20[r3]
                                                            ReturnVal = r9[r43]
                                                            r7[state] = ReturnVal
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r9 = upvalueValues[upvalues[2]]
                                                            r28 = 798365073779
                                                            r20 = "\150\235\214\242a{\220\208\012ht\179q\2131s"
                                                            r43 = r9(r20, r28)
                                                            state = ReturnVal[r43]
                                                            ReturnVal = 1
                                                            r7[state] = ReturnVal
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r9 = upvalueValues[upvalues[2]]
                                                            r20 = "\239\184\014AT\024\206\138\ro"
                                                            r28 = 15590110354523
                                                            r43 = r9(r20, r28)
                                                            state = ReturnVal[r43]
                                                            ReturnVal = true
                                                            r7[state] = ReturnVal
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r9 = upvalueValues[upvalues[2]]
                                                            r20 = "\205\204c\030h\004"
                                                            r28 = 8371955666746
                                                            r43 = r9(r20, r28)
                                                            state = ReturnVal[r43]
                                                            ReturnVal = r23
                                                            r7[state] = ReturnVal
                                                            state = upvalueValues[upvalues[6]]
                                                            r20 = "TweenInfo"
                                                            r43 = _env[r20]
                                                            r28 = upvalueValues[upvalues[1]]
                                                            r3 = upvalueValues[upvalues[2]]
                                                            r38 = 25969893830461
                                                            r26 = "+9`"
                                                            r60 = r3(r26, r38)
                                                            r20 = r28[r60]
                                                            r9 = r43[r20]
                                                            r26 = "Enum"
                                                            r60 = _env[r26]
                                                            r38 = upvalueValues[upvalues[1]]
                                                            r54 = upvalueValues[upvalues[2]]
                                                            r18 = "\249S\1963M\216(\187\030\153q"
                                                            r11 = 24627060616395
                                                            r68 = r54(r18, r11)
                                                            r26 = r38[r68]
                                                            r3 = r60[r26]
                                                            r26 = upvalueValues[upvalues[1]]
                                                            r38 = upvalueValues[upvalues[2]]
                                                            r18 = 17685938823211
                                                            r68 = "\243~d\008"
                                                            r54 = r38(r68, r18)
                                                            r60 = r26[r54]
                                                            r28 = r3[r60]
                                                            r38 = "Enum"
                                                            r26 = _env[r38]
                                                            r54 = upvalueValues[upvalues[1]]
                                                            r68 = upvalueValues[upvalues[2]]
                                                            r49 = 22115802425402
                                                            r11 = "8j\169v\237\161\132\192\165\148\253\028i\031\241"
                                                            r18 = r68(r11, r49)
                                                            r38 = r54[r18]
                                                            r60 = r26[r38]
                                                            r38 = upvalueValues[upvalues[1]]
                                                            r54 = upvalueValues[upvalues[2]]
                                                            r11 = 32563254016827
                                                            r18 = "f\253"
                                                            r68 = r54(r18, r11)
                                                            r26 = r38[r68]
                                                            r3 = r60[r26]
                                                            r20 = 0.5
                                                            r43 = r9(r20, r28, r3)
                                                            r28 = upvalueValues[upvalues[1]]
                                                            r3 = upvalueValues[upvalues[2]]
                                                            r26 = "$ks\027\153-\195\219N\184\164\158QG\198w\149\222\\\143\233\199"
                                                            r38 = 16244799298956
                                                            r60 = r3(r26, r38)
                                                            r20 = r28[r60]
                                                            r60 = upvalueValues[upvalues[1]]
                                                            r26 = upvalueValues[upvalues[2]]
                                                            r68 = 29547937789375
                                                            r54 = "\136!\143\167"
                                                            r38 = r26(r54, r68)
                                                            ReturnVal = "Create"
                                                            ReturnVal = state[ReturnVal]
                                                            r3 = r60[r38]
                                                            r38 = "UDim2"
                                                            r26 = _env[r38]
                                                            r54 = upvalueValues[upvalues[1]]
                                                            r68 = upvalueValues[upvalues[2]]
                                                            r49 = 23925663869829
                                                            r11 = "\152oK"
                                                            r18 = r68(r11, r49)
                                                            r38 = r54[r18]
                                                            r60 = r26[r38]
                                                            r54 = 0
                                                            r18 = 0
                                                            r38 = 0.2
                                                            r68 = 0.2
                                                            r26 = r60(r38, r54, r68, r18)
                                                            r28 = 0.2
                                                            r9 = {
                                                                [r20] = r28,
                                                                [r3] = r26
                                                            }
                                                            ReturnVal = ReturnVal(state, r23, r43, r9)
                                                            r9 = ReturnVal
                                                            state = "Play"
                                                            state = r9[state]
                                                            state = state(r9)
                                                            r43 = "table"
                                                            ReturnVal = _env[r43]
                                                            r20 = upvalueValues[upvalues[1]]
                                                            r28 = upvalueValues[upvalues[2]]
                                                            r26 = 30541345732493
                                                            r60 = "\241l\254\0172\166"
                                                            r3 = r28(r60, r26)
                                                            r43 = r20[r3]
                                                            state = ReturnVal[r43]
                                                            ReturnVal = state(r22, r9)
                                                            state = upvalueValues[upvalues[6]]
                                                            r28 = "TweenInfo"
                                                            r20 = _env[r28]
                                                            r3 = upvalueValues[upvalues[1]]
                                                            r60 = upvalueValues[upvalues[2]]
                                                            r54 = 21400696760045
                                                            r38 = "\135lA"
                                                            r26 = r60(r38, r54)
                                                            r28 = r3[r26]
                                                            r43 = r20[r28]
                                                            r38 = "Enum"
                                                            r26 = _env[r38]
                                                            r54 = upvalueValues[upvalues[1]]
                                                            r68 = upvalueValues[upvalues[2]]
                                                            r11 = "Fx\137@H\128H\014\167-\191"
                                                            r49 = 16641035050565
                                                            r18 = r68(r11, r49)
                                                            r38 = r54[r18]
                                                            ReturnVal = "Create"
                                                            ReturnVal = state[ReturnVal]
                                                            r60 = r26[r38]
                                                            r38 = upvalueValues[upvalues[1]]
                                                            r54 = upvalueValues[upvalues[2]]
                                                            r11 = 27182309192049
                                                            r18 = "\250\243\244\017"
                                                            r68 = r54(r18, r11)
                                                            r26 = r38[r68]
                                                            r3 = r60[r26]
                                                            r54 = "Enum"
                                                            r38 = _env[r54]
                                                            r68 = upvalueValues[upvalues[1]]
                                                            r18 = upvalueValues[upvalues[2]]
                                                            r25 = 7545182981561
                                                            r49 = "\007-\233\218\233;\240\185\186\148\1622F\200\023"
                                                            r11 = r18(r49, r25)
                                                            r54 = r68[r11]
                                                            r26 = r38[r54]
                                                            r54 = upvalueValues[upvalues[1]]
                                                            r68 = upvalueValues[upvalues[2]]
                                                            r49 = 17486995693519
                                                            r11 = "E\234"
                                                            r18 = r68(r11, r49)
                                                            r38 = r54[r18]
                                                            r60 = r26[r38]
                                                            r28 = 0.5
                                                            r20 = r43(r28, r3, r60)
                                                            r3 = upvalueValues[upvalues[1]]
                                                            r60 = upvalueValues[upvalues[2]]
                                                            r38 = "mr\166\220\210jv{\147i\132\1743X\167b"
                                                            r54 = 28921136968859
                                                            r26 = r60(r38, r54)
                                                            r28 = r3[r26]
                                                            r3 = 0
                                                            r43 = {
                                                                [r28] = r3
                                                            }
                                                            ReturnVal = ReturnVal(state, r7, r20, r43)
                                                            r43 = ReturnVal
                                                            state = "Play"
                                                            state = r43[state]
                                                            state = state(r43)
                                                            r20 = "table"
                                                            ReturnVal = _env[r20]
                                                            r28 = upvalueValues[upvalues[1]]
                                                            r3 = upvalueValues[upvalues[2]]
                                                            r26 = "\208o\029W\012\222"
                                                            r38 = 7705109941763
                                                            r60 = r3(r26, r38)
                                                            r20 = r28[r60]
                                                            state = ReturnVal[r20]
                                                            ReturnVal = state(r22, r43)
                                                            state = {}
                                                            r20 = state
                                                            r28 = 2
                                                            r3 = r28
                                                            r28 = 1
                                                            r60 = r28
                                                            r28 = 0
                                                            r26 = r60 < r28
                                                            ReturnVal = 1
                                                            r28 = ReturnVal - r60
                                                            state = 190
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 186 then
                                                    if state <= 185 then
                                                        if state == 185 then
                                                            r22 = nil
                                                            ReturnVal = {}
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 186 then
                                                            r38 = state
                                                            r68 = upvalueValues[upvalues[3]]
                                                            r11 = upvalueValues[upvalues[1]]
                                                            r49 = upvalueValues[upvalues[2]]
                                                            r31 = 18931438625391
                                                            r65 = "\251{\13014\225"
                                                            r25 = r49(r65, r31)
                                                            r18 = r11[r25]
                                                            r54 = r68[r18]
                                                            state = r54 and (191) or (192)
                                                            r26 = r54
                                                        end
                                                    end
                                                else
                                                    if state <= 187 then
                                                        if state == 187 then
                                                            state = r60
                                                            r20 = r3
                                                            state = 181
                                                        end
                                                    else
                                                        if state == 188 then
                                                            state = upvalueValues[upvalues[4]]
                                                            r3 = upvalueValues[upvalues[1]]
                                                            r60 = upvalueValues[upvalues[2]]
                                                            r54 = 15737685974176
                                                            r38 = "F\005\243\136"
                                                            r26 = r60(r38, r54)
                                                            ReturnVal = r3[r26]
                                                            r26 = upvalueValues[upvalues[7]]
                                                            r60 = r26[r28]
                                                            r38 = upvalueValues[upvalues[1]]
                                                            r54 = upvalueValues[upvalues[2]]
                                                            r11 = 19604995695529
                                                            r18 = "\192\n_\029"
                                                            r68 = r54(r18, r11)
                                                            r26 = r38[r68]
                                                            r3 = r60[r26]
                                                            state[ReturnVal] = r3
                                                            state = upvalueValues[upvalues[4]]
                                                            r3 = upvalueValues[upvalues[1]]
                                                            r60 = upvalueValues[upvalues[2]]
                                                            r54 = 1352961311350
                                                            r38 = "x$\209\228b\227\150\180\n`"
                                                            r26 = r60(r38, r54)
                                                            ReturnVal = r3[r26]
                                                            r26 = upvalueValues[upvalues[7]]
                                                            r60 = r26[r28]
                                                            r38 = upvalueValues[upvalues[1]]
                                                            r54 = upvalueValues[upvalues[2]]
                                                            r11 = 17528789114850
                                                            r18 = "\127\183xdl"
                                                            r68 = r54(r18, r11)
                                                            r26 = r38[r68]
                                                            r3 = r60[r26]
                                                            state[ReturnVal] = r3
                                                            state = upvalueValues[upvalues[4]]
                                                            r3 = upvalueValues[upvalues[1]]
                                                            r60 = upvalueValues[upvalues[2]]
                                                            r54 = 29476099356061
                                                            r38 = "\1371E\136"
                                                            r26 = r60(r38, r54)
                                                            ReturnVal = r3[r26]
                                                            r26 = upvalueValues[upvalues[7]]
                                                            r60 = r26[r28]
                                                            r38 = upvalueValues[upvalues[1]]
                                                            r54 = upvalueValues[upvalues[2]]
                                                            r18 = "\004\0312,"
                                                            r11 = 8130589462218
                                                            r68 = r54(r18, r11)
                                                            r26 = r38[r68]
                                                            r3 = r60[r26]
                                                            state[ReturnVal] = r3
                                                            state = 189
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 197 then
                                            if state <= 193 then
                                                if state <= 191 then
                                                    if state <= 190 then
                                                        if state <= 189 then
                                                            if state == 189 then
                                                                r26 = "math"
                                                                r60 = _env[r26]
                                                                r38 = upvalueValues[upvalues[1]]
                                                                r54 = upvalueValues[upvalues[2]]
                                                                r11 = 5097864317253
                                                                r18 = "\025!\235\174\018"
                                                                r68 = r54(r18, r11)
                                                                r26 = r38[r68]
                                                                r3 = r60[r26]
                                                                r60 = r3(r43)
                                                                r3 = 10
                                                                ReturnVal = r60 % r3
                                                                r3 = 0
                                                                state = ReturnVal == r3
                                                                state = state and (193) or (194)
                                                            end
                                                        else
                                                            if state == 190 then
                                                                r38 = not r26
                                                                r28 = r28 + r60
                                                                ReturnVal = r28 <= r3
                                                                ReturnVal = r38 and ReturnVal
                                                                r38 = r28 >= r3
                                                                r38 = r26 and r38
                                                                ReturnVal = r38 or ReturnVal
                                                                r38 = (195)
                                                                state = ReturnVal and r38
                                                                ReturnVal = (196)
                                                                state = state or ReturnVal
                                                            end
                                                        end
                                                    else
                                                        if state == 191 then
                                                            r68 = state
                                                            r11 = upvalueValues[upvalues[4]]
                                                            r25 = upvalueValues[upvalues[1]]
                                                            r65 = upvalueValues[upvalues[2]]
                                                            r35 = 11394198639801
                                                            r21 = "\160\243\197M\249\243"
                                                            r31 = r65(r21, r35)
                                                            r49 = r25[r31]
                                                            r18 = r11[r49]
                                                            state = r18 and (197) or (198)
                                                            r54 = r18
                                                        end
                                                    end
                                                else
                                                    if state <= 192 then
                                                        if state == 192 then
                                                            state = r38
                                                            r3 = r26
                                                            state = 187
                                                        end
                                                    else
                                                        if state == 193 then
                                                            state = upvalueValues[upvalues[8]]
                                                            r60 = {
                                                                state()
                                                            }
                                                            r3 = r60[2]
                                                            ReturnVal = r60[1]
                                                            r60 = ReturnVal
                                                            r26 = "table"
                                                            ReturnVal = _env[r26]
                                                            r38 = upvalueValues[upvalues[1]]
                                                            r54 = upvalueValues[upvalues[2]]
                                                            r11 = 14015440738686
                                                            r18 = "+\133%\003h\011"
                                                            r68 = r54(r18, r11)
                                                            r26 = r38[r68]
                                                            state = ReturnVal[r26]
                                                            ReturnVal = state(r22, r60)
                                                            r18 = "\144@\231\224\245\196"
                                                            r11 = 1574567985885
                                                            r26 = "table"
                                                            r60 = nil
                                                            ReturnVal = _env[r26]
                                                            r38 = upvalueValues[upvalues[1]]
                                                            r54 = upvalueValues[upvalues[2]]
                                                            r68 = r54(r18, r11)
                                                            r26 = r38[r68]
                                                            state = ReturnVal[r26]
                                                            ReturnVal = state(r22, r3)
                                                            r3 = nil
                                                            state = 194
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 195 then
                                                    if state <= 194 then
                                                        if state == 194 then
                                                            r20 = nil
                                                            r68 = 16538254138901
                                                            r3 = "task"
                                                            ReturnVal = _env[r3]
                                                            r60 = upvalueValues[upvalues[1]]
                                                            r54 = "$\130\201\158"
                                                            r26 = upvalueValues[upvalues[2]]
                                                            r28 = nil
                                                            r38 = r26(r54, r68)
                                                            r3 = r60[r38]
                                                            state = ReturnVal[r3]
                                                            r3 = 0.05
                                                            ReturnVal = state(r3)
                                                            state = 199
                                                        end
                                                    else
                                                        if state == 195 then
                                                            r38 = r28
                                                            state = upvalueValues[upvalues[6]]
                                                            r18 = "TweenInfo"
                                                            r68 = _env[r18]
                                                            r11 = upvalueValues[upvalues[1]]
                                                            r49 = upvalueValues[upvalues[2]]
                                                            r65 = "\\W\237"
                                                            r31 = 19907524322358
                                                            r25 = r49(r65, r31)
                                                            r18 = r11[r25]
                                                            r54 = r68[r18]
                                                            r65 = "Enum"
                                                            r25 = _env[r65]
                                                            r31 = upvalueValues[upvalues[1]]
                                                            r21 = upvalueValues[upvalues[2]]
                                                            r55 = "bvC\135\194\183H\250\132@Y"
                                                            r14 = 12013846779354
                                                            r35 = r21(r55, r14)
                                                            r65 = r31[r35]
                                                            r49 = r25[r65]
                                                            r65 = upvalueValues[upvalues[1]]
                                                            r31 = upvalueValues[upvalues[2]]
                                                            r55 = 18497376051621
                                                            r35 = "g\"\137\196"
                                                            r21 = r31(r35, r55)
                                                            r25 = r65[r21]
                                                            r11 = r49[r25]
                                                            r31 = "Enum"
                                                            r65 = _env[r31]
                                                            r21 = upvalueValues[upvalues[1]]
                                                            r35 = upvalueValues[upvalues[2]]
                                                            r33 = 2215042089991
                                                            r14 = "Q\204)\178\212,\202\135@r:\210\t\190\222"
                                                            r55 = r35(r14, r33)
                                                            r31 = r21[r55]
                                                            r25 = r65[r31]
                                                            r31 = upvalueValues[upvalues[1]]
                                                            r21 = upvalueValues[upvalues[2]]
                                                            r55 = "\186r\182#F"
                                                            r14 = 24450395778169
                                                            r35 = r21(r55, r14)
                                                            r65 = r31[r35]
                                                            r49 = r25[r65]
                                                            r18 = 0.3
                                                            r68 = r54(r18, r11, r49)
                                                            r11 = upvalueValues[upvalues[1]]
                                                            r49 = upvalueValues[upvalues[2]]
                                                            r31 = 7820121558585
                                                            r65 = "\\\003\137_"
                                                            r25 = r49(r65, r31)
                                                            r18 = r11[r25]
                                                            ReturnVal = "Create"
                                                            ReturnVal = state[ReturnVal]
                                                            r25 = "UDim2"
                                                            r49 = _env[r25]
                                                            r65 = upvalueValues[upvalues[1]]
                                                            r31 = upvalueValues[upvalues[2]]
                                                            r35 = "\201S\020"
                                                            r55 = 18525359727026
                                                            r21 = r31(r35, r55)
                                                            r25 = r65[r21]
                                                            r11 = r49[r25]
                                                            r65 = 0
                                                            r31 = 0.22
                                                            r21 = 0
                                                            r25 = 0.22
                                                            r49 = r11(r25, r65, r31, r21)
                                                            r54 = {
                                                                [r18] = r49
                                                            }
                                                            ReturnVal = ReturnVal(state, r23, r68, r54)
                                                            r68 = "table"
                                                            r54 = ReturnVal
                                                            state = "Play"
                                                            state = r54[state]
                                                            state = state(r54)
                                                            ReturnVal = _env[r68]
                                                            r18 = upvalueValues[upvalues[1]]
                                                            r11 = upvalueValues[upvalues[2]]
                                                            r25 = "\176\151\165c\157;"
                                                            r65 = 7256238394674
                                                            r49 = r11(r25, r65)
                                                            r68 = r18[r49]
                                                            state = ReturnVal[r68]
                                                            ReturnVal = state(r20, r54)
                                                            r12 = 33150787976269
                                                            r68 = "task"
                                                            ReturnVal = _env[r68]
                                                            r18 = upvalueValues[upvalues[1]]
                                                            r11 = upvalueValues[upvalues[2]]
                                                            r25 = ">C\154\212"
                                                            r65 = 25467167862355
                                                            r49 = r11(r25, r65)
                                                            r68 = r18[r49]
                                                            state = ReturnVal[r68]
                                                            r68 = 0.3
                                                            ReturnVal = state(r68)
                                                            state = upvalueValues[upvalues[6]]
                                                            r11 = "TweenInfo"
                                                            r18 = _env[r11]
                                                            r49 = upvalueValues[upvalues[1]]
                                                            r25 = upvalueValues[upvalues[2]]
                                                            ReturnVal = "Create"
                                                            ReturnVal = state[ReturnVal]
                                                            r31 = "\178)N"
                                                            r21 = 32352422902489
                                                            r65 = r25(r31, r21)
                                                            r11 = r49[r65]
                                                            r68 = r18[r11]
                                                            r11 = 0.3
                                                            r31 = "Enum"
                                                            r65 = _env[r31]
                                                            r21 = upvalueValues[upvalues[1]]
                                                            r35 = upvalueValues[upvalues[2]]
                                                            r14 = "u\\QTZ\185\022\216\180\166\227"
                                                            r33 = 24440123550836
                                                            r55 = r35(r14, r33)
                                                            r31 = r21[r55]
                                                            r25 = r65[r31]
                                                            r31 = upvalueValues[upvalues[1]]
                                                            r21 = upvalueValues[upvalues[2]]
                                                            r14 = 25382870412843
                                                            r55 = "\163h\240\253"
                                                            r35 = r21(r55, r14)
                                                            r65 = r31[r35]
                                                            r49 = r25[r65]
                                                            r21 = "Enum"
                                                            r33 = "\248hk\192J\1664]J\231Ar@G\022"
                                                            r54 = nil
                                                            r31 = _env[r21]
                                                            r35 = upvalueValues[upvalues[1]]
                                                            r55 = upvalueValues[upvalues[2]]
                                                            r14 = r55(r33, r12)
                                                            r21 = r35[r14]
                                                            r65 = r31[r21]
                                                            r21 = upvalueValues[upvalues[1]]
                                                            r35 = upvalueValues[upvalues[2]]
                                                            r14 = "'\172\001<$"
                                                            r33 = 4845861800144
                                                            r55 = r35(r14, r33)
                                                            r31 = r21[r55]
                                                            r25 = r65[r31]
                                                            r18 = r68(r11, r49, r25)
                                                            r49 = upvalueValues[upvalues[1]]
                                                            r25 = upvalueValues[upvalues[2]]
                                                            r31 = "\147#\008\166"
                                                            r21 = 33754826079590
                                                            r65 = r25(r31, r21)
                                                            r11 = r49[r65]
                                                            r65 = "UDim2"
                                                            r25 = _env[r65]
                                                            r14 = 23936309701514
                                                            r31 = upvalueValues[upvalues[1]]
                                                            r38 = nil
                                                            r21 = upvalueValues[upvalues[2]]
                                                            r55 = "\"\133N"
                                                            r35 = r21(r55, r14)
                                                            r65 = r31[r35]
                                                            r49 = r25[r65]
                                                            r35 = 0
                                                            r65 = 0.2
                                                            r31 = 0
                                                            r21 = 0.2
                                                            r25 = r49(r65, r31, r21, r35)
                                                            r68 = {
                                                                [r11] = r25
                                                            }
                                                            ReturnVal = ReturnVal(state, r23, r18, r68)
                                                            r68 = ReturnVal
                                                            state = "Play"
                                                            state = r68[state]
                                                            state = state(r68)
                                                            r18 = "table"
                                                            ReturnVal = _env[r18]
                                                            r11 = upvalueValues[upvalues[1]]
                                                            r49 = upvalueValues[upvalues[2]]
                                                            r31 = 29472922416540
                                                            r65 = ",cZ\248I\216"
                                                            r25 = r49(r65, r31)
                                                            r18 = r11[r25]
                                                            state = ReturnVal[r18]
                                                            ReturnVal = state(r20, r68)
                                                            r65 = "\014\215\178\203"
                                                            r31 = 16256392797585
                                                            r18 = "task"
                                                            ReturnVal = _env[r18]
                                                            r11 = upvalueValues[upvalues[1]]
                                                            r68 = nil
                                                            r49 = upvalueValues[upvalues[2]]
                                                            r25 = r49(r65, r31)
                                                            r18 = r11[r25]
                                                            state = ReturnVal[r18]
                                                            r18 = 0.3
                                                            ReturnVal = state(r18)
                                                            state = 190
                                                        end
                                                    end
                                                else
                                                    if state <= 196 then
                                                        if state == 196 then
                                                            state = upvalueValues[upvalues[12]]
                                                            ReturnVal = state()
                                                            r28 = ReturnVal
                                                            ReturnVal = "ipairs"
                                                            state = _env[ReturnVal]
                                                            r26 = {
                                                                state(r28)
                                                            }
                                                            ReturnVal = r26[1]
                                                            r60 = r26[3]
                                                            r3 = r26[2]
                                                            r26 = ReturnVal
                                                            state = 200
                                                        end
                                                    else
                                                        if state == 197 then
                                                            r11 = upvalueValues[upvalues[5]]
                                                            r25 = upvalueValues[upvalues[1]]
                                                            r65 = upvalueValues[upvalues[2]]
                                                            r21 = "EH\157\156u\252"
                                                            r35 = 14609449278099
                                                            r31 = r65(r21, r35)
                                                            r49 = r25[r31]
                                                            r18 = r11[r49]
                                                            r54 = r18
                                                            state = 198
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 201 then
                                                if state <= 199 then
                                                    if state <= 198 then
                                                        if state == 198 then
                                                            state = r68
                                                            r26 = r54
                                                            state = 192
                                                        end
                                                    else
                                                        if state == 199 then
                                                            r43 = nil
                                                            r9 = nil
                                                            state = 173
                                                        end
                                                    end
                                                else
                                                    if state <= 200 then
                                                        if state == 200 then
                                                            r60, r54 = r26(r3, r60)
                                                            state = r60 and (201) or (202)
                                                        end
                                                    else
                                                        if state == 201 then
                                                            r38 = r60
                                                            r65 = ";\231\240\1294\147"
                                                            r18 = "table"
                                                            r68 = _env[r18]
                                                            r11 = upvalueValues[upvalues[1]]
                                                            r49 = upvalueValues[upvalues[2]]
                                                            r31 = 10867740021700
                                                            r38 = nil
                                                            r25 = r49(r65, r31)
                                                            r18 = r11[r25]
                                                            state = r68[r18]
                                                            r68 = state(r22, r54)
                                                            r54 = nil
                                                            state = 200
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 203 then
                                                    if state <= 202 then
                                                        if state == 202 then
                                                            r60 = "task"
                                                            r3 = _env[r60]
                                                            r26 = upvalueValues[upvalues[1]]
                                                            r38 = upvalueValues[upvalues[2]]
                                                            r68 = "\145O\246\018"
                                                            r18 = 26851804328151
                                                            r54 = r38(r68, r18)
                                                            r60 = r26[r54]
                                                            state = r3[r60]
                                                            r60 = 0.7
                                                            r3 = state(r60)
                                                            state = upvalueValues[upvalues[13]]
                                                            r68 = {
                                                                state()
                                                            }
                                                            r60 = r68[2]
                                                            r38 = r68[4]
                                                            r54 = r68[5]
                                                            r3 = r68[1]
                                                            r26 = r68[3]
                                                            r68 = "ipairs"
                                                            state = _env[r68]
                                                            r49 = {
                                                                state(r3)
                                                            }
                                                            r68 = r49[1]
                                                            r11 = r49[3]
                                                            r18 = r49[2]
                                                            state = 203
                                                        end
                                                    else
                                                        if state == 203 then
                                                            r11, r25 = r68(r18, r11)
                                                            state = r11 and (204) or (205)
                                                        end
                                                    end
                                                else
                                                    if state <= 204 then
                                                        if state == 204 then
                                                            r49 = r11
                                                            r31 = "table"
                                                            r65 = _env[r31]
                                                            r21 = upvalueValues[upvalues[1]]
                                                            r35 = upvalueValues[upvalues[2]]
                                                            r33 = 32501192096542
                                                            r14 = "\027\156\153S\146\199"
                                                            r55 = r35(r14, r33)
                                                            r49 = nil
                                                            r31 = r21[r55]
                                                            state = r65[r31]
                                                            r65 = state(r22, r25)
                                                            r25 = nil
                                                            state = 203
                                                        end
                                                    else
                                                        if state == 205 then
                                                            r18 = "table"
                                                            r68 = _env[r18]
                                                            r11 = upvalueValues[upvalues[1]]
                                                            r49 = upvalueValues[upvalues[2]]
                                                            r31 = 5231305722244
                                                            r65 = "Iwk4\201\138"
                                                            r25 = r49(r65, r31)
                                                            r18 = r11[r25]
                                                            state = r68[r18]
                                                            r68 = state(r22, r60)
                                                            r68 = "ipairs"
                                                            state = _env[r68]
                                                            r49 = {
                                                                state(r26)
                                                            }
                                                            r11 = r49[3]
                                                            r68 = r49[1]
                                                            r18 = r49[2]
                                                            state = 206
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    if state <= 222 then
                                        if state <= 214 then
                                            if state <= 210 then
                                                if state <= 208 then
                                                    if state <= 207 then
                                                        if state <= 206 then
                                                            if state == 206 then
                                                                r11, r25 = r68(r18, r11)
                                                                state = r11 and (207) or (208)
                                                            end
                                                        else
                                                            if state == 207 then
                                                                r31 = "table"
                                                                r65 = _env[r31]
                                                                r21 = upvalueValues[upvalues[1]]
                                                                r49 = r11
                                                                r35 = upvalueValues[upvalues[2]]
                                                                r33 = 15593096109149
                                                                r14 = "@O?2\129\128"
                                                                r55 = r35(r14, r33)
                                                                r31 = r21[r55]
                                                                state = r65[r31]
                                                                r65 = state(r22, r25)
                                                                r49 = nil
                                                                r25 = nil
                                                                state = 206
                                                            end
                                                        end
                                                    else
                                                        if state == 208 then
                                                            r18 = "table"
                                                            r68 = _env[r18]
                                                            r11 = upvalueValues[upvalues[1]]
                                                            r49 = upvalueValues[upvalues[2]]
                                                            r65 = "oQ\138;6\148"
                                                            r31 = 27858165740204
                                                            r25 = r49(r65, r31)
                                                            r18 = r11[r25]
                                                            state = r68[r18]
                                                            r68 = state(r22, r38)
                                                            r68 = "ipairs"
                                                            state = _env[r68]
                                                            r49 = {
                                                                state(r54)
                                                            }
                                                            r18 = r49[2]
                                                            r11 = r49[3]
                                                            r68 = r49[1]
                                                            state = 209
                                                        end
                                                    end
                                                else
                                                    if state <= 209 then
                                                        if state == 209 then
                                                            r11, r25 = r68(r18, r11)
                                                            state = r11 and (210) or (211)
                                                        end
                                                    else
                                                        if state == 210 then
                                                            r14 = "\146\198QB)\164"
                                                            r49 = r11
                                                            r33 = 26632002482289
                                                            r31 = "table"
                                                            r65 = _env[r31]
                                                            r49 = nil
                                                            r21 = upvalueValues[upvalues[1]]
                                                            r35 = upvalueValues[upvalues[2]]
                                                            r55 = r35(r14, r33)
                                                            r31 = r21[r55]
                                                            state = r65[r31]
                                                            r65 = state(r22, r25)
                                                            r25 = nil
                                                            state = 209
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 212 then
                                                    if state <= 211 then
                                                        if state == 211 then
                                                            r18 = "task"
                                                            r68 = _env[r18]
                                                            r11 = upvalueValues[upvalues[1]]
                                                            r49 = upvalueValues[upvalues[2]]
                                                            r31 = 32234131159714
                                                            r65 = "\179\149N\004"
                                                            r25 = r49(r65, r31)
                                                            r18 = r11[r25]
                                                            state = r68[r18]
                                                            r18 = 0.7
                                                            r68 = state(r18)
                                                            state = upvalueValues[upvalues[9]]
                                                            r68 = "Cancel"
                                                            r68 = state[r68]
                                                            r68 = r68(state)
                                                            r18 = upvalueValues[upvalues[10]]
                                                            state = r18 and (212) or (213)
                                                            r68 = r18
                                                        end
                                                    else
                                                        if state == 212 then
                                                            r11 = upvalueValues[upvalues[10]]
                                                            r25 = upvalueValues[upvalues[1]]
                                                            r65 = upvalueValues[upvalues[2]]
                                                            r35 = 19856102827038
                                                            r21 = "vj.d\175\221"
                                                            r31 = r65(r21, r35)
                                                            r49 = r25[r31]
                                                            r18 = r11[r49]
                                                            r68 = r18
                                                            state = 213
                                                        end
                                                    end
                                                else
                                                    if state <= 213 then
                                                        if state == 213 then
                                                            state = r68 and (214) or (215)
                                                        end
                                                    else
                                                        if state == 214 then
                                                            state = upvalueValues[upvalues[10]]
                                                            r68 = "Stop"
                                                            r68 = state[r68]
                                                            r68 = r68(state)
                                                            state = upvalueValues[upvalues[10]]
                                                            r68 = "Destroy"
                                                            r68 = state[r68]
                                                            r68 = r68(state)
                                                            state = 215
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 218 then
                                                if state <= 216 then
                                                    if state <= 215 then
                                                        if state == 215 then
                                                            r68 = "ipairs"
                                                            state = _env[r68]
                                                            r49 = upvalueValues[upvalues[11]]
                                                            r65 = "GetDescendants"
                                                            r65 = r49[r65]
                                                            r25 = {
                                                                r65(r49)
                                                            }
                                                            r49 = {
                                                                state(unpack(r25))
                                                            }
                                                            r11 = r49[3]
                                                            r18 = r49[2]
                                                            r68 = r49[1]
                                                            state = 216
                                                        end
                                                    else
                                                        if state == 216 then
                                                            r11, r25 = r68(r18, r11)
                                                            state = r11 and (217) or (218)
                                                        end
                                                    end
                                                else
                                                    if state <= 217 then
                                                        if state == 217 then
                                                            r31 = upvalueValues[upvalues[1]]
                                                            r21 = upvalueValues[upvalues[2]]
                                                            r14 = 34177185463850
                                                            r55 = "\1986-\137\185"
                                                            r35 = r21(r55, r14)
                                                            state = "IsA"
                                                            state = r25[state]
                                                            r65 = r31[r35]
                                                            state = state(r25, r65)
                                                            state = state and (219) or (220)
                                                            r49 = r11
                                                        end
                                                    else
                                                        if state == 218 then
                                                            r68 = "ipairs"
                                                            state = _env[r68]
                                                            r49 = {
                                                                state(r22)
                                                            }
                                                            r18 = r49[2]
                                                            r11 = r49[3]
                                                            r68 = r49[1]
                                                            state = 221
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 220 then
                                                    if state <= 219 then
                                                        if state == 219 then
                                                            state = "Stop"
                                                            state = r25[state]
                                                            state = state(r25)
                                                            state = "Destroy"
                                                            state = r25[state]
                                                            state = state(r25)
                                                            state = 220
                                                        end
                                                    else
                                                        if state == 220 then
                                                            r49 = nil
                                                            r25 = nil
                                                            state = 216
                                                        end
                                                    end
                                                else
                                                    if state <= 221 then
                                                        if state == 221 then
                                                            r11, r25 = r68(r18, r11)
                                                            state = r11 and (222) or (223)
                                                        end
                                                    else
                                                        if state == 222 then
                                                            state = r25 and (224) or (225)
                                                            r49 = r11
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 230 then
                                            if state <= 226 then
                                                if state <= 224 then
                                                    if state <= 223 then
                                                        if state == 223 then
                                                            r68 = "ipairs"
                                                            state = _env[r68]
                                                            r49 = {
                                                                state(r20)
                                                            }
                                                            r68 = r49[1]
                                                            r11 = r49[3]
                                                            r18 = r49[2]
                                                            state = 226
                                                        end
                                                    else
                                                        if state == 224 then
                                                            state = "Cancel"
                                                            state = r25[state]
                                                            state = state(r25)
                                                            state = 225
                                                        end
                                                    end
                                                else
                                                    if state <= 225 then
                                                        if state == 225 then
                                                            r25 = nil
                                                            r49 = nil
                                                            state = 221
                                                        end
                                                    else
                                                        if state == 226 then
                                                            r11, r25 = r68(r18, r11)
                                                            state = r11 and (227) or (228)
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 228 then
                                                    if state <= 227 then
                                                        if state == 227 then
                                                            state = r25 and (229) or (230)
                                                            r49 = r11
                                                        end
                                                    else
                                                        if state == 228 then
                                                            r18 = upvalueValues[upvalues[14]]
                                                            state = r18 and (231) or (232)
                                                            r68 = r18
                                                        end
                                                    end
                                                else
                                                    if state <= 229 then
                                                        if state == 229 then
                                                            state = "Cancel"
                                                            state = r25[state]
                                                            state = state(r25)
                                                            state = 230
                                                        end
                                                    else
                                                        if state == 230 then
                                                            r49 = nil
                                                            r25 = nil
                                                            state = 226
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 234 then
                                                if state <= 232 then
                                                    if state <= 231 then
                                                        if state == 231 then
                                                            r11 = upvalueValues[upvalues[14]]
                                                            r25 = upvalueValues[upvalues[1]]
                                                            r65 = upvalueValues[upvalues[2]]
                                                            r21 = "#\007S\197\232\027"
                                                            r35 = 14536754748017
                                                            r31 = r65(r21, r35)
                                                            r49 = r25[r31]
                                                            r18 = r11[r49]
                                                            r68 = r18
                                                            state = 232
                                                        end
                                                    else
                                                        if state == 232 then
                                                            state = r68 and (233) or (234)
                                                        end
                                                    end
                                                else
                                                    if state <= 233 then
                                                        if state == 233 then
                                                            r68 = "warn"
                                                            state = _env[r68]
                                                            r11 = upvalueValues[upvalues[1]]
                                                            r49 = upvalueValues[upvalues[2]]
                                                            r31 = 13592867690681
                                                            r65 = "\133V\005<_\211\215_w\160\188\000\192\198\\=\r\143Q\022\235\184gb\150\250\188\156X\198"
                                                            r25 = r49(r65, r31)
                                                            r18 = r11[r25]
                                                            r68 = state(r18)
                                                            state = upvalueValues[upvalues[14]]
                                                            r68 = "Destroy"
                                                            r68 = state[r68]
                                                            r68 = r68(state)
                                                            state = 235
                                                        end
                                                    else
                                                        if state == 234 then
                                                            r68 = "warn"
                                                            state = _env[r68]
                                                            r11 = upvalueValues[upvalues[1]]
                                                            r49 = upvalueValues[upvalues[2]]
                                                            r65 = "!\127\1761\131'\007\016\176\213\228\006\008\191\175\194\173I\235jo\231<\150@\228\198ZP\157"
                                                            r31 = 6697923300398
                                                            r25 = r49(r65, r31)
                                                            r18 = r11[r25]
                                                            r68 = state(r18)
                                                            state = 235
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 236 then
                                                    if state <= 235 then
                                                        if state == 235 then
                                                            r68 = "pcall"
                                                            state = _env[r68]
                                                            r11 = createClosure2(255, {
                                                                upvalues[15]
                                                            })
                                                            r49 = {
                                                                state(r11)
                                                            }
                                                            r68 = r49[1]
                                                            state = not r68
                                                            state = state and (236) or (237)
                                                            r18 = r49[2]
                                                        end
                                                    else
                                                        if state == 236 then
                                                            r11 = "warn"
                                                            state = _env[r11]
                                                            r65 = upvalueValues[upvalues[1]]
                                                            r31 = upvalueValues[upvalues[2]]
                                                            r55 = 34444279070375
                                                            r35 = "\200\209Rg\234\003Q\237\184\160\005\012\166R\025\127If\153\233"
                                                            r21 = r31(r35, r55)
                                                            r25 = r65[r21]
                                                            r31 = "tostring"
                                                            r65 = _env[r31]
                                                            r31 = r65(r18)
                                                            r49 = r25 .. r31
                                                            r11 = state(r49)
                                                            state = 238
                                                        end
                                                    end
                                                else
                                                    if state <= 237 then
                                                        if state == 237 then
                                                            r11 = "warn"
                                                            state = _env[r11]
                                                            r25 = upvalueValues[upvalues[1]]
                                                            r65 = upvalueValues[upvalues[2]]
                                                            r21 = "Q$rRt\150\"\147\029o\232\128\239"
                                                            r35 = 25606714470036
                                                            r31 = r65(r21, r35)
                                                            r49 = r25[r31]
                                                            r11 = state(r49)
                                                            state = 238
                                                        end
                                                    else
                                                        if state == 238 then
                                                            r60 = nil
                                                            r9 = nil
                                                            r20 = nil
                                                            r18 = nil
                                                            r68 = nil
                                                            r2 = nil
                                                            r3 = nil
                                                            r7 = nil
                                                            r23 = nil
                                                            r26 = nil
                                                            r38 = nil
                                                            r54 = nil
                                                            r28 = nil
                                                            r41 = nil
                                                            r43 = nil
                                                            state = 185
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 249 then
                            if state <= 244 then
                                if state <= 239 then
                                    -- createClosure2 entry 705775 -> 239, states 239-239
                                    if state == 239 then -- entry 705775 -> 239
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r23 = upvalueValues[upvalues[2]]
                                        r2 = upvalueValues[upvalues[3]]
                                        r9 = 21658373056357
                                        r7 = "\143\129}5\249Z\236tb\133S\177\028\131"
                                        r41 = r2(r7, r9)
                                        r22 = r23[r41]
                                        state = ReturnVal[r22]
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure1 entry 2809357 -> 240, states 240-244
                                    if state <= 242 then
                                        if state <= 241 then
                                            if state <= 240 then
                                                if state == 240 then -- entry 2809357 -> 240
                                                    r22 = upvalueValues[upvalues[1]]
                                                    state = r22 and (241) or (242)
                                                    ReturnVal = r22
                                                end
                                            else
                                                if state == 241 then
                                                    r23 = upvalueValues[upvalues[1]]
                                                    r41 = upvalueValues[upvalues[2]]
                                                    r7 = upvalueValues[upvalues[3]]
                                                    r43 = "\238\nU\163\254z"
                                                    r20 = 6018718173938
                                                    r9 = r7(r43, r20)
                                                    r2 = r41[r9]
                                                    r22 = r23[r2]
                                                    ReturnVal = r22
                                                    state = 242
                                                end
                                            end
                                        else
                                            if state == 242 then
                                                state = ReturnVal and (243) or (244)
                                            end
                                        end
                                    else
                                        if state <= 243 then
                                            if state == 243 then
                                                state = upvalueValues[upvalues[4]]
                                                r22 = upvalueValues[upvalues[1]]
                                                r41 = "TweenInfo"
                                                r2 = _env[r41]
                                                r7 = upvalueValues[upvalues[2]]
                                                r9 = upvalueValues[upvalues[3]]
                                                r20 = "\137\178\153"
                                                r28 = 21391080662761
                                                r43 = r9(r20, r28)
                                                r41 = r7[r43]
                                                r23 = r2[r41]
                                                ReturnVal = "Create"
                                                ReturnVal = state[ReturnVal]
                                                r41 = 0.5
                                                r2 = r23(r41)
                                                r7 = upvalueValues[upvalues[2]]
                                                r9 = upvalueValues[upvalues[3]]
                                                r28 = 34492459269821
                                                r20 = "t\020N\015\005t)>\131~-\181#;\1713\138.:\174\t~"
                                                r43 = r9(r20, r28)
                                                r41 = r7[r43]
                                                r7 = 1
                                                r23 = {
                                                    [r41] = r7
                                                }
                                                ReturnVal = ReturnVal(state, r22, r2, r23)
                                                state = "Play"
                                                state = ReturnVal[state]
                                                state = state(ReturnVal)
                                                r22 = "task"
                                                ReturnVal = _env[r22]
                                                r23 = upvalueValues[upvalues[2]]
                                                r2 = upvalueValues[upvalues[3]]
                                                r7 = "\152p\007KQ"
                                                r9 = 14028994320772
                                                r41 = r2(r7, r9)
                                                r22 = r23[r41]
                                                r23 = createClosure3(256, {
                                                    upvalues[1],
                                                    upvalues[2],
                                                    upvalues[3]
                                                })
                                                state = ReturnVal[r22]
                                                r22 = 0.5
                                                ReturnVal = state(r22, r23)
                                                state = 244
                                            end
                                        else
                                            if state == 244 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure1 entry 11500218 -> 245, states 245-249
                                if state <= 247 then
                                    if state <= 246 then
                                        if state <= 245 then
                                            if state == 245 then -- entry 11500218 -> 245
                                                r22 = upvalueValues[upvalues[1]]
                                                state = r22 and (246) or (247)
                                                ReturnVal = r22
                                            end
                                        else
                                            if state == 246 then
                                                r23 = upvalueValues[upvalues[1]]
                                                r41 = upvalueValues[upvalues[2]]
                                                r7 = upvalueValues[upvalues[3]]
                                                r43 = "\004\017+\151\140H"
                                                r20 = 24733156748541
                                                r9 = r7(r43, r20)
                                                r2 = r41[r9]
                                                r22 = r23[r2]
                                                ReturnVal = r22
                                                state = 247
                                            end
                                        end
                                    else
                                        if state == 247 then
                                            state = ReturnVal and (248) or (249)
                                        end
                                    end
                                else
                                    if state <= 248 then
                                        if state == 248 then
                                            state = upvalueValues[upvalues[1]]
                                            ReturnVal = "Destroy"
                                            ReturnVal = state[ReturnVal]
                                            ReturnVal = ReturnVal(state)
                                            state = 249
                                        end
                                    else
                                        if state == 249 then
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 255 then
                                if state <= 254 then
                                    -- createClosure0 entry 2566117 -> 250, states 250-254
                                    if state <= 252 then
                                        if state <= 251 then
                                            if state <= 250 then
                                                if state == 250 then -- entry 2566117 -> 250
                                                    r22 = upvalueValues[upvalues[1]]
                                                    state = r22 and (251) or (252)
                                                    ReturnVal = r22
                                                end
                                            else
                                                if state == 251 then
                                                    r23 = upvalueValues[upvalues[1]]
                                                    r41 = upvalueValues[upvalues[2]]
                                                    r7 = upvalueValues[upvalues[3]]
                                                    r43 = "\227\216\012\160p\022"
                                                    r20 = 23326743980654
                                                    r9 = r7(r43, r20)
                                                    r2 = r41[r9]
                                                    r22 = r23[r2]
                                                    ReturnVal = r22
                                                    state = 252
                                                end
                                            end
                                        else
                                            if state == 252 then
                                                state = ReturnVal and (253) or (254)
                                            end
                                        end
                                    else
                                        if state <= 253 then
                                            if state == 253 then
                                                state = upvalueValues[upvalues[1]]
                                                ReturnVal = "Destroy"
                                                ReturnVal = state[ReturnVal]
                                                ReturnVal = ReturnVal(state)
                                                state = 254
                                            end
                                        else
                                            if state == 254 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure2 entry 15817525 -> 255, states 255-255
                                    if state == 255 then -- entry 15817525 -> 255
                                        ReturnVal = "loadstring"
                                        state = _env[ReturnVal]
                                        r23 = "game"
                                        r22 = _env[r23]
                                        r41 = "HttpGet"
                                        r41 = r22[r41]
                                        r2 = upvalueValues[upvalues[1]]
                                        r23 = {
                                            r41(r22, r2)
                                        }
                                        ReturnVal = state(unpack(r23))
                                        state = {
                                            ReturnVal()
                                        }
                                        ReturnVal = {
                                            unpack(state)
                                        }
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure3 entry 15898817 -> 256, states 256-260
                                if state <= 258 then
                                    if state <= 257 then
                                        if state <= 256 then
                                            if state == 256 then -- entry 15898817 -> 256
                                                r22 = upvalueValues[upvalues[1]]
                                                state = r22 and (257) or (258)
                                                ReturnVal = r22
                                            end
                                        else
                                            if state == 257 then
                                                r23 = upvalueValues[upvalues[1]]
                                                r41 = upvalueValues[upvalues[2]]
                                                r7 = upvalueValues[upvalues[3]]
                                                r43 = "\137\031\179\217\031A"
                                                r20 = 30958506260560
                                                r9 = r7(r43, r20)
                                                r2 = r41[r9]
                                                r22 = r23[r2]
                                                ReturnVal = r22
                                                state = 258
                                            end
                                        end
                                    else
                                        if state == 258 then
                                            state = ReturnVal and (259) or (260)
                                        end
                                    end
                                else
                                    if state <= 259 then
                                        if state == 259 then
                                            state = upvalueValues[upvalues[1]]
                                            ReturnVal = "Destroy"
                                            ReturnVal = state[ReturnVal]
                                            ReturnVal = ReturnVal(state)
                                            state = 260
                                        end
                                    else
                                        if state == 260 then
                                            ReturnVal = {}
                                            state = nil
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 705962
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 705962
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
        currentUpvalueId = 0
        upvalueValues = {}
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
            end
            return closure
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
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        upvalueRefCounts = {}
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)