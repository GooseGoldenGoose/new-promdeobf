return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, allocUpvalue, releaseUpvalues, createClosure4, createClosure3, createUpvalueProxy, createClosure0, currentUpvalueId, createClosure, createClosure6, releaseUpvalue, createClosure2, createClosure1, createClosure5, upvalueValues, vm, upvalueRefCounts)
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
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, ReturnVal, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57
            while state do
                if state <= 115 then
                    if state <= 81 then
                        if state <= 52 then
                            if state <= 50 then
                                if state <= 49 then
                                    -- root entry 14972486 -> 1, states 1-49
                                    if state <= 25 then
                                        if state <= 13 then
                                            if state <= 7 then
                                                if state <= 4 then
                                                    if state <= 2 then
                                                        if state <= 1 then
                                                            if state == 1 then -- entry 14972486 -> 1
                                                                r25 = allocUpvalue()
                                                                state = true
                                                                upvalueValues[r25] = state
                                                                r14 = "string"
                                                                ReturnVal = _env[r14]
                                                                r14 = "gmatch"
                                                                state = ReturnVal[r14]
                                                                r14 = allocUpvalue()
                                                                upvalueValues[r14] = state
                                                                state = createClosure0(50, {})
                                                                r37 = allocUpvalue()
                                                                r20 = allocUpvalue()
                                                                upvalueValues[r20] = state
                                                                r8 = createClosure3(51, {
                                                                    r37
                                                                })
                                                                state = false
                                                                upvalueValues[r37] = state
                                                                r18 = "pcall"
                                                                r50 = _env[r18]
                                                                r18 = r50(r8)
                                                                state = r18 and (2) or (3)
                                                                r11 = args
                                                                ReturnVal = r18
                                                            end
                                                        else
                                                            if state == 2 then
                                                                r50 = upvalueValues[r37]
                                                                ReturnVal = r50
                                                                state = 3
                                                            end
                                                        end
                                                    else
                                                        if state <= 3 then
                                                            if state == 3 then
                                                                r50 = ReturnVal
                                                                r18 = "math"
                                                                ReturnVal = _env[r18]
                                                                r18 = "random"
                                                                state = ReturnVal[r18]
                                                                r18 = allocUpvalue()
                                                                upvalueValues[r18] = state
                                                                r8 = "table"
                                                                ReturnVal = _env[r8]
                                                                r8 = "concat"
                                                                state = ReturnVal[r8]
                                                                r8 = state
                                                                r31 = state
                                                                r47 = "table"
                                                                r33 = _env[r47]
                                                                state = r33 and (4) or (5)
                                                                r32 = r33
                                                            end
                                                        else
                                                            if state == 4 then
                                                                r41 = "table"
                                                                r47 = _env[r41]
                                                                r41 = "unpack"
                                                                r33 = r47[r41]
                                                                r32 = r33
                                                                state = 5
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 6 then
                                                        if state <= 5 then
                                                            if state == 5 then
                                                                state = r31
                                                                state = r32 and (6) or (7)
                                                                ReturnVal = r32
                                                            end
                                                        else
                                                            if state == 6 then
                                                                r32 = allocUpvalue()
                                                                upvalueValues[r32] = ReturnVal
                                                                state = upvalueValues[r18]
                                                                r40 = createClosure5(52, {})
                                                                r33 = 65
                                                                r31 = 3
                                                                ReturnVal = state(r31, r33)
                                                                r31 = allocUpvalue()
                                                                state = 0
                                                                upvalueValues[r31] = ReturnVal
                                                                r33 = state
                                                                r41 = "pcall"
                                                                ReturnVal = _env[r41]
                                                                state = 0
                                                                r41 = {
                                                                    ReturnVal(r40)
                                                                }
                                                                r47 = state
                                                                state = {
                                                                    unpack(r41)
                                                                }
                                                                r41 = state
                                                                ReturnVal = 2
                                                                state = r41[ReturnVal]
                                                                r40 = state
                                                                ReturnVal = "tonumber"
                                                                state = _env[ReturnVal]
                                                                r57 = upvalueValues[r14]
                                                                r1 = "tostring"
                                                                r52 = _env[r1]
                                                                r1 = r52(r40)
                                                                r52 = ":(%d*):"
                                                                r51 = r57(r1, r52)
                                                                r57 = {
                                                                    r51()
                                                                }
                                                                ReturnVal = state(unpack(r57))
                                                                r57 = allocUpvalue()
                                                                upvalueValues[r57] = ReturnVal
                                                                r51 = upvalueValues[r31]
                                                                r52 = r51
                                                                r51 = 1
                                                                r1 = r51
                                                                r51 = 0
                                                                r29 = r1 < r51
                                                                ReturnVal = 1
                                                                r51 = ReturnVal - r1
                                                                state = 8
                                                            end
                                                        end
                                                    else
                                                        if state == 7 then
                                                            r31 = "unpack"
                                                            r32 = _env[r31]
                                                            ReturnVal = r32
                                                            state = 6
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 10 then
                                                    if state <= 9 then
                                                        if state <= 8 then
                                                            if state == 8 then
                                                                r51 = r51 + r1
                                                                ReturnVal = r51 <= r52
                                                                r53 = not r29
                                                                ReturnVal = r53 and ReturnVal
                                                                r53 = r51 >= r52
                                                                r53 = r29 and r53
                                                                ReturnVal = r53 or ReturnVal
                                                                r53 = (9)
                                                                state = ReturnVal and r53
                                                                ReturnVal = (10)
                                                                state = state or ReturnVal
                                                            end
                                                        else
                                                            if state == 9 then
                                                                r53 = allocUpvalue()
                                                                upvalueValues[r53] = r51
                                                                r23 = "math"
                                                                ReturnVal = _env[r23]
                                                                r23 = "random"
                                                                state = ReturnVal[r23]
                                                                r56 = 100
                                                                r23 = 1
                                                                ReturnVal = state(r23, r56)
                                                                r23 = allocUpvalue()
                                                                upvalueValues[r23] = ReturnVal
                                                                state = upvalueValues[r18]
                                                                r48 = 255
                                                                r56 = 0
                                                                ReturnVal = state(r56, r48)
                                                                r56 = allocUpvalue()
                                                                upvalueValues[r56] = ReturnVal
                                                                state = upvalueValues[r18]
                                                                r46 = upvalueValues[r23]
                                                                r48 = 1
                                                                ReturnVal = state(r48, r46)
                                                                r48 = allocUpvalue()
                                                                upvalueValues[r48] = ReturnVal
                                                                ReturnVal = upvalueValues[r18]
                                                                r3 = 1
                                                                r45 = 2
                                                                r46 = ReturnVal(r3, r45)
                                                                ReturnVal = 1
                                                                state = r46 == ReturnVal
                                                                r46 = allocUpvalue()
                                                                upvalueValues[r46] = state
                                                                r17 = "tostring"
                                                                r2 = _env[r17]
                                                                r22 = upvalueValues[r18]
                                                                r30 = 10000
                                                                r49 = 0
                                                                r24 = {
                                                                    r22(r49, r30)
                                                                }
                                                                r17 = r2(unpack(r24))
                                                                r2 = ":"
                                                                r7 = r17 .. r2
                                                                state = "gsub"
                                                                state = r40[state]
                                                                r45 = ":"
                                                                r3 = r45 .. r7
                                                                ReturnVal = ":(%d*):"
                                                                state = state(r40, ReturnVal, r3)
                                                                r3 = allocUpvalue()
                                                                r7 = createClosure0(53, {
                                                                    r18,
                                                                    r53,
                                                                    r31,
                                                                    r14,
                                                                    r25,
                                                                    r57,
                                                                    r46,
                                                                    r3,
                                                                    r23,
                                                                    r48,
                                                                    r56,
                                                                    r32
                                                                })
                                                                upvalueValues[r3] = state
                                                                r45 = "pcall"
                                                                ReturnVal = _env[r45]
                                                                r45 = {
                                                                    ReturnVal(r7)
                                                                }
                                                                state = {
                                                                    unpack(r45)
                                                                }
                                                                r45 = state
                                                                state = upvalueValues[r46]
                                                                state = state and (11) or (12)
                                                            end
                                                        end
                                                    else
                                                        if state == 10 then
                                                            r52 = upvalueValues[r25]
                                                            state = r52 and (13) or (14)
                                                            r51 = r52
                                                        end
                                                    end
                                                else
                                                    if state <= 12 then
                                                        if state <= 11 then
                                                            if state == 11 then
                                                                r7 = upvalueValues[r25]
                                                                state = r7 and (15) or (16)
                                                                ReturnVal = r7
                                                            end
                                                        else
                                                            if state == 12 then
                                                                r2 = upvalueValues[r25]
                                                                state = r2 and (17) or (18)
                                                                r7 = r2
                                                            end
                                                        end
                                                    else
                                                        if state == 13 then
                                                            r52 = r33 == r47
                                                            r51 = r52
                                                            state = 14
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 19 then
                                                if state <= 16 then
                                                    if state <= 15 then
                                                        if state <= 14 then
                                                            if state == 14 then
                                                                upvalueValues[r25] = r51
                                                                state = upvalueValues[r25]
                                                                state = state and (19) or (20)
                                                            end
                                                        else
                                                            if state == 15 then
                                                                r2 = state
                                                                r24 = 1
                                                                r22 = r45[r24]
                                                                r24 = false
                                                                r17 = r22 == r24
                                                                state = r17 and (21) or (22)
                                                                r7 = r17
                                                            end
                                                        end
                                                    else
                                                        if state == 16 then
                                                            upvalueValues[r25] = ReturnVal
                                                            state = 23
                                                        end
                                                    end
                                                else
                                                    if state <= 18 then
                                                        if state <= 17 then
                                                            if state == 17 then
                                                                r17 = 1
                                                                r2 = r45[r17]
                                                                r7 = r2
                                                                state = 18
                                                            end
                                                        else
                                                            if state == 18 then
                                                                upvalueValues[r25] = r7
                                                                r24 = upvalueValues[r48]
                                                                r49 = 1
                                                                r22 = r24 + r49
                                                                r17 = r45[r22]
                                                                r2 = r33 + r17
                                                                r17 = 256
                                                                state = r2 % r17
                                                                r33 = state
                                                                r22 = upvalueValues[r56]
                                                                r17 = r47 + r22
                                                                r22 = 256
                                                                r2 = r17 % r22
                                                                r47 = r2
                                                                state = 23
                                                            end
                                                        end
                                                    else
                                                        if state == 19 then
                                                            state = 24
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 22 then
                                                    if state <= 21 then
                                                        if state <= 20 then
                                                            if state == 20 then
                                                                state = true
                                                                state = 25
                                                            end
                                                        else
                                                            if state == 21 then
                                                                r24 = 2
                                                                r22 = r45[r24]
                                                                r24 = upvalueValues[r3]
                                                                r17 = r22 == r24
                                                                r7 = r17
                                                                state = 22
                                                            end
                                                        end
                                                    else
                                                        if state == 22 then
                                                            state = r2
                                                            ReturnVal = r7
                                                            state = 16
                                                        end
                                                    end
                                                else
                                                    if state <= 24 then
                                                        if state <= 23 then
                                                            if state == 23 then
                                                                r48 = releaseUpvalue(r48)
                                                                r46 = releaseUpvalue(r46)
                                                                r23 = releaseUpvalue(r23)
                                                                r53 = releaseUpvalue(r53)
                                                                r45 = nil
                                                                r56 = releaseUpvalue(r56)
                                                                r3 = releaseUpvalue(r3)
                                                                state = 8
                                                            end
                                                        else
                                                            if state == 24 then
                                                                r32 = releaseUpvalue(r32)
                                                                r31 = releaseUpvalue(r31)
                                                                r14 = releaseUpvalue(r14)
                                                                r25 = releaseUpvalue(r25)
                                                                r20 = releaseUpvalue(r20)
                                                                r41 = nil
                                                                r41 = {}
                                                                r31 = allocUpvalue()
                                                                r18 = releaseUpvalue(r18)
                                                                r20 = allocUpvalue()
                                                                r57 = releaseUpvalue(r57)
                                                                r37 = releaseUpvalue(r37)
                                                                r25 = nil
                                                                upvalueValues[r20] = r25
                                                                r25 = allocUpvalue()
                                                                r14 = nil
                                                                upvalueValues[r25] = r14
                                                                r50 = nil
                                                                r50 = "math"
                                                                r37 = _env[r50]
                                                                r50 = "floor"
                                                                r14 = r37[r50]
                                                                r37 = allocUpvalue()
                                                                upvalueValues[r37] = r14
                                                                r18 = "math"
                                                                r50 = _env[r18]
                                                                r18 = "random"
                                                                r14 = r50[r18]
                                                                r47 = nil
                                                                r47 = allocUpvalue()
                                                                r8 = nil
                                                                r8 = "table"
                                                                r18 = _env[r8]
                                                                r33 = nil
                                                                r33 = {}
                                                                r8 = "remove"
                                                                r50 = r18[r8]
                                                                r32 = "string"
                                                                r8 = _env[r32]
                                                                r32 = "char"
                                                                r18 = r8[r32]
                                                                r32 = allocUpvalue()
                                                                r8 = 0
                                                                upvalueValues[r32] = r8
                                                                r8 = 2
                                                                upvalueValues[r31] = r8
                                                                r8 = {}
                                                                upvalueValues[r47] = r33
                                                                r57 = 256
                                                                r29 = r57
                                                                r57 = 1
                                                                r53 = r57
                                                                r57 = 0
                                                                r23 = r53 < r57
                                                                r40 = nil
                                                                r40 = 1
                                                                r57 = r40 - r53
                                                                r33 = 0
                                                                state = 26
                                                            end
                                                        end
                                                    else
                                                        if state == 25 then
                                                            state = createClosure2(65, {
                                                                r20
                                                            })
                                                            r52 = {
                                                                state()
                                                            }
                                                            ReturnVal = {
                                                                unpack(r52)
                                                            }
                                                            state = nil
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 37 then
                                            if state <= 31 then
                                                if state <= 28 then
                                                    if state <= 27 then
                                                        if state <= 26 then
                                                            if state == 26 then
                                                                r57 = r57 + r53
                                                                r40 = r57 <= r29
                                                                r56 = not r23
                                                                r40 = r56 and r40
                                                                r56 = r57 >= r29
                                                                r56 = r23 and r56
                                                                r40 = r56 or r40
                                                                r56 = (27)
                                                                state = r40 and r56
                                                                r40 = (28)
                                                                state = state or r40
                                                            end
                                                        else
                                                            if state == 27 then
                                                                r40 = r57
                                                                r56 = r40
                                                                r41[r40] = r56
                                                                r40 = nil
                                                                state = 26
                                                            end
                                                        end
                                                    else
                                                        if state == 28 then
                                                            r57 = #r41
                                                            r29 = 0
                                                            r40 = r57 == r29
                                                            state = 29
                                                        end
                                                    end
                                                else
                                                    if state <= 30 then
                                                        if state <= 29 then
                                                            if state == 29 then
                                                                r57 = 1
                                                                r29 = #r41
                                                                r40 = r14(r57, r29)
                                                                r57 = r50(r41, r40)
                                                                r40 = nil
                                                                r29 = upvalueValues[r47]
                                                                r56 = 1
                                                                r23 = r57 - r56
                                                                r53 = r18(r23)
                                                                r29[r57] = r53
                                                                r57 = nil
                                                                state = 30
                                                            end
                                                        else
                                                            if state == 30 then
                                                                r57 = #r41
                                                                r29 = 0
                                                                r40 = r57 == r29
                                                                state = r40 and (31) or (29)
                                                            end
                                                        end
                                                    else
                                                        if state == 31 then
                                                            r40 = {}
                                                            r57 = allocUpvalue()
                                                            r53 = allocUpvalue()
                                                            upvalueValues[r57] = r40
                                                            r40 = allocUpvalue()
                                                            r29 = createClosure3(69, {
                                                                r57,
                                                                r32,
                                                                r31,
                                                                r37
                                                            })
                                                            r37 = releaseUpvalue(r37)
                                                            upvalueValues[r40] = r29
                                                            r29 = {}
                                                            r56 = {}
                                                            upvalueValues[r53] = r29
                                                            r23 = "setmetatable"
                                                            r29 = _env[r23]
                                                            r3 = upvalueValues[r53]
                                                            r17 = nil
                                                            r46 = "__index"
                                                            r45 = "__metatable"
                                                            r48 = {
                                                                [r46] = r3,
                                                                [r45] = r17
                                                            }
                                                            r23 = r29(r56, r48)
                                                            upvalueValues[r20] = r23
                                                            r29 = createClosure2(75, {
                                                                r53,
                                                                r57,
                                                                r47,
                                                                r32,
                                                                r31,
                                                                r40
                                                            })
                                                            r53 = releaseUpvalue(r53)
                                                            r40 = releaseUpvalue(r40)
                                                            r47 = releaseUpvalue(r47)
                                                            r32 = releaseUpvalue(r32)
                                                            upvalueValues[r25] = r29
                                                            r31 = releaseUpvalue(r31)
                                                            r37 = upvalueValues[r20]
                                                            r57 = releaseUpvalue(r57)
                                                            r50 = nil
                                                            r50 = upvalueValues[r25]
                                                            r32 = 26812142710981
                                                            r8 = nil
                                                            r8 = "\211\151\207\228"
                                                            r18 = nil
                                                            r18 = r50(r8, r32)
                                                            r14 = nil
                                                            r14 = r37[r18]
                                                            r37 = allocUpvalue()
                                                            upvalueValues[r37] = r14
                                                            r50 = upvalueValues[r20]
                                                            r18 = upvalueValues[r25]
                                                            r31 = 4255417878461
                                                            r32 = "\133\189\244m\229\212\145\003\008`\155\"\234\210\143Lhu\031{\215\149\138wRN\247\139\001b\233U\161\003\130\241"
                                                            r8 = r18(r32, r31)
                                                            r14 = r50[r8]
                                                            r50 = allocUpvalue()
                                                            r18 = allocUpvalue()
                                                            upvalueValues[r50] = r14
                                                            r14 = true
                                                            upvalueValues[r18] = r14
                                                            r14 = createClosure5(82, {
                                                                r20,
                                                                r25
                                                            })
                                                            r8 = r14()
                                                            r14 = allocUpvalue()
                                                            upvalueValues[r14] = r8
                                                            r32 = "game"
                                                            r8 = _env[r32]
                                                            r33 = nil
                                                            r33 = upvalueValues[r20]
                                                            r47 = upvalueValues[r25]
                                                            r40 = "'A\179\138\192\249;\201fD\128"
                                                            r57 = 28399910171560
                                                            r41 = nil
                                                            r41 = r47(r40, r57)
                                                            r32 = "GetService"
                                                            r32 = r8[r32]
                                                            r31 = r33[r41]
                                                            r32 = r32(r8, r31)
                                                            r8 = allocUpvalue()
                                                            upvalueValues[r8] = r32
                                                            r33 = "game"
                                                            r31 = _env[r33]
                                                            r41 = upvalueValues[r20]
                                                            r40 = upvalueValues[r25]
                                                            r53 = 16283895651742
                                                            r29 = "\248\139t\135\213\020\206"
                                                            r57 = r40(r29, r53)
                                                            r47 = r41[r57]
                                                            r33 = "GetService"
                                                            r33 = r31[r33]
                                                            r33 = r33(r31, r47)
                                                            r47 = upvalueValues[r20]
                                                            r41 = upvalueValues[r25]
                                                            r29 = 14585178282631
                                                            r57 = "qN\137\172\129\211\238\006|\147\t"
                                                            r40 = r41(r57, r29)
                                                            r31 = r47[r40]
                                                            r32 = r33[r31]
                                                            r31 = allocUpvalue()
                                                            r33 = allocUpvalue()
                                                            upvalueValues[r31] = r32
                                                            r32 = false
                                                            upvalueValues[r33] = r32
                                                            r40 = "setclipboard"
                                                            r41 = _env[r40]
                                                            r47 = state
                                                            state = r41 and (32) or (33)
                                                            r32 = r41
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 34 then
                                                    if state <= 33 then
                                                        if state <= 32 then
                                                            if state == 32 then
                                                                state = r47
                                                                r41 = state
                                                                r47 = allocUpvalue()
                                                                upvalueValues[r47] = r32
                                                                r57 = "request"
                                                                r40 = _env[r57]
                                                                state = r40 and (34) or (35)
                                                                r32 = r40
                                                            end
                                                        else
                                                            if state == 33 then
                                                                r40 = "toclipboard"
                                                                r41 = _env[r40]
                                                                r32 = r41
                                                                state = 32
                                                            end
                                                        end
                                                    else
                                                        if state == 34 then
                                                            state = r41
                                                            r41 = allocUpvalue()
                                                            upvalueValues[r41] = r32
                                                            r57 = "string"
                                                            r40 = _env[r57]
                                                            r29 = upvalueValues[r20]
                                                            r53 = upvalueValues[r25]
                                                            r48 = "\"\146V\254"
                                                            r46 = 24524538326172
                                                            r56 = r53(r48, r46)
                                                            r57 = r29[r56]
                                                            r32 = r40[r57]
                                                            r40 = allocUpvalue()
                                                            upvalueValues[r40] = r32
                                                            r57 = "tostring"
                                                            r32 = _env[r57]
                                                            r57 = allocUpvalue()
                                                            upvalueValues[r57] = r32
                                                            r53 = "string"
                                                            r29 = _env[r53]
                                                            r56 = upvalueValues[r20]
                                                            r48 = upvalueValues[r25]
                                                            r3 = "\161&\021"
                                                            r45 = 28017255265014
                                                            r46 = r48(r3, r45)
                                                            r53 = r56[r46]
                                                            r32 = r29[r53]
                                                            r29 = allocUpvalue()
                                                            upvalueValues[r29] = r32
                                                            r56 = "os"
                                                            r53 = _env[r56]
                                                            r48 = upvalueValues[r20]
                                                            r46 = upvalueValues[r25]
                                                            r17 = 6212948904781
                                                            r45 = "\137Z\027\253"
                                                            r3 = r46(r45, r17)
                                                            r56 = r48[r3]
                                                            r32 = r53[r56]
                                                            r53 = allocUpvalue()
                                                            upvalueValues[r53] = r32
                                                            r48 = "math"
                                                            r56 = _env[r48]
                                                            r46 = upvalueValues[r20]
                                                            r3 = upvalueValues[r25]
                                                            r22 = 28779956204633
                                                            r17 = "\2210\235\005\137\170"
                                                            r45 = r3(r17, r22)
                                                            r48 = r46[r45]
                                                            r32 = r56[r48]
                                                            r56 = allocUpvalue()
                                                            upvalueValues[r56] = r32
                                                            r46 = "math"
                                                            r48 = _env[r46]
                                                            r3 = upvalueValues[r20]
                                                            r45 = upvalueValues[r25]
                                                            r24 = 11562721613064
                                                            r22 = "\143@tv\164"
                                                            r17 = r45(r22, r24)
                                                            r46 = r3[r17]
                                                            r32 = r48[r46]
                                                            r48 = allocUpvalue()
                                                            upvalueValues[r48] = r32
                                                            r46 = state
                                                            r45 = "gethwid"
                                                            r3 = _env[r45]
                                                            state = r3 and (36) or (37)
                                                            r32 = r3
                                                        end
                                                    end
                                                else
                                                    if state <= 36 then
                                                        if state <= 35 then
                                                            if state == 35 then
                                                                r57 = "http_request"
                                                                r40 = _env[r57]
                                                                r32 = r40
                                                                state = 34
                                                            end
                                                        else
                                                            if state == 36 then
                                                                state = r46
                                                                r46 = allocUpvalue()
                                                                r45 = createClosure2(97, {
                                                                    r8
                                                                })
                                                                r3 = createClosure2(98, {
                                                                    r20,
                                                                    r25
                                                                })
                                                                upvalueValues[r46] = r32
                                                                r32 = allocUpvalue()
                                                                upvalueValues[r32] = r3
                                                                r3 = allocUpvalue()
                                                                upvalueValues[r3] = r45
                                                                r45 = allocUpvalue()
                                                                r17 = createClosure4(99, {
                                                                    r8
                                                                })
                                                                upvalueValues[r45] = r17
                                                                r22 = upvalueValues[r20]
                                                                r24 = upvalueValues[r25]
                                                                r16 = 21038735189572
                                                                r30 = "\143f\149\255\200\2410\251:\159\185\195\1486\148\148\004\195\0032\027\031U\212\017\242"
                                                                r49 = r24(r30, r16)
                                                                r17 = r22[r49]
                                                                r22 = upvalueValues[r41]
                                                                r16 = upvalueValues[r20]
                                                                r44 = upvalueValues[r25]
                                                                r6 = "ar\229"
                                                                r13 = 1983369577371
                                                                r26 = r44(r6, r13)
                                                                r30 = r16[r26]
                                                                r26 = upvalueValues[r20]
                                                                r6 = upvalueValues[r25]
                                                                r34 = 24273261571111
                                                                r21 = "\020&\169d\023*\005>\170\219\251%Y<\022[\224\137\240v"
                                                                r13 = r6(r21, r34)
                                                                r44 = r26[r13]
                                                                r16 = r17 .. r44
                                                                r26 = upvalueValues[r20]
                                                                r6 = upvalueValues[r25]
                                                                r21 = "&y\254a\128n"
                                                                r34 = 32168595618435
                                                                r13 = r6(r21, r34)
                                                                r44 = r26[r13]
                                                                r6 = upvalueValues[r20]
                                                                r13 = upvalueValues[r25]
                                                                r27 = 8011213901458
                                                                r34 = "\142k]"
                                                                r21 = r13(r34, r27)
                                                                r26 = r6[r21]
                                                                r49 = {
                                                                    [r30] = r16,
                                                                    [r44] = r26
                                                                }
                                                                r24 = r22(r49)
                                                                r13 = upvalueValues[r20]
                                                                r21 = upvalueValues[r25]
                                                                r39 = 10608065434443
                                                                r27 = "\165\221\167\145\141\148\223d)\018"
                                                                r34 = r21(r27, r39)
                                                                r6 = r13[r34]
                                                                r26 = r24[r6]
                                                                r6 = 200
                                                                r44 = r26 ~= r6
                                                                r49 = state
                                                                r16 = state
                                                                state = r44 and (38) or (39)
                                                                r30 = r44
                                                            end
                                                        end
                                                    else
                                                        if state == 37 then
                                                            r3 = createClosure1(100, {
                                                                r31,
                                                                r20,
                                                                r25
                                                            })
                                                            r32 = r3
                                                            state = 36
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 43 then
                                                if state <= 40 then
                                                    if state <= 39 then
                                                        if state <= 38 then
                                                            if state == 38 then
                                                                r26 = state
                                                                r34 = upvalueValues[r20]
                                                                r27 = upvalueValues[r25]
                                                                r5 = "\001\179\216\237\170+\020/\156\203"
                                                                r42 = 34969295962011
                                                                r39 = r27(r5, r42)
                                                                r21 = r34[r39]
                                                                r13 = r24[r21]
                                                                r21 = 429
                                                                r6 = r13 ~= r21
                                                                state = r6 and (40) or (41)
                                                                r44 = r6
                                                            end
                                                        else
                                                            if state == 39 then
                                                                state = r16
                                                                state = r30 and (42) or (43)
                                                                r22 = r30
                                                            end
                                                        end
                                                    else
                                                        if state == 40 then
                                                            r13 = upvalueValues[r20]
                                                            r21 = upvalueValues[r25]
                                                            r39 = 29338017789277
                                                            r27 = "\029\146\154k\129T\003m\003\029\230\021\181\011S\229{\202\0007\185\230q\017\167\r"
                                                            r34 = r21(r27, r39)
                                                            r6 = r13[r34]
                                                            r44 = r6
                                                            state = 41
                                                        end
                                                    end
                                                else
                                                    if state <= 42 then
                                                        if state <= 41 then
                                                            if state == 41 then
                                                                state = r26
                                                                r30 = r44
                                                                state = 39
                                                            end
                                                        else
                                                            if state == 42 then
                                                                state = r49
                                                                r49 = allocUpvalue()
                                                                upvalueValues[r49] = r22
                                                                r30 = upvalueValues[r20]
                                                                r16 = upvalueValues[r25]
                                                                r6 = 7456305991056
                                                                r26 = ""
                                                                r44 = r16(r26, r6)
                                                                r22 = r30[r44]
                                                                r30 = allocUpvalue()
                                                                r16 = allocUpvalue()
                                                                upvalueValues[r30] = r22
                                                                r26 = createClosure1(101, {
                                                                    r20,
                                                                    r25,
                                                                    r40,
                                                                    r48,
                                                                    r56
                                                                })
                                                                r44 = createClosure2(105, {
                                                                    r16,
                                                                    r53,
                                                                    r30,
                                                                    r41,
                                                                    r20,
                                                                    r25,
                                                                    r49,
                                                                    r3,
                                                                    r37,
                                                                    r46,
                                                                    r32,
                                                                    r45
                                                                })
                                                                r22 = 0
                                                                upvalueValues[r16] = r22
                                                                r22 = allocUpvalue()
                                                                r6 = createClosure2(116, {
                                                                    r22,
                                                                    r47,
                                                                    r32,
                                                                    r20,
                                                                    r25
                                                                })
                                                                upvalueValues[r22] = r44
                                                                r44 = allocUpvalue()
                                                                upvalueValues[r44] = r26
                                                                r13 = createClosure3(119, {
                                                                    r44,
                                                                    r49,
                                                                    r20,
                                                                    r25,
                                                                    r57,
                                                                    r37,
                                                                    r46,
                                                                    r18,
                                                                    r41,
                                                                    r3,
                                                                    r32,
                                                                    r45,
                                                                    r50
                                                                })
                                                                r26 = allocUpvalue()
                                                                upvalueValues[r26] = r6
                                                                r6 = allocUpvalue()
                                                                upvalueValues[r6] = r13
                                                                r13 = allocUpvalue()
                                                                r21 = createClosure5(134, {
                                                                    r33,
                                                                    r32,
                                                                    r20,
                                                                    r25,
                                                                    r44,
                                                                    r49,
                                                                    r57,
                                                                    r37,
                                                                    r46,
                                                                    r18,
                                                                    r41,
                                                                    r45,
                                                                    r29,
                                                                    r6
                                                                })
                                                                upvalueValues[r13] = r21
                                                                r34 = "loadstring"
                                                                r21 = _env[r34]
                                                                r27 = upvalueValues[r14]
                                                                r42 = upvalueValues[r20]
                                                                r10 = upvalueValues[r25]
                                                                r12 = 18436068123016
                                                                r19 = "\239\192\1503;\175\140x&T\167\239A\170\186\002\204!\138\188\143\213\168X\230\211\005\145"
                                                                r36 = r10(r19, r12)
                                                                r5 = r42[r36]
                                                                r39 = {
                                                                    r27(r5)
                                                                }
                                                                r34 = r21(unpack(r39))
                                                                r21 = r34()
                                                                r34 = allocUpvalue()
                                                                upvalueValues[r34] = r21
                                                                r21 = upvalueValues[r34]
                                                                r39 = upvalueValues[r34]
                                                                r42 = upvalueValues[r20]
                                                                r10 = upvalueValues[r25]
                                                                r19 = "\156\249l!\244\247\t\158K\172U%"
                                                                r12 = 32747482348433
                                                                r36 = r10(r19, r12)
                                                                r5 = r42[r36]
                                                                r27 = r39[r5]
                                                                r10 = upvalueValues[r20]
                                                                r36 = upvalueValues[r25]
                                                                r38 = 10525151466277
                                                                r12 = "7\152o\214"
                                                                r19 = r36(r12, r38)
                                                                r42 = r10[r19]
                                                                r36 = upvalueValues[r20]
                                                                r19 = upvalueValues[r25]
                                                                r9 = 19317192467235
                                                                r38 = "\129\229\196V\213@v\231\183P"
                                                                r12 = r19(r38, r9)
                                                                r10 = r36[r12]
                                                                r19 = upvalueValues[r20]
                                                                r12 = upvalueValues[r25]
                                                                r15 = 32534093642541
                                                                r9 = "(L4\002\170I\181yu?\180\149"
                                                                r38 = r12(r9, r15)
                                                                r36 = r19[r38]
                                                                r12 = upvalueValues[r20]
                                                                r38 = upvalueValues[r25]
                                                                r55 = 25123379998130
                                                                r15 = "\012B4\211\196\232\202A\175\136"
                                                                r9 = r38(r15, r55)
                                                                r19 = r12[r9]
                                                                r38 = upvalueValues[r20]
                                                                r9 = upvalueValues[r25]
                                                                r28 = 17792291496029
                                                                r55 = "W\171i\255\179\132\218\226\249\240\216\160`\134\183"
                                                                r15 = r9(r55, r28)
                                                                r12 = r38[r15]
                                                                r9 = upvalueValues[r20]
                                                                r15 = upvalueValues[r25]
                                                                r54 = 26902337302767
                                                                r28 = "\206\140\212\2484\253\022\025\145\r.'\025\184\t)\233\177\191\031Q\028\026F8[C\150\139=\248"
                                                                r55 = r15(r28, r54)
                                                                r38 = r9[r55]
                                                                r15 = upvalueValues[r20]
                                                                r55 = upvalueValues[r25]
                                                                r43 = 25021219761539
                                                                r54 = "#4aU\217{\217\024\185\181C;\164\178\218\241c\167\192"
                                                                r28 = r55(r54, r43)
                                                                r9 = r15[r28]
                                                                r28 = upvalueValues[r20]
                                                                r54 = upvalueValues[r25]
                                                                r35 = 7076903308511
                                                                r4 = ">\163y\225\150\152\217"
                                                                r43 = r54(r4, r35)
                                                                r55 = r28[r43]
                                                                r28 = false
                                                                r15 = {
                                                                    [r55] = r28
                                                                }
                                                                r5 = {
                                                                    [r42] = r10,
                                                                    [r36] = r19,
                                                                    [r12] = r38,
                                                                    [r9] = r15
                                                                }
                                                                r39 = r27(r21, r5)
                                                                r42 = upvalueValues[r20]
                                                                r10 = upvalueValues[r25]
                                                                r19 = "\130x\241k\n\221B\128\003@"
                                                                r12 = 32136108964468
                                                                r36 = r10(r19, r12)
                                                                r5 = r42[r36]
                                                                r27 = "CreateTab"
                                                                r27 = r39[r27]
                                                                r27 = r27(r39, r5)
                                                                r5 = upvalueValues[r20]
                                                                r42 = upvalueValues[r25]
                                                                r19 = 24803849039134
                                                                r36 = ""
                                                                r10 = r42(r36, r19)
                                                                r39 = r5[r10]
                                                                r5 = allocUpvalue()
                                                                upvalueValues[r5] = r39
                                                                r36 = upvalueValues[r20]
                                                                r19 = upvalueValues[r25]
                                                                r9 = 11695566198086
                                                                r38 = "J\230\016\""
                                                                r12 = r19(r38, r9)
                                                                r10 = r36[r12]
                                                                r19 = upvalueValues[r20]
                                                                r12 = upvalueValues[r25]
                                                                r15 = 5883919682227
                                                                r9 = "t\0021Xr\157\196\n\140OP2\254\156"
                                                                r38 = r12(r9, r15)
                                                                r36 = r19[r38]
                                                                r12 = upvalueValues[r20]
                                                                r38 = upvalueValues[r25]
                                                                r55 = 30684216735696
                                                                r15 = "#\192\141\223\198\244\128\1876*\218\022\149v\017"
                                                                r9 = r38(r15, r55)
                                                                r19 = r12[r9]
                                                                r38 = upvalueValues[r20]
                                                                r9 = upvalueValues[r25]
                                                                r28 = 25243864296939
                                                                r55 = "<9\215\145\214\181\0215\149\238D\246\252\238a:z@\000\237~\127"
                                                                r15 = r9(r55, r28)
                                                                r12 = r38[r15]
                                                                r9 = upvalueValues[r20]
                                                                r39 = "CreateInput"
                                                                r39 = r27[r39]
                                                                r15 = upvalueValues[r25]
                                                                r54 = 30077235295925
                                                                r28 = "G`\240\214\178\174\128'\161\245\253l'U\008\201+\187HSN\177:\158"
                                                                r55 = r15(r28, r54)
                                                                r38 = r9[r55]
                                                                r55 = upvalueValues[r20]
                                                                r28 = upvalueValues[r25]
                                                                r43 = "\177\008\151\217\226\031<\187"
                                                                r4 = 14570275723904
                                                                r54 = r28(r43, r4)
                                                                r15 = r55[r54]
                                                                r55 = createClosure1(149, {
                                                                    r5
                                                                })
                                                                r9 = false
                                                                r42 = {
                                                                    [r10] = r36,
                                                                    [r19] = r12,
                                                                    [r38] = r9,
                                                                    [r15] = r55
                                                                }
                                                                r39 = r39(r27, r42)
                                                                r36 = upvalueValues[r20]
                                                                r19 = upvalueValues[r25]
                                                                r38 = "\222\180=\170"
                                                                r9 = 26135065227146
                                                                r12 = r19(r38, r9)
                                                                r10 = r36[r12]
                                                                r19 = upvalueValues[r20]
                                                                r12 = upvalueValues[r25]
                                                                r15 = 7372599430505
                                                                r9 = "\152\212bD\2040\213"
                                                                r38 = r12(r9, r15)
                                                                r36 = r19[r38]
                                                                r12 = upvalueValues[r20]
                                                                r38 = upvalueValues[r25]
                                                                r55 = 13178930272248
                                                                r15 = "R\029\188\226&\255\201\191"
                                                                r9 = r38(r15, r55)
                                                                r39 = "CreateButton"
                                                                r39 = r27[r39]
                                                                r19 = r12[r9]
                                                                r12 = createClosure4(150, {
                                                                    r26,
                                                                    r34,
                                                                    r20,
                                                                    r25
                                                                })
                                                                r42 = {
                                                                    [r10] = r36,
                                                                    [r19] = r12
                                                                }
                                                                r39 = r39(r27, r42)
                                                                r36 = upvalueValues[r20]
                                                                r19 = upvalueValues[r25]
                                                                r38 = "\025\137\025\171"
                                                                r9 = 32438759865089
                                                                r12 = r19(r38, r9)
                                                                r10 = r36[r12]
                                                                r19 = upvalueValues[r20]
                                                                r12 = upvalueValues[r25]
                                                                r15 = 34651718565639
                                                                r9 = "\237\202@\005Q\134\140\003\227\139"
                                                                r38 = r12(r9, r15)
                                                                r36 = r19[r38]
                                                                r12 = upvalueValues[r20]
                                                                r39 = "CreateButton"
                                                                r39 = r27[r39]
                                                                r38 = upvalueValues[r25]
                                                                r55 = 4617836841062
                                                                r15 = "\141\1604W\155\024!\149"
                                                                r9 = r38(r15, r55)
                                                                r19 = r12[r9]
                                                                r12 = createClosure4(151, {
                                                                    r5,
                                                                    r20,
                                                                    r25,
                                                                    r13,
                                                                    r34,
                                                                    r14
                                                                })
                                                                r42 = {
                                                                    [r10] = r36,
                                                                    [r19] = r12
                                                                }
                                                                r39 = r39(r27, r42)
                                                                r42 = upvalueValues[r20]
                                                                r10 = upvalueValues[r25]
                                                                r12 = 13779520411920
                                                                r19 = "\209\216\152\131q\227\233x\203\004H"
                                                                r36 = r10(r19, r12)
                                                                r39 = r42[r36]
                                                                r10 = "isfile"
                                                                r42 = _env[r10]
                                                                r10 = r42(r39)
                                                                state = r10 and (44) or (45)
                                                            end
                                                        end
                                                    else
                                                        if state == 43 then
                                                            r22 = r17
                                                            state = 42
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 46 then
                                                    if state <= 45 then
                                                        if state <= 44 then
                                                            if state == 44 then
                                                                r10 = "readfile"
                                                                r42 = _env[r10]
                                                                r10 = r42(r39)
                                                                r42 = allocUpvalue()
                                                                upvalueValues[r42] = r10
                                                                r19 = upvalueValues[r42]
                                                                r36 = state
                                                                state = r19 and (46) or (47)
                                                                r10 = r19
                                                            end
                                                        else
                                                            if state == 45 then
                                                                r50 = releaseUpvalue(r50)
                                                                r17 = nil
                                                                r5 = releaseUpvalue(r5)
                                                                r8 = releaseUpvalue(r8)
                                                                r39 = nil
                                                                r14 = releaseUpvalue(r14)
                                                                r48 = releaseUpvalue(r48)
                                                                r27 = nil
                                                                r13 = releaseUpvalue(r13)
                                                                ReturnVal = {}
                                                                r31 = releaseUpvalue(r31)
                                                                r53 = releaseUpvalue(r53)
                                                                r26 = releaseUpvalue(r26)
                                                                r56 = releaseUpvalue(r56)
                                                                r20 = releaseUpvalue(r20)
                                                                r32 = releaseUpvalue(r32)
                                                                r45 = releaseUpvalue(r45)
                                                                r46 = releaseUpvalue(r46)
                                                                r33 = releaseUpvalue(r33)
                                                                r22 = releaseUpvalue(r22)
                                                                r41 = releaseUpvalue(r41)
                                                                r25 = releaseUpvalue(r25)
                                                                r44 = releaseUpvalue(r44)
                                                                r30 = releaseUpvalue(r30)
                                                                r21 = nil
                                                                r29 = releaseUpvalue(r29)
                                                                r3 = releaseUpvalue(r3)
                                                                r18 = releaseUpvalue(r18)
                                                                r57 = releaseUpvalue(r57)
                                                                r49 = releaseUpvalue(r49)
                                                                r24 = nil
                                                                r47 = releaseUpvalue(r47)
                                                                r34 = releaseUpvalue(r34)
                                                                r16 = releaseUpvalue(r16)
                                                                r40 = releaseUpvalue(r40)
                                                                r37 = releaseUpvalue(r37)
                                                                r6 = releaseUpvalue(r6)
                                                                state = nil
                                                            end
                                                        end
                                                    else
                                                        if state == 46 then
                                                            r12 = upvalueValues[r42]
                                                            r9 = upvalueValues[r20]
                                                            r15 = upvalueValues[r25]
                                                            r54 = 24761671675146
                                                            r28 = ""
                                                            r55 = r15(r28, r54)
                                                            r38 = r9[r55]
                                                            r19 = r12 ~= r38
                                                            r10 = r19
                                                            state = 47
                                                        end
                                                    end
                                                else
                                                    if state <= 48 then
                                                        if state <= 47 then
                                                            if state == 47 then
                                                                state = r36
                                                                state = r10 and (48) or (49)
                                                            end
                                                        else
                                                            if state == 48 then
                                                                r10 = upvalueValues[r42]
                                                                upvalueValues[r5] = r10
                                                                r12 = "task"
                                                                r19 = _env[r12]
                                                                r38 = upvalueValues[r20]
                                                                r9 = upvalueValues[r25]
                                                                r28 = 27701850403427
                                                                r55 = ")\247\014\023\029"
                                                                r15 = r9(r55, r28)
                                                                r12 = r38[r15]
                                                                r36 = r19[r12]
                                                                r12 = createClosure0(158, {
                                                                    r13,
                                                                    r42,
                                                                    r34,
                                                                    r20,
                                                                    r25,
                                                                    r14
                                                                })
                                                                r19 = r36(r12)
                                                                state = 49
                                                            end
                                                        end
                                                    else
                                                        if state == 49 then
                                                            r42 = releaseUpvalue(r42)
                                                            state = 45
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure0 entry 15350492 -> 50, states 50-50
                                    if state == 50 then -- entry 15350492 -> 50
                                        ReturnVal = "error"
                                        state = _env[ReturnVal]
                                        r11 = "Tamper Detected!"
                                        ReturnVal = state(r11)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                if state <= 51 then
                                    -- createClosure3 entry 15239126 -> 51, states 51-51
                                    if state == 51 then -- entry 15239126 -> 51
                                        state = true
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure5 entry 12779124 -> 52, states 52-52
                                    if state == 52 then -- entry 12779124 -> 52
                                        r14 = 16172910
                                        r25 = "0EyD2qs"
                                        r11 = r25 ^ r14
                                        ReturnVal = 12897979
                                        state = ReturnVal - r11
                                        r11 = state
                                        ReturnVal = "57dRx"
                                        state = ReturnVal / r11
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 68 then
                                if state <= 64 then
                                    -- createClosure0 entry 12230439 -> 53, states 53-64
                                    if state <= 58 then
                                        if state <= 55 then
                                            if state <= 54 then
                                                if state <= 53 then
                                                    if state == 53 then -- entry 12230439 -> 53
                                                        r25 = upvalueValues[upvalues[1]]
                                                        r20 = 1
                                                        r37 = 2
                                                        r14 = r25(r20, r37)
                                                        r25 = 1
                                                        r11 = r14 == r25
                                                        state = r11 and (54) or (55)
                                                        ReturnVal = r11
                                                    end
                                                else
                                                    if state == 54 then
                                                        state = ReturnVal and (56) or (57)
                                                    end
                                                end
                                            else
                                                if state == 55 then
                                                    r25 = upvalueValues[upvalues[2]]
                                                    r14 = upvalueValues[upvalues[3]]
                                                    r11 = r25 == r14
                                                    ReturnVal = r11
                                                    state = 54
                                                end
                                            end
                                        else
                                            if state <= 57 then
                                                if state <= 56 then
                                                    if state == 56 then
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r32 = createClosure1(162, {})
                                                        r11 = upvalueValues[upvalues[4]]
                                                        r20 = "tostring"
                                                        r14 = _env[r20]
                                                        r8 = "pcall"
                                                        r18 = _env[r8]
                                                        r8 = {
                                                            r18(r32)
                                                        }
                                                        r50 = {
                                                            unpack(r8)
                                                        }
                                                        r18 = 2
                                                        r37 = r50[r18]
                                                        r20 = r14(r37)
                                                        r14 = ":(%d*):"
                                                        r25 = r11(r20, r14)
                                                        r11 = {
                                                            r25()
                                                        }
                                                        ReturnVal = state(unpack(r11))
                                                        r11 = ReturnVal
                                                        r25 = upvalueValues[upvalues[5]]
                                                        state = r25 and (58) or (59)
                                                        ReturnVal = r25
                                                    end
                                                else
                                                    if state == 57 then
                                                        state = upvalueValues[upvalues[7]]
                                                        state = state and (60) or (61)
                                                    end
                                                end
                                            else
                                                if state == 58 then
                                                    r14 = upvalueValues[upvalues[6]]
                                                    r25 = r14 == r11
                                                    ReturnVal = r25
                                                    state = 59
                                                end
                                            end
                                        end
                                    else
                                        if state <= 61 then
                                            if state <= 60 then
                                                if state <= 59 then
                                                    if state == 59 then
                                                        upvalueValues[upvalues[5]] = ReturnVal
                                                        r11 = nil
                                                        state = 57
                                                    end
                                                else
                                                    if state == 60 then
                                                        r11 = "error"
                                                        state = _env[r11]
                                                        r25 = upvalueValues[upvalues[8]]
                                                        r14 = 0
                                                        r11 = state(r25, r14)
                                                        state = 61
                                                    end
                                                end
                                            else
                                                if state == 61 then
                                                    state = {}
                                                    r11 = state
                                                    r14 = upvalueValues[upvalues[9]]
                                                    r20 = r14
                                                    r14 = 1
                                                    r37 = r14
                                                    r14 = 0
                                                    r50 = r37 < r14
                                                    r25 = 1
                                                    r14 = r25 - r37
                                                    state = 62
                                                end
                                            end
                                        else
                                            if state <= 63 then
                                                if state <= 62 then
                                                    if state == 62 then
                                                        r18 = not r50
                                                        r14 = r14 + r37
                                                        r25 = r14 <= r20
                                                        r25 = r18 and r25
                                                        r18 = r14 >= r20
                                                        r18 = r50 and r18
                                                        r25 = r18 or r25
                                                        r18 = (63)
                                                        state = r25 and r18
                                                        r25 = (64)
                                                        state = state or r25
                                                    end
                                                else
                                                    if state == 63 then
                                                        state = upvalueValues[upvalues[1]]
                                                        r8 = 0
                                                        r32 = 255
                                                        r18 = state(r8, r32)
                                                        r25 = r14
                                                        r11[r25] = r18
                                                        r25 = nil
                                                        state = 62
                                                    end
                                                end
                                            else
                                                if state == 64 then
                                                    state = upvalueValues[upvalues[10]]
                                                    r25 = upvalueValues[upvalues[11]]
                                                    r11[state] = r25
                                                    state = upvalueValues[upvalues[12]]
                                                    r25 = {
                                                        state(r11)
                                                    }
                                                    ReturnVal = {
                                                        unpack(r25)
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure2 entry 6518604 -> 65, states 65-68
                                    if state <= 66 then
                                        if state <= 65 then
                                            if state == 65 then -- entry 6518604 -> 65
                                                state = 66
                                            end
                                        else
                                            if state == 66 then
                                                state = true
                                                state = state and (67) or (68)
                                            end
                                        end
                                    else
                                        if state <= 67 then
                                            if state == 67 then
                                                ReturnVal = "l2"
                                                state = _env[ReturnVal]
                                                r11 = "l1"
                                                ReturnVal = _env[r11]
                                                r11 = "l1"
                                                _env[r11] = state
                                                r11 = "l2"
                                                _env[r11] = ReturnVal
                                                r11 = upvalueValues[upvalues[1]]
                                                r25 = r11()
                                                state = 66
                                            end
                                        else
                                            if state == 68 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 74 then
                                    -- createClosure3 entry 16757928 -> 69, states 69-74
                                    if state <= 71 then
                                        if state <= 70 then
                                            if state <= 69 then
                                                if state == 69 then -- entry 16757928 -> 69
                                                    r11 = upvalueValues[upvalues[1]]
                                                    ReturnVal = #r11
                                                    r11 = 0
                                                    state = ReturnVal == r11
                                                    state = state and (70) or (71)
                                                end
                                            else
                                                if state == 70 then
                                                    r25 = upvalueValues[upvalues[2]]
                                                    r14 = 197
                                                    r11 = r25 * r14
                                                    r25 = 31309000243441
                                                    ReturnVal = r11 + r25
                                                    r11 = 35184372088832
                                                    state = ReturnVal % r11
                                                    upvalueValues[upvalues[2]] = state
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r25 = 1
                                                    ReturnVal = r11 ~= r25
                                                    state = 72
                                                end
                                            end
                                        else
                                            if state == 71 then
                                                r14 = "table"
                                                r25 = _env[r14]
                                                r14 = "remove"
                                                r11 = r25[r14]
                                                r14 = upvalueValues[upvalues[1]]
                                                r25 = {
                                                    r11(r14)
                                                }
                                                ReturnVal = {
                                                    unpack(r25)
                                                }
                                                state = nil
                                            end
                                        end
                                    else
                                        if state <= 73 then
                                            if state <= 72 then
                                                if state == 72 then
                                                    r25 = upvalueValues[upvalues[3]]
                                                    r14 = 71
                                                    r11 = r25 * r14
                                                    r25 = 257
                                                    ReturnVal = r11 % r25
                                                    upvalueValues[upvalues[3]] = ReturnVal
                                                    state = 73
                                                end
                                            else
                                                if state == 73 then
                                                    r25 = upvalueValues[upvalues[3]]
                                                    r14 = 1
                                                    r11 = r25 ~= r14
                                                    state = r11 and (74) or (72)
                                                end
                                            end
                                        else
                                            if state == 74 then
                                                r25 = upvalueValues[upvalues[3]]
                                                r14 = 32
                                                r11 = r25 % r14
                                                r20 = upvalueValues[upvalues[4]]
                                                r32 = 2
                                                r18 = upvalueValues[upvalues[2]]
                                                r40 = upvalueValues[upvalues[3]]
                                                r41 = r40 - r11
                                                r40 = 32
                                                r47 = r41 / r40
                                                r33 = 13
                                                r31 = r33 - r47
                                                r8 = r32 ^ r31
                                                r50 = r18 / r8
                                                r37 = r20(r50)
                                                r20 = 4294967296
                                                r8 = 1
                                                r14 = r37 % r20
                                                r37 = 2
                                                r20 = r37 ^ r11
                                                r25 = r14 / r20
                                                r20 = upvalueValues[upvalues[4]]
                                                r18 = r25 % r8
                                                r8 = 4294967296
                                                r50 = r18 * r8
                                                r18 = 65536
                                                r37 = r20(r50)
                                                r20 = upvalueValues[upvalues[4]]
                                                r32 = 256
                                                r50 = r20(r25)
                                                r14 = r37 + r50
                                                r37 = 65536
                                                r20 = r14 % r37
                                                r50 = r14 - r20
                                                r37 = r50 / r18
                                                r18 = 256
                                                r50 = r20 % r18
                                                r8 = r20 - r50
                                                r33 = 256
                                                r14 = nil
                                                r18 = r8 / r32
                                                r32 = 256
                                                r8 = r37 % r32
                                                r31 = r37 - r8
                                                r25 = nil
                                                r32 = r31 / r33
                                                r31 = {
                                                    r50,
                                                    r18,
                                                    r8,
                                                    r32
                                                }
                                                r18 = nil
                                                r8 = nil
                                                r50 = nil
                                                r11 = nil
                                                r32 = nil
                                                upvalueValues[upvalues[1]] = r31
                                                r20 = nil
                                                r37 = nil
                                                state = 71
                                            end
                                        end
                                    end
                                else
                                    -- createClosure2 entry 13170811 -> 75, states 75-81
                                    if state <= 78 then
                                        if state <= 76 then
                                            if state <= 75 then
                                                if state == 75 then -- entry 13170811 -> 75
                                                    state = upvalueValues[upvalues[1]]
                                                    r14 = state
                                                    r11 = args[1]
                                                    r25 = args[2]
                                                    state = r14[r25]
                                                    state = state and (76) or (77)
                                                end
                                            else
                                                if state == 76 then
                                                    state = 78
                                                end
                                            end
                                        else
                                            if state <= 77 then
                                                if state == 77 then
                                                    state = {}
                                                    upvalueValues[upvalues[2]] = state
                                                    ReturnVal = upvalueValues[upvalues[3]]
                                                    r20 = ReturnVal
                                                    r31 = 1
                                                    r33 = r31
                                                    r37 = 35184372088832
                                                    ReturnVal = r25 % r37
                                                    upvalueValues[upvalues[4]] = ReturnVal
                                                    r18 = 255
                                                    r50 = r25 % r18
                                                    r18 = 2
                                                    r37 = r50 + r18
                                                    upvalueValues[upvalues[5]] = r37
                                                    r8 = "string"
                                                    r18 = _env[r8]
                                                    r8 = "len"
                                                    r50 = r18[r8]
                                                    r18 = r50(r11)
                                                    r50 = ""
                                                    r14[r25] = r50
                                                    r31 = 0
                                                    r47 = r33 < r31
                                                    r8 = 1
                                                    r31 = r8 - r33
                                                    r50 = 85
                                                    r32 = r18
                                                    state = 79
                                                end
                                            else
                                                if state == 78 then
                                                    ReturnVal = {
                                                        r25
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        if state <= 80 then
                                            if state <= 79 then
                                                if state == 79 then
                                                    r31 = r31 + r33
                                                    r41 = not r47
                                                    r8 = r31 <= r32
                                                    r8 = r41 and r8
                                                    r41 = r31 >= r32
                                                    r41 = r47 and r41
                                                    r8 = r41 or r8
                                                    r41 = (80)
                                                    state = r8 and r41
                                                    r8 = (81)
                                                    state = state or r8
                                                end
                                            else
                                                if state == 80 then
                                                    r8 = r31
                                                    r1 = "string"
                                                    r52 = _env[r1]
                                                    r1 = "byte"
                                                    r51 = r52[r1]
                                                    r52 = r51(r11, r8)
                                                    r51 = upvalueValues[upvalues[6]]
                                                    r1 = r51()
                                                    r57 = r52 + r1
                                                    r40 = r57 + r50
                                                    r8 = nil
                                                    r57 = 256
                                                    r41 = r40 % r57
                                                    r50 = r41
                                                    r57 = r14[r25]
                                                    r1 = 1
                                                    r52 = r50 + r1
                                                    r51 = r20[r52]
                                                    r40 = r57 .. r51
                                                    r14[r25] = r40
                                                    state = 79
                                                end
                                            end
                                        else
                                            if state == 81 then
                                                r20 = nil
                                                r18 = nil
                                                r50 = nil
                                                state = 78
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 99 then
                            if state <= 97 then
                                if state <= 96 then
                                    -- createClosure5 entry 1810002 -> 82, states 82-96
                                    if state <= 89 then
                                        if state <= 85 then
                                            if state <= 83 then
                                                if state <= 82 then
                                                    if state == 82 then -- entry 1810002 -> 82
                                                        r25 = "syn"
                                                        r11 = _env[r25]
                                                        state = r11 and (83) or (84)
                                                        ReturnVal = r11
                                                    end
                                                else
                                                    if state == 83 then
                                                        r14 = "syn"
                                                        r25 = _env[r14]
                                                        r20 = upvalueValues[upvalues[1]]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r18 = "\127\181\127\148\181%\165"
                                                        r8 = 18729838453265
                                                        r50 = r37(r18, r8)
                                                        r14 = r20[r50]
                                                        r11 = r25[r14]
                                                        ReturnVal = r11
                                                        state = 84
                                                    end
                                                end
                                            else
                                                if state <= 84 then
                                                    if state == 84 then
                                                        state = ReturnVal and (85) or (86)
                                                    end
                                                else
                                                    if state == 85 then
                                                        state = createClosure5(163, {
                                                            upvalues[1],
                                                            upvalues[2]
                                                        })
                                                        ReturnVal = {
                                                            state
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 87 then
                                                if state <= 86 then
                                                    if state == 86 then
                                                        r25 = "http"
                                                        r11 = _env[r25]
                                                        state = r11 and (87) or (88)
                                                        ReturnVal = r11
                                                    end
                                                else
                                                    if state == 87 then
                                                        r14 = "http"
                                                        r25 = _env[r14]
                                                        r20 = upvalueValues[upvalues[1]]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r18 = "\195\213\241T\011\029\238"
                                                        r8 = 28958081741996
                                                        r50 = r37(r18, r8)
                                                        r14 = r20[r50]
                                                        r11 = r25[r14]
                                                        ReturnVal = r11
                                                        state = 88
                                                    end
                                                end
                                            else
                                                if state <= 88 then
                                                    if state == 88 then
                                                        state = ReturnVal and (89) or (90)
                                                    end
                                                else
                                                    if state == 89 then
                                                        state = createClosure4(164, {
                                                            upvalues[1],
                                                            upvalues[2]
                                                        })
                                                        ReturnVal = {
                                                            state
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 93 then
                                            if state <= 91 then
                                                if state <= 90 then
                                                    if state == 90 then
                                                        ReturnVal = "request"
                                                        state = _env[ReturnVal]
                                                        state = state and (91) or (92)
                                                    end
                                                else
                                                    if state == 91 then
                                                        state = createClosure6(165, {
                                                            upvalues[1],
                                                            upvalues[2]
                                                        })
                                                        ReturnVal = {
                                                            state
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state <= 92 then
                                                    if state == 92 then
                                                        ReturnVal = "http_request"
                                                        state = _env[ReturnVal]
                                                        state = state and (93) or (94)
                                                    end
                                                else
                                                    if state == 93 then
                                                        state = createClosure3(166, {
                                                            upvalues[1],
                                                            upvalues[2]
                                                        })
                                                        ReturnVal = {
                                                            state
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 95 then
                                                if state <= 94 then
                                                    if state == 94 then
                                                        ReturnVal = "getrawmetatable"
                                                        state = _env[ReturnVal]
                                                        r25 = "game"
                                                        r11 = _env[r25]
                                                        ReturnVal = state(r11)
                                                        r11 = allocUpvalue()
                                                        upvalueValues[r11] = ReturnVal
                                                        ReturnVal = upvalueValues[r11]
                                                        state = not ReturnVal
                                                        state = state and (95) or (96)
                                                    end
                                                else
                                                    if state == 95 then
                                                        state = createClosure6(167, {})
                                                        ReturnVal = {
                                                            state
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state == 96 then
                                                    ReturnVal = upvalueValues[r11]
                                                    r14 = upvalueValues[upvalues[1]]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r50 = ";\030\246E\182o\239\135\000\179"
                                                    r18 = 11538776413437
                                                    r37 = r20(r50, r18)
                                                    r25 = r14[r37]
                                                    state = ReturnVal[r25]
                                                    r25 = allocUpvalue()
                                                    upvalueValues[r25] = state
                                                    state = createClosure4(168, {
                                                        r11,
                                                        upvalues[1],
                                                        upvalues[2],
                                                        r25
                                                    })
                                                    ReturnVal = {
                                                        state
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure2 entry 247117 -> 97, states 97-97
                                    if state == 97 then -- entry 247117 -> 97
                                        state = upvalueValues[upvalues[1]]
                                        r11 = args[1]
                                        r25 = "JSONEncode"
                                        r25 = state[r25]
                                        ReturnVal = {
                                            r25(state, r11)
                                        }
                                        ReturnVal = {
                                            unpack(ReturnVal)
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 98 then
                                    -- createClosure2 entry 13831372 -> 98, states 98-98
                                    if state == 98 then -- entry 13831372 -> 98
                                        ReturnVal = "game"
                                        state = _env[ReturnVal]
                                        r14 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r11 = args[1]
                                        r18 = 13597639760059
                                        r50 = "\214\tD\148\239\170\248\128Pq"
                                        r37 = r20(r50, r18)
                                        r25 = r14[r37]
                                        ReturnVal = "GetService"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state, r25)
                                        r14 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r18 = 8209659940590
                                        r50 = "J\159-'\191D\158\208\184u1Tq8\1474\158\028t\r\170"
                                        r37 = r20(r50, r18)
                                        r25 = r14[r37]
                                        r37 = upvalueValues[upvalues[1]]
                                        r50 = upvalueValues[upvalues[2]]
                                        r8 = "\162\130\193h"
                                        r32 = 1532532146889
                                        r18 = r50(r8, r32)
                                        r20 = r37[r18]
                                        state = "SetCore"
                                        state = ReturnVal[state]
                                        r14 = {
                                            [r20] = r11
                                        }
                                        state = state(ReturnVal, r25, r14)
                                        r11 = nil
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure4 entry 8075733 -> 99, states 99-99
                                    if state == 99 then -- entry 8075733 -> 99
                                        r11 = args[1]
                                        state = upvalueValues[upvalues[1]]
                                        r25 = "JSONDecode"
                                        r25 = state[r25]
                                        ReturnVal = {
                                            r25(state, r11)
                                        }
                                        ReturnVal = {
                                            unpack(ReturnVal)
                                        }
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 104 then
                                if state <= 100 then
                                    -- createClosure1 entry 11451682 -> 100, states 100-100
                                    if state == 100 then -- entry 11451682 -> 100
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r25 = upvalueValues[upvalues[2]]
                                        r14 = upvalueValues[upvalues[3]]
                                        r37 = "\136\191i\192\144\154"
                                        r50 = 7092324977894
                                        r20 = r14(r37, r50)
                                        r11 = r25[r20]
                                        state = ReturnVal[r11]
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure1 entry 118784 -> 101, states 101-104
                                    if state <= 102 then
                                        if state <= 101 then
                                            if state == 101 then -- entry 118784 -> 101
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r11 = upvalueValues[upvalues[2]]
                                                r14 = ""
                                                r20 = 22527274952954
                                                r25 = r11(r14, r20)
                                                state = ReturnVal[r25]
                                                r11 = state
                                                r25 = 16
                                                r14 = r25
                                                r25 = 1
                                                r20 = r25
                                                r25 = 0
                                                r37 = r20 < r25
                                                ReturnVal = 1
                                                r25 = ReturnVal - r20
                                                state = 102
                                            end
                                        else
                                            if state == 102 then
                                                r50 = not r37
                                                r25 = r25 + r20
                                                ReturnVal = r25 <= r14
                                                ReturnVal = r50 and ReturnVal
                                                r50 = r25 >= r14
                                                r50 = r37 and r50
                                                ReturnVal = r50 or ReturnVal
                                                r50 = (103)
                                                state = ReturnVal and r50
                                                ReturnVal = (104)
                                                state = state or ReturnVal
                                            end
                                        end
                                    else
                                        if state <= 103 then
                                            if state == 103 then
                                                r50 = r25
                                                ReturnVal = upvalueValues[upvalues[3]]
                                                r32 = upvalueValues[upvalues[4]]
                                                r50 = nil
                                                r47 = upvalueValues[upvalues[5]]
                                                r41 = r47()
                                                r47 = 26
                                                r33 = r41 * r47
                                                r31 = r32(r33)
                                                r32 = 97
                                                r8 = r31 + r32
                                                r18 = ReturnVal(r8)
                                                state = r11 .. r18
                                                r11 = state
                                                state = 102
                                            end
                                        else
                                            if state == 104 then
                                                ReturnVal = {
                                                    r11
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure2 entry 9944729 -> 105, states 105-115
                                if state <= 110 then
                                    if state <= 107 then
                                        if state <= 106 then
                                            if state <= 105 then
                                                if state == 105 then -- entry 9944729 -> 105
                                                    r11 = upvalueValues[upvalues[1]]
                                                    r25 = 600
                                                    ReturnVal = r11 + r25
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r25 = r11()
                                                    state = ReturnVal >= r25
                                                    state = state and (106) or (107)
                                                end
                                            else
                                                if state == 106 then
                                                    ReturnVal = upvalueValues[upvalues[3]]
                                                    state = true
                                                    ReturnVal = {
                                                        state,
                                                        ReturnVal
                                                    }
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state == 107 then
                                                state = upvalueValues[upvalues[4]]
                                                r11 = state
                                                r25 = upvalueValues[upvalues[5]]
                                                r14 = upvalueValues[upvalues[6]]
                                                r50 = 34565670371039
                                                r37 = ":w\147"
                                                r20 = r14(r37, r50)
                                                ReturnVal = r25[r20]
                                                r14 = upvalueValues[upvalues[7]]
                                                r37 = upvalueValues[upvalues[5]]
                                                r50 = upvalueValues[upvalues[6]]
                                                r8 = "\153\t%\173*\173\161\r\025\153~\246\171"
                                                r32 = 32536237914926
                                                r18 = r50(r8, r32)
                                                r20 = r37[r18]
                                                r25 = r14 .. r20
                                                r20 = upvalueValues[upvalues[5]]
                                                r37 = upvalueValues[upvalues[6]]
                                                r18 = "\255\1941=#h"
                                                r8 = 7340451515738
                                                r50 = r37(r18, r8)
                                                r14 = r20[r50]
                                                r37 = upvalueValues[upvalues[5]]
                                                r50 = upvalueValues[upvalues[6]]
                                                r32 = 16855870267049
                                                r8 = "1\235g\249"
                                                r18 = r50(r8, r32)
                                                r20 = r37[r18]
                                                r50 = upvalueValues[upvalues[5]]
                                                r18 = upvalueValues[upvalues[6]]
                                                r31 = 11094608712750
                                                r32 = "\005-[\187"
                                                r8 = r18(r32, r31)
                                                r37 = r50[r8]
                                                r50 = upvalueValues[upvalues[8]]
                                                r31 = upvalueValues[upvalues[5]]
                                                r33 = upvalueValues[upvalues[6]]
                                                r40 = 5754675432055
                                                r41 = "[HL\"\165+\131"
                                                r47 = r33(r41, r40)
                                                r32 = r31[r47]
                                                r31 = upvalueValues[upvalues[9]]
                                                r47 = upvalueValues[upvalues[5]]
                                                r41 = upvalueValues[upvalues[6]]
                                                r51 = 28394646680486
                                                r57 = "\203\234ba\180\236D\216,N"
                                                r40 = r41(r57, r51)
                                                r33 = r47[r40]
                                                r47 = upvalueValues[upvalues[10]]
                                                r41 = r47()
                                                r8 = {
                                                    [r32] = r31,
                                                    [r33] = r41
                                                }
                                                r18 = r50(r8)
                                                r8 = upvalueValues[upvalues[5]]
                                                r32 = upvalueValues[upvalues[6]]
                                                r47 = 32778346789791
                                                r33 = "\135\189\251\240gY\165"
                                                r31 = r32(r33, r47)
                                                r50 = r8[r31]
                                                r31 = upvalueValues[upvalues[5]]
                                                r33 = upvalueValues[upvalues[6]]
                                                r40 = 29766004454948
                                                r41 = "\169\217\012P\224L(\176Ea\206\227"
                                                r47 = r33(r41, r40)
                                                r32 = r31[r47]
                                                r33 = upvalueValues[upvalues[5]]
                                                r47 = upvalueValues[upvalues[6]]
                                                r57 = 20483983320386
                                                r40 = "\217\205\204i\172\021\148\008\152\215\203\159\159\131f}"
                                                r41 = r47(r40, r57)
                                                r31 = r33[r41]
                                                r8 = {
                                                    [r32] = r31
                                                }
                                                state = {
                                                    [ReturnVal] = r25,
                                                    [r14] = r20,
                                                    [r37] = r18,
                                                    [r50] = r8
                                                }
                                                r25 = state
                                                state = r11(r25)
                                                r14 = state
                                                r37 = upvalueValues[upvalues[5]]
                                                r50 = upvalueValues[upvalues[6]]
                                                r32 = 25993884872520
                                                r8 = "C\130fb\141\185\026\177n\191"
                                                r18 = r50(r8, r32)
                                                r20 = r37[r18]
                                                ReturnVal = r14[r20]
                                                r20 = 200
                                                state = ReturnVal ~= r20
                                                state = state and (108) or (109)
                                            end
                                        end
                                    else
                                        if state <= 109 then
                                            if state <= 108 then
                                                if state == 108 then
                                                    r37 = upvalueValues[upvalues[5]]
                                                    r50 = upvalueValues[upvalues[6]]
                                                    r8 = ">\232\193\134\205\203x\238Q\228"
                                                    r32 = 10865528001475
                                                    r18 = r50(r8, r32)
                                                    r20 = r37[r18]
                                                    ReturnVal = r14[r20]
                                                    r20 = 429
                                                    state = ReturnVal ~= r20
                                                    state = state and (110) or (111)
                                                end
                                            else
                                                if state == 109 then
                                                    state = upvalueValues[upvalues[12]]
                                                    r50 = upvalueValues[upvalues[5]]
                                                    r18 = upvalueValues[upvalues[6]]
                                                    r31 = 3698411161274
                                                    r32 = "\215\198\214\002"
                                                    r8 = r18(r32, r31)
                                                    r37 = r50[r8]
                                                    r20 = r14[r37]
                                                    ReturnVal = state(r20)
                                                    r20 = ReturnVal
                                                    r37 = upvalueValues[upvalues[5]]
                                                    r50 = upvalueValues[upvalues[6]]
                                                    r32 = 6097738418967
                                                    r8 = "f\193\236u\133We"
                                                    r18 = r50(r8, r32)
                                                    ReturnVal = r37[r18]
                                                    state = r20[ReturnVal]
                                                    state = state and (112) or (113)
                                                end
                                            end
                                        else
                                            if state == 110 then
                                                state = upvalueValues[upvalues[11]]
                                                r37 = upvalueValues[upvalues[5]]
                                                r50 = upvalueValues[upvalues[6]]
                                                r32 = 35069161619402
                                                r8 = "Q\148\030byL%\026\016!c\240^\157\169\138A\183\196\216\002"
                                                r18 = r50(r8, r32)
                                                r20 = r37[r18]
                                                ReturnVal = state(r20)
                                                state = 114
                                            end
                                        end
                                    end
                                else
                                    if state <= 113 then
                                        if state <= 112 then
                                            if state <= 111 then
                                                if state == 111 then
                                                    state = upvalueValues[upvalues[11]]
                                                    r37 = upvalueValues[upvalues[5]]
                                                    r50 = upvalueValues[upvalues[6]]
                                                    r32 = 15334051093476
                                                    r8 = "\005w\1796\006u\138\2370\015\238j}Fh\247\135\164\017\251\nm\140Z>\026e\006\135\140"
                                                    r18 = r50(r8, r32)
                                                    r20 = r37[r18]
                                                    ReturnVal = state(r20)
                                                    state = 114
                                                end
                                            else
                                                if state == 112 then
                                                    r50 = upvalueValues[upvalues[5]]
                                                    r18 = upvalueValues[upvalues[6]]
                                                    r31 = 8929635192894
                                                    r32 = "T\133F\003"
                                                    r8 = r18(r32, r31)
                                                    r37 = r50[r8]
                                                    ReturnVal = r20[r37]
                                                    r50 = upvalueValues[upvalues[5]]
                                                    r18 = upvalueValues[upvalues[6]]
                                                    r31 = 15261132774338
                                                    r32 = "\248\027\143"
                                                    r8 = r18(r32, r31)
                                                    r37 = r50[r8]
                                                    state = ReturnVal[r37]
                                                    upvalueValues[upvalues[3]] = state
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r37 = ReturnVal()
                                                    upvalueValues[upvalues[1]] = r37
                                                    r50 = upvalueValues[upvalues[3]]
                                                    ReturnVal = true
                                                    ReturnVal = {
                                                        ReturnVal,
                                                        r50
                                                    }
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state == 113 then
                                                ReturnVal = upvalueValues[upvalues[11]]
                                                r32 = upvalueValues[upvalues[5]]
                                                r31 = upvalueValues[upvalues[6]]
                                                r41 = 13190063396862
                                                r47 = "\185\tPE\021\231\r"
                                                r33 = r31(r47, r41)
                                                r8 = r32[r33]
                                                r18 = r20[r8]
                                                r50 = ReturnVal(r18)
                                                r20 = nil
                                                state = 115
                                            end
                                        end
                                    else
                                        if state <= 114 then
                                            if state == 114 then
                                                state = 115
                                            end
                                        else
                                            if state == 115 then
                                                ReturnVal = false
                                                ReturnVal = {
                                                    ReturnVal
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
                    if state <= 162 then
                        if state <= 149 then
                            if state <= 133 then
                                if state <= 118 then
                                    -- createClosure2 entry 13501351 -> 116, states 116-118
                                    if state <= 117 then
                                        if state <= 116 then
                                            if state == 116 then -- entry 13501351 -> 116
                                                state = upvalueValues[upvalues[1]]
                                                r25 = {
                                                    state()
                                                }
                                                r11 = r25[2]
                                                ReturnVal = r25[1]
                                                r25 = ReturnVal
                                                state = r25 and (117) or (118)
                                            end
                                        else
                                            if state == 117 then
                                                state = upvalueValues[upvalues[2]]
                                                ReturnVal = state(r11)
                                                state = upvalueValues[upvalues[3]]
                                                r20 = upvalueValues[upvalues[4]]
                                                r37 = upvalueValues[upvalues[5]]
                                                r18 = "\136\250\135\002\n\1957X\188d\006\014\222\129L\143\012+\131c\237dH\016O"
                                                r8 = 23470792731313
                                                r50 = r37(r18, r8)
                                                r14 = r20[r50]
                                                ReturnVal = state(r14)
                                                state = 118
                                            end
                                        end
                                    else
                                        if state == 118 then
                                            r25 = nil
                                            r11 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure3 entry 11642215 -> 119, states 119-133
                                    if state <= 126 then
                                        if state <= 122 then
                                            if state <= 120 then
                                                if state <= 119 then
                                                    if state == 119 then -- entry 11642215 -> 119
                                                        r11 = args[1]
                                                        state = upvalueValues[upvalues[1]]
                                                        ReturnVal = state()
                                                        r25 = ReturnVal
                                                        ReturnVal = upvalueValues[upvalues[2]]
                                                        r37 = upvalueValues[upvalues[3]]
                                                        r50 = upvalueValues[upvalues[4]]
                                                        r8 = "\195:\143X_\228\213\154\224Y\214A\000\1908"
                                                        r32 = 14722595543751
                                                        r18 = r50(r8, r32)
                                                        r20 = r37[r18]
                                                        r37 = upvalueValues[upvalues[5]]
                                                        r18 = upvalueValues[upvalues[6]]
                                                        r50 = r37(r18)
                                                        r14 = r20 .. r50
                                                        state = ReturnVal .. r14
                                                        r14 = state
                                                        r20 = upvalueValues[upvalues[3]]
                                                        r37 = upvalueValues[upvalues[4]]
                                                        r8 = 8381638037311
                                                        r18 = "\025<\190\144\019F\203\251hh"
                                                        r50 = r37(r18, r8)
                                                        ReturnVal = r20[r50]
                                                        r20 = upvalueValues[upvalues[7]]
                                                        r37 = r20()
                                                        r50 = upvalueValues[upvalues[3]]
                                                        r18 = upvalueValues[upvalues[4]]
                                                        r31 = 25454162308685
                                                        r32 = "e\146\165"
                                                        r8 = r18(r32, r31)
                                                        r20 = r50[r8]
                                                        state = {
                                                            [ReturnVal] = r37,
                                                            [r20] = r11
                                                        }
                                                        r20 = state
                                                        state = upvalueValues[upvalues[8]]
                                                        state = state and (120) or (121)
                                                    end
                                                else
                                                    if state == 120 then
                                                        ReturnVal = upvalueValues[upvalues[3]]
                                                        r37 = upvalueValues[upvalues[4]]
                                                        r18 = "YM\028E\242"
                                                        r8 = 3811485026030
                                                        r50 = r37(r18, r8)
                                                        state = ReturnVal[r50]
                                                        ReturnVal = r25
                                                        r20[state] = ReturnVal
                                                        state = 121
                                                    end
                                                end
                                            else
                                                if state <= 121 then
                                                    if state == 121 then
                                                        state = upvalueValues[upvalues[9]]
                                                        r18 = upvalueValues[upvalues[3]]
                                                        r8 = upvalueValues[upvalues[4]]
                                                        r33 = 5365861550530
                                                        r31 = "\171\134\028"
                                                        r32 = r8(r31, r33)
                                                        r50 = r18[r32]
                                                        r8 = upvalueValues[upvalues[3]]
                                                        r32 = upvalueValues[upvalues[4]]
                                                        r47 = 33465376226527
                                                        r33 = "\002C\168TX:"
                                                        r31 = r32(r33, r47)
                                                        r18 = r8[r31]
                                                        r32 = upvalueValues[upvalues[3]]
                                                        r31 = upvalueValues[upvalues[4]]
                                                        r41 = 14419550460474
                                                        r47 = "\131y\166\187"
                                                        r33 = r31(r47, r41)
                                                        r8 = r32[r33]
                                                        r31 = upvalueValues[upvalues[3]]
                                                        r33 = upvalueValues[upvalues[4]]
                                                        r40 = 5150785407326
                                                        r41 = "-\201\168\163"
                                                        r47 = r33(r41, r40)
                                                        r32 = r31[r47]
                                                        r31 = upvalueValues[upvalues[10]]
                                                        r33 = r31(r20)
                                                        r47 = upvalueValues[upvalues[3]]
                                                        r41 = upvalueValues[upvalues[4]]
                                                        r57 = "\004e~\137\150A\015"
                                                        r51 = 27619021910589
                                                        r40 = r41(r57, r51)
                                                        r31 = r47[r40]
                                                        r40 = upvalueValues[upvalues[3]]
                                                        r57 = upvalueValues[upvalues[4]]
                                                        r1 = 21875856451530
                                                        r52 = "}\029\253\023\001\246\1549X\246\224\199"
                                                        r51 = r57(r52, r1)
                                                        r41 = r40[r51]
                                                        r57 = upvalueValues[upvalues[3]]
                                                        r51 = upvalueValues[upvalues[4]]
                                                        r29 = 4532083673150
                                                        r1 = "\237\165\153\216k\160\144pW\245\175\208_\156c\154"
                                                        r52 = r51(r1, r29)
                                                        r40 = r57[r52]
                                                        r47 = {
                                                            [r41] = r40
                                                        }
                                                        r37 = {
                                                            [r50] = r14,
                                                            [r18] = r8,
                                                            [r32] = r33,
                                                            [r31] = r47
                                                        }
                                                        ReturnVal = state(r37)
                                                        r37 = ReturnVal
                                                        r18 = upvalueValues[upvalues[3]]
                                                        r8 = upvalueValues[upvalues[4]]
                                                        r33 = 24970887736683
                                                        r31 = "\022\205\017\021\212\138\012Ci\224"
                                                        r32 = r8(r31, r33)
                                                        r50 = r18[r32]
                                                        ReturnVal = r37[r50]
                                                        r50 = 200
                                                        state = ReturnVal ~= r50
                                                        state = state and (122) or (123)
                                                    end
                                                else
                                                    if state == 122 then
                                                        state = upvalueValues[upvalues[11]]
                                                        r18 = upvalueValues[upvalues[3]]
                                                        r8 = upvalueValues[upvalues[4]]
                                                        r31 = "h\185\209\182\247\200p\2477C\248\189(\160Y\n\229\014%\239\255\029>\144{\178\212"
                                                        r33 = 29216307967268
                                                        r32 = r8(r31, r33)
                                                        r50 = r18[r32]
                                                        ReturnVal = state(r50)
                                                        state = false
                                                        ReturnVal = {
                                                            state
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 124 then
                                                if state <= 123 then
                                                    if state == 123 then
                                                        state = upvalueValues[upvalues[12]]
                                                        r8 = upvalueValues[upvalues[3]]
                                                        r32 = upvalueValues[upvalues[4]]
                                                        r33 = "Y\229\169u"
                                                        r47 = 21387953956583
                                                        r31 = r32(r33, r47)
                                                        r18 = r8[r31]
                                                        r50 = r37[r18]
                                                        ReturnVal = state(r50)
                                                        r18 = state
                                                        r50 = ReturnVal
                                                        r31 = upvalueValues[upvalues[3]]
                                                        r33 = upvalueValues[upvalues[4]]
                                                        r40 = 881124344218
                                                        r41 = "\128\231\194\156\168Uo"
                                                        r47 = r33(r41, r40)
                                                        r32 = r31[r47]
                                                        r8 = r50[r32]
                                                        state = r8 and (124) or (125)
                                                        ReturnVal = r8
                                                    end
                                                else
                                                    if state == 124 then
                                                        r33 = upvalueValues[upvalues[3]]
                                                        r47 = upvalueValues[upvalues[4]]
                                                        r40 = "ih4\230"
                                                        r57 = 34970983399324
                                                        r41 = r47(r40, r57)
                                                        r31 = r33[r41]
                                                        r32 = r50[r31]
                                                        r33 = upvalueValues[upvalues[3]]
                                                        r47 = upvalueValues[upvalues[4]]
                                                        r40 = "D\203\172{\171"
                                                        r57 = 14598228531853
                                                        r41 = r47(r40, r57)
                                                        r31 = r33[r41]
                                                        r8 = r32[r31]
                                                        ReturnVal = r8
                                                        state = 125
                                                    end
                                                end
                                            else
                                                if state <= 125 then
                                                    if state == 125 then
                                                        state = r18
                                                        state = not ReturnVal
                                                        state = state and (126) or (127)
                                                    end
                                                else
                                                    if state == 126 then
                                                        state = upvalueValues[upvalues[11]]
                                                        r8 = state
                                                        r33 = upvalueValues[upvalues[3]]
                                                        r47 = upvalueValues[upvalues[4]]
                                                        r57 = 33659471134009
                                                        r40 = "^\232S\142A9\n"
                                                        r41 = r47(r40, r57)
                                                        r31 = r33[r41]
                                                        r32 = r50[r31]
                                                        state = r32 and (128) or (129)
                                                        r18 = r32
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 130 then
                                            if state <= 128 then
                                                if state <= 127 then
                                                    if state == 127 then
                                                        ReturnVal = upvalueValues[upvalues[8]]
                                                        state = not ReturnVal
                                                        state = state and (130) or (131)
                                                    end
                                                else
                                                    if state == 128 then
                                                        state = r8
                                                        ReturnVal = state(r18)
                                                        state = false
                                                        ReturnVal = {
                                                            state
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state <= 129 then
                                                    if state == 129 then
                                                        r31 = upvalueValues[upvalues[3]]
                                                        r33 = upvalueValues[upvalues[4]]
                                                        r41 = "\237\180/5gM\195\008M0h]\127\211\145"
                                                        r40 = 29552615749057
                                                        r47 = r33(r41, r40)
                                                        r32 = r31[r47]
                                                        r18 = r32
                                                        state = 128
                                                    end
                                                else
                                                    if state == 130 then
                                                        state = true
                                                        ReturnVal = {
                                                            state
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 132 then
                                                if state <= 131 then
                                                    if state == 131 then
                                                        r32 = upvalueValues[upvalues[3]]
                                                        r31 = upvalueValues[upvalues[4]]
                                                        r47 = "75\255\194"
                                                        r41 = 35082211868624
                                                        r33 = r31(r47, r41)
                                                        r8 = r32[r33]
                                                        r18 = r50[r8]
                                                        r32 = upvalueValues[upvalues[3]]
                                                        r31 = upvalueValues[upvalues[4]]
                                                        r47 = "\t\1704\207"
                                                        r41 = 24468983901314
                                                        r33 = r31(r47, r41)
                                                        r8 = r32[r33]
                                                        ReturnVal = r18[r8]
                                                        r8 = "lDigest"
                                                        r18 = _env[r8]
                                                        r33 = upvalueValues[upvalues[3]]
                                                        r47 = upvalueValues[upvalues[4]]
                                                        r40 = "5\022@\138"
                                                        r57 = 5233771661701
                                                        r41 = r47(r40, r57)
                                                        r31 = r33[r41]
                                                        r41 = upvalueValues[upvalues[3]]
                                                        r40 = upvalueValues[upvalues[4]]
                                                        r51 = "n"
                                                        r52 = 34967001382810
                                                        r57 = r40(r51, r52)
                                                        r47 = r41[r57]
                                                        r51 = upvalueValues[upvalues[3]]
                                                        r52 = upvalueValues[upvalues[4]]
                                                        r53 = 4618662889574
                                                        r29 = "M"
                                                        r1 = r52(r29, r53)
                                                        r57 = r51[r1]
                                                        r51 = upvalueValues[upvalues[13]]
                                                        r40 = r57 .. r51
                                                        r41 = r25 .. r40
                                                        r33 = r47 .. r41
                                                        r32 = r31 .. r33
                                                        r8 = r18(r32)
                                                        state = ReturnVal == r8
                                                        state = state and (132) or (133)
                                                    end
                                                else
                                                    if state == 132 then
                                                        state = true
                                                        ReturnVal = {
                                                            state
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state == 133 then
                                                    state = upvalueValues[upvalues[11]]
                                                    r8 = upvalueValues[upvalues[3]]
                                                    r32 = upvalueValues[upvalues[4]]
                                                    r47 = 8932182822975
                                                    r33 = "\011=\137\144\197\2331\022\197H3\023,\176%N\232>8>\182q\129'\215\030\014"
                                                    r31 = r32(r33, r47)
                                                    r18 = r8[r31]
                                                    ReturnVal = state(r18)
                                                    state = false
                                                    ReturnVal = {
                                                        state
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 148 then
                                    -- createClosure5 entry 11041890 -> 134, states 134-148
                                    if state <= 141 then
                                        if state <= 137 then
                                            if state <= 135 then
                                                if state <= 134 then
                                                    if state == 134 then -- entry 11041890 -> 134
                                                        r11 = args[1]
                                                        state = upvalueValues[upvalues[1]]
                                                        state = state and (135) or (136)
                                                    end
                                                else
                                                    if state == 135 then
                                                        state = upvalueValues[upvalues[2]]
                                                        r14 = upvalueValues[upvalues[3]]
                                                        r20 = upvalueValues[upvalues[4]]
                                                        r50 = "\224\132p\130A2e:C\n\193\210\r\169[\242N\170Y\129"
                                                        r18 = 5880367696562
                                                        r37 = r20(r50, r18)
                                                        r25 = r14[r37]
                                                        ReturnVal = state(r25)
                                                        state = false
                                                        ReturnVal = {
                                                            state
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state <= 136 then
                                                    if state == 136 then
                                                        state = true
                                                        upvalueValues[upvalues[1]] = state
                                                        ReturnVal = upvalueValues[upvalues[5]]
                                                        r25 = ReturnVal()
                                                        r14 = upvalueValues[upvalues[6]]
                                                        r50 = upvalueValues[upvalues[3]]
                                                        r18 = upvalueValues[upvalues[4]]
                                                        r31 = 13548298082468
                                                        r32 = "\022\"\135\012G\163B\131~W?\219\004^nkh`"
                                                        r8 = r18(r32, r31)
                                                        r37 = r50[r8]
                                                        r18 = upvalueValues[upvalues[7]]
                                                        r32 = upvalueValues[upvalues[8]]
                                                        r8 = r18(r32)
                                                        r31 = upvalueValues[upvalues[3]]
                                                        r33 = upvalueValues[upvalues[4]]
                                                        r41 = "H#\1592*\t@/\155s)*"
                                                        r40 = 24193315613697
                                                        r47 = r33(r41, r40)
                                                        r32 = r31[r47]
                                                        r33 = upvalueValues[upvalues[9]]
                                                        r47 = r33()
                                                        r40 = upvalueValues[upvalues[3]]
                                                        r57 = upvalueValues[upvalues[4]]
                                                        r1 = 19070431093424
                                                        r52 = "\157XM\191\135"
                                                        r51 = r57(r52, r1)
                                                        r41 = r40[r51]
                                                        r33 = r41 .. r11
                                                        r31 = r47 .. r33
                                                        r18 = r32 .. r31
                                                        r50 = r8 .. r18
                                                        r20 = r37 .. r50
                                                        ReturnVal = r14 .. r20
                                                        r14 = ReturnVal
                                                        ReturnVal = upvalueValues[upvalues[10]]
                                                        state = ReturnVal and (137) or (138)
                                                    end
                                                else
                                                    if state == 137 then
                                                        r50 = upvalueValues[upvalues[3]]
                                                        r18 = upvalueValues[upvalues[4]]
                                                        r32 = "&\006\146e\154\155["
                                                        r31 = 891200930206
                                                        r8 = r18(r32, r31)
                                                        r37 = r50[r8]
                                                        r20 = r37 .. r25
                                                        ReturnVal = r14 .. r20
                                                        r14 = ReturnVal
                                                        state = 138
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 139 then
                                                if state <= 138 then
                                                    if state == 138 then
                                                        r20 = upvalueValues[upvalues[11]]
                                                        r8 = upvalueValues[upvalues[3]]
                                                        r32 = upvalueValues[upvalues[4]]
                                                        r47 = 12479736239795
                                                        r33 = "\244\177\204"
                                                        r31 = r32(r33, r47)
                                                        r18 = r8[r31]
                                                        r32 = upvalueValues[upvalues[3]]
                                                        r31 = upvalueValues[upvalues[4]]
                                                        r41 = 33793026637176
                                                        r47 = "\191\153S\222=\151"
                                                        r33 = r31(r47, r41)
                                                        r8 = r32[r33]
                                                        r31 = upvalueValues[upvalues[3]]
                                                        r33 = upvalueValues[upvalues[4]]
                                                        r40 = 9272838967518
                                                        r41 = "+kq"
                                                        r47 = r33(r41, r40)
                                                        r32 = r31[r47]
                                                        r50 = {
                                                            [r18] = r14,
                                                            [r8] = r32
                                                        }
                                                        r37 = r20(r50)
                                                        r20 = false
                                                        upvalueValues[upvalues[1]] = r20
                                                        r32 = upvalueValues[upvalues[3]]
                                                        r31 = upvalueValues[upvalues[4]]
                                                        r41 = 2749526443264
                                                        r47 = "\227(W\186\237\226\152&b)"
                                                        r33 = r31(r47, r41)
                                                        r8 = r32[r33]
                                                        r18 = r37[r8]
                                                        r8 = 200
                                                        r50 = r18 ~= r8
                                                        state = r50 and (139) or (140)
                                                    end
                                                else
                                                    if state == 139 then
                                                        r50 = upvalueValues[upvalues[2]]
                                                        r32 = upvalueValues[upvalues[3]]
                                                        r31 = upvalueValues[upvalues[4]]
                                                        r41 = 2420139557990
                                                        r47 = "\150\179\242qd\142\200\154\131\154|\145]\174\244\023\020\149c\223\183\228&%\244\242\000"
                                                        r33 = r31(r47, r41)
                                                        r8 = r32[r33]
                                                        r18 = r50(r8)
                                                        r50 = false
                                                        ReturnVal = {
                                                            r50
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state <= 140 then
                                                    if state == 140 then
                                                        r50 = upvalueValues[upvalues[12]]
                                                        r31 = upvalueValues[upvalues[3]]
                                                        r33 = upvalueValues[upvalues[4]]
                                                        r41 = "\149\148;\179"
                                                        r40 = 14638700518048
                                                        r47 = r33(r41, r40)
                                                        r32 = r31[r47]
                                                        r8 = r37[r32]
                                                        r18 = r50(r8)
                                                        r33 = upvalueValues[upvalues[3]]
                                                        r47 = upvalueValues[upvalues[4]]
                                                        r57 = 1030530564575
                                                        r40 = "z\140%\247[Q\029"
                                                        r41 = r47(r40, r57)
                                                        r31 = r33[r41]
                                                        r32 = r18[r31]
                                                        r8 = state
                                                        state = r32 and (141) or (142)
                                                        r50 = r32
                                                    end
                                                else
                                                    if state == 141 then
                                                        r47 = upvalueValues[upvalues[3]]
                                                        r41 = upvalueValues[upvalues[4]]
                                                        r57 = "\150\152@\176"
                                                        r51 = 16839690018465
                                                        r40 = r41(r57, r51)
                                                        r33 = r47[r40]
                                                        r31 = r18[r33]
                                                        r47 = upvalueValues[upvalues[3]]
                                                        r41 = upvalueValues[upvalues[4]]
                                                        r57 = "\008\019afe"
                                                        r51 = 19789485925375
                                                        r40 = r41(r57, r51)
                                                        r33 = r47[r40]
                                                        r32 = r31[r33]
                                                        r50 = r32
                                                        state = 142
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 145 then
                                            if state <= 143 then
                                                if state <= 142 then
                                                    if state == 142 then
                                                        state = r8
                                                        state = r50 and (143) or (144)
                                                    end
                                                else
                                                    if state == 143 then
                                                        r50 = true
                                                        ReturnVal = {
                                                            r50
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state <= 144 then
                                                    if state == 144 then
                                                        r8 = state
                                                        r31 = upvalueValues[upvalues[13]]
                                                        r41 = 5
                                                        r47 = 1
                                                        r33 = r31(r11, r47, r41)
                                                        r47 = upvalueValues[upvalues[3]]
                                                        r41 = upvalueValues[upvalues[4]]
                                                        r57 = "\189\238$mN"
                                                        r51 = 28649552491548
                                                        r40 = r41(r57, r51)
                                                        r31 = r47[r40]
                                                        r32 = r33 == r31
                                                        state = r32 and (145) or (146)
                                                        r50 = r32
                                                    end
                                                else
                                                    if state == 145 then
                                                        state = r8
                                                        state = r50 and (147) or (148)
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 147 then
                                                if state <= 146 then
                                                    if state == 146 then
                                                        r31 = upvalueValues[upvalues[13]]
                                                        r47 = 1
                                                        r41 = 4
                                                        r33 = r31(r11, r47, r41)
                                                        r47 = upvalueValues[upvalues[3]]
                                                        r41 = upvalueValues[upvalues[4]]
                                                        r51 = 3531174364780
                                                        r57 = "\206\169\177\219"
                                                        r40 = r41(r57, r51)
                                                        r31 = r47[r40]
                                                        r32 = r33 == r31
                                                        r50 = r32
                                                        state = 145
                                                    end
                                                else
                                                    if state == 147 then
                                                        r50 = upvalueValues[upvalues[14]]
                                                        r8 = {
                                                            r50(r11)
                                                        }
                                                        ReturnVal = {
                                                            unpack(r8)
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state == 148 then
                                                    r50 = upvalueValues[upvalues[2]]
                                                    r31 = upvalueValues[upvalues[3]]
                                                    r33 = upvalueValues[upvalues[4]]
                                                    r40 = 24321569614909
                                                    r41 = "\r?8\133\229\178\144\"(\247;\231\022\016\248:P]\021\236G\145!"
                                                    r47 = r33(r41, r40)
                                                    r32 = r31[r47]
                                                    r8 = r50(r32)
                                                    r50 = false
                                                    ReturnVal = {
                                                        r50
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure1 entry 6984135 -> 149, states 149-149
                                    if state == 149 then -- entry 6984135 -> 149
                                        r11 = args[1]
                                        state = r11
                                        r11 = nil
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 157 then
                                if state <= 150 then
                                    -- createClosure4 entry 12318416 -> 150, states 150-150
                                    if state == 150 then -- entry 12318416 -> 150
                                        state = upvalueValues[upvalues[1]]
                                        ReturnVal = state()
                                        state = upvalueValues[upvalues[2]]
                                        r14 = upvalueValues[upvalues[3]]
                                        r20 = upvalueValues[upvalues[4]]
                                        r18 = 223532105832
                                        r50 = "r\234\249\231\166"
                                        r37 = r20(r50, r18)
                                        r25 = r14[r37]
                                        r20 = upvalueValues[upvalues[3]]
                                        r37 = upvalueValues[upvalues[4]]
                                        r8 = 10122125890153
                                        r18 = "\210l\254%M9\251\146\225U\224"
                                        r50 = r37(r18, r8)
                                        r14 = r20[r50]
                                        r37 = upvalueValues[upvalues[3]]
                                        r50 = upvalueValues[upvalues[4]]
                                        r32 = 15599069830239
                                        r8 = "\144\002\255\184\237\247\127"
                                        r18 = r50(r8, r32)
                                        r20 = r37[r18]
                                        r50 = upvalueValues[upvalues[3]]
                                        ReturnVal = "Notify"
                                        ReturnVal = state[ReturnVal]
                                        r18 = upvalueValues[upvalues[4]]
                                        r31 = 14862232623880
                                        r32 = "\212M\144\207\171V\237\188\215\203j\015\022J\139Vx\2335t\135\179\026Dl\008\020\1337(\163\173~{\015\209\022\023b\130\211%\225s\200\026\159"
                                        r8 = r18(r32, r31)
                                        r37 = r50[r8]
                                        r18 = upvalueValues[upvalues[3]]
                                        r8 = upvalueValues[upvalues[4]]
                                        r33 = 11152656454729
                                        r31 = "!o \197!\244\169*"
                                        r32 = r8(r31, r33)
                                        r50 = r18[r32]
                                        r18 = 4
                                        r11 = {
                                            [r25] = r14,
                                            [r20] = r37,
                                            [r50] = r18
                                        }
                                        ReturnVal = ReturnVal(state, r11)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure4 entry 15619929 -> 151, states 151-157
                                    if state <= 154 then
                                        if state <= 152 then
                                            if state <= 151 then
                                                if state == 151 then -- entry 15619929 -> 151
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r25 = upvalueValues[upvalues[2]]
                                                    r14 = upvalueValues[upvalues[3]]
                                                    r50 = 785562124653
                                                    r37 = ""
                                                    r20 = r14(r37, r50)
                                                    r11 = r25[r20]
                                                    state = ReturnVal ~= r11
                                                    state = state and (152) or (153)
                                                end
                                            else
                                                if state == 152 then
                                                    state = upvalueValues[upvalues[4]]
                                                    r11 = upvalueValues[upvalues[1]]
                                                    ReturnVal = state(r11)
                                                    state = ReturnVal and (154) or (155)
                                                end
                                            end
                                        else
                                            if state <= 153 then
                                                if state == 153 then
                                                    state = upvalueValues[upvalues[5]]
                                                    r14 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r18 = 8567114239893
                                                    r50 = "\\\159\153\254\005"
                                                    r37 = r20(r50, r18)
                                                    r25 = r14[r37]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r37 = upvalueValues[upvalues[3]]
                                                    r18 = "\204\138\143\212!}\179\235\185n|"
                                                    r8 = 25436387765828
                                                    r50 = r37(r18, r8)
                                                    r14 = r20[r50]
                                                    r37 = upvalueValues[upvalues[2]]
                                                    r50 = upvalueValues[upvalues[3]]
                                                    r32 = 34393616793231
                                                    r8 = "<Er\255\012\188\008"
                                                    r18 = r50(r8, r32)
                                                    r20 = r37[r18]
                                                    ReturnVal = "Notify"
                                                    ReturnVal = state[ReturnVal]
                                                    r50 = upvalueValues[upvalues[2]]
                                                    r18 = upvalueValues[upvalues[3]]
                                                    r31 = 33810978536832
                                                    r32 = "-[i\228\210\162\130\231Dw\170\017\212\135\016\174g\178\r"
                                                    r8 = r18(r32, r31)
                                                    r37 = r50[r8]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r8 = upvalueValues[upvalues[3]]
                                                    r33 = 20329250972922
                                                    r31 = "\227\011\029\138\190\131\143\188"
                                                    r32 = r8(r31, r33)
                                                    r50 = r18[r32]
                                                    r18 = 4
                                                    r11 = {
                                                        [r25] = r14,
                                                        [r20] = r37,
                                                        [r50] = r18
                                                    }
                                                    ReturnVal = ReturnVal(state, r11)
                                                    state = 156
                                                end
                                            else
                                                if state == 154 then
                                                    ReturnVal = "writefile"
                                                    state = _env[ReturnVal]
                                                    r25 = upvalueValues[upvalues[2]]
                                                    r14 = upvalueValues[upvalues[3]]
                                                    r50 = 23788916075333
                                                    r37 = "\007\133\242\183\172\005\209\232\193M6"
                                                    r20 = r14(r37, r50)
                                                    r11 = r25[r20]
                                                    r25 = upvalueValues[upvalues[1]]
                                                    ReturnVal = state(r11, r25)
                                                    state = upvalueValues[upvalues[5]]
                                                    r14 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r50 = "\005\250`\196\169"
                                                    r18 = 23053904964079
                                                    r37 = r20(r50, r18)
                                                    r25 = r14[r37]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r37 = upvalueValues[upvalues[3]]
                                                    r8 = 33533044473087
                                                    r18 = "\217\144\1304\131\141\186"
                                                    r50 = r37(r18, r8)
                                                    r14 = r20[r50]
                                                    r37 = upvalueValues[upvalues[2]]
                                                    r50 = upvalueValues[upvalues[3]]
                                                    r32 = 34314067541610
                                                    r8 = "\016L\186\150T0\158"
                                                    r18 = r50(r8, r32)
                                                    r20 = r37[r18]
                                                    r50 = upvalueValues[upvalues[2]]
                                                    r18 = upvalueValues[upvalues[3]]
                                                    r31 = 7186725326098
                                                    r32 = "Xx\005\193\\\012Cp\162\190\006\244\255\015^[ \201\128\231\183_\030"
                                                    r8 = r18(r32, r31)
                                                    r37 = r50[r8]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r8 = upvalueValues[upvalues[3]]
                                                    r33 = 30882766026796
                                                    r31 = "\254p\205A\208;\149\222"
                                                    r32 = r8(r31, r33)
                                                    r50 = r18[r32]
                                                    ReturnVal = "Notify"
                                                    ReturnVal = state[ReturnVal]
                                                    r18 = 2
                                                    r11 = {
                                                        [r25] = r14,
                                                        [r20] = r37,
                                                        [r50] = r18
                                                    }
                                                    ReturnVal = ReturnVal(state, r11)
                                                    r11 = "task"
                                                    ReturnVal = _env[r11]
                                                    r25 = upvalueValues[upvalues[2]]
                                                    r14 = upvalueValues[upvalues[3]]
                                                    r50 = 24253075434525
                                                    r37 = "\243\163ox"
                                                    r20 = r14(r37, r50)
                                                    r11 = r25[r20]
                                                    state = ReturnVal[r11]
                                                    r11 = 2
                                                    ReturnVal = state(r11)
                                                    state = upvalueValues[upvalues[5]]
                                                    ReturnVal = "Destroy"
                                                    ReturnVal = state[ReturnVal]
                                                    ReturnVal = ReturnVal(state)
                                                    ReturnVal = "loadstring"
                                                    state = _env[ReturnVal]
                                                    r11 = upvalueValues[upvalues[6]]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r37 = upvalueValues[upvalues[3]]
                                                    r8 = 24979016838511
                                                    r18 = "\137b\181\030\007A\238\021b+IY\031\176\249\164>{\182(\181\202\139\211\207\145|Kv\143\255\148n\225\020Z\219\198C\016\232\182t\201\213D\030\191\242U^\174U\169\169\020\251\234\232\027\152\131=\n\143\214\021\151\242\242Z"
                                                    r50 = r37(r18, r8)
                                                    r14 = r20[r50]
                                                    r25 = {
                                                        r11(r14)
                                                    }
                                                    ReturnVal = state(unpack(r25))
                                                    state = ReturnVal()
                                                    state = 157
                                                end
                                            end
                                        end
                                    else
                                        if state <= 156 then
                                            if state <= 155 then
                                                if state == 155 then
                                                    state = upvalueValues[upvalues[5]]
                                                    r14 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r18 = 22600731224348
                                                    r50 = "I^e\030\143"
                                                    r37 = r20(r50, r18)
                                                    r25 = r14[r37]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r37 = upvalueValues[upvalues[3]]
                                                    r8 = 14089923107233
                                                    r18 = "\195\196\022\148J\011A(\193X\209"
                                                    r50 = r37(r18, r8)
                                                    r14 = r20[r50]
                                                    r37 = upvalueValues[upvalues[2]]
                                                    ReturnVal = "Notify"
                                                    ReturnVal = state[ReturnVal]
                                                    r50 = upvalueValues[upvalues[3]]
                                                    r32 = 32055920147023
                                                    r8 = "\240\147P!\242\2507"
                                                    r18 = r50(r8, r32)
                                                    r20 = r37[r18]
                                                    r50 = upvalueValues[upvalues[2]]
                                                    r18 = upvalueValues[upvalues[3]]
                                                    r31 = 19552468083600
                                                    r32 = "\144\019gA\127ONV\155\255P\244\231\025R\000\n\184\028\":A\246\217\157\196"
                                                    r8 = r18(r32, r31)
                                                    r37 = r50[r8]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r8 = upvalueValues[upvalues[3]]
                                                    r33 = 3709400041151
                                                    r31 = "bNId\003c\175#"
                                                    r32 = r8(r31, r33)
                                                    r50 = r18[r32]
                                                    r18 = 4
                                                    r11 = {
                                                        [r25] = r14,
                                                        [r20] = r37,
                                                        [r50] = r18
                                                    }
                                                    ReturnVal = ReturnVal(state, r11)
                                                    state = 157
                                                end
                                            else
                                                if state == 156 then
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state == 157 then
                                                state = 156
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 161 then
                                    -- createClosure0 entry 15433018 -> 158, states 158-161
                                    if state <= 159 then
                                        if state <= 158 then
                                            if state == 158 then -- entry 15433018 -> 158
                                                state = upvalueValues[upvalues[1]]
                                                r11 = upvalueValues[upvalues[2]]
                                                ReturnVal = state(r11)
                                                state = ReturnVal and (159) or (160)
                                            end
                                        else
                                            if state == 159 then
                                                state = upvalueValues[upvalues[3]]
                                                r14 = upvalueValues[upvalues[4]]
                                                r20 = upvalueValues[upvalues[5]]
                                                r18 = 26958450684169
                                                r50 = "J\005\023\141 "
                                                r37 = r20(r50, r18)
                                                r25 = r14[r37]
                                                r20 = upvalueValues[upvalues[4]]
                                                r37 = upvalueValues[upvalues[5]]
                                                r18 = "\139\177\217\014\165\202T"
                                                r8 = 24985203780978
                                                r50 = r37(r18, r8)
                                                r14 = r20[r50]
                                                r37 = upvalueValues[upvalues[4]]
                                                r50 = upvalueValues[upvalues[5]]
                                                r32 = 2639604188365
                                                r8 = "\132\019,[d\204\r"
                                                r18 = r50(r8, r32)
                                                r20 = r37[r18]
                                                r50 = upvalueValues[upvalues[4]]
                                                ReturnVal = "Notify"
                                                ReturnVal = state[ReturnVal]
                                                r18 = upvalueValues[upvalues[5]]
                                                r31 = 7373148425577
                                                r32 = "\147\154}\134z\230\218|]\023\236!,\137\155z\134Q\024"
                                                r8 = r18(r32, r31)
                                                r37 = r50[r8]
                                                r18 = upvalueValues[upvalues[4]]
                                                r8 = upvalueValues[upvalues[5]]
                                                r33 = 4663064299643
                                                r31 = "\148e\158\242]$\165\244"
                                                r32 = r8(r31, r33)
                                                r50 = r18[r32]
                                                r18 = 2
                                                r11 = {
                                                    [r25] = r14,
                                                    [r20] = r37,
                                                    [r50] = r18
                                                }
                                                ReturnVal = ReturnVal(state, r11)
                                                r11 = "task"
                                                ReturnVal = _env[r11]
                                                r25 = upvalueValues[upvalues[4]]
                                                r14 = upvalueValues[upvalues[5]]
                                                r37 = "[F\240&"
                                                r50 = 13792260659478
                                                r20 = r14(r37, r50)
                                                r11 = r25[r20]
                                                state = ReturnVal[r11]
                                                r11 = 2
                                                ReturnVal = state(r11)
                                                state = upvalueValues[upvalues[3]]
                                                ReturnVal = "Destroy"
                                                ReturnVal = state[ReturnVal]
                                                ReturnVal = ReturnVal(state)
                                                ReturnVal = "loadstring"
                                                state = _env[ReturnVal]
                                                r11 = upvalueValues[upvalues[6]]
                                                r20 = upvalueValues[upvalues[4]]
                                                r37 = upvalueValues[upvalues[5]]
                                                r8 = 4627536185450
                                                r18 = "\218\143\129%\197\203\003i|'R\155r\242\219\157\003\207\015\028\217\210]Y\141\226\004\133g\232\203.]\251c\215\162\208+\234QN\201m\030\148\007\008\159;\215+\188B4\002\185\184`\198\250k\209\209\147\134k\206\024\147\003"
                                                r50 = r37(r18, r8)
                                                r14 = r20[r50]
                                                r25 = {
                                                    r11(r14)
                                                }
                                                ReturnVal = state(unpack(r25))
                                                state = ReturnVal()
                                                state = 161
                                            end
                                        end
                                    else
                                        if state <= 160 then
                                            if state == 160 then
                                                state = upvalueValues[upvalues[3]]
                                                r14 = upvalueValues[upvalues[4]]
                                                r20 = upvalueValues[upvalues[5]]
                                                r50 = "\243\r\173\247K"
                                                r18 = 4130410760067
                                                r37 = r20(r50, r18)
                                                r25 = r14[r37]
                                                r20 = upvalueValues[upvalues[4]]
                                                r37 = upvalueValues[upvalues[5]]
                                                r18 = "\195\145\208\147\202Im\231q2\165cu\215\160U\005"
                                                r8 = 18410097500540
                                                r50 = r37(r18, r8)
                                                r14 = r20[r50]
                                                r37 = upvalueValues[upvalues[4]]
                                                r50 = upvalueValues[upvalues[5]]
                                                r32 = 5413098310104
                                                r8 = "\247\018\246<\208\244\012"
                                                r18 = r50(r8, r32)
                                                r20 = r37[r18]
                                                r50 = upvalueValues[upvalues[4]]
                                                r18 = upvalueValues[upvalues[5]]
                                                r31 = 27919326835400
                                                r32 = "/i,\136\246\206\005I\1877\1811*\188\222\141\189 \025\247\163%\162"
                                                r8 = r18(r32, r31)
                                                r37 = r50[r8]
                                                r18 = upvalueValues[upvalues[4]]
                                                r8 = upvalueValues[upvalues[5]]
                                                r33 = 6279630375788
                                                r31 = "X2\005\214\226\127\181f"
                                                r32 = r8(r31, r33)
                                                r50 = r18[r32]
                                                ReturnVal = "Notify"
                                                ReturnVal = state[ReturnVal]
                                                r18 = 4
                                                r11 = {
                                                    [r25] = r14,
                                                    [r20] = r37,
                                                    [r50] = r18
                                                }
                                                ReturnVal = ReturnVal(state, r11)
                                                state = 161
                                            end
                                        else
                                            if state == 161 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure1 entry 5879569 -> 162, states 162-162
                                    if state == 162 then -- entry 5879569 -> 162
                                        r25 = "uDczX"
                                        r14 = 12378503
                                        r11 = r25 ^ r14
                                        ReturnVal = 15300723
                                        state = ReturnVal - r11
                                        r11 = state
                                        ReturnVal = "3jAHWKQN"
                                        state = ReturnVal / r11
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            end
                        end
                    else
                        if state <= 166 then
                            if state <= 164 then
                                if state <= 163 then
                                    -- createClosure5 entry 2776607 -> 163, states 163-163
                                    if state == 163 then -- entry 2776607 -> 163
                                        r11 = args[1]
                                        r14 = "syn"
                                        r25 = _env[r14]
                                        r20 = upvalueValues[upvalues[1]]
                                        r37 = upvalueValues[upvalues[2]]
                                        r8 = 879376073113
                                        r18 = "@\239\192\1546\156\180"
                                        r50 = r37(r18, r8)
                                        r14 = r20[r50]
                                        ReturnVal = r25[r14]
                                        r37 = upvalueValues[upvalues[1]]
                                        r50 = upvalueValues[upvalues[2]]
                                        r32 = 20002055660642
                                        r8 = "\255N\242"
                                        r18 = r50(r8, r32)
                                        r20 = r37[r18]
                                        r50 = upvalueValues[upvalues[1]]
                                        r18 = upvalueValues[upvalues[2]]
                                        r31 = 31831310432742
                                        r32 = "@K\241\"a\234"
                                        r8 = r18(r32, r31)
                                        r37 = r50[r8]
                                        r18 = upvalueValues[upvalues[1]]
                                        r8 = upvalueValues[upvalues[2]]
                                        r33 = 29624579274211
                                        r31 = "1\178\131"
                                        r32 = r8(r31, r33)
                                        r50 = r18[r32]
                                        r14 = {
                                            [r20] = r11,
                                            [r37] = r50
                                        }
                                        r25 = ReturnVal(r14)
                                        r14 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r50 = "i'\190\227"
                                        r18 = 7441095429513
                                        r37 = r20(r50, r18)
                                        ReturnVal = r14[r37]
                                        state = r25[ReturnVal]
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure4 entry 5775317 -> 164, states 164-164
                                    if state == 164 then -- entry 5775317 -> 164
                                        r14 = "http"
                                        r25 = _env[r14]
                                        r20 = upvalueValues[upvalues[1]]
                                        r11 = args[1]
                                        r37 = upvalueValues[upvalues[2]]
                                        r8 = 22740729424221
                                        r18 = "\231\143\134\019m\253["
                                        r50 = r37(r18, r8)
                                        r14 = r20[r50]
                                        ReturnVal = r25[r14]
                                        r37 = upvalueValues[upvalues[1]]
                                        r50 = upvalueValues[upvalues[2]]
                                        r32 = 11129860428862
                                        r8 = ">8\234"
                                        r18 = r50(r8, r32)
                                        r20 = r37[r18]
                                        r50 = upvalueValues[upvalues[1]]
                                        r18 = upvalueValues[upvalues[2]]
                                        r31 = 6027844324086
                                        r32 = "|m\216\008\016\233"
                                        r8 = r18(r32, r31)
                                        r37 = r50[r8]
                                        r18 = upvalueValues[upvalues[1]]
                                        r8 = upvalueValues[upvalues[2]]
                                        r33 = 21519175952164
                                        r31 = "\165:\251"
                                        r32 = r8(r31, r33)
                                        r50 = r18[r32]
                                        r14 = {
                                            [r20] = r11,
                                            [r37] = r50
                                        }
                                        r25 = ReturnVal(r14)
                                        r14 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r50 = "[\n\\a"
                                        r18 = 2800700343576
                                        r37 = r20(r50, r18)
                                        ReturnVal = r14[r37]
                                        state = r25[ReturnVal]
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 165 then
                                    -- createClosure6 entry 10110830 -> 165, states 165-165
                                    if state == 165 then -- entry 10110830 -> 165
                                        r11 = args[1]
                                        r25 = "request"
                                        ReturnVal = _env[r25]
                                        r37 = upvalueValues[upvalues[1]]
                                        r50 = upvalueValues[upvalues[2]]
                                        r8 = "\201\137\192"
                                        r32 = 21326803887819
                                        r18 = r50(r8, r32)
                                        r20 = r37[r18]
                                        r50 = upvalueValues[upvalues[1]]
                                        r18 = upvalueValues[upvalues[2]]
                                        r31 = 32032612661828
                                        r32 = "\2230Q\240PD"
                                        r8 = r18(r32, r31)
                                        r37 = r50[r8]
                                        r18 = upvalueValues[upvalues[1]]
                                        r8 = upvalueValues[upvalues[2]]
                                        r33 = 34780746514244
                                        r31 = "\155\020\167"
                                        r32 = r8(r31, r33)
                                        r50 = r18[r32]
                                        r14 = {
                                            [r20] = r11,
                                            [r37] = r50
                                        }
                                        r25 = ReturnVal(r14)
                                        r14 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r50 = "\167\221\230H"
                                        r18 = 3198220125649
                                        r37 = r20(r50, r18)
                                        ReturnVal = r14[r37]
                                        state = r25[ReturnVal]
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure3 entry 6472813 -> 166, states 166-166
                                    if state == 166 then -- entry 6472813 -> 166
                                        r25 = "http_request"
                                        ReturnVal = _env[r25]
                                        r11 = args[1]
                                        r37 = upvalueValues[upvalues[1]]
                                        r50 = upvalueValues[upvalues[2]]
                                        r32 = 35068517629898
                                        r8 = "G\169s"
                                        r18 = r50(r8, r32)
                                        r20 = r37[r18]
                                        r50 = upvalueValues[upvalues[1]]
                                        r18 = upvalueValues[upvalues[2]]
                                        r31 = 17474572001225
                                        r32 = "\192\247X\185\136\021"
                                        r8 = r18(r32, r31)
                                        r37 = r50[r8]
                                        r18 = upvalueValues[upvalues[1]]
                                        r8 = upvalueValues[upvalues[2]]
                                        r33 = 13742742886655
                                        r31 = "o\137\011"
                                        r32 = r8(r31, r33)
                                        r50 = r18[r32]
                                        r14 = {
                                            [r20] = r11,
                                            [r37] = r50
                                        }
                                        r25 = ReturnVal(r14)
                                        r14 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r50 = "O\227M\016"
                                        r18 = 33598596005149
                                        r37 = r20(r50, r18)
                                        ReturnVal = r14[r37]
                                        state = r25[ReturnVal]
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 168 then
                                if state <= 167 then
                                    -- createClosure6 entry 5985834 -> 167, states 167-167
                                    if state == 167 then -- entry 5985834 -> 167
                                        r11 = args[1]
                                        ReturnVal = "game"
                                        state = _env[ReturnVal]
                                        r25 = "HttpGet"
                                        r25 = state[r25]
                                        ReturnVal = {
                                            r25(state, r11)
                                        }
                                        ReturnVal = {
                                            unpack(ReturnVal)
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure4 entry 10524520 -> 168, states 168-168
                                    if state == 168 then -- entry 10524520 -> 168
                                        r11 = allocUpvalue()
                                        upvalueValues[r11] = args[1]
                                        r25 = allocUpvalue()
                                        state = nil
                                        upvalueValues[r25] = state
                                        state = upvalueValues[upvalues[1]]
                                        r14 = upvalueValues[upvalues[2]]
                                        r20 = upvalueValues[upvalues[3]]
                                        r50 = ")\230M\144,\217\170=\140@"
                                        r18 = 21683738077041
                                        r37 = r20(r50, r18)
                                        ReturnVal = r14[r37]
                                        r37 = createClosure(169, {
                                            upvalues[2],
                                            upvalues[3],
                                            upvalues[4],
                                            r11,
                                            r25
                                        })
                                        r20 = "newcclosure"
                                        r14 = _env[r20]
                                        r20 = r14(r37)
                                        state[ReturnVal] = r20
                                        ReturnVal = "game"
                                        state = _env[ReturnVal]
                                        r14 = upvalueValues[r11]
                                        ReturnVal = "HttpGet"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state, r14)
                                        state = upvalueValues[upvalues[1]]
                                        r14 = upvalueValues[upvalues[2]]
                                        r20 = upvalueValues[upvalues[3]]
                                        r50 = "\145\2453gZ5\196\248\140D"
                                        r18 = 27273708745116
                                        r37 = r20(r50, r18)
                                        ReturnVal = r14[r37]
                                        r14 = upvalueValues[upvalues[4]]
                                        state[ReturnVal] = r14
                                        state = upvalueValues[r25]
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure entry 4137099 -> 169, states 169-171
                                if state <= 170 then
                                    if state <= 169 then
                                        if state == 169 then -- entry 4137099 -> 169
                                            r11 = args[1]
                                            r14 = "getnamecallmethod"
                                            ReturnVal = _env[r14]
                                            r25 = {
                                                select(2, unpack(args))
                                            }
                                            r14 = ReturnVal()
                                            r20 = upvalueValues[upvalues[1]]
                                            r37 = upvalueValues[upvalues[2]]
                                            r8 = 24011329022893
                                            r18 = "SZ-\233/\160\157"
                                            r50 = r37(r18, r8)
                                            ReturnVal = r20[r50]
                                            state = r14 ~= ReturnVal
                                            state = state and (170) or (171)
                                        end
                                    else
                                        if state == 170 then
                                            state = upvalueValues[upvalues[3]]
                                            ReturnVal = {
                                                state(r11, unpack(r25))
                                            }
                                            ReturnVal = {
                                                unpack(ReturnVal)
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    if state == 171 then
                                        state = upvalueValues[upvalues[3]]
                                        r14 = upvalueValues[upvalues[4]]
                                        ReturnVal = state(r11, r14)
                                        upvalueValues[upvalues[5]] = ReturnVal
                                        state = upvalueValues[upvalues[5]]
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
            state = #gcProxy
            return unpack(ReturnVal)
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
                upvalueRefCounts[upvalueId], captureIndex = upvalueRefCounts[upvalueId] - (1), (1) + captureIndex
                if 0 == upvalueRefCounts[upvalueId] then
                    upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
                end
                upvalueId = captures[captureIndex]
            end
        end
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 1559032
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 1559032
                    end
                })
            end
        end
        upvalueValues = {}
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
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
        currentUpvalueId = 0
        createClosure = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(...)
                return vm(entryId, {
                    ...
                }, captures, gcProxy)
            end
            return closure
        end
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)