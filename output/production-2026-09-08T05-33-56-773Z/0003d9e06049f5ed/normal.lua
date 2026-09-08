return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, upvalueValues, releaseUpvalue, createClosure3, allocUpvalue, createClosure1, createUpvalueProxy, createClosure7, createClosure2, currentUpvalueId, createClosure5, upvalueRefCounts, createClosure4, releaseUpvalues, createClosure, createClosure0, vm)
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, ReturnVal, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88
            while state do
                if state <= 164 then
                    if state <= 62 then
                        if state <= 40 then
                            if state <= 38 then
                                if state <= 37 then
                                    -- root entry 1957554 -> 1, states 1-37
                                    if state <= 19 then
                                        if state <= 10 then
                                            if state <= 5 then
                                                if state <= 3 then
                                                    if state <= 2 then
                                                        if state <= 1 then
                                                            if state == 1 then -- entry 1957554 -> 1
                                                                r57 = allocUpvalue()
                                                                state = true
                                                                upvalueValues[r57] = state
                                                                r43 = allocUpvalue()
                                                                r61 = "string"
                                                                ReturnVal = _env[r61]
                                                                r61 = "gmatch"
                                                                state = ReturnVal[r61]
                                                                r61 = allocUpvalue()
                                                                upvalueValues[r61] = state
                                                                r14 = allocUpvalue()
                                                                state = createClosure4(38, {})
                                                                upvalueValues[r43] = state
                                                                r31 = createClosure4(39, {
                                                                    r14
                                                                })
                                                                state = false
                                                                upvalueValues[r14] = state
                                                                r75 = "pcall"
                                                                r17 = _env[r75]
                                                                r75 = r17(r31)
                                                                state = r75 and (2) or (3)
                                                                r38 = args
                                                                ReturnVal = r75
                                                            end
                                                        else
                                                            if state == 2 then
                                                                r17 = upvalueValues[r14]
                                                                ReturnVal = r17
                                                                state = 3
                                                            end
                                                        end
                                                    else
                                                        if state == 3 then
                                                            r17 = ReturnVal
                                                            r75 = "math"
                                                            ReturnVal = _env[r75]
                                                            r75 = "random"
                                                            state = ReturnVal[r75]
                                                            r75 = allocUpvalue()
                                                            upvalueValues[r75] = state
                                                            r31 = "table"
                                                            ReturnVal = _env[r31]
                                                            r31 = "concat"
                                                            state = ReturnVal[r31]
                                                            r83 = state
                                                            r31 = state
                                                            r88 = "table"
                                                            r4 = _env[r88]
                                                            state = r4 and (4) or (5)
                                                            r20 = r4
                                                        end
                                                    end
                                                else
                                                    if state <= 4 then
                                                        if state == 4 then
                                                            r54 = "table"
                                                            r88 = _env[r54]
                                                            r54 = "unpack"
                                                            r4 = r88[r54]
                                                            r20 = r4
                                                            state = 5
                                                        end
                                                    else
                                                        if state == 5 then
                                                            state = r83
                                                            state = r20 and (6) or (7)
                                                            ReturnVal = r20
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 8 then
                                                    if state <= 7 then
                                                        if state <= 6 then
                                                            if state == 6 then
                                                                r20 = allocUpvalue()
                                                                upvalueValues[r20] = ReturnVal
                                                                state = upvalueValues[r75]
                                                                r4 = 65
                                                                r83 = 3
                                                                ReturnVal = state(r83, r4)
                                                                r39 = createClosure0(40, {})
                                                                state = 0
                                                                r83 = allocUpvalue()
                                                                upvalueValues[r83] = ReturnVal
                                                                r4 = state
                                                                state = 0
                                                                r54 = "pcall"
                                                                ReturnVal = _env[r54]
                                                                r54 = {
                                                                    ReturnVal(r39)
                                                                }
                                                                r88 = state
                                                                state = {
                                                                    unpack(r54)
                                                                }
                                                                r54 = state
                                                                ReturnVal = 2
                                                                state = r54[ReturnVal]
                                                                r39 = state
                                                                ReturnVal = "tonumber"
                                                                state = _env[ReturnVal]
                                                                r63 = upvalueValues[r61]
                                                                r82 = "tostring"
                                                                r6 = _env[r82]
                                                                r82 = r6(r39)
                                                                r6 = ":(%d*):"
                                                                r85 = r63(r82, r6)
                                                                r63 = {
                                                                    r85()
                                                                }
                                                                ReturnVal = state(unpack(r63))
                                                                r63 = allocUpvalue()
                                                                upvalueValues[r63] = ReturnVal
                                                                r85 = upvalueValues[r83]
                                                                r6 = r85
                                                                r85 = 1
                                                                r82 = r85
                                                                r85 = 0
                                                                r59 = r82 < r85
                                                                ReturnVal = 1
                                                                r85 = ReturnVal - r82
                                                                state = 8
                                                            end
                                                        else
                                                            if state == 7 then
                                                                r83 = "unpack"
                                                                r20 = _env[r83]
                                                                ReturnVal = r20
                                                                state = 6
                                                            end
                                                        end
                                                    else
                                                        if state == 8 then
                                                            r87 = not r59
                                                            r85 = r85 + r82
                                                            ReturnVal = r85 <= r6
                                                            ReturnVal = r87 and ReturnVal
                                                            r87 = r85 >= r6
                                                            r87 = r59 and r87
                                                            ReturnVal = r87 or ReturnVal
                                                            r87 = (9)
                                                            state = ReturnVal and r87
                                                            ReturnVal = (10)
                                                            state = state or ReturnVal
                                                        end
                                                    end
                                                else
                                                    if state <= 9 then
                                                        if state == 9 then
                                                            r87 = allocUpvalue()
                                                            upvalueValues[r87] = r85
                                                            r50 = "math"
                                                            ReturnVal = _env[r50]
                                                            r50 = "random"
                                                            state = ReturnVal[r50]
                                                            r23 = 100
                                                            r50 = 1
                                                            ReturnVal = state(r50, r23)
                                                            r50 = allocUpvalue()
                                                            upvalueValues[r50] = ReturnVal
                                                            state = upvalueValues[r75]
                                                            r23 = 0
                                                            r52 = 255
                                                            ReturnVal = state(r23, r52)
                                                            r23 = allocUpvalue()
                                                            upvalueValues[r23] = ReturnVal
                                                            state = upvalueValues[r75]
                                                            r16 = upvalueValues[r50]
                                                            r52 = 1
                                                            ReturnVal = state(r52, r16)
                                                            r52 = allocUpvalue()
                                                            upvalueValues[r52] = ReturnVal
                                                            ReturnVal = upvalueValues[r75]
                                                            r12 = 2
                                                            r26 = 1
                                                            r16 = ReturnVal(r26, r12)
                                                            ReturnVal = 1
                                                            state = r16 == ReturnVal
                                                            r16 = allocUpvalue()
                                                            upvalueValues[r16] = state
                                                            r42 = "tostring"
                                                            r24 = _env[r42]
                                                            r46 = upvalueValues[r75]
                                                            r73 = 0
                                                            r30 = 10000
                                                            r56 = {
                                                                r46(r73, r30)
                                                            }
                                                            r42 = r24(unpack(r56))
                                                            r24 = ":"
                                                            r62 = r42 .. r24
                                                            r12 = ":"
                                                            r26 = r12 .. r62
                                                            state = "gsub"
                                                            state = r39[state]
                                                            ReturnVal = ":(%d*):"
                                                            state = state(r39, ReturnVal, r26)
                                                            r26 = allocUpvalue()
                                                            upvalueValues[r26] = state
                                                            r12 = "pcall"
                                                            ReturnVal = _env[r12]
                                                            r62 = createClosure0(41, {
                                                                r75,
                                                                r87,
                                                                r83,
                                                                r61,
                                                                r57,
                                                                r63,
                                                                r16,
                                                                r26,
                                                                r50,
                                                                r52,
                                                                r23,
                                                                r20
                                                            })
                                                            r12 = {
                                                                ReturnVal(r62)
                                                            }
                                                            state = {
                                                                unpack(r12)
                                                            }
                                                            r12 = state
                                                            state = upvalueValues[r16]
                                                            state = state and (11) or (12)
                                                        end
                                                    else
                                                        if state == 10 then
                                                            r6 = upvalueValues[r57]
                                                            state = r6 and (13) or (14)
                                                            r85 = r6
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
                                                                r62 = upvalueValues[r57]
                                                                state = r62 and (15) or (16)
                                                                ReturnVal = r62
                                                            end
                                                        else
                                                            if state == 12 then
                                                                r24 = upvalueValues[r57]
                                                                state = r24 and (17) or (18)
                                                                r62 = r24
                                                            end
                                                        end
                                                    else
                                                        if state == 13 then
                                                            r6 = r4 == r88
                                                            r85 = r6
                                                            state = 14
                                                        end
                                                    end
                                                else
                                                    if state <= 14 then
                                                        if state == 14 then
                                                            upvalueValues[r57] = r85
                                                            state = upvalueValues[r57]
                                                            state = state and (19) or (20)
                                                        end
                                                    else
                                                        if state == 15 then
                                                            r24 = state
                                                            r56 = 1
                                                            r46 = r12[r56]
                                                            r56 = false
                                                            r42 = r46 == r56
                                                            state = r42 and (21) or (22)
                                                            r62 = r42
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 17 then
                                                    if state <= 16 then
                                                        if state == 16 then
                                                            upvalueValues[r57] = ReturnVal
                                                            state = 23
                                                        end
                                                    else
                                                        if state == 17 then
                                                            r42 = 1
                                                            r24 = r12[r42]
                                                            r62 = r24
                                                            state = 18
                                                        end
                                                    end
                                                else
                                                    if state <= 18 then
                                                        if state == 18 then
                                                            upvalueValues[r57] = r62
                                                            r56 = upvalueValues[r52]
                                                            r73 = 1
                                                            r46 = r56 + r73
                                                            r42 = r12[r46]
                                                            r24 = r4 + r42
                                                            r42 = 256
                                                            state = r24 % r42
                                                            r4 = state
                                                            r46 = upvalueValues[r23]
                                                            r42 = r88 + r46
                                                            r46 = 256
                                                            r24 = r42 % r46
                                                            r88 = r24
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
                                        if state <= 28 then
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
                                                                r56 = 2
                                                                r46 = r12[r56]
                                                                r56 = upvalueValues[r26]
                                                                r42 = r46 == r56
                                                                r62 = r42
                                                                state = 22
                                                            end
                                                        end
                                                    else
                                                        if state == 22 then
                                                            state = r24
                                                            ReturnVal = r62
                                                            state = 16
                                                        end
                                                    end
                                                else
                                                    if state <= 23 then
                                                        if state == 23 then
                                                            r26 = releaseUpvalue(r26)
                                                            r16 = releaseUpvalue(r16)
                                                            r12 = nil
                                                            r23 = releaseUpvalue(r23)
                                                            r52 = releaseUpvalue(r52)
                                                            r50 = releaseUpvalue(r50)
                                                            r87 = releaseUpvalue(r87)
                                                            state = 8
                                                        end
                                                    else
                                                        if state == 24 then
                                                            r57 = releaseUpvalue(r57)
                                                            r83 = releaseUpvalue(r83)
                                                            r75 = releaseUpvalue(r75)
                                                            r61 = releaseUpvalue(r61)
                                                            r83 = allocUpvalue()
                                                            r43 = releaseUpvalue(r43)
                                                            r63 = releaseUpvalue(r63)
                                                            r43 = allocUpvalue()
                                                            r88 = nil
                                                            r88 = allocUpvalue()
                                                            r4 = nil
                                                            r4 = {}
                                                            r14 = releaseUpvalue(r14)
                                                            r20 = releaseUpvalue(r20)
                                                            r57 = nil
                                                            upvalueValues[r43] = r57
                                                            r57 = allocUpvalue()
                                                            r61 = nil
                                                            upvalueValues[r57] = r61
                                                            r17 = nil
                                                            r17 = "math"
                                                            r14 = _env[r17]
                                                            r17 = "floor"
                                                            r61 = r14[r17]
                                                            r14 = allocUpvalue()
                                                            upvalueValues[r14] = r61
                                                            r75 = "math"
                                                            r17 = _env[r75]
                                                            r75 = "random"
                                                            r61 = r17[r75]
                                                            r31 = nil
                                                            r31 = "table"
                                                            r75 = _env[r31]
                                                            r31 = "remove"
                                                            r17 = r75[r31]
                                                            r20 = "string"
                                                            r31 = _env[r20]
                                                            r54 = nil
                                                            r54 = {}
                                                            r20 = "char"
                                                            r75 = r31[r20]
                                                            r63 = 256
                                                            r20 = allocUpvalue()
                                                            r31 = 0
                                                            upvalueValues[r20] = r31
                                                            r31 = 2
                                                            upvalueValues[r83] = r31
                                                            upvalueValues[r88] = r4
                                                            r59 = r63
                                                            r31 = {}
                                                            r63 = 1
                                                            r87 = r63
                                                            r63 = 0
                                                            r50 = r87 < r63
                                                            r39 = nil
                                                            r39 = 1
                                                            r63 = r39 - r87
                                                            r4 = 0
                                                            state = 26
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 26 then
                                                    if state <= 25 then
                                                        if state == 25 then
                                                            state = createClosure0(53, {
                                                                r43
                                                            })
                                                            r6 = {
                                                                state()
                                                            }
                                                            ReturnVal = {
                                                                unpack(r6)
                                                            }
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 26 then
                                                            r23 = not r50
                                                            r63 = r63 + r87
                                                            r39 = r63 <= r59
                                                            r39 = r23 and r39
                                                            r23 = r63 >= r59
                                                            r23 = r50 and r23
                                                            r39 = r23 or r39
                                                            r23 = (27)
                                                            state = r39 and r23
                                                            r39 = (28)
                                                            state = state or r39
                                                        end
                                                    end
                                                else
                                                    if state <= 27 then
                                                        if state == 27 then
                                                            r39 = r63
                                                            r23 = r39
                                                            r54[r39] = r23
                                                            r39 = nil
                                                            state = 26
                                                        end
                                                    else
                                                        if state == 28 then
                                                            r63 = #r54
                                                            r59 = 0
                                                            r39 = r63 == r59
                                                            state = 29
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 33 then
                                                if state <= 31 then
                                                    if state <= 30 then
                                                        if state <= 29 then
                                                            if state == 29 then
                                                                r63 = 1
                                                                r59 = #r54
                                                                r39 = r61(r63, r59)
                                                                r63 = r17(r54, r39)
                                                                r59 = upvalueValues[r88]
                                                                r23 = 1
                                                                r50 = r63 - r23
                                                                r39 = nil
                                                                r87 = r75(r50)
                                                                r59[r63] = r87
                                                                r63 = nil
                                                                state = 30
                                                            end
                                                        else
                                                            if state == 30 then
                                                                r63 = #r54
                                                                r59 = 0
                                                                r39 = r63 == r59
                                                                state = r39 and (31) or (29)
                                                            end
                                                        end
                                                    else
                                                        if state == 31 then
                                                            r63 = allocUpvalue()
                                                            r39 = {}
                                                            upvalueValues[r63] = r39
                                                            r23 = {}
                                                            r54 = nil
                                                            r39 = allocUpvalue()
                                                            r59 = createClosure4(57, {
                                                                r63,
                                                                r20,
                                                                r83,
                                                                r14
                                                            })
                                                            upvalueValues[r39] = r59
                                                            r59 = {}
                                                            r87 = allocUpvalue()
                                                            upvalueValues[r87] = r59
                                                            r50 = "setmetatable"
                                                            r59 = _env[r50]
                                                            r26 = upvalueValues[r87]
                                                            r42 = nil
                                                            r16 = "__index"
                                                            r12 = "__metatable"
                                                            r52 = {
                                                                [r16] = r26,
                                                                [r12] = r42
                                                            }
                                                            r50 = r59(r23, r52)
                                                            upvalueValues[r57] = r50
                                                            r59 = createClosure7(63, {
                                                                r87,
                                                                r63,
                                                                r88,
                                                                r20,
                                                                r83,
                                                                r39
                                                            })
                                                            r39 = releaseUpvalue(r39)
                                                            upvalueValues[r43] = r59
                                                            r88 = releaseUpvalue(r88)
                                                            r63 = releaseUpvalue(r63)
                                                            r20 = releaseUpvalue(r20)
                                                            r14 = releaseUpvalue(r14)
                                                            r14 = createClosure5(70, {
                                                                r57,
                                                                r43
                                                            })
                                                            r61 = nil
                                                            r61 = allocUpvalue()
                                                            r83 = releaseUpvalue(r83)
                                                            upvalueValues[r61] = r14
                                                            r87 = releaseUpvalue(r87)
                                                            r14 = allocUpvalue()
                                                            r17 = nil
                                                            r17 = createClosure7(71, {
                                                                r57,
                                                                r43,
                                                                r14
                                                            })
                                                            upvalueValues[r14] = r17
                                                            r20 = 3
                                                            r17 = allocUpvalue()
                                                            r75 = nil
                                                            r75 = createClosure2(86, {
                                                                r57,
                                                                r43,
                                                                r61
                                                            })
                                                            upvalueValues[r17] = r75
                                                            r83 = r20
                                                            r20 = 1
                                                            r75 = createClosure1(161, {
                                                                r61,
                                                                r17,
                                                                r57,
                                                                r43
                                                            })
                                                            r4 = nil
                                                            r4 = r20
                                                            r20 = 0
                                                            r88 = r4 < r20
                                                            r31 = nil
                                                            r31 = 1
                                                            r20 = r31 - r4
                                                            state = 32
                                                        end
                                                    end
                                                else
                                                    if state <= 32 then
                                                        if state == 32 then
                                                            r20 = r20 + r4
                                                            r31 = r20 <= r83
                                                            r54 = not r88
                                                            r31 = r54 and r31
                                                            r54 = r20 >= r83
                                                            r54 = r88 and r54
                                                            r31 = r54 or r31
                                                            r54 = (33)
                                                            state = r31 and r54
                                                            r31 = (34)
                                                            state = state or r31
                                                        end
                                                    else
                                                        if state == 33 then
                                                            r31 = r20
                                                            r63 = 0.1
                                                            r54 = r75()
                                                            r31 = nil
                                                            r39 = "wait"
                                                            r54 = _env[r39]
                                                            r39 = r54(r63)
                                                            state = 32
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 35 then
                                                    if state <= 34 then
                                                        if state == 34 then
                                                            r20 = createClosure0(164, {
                                                                r57,
                                                                r43
                                                            })
                                                            r31 = createClosure1(165, {
                                                                r57,
                                                                r43
                                                            })
                                                            r83 = r31()
                                                            state = r83 and (35) or (36)
                                                        end
                                                    else
                                                        if state == 35 then
                                                            r83 = r20()
                                                            state = 37
                                                        end
                                                    end
                                                else
                                                    if state <= 36 then
                                                        if state == 36 then
                                                            r4 = "warn"
                                                            r83 = _env[r4]
                                                            r54 = upvalueValues[r57]
                                                            r39 = upvalueValues[r43]
                                                            r87 = 19962681828431
                                                            r59 = "c\221)E\204\148\157\006~O_S\n*\132\199/\238\015}\129\172{h4\198\004\149"
                                                            r63 = r39(r59, r87)
                                                            r88 = r54[r63]
                                                            r4 = r83(r88)
                                                            r4 = "game"
                                                            r83 = _env[r4]
                                                            r4 = "Shutdown"
                                                            r4 = r83[r4]
                                                            r4 = r4(r83)
                                                            state = 37
                                                        end
                                                    else
                                                        if state == 37 then
                                                            r57 = releaseUpvalue(r57)
                                                            r14 = releaseUpvalue(r14)
                                                            r17 = releaseUpvalue(r17)
                                                            ReturnVal = {}
                                                            r43 = releaseUpvalue(r43)
                                                            r31 = nil
                                                            r20 = nil
                                                            r61 = releaseUpvalue(r61)
                                                            r75 = nil
                                                            state = nil
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure4 entry 12646598 -> 38, states 38-38
                                    if state == 38 then -- entry 12646598 -> 38
                                        ReturnVal = "error"
                                        state = _env[ReturnVal]
                                        r38 = "Tamper Detected!"
                                        ReturnVal = state(r38)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                if state <= 39 then
                                    -- createClosure4 entry 1897049 -> 39, states 39-39
                                    if state == 39 then -- entry 1897049 -> 39
                                        state = true
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure0 entry 5322535 -> 40, states 40-40
                                    if state == 40 then -- entry 5322535 -> 40
                                        r57 = "0zW1NUl"
                                        r61 = 8756385
                                        r38 = r57 ^ r61
                                        ReturnVal = 12623673
                                        state = ReturnVal - r38
                                        r38 = state
                                        ReturnVal = "Xgx9owkOfr7R"
                                        state = ReturnVal / r38
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 56 then
                                if state <= 52 then
                                    -- createClosure0 entry 8755609 -> 41, states 41-52
                                    if state <= 46 then
                                        if state <= 43 then
                                            if state <= 42 then
                                                if state <= 41 then
                                                    if state == 41 then -- entry 8755609 -> 41
                                                        r57 = upvalueValues[upvalues[1]]
                                                        r14 = 2
                                                        r43 = 1
                                                        r61 = r57(r43, r14)
                                                        r57 = 1
                                                        r38 = r61 == r57
                                                        state = r38 and (42) or (43)
                                                        ReturnVal = r38
                                                    end
                                                else
                                                    if state == 42 then
                                                        state = ReturnVal and (44) or (45)
                                                    end
                                                end
                                            else
                                                if state == 43 then
                                                    r57 = upvalueValues[upvalues[2]]
                                                    r61 = upvalueValues[upvalues[3]]
                                                    r38 = r57 == r61
                                                    ReturnVal = r38
                                                    state = 42
                                                end
                                            end
                                        else
                                            if state <= 45 then
                                                if state <= 44 then
                                                    if state == 44 then
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r20 = createClosure2(172, {})
                                                        r38 = upvalueValues[upvalues[4]]
                                                        r43 = "tostring"
                                                        r61 = _env[r43]
                                                        r31 = "pcall"
                                                        r75 = _env[r31]
                                                        r31 = {
                                                            r75(r20)
                                                        }
                                                        r17 = {
                                                            unpack(r31)
                                                        }
                                                        r75 = 2
                                                        r14 = r17[r75]
                                                        r43 = r61(r14)
                                                        r61 = ":(%d*):"
                                                        r57 = r38(r43, r61)
                                                        r38 = {
                                                            r57()
                                                        }
                                                        ReturnVal = state(unpack(r38))
                                                        r38 = ReturnVal
                                                        r57 = upvalueValues[upvalues[5]]
                                                        state = r57 and (46) or (47)
                                                        ReturnVal = r57
                                                    end
                                                else
                                                    if state == 45 then
                                                        state = upvalueValues[upvalues[7]]
                                                        state = state and (48) or (49)
                                                    end
                                                end
                                            else
                                                if state == 46 then
                                                    r61 = upvalueValues[upvalues[6]]
                                                    r57 = r61 == r38
                                                    ReturnVal = r57
                                                    state = 47
                                                end
                                            end
                                        end
                                    else
                                        if state <= 49 then
                                            if state <= 48 then
                                                if state <= 47 then
                                                    if state == 47 then
                                                        r38 = nil
                                                        upvalueValues[upvalues[5]] = ReturnVal
                                                        state = 45
                                                    end
                                                else
                                                    if state == 48 then
                                                        r38 = "error"
                                                        state = _env[r38]
                                                        r57 = upvalueValues[upvalues[8]]
                                                        r61 = 0
                                                        r38 = state(r57, r61)
                                                        state = 49
                                                    end
                                                end
                                            else
                                                if state == 49 then
                                                    r61 = upvalueValues[upvalues[9]]
                                                    r43 = r61
                                                    state = {}
                                                    r38 = state
                                                    r61 = 1
                                                    r14 = r61
                                                    r61 = 0
                                                    r17 = r14 < r61
                                                    r57 = 1
                                                    r61 = r57 - r14
                                                    state = 50
                                                end
                                            end
                                        else
                                            if state <= 51 then
                                                if state <= 50 then
                                                    if state == 50 then
                                                        r61 = r61 + r14
                                                        r75 = not r17
                                                        r57 = r61 <= r43
                                                        r57 = r75 and r57
                                                        r75 = r61 >= r43
                                                        r75 = r17 and r75
                                                        r57 = r75 or r57
                                                        r75 = (51)
                                                        state = r57 and r75
                                                        r57 = (52)
                                                        state = state or r57
                                                    end
                                                else
                                                    if state == 51 then
                                                        state = upvalueValues[upvalues[1]]
                                                        r20 = 255
                                                        r31 = 0
                                                        r75 = state(r31, r20)
                                                        r57 = r61
                                                        r38[r57] = r75
                                                        r57 = nil
                                                        state = 50
                                                    end
                                                end
                                            else
                                                if state == 52 then
                                                    state = upvalueValues[upvalues[10]]
                                                    r57 = upvalueValues[upvalues[11]]
                                                    r38[state] = r57
                                                    state = upvalueValues[upvalues[12]]
                                                    r57 = {
                                                        state(r38)
                                                    }
                                                    ReturnVal = {
                                                        unpack(r57)
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure0 entry 8212059 -> 53, states 53-56
                                    if state <= 54 then
                                        if state <= 53 then
                                            if state == 53 then -- entry 8212059 -> 53
                                                state = 54
                                            end
                                        else
                                            if state == 54 then
                                                state = true
                                                state = state and (55) or (56)
                                            end
                                        end
                                    else
                                        if state <= 55 then
                                            if state == 55 then
                                                ReturnVal = "l2"
                                                state = _env[ReturnVal]
                                                r38 = "l1"
                                                ReturnVal = _env[r38]
                                                r38 = "l1"
                                                _env[r38] = state
                                                r38 = "l2"
                                                _env[r38] = ReturnVal
                                                r38 = upvalueValues[upvalues[1]]
                                                r57 = r38()
                                                state = 54
                                            end
                                        else
                                            if state == 56 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure4 entry 13492166 -> 57, states 57-62
                                if state <= 59 then
                                    if state <= 58 then
                                        if state <= 57 then
                                            if state == 57 then -- entry 13492166 -> 57
                                                r38 = upvalueValues[upvalues[1]]
                                                ReturnVal = #r38
                                                r38 = 0
                                                state = ReturnVal == r38
                                                state = state and (58) or (59)
                                            end
                                        else
                                            if state == 58 then
                                                r57 = upvalueValues[upvalues[2]]
                                                r61 = 153
                                                r38 = r57 * r61
                                                r57 = 27839225655971
                                                ReturnVal = r38 + r57
                                                r38 = 35184372088832
                                                state = ReturnVal % r38
                                                upvalueValues[upvalues[2]] = state
                                                r38 = upvalueValues[upvalues[3]]
                                                r57 = 1
                                                ReturnVal = r38 ~= r57
                                                state = 60
                                            end
                                        end
                                    else
                                        if state == 59 then
                                            r61 = "table"
                                            r57 = _env[r61]
                                            r61 = "remove"
                                            r38 = r57[r61]
                                            r61 = upvalueValues[upvalues[1]]
                                            r57 = {
                                                r38(r61)
                                            }
                                            ReturnVal = {
                                                unpack(r57)
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    if state <= 61 then
                                        if state <= 60 then
                                            if state == 60 then
                                                r57 = upvalueValues[upvalues[3]]
                                                r61 = 150
                                                r38 = r57 * r61
                                                r57 = 257
                                                ReturnVal = r38 % r57
                                                upvalueValues[upvalues[3]] = ReturnVal
                                                state = 61
                                            end
                                        else
                                            if state == 61 then
                                                r57 = upvalueValues[upvalues[3]]
                                                r61 = 1
                                                r38 = r57 ~= r61
                                                state = r38 and (62) or (60)
                                            end
                                        end
                                    else
                                        if state == 62 then
                                            r57 = upvalueValues[upvalues[3]]
                                            r61 = 32
                                            r38 = r57 % r61
                                            r43 = upvalueValues[upvalues[4]]
                                            r20 = 2
                                            r75 = upvalueValues[upvalues[2]]
                                            r39 = upvalueValues[upvalues[3]]
                                            r54 = r39 - r38
                                            r39 = 32
                                            r88 = r54 / r39
                                            r4 = 13
                                            r83 = r4 - r88
                                            r31 = r20 ^ r83
                                            r17 = r75 / r31
                                            r14 = r43(r17)
                                            r43 = 4294967296
                                            r61 = r14 % r43
                                            r14 = 2
                                            r31 = 1
                                            r43 = r14 ^ r38
                                            r20 = 256
                                            r57 = r61 / r43
                                            r43 = upvalueValues[upvalues[4]]
                                            r75 = r57 % r31
                                            r31 = 4294967296
                                            r17 = r75 * r31
                                            r14 = r43(r17)
                                            r43 = upvalueValues[upvalues[4]]
                                            r17 = r43(r57)
                                            r61 = r14 + r17
                                            r75 = 65536
                                            r14 = 65536
                                            r43 = r61 % r14
                                            r17 = r61 - r43
                                            r14 = r17 / r75
                                            r61 = nil
                                            r75 = 256
                                            r17 = r43 % r75
                                            r31 = r43 - r17
                                            r75 = r31 / r20
                                            r20 = 256
                                            r43 = nil
                                            r31 = r14 % r20
                                            r38 = nil
                                            r83 = r14 - r31
                                            r4 = 256
                                            r57 = nil
                                            r14 = nil
                                            r20 = r83 / r4
                                            r83 = {
                                                r17,
                                                r75,
                                                r31,
                                                r20
                                            }
                                            r75 = nil
                                            r20 = nil
                                            upvalueValues[upvalues[1]] = r83
                                            r31 = nil
                                            r17 = nil
                                            state = 59
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 85 then
                            if state <= 70 then
                                if state <= 69 then
                                    -- createClosure7 entry 273048 -> 63, states 63-69
                                    if state <= 66 then
                                        if state <= 64 then
                                            if state <= 63 then
                                                if state == 63 then -- entry 273048 -> 63
                                                    state = upvalueValues[upvalues[1]]
                                                    r61 = state
                                                    r38 = args[1]
                                                    r57 = args[2]
                                                    state = r61[r57]
                                                    state = state and (64) or (65)
                                                end
                                            else
                                                if state == 64 then
                                                    state = 66
                                                end
                                            end
                                        else
                                            if state <= 65 then
                                                if state == 65 then
                                                    state = {}
                                                    upvalueValues[upvalues[2]] = state
                                                    ReturnVal = upvalueValues[upvalues[3]]
                                                    r43 = ReturnVal
                                                    r14 = 35184372088832
                                                    ReturnVal = r57 % r14
                                                    upvalueValues[upvalues[4]] = ReturnVal
                                                    r75 = 255
                                                    r17 = r57 % r75
                                                    r75 = 2
                                                    r14 = r17 + r75
                                                    r83 = 1
                                                    upvalueValues[upvalues[5]] = r14
                                                    r4 = r83
                                                    r31 = "string"
                                                    r75 = _env[r31]
                                                    r31 = "len"
                                                    r17 = r75[r31]
                                                    r75 = r17(r38)
                                                    r17 = ""
                                                    r61[r57] = r17
                                                    r83 = 0
                                                    r88 = r4 < r83
                                                    r31 = 1
                                                    r83 = r31 - r4
                                                    r17 = 213
                                                    r20 = r75
                                                    state = 67
                                                end
                                            else
                                                if state == 66 then
                                                    ReturnVal = {
                                                        r57
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        if state <= 68 then
                                            if state <= 67 then
                                                if state == 67 then
                                                    r54 = not r88
                                                    r83 = r83 + r4
                                                    r31 = r83 <= r20
                                                    r31 = r54 and r31
                                                    r54 = r83 >= r20
                                                    r54 = r88 and r54
                                                    r31 = r54 or r31
                                                    r54 = (68)
                                                    state = r31 and r54
                                                    r31 = (69)
                                                    state = state or r31
                                                end
                                            else
                                                if state == 68 then
                                                    r31 = r83
                                                    r82 = "string"
                                                    r6 = _env[r82]
                                                    r82 = "byte"
                                                    r85 = r6[r82]
                                                    r6 = r85(r38, r31)
                                                    r85 = upvalueValues[upvalues[6]]
                                                    r82 = r85()
                                                    r63 = r6 + r82
                                                    r39 = r63 + r17
                                                    r82 = 1
                                                    r31 = nil
                                                    r63 = 256
                                                    r54 = r39 % r63
                                                    r17 = r54
                                                    r63 = r61[r57]
                                                    r6 = r17 + r82
                                                    r85 = r43[r6]
                                                    r39 = r63 .. r85
                                                    r61[r57] = r39
                                                    state = 67
                                                end
                                            end
                                        else
                                            if state == 69 then
                                                r75 = nil
                                                r43 = nil
                                                r17 = nil
                                                state = 66
                                            end
                                        end
                                    end
                                else
                                    -- createClosure5 entry 8666289 -> 70, states 70-70
                                    if state == 70 then -- entry 8666289 -> 70
                                        r61 = "tick"
                                        r57 = _env[r61]
                                        r61 = r57()
                                        r14 = "os"
                                        r43 = _env[r14]
                                        r17 = upvalueValues[upvalues[1]]
                                        r75 = upvalueValues[upvalues[2]]
                                        r20 = "N{\221n"
                                        r83 = 7784031768104
                                        r31 = r75(r20, r83)
                                        r14 = r17[r31]
                                        r57 = r43[r14]
                                        r43 = r57()
                                        r38 = r61 * r43
                                        r14 = {}
                                        r43 = "tostring"
                                        r61 = _env[r43]
                                        r43 = r61(r14)
                                        r57 = #r43
                                        ReturnVal = r38 * r57
                                        r61 = "math"
                                        r57 = _env[r61]
                                        r43 = upvalueValues[upvalues[1]]
                                        r14 = upvalueValues[upvalues[2]]
                                        r31 = 26675999879301
                                        r75 = "\243\218\021I\201'"
                                        r17 = r14(r75, r31)
                                        r61 = r43[r17]
                                        r38 = r57[r61]
                                        r61 = 1
                                        r43 = 1000000
                                        r57 = r38(r61, r43)
                                        state = ReturnVal * r57
                                        r38 = state
                                        r57 = "math"
                                        ReturnVal = _env[r57]
                                        r61 = upvalueValues[upvalues[1]]
                                        r43 = upvalueValues[upvalues[2]]
                                        r75 = 26977907536146
                                        r17 = "e\138*\146\249}\000\229t\130"
                                        r14 = r43(r17, r75)
                                        r57 = r61[r14]
                                        state = ReturnVal[r57]
                                        ReturnVal = state(r38)
                                        r57 = "math"
                                        ReturnVal = _env[r57]
                                        r61 = upvalueValues[upvalues[1]]
                                        r43 = upvalueValues[upvalues[2]]
                                        r17 = "\138XG \012\251"
                                        r75 = 30809987708939
                                        r14 = r43(r17, r75)
                                        r57 = r61[r14]
                                        state = ReturnVal[r57]
                                        r61 = 1000000000
                                        r57 = 1
                                        ReturnVal = {
                                            state(r57, r61)
                                        }
                                        ReturnVal = {
                                            unpack(ReturnVal)
                                        }
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure7 entry 7885361 -> 71, states 71-85
                                if state <= 78 then
                                    if state <= 74 then
                                        if state <= 72 then
                                            if state <= 71 then
                                                if state == 71 then -- entry 7885361 -> 71
                                                    r57 = args[2]
                                                    r38 = args[1]
                                                    r61 = "type"
                                                    ReturnVal = _env[r61]
                                                    r61 = ReturnVal(r38)
                                                    r43 = "type"
                                                    ReturnVal = _env[r43]
                                                    r43 = ReturnVal(r57)
                                                    state = r61 ~= r43
                                                    state = state and (72) or (73)
                                                end
                                            else
                                                if state == 72 then
                                                    state = false
                                                    ReturnVal = {
                                                        state
                                                    }
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state <= 73 then
                                                if state == 73 then
                                                    r61 = "type"
                                                    ReturnVal = _env[r61]
                                                    r61 = ReturnVal(r38)
                                                    r43 = upvalueValues[upvalues[1]]
                                                    r14 = upvalueValues[upvalues[2]]
                                                    r31 = 28023842140921
                                                    r75 = "\149\147\153\136+"
                                                    r17 = r14(r75, r31)
                                                    ReturnVal = r43[r17]
                                                    state = r61 ~= ReturnVal
                                                    state = state and (74) or (75)
                                                end
                                            else
                                                if state == 74 then
                                                    state = r38 == r57
                                                    ReturnVal = {
                                                        state
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        if state <= 76 then
                                            if state <= 75 then
                                                if state == 75 then
                                                    state = {}
                                                    r61 = state
                                                    ReturnVal = "pairs"
                                                    state = _env[ReturnVal]
                                                    r17 = {
                                                        state(r38)
                                                    }
                                                    r43 = r17[2]
                                                    ReturnVal = r17[1]
                                                    r14 = r17[3]
                                                    r17 = ReturnVal
                                                    state = 76
                                                end
                                            else
                                                if state == 76 then
                                                    r14, r31 = r17(r43, r14)
                                                    state = r14 and (77) or (78)
                                                end
                                            end
                                        else
                                            if state <= 77 then
                                                if state == 77 then
                                                    r75 = r14
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r4 = r57[r75]
                                                    r83 = r20(r31, r4)
                                                    state = not r83
                                                    state = state and (79) or (80)
                                                end
                                            else
                                                if state == 78 then
                                                    r43 = "pairs"
                                                    state = _env[r43]
                                                    r75 = {
                                                        state(r57)
                                                    }
                                                    r14 = r75[2]
                                                    r43 = r75[1]
                                                    r17 = r75[3]
                                                    state = 81
                                                end
                                            end
                                        end
                                    end
                                else
                                    if state <= 82 then
                                        if state <= 80 then
                                            if state <= 79 then
                                                if state == 79 then
                                                    state = false
                                                    ReturnVal = {
                                                        state
                                                    }
                                                    state = nil
                                                end
                                            else
                                                if state == 80 then
                                                    state = true
                                                    r61[r75] = state
                                                    r75 = nil
                                                    r31 = nil
                                                    state = 76
                                                end
                                            end
                                        else
                                            if state <= 81 then
                                                if state == 81 then
                                                    r17, r31 = r43(r14, r17)
                                                    state = r17 and (82) or (83)
                                                end
                                            else
                                                if state == 82 then
                                                    r75 = r17
                                                    r20 = r61[r75]
                                                    state = not r20
                                                    state = state and (84) or (85)
                                                end
                                            end
                                        end
                                    else
                                        if state <= 84 then
                                            if state <= 83 then
                                                if state == 83 then
                                                    state = true
                                                    ReturnVal = {
                                                        state
                                                    }
                                                    state = nil
                                                end
                                            else
                                                if state == 84 then
                                                    state = false
                                                    ReturnVal = {
                                                        state
                                                    }
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state == 85 then
                                                r75 = nil
                                                r31 = nil
                                                state = 81
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 163 then
                                if state <= 160 then
                                    -- createClosure2 entry 5263673 -> 86, states 86-160
                                    if state <= 123 then
                                        if state <= 104 then
                                            if state <= 95 then
                                                if state <= 90 then
                                                    if state <= 88 then
                                                        if state <= 87 then
                                                            if state <= 86 then
                                                                if state == 86 then -- entry 5263673 -> 86
                                                                    r38 = upvalueValues[upvalues[1]]
                                                                    r57 = upvalueValues[upvalues[2]]
                                                                    r14 = 23053567060463
                                                                    r43 = "\002\176\004\232\186y\026\0319\019M\001"
                                                                    r61 = r57(r43, r14)
                                                                    ReturnVal = r38[r61]
                                                                    r57 = upvalueValues[upvalues[1]]
                                                                    r61 = upvalueValues[upvalues[2]]
                                                                    r17 = 1162999628317
                                                                    r14 = "\223\025,\022\207\017R\214\151\185\140\137\020"
                                                                    r43 = r61(r14, r17)
                                                                    r38 = r57[r43]
                                                                    r61 = upvalueValues[upvalues[1]]
                                                                    r43 = upvalueValues[upvalues[2]]
                                                                    r75 = 26690875011212
                                                                    r17 = "\235\187\001\012\012J\n\192\215\165(\183"
                                                                    r14 = r43(r17, r75)
                                                                    r57 = r61[r14]
                                                                    r43 = upvalueValues[upvalues[1]]
                                                                    r14 = upvalueValues[upvalues[2]]
                                                                    r75 = "\207:\180)\026\025Y\199\208\171\t\213"
                                                                    r31 = 28588535690240
                                                                    r17 = r14(r75, r31)
                                                                    r61 = r43[r17]
                                                                    r14 = upvalueValues[upvalues[1]]
                                                                    r17 = upvalueValues[upvalues[2]]
                                                                    r20 = 23842943101790
                                                                    r31 = "a\144\212\188\190\229n\197\188-E@z\172Q"
                                                                    r75 = r17(r31, r20)
                                                                    r43 = r14[r75]
                                                                    r17 = upvalueValues[upvalues[1]]
                                                                    r75 = upvalueValues[upvalues[2]]
                                                                    r83 = 900883923363
                                                                    r20 = "B\195\174\1614 \245\025\237\204\202\248O\1324"
                                                                    r31 = r75(r20, r83)
                                                                    r14 = r17[r31]
                                                                    r75 = upvalueValues[upvalues[1]]
                                                                    r31 = upvalueValues[upvalues[2]]
                                                                    r4 = 25829685522171
                                                                    r83 = "\144\1618v\169\027\192\004\020"
                                                                    r20 = r31(r83, r4)
                                                                    r17 = r75[r20]
                                                                    r31 = upvalueValues[upvalues[1]]
                                                                    r20 = upvalueValues[upvalues[2]]
                                                                    r88 = 34248742993484
                                                                    r4 = "\194\194W\168Ke\158j\235\190\007"
                                                                    r83 = r20(r4, r88)
                                                                    r75 = r31[r83]
                                                                    r20 = upvalueValues[upvalues[1]]
                                                                    r83 = upvalueValues[upvalues[2]]
                                                                    r54 = 4145490151306
                                                                    r88 = "cq\004\191\"\222\182\210\245h&\1679\254"
                                                                    r4 = r83(r88, r54)
                                                                    r31 = r20[r4]
                                                                    r83 = upvalueValues[upvalues[1]]
                                                                    r4 = upvalueValues[upvalues[2]]
                                                                    r39 = 21925487831009
                                                                    r54 = "\159!;)3M\183;="
                                                                    r88 = r4(r54, r39)
                                                                    r20 = r83[r88]
                                                                    r4 = upvalueValues[upvalues[1]]
                                                                    r88 = upvalueValues[upvalues[2]]
                                                                    r63 = 2960524903778
                                                                    r39 = "If$@\017$\154k"
                                                                    r54 = r88(r39, r63)
                                                                    r83 = r4[r54]
                                                                    r88 = upvalueValues[upvalues[1]]
                                                                    r54 = upvalueValues[upvalues[2]]
                                                                    r85 = 15019405810513
                                                                    r63 = "\197}T\0312\184\196\197"
                                                                    r39 = r54(r63, r85)
                                                                    r4 = r88[r39]
                                                                    r54 = upvalueValues[upvalues[1]]
                                                                    r39 = upvalueValues[upvalues[2]]
                                                                    r6 = 3431835993662
                                                                    r85 = "#\200\tc\231(\000"
                                                                    r63 = r39(r85, r6)
                                                                    r88 = r54[r63]
                                                                    r39 = upvalueValues[upvalues[1]]
                                                                    r63 = upvalueValues[upvalues[2]]
                                                                    r82 = 11077702521894
                                                                    r6 = "\238\255\168\025;\002\000"
                                                                    r85 = r63(r6, r82)
                                                                    r54 = r39[r85]
                                                                    r63 = upvalueValues[upvalues[1]]
                                                                    r85 = upvalueValues[upvalues[2]]
                                                                    r59 = 15409583889415
                                                                    r82 = "\203\165\194\142\144\239\174"
                                                                    r6 = r85(r82, r59)
                                                                    r39 = r63[r6]
                                                                    r85 = upvalueValues[upvalues[1]]
                                                                    r6 = upvalueValues[upvalues[2]]
                                                                    r87 = 26171436789659
                                                                    r59 = "\005\164#\t~\131\190"
                                                                    r82 = r6(r59, r87)
                                                                    r63 = r85[r82]
                                                                    r6 = upvalueValues[upvalues[1]]
                                                                    r82 = upvalueValues[upvalues[2]]
                                                                    r50 = 1328496640618
                                                                    r87 = "&\1370\165\n\175+"
                                                                    r59 = r82(r87, r50)
                                                                    r85 = r6[r59]
                                                                    r82 = upvalueValues[upvalues[1]]
                                                                    r59 = upvalueValues[upvalues[2]]
                                                                    r23 = 21919514568671
                                                                    r50 = "\160`&\237"
                                                                    r87 = r59(r50, r23)
                                                                    r6 = r82[r87]
                                                                    r59 = upvalueValues[upvalues[1]]
                                                                    r87 = upvalueValues[upvalues[2]]
                                                                    r52 = 24739164892416
                                                                    r23 = "s\215\011*\015\185\143f\219N\202\162\223#\136q\247\235"
                                                                    r50 = r87(r23, r52)
                                                                    r82 = r59[r50]
                                                                    r87 = upvalueValues[upvalues[1]]
                                                                    r50 = upvalueValues[upvalues[2]]
                                                                    r16 = 29680943920637
                                                                    r52 = "\207\166O\214\005\154\218\215\216-\228\2146\182\023P"
                                                                    r23 = r50(r52, r16)
                                                                    r59 = r87[r23]
                                                                    r50 = upvalueValues[upvalues[1]]
                                                                    r23 = upvalueValues[upvalues[2]]
                                                                    r26 = 25166226845126
                                                                    r16 = "}\206]\246\238\219\019YZ\148Xu\007=\134\147\225"
                                                                    r52 = r23(r16, r26)
                                                                    r87 = r50[r52]
                                                                    r23 = upvalueValues[upvalues[1]]
                                                                    r52 = upvalueValues[upvalues[2]]
                                                                    r12 = 804946690422
                                                                    r26 = "\229\192t\203%\133\165\234S\200\137\017\191,"
                                                                    r16 = r52(r26, r12)
                                                                    r50 = r23[r16]
                                                                    r52 = upvalueValues[upvalues[1]]
                                                                    r16 = upvalueValues[upvalues[2]]
                                                                    r62 = 15436346203156
                                                                    r12 = "\2233(\nK\136\208u\255\003\176\246+\235\205\171"
                                                                    r26 = r16(r12, r62)
                                                                    r23 = r52[r26]
                                                                    r16 = upvalueValues[upvalues[1]]
                                                                    r26 = upvalueValues[upvalues[2]]
                                                                    r24 = 11882255521181
                                                                    r62 = "rF&\194\229\020l\203\188B"
                                                                    r12 = r26(r62, r24)
                                                                    r52 = r16[r12]
                                                                    r26 = upvalueValues[upvalues[1]]
                                                                    r12 = upvalueValues[upvalues[2]]
                                                                    r42 = 28644172346394
                                                                    r24 = "\024\150\024\231\230>)~`R\158\158\248\228\154"
                                                                    r62 = r12(r24, r42)
                                                                    r16 = r26[r62]
                                                                    r12 = upvalueValues[upvalues[1]]
                                                                    r62 = upvalueValues[upvalues[2]]
                                                                    r42 = "\164N\004\224\224\223\"\242~\245\156\017\176"
                                                                    r46 = 9533507670359
                                                                    r24 = r62(r42, r46)
                                                                    r26 = r12[r24]
                                                                    r62 = upvalueValues[upvalues[1]]
                                                                    r24 = upvalueValues[upvalues[2]]
                                                                    r56 = 19666287289285
                                                                    r46 = "\180\020\026\239\198\192#x\015\143\239\153_\031\133@i"
                                                                    r42 = r24(r46, r56)
                                                                    r12 = r62[r42]
                                                                    r24 = upvalueValues[upvalues[1]]
                                                                    r42 = upvalueValues[upvalues[2]]
                                                                    r73 = 20135800120480
                                                                    r56 = "\001\177[\222Q"
                                                                    r46 = r42(r56, r73)
                                                                    r62 = r24[r46]
                                                                    r42 = upvalueValues[upvalues[1]]
                                                                    r46 = upvalueValues[upvalues[2]]
                                                                    r30 = 1327043101289
                                                                    r73 = "\156\153[\187\003\031\212\164!\208\165"
                                                                    r56 = r46(r73, r30)
                                                                    r24 = r42[r56]
                                                                    r46 = upvalueValues[upvalues[1]]
                                                                    r56 = upvalueValues[upvalues[2]]
                                                                    r11 = 15291902909392
                                                                    r30 = "%\186%nP~\252\018\222\143\002G6_\1872"
                                                                    r73 = r56(r30, r11)
                                                                    r42 = r46[r73]
                                                                    r56 = upvalueValues[upvalues[1]]
                                                                    r73 = upvalueValues[upvalues[2]]
                                                                    r28 = 12975270156186
                                                                    r11 = "e\214\137\234\232\150\232>u\027\235\242\1455"
                                                                    r30 = r73(r11, r28)
                                                                    r46 = r56[r30]
                                                                    r73 = upvalueValues[upvalues[1]]
                                                                    r30 = upvalueValues[upvalues[2]]
                                                                    r79 = 24380610161753
                                                                    r28 = "\000\212\177\2260\007\240 "
                                                                    r11 = r30(r28, r79)
                                                                    r56 = r73[r11]
                                                                    r30 = upvalueValues[upvalues[1]]
                                                                    r11 = upvalueValues[upvalues[2]]
                                                                    r81 = 16454902537710
                                                                    r79 = "\140G\167\021\254J\249|+X"
                                                                    r28 = r11(r79, r81)
                                                                    r73 = r30[r28]
                                                                    r11 = upvalueValues[upvalues[1]]
                                                                    r28 = upvalueValues[upvalues[2]]
                                                                    r84 = 4481773078566
                                                                    r81 = "b\133\005\212\214\004\195bG\173\170\132"
                                                                    r79 = r28(r81, r84)
                                                                    r30 = r11[r79]
                                                                    r28 = upvalueValues[upvalues[1]]
                                                                    r79 = upvalueValues[upvalues[2]]
                                                                    r5 = 17784773746777
                                                                    r84 = "\221\167\227\166\244'\214;\228M\246\031"
                                                                    r81 = r79(r84, r5)
                                                                    r11 = r28[r81]
                                                                    r79 = upvalueValues[upvalues[1]]
                                                                    r81 = upvalueValues[upvalues[2]]
                                                                    r36 = 5113473534285
                                                                    r5 = "0\137\199\000?\188"
                                                                    r84 = r81(r5, r36)
                                                                    r28 = r79[r84]
                                                                    r81 = upvalueValues[upvalues[1]]
                                                                    r84 = upvalueValues[upvalues[2]]
                                                                    r65 = 5382657001930
                                                                    r36 = "|\215\201\016\200 \143i\006\156"
                                                                    r5 = r84(r36, r65)
                                                                    r79 = r81[r5]
                                                                    r84 = upvalueValues[upvalues[1]]
                                                                    r5 = upvalueValues[upvalues[2]]
                                                                    r2 = 8430087180117
                                                                    r65 = "T7w\016M\029\178\005\202(uS\151X\1365d"
                                                                    r36 = r5(r65, r2)
                                                                    r81 = r84[r36]
                                                                    r5 = upvalueValues[upvalues[1]]
                                                                    r36 = upvalueValues[upvalues[2]]
                                                                    r53 = 4177844422553
                                                                    r2 = "CS\173\253[\228\208[\147\161\154G\176\166|\174\240\031Q"
                                                                    r65 = r36(r2, r53)
                                                                    r84 = r5[r65]
                                                                    r36 = upvalueValues[upvalues[1]]
                                                                    r65 = upvalueValues[upvalues[2]]
                                                                    r71 = 9528147153236
                                                                    r53 = "\002\128\016NAz\190C\224"
                                                                    r2 = r65(r53, r71)
                                                                    r5 = r36[r2]
                                                                    r65 = upvalueValues[upvalues[1]]
                                                                    r2 = upvalueValues[upvalues[2]]
                                                                    r15 = 30355575011127
                                                                    r71 = "\015i\2303\209\203\241"
                                                                    r53 = r2(r71, r15)
                                                                    r36 = r65[r53]
                                                                    r2 = upvalueValues[upvalues[1]]
                                                                    r53 = upvalueValues[upvalues[2]]
                                                                    r37 = 7138369326332
                                                                    r15 = "<\196\231:\016\178VL\182rm\216\177"
                                                                    r71 = r53(r15, r37)
                                                                    r65 = r2[r71]
                                                                    r53 = upvalueValues[upvalues[1]]
                                                                    r71 = upvalueValues[upvalues[2]]
                                                                    r69 = 24547552963750
                                                                    r37 = "V\157\0316\006\152\017-ld\178"
                                                                    r15 = r71(r37, r69)
                                                                    r2 = r53[r15]
                                                                    r71 = upvalueValues[upvalues[1]]
                                                                    r15 = upvalueValues[upvalues[2]]
                                                                    r48 = 33787411021173
                                                                    r69 = "\209,\233\002\169\189\215\146\228\241g\240\219\022^\012"
                                                                    r37 = r15(r69, r48)
                                                                    r53 = r71[r37]
                                                                    r15 = upvalueValues[upvalues[1]]
                                                                    r37 = upvalueValues[upvalues[2]]
                                                                    r80 = 18216071864610
                                                                    r48 = "@\237\216{\246\218|[\166\017\185uk\213f+"
                                                                    r69 = r37(r48, r80)
                                                                    r71 = r15[r69]
                                                                    r37 = upvalueValues[upvalues[1]]
                                                                    r69 = upvalueValues[upvalues[2]]
                                                                    r35 = 4772764747950
                                                                    r80 = "\246x'R\239\164\237\192,kA\195\024"
                                                                    r48 = r69(r80, r35)
                                                                    r15 = r37[r48]
                                                                    r69 = upvalueValues[upvalues[1]]
                                                                    r48 = upvalueValues[upvalues[2]]
                                                                    r51 = 24774475705616
                                                                    r35 = "r\217\201\012O\168\236\201\028\031\r\206\253\138\202\026\166"
                                                                    r80 = r48(r35, r51)
                                                                    r37 = r69[r80]
                                                                    r48 = upvalueValues[upvalues[1]]
                                                                    r80 = upvalueValues[upvalues[2]]
                                                                    r25 = 19544568505229
                                                                    r51 = "\195\012w\001\225\180\142\151\018\128t\1871\005l\158\\"
                                                                    r35 = r80(r51, r25)
                                                                    r69 = r48[r35]
                                                                    r80 = upvalueValues[upvalues[1]]
                                                                    r35 = upvalueValues[upvalues[2]]
                                                                    r45 = 26692279316621
                                                                    r25 = "\196\223\226LnC,!a\253"
                                                                    r51 = r35(r25, r45)
                                                                    r48 = r80[r51]
                                                                    r35 = upvalueValues[upvalues[1]]
                                                                    r51 = upvalueValues[upvalues[2]]
                                                                    r22 = 14329268492816
                                                                    r45 = "y\228\144\207:/'\236c\004e\219\1627\187"
                                                                    r25 = r51(r45, r22)
                                                                    r80 = r35[r25]
                                                                    r51 = upvalueValues[upvalues[1]]
                                                                    r25 = upvalueValues[upvalues[2]]
                                                                    r60 = 14041140320650
                                                                    r22 = "\007X\025\024\180|U\244\179Y\150\016"
                                                                    r45 = r25(r22, r60)
                                                                    r35 = r51[r45]
                                                                    r25 = upvalueValues[upvalues[1]]
                                                                    r45 = upvalueValues[upvalues[2]]
                                                                    r70 = 16674134056532
                                                                    r60 = "\145\230\2197[P-\192"
                                                                    r22 = r45(r60, r70)
                                                                    r51 = r25[r22]
                                                                    r45 = upvalueValues[upvalues[1]]
                                                                    r22 = upvalueValues[upvalues[2]]
                                                                    r76 = 15134215183239
                                                                    r70 = "?\017\182]\195\243\239\188\194k\000\174h\192"
                                                                    r60 = r22(r70, r76)
                                                                    r25 = r45[r60]
                                                                    r22 = upvalueValues[upvalues[1]]
                                                                    r60 = upvalueValues[upvalues[2]]
                                                                    r19 = 29477486523806
                                                                    r76 = "'\011\001\t\229\249\251#\131\018\163\nU[\015qo"
                                                                    r70 = r60(r76, r19)
                                                                    r45 = r22[r70]
                                                                    r60 = upvalueValues[upvalues[1]]
                                                                    r70 = upvalueValues[upvalues[2]]
                                                                    r44 = 28556389594097
                                                                    r19 = "\205\222q\2554\180]\251\191\215\022\158\212\\"
                                                                    r76 = r70(r19, r44)
                                                                    r22 = r60[r76]
                                                                    r70 = upvalueValues[upvalues[1]]
                                                                    r76 = upvalueValues[upvalues[2]]
                                                                    r3 = 8594015440801
                                                                    r44 = "\144\146C_D\t@\180\147\138"
                                                                    r19 = r76(r44, r3)
                                                                    r60 = r70[r19]
                                                                    r76 = upvalueValues[upvalues[1]]
                                                                    r19 = upvalueValues[upvalues[2]]
                                                                    r32 = 3826622088949
                                                                    r3 = "Q4\018\234\162\018\164\218\172\231\016"
                                                                    r44 = r19(r3, r32)
                                                                    r70 = r76[r44]
                                                                    r19 = upvalueValues[upvalues[1]]
                                                                    r44 = upvalueValues[upvalues[2]]
                                                                    r47 = 13038304778167
                                                                    r32 = "\025\127\2275\208\026N\149\127i\208R"
                                                                    r3 = r44(r32, r47)
                                                                    r76 = r19[r3]
                                                                    r44 = upvalueValues[upvalues[1]]
                                                                    r3 = upvalueValues[upvalues[2]]
                                                                    r7 = 28729815561282
                                                                    r47 = "F`F]B\215$\187\157\233\188"
                                                                    r32 = r3(r47, r7)
                                                                    r19 = r44[r32]
                                                                    r3 = upvalueValues[upvalues[1]]
                                                                    r32 = upvalueValues[upvalues[2]]
                                                                    r74 = 5153665206623
                                                                    r7 = "\216\138\179\018\239[\152\197\023\219\207/z:"
                                                                    r47 = r32(r7, r74)
                                                                    r44 = r3[r47]
                                                                    r32 = upvalueValues[upvalues[1]]
                                                                    r47 = upvalueValues[upvalues[2]]
                                                                    r27 = 28330207687560
                                                                    r74 = "e\183y\001\127\1784\1941=\226\198\128N<\206K"
                                                                    r7 = r47(r74, r27)
                                                                    r3 = r32[r7]
                                                                    r47 = upvalueValues[upvalues[1]]
                                                                    r7 = upvalueValues[upvalues[2]]
                                                                    r58 = 6520713628636
                                                                    r27 = "\130\175j\195"
                                                                    r74 = r7(r27, r58)
                                                                    r32 = r47[r74]
                                                                    r7 = upvalueValues[upvalues[1]]
                                                                    r74 = upvalueValues[upvalues[2]]
                                                                    r68 = 29534275368376
                                                                    r58 = "S\178AD"
                                                                    r27 = r74(r58, r68)
                                                                    r47 = r7[r27]
                                                                    r74 = upvalueValues[upvalues[1]]
                                                                    r27 = upvalueValues[upvalues[2]]
                                                                    r8 = 9600738120054
                                                                    r68 = "\237\029\176\247vz\135b"
                                                                    r58 = r27(r68, r8)
                                                                    r7 = r74[r58]
                                                                    r27 = upvalueValues[upvalues[1]]
                                                                    r58 = upvalueValues[upvalues[2]]
                                                                    r66 = 11002486707203
                                                                    r8 = "\165\220L\241\230*\226nw\001"
                                                                    r68 = r58(r8, r66)
                                                                    r74 = r27[r68]
                                                                    r58 = upvalueValues[upvalues[1]]
                                                                    r68 = upvalueValues[upvalues[2]]
                                                                    r67 = 12134677026322
                                                                    r66 = "\021\216\027\136\242\154v\156"
                                                                    r8 = r68(r66, r67)
                                                                    r27 = r58[r8]
                                                                    r68 = upvalueValues[upvalues[1]]
                                                                    r8 = upvalueValues[upvalues[2]]
                                                                    r49 = 14714211654339
                                                                    r67 = "\159\209\029\159\254'\187\133~\182\226\1702\160\196"
                                                                    r66 = r8(r67, r49)
                                                                    r58 = r68[r66]
                                                                    r8 = upvalueValues[upvalues[1]]
                                                                    r66 = upvalueValues[upvalues[2]]
                                                                    r9 = 16385143709133
                                                                    r49 = "Og2\028D\248\132\250\208\248t\238"
                                                                    r67 = r66(r49, r9)
                                                                    r68 = r8[r67]
                                                                    r66 = upvalueValues[upvalues[1]]
                                                                    r67 = upvalueValues[upvalues[2]]
                                                                    r64 = 20564764206440
                                                                    r9 = "\234)9QK\209H\239:\194\028G\128\224"
                                                                    r49 = r67(r9, r64)
                                                                    r8 = r66[r49]
                                                                    r67 = upvalueValues[upvalues[1]]
                                                                    r49 = upvalueValues[upvalues[2]]
                                                                    r1 = 18892056076893
                                                                    r64 = "\214\173=\151\174\167\255\139^QC\144\166\169D"
                                                                    r9 = r49(r64, r1)
                                                                    r66 = r67[r9]
                                                                    r49 = upvalueValues[upvalues[1]]
                                                                    r9 = upvalueValues[upvalues[2]]
                                                                    r34 = 25913290862370
                                                                    r1 = "U\197\216\2229W Gy[,Ib\224"
                                                                    r64 = r9(r1, r34)
                                                                    r67 = r49[r64]
                                                                    r9 = upvalueValues[upvalues[1]]
                                                                    r64 = upvalueValues[upvalues[2]]
                                                                    r86 = 15735967112351
                                                                    r34 = "\174W\169G\029\152\193\252\031\142\198&7"
                                                                    r1 = r64(r34, r86)
                                                                    r49 = r9[r1]
                                                                    r64 = upvalueValues[upvalues[1]]
                                                                    r1 = upvalueValues[upvalues[2]]
                                                                    r29 = 26030425419609
                                                                    r86 = "[8\245\t\247)*"
                                                                    r34 = r1(r86, r29)
                                                                    r9 = r64[r34]
                                                                    r1 = upvalueValues[upvalues[1]]
                                                                    r34 = upvalueValues[upvalues[2]]
                                                                    r40 = 15276471737289
                                                                    r29 = "\163\219\133\137\023h\253\255\158zw\r\012"
                                                                    r86 = r34(r29, r40)
                                                                    r64 = r1[r86]
                                                                    r34 = upvalueValues[upvalues[1]]
                                                                    r86 = upvalueValues[upvalues[2]]
                                                                    r78 = 14339006028309
                                                                    r40 = "\1333\194\239\128<"
                                                                    r29 = r86(r40, r78)
                                                                    r1 = r34[r29]
                                                                    r86 = upvalueValues[upvalues[1]]
                                                                    r29 = upvalueValues[upvalues[2]]
                                                                    r72 = 9062125179003
                                                                    r78 = "\251\000Po\191|8!\196\021E"
                                                                    r40 = r29(r78, r72)
                                                                    r34 = r86[r40]
                                                                    r29 = upvalueValues[upvalues[1]]
                                                                    r40 = upvalueValues[upvalues[2]]
                                                                    r10 = 20049236485240
                                                                    r72 = "\206\212\011sq"
                                                                    r78 = r40(r72, r10)
                                                                    r86 = r29[r78]
                                                                    r40 = upvalueValues[upvalues[1]]
                                                                    r78 = upvalueValues[upvalues[2]]
                                                                    r13 = 3929109628709
                                                                    r10 = "i\2274\193\227\177/"
                                                                    r72 = r78(r10, r13)
                                                                    r29 = r40[r72]
                                                                    r78 = upvalueValues[upvalues[1]]
                                                                    r72 = upvalueValues[upvalues[2]]
                                                                    r33 = 28606693684233
                                                                    r13 = "7\156@ip\172\000"
                                                                    r10 = r72(r13, r33)
                                                                    r40 = r78[r10]
                                                                    r72 = upvalueValues[upvalues[1]]
                                                                    r10 = upvalueValues[upvalues[2]]
                                                                    r55 = 11557143713029
                                                                    r33 = "\171\171\238\224;\161"
                                                                    r13 = r10(r33, r55)
                                                                    r78 = r72[r13]
                                                                    r10 = upvalueValues[upvalues[1]]
                                                                    r13 = upvalueValues[upvalues[2]]
                                                                    r18 = 18258378137910
                                                                    r55 = "+\194\234\n\1611\161Z\148"
                                                                    r33 = r13(r55, r18)
                                                                    r72 = r10[r33]
                                                                    r13 = upvalueValues[upvalues[1]]
                                                                    r33 = upvalueValues[upvalues[2]]
                                                                    r41 = 7463461899667
                                                                    r18 = "r\145|\230\142\168\220\194\004"
                                                                    r55 = r33(r18, r41)
                                                                    r10 = r13[r55]
                                                                    r33 = upvalueValues[upvalues[1]]
                                                                    r55 = upvalueValues[upvalues[2]]
                                                                    r21 = 28231277769562
                                                                    r41 = "v\149\028(\188\176"
                                                                    r18 = r55(r41, r21)
                                                                    r13 = r33[r18]
                                                                    r55 = upvalueValues[upvalues[1]]
                                                                    r18 = upvalueValues[upvalues[2]]
                                                                    r77 = 33392593321149
                                                                    r21 = "\1469\246"
                                                                    r41 = r18(r21, r77)
                                                                    r33 = r55[r41]
                                                                    state = {
                                                                        ReturnVal,
                                                                        r38,
                                                                        r57,
                                                                        r61,
                                                                        r43,
                                                                        r14,
                                                                        r17,
                                                                        r75,
                                                                        r31,
                                                                        r20,
                                                                        r83,
                                                                        r4,
                                                                        r88,
                                                                        r54,
                                                                        r39,
                                                                        r63,
                                                                        r85,
                                                                        r6,
                                                                        r82,
                                                                        r59,
                                                                        r87,
                                                                        r50,
                                                                        r23,
                                                                        r52,
                                                                        r16,
                                                                        r26,
                                                                        r12,
                                                                        r62,
                                                                        r24,
                                                                        r42,
                                                                        r46,
                                                                        r56,
                                                                        r73,
                                                                        r30,
                                                                        r11,
                                                                        r28,
                                                                        r79,
                                                                        r81,
                                                                        r84,
                                                                        r5,
                                                                        r36,
                                                                        r65,
                                                                        r2,
                                                                        r53,
                                                                        r71,
                                                                        r15,
                                                                        r37,
                                                                        r69,
                                                                        r48,
                                                                        r80,
                                                                        r35,
                                                                        r51,
                                                                        r25,
                                                                        r45,
                                                                        r22,
                                                                        r60,
                                                                        r70,
                                                                        r76,
                                                                        r19,
                                                                        r44,
                                                                        r3,
                                                                        r32,
                                                                        r47,
                                                                        r7,
                                                                        r74,
                                                                        r27,
                                                                        r58,
                                                                        r68,
                                                                        r8,
                                                                        r66,
                                                                        r67,
                                                                        r49,
                                                                        r9,
                                                                        r64,
                                                                        r1,
                                                                        r34,
                                                                        r86,
                                                                        r29,
                                                                        r40,
                                                                        r78,
                                                                        r72,
                                                                        r10,
                                                                        r13,
                                                                        r33
                                                                    }
                                                                    r38 = state
                                                                    ReturnVal = "pairs"
                                                                    state = _env[ReturnVal]
                                                                    r43 = {
                                                                        state(r38)
                                                                    }
                                                                    r57 = r43[2]
                                                                    ReturnVal = r43[1]
                                                                    r61 = r43[3]
                                                                    r43 = ReturnVal
                                                                    state = 87
                                                                end
                                                            else
                                                                if state == 87 then
                                                                    r61, r17 = r43(r57, r61)
                                                                    state = r61 and (88) or (89)
                                                                end
                                                            end
                                                        else
                                                            if state == 88 then
                                                                r75 = "rawget"
                                                                state = _env[r75]
                                                                r20 = "_G"
                                                                r31 = _env[r20]
                                                                r75 = state(r31, r17)
                                                                r31 = nil
                                                                state = r75 ~= r31
                                                                state = state and (90) or (91)
                                                                r14 = r61
                                                            end
                                                        end
                                                    else
                                                        if state <= 89 then
                                                            if state == 89 then
                                                                state = createClosure2(173, {
                                                                    upvalues[1],
                                                                    upvalues[2]
                                                                })
                                                                r57 = state
                                                                state = r57()
                                                                r61 = state
                                                                r43 = "tick"
                                                                state = _env[r43]
                                                                r43 = state()
                                                                state = upvalueValues[upvalues[3]]
                                                                r14 = state()
                                                                r75 = 100000
                                                                r31 = r75
                                                                r75 = 1
                                                                r20 = r75
                                                                r75 = 0
                                                                r83 = r20 < r75
                                                                r17 = 1
                                                                r75 = r17 - r20
                                                                state = 92
                                                            end
                                                        else
                                                            if state == 90 then
                                                                r20 = "type"
                                                                r31 = _env[r20]
                                                                r20 = r31(r75)
                                                                r83 = upvalueValues[upvalues[1]]
                                                                r4 = upvalueValues[upvalues[2]]
                                                                r54 = "\152zM\238\181\000\241\030"
                                                                r39 = 1756576318257
                                                                r88 = r4(r54, r39)
                                                                r31 = r83[r88]
                                                                state = r20 ~= r31
                                                                state = state and (93) or (94)
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 93 then
                                                        if state <= 92 then
                                                            if state <= 91 then
                                                                if state == 91 then
                                                                    r17 = nil
                                                                    r75 = nil
                                                                    r14 = nil
                                                                    state = 87
                                                                end
                                                            else
                                                                if state == 92 then
                                                                    r4 = not r83
                                                                    r75 = r75 + r20
                                                                    r17 = r75 <= r31
                                                                    r17 = r4 and r17
                                                                    r4 = r75 >= r31
                                                                    r4 = r83 and r4
                                                                    r17 = r4 or r17
                                                                    r4 = (95)
                                                                    state = r17 and r4
                                                                    r17 = (96)
                                                                    state = state or r17
                                                                end
                                                            end
                                                        else
                                                            if state == 93 then
                                                                r83 = upvalueValues[upvalues[1]]
                                                                r4 = upvalueValues[upvalues[2]]
                                                                r39 = 21603295258443
                                                                r54 = "\156\188*\147\252\155\207\207=M\186\238Fs\001\217*\028\229'\174\211\024\147"
                                                                r88 = r4(r54, r39)
                                                                r20 = r83[r88]
                                                                r31 = r20 .. r17
                                                                state = false
                                                                ReturnVal = {
                                                                    state,
                                                                    r31
                                                                }
                                                                state = nil
                                                            end
                                                        end
                                                    else
                                                        if state <= 94 then
                                                            if state == 94 then
                                                                r83 = "debug"
                                                                r20 = _env[r83]
                                                                state = r20 and (97) or (98)
                                                                r31 = r20
                                                            end
                                                        else
                                                            if state == 95 then
                                                                r17 = r75
                                                                state = r14 + r17
                                                                r14 = state
                                                                r39 = "tick"
                                                                r54 = _env[r39]
                                                                r39 = r54()
                                                                r88 = r39 - r43
                                                                r54 = 0.5
                                                                r4 = r88 > r54
                                                                state = r4 and (99) or (100)
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 100 then
                                                    if state <= 98 then
                                                        if state <= 97 then
                                                            if state <= 96 then
                                                                if state == 96 then
                                                                    r17 = "getfenv"
                                                                    state = _env[r17]
                                                                    state = state and (101) or (102)
                                                                end
                                                            else
                                                                if state == 97 then
                                                                    r4 = "debug"
                                                                    r83 = _env[r4]
                                                                    r88 = upvalueValues[upvalues[1]]
                                                                    r54 = upvalueValues[upvalues[2]]
                                                                    r85 = 6802236656735
                                                                    r63 = "4~D^$_p"
                                                                    r39 = r54(r63, r85)
                                                                    r4 = r88[r39]
                                                                    r20 = r83[r4]
                                                                    r31 = r20
                                                                    state = 98
                                                                end
                                                            end
                                                        else
                                                            if state == 98 then
                                                                state = r31 and (103) or (104)
                                                            end
                                                        end
                                                    else
                                                        if state <= 99 then
                                                            if state == 99 then
                                                                r54 = upvalueValues[upvalues[1]]
                                                                r39 = upvalueValues[upvalues[2]]
                                                                r85 = "P\029\237\"\015-|\005\138\230\133\226\237\189\240\198\212r[\2136#\142"
                                                                r6 = 2203801666562
                                                                r63 = r39(r85, r6)
                                                                r88 = r54[r63]
                                                                r4 = false
                                                                ReturnVal = {
                                                                    r4,
                                                                    r88
                                                                }
                                                                state = nil
                                                            end
                                                        else
                                                            if state == 100 then
                                                                r17 = nil
                                                                state = 92
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 102 then
                                                        if state <= 101 then
                                                            if state == 101 then
                                                                r17 = "getfenv"
                                                                state = _env[r17]
                                                                r75 = 0
                                                                r17 = state(r75)
                                                                r83 = "type"
                                                                r20 = _env[r83]
                                                                r83 = r20(r17)
                                                                r4 = upvalueValues[upvalues[1]]
                                                                r88 = upvalueValues[upvalues[2]]
                                                                r63 = 17870880465025
                                                                r39 = "V\244e\140&"
                                                                r54 = r88(r39, r63)
                                                                r20 = r4[r54]
                                                                r31 = r83 ~= r20
                                                                state = r31 and (105) or (106)
                                                                r75 = r31
                                                            end
                                                        else
                                                            if state == 102 then
                                                                r31 = createClosure0(180, {})
                                                                r17 = "pcall"
                                                                state = _env[r17]
                                                                r20 = {
                                                                    state(r31)
                                                                }
                                                                r75 = r20[2]
                                                                r17 = r20[1]
                                                                r20 = not r17
                                                                state = r20 and (107) or (108)
                                                                r31 = r20
                                                            end
                                                        end
                                                    else
                                                        if state <= 103 then
                                                            if state == 103 then
                                                                r20 = "debug"
                                                                r31 = _env[r20]
                                                                r83 = upvalueValues[upvalues[1]]
                                                                r4 = upvalueValues[upvalues[2]]
                                                                r39 = 5583198423591
                                                                r54 = "\160\156{\237#\181\152"
                                                                r88 = r4(r54, r39)
                                                                r20 = r83[r88]
                                                                state = r31[r20]
                                                                r31 = state(r75)
                                                                r54 = upvalueValues[upvalues[1]]
                                                                r39 = upvalueValues[upvalues[2]]
                                                                r85 = "\196\151\031\191"
                                                                r6 = 34641600052995
                                                                r63 = r39(r85, r6)
                                                                r88 = r54[r63]
                                                                r4 = r31[r88]
                                                                r54 = upvalueValues[upvalues[1]]
                                                                r39 = upvalueValues[upvalues[2]]
                                                                r6 = 347680129185
                                                                r85 = "\214"
                                                                r63 = r39(r85, r6)
                                                                r88 = r54[r63]
                                                                r83 = r4 ~= r88
                                                                state = r83 and (109) or (110)
                                                                r20 = r83
                                                            end
                                                        else
                                                            if state == 104 then
                                                                state = 91
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 114 then
                                                if state <= 109 then
                                                    if state <= 107 then
                                                        if state <= 106 then
                                                            if state <= 105 then
                                                                if state == 105 then
                                                                    state = r75 and (111) or (112)
                                                                end
                                                            else
                                                                if state == 106 then
                                                                    r54 = upvalueValues[upvalues[1]]
                                                                    r39 = upvalueValues[upvalues[2]]
                                                                    r85 = "\143-\144\170\029"
                                                                    r6 = 17221443919699
                                                                    r63 = r39(r85, r6)
                                                                    r88 = r54[r63]
                                                                    r4 = r17[r88]
                                                                    r54 = "print"
                                                                    r88 = _env[r54]
                                                                    r83 = r4 ~= r88
                                                                    r20 = state
                                                                    state = r83 and (113) or (114)
                                                                    r31 = r83
                                                                end
                                                            end
                                                        else
                                                            if state == 107 then
                                                                state = r31 and (115) or (116)
                                                            end
                                                        end
                                                    else
                                                        if state <= 108 then
                                                            if state == 108 then
                                                                r83 = true
                                                                r20 = r75 ~= r83
                                                                r31 = r20
                                                                state = 107
                                                            end
                                                        else
                                                            if state == 109 then
                                                                r54 = upvalueValues[upvalues[1]]
                                                                r39 = upvalueValues[upvalues[2]]
                                                                r85 = "\154@\138b"
                                                                r6 = 10736863630215
                                                                r63 = r39(r85, r6)
                                                                r88 = r54[r63]
                                                                r4 = r31[r88]
                                                                r54 = upvalueValues[upvalues[1]]
                                                                r39 = upvalueValues[upvalues[2]]
                                                                r85 = "6\131\190"
                                                                r6 = 27787435635339
                                                                r63 = r39(r85, r6)
                                                                r88 = r54[r63]
                                                                r83 = r4 ~= r88
                                                                r20 = r83
                                                                state = 110
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 112 then
                                                        if state <= 111 then
                                                            if state <= 110 then
                                                                if state == 110 then
                                                                    state = r20 and (117) or (118)
                                                                end
                                                            else
                                                                if state == 111 then
                                                                    r31 = upvalueValues[upvalues[1]]
                                                                    r20 = upvalueValues[upvalues[2]]
                                                                    r4 = "\208\1577\028\220Y\180#\165\160\236S\252\159I\169\247\170\252\141Cp\224\246\255\021@\024\241\"Q\189\191"
                                                                    r88 = 34256024174159
                                                                    r83 = r20(r4, r88)
                                                                    r75 = r31[r83]
                                                                    state = false
                                                                    ReturnVal = {
                                                                        state,
                                                                        r75
                                                                    }
                                                                    state = nil
                                                                end
                                                            end
                                                        else
                                                            if state == 112 then
                                                                r17 = nil
                                                                state = 102
                                                            end
                                                        end
                                                    else
                                                        if state <= 113 then
                                                            if state == 113 then
                                                                state = r20
                                                                r75 = r31
                                                                state = 105
                                                            end
                                                        else
                                                            if state == 114 then
                                                                r54 = upvalueValues[upvalues[1]]
                                                                r39 = upvalueValues[upvalues[2]]
                                                                r85 = "\192\031\139C"
                                                                r6 = 16918013320902
                                                                r63 = r39(r85, r6)
                                                                r88 = r54[r63]
                                                                r4 = r17[r88]
                                                                r83 = not r4
                                                                r31 = r83
                                                                state = 113
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 119 then
                                                    if state <= 117 then
                                                        if state <= 116 then
                                                            if state <= 115 then
                                                                if state == 115 then
                                                                    r20 = upvalueValues[upvalues[1]]
                                                                    r83 = upvalueValues[upvalues[2]]
                                                                    r88 = "-\172:\180\238\164\166\219\148G\167@\179\216%K\143w\017\152i\014"
                                                                    r54 = 2601836020923
                                                                    r4 = r83(r88, r54)
                                                                    r31 = r20[r4]
                                                                    state = false
                                                                    ReturnVal = {
                                                                        state,
                                                                        r31
                                                                    }
                                                                    state = nil
                                                                end
                                                            else
                                                                if state == 116 then
                                                                    state = createClosure0(181, {
                                                                        upvalues[1],
                                                                        upvalues[2]
                                                                    })
                                                                    r31 = state
                                                                    r88 = "type"
                                                                    r4 = _env[r88]
                                                                    r88 = r4(r31)
                                                                    r54 = upvalueValues[upvalues[1]]
                                                                    r39 = upvalueValues[upvalues[2]]
                                                                    r6 = 24984942931314
                                                                    r85 = "h\160\244\161v\149-\165"
                                                                    r63 = r39(r85, r6)
                                                                    r4 = r54[r63]
                                                                    r83 = r88 ~= r4
                                                                    state = r83 and (119) or (120)
                                                                    r20 = r83
                                                                end
                                                            end
                                                        else
                                                            if state == 117 then
                                                                r4 = upvalueValues[upvalues[1]]
                                                                r88 = upvalueValues[upvalues[2]]
                                                                r39 = "\237\239l\015y\226%\031\142\140\187\"\187\019\175U\1671\252~\197\154\011\007\249RV6"
                                                                r63 = 6868393757822
                                                                r54 = r88(r39, r63)
                                                                r83 = r4[r54]
                                                                r20 = r83 .. r17
                                                                state = false
                                                                ReturnVal = {
                                                                    state,
                                                                    r20
                                                                }
                                                                state = nil
                                                            end
                                                        end
                                                    else
                                                        if state <= 118 then
                                                            if state == 118 then
                                                                r31 = nil
                                                                state = 104
                                                            end
                                                        else
                                                            if state == 119 then
                                                                state = r20 and (121) or (122)
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 121 then
                                                        if state <= 120 then
                                                            if state == 120 then
                                                                r88 = "tostring"
                                                                r4 = _env[r88]
                                                                r88 = r4(r31)
                                                                r39 = upvalueValues[upvalues[1]]
                                                                r63 = upvalueValues[upvalues[2]]
                                                                r82 = 18337803149659
                                                                r6 = "\137w\231\166\254\153\164_"
                                                                r85 = r63(r6, r82)
                                                                r4 = "find"
                                                                r4 = r88[r4]
                                                                r54 = r39[r85]
                                                                r4 = r4(r88, r54)
                                                                r83 = not r4
                                                                r20 = r83
                                                                state = 119
                                                            end
                                                        else
                                                            if state == 121 then
                                                                r83 = upvalueValues[upvalues[1]]
                                                                r4 = upvalueValues[upvalues[2]]
                                                                r39 = 26656122728572
                                                                r54 = "\223\004\212&*\191EmO^\213\131\162\244\184\219\133\205H\127\2297eL7SF\219X\172"
                                                                r88 = r4(r54, r39)
                                                                r20 = r83[r88]
                                                                state = false
                                                                ReturnVal = {
                                                                    state,
                                                                    r20
                                                                }
                                                                state = nil
                                                            end
                                                        end
                                                    else
                                                        if state <= 122 then
                                                            if state == 122 then
                                                                r4 = "rawget"
                                                                r83 = _env[r4]
                                                                r54 = "_G"
                                                                r88 = _env[r54]
                                                                r39 = upvalueValues[upvalues[1]]
                                                                r63 = upvalueValues[upvalues[2]]
                                                                r82 = 5077042563388
                                                                r6 = "7\174\007D\154dO"
                                                                r85 = r63(r6, r82)
                                                                r54 = r39[r85]
                                                                r4 = r83(r88, r54)
                                                                state = r4 and (123) or (124)
                                                                r20 = r4
                                                            end
                                                        else
                                                            if state == 123 then
                                                                state = r20 and (125) or (126)
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 142 then
                                            if state <= 133 then
                                                if state <= 128 then
                                                    if state <= 126 then
                                                        if state <= 125 then
                                                            if state <= 124 then
                                                                if state == 124 then
                                                                    r4 = "rawget"
                                                                    r83 = _env[r4]
                                                                    r54 = "_G"
                                                                    r88 = _env[r54]
                                                                    r39 = upvalueValues[upvalues[1]]
                                                                    r63 = upvalueValues[upvalues[2]]
                                                                    r6 = "\252\016\170\237\175\184\200"
                                                                    r82 = 32676809177968
                                                                    r85 = r63(r6, r82)
                                                                    r54 = r39[r85]
                                                                    r4 = r83(r88, r54)
                                                                    r20 = r4
                                                                    state = 123
                                                                end
                                                            else
                                                                if state == 125 then
                                                                    r83 = upvalueValues[upvalues[1]]
                                                                    r4 = upvalueValues[upvalues[2]]
                                                                    r39 = 533875802360
                                                                    r54 = ":J\237p\168\239\131\239}m\029\019\130\217\187\195"
                                                                    r88 = r4(r54, r39)
                                                                    r20 = r83[r88]
                                                                    state = false
                                                                    ReturnVal = {
                                                                        state,
                                                                        r20
                                                                    }
                                                                    state = nil
                                                                end
                                                            end
                                                        else
                                                            if state == 126 then
                                                                r83 = upvalueValues[upvalues[1]]
                                                                r4 = upvalueValues[upvalues[2]]
                                                                r54 = "\1955\179d\004y]"
                                                                r39 = 25126279065012
                                                                r88 = r4(r54, r39)
                                                                r20 = r83[r88]
                                                                r4 = upvalueValues[upvalues[1]]
                                                                r88 = upvalueValues[upvalues[2]]
                                                                r63 = 1421546717845
                                                                r39 = "\169\241c"
                                                                r54 = r88(r39, r63)
                                                                r83 = r4[r54]
                                                                r88 = upvalueValues[upvalues[1]]
                                                                r54 = upvalueValues[upvalues[2]]
                                                                r85 = 29140569486593
                                                                r63 = ";\177\028\r"
                                                                r39 = r54(r63, r85)
                                                                r4 = r88[r39]
                                                                r54 = upvalueValues[upvalues[1]]
                                                                r39 = upvalueValues[upvalues[2]]
                                                                r6 = 1499050672826
                                                                r85 = "\158\187#3\167wy"
                                                                r63 = r39(r85, r6)
                                                                r88 = r54[r63]
                                                                state = {
                                                                    r20,
                                                                    r83,
                                                                    r4,
                                                                    r88
                                                                }
                                                                r20 = state
                                                                r83 = "pairs"
                                                                state = _env[r83]
                                                                r54 = {
                                                                    state(r20)
                                                                }
                                                                r4 = r54[2]
                                                                r88 = r54[3]
                                                                r83 = r54[1]
                                                                state = 127
                                                            end
                                                        end
                                                    else
                                                        if state <= 127 then
                                                            if state == 127 then
                                                                r88, r39 = r83(r4, r88)
                                                                state = r88 and (128) or (129)
                                                            end
                                                        else
                                                            if state == 128 then
                                                                r63 = "rawget"
                                                                state = _env[r63]
                                                                r6 = "_G"
                                                                r85 = _env[r6]
                                                                r63 = state(r85, r39)
                                                                state = r63 and (130) or (131)
                                                                r54 = r88
                                                                r85 = r63
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 131 then
                                                        if state <= 130 then
                                                            if state <= 129 then
                                                                if state == 129 then
                                                                    r88 = "package"
                                                                    r4 = _env[r88]
                                                                    state = r4 and (132) or (133)
                                                                    r83 = r4
                                                                end
                                                            else
                                                                if state == 130 then
                                                                    r59 = "type"
                                                                    r82 = _env[r59]
                                                                    r59 = r82(r63)
                                                                    r87 = upvalueValues[upvalues[1]]
                                                                    r50 = upvalueValues[upvalues[2]]
                                                                    r52 = ":zrz\179\251\199\129"
                                                                    r16 = 19679924855756
                                                                    r23 = r50(r52, r16)
                                                                    r82 = r87[r23]
                                                                    r6 = r59 == r82
                                                                    r85 = r6
                                                                    state = 131
                                                                end
                                                            end
                                                        else
                                                            if state == 131 then
                                                                state = r85 and (134) or (135)
                                                            end
                                                        end
                                                    else
                                                        if state <= 132 then
                                                            if state == 132 then
                                                                r54 = "package"
                                                                r88 = _env[r54]
                                                                r39 = upvalueValues[upvalues[1]]
                                                                r63 = upvalueValues[upvalues[2]]
                                                                r82 = 24690382744809
                                                                r6 = "\138\128b>\218f"
                                                                r85 = r63(r6, r82)
                                                                r54 = r39[r85]
                                                                r4 = r88[r54]
                                                                r83 = r4
                                                                state = 133
                                                            end
                                                        else
                                                            if state == 133 then
                                                                state = r83 and (136) or (137)
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 138 then
                                                    if state <= 136 then
                                                        if state <= 135 then
                                                            if state <= 134 then
                                                                if state == 134 then
                                                                    r82 = "debug"
                                                                    r6 = _env[r82]
                                                                    state = r6 and (138) or (139)
                                                                    r85 = r6
                                                                end
                                                            else
                                                                if state == 135 then
                                                                    r39 = nil
                                                                    r63 = nil
                                                                    r54 = nil
                                                                    state = 127
                                                                end
                                                            end
                                                        else
                                                            if state == 136 then
                                                                r83 = "require"
                                                                state = _env[r83]
                                                                r83 = state
                                                                r54 = "debug"
                                                                r88 = _env[r54]
                                                                state = r88 and (140) or (141)
                                                                r4 = r88
                                                            end
                                                        end
                                                    else
                                                        if state <= 137 then
                                                            if state == 137 then
                                                                state = r57()
                                                                r83 = state
                                                                r4 = "pairs"
                                                                state = _env[r4]
                                                                r39 = {
                                                                    state(r83)
                                                                }
                                                                r4 = r39[1]
                                                                r54 = r39[3]
                                                                r88 = r39[2]
                                                                state = 142
                                                            end
                                                        else
                                                            if state == 138 then
                                                                r59 = "debug"
                                                                r82 = _env[r59]
                                                                r87 = upvalueValues[upvalues[1]]
                                                                r50 = upvalueValues[upvalues[2]]
                                                                r16 = 1419659281045
                                                                r52 = "\148 \150\223;\212\241"
                                                                r23 = r50(r52, r16)
                                                                r59 = r87[r23]
                                                                r6 = r82[r59]
                                                                r82 = r6(r63)
                                                                r85 = r82
                                                                state = 139
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 140 then
                                                        if state <= 139 then
                                                            if state == 139 then
                                                                state = r85 and (143) or (144)
                                                                r6 = r85
                                                            end
                                                        else
                                                            if state == 140 then
                                                                r39 = "debug"
                                                                r54 = _env[r39]
                                                                r63 = upvalueValues[upvalues[1]]
                                                                r85 = upvalueValues[upvalues[2]]
                                                                r59 = 8759434022894
                                                                r82 = "\179R\250\023<\1415"
                                                                r6 = r85(r82, r59)
                                                                r39 = r63[r6]
                                                                r88 = r54[r39]
                                                                r4 = r88
                                                                state = 141
                                                            end
                                                        end
                                                    else
                                                        if state <= 141 then
                                                            if state == 141 then
                                                                state = r4 and (145) or (146)
                                                            end
                                                        else
                                                            if state == 142 then
                                                                r54, r63 = r4(r88, r54)
                                                                state = r54 and (147) or (148)
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 151 then
                                                if state <= 147 then
                                                    if state <= 145 then
                                                        if state <= 144 then
                                                            if state <= 143 then
                                                                if state == 143 then
                                                                    r59 = state
                                                                    r23 = upvalueValues[upvalues[1]]
                                                                    r52 = upvalueValues[upvalues[2]]
                                                                    r12 = 29730328442388
                                                                    r26 = "~t\189\254\t\006"
                                                                    r16 = r52(r26, r12)
                                                                    r50 = r23[r16]
                                                                    r87 = r85[r50]
                                                                    state = r87 and (149) or (150)
                                                                    r82 = r87
                                                                end
                                                            else
                                                                if state == 144 then
                                                                    state = r6 and (151) or (152)
                                                                end
                                                            end
                                                        else
                                                            if state == 145 then
                                                                r88 = "debug"
                                                                r4 = _env[r88]
                                                                r54 = upvalueValues[upvalues[1]]
                                                                r39 = upvalueValues[upvalues[2]]
                                                                r6 = 15606479559779
                                                                r85 = "\254\251\193\020\169\153\219"
                                                                r63 = r39(r85, r6)
                                                                r88 = r54[r63]
                                                                state = r4[r88]
                                                                r4 = state(r83)
                                                                r39 = upvalueValues[upvalues[1]]
                                                                r63 = upvalueValues[upvalues[2]]
                                                                r82 = 25038062873995
                                                                r6 = "\136|\130\153"
                                                                r85 = r63(r6, r82)
                                                                r54 = r39[r85]
                                                                r88 = r4[r54]
                                                                r39 = upvalueValues[upvalues[1]]
                                                                r63 = upvalueValues[upvalues[2]]
                                                                r82 = 19496297653110
                                                                r6 = "&"
                                                                r85 = r63(r6, r82)
                                                                r54 = r39[r85]
                                                                state = r88 ~= r54
                                                                state = state and (153) or (154)
                                                            end
                                                        end
                                                    else
                                                        if state <= 146 then
                                                            if state == 146 then
                                                                r83 = nil
                                                                state = 137
                                                            end
                                                        else
                                                            if state == 147 then
                                                                r39 = r54
                                                                r85 = r61[r39]
                                                                state = r85 ~= r63
                                                                state = state and (155) or (156)
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 149 then
                                                        if state <= 148 then
                                                            if state == 148 then
                                                                r54 = "hookfunction"
                                                                r88 = _env[r54]
                                                                state = r88 and (157) or (158)
                                                                r4 = r88
                                                            end
                                                        else
                                                            if state == 149 then
                                                                r50 = "tostring"
                                                                r87 = _env[r50]
                                                                r16 = upvalueValues[upvalues[1]]
                                                                r26 = upvalueValues[upvalues[2]]
                                                                r62 = "g\200\000O\149\232"
                                                                r24 = 17888146071689
                                                                r12 = r26(r62, r24)
                                                                r52 = r16[r12]
                                                                r23 = r85[r52]
                                                                r50 = r87(r23)
                                                                r87 = "lower"
                                                                r87 = r50[r87]
                                                                r87 = r87(r50)
                                                                r52 = upvalueValues[upvalues[1]]
                                                                r16 = upvalueValues[upvalues[2]]
                                                                r12 = "Y\163\212\185\196\016\200"
                                                                r62 = 3176235599303
                                                                r26 = r16(r12, r62)
                                                                r50 = "find"
                                                                r50 = r87[r50]
                                                                r23 = r52[r26]
                                                                r50 = r50(r87, r23)
                                                                r82 = r50
                                                                state = 150
                                                            end
                                                        end
                                                    else
                                                        if state <= 150 then
                                                            if state == 150 then
                                                                state = r59
                                                                r6 = r82
                                                                state = 144
                                                            end
                                                        else
                                                            if state == 151 then
                                                                r59 = upvalueValues[upvalues[1]]
                                                                r87 = upvalueValues[upvalues[2]]
                                                                r52 = 16149251612000
                                                                r23 = "Q\n2,\183\143\148\163\018\207E:-Z\185\024\026\185'[\187\192\216\149(Qx"
                                                                r50 = r87(r23, r52)
                                                                r82 = r59[r50]
                                                                r6 = r82 .. r39
                                                                state = false
                                                                ReturnVal = {
                                                                    state,
                                                                    r6
                                                                }
                                                                state = nil
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 156 then
                                                    if state <= 154 then
                                                        if state <= 153 then
                                                            if state <= 152 then
                                                                if state == 152 then
                                                                    r85 = nil
                                                                    state = 135
                                                                end
                                                            else
                                                                if state == 153 then
                                                                    r54 = upvalueValues[upvalues[1]]
                                                                    r39 = upvalueValues[upvalues[2]]
                                                                    r6 = 8209543089902
                                                                    r85 = "Lg<\tv;:\012xKmb\182\138\220\166W\136\221\185\181\249\026\251w\018\148\165\220\024H\203r!"
                                                                    r63 = r39(r85, r6)
                                                                    r88 = r54[r63]
                                                                    state = false
                                                                    ReturnVal = {
                                                                        state,
                                                                        r88
                                                                    }
                                                                    state = nil
                                                                end
                                                            end
                                                        else
                                                            if state == 154 then
                                                                r4 = nil
                                                                state = 146
                                                            end
                                                        end
                                                    else
                                                        if state <= 155 then
                                                            if state == 155 then
                                                                r82 = upvalueValues[upvalues[1]]
                                                                r59 = upvalueValues[upvalues[2]]
                                                                r50 = "\190\174A\147o\210\246L\227|\006\208T)\\\127\016hQ\209\020\187\171\217\169\168\243b\131\205\174&G"
                                                                r23 = 31906456631817
                                                                r87 = r59(r50, r23)
                                                                r6 = r82[r87]
                                                                r59 = "tostring"
                                                                r82 = _env[r59]
                                                                r59 = r82(r39)
                                                                r85 = r6 .. r59
                                                                state = false
                                                                ReturnVal = {
                                                                    state,
                                                                    r85
                                                                }
                                                                state = nil
                                                            end
                                                        else
                                                            if state == 156 then
                                                                r39 = nil
                                                                r63 = nil
                                                                state = 142
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 158 then
                                                        if state <= 157 then
                                                            if state == 157 then
                                                                r63 = createClosure3(182, {})
                                                                r39 = "pcall"
                                                                r54 = _env[r39]
                                                                r39 = r54(r63)
                                                                r88 = not r39
                                                                r4 = r88
                                                                state = 158
                                                            end
                                                        else
                                                            if state == 158 then
                                                                state = r4 and (159) or (160)
                                                            end
                                                        end
                                                    else
                                                        if state <= 159 then
                                                            if state == 159 then
                                                                r88 = upvalueValues[upvalues[1]]
                                                                r54 = upvalueValues[upvalues[2]]
                                                                r85 = 24583064562871
                                                                r63 = "\014d0\180U\222DL\210\\r9k\211\143\018\230c\020\196w\235\234g\\\129\139\195\003\146\212\023"
                                                                r39 = r54(r63, r85)
                                                                r4 = r88[r39]
                                                                state = false
                                                                ReturnVal = {
                                                                    state,
                                                                    r4
                                                                }
                                                                state = nil
                                                            end
                                                        else
                                                            if state == 160 then
                                                                state = true
                                                                ReturnVal = {
                                                                    state
                                                                }
                                                                state = nil
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure1 entry 15758697 -> 161, states 161-163
                                    if state <= 162 then
                                        if state <= 161 then
                                            if state == 161 then -- entry 15758697 -> 161
                                                r57 = createClosure3(183, {
                                                    upvalues[1],
                                                    upvalues[2],
                                                    upvalues[3],
                                                    upvalues[4]
                                                })
                                                ReturnVal = "pcall"
                                                state = _env[ReturnVal]
                                                r61 = {
                                                    state(r57)
                                                }
                                                ReturnVal = r61[1]
                                                r57 = ReturnVal
                                                state = not r57
                                                state = state and (162) or (163)
                                                r38 = r61[2]
                                            end
                                        else
                                            if state == 162 then
                                                state = createClosure1(186, {
                                                    upvalues[3],
                                                    upvalues[4]
                                                })
                                                r61 = state
                                                state = r61(r38)
                                                r61 = nil
                                                state = 163
                                            end
                                        end
                                    else
                                        if state == 163 then
                                            r38 = nil
                                            r57 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            else
                                -- createClosure0 entry 11576580 -> 164, states 164-164
                                if state == 164 then -- entry 11576580 -> 164
                                    ReturnVal = "print"
                                    state = _env[ReturnVal]
                                    r57 = upvalueValues[upvalues[1]]
                                    r61 = upvalueValues[upvalues[2]]
                                    r17 = 19428806026071
                                    r14 = "\149\127,Q\228\235\171n%#I\213q\025H\144\011gO\152*\225"
                                    r43 = r61(r14, r17)
                                    r38 = r57[r43]
                                    ReturnVal = state(r38)
                                    ReturnVal = "wait"
                                    state = _env[ReturnVal]
                                    r61 = "math"
                                    r57 = _env[r61]
                                    r43 = upvalueValues[upvalues[1]]
                                    r14 = upvalueValues[upvalues[2]]
                                    r75 = "\002\240N(\006\184"
                                    r31 = 8542230466441
                                    r17 = r14(r75, r31)
                                    r61 = r43[r17]
                                    r38 = r57[r61]
                                    r61 = 1
                                    r43 = 5
                                    r57 = {
                                        r38(r61, r43)
                                    }
                                    ReturnVal = state(unpack(r57))
                                    ReturnVal = "loadstring"
                                    state = _env[ReturnVal]
                                    r57 = "game"
                                    r38 = _env[r57]
                                    r43 = upvalueValues[upvalues[1]]
                                    r14 = upvalueValues[upvalues[2]]
                                    r75 = "#\219\014\022\173\174\162$\r\tX\151\244\153H,\r\151\252:\154\173\172\0213\178\018\215\148~C\136\171\131<\027>\215\131@\162\214_*\163\189\250\246\173\242\156\196+yjw@\157;\161\183\176\008\247\030\0172*\235\239Bp\192\030$sPC\168&\232\230\173\165\132"
                                    r31 = 25052212637073
                                    r17 = r14(r75, r31)
                                    r61 = r43[r17]
                                    r43 = "HttpGet"
                                    r43 = r38[r43]
                                    r57 = {
                                        r43(r38, r61)
                                    }
                                    ReturnVal = state(unpack(r57))
                                    state = ReturnVal()
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        end
                    end
                else
                    if state <= 182 then
                        if state <= 179 then
                            if state <= 172 then
                                if state <= 171 then
                                    -- createClosure1 entry 14354079 -> 165, states 165-171
                                    if state <= 168 then
                                        if state <= 166 then
                                            if state <= 165 then
                                                if state == 165 then -- entry 14354079 -> 165
                                                    state = createClosure2(190, {
                                                        upvalues[1],
                                                        upvalues[2]
                                                    })
                                                    r38 = state
                                                    state = createClosure0(198, {
                                                        upvalues[1],
                                                        upvalues[2]
                                                    })
                                                    ReturnVal = r38()
                                                    r57 = state
                                                    state = createClosure4(203, {
                                                        upvalues[1],
                                                        upvalues[2]
                                                    })
                                                    r61 = state
                                                    state = not ReturnVal
                                                    state = state and (166) or (167)
                                                end
                                            else
                                                if state == 166 then
                                                    state = false
                                                    ReturnVal = {
                                                        state
                                                    }
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state <= 167 then
                                                if state == 167 then
                                                    ReturnVal = r57()
                                                    state = not ReturnVal
                                                    state = state and (168) or (169)
                                                end
                                            else
                                                if state == 168 then
                                                    state = false
                                                    ReturnVal = {
                                                        state
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        if state <= 170 then
                                            if state <= 169 then
                                                if state == 169 then
                                                    r43 = "game"
                                                    ReturnVal = _env[r43]
                                                    state = r61(ReturnVal)
                                                    state = state and (170) or (171)
                                                end
                                            else
                                                if state == 170 then
                                                    state = false
                                                    ReturnVal = {
                                                        state
                                                    }
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state == 171 then
                                                state = true
                                                ReturnVal = {
                                                    state
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure2 entry 3036479 -> 172, states 172-172
                                    if state == 172 then -- entry 3036479 -> 172
                                        r61 = 4777848
                                        r57 = "jn"
                                        r38 = r57 ^ r61
                                        ReturnVal = 14222829
                                        state = ReturnVal - r38
                                        r38 = state
                                        ReturnVal = "8gZvgeBy2xnbuoD"
                                        state = ReturnVal / r38
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure2 entry 5396212 -> 173, states 173-179
                                if state <= 176 then
                                    if state <= 174 then
                                        if state <= 173 then
                                            if state == 173 then -- entry 5396212 -> 173
                                                state = {}
                                                r38 = state
                                                ReturnVal = "pairs"
                                                state = _env[ReturnVal]
                                                r14 = "_G"
                                                r43 = _env[r14]
                                                r14 = {
                                                    state(r43)
                                                }
                                                ReturnVal = r14[1]
                                                r61 = r14[3]
                                                r57 = r14[2]
                                                r43 = ReturnVal
                                                state = 174
                                            end
                                        else
                                            if state == 174 then
                                                r61, r17 = r43(r57, r61)
                                                state = r61 and (175) or (176)
                                            end
                                        end
                                    else
                                        if state <= 175 then
                                            if state == 175 then
                                                r31 = "type"
                                                r75 = _env[r31]
                                                r31 = r75(r17)
                                                r20 = upvalueValues[upvalues[1]]
                                                r83 = upvalueValues[upvalues[2]]
                                                r54 = 5086766893376
                                                r88 = "\134\014\219\139\156\1951\247"
                                                r4 = r83(r88, r54)
                                                r75 = r20[r4]
                                                state = r31 == r75
                                                state = state and (177) or (178)
                                                r14 = r61
                                            end
                                        else
                                            if state == 176 then
                                                ReturnVal = {
                                                    r38
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    if state <= 178 then
                                        if state <= 177 then
                                            if state == 177 then
                                                r75 = "tostring"
                                                state = _env[r75]
                                                r75 = state(r17)
                                                r38[r14] = r75
                                                state = 179
                                            end
                                        else
                                            if state == 178 then
                                                state = r17
                                                r38[r14] = state
                                                state = 179
                                            end
                                        end
                                    else
                                        if state == 179 then
                                            r17 = nil
                                            r14 = nil
                                            state = 174
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 181 then
                                if state <= 180 then
                                    -- createClosure0 entry 6966008 -> 180, states 180-180
                                    if state == 180 then -- entry 6966008 -> 180
                                        state = true
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure0 entry 13631309 -> 181, states 181-181
                                    if state == 181 then -- entry 13631309 -> 181
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r38 = upvalueValues[upvalues[2]]
                                        r61 = "\141\204\129\"\151"
                                        r43 = 625697308963
                                        r57 = r38(r61, r43)
                                        state = ReturnVal[r57]
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure3 entry 4651732 -> 182, states 182-182
                                if state == 182 then -- entry 4651732 -> 182
                                    ReturnVal = "hookfunction"
                                    state = _env[ReturnVal]
                                    r57 = "hookfunction"
                                    r38 = _env[r57]
                                    r57 = createClosure5(210, {})
                                    ReturnVal = state(r38, r57)
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        end
                    else
                        if state <= 197 then
                            if state <= 189 then
                                if state <= 185 then
                                    -- createClosure3 entry 15136114 -> 183, states 183-185
                                    if state <= 184 then
                                        if state <= 183 then
                                            if state == 183 then -- entry 15136114 -> 183
                                                r38 = upvalueValues[upvalues[1]]
                                                r57 = r38()
                                                r38 = 100
                                                ReturnVal = r57 % r38
                                                r38 = 1000
                                                state = ReturnVal / r38
                                                r38 = state
                                                ReturnVal = "wait"
                                                state = _env[ReturnVal]
                                                ReturnVal = state(r38)
                                                state = upvalueValues[upvalues[2]]
                                                r61 = {
                                                    state()
                                                }
                                                r57 = r61[2]
                                                ReturnVal = r61[1]
                                                r61 = ReturnVal
                                                state = not r61
                                                state = state and (184) or (185)
                                            end
                                        else
                                            if state == 184 then
                                                ReturnVal = "error"
                                                state = _env[ReturnVal]
                                                r17 = upvalueValues[upvalues[3]]
                                                r75 = upvalueValues[upvalues[4]]
                                                r83 = 10413344756465
                                                r20 = "Z(b\128K\152h\237\168\022\232\190}\236'\1342\025\219+"
                                                r31 = r75(r20, r83)
                                                r14 = r17[r31]
                                                r75 = "tostring"
                                                r17 = _env[r75]
                                                r75 = r17(r57)
                                                r43 = r14 .. r75
                                                ReturnVal = state(r43)
                                                state = 185
                                            end
                                        end
                                    else
                                        if state == 185 then
                                            r38 = nil
                                            r57 = nil
                                            r61 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure1 entry 9702040 -> 186, states 186-189
                                    if state <= 187 then
                                        if state <= 186 then
                                            if state == 186 then -- entry 9702040 -> 186
                                                r38 = args[1]
                                                state = 187
                                            end
                                        else
                                            if state == 187 then
                                                state = true
                                                state = state and (188) or (189)
                                            end
                                        end
                                    else
                                        if state <= 188 then
                                            if state == 188 then
                                                ReturnVal = "print"
                                                state = _env[ReturnVal]
                                                r43 = upvalueValues[upvalues[1]]
                                                r14 = upvalueValues[upvalues[2]]
                                                r31 = 14592964991627
                                                r75 = "\127\142\017\238\134\139@\169^\172\162T\029\029\131\144"
                                                r17 = r14(r75, r31)
                                                r61 = r43[r17]
                                                r57 = r61 .. r38
                                                ReturnVal = state(r57)
                                                ReturnVal = "wait"
                                                state = _env[ReturnVal]
                                                r57 = 1
                                                ReturnVal = state(r57)
                                                state = 187
                                            end
                                        else
                                            if state == 189 then
                                                r38 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure2 entry 7968408 -> 190, states 190-197
                                if state <= 193 then
                                    if state <= 191 then
                                        if state <= 190 then
                                            if state == 190 then -- entry 7968408 -> 190
                                                ReturnVal = "pairs"
                                                state = _env[ReturnVal]
                                                r43 = "getfenv"
                                                r61 = _env[r43]
                                                r43 = {
                                                    r61()
                                                }
                                                r61 = {
                                                    state(unpack(r43))
                                                }
                                                ReturnVal = r61[1]
                                                r57 = r61[3]
                                                r38 = r61[2]
                                                r61 = ReturnVal
                                                state = 191
                                            end
                                        else
                                            if state == 191 then
                                                r57, r14 = r61(r38, r57)
                                                state = r57 and (192) or (193)
                                            end
                                        end
                                    else
                                        if state <= 192 then
                                            if state == 192 then
                                                r20 = "typeof"
                                                r31 = _env[r20]
                                                r43 = r57
                                                r20 = r31(r43)
                                                r83 = upvalueValues[upvalues[1]]
                                                r4 = upvalueValues[upvalues[2]]
                                                r39 = 6620136377354
                                                r54 = "U\242\240@x2"
                                                r88 = r4(r54, r39)
                                                r31 = r83[r88]
                                                r75 = r20 == r31
                                                state = r75 and (194) or (195)
                                                r17 = r75
                                            end
                                        else
                                            if state == 193 then
                                                state = true
                                                ReturnVal = {
                                                    state
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    if state <= 195 then
                                        if state <= 194 then
                                            if state == 194 then
                                                r20 = upvalueValues[upvalues[1]]
                                                r83 = upvalueValues[upvalues[2]]
                                                r54 = 27331358093751
                                                r88 = "\1959\237\148E\160"
                                                r4 = r83(r88, r54)
                                                r31 = r20[r4]
                                                r75 = "match"
                                                r75 = r43[r75]
                                                r75 = r75(r43, r31)
                                                r17 = r75
                                                state = 195
                                            end
                                        else
                                            if state == 195 then
                                                state = r17 and (196) or (197)
                                            end
                                        end
                                    else
                                        if state <= 196 then
                                            if state == 196 then
                                                state = false
                                                ReturnVal = {
                                                    state
                                                }
                                                state = nil
                                            end
                                        else
                                            if state == 197 then
                                                r14 = nil
                                                r43 = nil
                                                state = 191
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 209 then
                                if state <= 202 then
                                    -- createClosure0 entry 4332262 -> 198, states 198-202
                                    if state <= 200 then
                                        if state <= 199 then
                                            if state <= 198 then
                                                if state == 198 then -- entry 4332262 -> 198
                                                    ReturnVal = "getfenv"
                                                    state = _env[ReturnVal]
                                                    ReturnVal = state()
                                                    r38 = ReturnVal
                                                    state = r38 and (199) or (200)
                                                    ReturnVal = r38
                                                end
                                            else
                                                if state == 199 then
                                                    r17 = "type"
                                                    r14 = _env[r17]
                                                    r17 = r14(r38)
                                                    r75 = upvalueValues[upvalues[1]]
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r83 = "\255\129g\011:"
                                                    r4 = 13664617060571
                                                    r20 = r31(r83, r4)
                                                    r14 = r75[r20]
                                                    r43 = r17 == r14
                                                    r61 = state
                                                    state = r43 and (201) or (202)
                                                    r57 = r43
                                                end
                                            end
                                        else
                                            if state == 200 then
                                                ReturnVal = {
                                                    ReturnVal
                                                }
                                                state = nil
                                            end
                                        end
                                    else
                                        if state <= 201 then
                                            if state == 201 then
                                                r75 = upvalueValues[upvalues[1]]
                                                r31 = upvalueValues[upvalues[2]]
                                                r83 = "+\028\194}"
                                                r4 = 9221972414662
                                                r20 = r31(r83, r4)
                                                r17 = r75[r20]
                                                r14 = r38[r17]
                                                r17 = nil
                                                r43 = r14 ~= r17
                                                r57 = r43
                                                state = 202
                                            end
                                        else
                                            if state == 202 then
                                                state = r61
                                                ReturnVal = r57
                                                state = 200
                                            end
                                        end
                                    end
                                else
                                    -- createClosure4 entry 12100482 -> 203, states 203-209
                                    if state <= 206 then
                                        if state <= 204 then
                                            if state <= 203 then
                                                if state == 203 then -- entry 12100482 -> 203
                                                    r38 = args[1]
                                                    ReturnVal = "getmetatable"
                                                    state = _env[ReturnVal]
                                                    ReturnVal = state(r38)
                                                    r57 = ReturnVal
                                                    state = r57 and (204) or (205)
                                                    ReturnVal = r57
                                                end
                                            else
                                                if state == 204 then
                                                    r75 = upvalueValues[upvalues[1]]
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r83 = "!\025Lw"
                                                    r4 = 27957055402714
                                                    r20 = r31(r83, r4)
                                                    r17 = r75[r20]
                                                    r14 = r57[r17]
                                                    r43 = state
                                                    state = r14 and (206) or (207)
                                                    r61 = r14
                                                end
                                            end
                                        else
                                            if state <= 205 then
                                                if state == 205 then
                                                    ReturnVal = {
                                                        ReturnVal
                                                    }
                                                    state = nil
                                                end
                                            else
                                                if state == 206 then
                                                    state = r43
                                                    ReturnVal = r61
                                                    state = 205
                                                end
                                            end
                                        end
                                    else
                                        if state <= 208 then
                                            if state <= 207 then
                                                if state == 207 then
                                                    r20 = upvalueValues[upvalues[1]]
                                                    r83 = upvalueValues[upvalues[2]]
                                                    r54 = 3465187886669
                                                    r88 = "\156\246\247\011\167\158\246"
                                                    r4 = r83(r88, r54)
                                                    r31 = r20[r4]
                                                    r75 = r57[r31]
                                                    r17 = state
                                                    state = r75 and (208) or (209)
                                                    r14 = r75
                                                end
                                            else
                                                if state == 208 then
                                                    state = r17
                                                    r61 = r14
                                                    state = 206
                                                end
                                            end
                                        else
                                            if state == 209 then
                                                r20 = upvalueValues[upvalues[1]]
                                                r83 = upvalueValues[upvalues[2]]
                                                r54 = 27559775564321
                                                r88 = "BT\196\020}b7vU\136"
                                                r4 = r83(r88, r54)
                                                r31 = r20[r4]
                                                r75 = r57[r31]
                                                r14 = r75
                                                state = 208
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure5 entry 11856614 -> 210, states 210-210
                                if state == 210 then -- entry 11856614 -> 210
                                    ReturnVal = {}
                                    state = nil
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
        upvalueValues = {}
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
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
            end
            return closure
        end
        currentUpvalueId = 0
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -590854
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -590854
                    end
                })
            end
        end
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)