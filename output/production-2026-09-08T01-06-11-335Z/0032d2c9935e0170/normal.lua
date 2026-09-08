return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure0, createClosure3, createClosure6, allocUpvalue, createClosure2, createClosure1, upvalueValues, createUpvalueProxy, releaseUpvalue, upvalueRefCounts, createClosure5, currentUpvalueId, vm, createClosure, createClosure4, createClosure7, releaseUpvalues)
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, ReturnVal, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52
            while state do
                if state <= 165 then
                    if state <= 74 then
                        if state <= 52 then
                            if state <= 35 then
                                if state <= 34 then
                                    if state <= 33 then
                                        -- root entry 4915014 -> 1, states 1-33
                                        if state <= 17 then
                                            if state <= 9 then
                                                if state <= 5 then
                                                    if state <= 3 then
                                                        if state <= 2 then
                                                            if state <= 1 then
                                                                if state == 1 then -- entry 4915014 -> 1
                                                                    r41 = allocUpvalue()
                                                                    state = true
                                                                    upvalueValues[r41] = state
                                                                    r44 = allocUpvalue()
                                                                    r38 = "string"
                                                                    ReturnVal = _env[r38]
                                                                    r38 = "gmatch"
                                                                    state = ReturnVal[r38]
                                                                    r38 = allocUpvalue()
                                                                    upvalueValues[r38] = state
                                                                    r8 = allocUpvalue()
                                                                    state = createClosure4(34, {})
                                                                    r34 = createClosure3(35, {
                                                                        r8
                                                                    })
                                                                    upvalueValues[r44] = state
                                                                    state = false
                                                                    upvalueValues[r8] = state
                                                                    r50 = "pcall"
                                                                    r16 = _env[r50]
                                                                    r50 = r16(r34)
                                                                    state = r50 and (2) or (3)
                                                                    r28 = args
                                                                    ReturnVal = r50
                                                                end
                                                            else
                                                                if state == 2 then
                                                                    r16 = upvalueValues[r8]
                                                                    ReturnVal = r16
                                                                    state = 3
                                                                end
                                                            end
                                                        else
                                                            if state == 3 then
                                                                r16 = ReturnVal
                                                                r50 = "math"
                                                                ReturnVal = _env[r50]
                                                                r50 = "random"
                                                                state = ReturnVal[r50]
                                                                r50 = allocUpvalue()
                                                                upvalueValues[r50] = state
                                                                r34 = "table"
                                                                ReturnVal = _env[r34]
                                                                r34 = "concat"
                                                                state = ReturnVal[r34]
                                                                r34 = state
                                                                r52 = state
                                                                r25 = "table"
                                                                r24 = _env[r25]
                                                                state = r24 and (4) or (5)
                                                                r18 = r24
                                                            end
                                                        end
                                                    else
                                                        if state <= 4 then
                                                            if state == 4 then
                                                                r43 = "table"
                                                                r25 = _env[r43]
                                                                r43 = "unpack"
                                                                r24 = r25[r43]
                                                                r18 = r24
                                                                state = 5
                                                            end
                                                        else
                                                            if state == 5 then
                                                                state = r52
                                                                state = r18 and (6) or (7)
                                                                ReturnVal = r18
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 7 then
                                                        if state <= 6 then
                                                            if state == 6 then
                                                                r18 = allocUpvalue()
                                                                upvalueValues[r18] = ReturnVal
                                                                state = upvalueValues[r50]
                                                                r52 = 3
                                                                r24 = 65
                                                                ReturnVal = state(r52, r24)
                                                                r52 = allocUpvalue()
                                                                upvalueValues[r52] = ReturnVal
                                                                state = 0
                                                                r24 = state
                                                                r43 = "pcall"
                                                                ReturnVal = _env[r43]
                                                                state = 0
                                                                r22 = createClosure2(36, {})
                                                                r43 = {
                                                                    ReturnVal(r22)
                                                                }
                                                                r25 = state
                                                                state = {
                                                                    unpack(r43)
                                                                }
                                                                r43 = state
                                                                ReturnVal = 2
                                                                state = r43[ReturnVal]
                                                                r22 = state
                                                                ReturnVal = "tonumber"
                                                                state = _env[ReturnVal]
                                                                r35 = upvalueValues[r38]
                                                                r4 = "tostring"
                                                                r9 = _env[r4]
                                                                r4 = r9(r22)
                                                                r9 = ":(%d*):"
                                                                r12 = r35(r4, r9)
                                                                r35 = {
                                                                    r12()
                                                                }
                                                                ReturnVal = state(unpack(r35))
                                                                r35 = allocUpvalue()
                                                                upvalueValues[r35] = ReturnVal
                                                                r12 = upvalueValues[r52]
                                                                r9 = r12
                                                                r12 = 1
                                                                r4 = r12
                                                                r12 = 0
                                                                r6 = r4 < r12
                                                                ReturnVal = 1
                                                                r12 = ReturnVal - r4
                                                                state = 8
                                                            end
                                                        else
                                                            if state == 7 then
                                                                r52 = "unpack"
                                                                r18 = _env[r52]
                                                                ReturnVal = r18
                                                                state = 6
                                                            end
                                                        end
                                                    else
                                                        if state <= 8 then
                                                            if state == 8 then
                                                                r12 = r12 + r4
                                                                ReturnVal = r12 <= r9
                                                                r32 = not r6
                                                                ReturnVal = r32 and ReturnVal
                                                                r32 = r12 >= r9
                                                                r32 = r6 and r32
                                                                ReturnVal = r32 or ReturnVal
                                                                r32 = (9)
                                                                state = ReturnVal and r32
                                                                ReturnVal = (10)
                                                                state = state or ReturnVal
                                                            end
                                                        else
                                                            if state == 9 then
                                                                r32 = allocUpvalue()
                                                                upvalueValues[r32] = r12
                                                                r29 = "math"
                                                                ReturnVal = _env[r29]
                                                                r29 = "random"
                                                                state = ReturnVal[r29]
                                                                r29 = 1
                                                                r2 = 100
                                                                ReturnVal = state(r29, r2)
                                                                r29 = allocUpvalue()
                                                                upvalueValues[r29] = ReturnVal
                                                                state = upvalueValues[r50]
                                                                r31 = 255
                                                                r2 = 0
                                                                ReturnVal = state(r2, r31)
                                                                r2 = allocUpvalue()
                                                                upvalueValues[r2] = ReturnVal
                                                                state = upvalueValues[r50]
                                                                r7 = upvalueValues[r29]
                                                                r31 = 1
                                                                ReturnVal = state(r31, r7)
                                                                r31 = allocUpvalue()
                                                                upvalueValues[r31] = ReturnVal
                                                                ReturnVal = upvalueValues[r50]
                                                                r40 = 1
                                                                r51 = 2
                                                                r7 = ReturnVal(r40, r51)
                                                                ReturnVal = 1
                                                                state = r7 == ReturnVal
                                                                r7 = allocUpvalue()
                                                                upvalueValues[r7] = state
                                                                r47 = "tostring"
                                                                r33 = _env[r47]
                                                                r15 = upvalueValues[r50]
                                                                r46 = 0
                                                                r45 = 10000
                                                                r27 = {
                                                                    r15(r46, r45)
                                                                }
                                                                r47 = r33(unpack(r27))
                                                                r33 = ":"
                                                                r14 = r47 .. r33
                                                                r51 = ":"
                                                                r40 = r51 .. r14
                                                                state = "gsub"
                                                                state = r22[state]
                                                                ReturnVal = ":(%d*):"
                                                                state = state(r22, ReturnVal, r40)
                                                                r40 = allocUpvalue()
                                                                upvalueValues[r40] = state
                                                                r51 = "pcall"
                                                                ReturnVal = _env[r51]
                                                                r14 = createClosure4(37, {
                                                                    r50,
                                                                    r32,
                                                                    r52,
                                                                    r38,
                                                                    r41,
                                                                    r35,
                                                                    r7,
                                                                    r40,
                                                                    r29,
                                                                    r31,
                                                                    r2,
                                                                    r18
                                                                })
                                                                r51 = {
                                                                    ReturnVal(r14)
                                                                }
                                                                state = {
                                                                    unpack(r51)
                                                                }
                                                                r51 = state
                                                                state = upvalueValues[r7]
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
                                                                r9 = upvalueValues[r41]
                                                                state = r9 and (13) or (14)
                                                                r12 = r9
                                                            end
                                                        else
                                                            if state == 11 then
                                                                r14 = upvalueValues[r41]
                                                                state = r14 and (15) or (16)
                                                                ReturnVal = r14
                                                            end
                                                        end
                                                    else
                                                        if state <= 12 then
                                                            if state == 12 then
                                                                r33 = upvalueValues[r41]
                                                                state = r33 and (17) or (18)
                                                                r14 = r33
                                                            end
                                                        else
                                                            if state == 13 then
                                                                r9 = r24 == r25
                                                                r12 = r9
                                                                state = 14
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 15 then
                                                        if state <= 14 then
                                                            if state == 14 then
                                                                upvalueValues[r41] = r12
                                                                state = upvalueValues[r41]
                                                                state = state and (19) or (20)
                                                            end
                                                        else
                                                            if state == 15 then
                                                                r33 = state
                                                                r27 = 1
                                                                r15 = r51[r27]
                                                                r27 = false
                                                                r47 = r15 == r27
                                                                state = r47 and (21) or (22)
                                                                r14 = r47
                                                            end
                                                        end
                                                    else
                                                        if state <= 16 then
                                                            if state == 16 then
                                                                upvalueValues[r41] = ReturnVal
                                                                state = 23
                                                            end
                                                        else
                                                            if state == 17 then
                                                                r47 = 1
                                                                r33 = r51[r47]
                                                                r14 = r33
                                                                state = 18
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 25 then
                                                if state <= 21 then
                                                    if state <= 19 then
                                                        if state <= 18 then
                                                            if state == 18 then
                                                                upvalueValues[r41] = r14
                                                                r27 = upvalueValues[r31]
                                                                r46 = 1
                                                                r15 = r27 + r46
                                                                r47 = r51[r15]
                                                                r33 = r24 + r47
                                                                r47 = 256
                                                                state = r33 % r47
                                                                r24 = state
                                                                r15 = upvalueValues[r2]
                                                                r47 = r25 + r15
                                                                r15 = 256
                                                                r33 = r47 % r15
                                                                r25 = r33
                                                                state = 23
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
                                                                r27 = 2
                                                                r15 = r51[r27]
                                                                r27 = upvalueValues[r40]
                                                                r47 = r15 == r27
                                                                r14 = r47
                                                                state = 22
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 23 then
                                                        if state <= 22 then
                                                            if state == 22 then
                                                                state = r33
                                                                ReturnVal = r14
                                                                state = 16
                                                            end
                                                        else
                                                            if state == 23 then
                                                                r32 = releaseUpvalue(r32)
                                                                r29 = releaseUpvalue(r29)
                                                                r51 = nil
                                                                r31 = releaseUpvalue(r31)
                                                                r7 = releaseUpvalue(r7)
                                                                r2 = releaseUpvalue(r2)
                                                                r40 = releaseUpvalue(r40)
                                                                state = 8
                                                            end
                                                        end
                                                    else
                                                        if state <= 24 then
                                                            if state == 24 then
                                                                r18 = releaseUpvalue(r18)
                                                                r50 = releaseUpvalue(r50)
                                                                r8 = releaseUpvalue(r8)
                                                                r41 = releaseUpvalue(r41)
                                                                r44 = releaseUpvalue(r44)
                                                                r24 = nil
                                                                r24 = {}
                                                                r44 = allocUpvalue()
                                                                r38 = releaseUpvalue(r38)
                                                                r52 = releaseUpvalue(r52)
                                                                r41 = nil
                                                                upvalueValues[r44] = r41
                                                                r25 = nil
                                                                r25 = allocUpvalue()
                                                                r41 = allocUpvalue()
                                                                r43 = nil
                                                                r43 = {}
                                                                r38 = nil
                                                                upvalueValues[r41] = r38
                                                                r35 = releaseUpvalue(r35)
                                                                r16 = nil
                                                                r16 = "math"
                                                                r8 = _env[r16]
                                                                r16 = "floor"
                                                                r38 = r8[r16]
                                                                r8 = allocUpvalue()
                                                                r52 = allocUpvalue()
                                                                upvalueValues[r8] = r38
                                                                r50 = "math"
                                                                r16 = _env[r50]
                                                                r50 = "random"
                                                                r38 = r16[r50]
                                                                r34 = nil
                                                                r34 = "table"
                                                                r50 = _env[r34]
                                                                r34 = "remove"
                                                                r16 = r50[r34]
                                                                r18 = "string"
                                                                r34 = _env[r18]
                                                                r18 = "char"
                                                                r50 = r34[r18]
                                                                r18 = allocUpvalue()
                                                                r34 = 0
                                                                upvalueValues[r18] = r34
                                                                r34 = 2
                                                                upvalueValues[r52] = r34
                                                                r34 = {}
                                                                upvalueValues[r25] = r24
                                                                r35 = 256
                                                                r6 = r35
                                                                r35 = 1
                                                                r32 = r35
                                                                r35 = 0
                                                                r29 = r32 < r35
                                                                r22 = nil
                                                                r22 = 1
                                                                r35 = r22 - r32
                                                                r24 = 0
                                                                state = 26
                                                            end
                                                        else
                                                            if state == 25 then
                                                                state = createClosure4(49, {
                                                                    r44
                                                                })
                                                                r9 = {
                                                                    state()
                                                                }
                                                                ReturnVal = {
                                                                    unpack(r9)
                                                                }
                                                                state = nil
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 29 then
                                                    if state <= 27 then
                                                        if state <= 26 then
                                                            if state == 26 then
                                                                r35 = r35 + r32
                                                                r2 = not r29
                                                                r22 = r35 <= r6
                                                                r22 = r2 and r22
                                                                r2 = r35 >= r6
                                                                r2 = r29 and r2
                                                                r22 = r2 or r22
                                                                r2 = (27)
                                                                state = r22 and r2
                                                                r22 = (28)
                                                                state = state or r22
                                                            end
                                                        else
                                                            if state == 27 then
                                                                r22 = r35
                                                                r2 = r22
                                                                r43[r22] = r2
                                                                r22 = nil
                                                                state = 26
                                                            end
                                                        end
                                                    else
                                                        if state <= 28 then
                                                            if state == 28 then
                                                                r35 = #r43
                                                                r6 = 0
                                                                r22 = r35 == r6
                                                                state = 29
                                                            end
                                                        else
                                                            if state == 29 then
                                                                r6 = #r43
                                                                r35 = 1
                                                                r22 = r38(r35, r6)
                                                                r35 = r16(r43, r22)
                                                                r2 = 1
                                                                r6 = upvalueValues[r25]
                                                                r22 = nil
                                                                r29 = r35 - r2
                                                                r32 = r50(r29)
                                                                r6[r35] = r32
                                                                r35 = nil
                                                                state = 30
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 31 then
                                                        if state <= 30 then
                                                            if state == 30 then
                                                                r35 = #r43
                                                                r6 = 0
                                                                r22 = r35 == r6
                                                                state = r22 and (31) or (29)
                                                            end
                                                        else
                                                            if state == 31 then
                                                                r2 = {}
                                                                r35 = allocUpvalue()
                                                                r22 = {}
                                                                upvalueValues[r35] = r22
                                                                r22 = allocUpvalue()
                                                                r6 = createClosure3(53, {
                                                                    r35,
                                                                    r18,
                                                                    r52,
                                                                    r8
                                                                })
                                                                r32 = allocUpvalue()
                                                                upvalueValues[r22] = r6
                                                                r6 = {}
                                                                r8 = releaseUpvalue(r8)
                                                                upvalueValues[r32] = r6
                                                                r29 = "setmetatable"
                                                                r6 = _env[r29]
                                                                r40 = upvalueValues[r32]
                                                                r51 = "__metatable"
                                                                r7 = "__index"
                                                                r47 = nil
                                                                r31 = {
                                                                    [r7] = r40,
                                                                    [r51] = r47
                                                                }
                                                                r29 = r6(r2, r31)
                                                                r6 = createClosure7(59, {
                                                                    r32,
                                                                    r35,
                                                                    r25,
                                                                    r18,
                                                                    r52,
                                                                    r22
                                                                })
                                                                r18 = releaseUpvalue(r18)
                                                                r25 = releaseUpvalue(r25)
                                                                r22 = releaseUpvalue(r22)
                                                                upvalueValues[r41] = r29
                                                                r32 = releaseUpvalue(r32)
                                                                upvalueValues[r44] = r6
                                                                r8 = "game"
                                                                r38 = nil
                                                                r38 = _env[r8]
                                                                r35 = releaseUpvalue(r35)
                                                                r50 = nil
                                                                r50 = upvalueValues[r41]
                                                                r52 = releaseUpvalue(r52)
                                                                r8 = "GetService"
                                                                r8 = r38[r8]
                                                                r34 = nil
                                                                r34 = upvalueValues[r44]
                                                                r24 = nil
                                                                r24 = 33357000473773
                                                                r52 = "\192W\154\024L\014}\238\025\156\206"
                                                                r18 = r34(r52, r24)
                                                                r16 = nil
                                                                r16 = r50[r18]
                                                                r8 = r8(r38, r16)
                                                                r38 = allocUpvalue()
                                                                upvalueValues[r38] = r8
                                                                r16 = "game"
                                                                r8 = _env[r16]
                                                                r34 = upvalueValues[r41]
                                                                r18 = upvalueValues[r44]
                                                                r24 = "\132\228s\024\219\143\030"
                                                                r25 = 14512995097190
                                                                r52 = r18(r24, r25)
                                                                r50 = r34[r52]
                                                                r16 = "GetService"
                                                                r16 = r8[r16]
                                                                r16 = r16(r8, r50)
                                                                r8 = allocUpvalue()
                                                                upvalueValues[r8] = r16
                                                                r50 = "game"
                                                                r16 = _env[r50]
                                                                r18 = upvalueValues[r41]
                                                                r52 = upvalueValues[r44]
                                                                r43 = nil
                                                                r43 = 14837165873917
                                                                r25 = "d\011\252\130a\249E\206\187\197\218l\138\228igJ"
                                                                r24 = r52(r25, r43)
                                                                r50 = "GetService"
                                                                r50 = r16[r50]
                                                                r34 = r18[r24]
                                                                r50 = r50(r16, r34)
                                                                r16 = allocUpvalue()
                                                                upvalueValues[r16] = r50
                                                                r34 = upvalueValues[r8]
                                                                r52 = upvalueValues[r41]
                                                                r24 = upvalueValues[r44]
                                                                r22 = 30875788277801
                                                                r43 = "H\225\231\022\154\028\144m\251\163\021"
                                                                r25 = r24(r43, r22)
                                                                r18 = r52[r25]
                                                                r50 = r34[r18]
                                                                r34 = allocUpvalue()
                                                                upvalueValues[r34] = r50
                                                                r50 = upvalueValues[r34]
                                                                r24 = upvalueValues[r41]
                                                                r18 = "WaitForChild"
                                                                r18 = r50[r18]
                                                                r25 = upvalueValues[r44]
                                                                r35 = 23226423929407
                                                                r22 = "\223|\155\r\212J\139\128"
                                                                r43 = r25(r22, r35)
                                                                r52 = r24[r43]
                                                                r18 = r18(r50, r52)
                                                                r50 = allocUpvalue()
                                                                upvalueValues[r50] = r18
                                                                r25 = upvalueValues[r34]
                                                                r22 = upvalueValues[r41]
                                                                r35 = upvalueValues[r44]
                                                                r32 = "\141\027\206\024\019'\200[\201"
                                                                r2 = 3752730478291
                                                                r6 = r35(r32, r2)
                                                                r43 = r22[r6]
                                                                r24 = r25[r43]
                                                                r52 = state
                                                                state = r24 and (32) or (33)
                                                                r18 = r24
                                                            end
                                                        end
                                                    else
                                                        if state <= 32 then
                                                            if state == 32 then
                                                                state = r52
                                                                r52 = allocUpvalue()
                                                                upvalueValues[r52] = r18
                                                                r18 = upvalueValues[r52]
                                                                r24 = "WaitForChild"
                                                                r24 = r18[r24]
                                                                r43 = upvalueValues[r41]
                                                                r22 = upvalueValues[r44]
                                                                r6 = "G\"\149D\019~\029\021"
                                                                r32 = 14015961356670
                                                                r35 = r22(r6, r32)
                                                                r25 = r43[r35]
                                                                r24 = r24(r18, r25)
                                                                r18 = allocUpvalue()
                                                                upvalueValues[r18] = r24
                                                                r24 = upvalueValues[r16]
                                                                r22 = upvalueValues[r41]
                                                                r25 = "WaitForChild"
                                                                r25 = r24[r25]
                                                                r35 = upvalueValues[r44]
                                                                r2 = 33776042868080
                                                                r32 = "\220V\215.M\159\135ZR1"
                                                                r6 = r35(r32, r2)
                                                                r43 = r22[r6]
                                                                r25 = r25(r24, r43)
                                                                r22 = upvalueValues[r41]
                                                                r35 = upvalueValues[r44]
                                                                r32 = "8\189\155\001\233\209A\221V\2242"
                                                                r2 = 17274380902252
                                                                r6 = r35(r32, r2)
                                                                r24 = "WaitForChild"
                                                                r24 = r25[r24]
                                                                r43 = r22[r6]
                                                                r24 = r24(r25, r43)
                                                                r25 = allocUpvalue()
                                                                upvalueValues[r25] = r24
                                                                r43 = "workspace"
                                                                r24 = _env[r43]
                                                                r35 = upvalueValues[r41]
                                                                r6 = upvalueValues[r44]
                                                                r31 = 23317714758250
                                                                r2 = "g\164c\250\183\218\250\229\222\0120f"
                                                                r32 = r6(r2, r31)
                                                                r43 = "WaitForChild"
                                                                r43 = r24[r43]
                                                                r22 = r35[r32]
                                                                r43 = r43(r24, r22)
                                                                r24 = allocUpvalue()
                                                                upvalueValues[r24] = r43
                                                                r22 = "require"
                                                                r43 = _env[r22]
                                                                r2 = upvalueValues[r16]
                                                                r7 = upvalueValues[r41]
                                                                r40 = upvalueValues[r44]
                                                                r15 = 22614380276002
                                                                r47 = "#\r\130s\237\158\222"
                                                                r51 = r40(r47, r15)
                                                                r31 = r7[r51]
                                                                r32 = r2[r31]
                                                                r45 = 340224983198
                                                                r31 = upvalueValues[r41]
                                                                r7 = upvalueValues[r44]
                                                                r51 = "\239\146\170\183\152\018\222\220\1678Z"
                                                                r47 = 8561118842770
                                                                r40 = r7(r51, r47)
                                                                r2 = r31[r40]
                                                                r6 = r32[r2]
                                                                r2 = upvalueValues[r41]
                                                                r31 = upvalueValues[r44]
                                                                r40 = "\171\156S\228\183\001pL\142\213\006&(Sm \228"
                                                                r51 = 4481956481063
                                                                r7 = r31(r40, r51)
                                                                r32 = r2[r7]
                                                                r35 = r6[r32]
                                                                r22 = r43(r35)
                                                                r43 = allocUpvalue()
                                                                upvalueValues[r43] = r22
                                                                r35 = upvalueValues[r41]
                                                                r6 = upvalueValues[r44]
                                                                r31 = 22569604163853
                                                                r2 = "\150Ll\176\231q\204\154i\158,\235\137\014C,8'\254n\146\160\136\231\214\165J\016G\250~\202\162\235\223\195s\159\207\134\006\022\209m\242\249\026;\208cK\150\130\172\143\157\153\163;\211o\204\193\223\031\180oj\178L:\005\235\189\137\026\253\245\189S\005\212\218\163\011\200C\149e\219K\134b\002\135(\241UK6\001\250\170\130p\177\018@\213\243~N$lVH_\001\149\171\135"
                                                                r32 = r6(r2, r31)
                                                                r22 = r35[r32]
                                                                r35 = allocUpvalue()
                                                                upvalueValues[r35] = r22
                                                                r32 = upvalueValues[r41]
                                                                r2 = upvalueValues[r44]
                                                                r40 = 1474916860590
                                                                r7 = "\002\133\138\197\179`\020"
                                                                r31 = r2(r7, r40)
                                                                r6 = r32[r31]
                                                                r2 = upvalueValues[r41]
                                                                r31 = upvalueValues[r44]
                                                                r51 = 15706323410065
                                                                r40 = "\157N\143\161!\142_\020\194"
                                                                r7 = r31(r40, r51)
                                                                r32 = r2[r7]
                                                                r31 = upvalueValues[r41]
                                                                r7 = upvalueValues[r44]
                                                                r47 = 6239924718425
                                                                r51 = "\241\182vBZ\230\240\008"
                                                                r40 = r7(r51, r47)
                                                                r2 = r31[r40]
                                                                r7 = upvalueValues[r41]
                                                                r40 = upvalueValues[r44]
                                                                r15 = 30906643249208
                                                                r47 = "RX\242\002\201\253<XZ"
                                                                r51 = r40(r47, r15)
                                                                r31 = r7[r51]
                                                                r40 = upvalueValues[r41]
                                                                r51 = upvalueValues[r44]
                                                                r27 = 24060803099588
                                                                r15 = ".\005\242P\219\024\007E\212"
                                                                r47 = r51(r15, r27)
                                                                r7 = r40[r47]
                                                                r51 = upvalueValues[r41]
                                                                r47 = upvalueValues[r44]
                                                                r46 = 2045519807416
                                                                r27 = "\\\146\127n\215\138\232\210"
                                                                r15 = r47(r27, r46)
                                                                r40 = r51[r15]
                                                                r47 = upvalueValues[r41]
                                                                r15 = upvalueValues[r44]
                                                                r46 = "$\\1\246\175&m"
                                                                r27 = r15(r46, r45)
                                                                r51 = r47[r27]
                                                                r45 = "1-t\203\158\232\002\139\220"
                                                                r15 = upvalueValues[r41]
                                                                r27 = upvalueValues[r44]
                                                                r17 = 18137471033597
                                                                r46 = r27(r45, r17)
                                                                r47 = r15[r46]
                                                                r27 = upvalueValues[r41]
                                                                r46 = upvalueValues[r44]
                                                                r37 = 29250642015540
                                                                r17 = "12\003\028\202N\000\197\184"
                                                                r45 = r46(r17, r37)
                                                                r15 = r27[r45]
                                                                r46 = upvalueValues[r41]
                                                                r45 = upvalueValues[r44]
                                                                r39 = 2444698322034
                                                                r37 = "4\197\145@2nN\241p\219@\245\230="
                                                                r17 = r45(r37, r39)
                                                                r27 = r46[r17]
                                                                r45 = upvalueValues[r41]
                                                                r17 = upvalueValues[r44]
                                                                r42 = 33081133775916
                                                                r39 = "\139/Z\023"
                                                                r37 = r17(r39, r42)
                                                                r46 = r45[r37]
                                                                r17 = upvalueValues[r41]
                                                                r37 = upvalueValues[r44]
                                                                r30 = 5431768156641
                                                                r42 = "N\243+\029"
                                                                r39 = r37(r42, r30)
                                                                r45 = r17[r39]
                                                                r22 = {
                                                                    r6,
                                                                    r32,
                                                                    r2,
                                                                    r31,
                                                                    r7,
                                                                    r40,
                                                                    r51,
                                                                    r47,
                                                                    r15,
                                                                    r27,
                                                                    r46,
                                                                    r45
                                                                }
                                                                r6 = allocUpvalue()
                                                                r32 = allocUpvalue()
                                                                r2 = allocUpvalue()
                                                                upvalueValues[r6] = r22
                                                                r47 = createClosure6(66, {
                                                                    r41,
                                                                    r44
                                                                })
                                                                r40 = createClosure3(69, {
                                                                    r41,
                                                                    r44
                                                                })
                                                                r22 = 10
                                                                upvalueValues[r32] = r22
                                                                r31 = allocUpvalue()
                                                                r22 = 40
                                                                upvalueValues[r2] = r22
                                                                r22 = {}
                                                                upvalueValues[r31] = r22
                                                                r7 = allocUpvalue()
                                                                r22 = nil
                                                                upvalueValues[r7] = r22
                                                                r22 = allocUpvalue()
                                                                r15 = createClosure3(72, {
                                                                    r41,
                                                                    r44
                                                                })
                                                                upvalueValues[r22] = r40
                                                                r40 = allocUpvalue()
                                                                r51 = createClosure1(75, {
                                                                    r41,
                                                                    r44,
                                                                    r6
                                                                })
                                                                upvalueValues[r40] = r51
                                                                r51 = allocUpvalue()
                                                                upvalueValues[r51] = r47
                                                                r47 = allocUpvalue()
                                                                r27 = createClosure3(81, {
                                                                    r51,
                                                                    r32
                                                                })
                                                                r21 = createClosure3(84, {
                                                                    r7,
                                                                    r41,
                                                                    r44
                                                                })
                                                                upvalueValues[r47] = r15
                                                                r15 = allocUpvalue()
                                                                upvalueValues[r15] = r27
                                                                r46 = createClosure3(91, {
                                                                    r47,
                                                                    r2
                                                                })
                                                                r27 = allocUpvalue()
                                                                upvalueValues[r27] = r46
                                                                r45 = createClosure3(94, {
                                                                    r40,
                                                                    r15,
                                                                    r27
                                                                })
                                                                r6 = releaseUpvalue(r6)
                                                                r46 = allocUpvalue()
                                                                upvalueValues[r46] = r45
                                                                r37 = upvalueValues[r41]
                                                                r39 = upvalueValues[r44]
                                                                r11 = 7605030637013
                                                                r30 = "\168\239\189X\185\163\251\219gha"
                                                                r42 = r39(r30, r11)
                                                                r17 = r37[r42]
                                                                r39 = upvalueValues[r41]
                                                                r42 = upvalueValues[r44]
                                                                r48 = 3567222310525
                                                                r11 = "\252\127=\240\246m\226\129\248\249\238\183"
                                                                r30 = r42(r11, r48)
                                                                r37 = r39[r30]
                                                                r45 = {
                                                                    r17,
                                                                    r37
                                                                }
                                                                r37 = allocUpvalue()
                                                                r17 = allocUpvalue()
                                                                r51 = releaseUpvalue(r51)
                                                                r39 = createClosure0(99, {
                                                                    r17,
                                                                    r8,
                                                                    r34,
                                                                    r41,
                                                                    r44
                                                                })
                                                                upvalueValues[r17] = r45
                                                                r42 = createClosure4(109, {
                                                                    r41,
                                                                    r44,
                                                                    r24,
                                                                    r34,
                                                                    r25
                                                                })
                                                                r48 = createClosure4(120, {
                                                                    r31,
                                                                    r41,
                                                                    r44
                                                                })
                                                                upvalueValues[r37] = r39
                                                                r30 = createClosure1(128, {
                                                                    r50,
                                                                    r22,
                                                                    r41,
                                                                    r44,
                                                                    r46,
                                                                    r37,
                                                                    r34,
                                                                    r17,
                                                                    r38,
                                                                    r35
                                                                })
                                                                r45 = createClosure3(155, {
                                                                    r24,
                                                                    r41,
                                                                    r44,
                                                                    r34
                                                                })
                                                                r11 = createClosure4(166, {
                                                                    r8,
                                                                    r34,
                                                                    r41,
                                                                    r44,
                                                                    r31
                                                                })
                                                                r39 = allocUpvalue()
                                                                r27 = releaseUpvalue(r27)
                                                                upvalueValues[r39] = r42
                                                                r35 = releaseUpvalue(r35)
                                                                r42 = allocUpvalue()
                                                                upvalueValues[r42] = r30
                                                                r30 = allocUpvalue()
                                                                upvalueValues[r30] = r11
                                                                r11 = allocUpvalue()
                                                                ReturnVal = {}
                                                                upvalueValues[r11] = r48
                                                                r49 = createClosure4(176, {
                                                                    r11,
                                                                    r37,
                                                                    r31,
                                                                    r41,
                                                                    r44
                                                                })
                                                                r48 = allocUpvalue()
                                                                upvalueValues[r48] = r49
                                                                r49 = allocUpvalue()
                                                                upvalueValues[r49] = r21
                                                                r31 = releaseUpvalue(r31)
                                                                r1 = "task"
                                                                r20 = _env[r1]
                                                                r26 = upvalueValues[r41]
                                                                r3 = upvalueValues[r44]
                                                                r11 = releaseUpvalue(r11)
                                                                r8 = releaseUpvalue(r8)
                                                                r37 = releaseUpvalue(r37)
                                                                r23 = 18255517786420
                                                                r36 = "\242H\134\023o"
                                                                r19 = r3(r36, r23)
                                                                r1 = r26[r19]
                                                                r21 = r20[r1]
                                                                r1 = createClosure5(181, {
                                                                    r24,
                                                                    r41,
                                                                    r44,
                                                                    r34,
                                                                    r25
                                                                })
                                                                r20 = r21(r1)
                                                                r20 = createClosure2(192, {
                                                                    r16,
                                                                    r41,
                                                                    r44,
                                                                    r50,
                                                                    r22,
                                                                    r52
                                                                })
                                                                r24 = releaseUpvalue(r24)
                                                                r1 = allocUpvalue()
                                                                r21 = allocUpvalue()
                                                                upvalueValues[r21] = r20
                                                                r2 = releaseUpvalue(r2)
                                                                r26 = createClosure1(217, {
                                                                    r21,
                                                                    r50,
                                                                    r22,
                                                                    r46,
                                                                    r41,
                                                                    r44
                                                                })
                                                                r20 = createClosure2(230, {
                                                                    r50,
                                                                    r22,
                                                                    r41,
                                                                    r44
                                                                })
                                                                upvalueValues[r1] = r26
                                                                r19 = "task"
                                                                r3 = _env[r19]
                                                                r46 = releaseUpvalue(r46)
                                                                r36 = upvalueValues[r41]
                                                                r23 = upvalueValues[r44]
                                                                r10 = "\207(\197\019\224"
                                                                r5 = 28984306676920
                                                                r13 = r23(r10, r5)
                                                                r19 = r36[r13]
                                                                r26 = r3[r19]
                                                                r19 = createClosure0(241, {
                                                                    r41,
                                                                    r44
                                                                })
                                                                r50 = releaseUpvalue(r50)
                                                                r3 = r26(r19)
                                                                r32 = releaseUpvalue(r32)
                                                                r5 = 18982268723847
                                                                r10 = "\249\229_(T"
                                                                r20 = nil
                                                                r19 = "task"
                                                                r45 = nil
                                                                r3 = _env[r19]
                                                                r36 = upvalueValues[r41]
                                                                r17 = releaseUpvalue(r17)
                                                                r23 = upvalueValues[r44]
                                                                r16 = releaseUpvalue(r16)
                                                                r13 = r23(r10, r5)
                                                                r19 = r36[r13]
                                                                r38 = releaseUpvalue(r38)
                                                                r40 = releaseUpvalue(r40)
                                                                r22 = releaseUpvalue(r22)
                                                                r34 = releaseUpvalue(r34)
                                                                r26 = r3[r19]
                                                                r19 = createClosure0(244, {
                                                                    r39,
                                                                    r21,
                                                                    r42,
                                                                    r30,
                                                                    r41,
                                                                    r44,
                                                                    r49,
                                                                    r48,
                                                                    r7,
                                                                    r52,
                                                                    r43,
                                                                    r18,
                                                                    r1
                                                                })
                                                                r30 = releaseUpvalue(r30)
                                                                r7 = releaseUpvalue(r7)
                                                                r15 = releaseUpvalue(r15)
                                                                r39 = releaseUpvalue(r39)
                                                                r48 = releaseUpvalue(r48)
                                                                r25 = releaseUpvalue(r25)
                                                                r21 = releaseUpvalue(r21)
                                                                r18 = releaseUpvalue(r18)
                                                                r47 = releaseUpvalue(r47)
                                                                r3 = r26(r19)
                                                                r43 = releaseUpvalue(r43)
                                                                r52 = releaseUpvalue(r52)
                                                                r41 = releaseUpvalue(r41)
                                                                r42 = releaseUpvalue(r42)
                                                                r44 = releaseUpvalue(r44)
                                                                r1 = releaseUpvalue(r1)
                                                                r49 = releaseUpvalue(r49)
                                                                state = nil
                                                            end
                                                        else
                                                            if state == 33 then
                                                                r25 = upvalueValues[r34]
                                                                r22 = upvalueValues[r41]
                                                                r35 = upvalueValues[r44]
                                                                r2 = 31125096134813
                                                                r32 = "\138\199\170\159\023 \2540;a\178\2272\""
                                                                r6 = r35(r32, r2)
                                                                r43 = r22[r6]
                                                                r24 = r25[r43]
                                                                r25 = "Wait"
                                                                r25 = r24[r25]
                                                                r25 = r25(r24)
                                                                r18 = r25
                                                                state = 32
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure4 entry 16408476 -> 34, states 34-34
                                        if state == 34 then -- entry 16408476 -> 34
                                            ReturnVal = "error"
                                            state = _env[ReturnVal]
                                            r28 = "Tamper Detected!"
                                            ReturnVal = state(r28)
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure3 entry 1632427 -> 35, states 35-35
                                    if state == 35 then -- entry 1632427 -> 35
                                        state = true
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                if state <= 48 then
                                    if state <= 36 then
                                        -- createClosure2 entry 7102788 -> 36, states 36-36
                                        if state == 36 then -- entry 7102788 -> 36
                                            r41 = "ndl"
                                            r38 = 12456462
                                            r28 = r41 ^ r38
                                            ReturnVal = 11475092
                                            state = ReturnVal - r28
                                            r28 = state
                                            ReturnVal = "103Rwzj"
                                            state = ReturnVal / r28
                                            ReturnVal = {
                                                state
                                            }
                                            state = nil
                                        end
                                    else
                                        -- createClosure4 entry 5941751 -> 37, states 37-48
                                        if state <= 42 then
                                            if state <= 39 then
                                                if state <= 38 then
                                                    if state <= 37 then
                                                        if state == 37 then -- entry 5941751 -> 37
                                                            r41 = upvalueValues[upvalues[1]]
                                                            r44 = 1
                                                            r8 = 2
                                                            r38 = r41(r44, r8)
                                                            r41 = 1
                                                            r28 = r38 == r41
                                                            state = r28 and (38) or (39)
                                                            ReturnVal = r28
                                                        end
                                                    else
                                                        if state == 38 then
                                                            state = ReturnVal and (40) or (41)
                                                        end
                                                    end
                                                else
                                                    if state == 39 then
                                                        r41 = upvalueValues[upvalues[2]]
                                                        r38 = upvalueValues[upvalues[3]]
                                                        r28 = r41 == r38
                                                        ReturnVal = r28
                                                        state = 38
                                                    end
                                                end
                                            else
                                                if state <= 41 then
                                                    if state <= 40 then
                                                        if state == 40 then
                                                            r18 = createClosure1(265, {})
                                                            ReturnVal = "tonumber"
                                                            state = _env[ReturnVal]
                                                            r28 = upvalueValues[upvalues[4]]
                                                            r44 = "tostring"
                                                            r38 = _env[r44]
                                                            r34 = "pcall"
                                                            r50 = _env[r34]
                                                            r34 = {
                                                                r50(r18)
                                                            }
                                                            r16 = {
                                                                unpack(r34)
                                                            }
                                                            r50 = 2
                                                            r8 = r16[r50]
                                                            r44 = r38(r8)
                                                            r38 = ":(%d*):"
                                                            r41 = r28(r44, r38)
                                                            r28 = {
                                                                r41()
                                                            }
                                                            ReturnVal = state(unpack(r28))
                                                            r28 = ReturnVal
                                                            r41 = upvalueValues[upvalues[5]]
                                                            state = r41 and (42) or (43)
                                                            ReturnVal = r41
                                                        end
                                                    else
                                                        if state == 41 then
                                                            state = upvalueValues[upvalues[7]]
                                                            state = state and (44) or (45)
                                                        end
                                                    end
                                                else
                                                    if state == 42 then
                                                        r38 = upvalueValues[upvalues[6]]
                                                        r41 = r38 == r28
                                                        ReturnVal = r41
                                                        state = 43
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 45 then
                                                if state <= 44 then
                                                    if state <= 43 then
                                                        if state == 43 then
                                                            r28 = nil
                                                            upvalueValues[upvalues[5]] = ReturnVal
                                                            state = 41
                                                        end
                                                    else
                                                        if state == 44 then
                                                            r28 = "error"
                                                            state = _env[r28]
                                                            r41 = upvalueValues[upvalues[8]]
                                                            r38 = 0
                                                            r28 = state(r41, r38)
                                                            state = 45
                                                        end
                                                    end
                                                else
                                                    if state == 45 then
                                                        r38 = upvalueValues[upvalues[9]]
                                                        r44 = r38
                                                        state = {}
                                                        r28 = state
                                                        r38 = 1
                                                        r8 = r38
                                                        r38 = 0
                                                        r16 = r8 < r38
                                                        r41 = 1
                                                        r38 = r41 - r8
                                                        state = 46
                                                    end
                                                end
                                            else
                                                if state <= 47 then
                                                    if state <= 46 then
                                                        if state == 46 then
                                                            r50 = not r16
                                                            r38 = r38 + r8
                                                            r41 = r38 <= r44
                                                            r41 = r50 and r41
                                                            r50 = r38 >= r44
                                                            r50 = r16 and r50
                                                            r41 = r50 or r41
                                                            r50 = (47)
                                                            state = r41 and r50
                                                            r41 = (48)
                                                            state = state or r41
                                                        end
                                                    else
                                                        if state == 47 then
                                                            state = upvalueValues[upvalues[1]]
                                                            r41 = r38
                                                            r34 = 0
                                                            r18 = 255
                                                            r50 = state(r34, r18)
                                                            r28[r41] = r50
                                                            r41 = nil
                                                            state = 46
                                                        end
                                                    end
                                                else
                                                    if state == 48 then
                                                        state = upvalueValues[upvalues[10]]
                                                        r41 = upvalueValues[upvalues[11]]
                                                        r28[state] = r41
                                                        state = upvalueValues[upvalues[12]]
                                                        r41 = {
                                                            state(r28)
                                                        }
                                                        ReturnVal = {
                                                            unpack(r41)
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure4 entry 16480158 -> 49, states 49-52
                                    if state <= 50 then
                                        if state <= 49 then
                                            if state == 49 then -- entry 16480158 -> 49
                                                state = 50
                                            end
                                        else
                                            if state == 50 then
                                                state = true
                                                state = state and (51) or (52)
                                            end
                                        end
                                    else
                                        if state <= 51 then
                                            if state == 51 then
                                                ReturnVal = "l2"
                                                state = _env[ReturnVal]
                                                r28 = "l1"
                                                ReturnVal = _env[r28]
                                                r28 = "l1"
                                                _env[r28] = state
                                                r28 = "l2"
                                                _env[r28] = ReturnVal
                                                r28 = upvalueValues[upvalues[1]]
                                                r41 = r28()
                                                state = 50
                                            end
                                        else
                                            if state == 52 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 68 then
                                if state <= 65 then
                                    if state <= 58 then
                                        -- createClosure3 entry 9333125 -> 53, states 53-58
                                        if state <= 55 then
                                            if state <= 54 then
                                                if state <= 53 then
                                                    if state == 53 then -- entry 9333125 -> 53
                                                        r28 = upvalueValues[upvalues[1]]
                                                        ReturnVal = #r28
                                                        r28 = 0
                                                        state = ReturnVal == r28
                                                        state = state and (54) or (55)
                                                    end
                                                else
                                                    if state == 54 then
                                                        r41 = upvalueValues[upvalues[2]]
                                                        r38 = 21
                                                        r28 = r41 * r38
                                                        r41 = 3648708953763
                                                        ReturnVal = r28 + r41
                                                        r28 = 35184372088832
                                                        state = ReturnVal % r28
                                                        upvalueValues[upvalues[2]] = state
                                                        r28 = upvalueValues[upvalues[3]]
                                                        r41 = 1
                                                        ReturnVal = r28 ~= r41
                                                        state = 56
                                                    end
                                                end
                                            else
                                                if state == 55 then
                                                    r38 = "table"
                                                    r41 = _env[r38]
                                                    r38 = "remove"
                                                    r28 = r41[r38]
                                                    r38 = upvalueValues[upvalues[1]]
                                                    r41 = {
                                                        r28(r38)
                                                    }
                                                    ReturnVal = {
                                                        unpack(r41)
                                                    }
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state <= 57 then
                                                if state <= 56 then
                                                    if state == 56 then
                                                        r41 = upvalueValues[upvalues[3]]
                                                        r38 = 164
                                                        r28 = r41 * r38
                                                        r41 = 257
                                                        ReturnVal = r28 % r41
                                                        upvalueValues[upvalues[3]] = ReturnVal
                                                        state = 57
                                                    end
                                                else
                                                    if state == 57 then
                                                        r41 = upvalueValues[upvalues[3]]
                                                        r38 = 1
                                                        r28 = r41 ~= r38
                                                        state = r28 and (58) or (56)
                                                    end
                                                end
                                            else
                                                if state == 58 then
                                                    r18 = 2
                                                    r41 = upvalueValues[upvalues[3]]
                                                    r38 = 32
                                                    r28 = r41 % r38
                                                    r44 = upvalueValues[upvalues[4]]
                                                    r50 = upvalueValues[upvalues[2]]
                                                    r22 = upvalueValues[upvalues[3]]
                                                    r43 = r22 - r28
                                                    r22 = 32
                                                    r25 = r43 / r22
                                                    r24 = 13
                                                    r52 = r24 - r25
                                                    r34 = r18 ^ r52
                                                    r16 = r50 / r34
                                                    r8 = r44(r16)
                                                    r44 = 4294967296
                                                    r38 = r8 % r44
                                                    r8 = 2
                                                    r44 = r8 ^ r28
                                                    r18 = 256
                                                    r41 = r38 / r44
                                                    r34 = 1
                                                    r44 = upvalueValues[upvalues[4]]
                                                    r50 = r41 % r34
                                                    r34 = 4294967296
                                                    r16 = r50 * r34
                                                    r8 = r44(r16)
                                                    r44 = upvalueValues[upvalues[4]]
                                                    r16 = r44(r41)
                                                    r38 = r8 + r16
                                                    r24 = 256
                                                    r41 = nil
                                                    r8 = 65536
                                                    r50 = 65536
                                                    r44 = r38 % r8
                                                    r16 = r38 - r44
                                                    r8 = r16 / r50
                                                    r38 = nil
                                                    r50 = 256
                                                    r16 = r44 % r50
                                                    r34 = r44 - r16
                                                    r50 = r34 / r18
                                                    r28 = nil
                                                    r18 = 256
                                                    r34 = r8 % r18
                                                    r52 = r8 - r34
                                                    r8 = nil
                                                    r18 = r52 / r24
                                                    r52 = {
                                                        r16,
                                                        r50,
                                                        r34,
                                                        r18
                                                    }
                                                    upvalueValues[upvalues[1]] = r52
                                                    r18 = nil
                                                    r34 = nil
                                                    r44 = nil
                                                    r16 = nil
                                                    r50 = nil
                                                    state = 55
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure7 entry 1961921 -> 59, states 59-65
                                        if state <= 62 then
                                            if state <= 60 then
                                                if state <= 59 then
                                                    if state == 59 then -- entry 1961921 -> 59
                                                        state = upvalueValues[upvalues[1]]
                                                        r38 = state
                                                        r28 = args[1]
                                                        r41 = args[2]
                                                        state = r38[r41]
                                                        state = state and (60) or (61)
                                                    end
                                                else
                                                    if state == 60 then
                                                        state = 62
                                                    end
                                                end
                                            else
                                                if state <= 61 then
                                                    if state == 61 then
                                                        state = {}
                                                        upvalueValues[upvalues[2]] = state
                                                        ReturnVal = upvalueValues[upvalues[3]]
                                                        r44 = ReturnVal
                                                        r8 = 35184372088832
                                                        ReturnVal = r41 % r8
                                                        upvalueValues[upvalues[4]] = ReturnVal
                                                        r50 = 255
                                                        r16 = r41 % r50
                                                        r50 = 2
                                                        r8 = r16 + r50
                                                        upvalueValues[upvalues[5]] = r8
                                                        r34 = "string"
                                                        r50 = _env[r34]
                                                        r34 = "len"
                                                        r16 = r50[r34]
                                                        r50 = r16(r28)
                                                        r52 = 1
                                                        r24 = r52
                                                        r16 = ""
                                                        r38[r41] = r16
                                                        r52 = 0
                                                        r25 = r24 < r52
                                                        r34 = 1
                                                        r52 = r34 - r24
                                                        r18 = r50
                                                        r16 = 136
                                                        state = 63
                                                    end
                                                else
                                                    if state == 62 then
                                                        ReturnVal = {
                                                            r41
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 64 then
                                                if state <= 63 then
                                                    if state == 63 then
                                                        r43 = not r25
                                                        r52 = r52 + r24
                                                        r34 = r52 <= r18
                                                        r34 = r43 and r34
                                                        r43 = r52 >= r18
                                                        r43 = r25 and r43
                                                        r34 = r43 or r34
                                                        r43 = (64)
                                                        state = r34 and r43
                                                        r34 = (65)
                                                        state = state or r34
                                                    end
                                                else
                                                    if state == 64 then
                                                        r34 = r52
                                                        r4 = "string"
                                                        r9 = _env[r4]
                                                        r4 = "byte"
                                                        r12 = r9[r4]
                                                        r9 = r12(r28, r34)
                                                        r12 = upvalueValues[upvalues[6]]
                                                        r4 = r12()
                                                        r35 = r9 + r4
                                                        r22 = r35 + r16
                                                        r35 = 256
                                                        r43 = r22 % r35
                                                        r16 = r43
                                                        r4 = 1
                                                        r34 = nil
                                                        r35 = r38[r41]
                                                        r9 = r16 + r4
                                                        r12 = r44[r9]
                                                        r22 = r35 .. r12
                                                        r38[r41] = r22
                                                        state = 63
                                                    end
                                                end
                                            else
                                                if state == 65 then
                                                    r44 = nil
                                                    r50 = nil
                                                    r16 = nil
                                                    state = 62
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure6 entry 1629161 -> 66, states 66-68
                                    if state <= 67 then
                                        if state <= 66 then
                                            if state == 66 then -- entry 1629161 -> 66
                                                r28 = args[1]
                                                r41 = "string"
                                                ReturnVal = _env[r41]
                                                r38 = upvalueValues[upvalues[1]]
                                                r44 = upvalueValues[upvalues[2]]
                                                r16 = "\147\248\245'N"
                                                r50 = 23593472207594
                                                r8 = r44(r16, r50)
                                                r41 = r38[r8]
                                                state = ReturnVal[r41]
                                                r38 = upvalueValues[upvalues[1]]
                                                r44 = upvalueValues[upvalues[2]]
                                                r50 = 3852300158721
                                                r16 = "\182\r\184!\135\148\215\211\224\241\210\030\192nA\154"
                                                r8 = r44(r16, r50)
                                                r41 = r38[r8]
                                                ReturnVal = state(r28, r41)
                                                r41 = ReturnVal
                                                state = r41 and (67) or (68)
                                            end
                                        else
                                            if state == 67 then
                                                ReturnVal = "tonumber"
                                                state = _env[ReturnVal]
                                                ReturnVal = {
                                                    state(r41)
                                                }
                                                ReturnVal = {
                                                    unpack(ReturnVal)
                                                }
                                                state = nil
                                            end
                                        end
                                    else
                                        if state == 68 then
                                            state = nil
                                            ReturnVal = {
                                                state
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            else
                                if state <= 71 then
                                    -- createClosure3 entry 677546 -> 69, states 69-71
                                    if state <= 70 then
                                        if state <= 69 then
                                            if state == 69 then -- entry 677546 -> 69
                                                r28 = args[1]
                                                r44 = upvalueValues[upvalues[1]]
                                                r8 = upvalueValues[upvalues[2]]
                                                r34 = 5379846916553
                                                r50 = "\028\140\023\195"
                                                r16 = r8(r50, r34)
                                                r41 = "IsA"
                                                r41 = r28[r41]
                                                r38 = r44[r16]
                                                r41 = r41(r28, r38)
                                                state = r41 and (70) or (71)
                                                ReturnVal = r41
                                            end
                                        else
                                            if state == 70 then
                                                r8 = upvalueValues[upvalues[1]]
                                                r16 = upvalueValues[upvalues[2]]
                                                r38 = "GetAttribute"
                                                r38 = r28[r38]
                                                r34 = "\018Q\172\128\0147\187'"
                                                r18 = 13762453739784
                                                r50 = r16(r34, r18)
                                                r44 = r8[r50]
                                                r38 = r38(r28, r44)
                                                r8 = upvalueValues[upvalues[1]]
                                                r16 = upvalueValues[upvalues[2]]
                                                r18 = 9080477110404
                                                r34 = "\026\253\015"
                                                r50 = r16(r34, r18)
                                                r44 = r8[r50]
                                                r41 = r38 == r44
                                                ReturnVal = r41
                                                state = 71
                                            end
                                        end
                                    else
                                        if state == 71 then
                                            ReturnVal = {
                                                ReturnVal
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure3 entry 4958114 -> 72, states 72-74
                                    if state <= 73 then
                                        if state <= 72 then
                                            if state == 72 then -- entry 4958114 -> 72
                                                r41 = "string"
                                                ReturnVal = _env[r41]
                                                r38 = upvalueValues[upvalues[1]]
                                                r28 = args[1]
                                                r44 = upvalueValues[upvalues[2]]
                                                r16 = "\157\251\2138o"
                                                r50 = 7626498280927
                                                r8 = r44(r16, r50)
                                                r41 = r38[r8]
                                                state = ReturnVal[r41]
                                                r38 = upvalueValues[upvalues[1]]
                                                r44 = upvalueValues[upvalues[2]]
                                                r50 = 11635524031786
                                                r16 = "\188\176\132\191\150a\206\016\191\014\017\220\212"
                                                r8 = r44(r16, r50)
                                                r41 = r38[r8]
                                                ReturnVal = state(r28, r41)
                                                r41 = ReturnVal
                                                state = r41 and (73) or (74)
                                            end
                                        else
                                            if state == 73 then
                                                ReturnVal = "tonumber"
                                                state = _env[ReturnVal]
                                                ReturnVal = {
                                                    state(r41)
                                                }
                                                ReturnVal = {
                                                    unpack(ReturnVal)
                                                }
                                                state = nil
                                            end
                                        end
                                    else
                                        if state == 74 then
                                            state = nil
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
                        if state <= 98 then
                            if state <= 90 then
                                if state <= 83 then
                                    if state <= 80 then
                                        -- createClosure1 entry 648391 -> 75, states 75-80
                                        if state <= 77 then
                                            if state <= 76 then
                                                if state <= 75 then
                                                    if state == 75 then -- entry 648391 -> 75
                                                        r28 = args[1]
                                                        r41 = "string"
                                                        ReturnVal = _env[r41]
                                                        r38 = upvalueValues[upvalues[1]]
                                                        r44 = upvalueValues[upvalues[2]]
                                                        r50 = 24199506373636
                                                        r16 = "\017\182\152-`"
                                                        r8 = r44(r16, r50)
                                                        r41 = r38[r8]
                                                        state = ReturnVal[r41]
                                                        ReturnVal = state(r28)
                                                        r41 = ReturnVal
                                                        ReturnVal = "ipairs"
                                                        state = _env[ReturnVal]
                                                        r8 = upvalueValues[upvalues[3]]
                                                        r16 = {
                                                            state(r8)
                                                        }
                                                        ReturnVal = r16[1]
                                                        r44 = r16[3]
                                                        r38 = r16[2]
                                                        r8 = ReturnVal
                                                        state = 76
                                                    end
                                                else
                                                    if state == 76 then
                                                        r44, r50 = r8(r38, r44)
                                                        state = r44 and (77) or (78)
                                                    end
                                                end
                                            else
                                                if state == 77 then
                                                    r52 = "string"
                                                    r18 = _env[r52]
                                                    r24 = upvalueValues[upvalues[1]]
                                                    r25 = upvalueValues[upvalues[2]]
                                                    r22 = "\221Ny"
                                                    r35 = 11935082108341
                                                    r43 = r25(r22, r35)
                                                    r52 = r24[r43]
                                                    r34 = r18[r52]
                                                    r24 = #r50
                                                    r52 = 1
                                                    r18 = r34(r41, r52, r24)
                                                    state = r18 == r50
                                                    state = state and (79) or (80)
                                                    r16 = r44
                                                end
                                            end
                                        else
                                            if state <= 79 then
                                                if state <= 78 then
                                                    if state == 78 then
                                                        state = false
                                                        ReturnVal = {
                                                            state
                                                        }
                                                        state = nil
                                                    end
                                                else
                                                    if state == 79 then
                                                        state = true
                                                        ReturnVal = {
                                                            state
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state == 80 then
                                                    r50 = nil
                                                    r16 = nil
                                                    state = 76
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure3 entry 11636235 -> 81, states 81-83
                                        if state <= 82 then
                                            if state <= 81 then
                                                if state == 81 then -- entry 11636235 -> 81
                                                    state = upvalueValues[upvalues[1]]
                                                    r28 = args[1]
                                                    ReturnVal = state(r28)
                                                    r41 = ReturnVal
                                                    state = r41 and (82) or (83)
                                                    ReturnVal = r41
                                                end
                                            else
                                                if state == 82 then
                                                    r44 = upvalueValues[upvalues[2]]
                                                    r38 = r41 >= r44
                                                    ReturnVal = r38
                                                    state = 83
                                                end
                                            end
                                        else
                                            if state == 83 then
                                                ReturnVal = {
                                                    ReturnVal
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure3 entry 9647039 -> 84, states 84-90
                                    if state <= 87 then
                                        if state <= 85 then
                                            if state <= 84 then
                                                if state == 84 then -- entry 9647039 -> 84
                                                    r28 = upvalueValues[upvalues[1]]
                                                    state = r28 and (85) or (86)
                                                    ReturnVal = r28
                                                end
                                            else
                                                if state == 85 then
                                                    r41 = state
                                                    r44 = upvalueValues[upvalues[1]]
                                                    r16 = upvalueValues[upvalues[2]]
                                                    r50 = upvalueValues[upvalues[3]]
                                                    r52 = 6973746482351
                                                    r18 = "\158\131\141\217\185U"
                                                    r34 = r50(r18, r52)
                                                    r8 = r16[r34]
                                                    r38 = r44[r8]
                                                    state = r38 and (87) or (88)
                                                    r28 = r38
                                                end
                                            end
                                        else
                                            if state <= 86 then
                                                if state == 86 then
                                                    ReturnVal = {
                                                        ReturnVal
                                                    }
                                                    state = nil
                                                end
                                            else
                                                if state == 87 then
                                                    r16 = upvalueValues[upvalues[1]]
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r18 = upvalueValues[upvalues[3]]
                                                    r25 = 28891348219021
                                                    r24 = "\155\000yz\201\197\235\014\\"
                                                    r52 = r18(r24, r25)
                                                    r50 = r34[r52]
                                                    r8 = r16[r50]
                                                    r44 = state
                                                    state = r8 and (89) or (90)
                                                    r38 = r8
                                                end
                                            end
                                        end
                                    else
                                        if state <= 89 then
                                            if state <= 88 then
                                                if state == 88 then
                                                    state = r41
                                                    ReturnVal = r28
                                                    state = 86
                                                end
                                            else
                                                if state == 89 then
                                                    r16 = "workspace"
                                                    r8 = _env[r16]
                                                    r34 = upvalueValues[upvalues[1]]
                                                    r52 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r22 = 621049626913
                                                    r43 = "?\129em"
                                                    r25 = r24(r43, r22)
                                                    r16 = "FindFirstChild"
                                                    r16 = r8[r16]
                                                    r18 = r52[r25]
                                                    r50 = r34[r18]
                                                    r16 = r16(r8, r50)
                                                    r38 = r16
                                                    state = 90
                                                end
                                            end
                                        else
                                            if state == 90 then
                                                state = r44
                                                r28 = r38
                                                state = 88
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 93 then
                                    -- createClosure3 entry 9603217 -> 91, states 91-93
                                    if state <= 92 then
                                        if state <= 91 then
                                            if state == 91 then -- entry 9603217 -> 91
                                                r28 = args[1]
                                                state = upvalueValues[upvalues[1]]
                                                ReturnVal = state(r28)
                                                r41 = ReturnVal
                                                state = r41 and (92) or (93)
                                                ReturnVal = r41
                                            end
                                        else
                                            if state == 92 then
                                                r44 = upvalueValues[upvalues[2]]
                                                r38 = r41 >= r44
                                                ReturnVal = r38
                                                state = 93
                                            end
                                        end
                                    else
                                        if state == 93 then
                                            ReturnVal = {
                                                ReturnVal
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure3 entry 5689257 -> 94, states 94-98
                                    if state <= 96 then
                                        if state <= 95 then
                                            if state <= 94 then
                                                if state == 94 then -- entry 5689257 -> 94
                                                    r28 = args[1]
                                                    r41 = upvalueValues[upvalues[1]]
                                                    r38 = r41(r28)
                                                    state = r38 and (95) or (96)
                                                    ReturnVal = r38
                                                end
                                            else
                                                if state == 95 then
                                                    ReturnVal = {
                                                        ReturnVal
                                                    }
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state == 96 then
                                                r38 = state
                                                r44 = upvalueValues[upvalues[2]]
                                                r8 = r44(r28)
                                                state = r8 and (97) or (98)
                                                r41 = r8
                                            end
                                        end
                                    else
                                        if state <= 97 then
                                            if state == 97 then
                                                state = r38
                                                ReturnVal = r41
                                                state = 95
                                            end
                                        else
                                            if state == 98 then
                                                r44 = upvalueValues[upvalues[3]]
                                                r8 = r44(r28)
                                                r41 = r8
                                                state = 97
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 127 then
                                if state <= 119 then
                                    if state <= 108 then
                                        -- createClosure0 entry 12651296 -> 99, states 99-108
                                        if state <= 103 then
                                            if state <= 101 then
                                                if state <= 100 then
                                                    if state <= 99 then
                                                        if state == 99 then -- entry 12651296 -> 99
                                                            ReturnVal = "ipairs"
                                                            state = _env[ReturnVal]
                                                            r38 = upvalueValues[upvalues[1]]
                                                            r44 = {
                                                                state(r38)
                                                            }
                                                            ReturnVal = r44[1]
                                                            r38 = ReturnVal
                                                            r41 = r44[3]
                                                            r28 = r44[2]
                                                            state = 100
                                                        end
                                                    else
                                                        if state == 100 then
                                                            r41, r8 = r38(r28, r41)
                                                            state = r41 and (101) or (102)
                                                        end
                                                    end
                                                else
                                                    if state == 101 then
                                                        state = upvalueValues[upvalues[2]]
                                                        r16 = "FindFirstChild"
                                                        r16 = state[r16]
                                                        r16 = r16(state, r8)
                                                        state = r16 and (103) or (104)
                                                        r44 = r41
                                                        r50 = r16
                                                    end
                                                end
                                            else
                                                if state <= 102 then
                                                    if state == 102 then
                                                        state = nil
                                                        ReturnVal = {
                                                            state
                                                        }
                                                        state = nil
                                                    end
                                                else
                                                    if state == 103 then
                                                        r18 = state
                                                        r24 = upvalueValues[upvalues[3]]
                                                        r52 = r16 ~= r24
                                                        state = r52 and (105) or (106)
                                                        r34 = r52
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 106 then
                                                if state <= 105 then
                                                    if state <= 104 then
                                                        if state == 104 then
                                                            state = r50 and (107) or (108)
                                                        end
                                                    else
                                                        if state == 105 then
                                                            r25 = upvalueValues[upvalues[4]]
                                                            r43 = upvalueValues[upvalues[5]]
                                                            r12 = 29402722071931
                                                            r35 = "\208\144&\128!\154\024\170g"
                                                            r22 = r43(r35, r12)
                                                            r24 = r25[r22]
                                                            r52 = r16[r24]
                                                            r34 = r52
                                                            state = 106
                                                        end
                                                    end
                                                else
                                                    if state == 106 then
                                                        state = r18
                                                        r50 = r34
                                                        state = 104
                                                    end
                                                end
                                            else
                                                if state <= 107 then
                                                    if state == 107 then
                                                        ReturnVal = {
                                                            r16
                                                        }
                                                        state = nil
                                                    end
                                                else
                                                    if state == 108 then
                                                        r44 = nil
                                                        r16 = nil
                                                        r8 = nil
                                                        state = 100
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure4 entry 6900956 -> 109, states 109-119
                                        if state <= 114 then
                                            if state <= 111 then
                                                if state <= 110 then
                                                    if state <= 109 then
                                                        if state == 109 then -- entry 6900956 -> 109
                                                            ReturnVal = "print"
                                                            state = _env[ReturnVal]
                                                            r41 = upvalueValues[upvalues[1]]
                                                            r38 = upvalueValues[upvalues[2]]
                                                            r16 = 18266784538938
                                                            r8 = "wY\238\012Xf\209\020\023\210\006b\249\243\172\147\026v\142\n`IH}\211])\r_z\197\147\246\187\029\199R7k\253\155\169h"
                                                            r44 = r38(r8, r16)
                                                            r28 = r41[r44]
                                                            ReturnVal = state(r28)
                                                            ReturnVal = "ipairs"
                                                            state = _env[ReturnVal]
                                                            r38 = upvalueValues[upvalues[3]]
                                                            r8 = "GetChildren"
                                                            r8 = r38[r8]
                                                            r44 = {
                                                                r8(r38)
                                                            }
                                                            r38 = {
                                                                state(unpack(r44))
                                                            }
                                                            ReturnVal = r38[1]
                                                            r41 = r38[3]
                                                            r28 = r38[2]
                                                            r38 = ReturnVal
                                                            state = 110
                                                        end
                                                    else
                                                        if state == 110 then
                                                            r41, r8 = r38(r28, r41)
                                                            state = r41 and (111) or (112)
                                                        end
                                                    end
                                                else
                                                    if state == 111 then
                                                        r34 = upvalueValues[upvalues[1]]
                                                        r18 = upvalueValues[upvalues[2]]
                                                        r24 = "V`y\231\030"
                                                        r25 = 16196313734517
                                                        r52 = r18(r24, r25)
                                                        r16 = "GetAttribute"
                                                        r16 = r8[r16]
                                                        r50 = r34[r52]
                                                        r16 = r16(r8, r50)
                                                        r34 = upvalueValues[upvalues[4]]
                                                        r52 = upvalueValues[upvalues[1]]
                                                        r24 = upvalueValues[upvalues[2]]
                                                        r43 = "\187\213\235\248"
                                                        r22 = 30877638932522
                                                        r25 = r24(r43, r22)
                                                        r18 = r52[r25]
                                                        r50 = r34[r18]
                                                        state = r16 == r50
                                                        state = state and (113) or (114)
                                                        r44 = r41
                                                    end
                                                end
                                            else
                                                if state <= 113 then
                                                    if state <= 112 then
                                                        if state == 112 then
                                                            ReturnVal = {}
                                                            r41 = "task"
                                                            r28 = _env[r41]
                                                            r38 = upvalueValues[upvalues[1]]
                                                            r44 = upvalueValues[upvalues[2]]
                                                            r16 = "\158\216oB"
                                                            r50 = 5802637888142
                                                            r8 = r44(r16, r50)
                                                            r41 = r38[r8]
                                                            state = r28[r41]
                                                            r41 = 2
                                                            r28 = state(r41)
                                                            r28 = "print"
                                                            state = _env[r28]
                                                            r38 = upvalueValues[upvalues[1]]
                                                            r44 = upvalueValues[upvalues[2]]
                                                            r50 = 18548028187069
                                                            r16 = "\028\191A\171\218\252\195'o\220\001\151\"\228\216\023{,\219\136\028\254\209A\255"
                                                            r8 = r44(r16, r50)
                                                            r41 = r38[r8]
                                                            r28 = state(r41)
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 113 then
                                                            r50 = upvalueValues[upvalues[1]]
                                                            state = "GetAttribute"
                                                            state = r8[state]
                                                            r34 = upvalueValues[upvalues[2]]
                                                            r52 = "\181\162\181\171"
                                                            r24 = 33973107949003
                                                            r18 = r34(r52, r24)
                                                            r16 = r50[r18]
                                                            state = state(r8, r16)
                                                            r16 = allocUpvalue()
                                                            upvalueValues[r16] = state
                                                            state = upvalueValues[r16]
                                                            state = state and (115) or (116)
                                                        end
                                                    end
                                                else
                                                    if state == 114 then
                                                        r8 = nil
                                                        r44 = nil
                                                        state = 110
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 117 then
                                                if state <= 116 then
                                                    if state <= 115 then
                                                        if state == 115 then
                                                            r18 = createClosure0(266, {
                                                                upvalues[5],
                                                                upvalues[1],
                                                                upvalues[2],
                                                                r16
                                                            })
                                                            r50 = "pcall"
                                                            state = _env[r50]
                                                            r52 = {
                                                                state(r18)
                                                            }
                                                            r50 = r52[1]
                                                            state = r50 and (117) or (118)
                                                            r34 = r52[2]
                                                        end
                                                    else
                                                        if state == 116 then
                                                            r16 = releaseUpvalue(r16)
                                                            state = 114
                                                        end
                                                    end
                                                else
                                                    if state == 117 then
                                                        r18 = "print"
                                                        state = _env[r18]
                                                        r24 = upvalueValues[upvalues[1]]
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r22 = "\201k\213\007\135\1817\249\203\201\130\248\138$"
                                                        r35 = 26599910076514
                                                        r43 = r25(r22, r35)
                                                        r52 = r24[r43]
                                                        r43 = upvalueValues[upvalues[1]]
                                                        r22 = upvalueValues[upvalues[2]]
                                                        r9 = 22849538943376
                                                        r12 = "P\244\170\025"
                                                        r35 = r22(r12, r9)
                                                        r25 = r43[r35]
                                                        r24 = r8[r25]
                                                        r18 = state(r52, r24)
                                                        state = 119
                                                    end
                                                end
                                            else
                                                if state <= 118 then
                                                    if state == 118 then
                                                        r18 = "warn"
                                                        state = _env[r18]
                                                        r24 = upvalueValues[upvalues[1]]
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r35 = 24481758260360
                                                        r22 = "E.\226\200\215\r\168~\002CZ5S\238r\195\191\236_\135\209G"
                                                        r43 = r25(r22, r35)
                                                        r52 = r24[r43]
                                                        r43 = upvalueValues[upvalues[1]]
                                                        r22 = upvalueValues[upvalues[2]]
                                                        r12 = "\175\\sY"
                                                        r9 = 26940135076096
                                                        r35 = r22(r12, r9)
                                                        r25 = r43[r35]
                                                        r24 = r8[r25]
                                                        r18 = state(r52, r24, r34)
                                                        state = 119
                                                    end
                                                else
                                                    if state == 119 then
                                                        r50 = nil
                                                        r34 = nil
                                                        state = 116
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure4 entry 1558144 -> 120, states 120-127
                                    if state <= 123 then
                                        if state <= 121 then
                                            if state <= 120 then
                                                if state == 120 then -- entry 1558144 -> 120
                                                    state = {}
                                                    r28 = state
                                                    ReturnVal = "ipairs"
                                                    state = _env[ReturnVal]
                                                    r44 = upvalueValues[upvalues[1]]
                                                    r8 = {
                                                        state(r44)
                                                    }
                                                    ReturnVal = r8[1]
                                                    r44 = ReturnVal
                                                    r41 = r8[2]
                                                    r38 = r8[3]
                                                    state = 121
                                                end
                                            else
                                                if state == 121 then
                                                    r38, r16 = r44(r41, r38)
                                                    state = r38 and (122) or (123)
                                                end
                                            end
                                        else
                                            if state <= 122 then
                                                if state == 122 then
                                                    r52 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r22 = 33002509171719
                                                    r43 = ";\024l\1322\180"
                                                    r25 = r24(r43, r22)
                                                    r18 = r52[r25]
                                                    r34 = r16[r18]
                                                    state = r34 and (124) or (125)
                                                    r8 = r38
                                                    r50 = r34
                                                end
                                            else
                                                if state == 123 then
                                                    state = r28
                                                    r28 = nil
                                                    upvalueValues[upvalues[1]] = state
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        if state <= 125 then
                                            if state <= 124 then
                                                if state == 124 then
                                                    r52 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r43 = "\127\r\024#<J\170~o"
                                                    r22 = 17498553950164
                                                    r25 = r24(r43, r22)
                                                    r18 = r52[r25]
                                                    r34 = r16[r18]
                                                    r50 = r34
                                                    state = 125
                                                end
                                            else
                                                if state == 125 then
                                                    state = r50 and (126) or (127)
                                                end
                                            end
                                        else
                                            if state <= 126 then
                                                if state == 126 then
                                                    r34 = "table"
                                                    r50 = _env[r34]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r52 = upvalueValues[upvalues[3]]
                                                    r25 = "\195u\026~\146\218"
                                                    r43 = 33191946517600
                                                    r24 = r52(r25, r43)
                                                    r34 = r18[r24]
                                                    state = r50[r34]
                                                    r50 = state(r28, r16)
                                                    state = 127
                                                end
                                            else
                                                if state == 127 then
                                                    r16 = nil
                                                    r8 = nil
                                                    state = 121
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 154 then
                                    -- createClosure1 entry 12245023 -> 128, states 128-154
                                    if state <= 141 then
                                        if state <= 134 then
                                            if state <= 131 then
                                                if state <= 129 then
                                                    if state <= 128 then
                                                        if state == 128 then -- entry 12245023 -> 128
                                                            state = {}
                                                            r28 = state
                                                            state = {}
                                                            r41 = state
                                                            ReturnVal = "ipairs"
                                                            state = _env[ReturnVal]
                                                            r8 = upvalueValues[upvalues[1]]
                                                            r50 = "GetChildren"
                                                            r50 = r8[r50]
                                                            r16 = {
                                                                r50(r8)
                                                            }
                                                            r8 = {
                                                                state(unpack(r16))
                                                            }
                                                            r38 = r8[2]
                                                            r44 = r8[3]
                                                            ReturnVal = r8[1]
                                                            r8 = ReturnVal
                                                            state = 129
                                                        end
                                                    else
                                                        if state == 129 then
                                                            r44, r50 = r8(r38, r44)
                                                            state = r44 and (130) or (131)
                                                        end
                                                    end
                                                else
                                                    if state <= 130 then
                                                        if state == 130 then
                                                            state = upvalueValues[upvalues[2]]
                                                            r34 = state(r50)
                                                            state = r34 and (132) or (133)
                                                            r16 = r44
                                                        end
                                                    else
                                                        if state == 131 then
                                                            r38 = #r41
                                                            r44 = 0
                                                            state = r38 > r44
                                                            r38 = state
                                                            r50 = "game"
                                                            r16 = _env[r50]
                                                            r34 = upvalueValues[upvalues[3]]
                                                            r18 = upvalueValues[upvalues[4]]
                                                            r24 = "\231S\244l\178"
                                                            r25 = 33060273454114
                                                            r52 = r18(r24, r25)
                                                            r50 = r34[r52]
                                                            r8 = r16[r50]
                                                            state = r8 and (134) or (135)
                                                            r44 = r8
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 133 then
                                                    if state <= 132 then
                                                        if state == 132 then
                                                            r18 = "table"
                                                            r34 = _env[r18]
                                                            r52 = upvalueValues[upvalues[3]]
                                                            r24 = upvalueValues[upvalues[4]]
                                                            r22 = 29384833398131
                                                            r43 = "\196\134\193\138\214\236"
                                                            r25 = r24(r43, r22)
                                                            r18 = r52[r25]
                                                            state = r34[r18]
                                                            r24 = upvalueValues[upvalues[3]]
                                                            r25 = upvalueValues[upvalues[4]]
                                                            r35 = 3699399558842
                                                            r22 = "\149\233\130y"
                                                            r43 = r25(r22, r35)
                                                            r52 = r24[r43]
                                                            r18 = r50[r52]
                                                            r34 = state(r28, r18)
                                                            state = upvalueValues[upvalues[5]]
                                                            r24 = upvalueValues[upvalues[3]]
                                                            r25 = upvalueValues[upvalues[4]]
                                                            r35 = 23979796343710
                                                            r22 = "\248=\129\216"
                                                            r43 = r25(r22, r35)
                                                            r52 = r24[r43]
                                                            r18 = r50[r52]
                                                            r34 = state(r18)
                                                            state = r34 and (136) or (137)
                                                        end
                                                    else
                                                        if state == 133 then
                                                            r16 = nil
                                                            r50 = nil
                                                            state = 129
                                                        end
                                                    end
                                                else
                                                    if state == 134 then
                                                        r34 = "game"
                                                        r50 = _env[r34]
                                                        r18 = upvalueValues[upvalues[3]]
                                                        r52 = upvalueValues[upvalues[4]]
                                                        r25 = "\t\016b\226\164\2345"
                                                        r43 = 29396935423353
                                                        r24 = r52(r25, r43)
                                                        r34 = r18[r24]
                                                        r16 = r50[r34]
                                                        state = r16 and (138) or (139)
                                                        r8 = r16
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 138 then
                                                if state <= 136 then
                                                    if state <= 135 then
                                                        if state == 135 then
                                                            r16 = upvalueValues[upvalues[3]]
                                                            r50 = upvalueValues[upvalues[4]]
                                                            r52 = 23779814599489
                                                            r18 = "\225\005\174"
                                                            r34 = r50(r18, r52)
                                                            r8 = r16[r34]
                                                            r44 = r8
                                                            state = 134
                                                        end
                                                    else
                                                        if state == 136 then
                                                            r18 = "table"
                                                            r34 = _env[r18]
                                                            r52 = upvalueValues[upvalues[3]]
                                                            r24 = upvalueValues[upvalues[4]]
                                                            r43 = "\000S\154,MV"
                                                            r22 = 34764680331068
                                                            r25 = r24(r43, r22)
                                                            r18 = r52[r25]
                                                            state = r34[r18]
                                                            r24 = upvalueValues[upvalues[3]]
                                                            r25 = upvalueValues[upvalues[4]]
                                                            r35 = 17461853298627
                                                            r22 = "{\141\187\221"
                                                            r43 = r25(r22, r35)
                                                            r52 = r24[r43]
                                                            r18 = r50[r52]
                                                            r34 = state(r41, r18)
                                                            state = 137
                                                        end
                                                    end
                                                else
                                                    if state <= 137 then
                                                        if state == 137 then
                                                            state = 133
                                                        end
                                                    else
                                                        if state == 138 then
                                                            r50 = upvalueValues[upvalues[3]]
                                                            r34 = upvalueValues[upvalues[4]]
                                                            r24 = 27632114758211
                                                            r52 = "\186\168\217\176uTVn{\008<\184bZ9J\208\200\r\166\201\220\198\184.\031f\202C\253vK"
                                                            r18 = r34(r52, r24)
                                                            r16 = r50[r18]
                                                            r18 = "tostring"
                                                            r34 = _env[r18]
                                                            r18 = r34(r8)
                                                            r24 = upvalueValues[upvalues[3]]
                                                            r25 = upvalueValues[upvalues[4]]
                                                            r35 = 1839061599064
                                                            r22 = "\139\187\199F\027\227p\195t9\1451\192\231\t\147"
                                                            r43 = r25(r22, r35)
                                                            r52 = r24[r43]
                                                            r25 = "tostring"
                                                            r24 = _env[r25]
                                                            r25 = r24(r44)
                                                            r34 = r52 .. r25
                                                            r50 = r18 .. r34
                                                            state = r16 .. r50
                                                            r16 = state
                                                            r50 = upvalueValues[upvalues[3]]
                                                            r34 = upvalueValues[upvalues[4]]
                                                            r52 = ""
                                                            r24 = 33104897588279
                                                            r18 = r34(r52, r24)
                                                            state = r50[r18]
                                                            r50 = state
                                                            r34 = #r28
                                                            r18 = 0
                                                            state = r34 > r18
                                                            state = state and (140) or (141)
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 140 then
                                                    if state <= 139 then
                                                        if state == 139 then
                                                            r50 = upvalueValues[upvalues[3]]
                                                            r34 = upvalueValues[upvalues[4]]
                                                            r52 = "\244\207X"
                                                            r24 = 21469373556493
                                                            r18 = r34(r52, r24)
                                                            r16 = r50[r18]
                                                            r8 = r16
                                                            state = 138
                                                        end
                                                    else
                                                        if state == 140 then
                                                            r52 = upvalueValues[upvalues[3]]
                                                            r24 = upvalueValues[upvalues[4]]
                                                            r22 = 52773290008
                                                            r43 = "\231\025\173h\204_^RA\209\177\006S7\020h\214\147\205\148\240\169RS\196\234\151\007t\026\133p\128\215\253\026"
                                                            r25 = r24(r43, r22)
                                                            r18 = r52[r25]
                                                            r43 = "table"
                                                            r25 = _env[r43]
                                                            r22 = upvalueValues[upvalues[3]]
                                                            r35 = upvalueValues[upvalues[4]]
                                                            r9 = "\177\230\127_\213\018"
                                                            r4 = 5406283925973
                                                            r12 = r35(r9, r4)
                                                            r43 = r22[r12]
                                                            r24 = r25[r43]
                                                            r22 = upvalueValues[upvalues[3]]
                                                            r35 = upvalueValues[upvalues[4]]
                                                            r9 = "`"
                                                            r4 = 23572010887904
                                                            r12 = r35(r9, r4)
                                                            r43 = r22[r12]
                                                            r25 = r24(r28, r43)
                                                            r43 = upvalueValues[upvalues[3]]
                                                            r22 = upvalueValues[upvalues[4]]
                                                            r12 = "i!S\004"
                                                            r9 = 6249474689886
                                                            r35 = r22(r12, r9)
                                                            r24 = r43[r35]
                                                            r52 = r25 .. r24
                                                            r34 = r18 .. r52
                                                            state = r50 .. r34
                                                            r50 = state
                                                            state = 142
                                                        end
                                                    end
                                                else
                                                    if state == 141 then
                                                        r52 = upvalueValues[upvalues[3]]
                                                        r24 = upvalueValues[upvalues[4]]
                                                        r43 = "b\020\2192\155HG\205\141b\0080\001\175)\001\248\250*\223\170n,q\190U\022A\195\228\169"
                                                        r22 = 26247887138750
                                                        r25 = r24(r43, r22)
                                                        r18 = r52[r25]
                                                        r34 = r50 .. r18
                                                        r50 = r34
                                                        state = 142
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 148 then
                                            if state <= 145 then
                                                if state <= 143 then
                                                    if state <= 142 then
                                                        if state == 142 then
                                                            state = r38 and (143) or (144)
                                                        end
                                                    else
                                                        if state == 143 then
                                                            r25 = upvalueValues[upvalues[3]]
                                                            r43 = upvalueValues[upvalues[4]]
                                                            r35 = "\171MxHU6\001\235\147\167\192e\235\221\171\143\208\248\212\227\224g\201\132\222F\208\158\026N\\\157k\156_"
                                                            r12 = 2172466840563
                                                            r22 = r43(r35, r12)
                                                            r24 = r25[r22]
                                                            r22 = "table"
                                                            r43 = _env[r22]
                                                            r35 = upvalueValues[upvalues[3]]
                                                            r12 = upvalueValues[upvalues[4]]
                                                            r4 = "\212k\222\163\019\004"
                                                            r6 = 35060556365766
                                                            r9 = r12(r4, r6)
                                                            r22 = r35[r9]
                                                            r25 = r43[r22]
                                                            r35 = upvalueValues[upvalues[3]]
                                                            r12 = upvalueValues[upvalues[4]]
                                                            r4 = "\210\145\135dL\003"
                                                            r6 = 20466237105466
                                                            r9 = r12(r4, r6)
                                                            r22 = r35[r9]
                                                            r43 = r25(r41, r22)
                                                            r52 = r24 .. r43
                                                            r18 = r50 .. r52
                                                            r50 = r18
                                                            state = 144
                                                        end
                                                    end
                                                else
                                                    if state <= 144 then
                                                        if state == 144 then
                                                            r52 = upvalueValues[upvalues[6]]
                                                            r24 = r52()
                                                            state = r24 and (145) or (146)
                                                        end
                                                    else
                                                        if state == 145 then
                                                            r22 = upvalueValues[upvalues[3]]
                                                            r35 = upvalueValues[upvalues[4]]
                                                            r4 = 20439251379501
                                                            r9 = "\169\244\144\235<\200\154\151|\184\155\222,\021\025\"\140#p\241\207\017c\017\233Cm\0223\"\147\002\170<\137"
                                                            r12 = r35(r9, r4)
                                                            r43 = r22[r12]
                                                            r9 = upvalueValues[upvalues[3]]
                                                            r4 = upvalueValues[upvalues[4]]
                                                            r29 = 16072498011452
                                                            r32 = "\148\187;%"
                                                            r6 = r4(r32, r29)
                                                            r12 = r9[r6]
                                                            r35 = r24[r12]
                                                            r9 = upvalueValues[upvalues[3]]
                                                            r4 = upvalueValues[upvalues[4]]
                                                            r29 = 16159503949156
                                                            r32 = "\165\224\n\173n\003\176KY@]W\030e\237\020/\1877\136\181rU*\217\184Y\186X\222"
                                                            r6 = r4(r32, r29)
                                                            r12 = r9[r6]
                                                            r22 = r35 .. r12
                                                            r25 = r43 .. r22
                                                            r52 = r50 .. r25
                                                            r50 = r52
                                                            state = 146
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 147 then
                                                    if state <= 146 then
                                                        if state == 146 then
                                                            r22 = upvalueValues[upvalues[3]]
                                                            r35 = upvalueValues[upvalues[4]]
                                                            r9 = "\020\203Z\177\031"
                                                            r4 = 19227987239673
                                                            r12 = r35(r9, r4)
                                                            r43 = r22[r12]
                                                            r35 = upvalueValues[upvalues[3]]
                                                            r12 = upvalueValues[upvalues[4]]
                                                            r6 = 3324364359180
                                                            r4 = "\234\026c\007\237\255u\238\014\255(E\254K\181V\167\201\004\188U\011YbG\203\165\206"
                                                            r9 = r12(r4, r6)
                                                            r22 = r35[r9]
                                                            r12 = upvalueValues[upvalues[3]]
                                                            r9 = upvalueValues[upvalues[4]]
                                                            r6 = "\244W*\241\210\239'j\204\030?"
                                                            r32 = 7575041920455
                                                            r4 = r9(r6, r32)
                                                            r35 = r12[r4]
                                                            r4 = upvalueValues[upvalues[3]]
                                                            r6 = upvalueValues[upvalues[4]]
                                                            r2 = 6893154077833
                                                            r29 = "\245\014v\173\003\134\213\004o\206\0143/\211\198\255?\007\028\210W\189\2443+\247\249\020:\137\225\164$7\2007\026\154\"\018\222\227E\217\202LM\248]1\191N\233\151\175#\027k\139\2520\162\168\158\150\240\168\027\172'\238E\159\159\015\0168\248\233m#T\156\231ZI\244f\159\220\157\220\021?w\248h\216\253"
                                                            r32 = r6(r29, r2)
                                                            r9 = r4[r32]
                                                            r12 = r50 .. r9
                                                            r4 = upvalueValues[upvalues[3]]
                                                            r6 = upvalueValues[upvalues[4]]
                                                            r2 = 27806122635924
                                                            r29 = "\220eg\209\136"
                                                            r32 = r6(r29, r2)
                                                            r9 = r4[r32]
                                                            r2 = 3581519
                                                            r32 = r38 and r2
                                                            r29 = state
                                                            r29 = 10181046
                                                            r4 = r32 or r29
                                                            r32 = upvalueValues[upvalues[3]]
                                                            r29 = upvalueValues[upvalues[4]]
                                                            r31 = "\167\1917\244\133\134"
                                                            r7 = 34515176996552
                                                            r2 = r29(r31, r7)
                                                            r6 = state
                                                            r6 = r32[r2]
                                                            r31 = upvalueValues[upvalues[3]]
                                                            r7 = upvalueValues[upvalues[4]]
                                                            r14 = 12695791965975
                                                            r51 = "q:p\134"
                                                            r40 = r7(r51, r14)
                                                            r2 = r31[r40]
                                                            r7 = upvalueValues[upvalues[3]]
                                                            r40 = upvalueValues[upvalues[4]]
                                                            r33 = 11169778717777
                                                            r14 = "\224#\189l\001\223\r:5\181:"
                                                            r51 = r40(r14, r33)
                                                            r31 = r7[r51]
                                                            r40 = upvalueValues[upvalues[3]]
                                                            r51 = upvalueValues[upvalues[4]]
                                                            r47 = 28715638305851
                                                            r33 = "\024\220F\004\228"
                                                            r14 = r51(r33, r47)
                                                            r7 = r40[r14]
                                                            r14 = upvalueValues[upvalues[3]]
                                                            r33 = upvalueValues[upvalues[4]]
                                                            r27 = 16395191541202
                                                            r15 = "\2397'"
                                                            r47 = r33(r15, r27)
                                                            r51 = r14[r47]
                                                            r47 = upvalueValues[upvalues[7]]
                                                            r27 = upvalueValues[upvalues[3]]
                                                            r46 = upvalueValues[upvalues[4]]
                                                            r37 = 35149575061487
                                                            r17 = "\218\127TT"
                                                            r45 = r46(r17, r37)
                                                            r15 = r27[r45]
                                                            r33 = r47[r15]
                                                            r15 = upvalueValues[upvalues[3]]
                                                            r27 = upvalueValues[upvalues[4]]
                                                            r17 = 28295946531704
                                                            r45 = "\226TA"
                                                            r46 = r27(r45, r17)
                                                            r47 = r15[r46]
                                                            r14 = r33 .. r47
                                                            r40 = r51 .. r14
                                                            r14 = upvalueValues[upvalues[3]]
                                                            r33 = upvalueValues[upvalues[4]]
                                                            r27 = 33857044839829
                                                            r15 = "\025\n-\030\199!"
                                                            r47 = r33(r15, r27)
                                                            r51 = r14[r47]
                                                            r14 = true
                                                            r29 = {
                                                                [r2] = r31,
                                                                [r7] = r40,
                                                                [r51] = r14
                                                            }
                                                            r7 = upvalueValues[upvalues[3]]
                                                            r40 = upvalueValues[upvalues[4]]
                                                            r14 = "d<\154\018"
                                                            r33 = 33025476410386
                                                            r51 = r40(r14, r33)
                                                            r31 = r7[r51]
                                                            r40 = upvalueValues[upvalues[3]]
                                                            r51 = upvalueValues[upvalues[4]]
                                                            r33 = "O2\018=\141\241'\181\250A\003d\246\158\160st\205!\169\160"
                                                            r47 = 16891389025977
                                                            r14 = r51(r33, r47)
                                                            r7 = r40[r14]
                                                            r51 = upvalueValues[upvalues[3]]
                                                            r14 = upvalueValues[upvalues[4]]
                                                            r15 = 28069608157966
                                                            r47 = "7\024U%\\"
                                                            r33 = r14(r47, r15)
                                                            r40 = r51[r33]
                                                            r33 = upvalueValues[upvalues[3]]
                                                            r47 = upvalueValues[upvalues[4]]
                                                            r46 = 19310477861664
                                                            r27 = "\194o`"
                                                            r15 = r47(r27, r46)
                                                            r14 = r33[r15]
                                                            r27 = "table"
                                                            r15 = _env[r27]
                                                            r46 = upvalueValues[upvalues[3]]
                                                            r45 = upvalueValues[upvalues[4]]
                                                            r39 = 9339131695356
                                                            r37 = "%\246\250p\007\212"
                                                            r17 = r45(r37, r39)
                                                            r27 = r46[r17]
                                                            r47 = r15[r27]
                                                            r27 = upvalueValues[upvalues[8]]
                                                            r45 = upvalueValues[upvalues[3]]
                                                            r17 = upvalueValues[upvalues[4]]
                                                            r42 = 29908669773415
                                                            r39 = "\223"
                                                            r37 = r17(r39, r42)
                                                            r46 = r45[r37]
                                                            r15 = r47(r27, r46)
                                                            r27 = upvalueValues[upvalues[3]]
                                                            r46 = upvalueValues[upvalues[4]]
                                                            r37 = 17231003344727
                                                            r17 = "\188\149t"
                                                            r45 = r46(r17, r37)
                                                            r47 = r27[r45]
                                                            r33 = r15 .. r47
                                                            r51 = r14 .. r33
                                                            r33 = upvalueValues[upvalues[3]]
                                                            r47 = upvalueValues[upvalues[4]]
                                                            r46 = 9391904985365
                                                            r27 = "\\\027\147\210\007N"
                                                            r15 = r47(r27, r46)
                                                            r14 = r33[r15]
                                                            r33 = true
                                                            r2 = {
                                                                [r31] = r7,
                                                                [r40] = r51,
                                                                [r14] = r33
                                                            }
                                                            r40 = upvalueValues[upvalues[3]]
                                                            r51 = upvalueValues[upvalues[4]]
                                                            r47 = 130581594172
                                                            r33 = "F\242\186a"
                                                            r14 = r51(r33, r47)
                                                            r7 = r40[r14]
                                                            r51 = upvalueValues[upvalues[3]]
                                                            r14 = upvalueValues[upvalues[4]]
                                                            r15 = 5618642143800
                                                            r47 = "\017\007\137\t\130\249wm36y\248\148\149\236"
                                                            r33 = r14(r47, r15)
                                                            r40 = r51[r33]
                                                            r14 = upvalueValues[upvalues[3]]
                                                            r33 = upvalueValues[upvalues[4]]
                                                            r27 = 15641379691635
                                                            r15 = "\150\242S\235H"
                                                            r47 = r33(r15, r27)
                                                            r51 = r14[r47]
                                                            r47 = upvalueValues[upvalues[3]]
                                                            r15 = upvalueValues[upvalues[4]]
                                                            r45 = 26378468732923
                                                            r46 = "gg\244"
                                                            r27 = r15(r46, r45)
                                                            r33 = r47[r27]
                                                            r27 = "tostring"
                                                            r15 = _env[r27]
                                                            r46 = #r28
                                                            r27 = r15(r46)
                                                            r46 = upvalueValues[upvalues[3]]
                                                            r45 = upvalueValues[upvalues[4]]
                                                            r39 = 7791108984364
                                                            r37 = "!\r\016"
                                                            r17 = r45(r37, r39)
                                                            r15 = r46[r17]
                                                            r47 = r27 .. r15
                                                            r14 = r33 .. r47
                                                            r47 = upvalueValues[upvalues[3]]
                                                            r15 = upvalueValues[upvalues[4]]
                                                            r45 = 15517563952185
                                                            r46 = "\191\127\1606M\017"
                                                            r27 = r15(r46, r45)
                                                            r33 = r47[r27]
                                                            r47 = true
                                                            r31 = {
                                                                [r7] = r40,
                                                                [r51] = r14,
                                                                [r33] = r47
                                                            }
                                                            r51 = upvalueValues[upvalues[3]]
                                                            r14 = upvalueValues[upvalues[4]]
                                                            r15 = 11660333749557
                                                            r47 = "\211\240F\229"
                                                            r33 = r14(r47, r15)
                                                            r40 = r51[r33]
                                                            r14 = upvalueValues[upvalues[3]]
                                                            r33 = upvalueValues[upvalues[4]]
                                                            r27 = 28230360380249
                                                            r15 = "v\174\205\136-\002R$\150\008Y\018\247\238\186\136"
                                                            r47 = r33(r15, r27)
                                                            r51 = r14[r47]
                                                            r33 = upvalueValues[upvalues[3]]
                                                            r47 = upvalueValues[upvalues[4]]
                                                            r46 = 31590061963638
                                                            r27 = "94\142\179\186"
                                                            r15 = r47(r27, r46)
                                                            r14 = r33[r15]
                                                            r15 = upvalueValues[upvalues[3]]
                                                            r27 = upvalueValues[upvalues[4]]
                                                            r45 = "\149f'"
                                                            r17 = 27819837698714
                                                            r46 = r27(r45, r17)
                                                            r47 = r15[r46]
                                                            r46 = "tostring"
                                                            r27 = _env[r46]
                                                            r45 = #r41
                                                            r46 = r27(r45)
                                                            r45 = upvalueValues[upvalues[3]]
                                                            r17 = upvalueValues[upvalues[4]]
                                                            r42 = 12273975514707
                                                            r39 = "<\195m"
                                                            r37 = r17(r39, r42)
                                                            r27 = r45[r37]
                                                            r15 = r46 .. r27
                                                            r33 = r47 .. r15
                                                            r15 = upvalueValues[upvalues[3]]
                                                            r27 = upvalueValues[upvalues[4]]
                                                            r45 = "R\020\177\209I\219"
                                                            r17 = 34914426339202
                                                            r46 = r27(r45, r17)
                                                            r47 = r15[r46]
                                                            r15 = true
                                                            r7 = {
                                                                [r40] = r51,
                                                                [r14] = r33,
                                                                [r47] = r15
                                                            }
                                                            r14 = upvalueValues[upvalues[3]]
                                                            r33 = upvalueValues[upvalues[4]]
                                                            r27 = 210507513954
                                                            r15 = "l\229_a"
                                                            r47 = r33(r15, r27)
                                                            r51 = r14[r47]
                                                            r33 = upvalueValues[upvalues[3]]
                                                            r47 = upvalueValues[upvalues[4]]
                                                            r46 = 19167129592541
                                                            r27 = "\164\145\t\183M\223\197AB\011p"
                                                            r15 = r47(r27, r46)
                                                            r14 = r33[r15]
                                                            r47 = upvalueValues[upvalues[3]]
                                                            r15 = upvalueValues[upvalues[4]]
                                                            r45 = 27536176869910
                                                            r46 = "7\167\143\208R"
                                                            r27 = r15(r46, r45)
                                                            r33 = r47[r27]
                                                            r27 = upvalueValues[upvalues[3]]
                                                            r46 = upvalueValues[upvalues[4]]
                                                            r37 = 34725684526890
                                                            r17 = "\202\175'"
                                                            r45 = r46(r17, r37)
                                                            r15 = r27[r45]
                                                            r45 = upvalueValues[upvalues[3]]
                                                            r17 = upvalueValues[upvalues[4]]
                                                            r39 = "\022\007\224"
                                                            r42 = 31862921574901
                                                            r37 = r17(r39, r42)
                                                            r46 = r45[r37]
                                                            r27 = r44 .. r46
                                                            r47 = r15 .. r27
                                                            r27 = upvalueValues[upvalues[3]]
                                                            r46 = upvalueValues[upvalues[4]]
                                                            r17 = "\160/\218$#\214"
                                                            r37 = 3521583482471
                                                            r45 = r46(r17, r37)
                                                            r15 = r27[r45]
                                                            r27 = true
                                                            r40 = {
                                                                [r51] = r14,
                                                                [r33] = r47,
                                                                [r15] = r27
                                                            }
                                                            r33 = upvalueValues[upvalues[3]]
                                                            r47 = upvalueValues[upvalues[4]]
                                                            r46 = 28256950727526
                                                            r27 = "u\247\008a"
                                                            r15 = r47(r27, r46)
                                                            r14 = r33[r15]
                                                            r47 = upvalueValues[upvalues[3]]
                                                            r15 = upvalueValues[upvalues[4]]
                                                            r46 = "\173\231\202F\216\1541\028\151mM\002\253"
                                                            r45 = 13073741010887
                                                            r27 = r15(r46, r45)
                                                            r33 = r47[r27]
                                                            r15 = upvalueValues[upvalues[3]]
                                                            r27 = upvalueValues[upvalues[4]]
                                                            r17 = 3486786438743
                                                            r45 = "\237\166\023\012q"
                                                            r46 = r27(r45, r17)
                                                            r47 = r15[r46]
                                                            r46 = upvalueValues[upvalues[3]]
                                                            r45 = upvalueValues[upvalues[4]]
                                                            r37 = "\189Z\253"
                                                            r39 = 21368525154014
                                                            r17 = r45(r37, r39)
                                                            r27 = r46[r17]
                                                            r17 = "tostring"
                                                            r45 = _env[r17]
                                                            r17 = r45(r8)
                                                            r37 = upvalueValues[upvalues[3]]
                                                            r39 = upvalueValues[upvalues[4]]
                                                            r30 = "w&C"
                                                            r11 = 11746413745501
                                                            r42 = r39(r30, r11)
                                                            r45 = r37[r42]
                                                            r46 = r17 .. r45
                                                            r15 = r27 .. r46
                                                            r46 = upvalueValues[upvalues[3]]
                                                            r45 = upvalueValues[upvalues[4]]
                                                            r39 = 1327890743914
                                                            r37 = "\008\194l\027\230\164"
                                                            r17 = r45(r37, r39)
                                                            r27 = r46[r17]
                                                            r46 = true
                                                            r51 = {
                                                                [r14] = r33,
                                                                [r47] = r15,
                                                                [r27] = r46
                                                            }
                                                            r47 = upvalueValues[upvalues[3]]
                                                            r15 = upvalueValues[upvalues[4]]
                                                            r46 = "c%\240\025"
                                                            r45 = 3075542074776
                                                            r27 = r15(r46, r45)
                                                            r33 = r47[r27]
                                                            r15 = upvalueValues[upvalues[3]]
                                                            r27 = upvalueValues[upvalues[4]]
                                                            r17 = 4631649814636
                                                            r45 = "\203\222\255\217\027g\"^\004\001K\226\156\018v"
                                                            r46 = r27(r45, r17)
                                                            r47 = r15[r46]
                                                            r27 = upvalueValues[upvalues[3]]
                                                            r46 = upvalueValues[upvalues[4]]
                                                            r37 = 20638368605578
                                                            r17 = "G\241X\1324"
                                                            r45 = r46(r17, r37)
                                                            r15 = r27[r45]
                                                            r45 = upvalueValues[upvalues[3]]
                                                            r17 = upvalueValues[upvalues[4]]
                                                            r39 = ";n\215\224\162\210\019H\216r\197\r.Q\191\141\n\134}"
                                                            r42 = 12414673770133
                                                            r37 = r17(r39, r42)
                                                            r46 = r45[r37]
                                                            r37 = upvalueValues[upvalues[3]]
                                                            r39 = upvalueValues[upvalues[4]]
                                                            r11 = 34540319588052
                                                            r30 = "\179"
                                                            r42 = r39(r30, r11)
                                                            r17 = r37[r42]
                                                            r45 = r16 .. r17
                                                            r27 = r46 .. r45
                                                            r45 = upvalueValues[upvalues[3]]
                                                            r17 = upvalueValues[upvalues[4]]
                                                            r42 = 2684999845090
                                                            r39 = ";\154\018\002\014D"
                                                            r37 = r17(r39, r42)
                                                            r46 = r45[r37]
                                                            r45 = false
                                                            r14 = {
                                                                [r33] = r47,
                                                                [r15] = r27,
                                                                [r46] = r45
                                                            }
                                                            r32 = {
                                                                r29,
                                                                r2,
                                                                r31,
                                                                r7,
                                                                r40,
                                                                r51,
                                                                r14
                                                            }
                                                            r2 = upvalueValues[upvalues[3]]
                                                            r31 = upvalueValues[upvalues[4]]
                                                            r40 = "\015x\253\254\242\243"
                                                            r51 = 21806578771882
                                                            r7 = r31(r40, r51)
                                                            r29 = r2[r7]
                                                            r7 = upvalueValues[upvalues[3]]
                                                            r40 = upvalueValues[upvalues[4]]
                                                            r33 = 34670901182224
                                                            r14 = "T\194\248M"
                                                            r51 = r40(r14, r33)
                                                            r31 = r7[r51]
                                                            r40 = upvalueValues[upvalues[3]]
                                                            r51 = upvalueValues[upvalues[4]]
                                                            r47 = 8303641988890
                                                            r33 = "\238A\221\229\"7\127\173\241\175@OVb\170\015L\025\198:\215/\139\147\207Q&h\253\221E\128\198\249\147\025)\141r\255\238\169 \202\r"
                                                            r14 = r51(r33, r47)
                                                            r7 = r40[r14]
                                                            r51 = upvalueValues[upvalues[3]]
                                                            r14 = upvalueValues[upvalues[4]]
                                                            r47 = "w\006R\229E\239V_"
                                                            r15 = 2263586358302
                                                            r33 = r14(r47, r15)
                                                            r40 = r51[r33]
                                                            r14 = upvalueValues[upvalues[3]]
                                                            r33 = upvalueValues[upvalues[4]]
                                                            r27 = 25864997809932
                                                            r15 = "\171\221^\194\000\140\206\184v\175\029\154[j\017 \133\"!\245G=\1539\235\0251\133\026$\031\156ti_\\\232\202\2053\160#\157\193V$\170\197\155\130\211a"
                                                            r47 = r33(r15, r27)
                                                            r51 = r14[r47]
                                                            r2 = {
                                                                [r31] = r7,
                                                                [r40] = r51
                                                            }
                                                            r7 = upvalueValues[upvalues[3]]
                                                            r40 = upvalueValues[upvalues[4]]
                                                            r33 = 16094750989638
                                                            r14 = "\255~\028\191\187\255\012n\020"
                                                            r51 = r40(r14, r33)
                                                            r31 = r7[r51]
                                                            r51 = "os"
                                                            r40 = _env[r51]
                                                            r14 = upvalueValues[upvalues[3]]
                                                            r33 = upvalueValues[upvalues[4]]
                                                            r15 = "\005\135X\228"
                                                            r27 = 17781150310487
                                                            r47 = r33(r15, r27)
                                                            r51 = r14[r47]
                                                            r7 = r40[r51]
                                                            r14 = upvalueValues[upvalues[3]]
                                                            r33 = upvalueValues[upvalues[4]]
                                                            r27 = 2340959454274
                                                            r15 = "F\2424\\\252S\210XD\224\254\001\175{\004Ch\224\022"
                                                            r47 = r33(r15, r27)
                                                            r51 = r14[r47]
                                                            r40 = r7(r51)
                                                            r51 = upvalueValues[upvalues[3]]
                                                            r14 = upvalueValues[upvalues[4]]
                                                            r15 = 9140739264672
                                                            r47 = "\129esUV\165G\202\205"
                                                            r33 = r14(r47, r15)
                                                            r7 = r51[r33]
                                                            r33 = upvalueValues[upvalues[3]]
                                                            r47 = upvalueValues[upvalues[4]]
                                                            r46 = 14186840185294
                                                            r27 = "rk\215"
                                                            r15 = r47(r27, r46)
                                                            r14 = r33[r15]
                                                            r47 = upvalueValues[upvalues[3]]
                                                            r15 = upvalueValues[upvalues[4]]
                                                            r45 = 30160797152988
                                                            r46 = "\005+\141t\136\245\235\227\1856\007\003\147\222\219\253\2170\1617\004_\149\200V\142.U\130\182\\\175R\020\150\227#j\135\207\186\224\197\t99\017 \006+\128\167\142\146"
                                                            r27 = r15(r46, r45)
                                                            r33 = r47[r27]
                                                            r51 = {
                                                                [r14] = r33
                                                            }
                                                            r25 = {
                                                                [r43] = r22,
                                                                [r35] = r12,
                                                                [r9] = r4,
                                                                [r6] = r32,
                                                                [r29] = r2,
                                                                [r31] = r40,
                                                                [r7] = r51
                                                            }
                                                            r22 = upvalueValues[upvalues[3]]
                                                            r35 = upvalueValues[upvalues[4]]
                                                            r4 = 21414714779380
                                                            r9 = ""
                                                            r12 = r35(r9, r4)
                                                            r43 = r22[r12]
                                                            r35 = state
                                                            state = r38 and (147) or (148)
                                                            r22 = r38
                                                        end
                                                    else
                                                        if state == 147 then
                                                            state = r35
                                                            state = r22 and (149) or (150)
                                                        end
                                                    end
                                                else
                                                    if state == 148 then
                                                        r22 = r24
                                                        state = 147
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 151 then
                                                if state <= 150 then
                                                    if state <= 149 then
                                                        if state == 149 then
                                                            r35 = upvalueValues[upvalues[3]]
                                                            r12 = upvalueValues[upvalues[4]]
                                                            r6 = 13916894419280
                                                            r4 = "\152<X\"Q\154\198\170\157\223[0+\182\226\177\182V&"
                                                            r9 = r12(r4, r6)
                                                            r22 = r35[r9]
                                                            r43 = r22
                                                            state = 151
                                                        end
                                                    else
                                                        if state == 150 then
                                                            r9 = upvalueValues[upvalues[3]]
                                                            r4 = upvalueValues[upvalues[4]]
                                                            r29 = 30371304683326
                                                            r32 = "\182\136>\012\165^x"
                                                            r6 = r4(r32, r29)
                                                            r12 = r9[r6]
                                                            r6 = upvalueValues[upvalues[7]]
                                                            r29 = upvalueValues[upvalues[3]]
                                                            r2 = upvalueValues[upvalues[4]]
                                                            r7 = "u\196e\008\224\160"
                                                            r40 = 5397472266705
                                                            r31 = r2(r7, r40)
                                                            r32 = r29[r31]
                                                            r4 = r6[r32]
                                                            r32 = upvalueValues[upvalues[3]]
                                                            r29 = upvalueValues[upvalues[4]]
                                                            r7 = 6268699183975
                                                            r31 = "W\008\003\215\136p"
                                                            r2 = r29(r31, r7)
                                                            r6 = r32[r2]
                                                            r9 = r4 .. r6
                                                            r35 = r12 .. r9
                                                            r43 = r35
                                                            state = 151
                                                        end
                                                    end
                                                else
                                                    if state == 151 then
                                                        r12 = upvalueValues[upvalues[9]]
                                                        r32 = upvalueValues[upvalues[3]]
                                                        r29 = upvalueValues[upvalues[4]]
                                                        r31 = "\024\226}\140\216\160\212"
                                                        r7 = 29912617105001
                                                        r2 = r29(r31, r7)
                                                        r6 = r32[r2]
                                                        r29 = upvalueValues[upvalues[3]]
                                                        r2 = upvalueValues[upvalues[4]]
                                                        r40 = 2076021736390
                                                        r7 = "\154\030u\216L\142\171\176"
                                                        r31 = r2(r7, r40)
                                                        r32 = r29[r31]
                                                        r2 = upvalueValues[upvalues[3]]
                                                        r31 = upvalueValues[upvalues[4]]
                                                        r51 = 9790282666446
                                                        r40 = "Q8Ta\246%\254\143\225\228t{\133"
                                                        r7 = r31(r40, r51)
                                                        r29 = r2[r7]
                                                        r31 = upvalueValues[upvalues[3]]
                                                        r7 = upvalueValues[upvalues[4]]
                                                        r14 = 22985195727311
                                                        r51 = "\240\177Gb\228\167\228\139\219\141"
                                                        r40 = r7(r51, r14)
                                                        r2 = r31[r40]
                                                        r7 = upvalueValues[upvalues[3]]
                                                        r40 = upvalueValues[upvalues[4]]
                                                        r33 = 15149762747278
                                                        r14 = "\212\196vE\133\160n\224}mV\030Qc\163\186ZK\0143\187Y\248\131\174\196(\022Oc%y7\152\2252\221\1319\219\225\142\207(W\226\212\206m\139\197y"
                                                        r51 = r40(r14, r33)
                                                        r31 = r7[r51]
                                                        r40 = upvalueValues[upvalues[3]]
                                                        r51 = upvalueValues[upvalues[4]]
                                                        r47 = 13277069105190
                                                        r33 = "\029\236\021\1724\218"
                                                        r14 = r51(r33, r47)
                                                        r7 = r40[r14]
                                                        r9 = "JSONEncode"
                                                        r9 = r12[r9]
                                                        r40 = {
                                                            r25
                                                        }
                                                        r4 = {
                                                            [r6] = r43,
                                                            [r32] = r29,
                                                            [r2] = r31,
                                                            [r7] = r40
                                                        }
                                                        r9 = r9(r12, r4)
                                                        r12 = allocUpvalue()
                                                        upvalueValues[r12] = r9
                                                        r32 = createClosure0(267, {
                                                            upvalues[3],
                                                            upvalues[4],
                                                            upvalues[10],
                                                            r12
                                                        })
                                                        r4 = "pcall"
                                                        r9 = _env[r4]
                                                        r29 = {
                                                            r9(r32)
                                                        }
                                                        r4 = r29[1]
                                                        state = r4 and (152) or (153)
                                                        r6 = r29[2]
                                                    end
                                                end
                                            else
                                                if state <= 153 then
                                                    if state <= 152 then
                                                        if state == 152 then
                                                            r32 = "print"
                                                            r9 = _env[r32]
                                                            r2 = upvalueValues[upvalues[3]]
                                                            r31 = upvalueValues[upvalues[4]]
                                                            r40 = "\210\176\019cq\229b\019hj\1274!\187\165\230RW\154c\150\1387\165\188\001U\007\173\196*\249\254\210\189\016ua\240X"
                                                            r51 = 30883773806637
                                                            r7 = r31(r40, r51)
                                                            r29 = r2[r7]
                                                            r32 = r9(r29)
                                                            state = 154
                                                        end
                                                    else
                                                        if state == 153 then
                                                            r32 = "warn"
                                                            r9 = _env[r32]
                                                            r2 = upvalueValues[upvalues[3]]
                                                            r31 = upvalueValues[upvalues[4]]
                                                            r51 = 2743956194557
                                                            r40 = "\221=!7\213\008z\129Q\2195\248\244\212\016v\226\168L\185Gw\177\201\227\130\028\250\130\191$\t"
                                                            r7 = r31(r40, r51)
                                                            r29 = r2[r7]
                                                            r32 = r9(r29, r6)
                                                            state = 154
                                                        end
                                                    end
                                                else
                                                    if state == 154 then
                                                        r41 = nil
                                                        r6 = nil
                                                        r38 = nil
                                                        r43 = nil
                                                        r50 = nil
                                                        r24 = nil
                                                        ReturnVal = {}
                                                        r16 = nil
                                                        r25 = nil
                                                        r44 = nil
                                                        r4 = nil
                                                        r8 = nil
                                                        r28 = nil
                                                        r12 = releaseUpvalue(r12)
                                                        state = nil
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure3 entry 4944564 -> 155, states 155-165
                                    if state <= 160 then
                                        if state <= 157 then
                                            if state <= 156 then
                                                if state <= 155 then
                                                    if state == 155 then -- entry 4944564 -> 155
                                                        state = {}
                                                        r28 = state
                                                        ReturnVal = "ipairs"
                                                        state = _env[ReturnVal]
                                                        r44 = upvalueValues[upvalues[1]]
                                                        r16 = "GetChildren"
                                                        r16 = r44[r16]
                                                        r8 = {
                                                            r16(r44)
                                                        }
                                                        r44 = {
                                                            state(unpack(r8))
                                                        }
                                                        r38 = r44[3]
                                                        r41 = r44[2]
                                                        ReturnVal = r44[1]
                                                        r44 = ReturnVal
                                                        state = 156
                                                    end
                                                else
                                                    if state == 156 then
                                                        r38, r16 = r44(r41, r38)
                                                        state = r38 and (157) or (158)
                                                    end
                                                end
                                            else
                                                if state == 157 then
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r52 = upvalueValues[upvalues[3]]
                                                    r43 = 25651485404840
                                                    r25 = "\203\2448\139\191"
                                                    r24 = r52(r25, r43)
                                                    r34 = r18[r24]
                                                    r50 = "GetAttribute"
                                                    r50 = r16[r50]
                                                    r50 = r50(r16, r34)
                                                    r18 = upvalueValues[upvalues[4]]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r25 = upvalueValues[upvalues[3]]
                                                    r22 = "o,?\146"
                                                    r35 = 6196701399877
                                                    r43 = r25(r22, r35)
                                                    r52 = r24[r43]
                                                    r34 = r18[r52]
                                                    state = r50 == r34
                                                    state = state and (159) or (160)
                                                    r8 = r38
                                                end
                                            end
                                        else
                                            if state <= 159 then
                                                if state <= 158 then
                                                    if state == 158 then
                                                        ReturnVal = {
                                                            r28
                                                        }
                                                        state = nil
                                                    end
                                                else
                                                    if state == 159 then
                                                        r24 = "GetChildren"
                                                        r24 = r16[r24]
                                                        r50 = "ipairs"
                                                        state = _env[r50]
                                                        r52 = {
                                                            r24(r16)
                                                        }
                                                        r24 = {
                                                            state(unpack(r52))
                                                        }
                                                        r34 = r24[2]
                                                        r50 = r24[1]
                                                        r18 = r24[3]
                                                        state = 161
                                                    end
                                                end
                                            else
                                                if state == 160 then
                                                    r8 = nil
                                                    r16 = nil
                                                    state = 156
                                                end
                                            end
                                        end
                                    else
                                        if state <= 163 then
                                            if state <= 162 then
                                                if state <= 161 then
                                                    if state == 161 then
                                                        r18, r24 = r50(r34, r18)
                                                        state = r18 and (162) or (163)
                                                    end
                                                else
                                                    if state == 162 then
                                                        state = "IsA"
                                                        state = r24[state]
                                                        r43 = upvalueValues[upvalues[2]]
                                                        r22 = upvalueValues[upvalues[3]]
                                                        r9 = 20841603212777
                                                        r12 = "\209\\3Ck"
                                                        r35 = r22(r12, r9)
                                                        r25 = r43[r35]
                                                        state = state(r24, r25)
                                                        state = state and (164) or (165)
                                                        r52 = r18
                                                    end
                                                end
                                            else
                                                if state == 163 then
                                                    state = 160
                                                end
                                            end
                                        else
                                            if state <= 164 then
                                                if state == 164 then
                                                    r43 = "table"
                                                    r25 = _env[r43]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r35 = upvalueValues[upvalues[3]]
                                                    r4 = 13784828057875
                                                    r9 = "b\177\159E\169L"
                                                    r12 = r35(r9, r4)
                                                    r43 = r22[r12]
                                                    state = r25[r43]
                                                    r6 = 28811081675880
                                                    r4 = "\238\011cm"
                                                    r35 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r52 = nil
                                                    r9 = r12(r4, r6)
                                                    r22 = r35[r9]
                                                    r43 = r24[r22]
                                                    r25 = state(r28, r43)
                                                    r24 = nil
                                                    state = 163
                                                end
                                            else
                                                if state == 165 then
                                                    r52 = nil
                                                    r24 = nil
                                                    state = 161
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 267 then
                        if state <= 240 then
                            if state <= 191 then
                                if state <= 180 then
                                    if state <= 175 then
                                        -- createClosure4 entry 1875095 -> 166, states 166-175
                                        if state <= 170 then
                                            if state <= 168 then
                                                if state <= 167 then
                                                    if state <= 166 then
                                                        if state == 166 then -- entry 1875095 -> 166
                                                            ReturnVal = "ipairs"
                                                            state = _env[ReturnVal]
                                                            r38 = upvalueValues[upvalues[1]]
                                                            r8 = "GetPlayers"
                                                            r8 = r38[r8]
                                                            r44 = {
                                                                r8(r38)
                                                            }
                                                            r38 = {
                                                                state(unpack(r44))
                                                            }
                                                            r28 = r38[2]
                                                            ReturnVal = r38[1]
                                                            r41 = r38[3]
                                                            r38 = ReturnVal
                                                            state = 167
                                                        end
                                                    else
                                                        if state == 167 then
                                                            r41, r8 = r38(r28, r41)
                                                            state = r41 and (168) or (169)
                                                        end
                                                    end
                                                else
                                                    if state == 168 then
                                                        state = allocUpvalue()
                                                        upvalueValues[state] = r8
                                                        r8 = state
                                                        r34 = upvalueValues[r8]
                                                        r18 = upvalueValues[upvalues[2]]
                                                        r50 = r34 ~= r18
                                                        state = r50 and (170) or (171)
                                                        r16 = r50
                                                        r44 = r41
                                                    end
                                                end
                                            else
                                                if state <= 169 then
                                                    if state == 169 then
                                                        r28 = upvalueValues[upvalues[1]]
                                                        r38 = upvalueValues[upvalues[3]]
                                                        r44 = upvalueValues[upvalues[4]]
                                                        r50 = 22513431128307
                                                        r16 = "P\146\183_\2012ul\031\189\244"
                                                        r8 = r44(r16, r50)
                                                        ReturnVal = {}
                                                        r41 = r38[r8]
                                                        state = r28[r41]
                                                        r41 = createClosure3(268, {
                                                            upvalues[2],
                                                            upvalues[3],
                                                            upvalues[4],
                                                            upvalues[5]
                                                        })
                                                        r28 = "Connect"
                                                        r28 = state[r28]
                                                        r28 = r28(state, r41)
                                                        state = nil
                                                    end
                                                else
                                                    if state == 170 then
                                                        r34 = upvalueValues[r8]
                                                        r52 = upvalueValues[upvalues[3]]
                                                        r24 = upvalueValues[upvalues[4]]
                                                        r22 = 11281771304069
                                                        r43 = "FZ\220\173\020\r/v\236"
                                                        r25 = r24(r43, r22)
                                                        r18 = r52[r25]
                                                        r50 = r34[r18]
                                                        r16 = r50
                                                        state = 171
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 173 then
                                                if state <= 172 then
                                                    if state <= 171 then
                                                        if state == 171 then
                                                            state = r16 and (172) or (173)
                                                        end
                                                    else
                                                        if state == 172 then
                                                            r16 = "pcall"
                                                            state = _env[r16]
                                                            r34 = createClosure0(271, {
                                                                r8,
                                                                upvalues[3],
                                                                upvalues[4],
                                                                upvalues[5]
                                                            })
                                                            r18 = {
                                                                state(r34)
                                                            }
                                                            r16 = r18[1]
                                                            state = not r16
                                                            state = state and (174) or (175)
                                                            r50 = r18[2]
                                                        end
                                                    end
                                                else
                                                    if state == 173 then
                                                        r44 = nil
                                                        r8 = releaseUpvalue(r8)
                                                        state = 167
                                                    end
                                                end
                                            else
                                                if state <= 174 then
                                                    if state == 174 then
                                                        r34 = "warn"
                                                        state = _env[r34]
                                                        r52 = upvalueValues[upvalues[3]]
                                                        r24 = upvalueValues[upvalues[4]]
                                                        r43 = "\\\186!U\239\154\226\227M\214\247\174+\153p\174\234es5\168\222\230xZ\230\129\214\157\148\217\170a\150$\211\154g\022\211\234\134\220"
                                                        r22 = 10328976052937
                                                        r25 = r24(r43, r22)
                                                        r18 = r52[r25]
                                                        r24 = upvalueValues[r8]
                                                        r43 = upvalueValues[upvalues[3]]
                                                        r22 = upvalueValues[upvalues[4]]
                                                        r12 = "\155\017\250\202"
                                                        r9 = 18368313106793
                                                        r35 = r22(r12, r9)
                                                        r25 = r43[r35]
                                                        r52 = r24[r25]
                                                        r34 = state(r18, r52, r50)
                                                        state = 175
                                                    end
                                                else
                                                    if state == 175 then
                                                        r16 = nil
                                                        r50 = nil
                                                        state = 173
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure4 entry 2499836 -> 176, states 176-180
                                        if state <= 178 then
                                            if state <= 177 then
                                                if state <= 176 then
                                                    if state == 176 then -- entry 2499836 -> 176
                                                        state = upvalueValues[upvalues[1]]
                                                        ReturnVal = state()
                                                        state = upvalueValues[upvalues[2]]
                                                        ReturnVal = state()
                                                        r28 = ReturnVal
                                                        state = r28 and (177) or (178)
                                                    end
                                                else
                                                    if state == 177 then
                                                        ReturnVal = {
                                                            r28
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state == 178 then
                                                    r41 = upvalueValues[upvalues[3]]
                                                    ReturnVal = #r41
                                                    r41 = 0
                                                    state = ReturnVal > r41
                                                    state = state and (179) or (180)
                                                end
                                            end
                                        else
                                            if state <= 179 then
                                                if state == 179 then
                                                    r41 = "table"
                                                    ReturnVal = _env[r41]
                                                    r38 = upvalueValues[upvalues[4]]
                                                    r44 = upvalueValues[upvalues[5]]
                                                    r16 = "_\141\228\0230\221"
                                                    r50 = 33061465521187
                                                    r8 = r44(r16, r50)
                                                    r41 = r38[r8]
                                                    state = ReturnVal[r41]
                                                    r41 = upvalueValues[upvalues[3]]
                                                    r38 = 1
                                                    ReturnVal = {
                                                        state(r41, r38)
                                                    }
                                                    ReturnVal = {
                                                        unpack(ReturnVal)
                                                    }
                                                    state = nil
                                                end
                                            else
                                                if state == 180 then
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
                                    -- createClosure5 entry 11779191 -> 181, states 181-191
                                    if state <= 186 then
                                        if state <= 183 then
                                            if state <= 182 then
                                                if state <= 181 then
                                                    if state == 181 then -- entry 11779191 -> 181
                                                        state = 182
                                                    end
                                                else
                                                    if state == 182 then
                                                        state = true
                                                        state = state and (183) or (184)
                                                    end
                                                end
                                            else
                                                if state == 183 then
                                                    ReturnVal = "ipairs"
                                                    state = _env[ReturnVal]
                                                    r38 = upvalueValues[upvalues[1]]
                                                    r8 = "GetChildren"
                                                    r8 = r38[r8]
                                                    r44 = {
                                                        r8(r38)
                                                    }
                                                    r38 = {
                                                        state(unpack(r44))
                                                    }
                                                    ReturnVal = r38[1]
                                                    r41 = r38[3]
                                                    r28 = r38[2]
                                                    r38 = ReturnVal
                                                    state = 185
                                                end
                                            end
                                        else
                                            if state <= 185 then
                                                if state <= 184 then
                                                    if state == 184 then
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                else
                                                    if state == 185 then
                                                        r41, r8 = r38(r28, r41)
                                                        state = r41 and (186) or (187)
                                                    end
                                                end
                                            else
                                                if state == 186 then
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r18 = upvalueValues[upvalues[3]]
                                                    r24 = "f\022\023\137\127"
                                                    r25 = 24077278997451
                                                    r52 = r18(r24, r25)
                                                    r50 = r34[r52]
                                                    r16 = "GetAttribute"
                                                    r16 = r8[r16]
                                                    r16 = r16(r8, r50)
                                                    r34 = upvalueValues[upvalues[4]]
                                                    r52 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r22 = 11668647826745
                                                    r43 = "\012,\233\232"
                                                    r25 = r24(r43, r22)
                                                    r18 = r52[r25]
                                                    r50 = r34[r18]
                                                    state = r16 == r50
                                                    state = state and (188) or (189)
                                                    r44 = r41
                                                end
                                            end
                                        end
                                    else
                                        if state <= 189 then
                                            if state <= 188 then
                                                if state <= 187 then
                                                    if state == 187 then
                                                        r41 = "task"
                                                        r28 = _env[r41]
                                                        r38 = upvalueValues[upvalues[2]]
                                                        r44 = upvalueValues[upvalues[3]]
                                                        r16 = "Z5\141\179"
                                                        r50 = 3626624911000
                                                        r8 = r44(r16, r50)
                                                        r41 = r38[r8]
                                                        state = r28[r41]
                                                        r41 = 1
                                                        r28 = state(r41)
                                                        state = 182
                                                    end
                                                else
                                                    if state == 188 then
                                                        r50 = upvalueValues[upvalues[2]]
                                                        r34 = upvalueValues[upvalues[3]]
                                                        r24 = 31800875448792
                                                        r52 = "\165v\016\192"
                                                        r18 = r34(r52, r24)
                                                        r16 = r50[r18]
                                                        state = "GetAttribute"
                                                        state = r8[state]
                                                        state = state(r8, r16)
                                                        r16 = state
                                                        state = r16 and (190) or (191)
                                                    end
                                                end
                                            else
                                                if state == 189 then
                                                    r8 = nil
                                                    r44 = nil
                                                    state = 185
                                                end
                                            end
                                        else
                                            if state <= 190 then
                                                if state == 190 then
                                                    state = upvalueValues[upvalues[5]]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r50 = "FireServer"
                                                    r50 = state[r50]
                                                    r52 = upvalueValues[upvalues[3]]
                                                    r25 = "\250\161\238\"\030\190\r-\238{"
                                                    r43 = 9943835496982
                                                    r24 = r52(r25, r43)
                                                    r34 = r18[r24]
                                                    r50 = r50(state, r34, r16)
                                                    state = 191
                                                end
                                            else
                                                if state == 191 then
                                                    r16 = nil
                                                    state = 189
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 229 then
                                    if state <= 216 then
                                        -- createClosure2 entry 4025976 -> 192, states 192-216
                                        if state <= 204 then
                                            if state <= 198 then
                                                if state <= 195 then
                                                    if state <= 193 then
                                                        if state <= 192 then
                                                            if state == 192 then -- entry 4025976 -> 192
                                                                state = upvalueValues[upvalues[1]]
                                                                r41 = upvalueValues[upvalues[2]]
                                                                r38 = upvalueValues[upvalues[3]]
                                                                ReturnVal = "WaitForChild"
                                                                ReturnVal = state[ReturnVal]
                                                                r16 = 27943011316435
                                                                r8 = "g\153e\180\231\251\016\243\199g"
                                                                r44 = r38(r8, r16)
                                                                r28 = r41[r44]
                                                                ReturnVal = ReturnVal(state, r28)
                                                                r41 = upvalueValues[upvalues[2]]
                                                                state = "WaitForChild"
                                                                state = ReturnVal[state]
                                                                r38 = upvalueValues[upvalues[3]]
                                                                r8 = "\190\025j\203\184\222\253\203\177\218\214\135\193"
                                                                r16 = 33335723556003
                                                                r44 = r38(r8, r16)
                                                                r28 = r41[r44]
                                                                state = state(ReturnVal, r28)
                                                                r28 = allocUpvalue()
                                                                upvalueValues[r28] = state
                                                                state = 0
                                                                r41 = state
                                                                ReturnVal = "ipairs"
                                                                state = _env[ReturnVal]
                                                                r8 = upvalueValues[upvalues[4]]
                                                                r50 = "GetChildren"
                                                                r50 = r8[r50]
                                                                r16 = {
                                                                    r50(r8)
                                                                }
                                                                r8 = {
                                                                    state(unpack(r16))
                                                                }
                                                                r44 = r8[3]
                                                                r38 = r8[2]
                                                                ReturnVal = r8[1]
                                                                r8 = ReturnVal
                                                                state = 193
                                                            end
                                                        else
                                                            if state == 193 then
                                                                r44, r50 = r8(r38, r44)
                                                                state = r44 and (194) or (195)
                                                            end
                                                        end
                                                    else
                                                        if state <= 194 then
                                                            if state == 194 then
                                                                state = allocUpvalue()
                                                                upvalueValues[state] = r50
                                                                r50 = state
                                                                r18 = upvalueValues[upvalues[5]]
                                                                r24 = upvalueValues[r50]
                                                                r52 = r18(r24)
                                                                state = r52 and (196) or (197)
                                                                r16 = r44
                                                                r34 = r52
                                                            end
                                                        else
                                                            if state == 195 then
                                                                r38 = upvalueValues[upvalues[6]]
                                                                state = r38 and (198) or (199)
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 197 then
                                                        if state <= 196 then
                                                            if state == 196 then
                                                                r52 = upvalueValues[r50]
                                                                r43 = upvalueValues[upvalues[2]]
                                                                r24 = "GetAttribute"
                                                                r24 = r52[r24]
                                                                r22 = upvalueValues[upvalues[3]]
                                                                r12 = "\205"
                                                                r9 = 4725341259928
                                                                r35 = r22(r12, r9)
                                                                r25 = r43[r35]
                                                                r24 = r24(r52, r25)
                                                                r52 = true
                                                                r18 = r24 == r52
                                                                r34 = r18
                                                                state = 197
                                                            end
                                                        else
                                                            if state == 197 then
                                                                state = r34 and (200) or (201)
                                                            end
                                                        end
                                                    else
                                                        if state == 198 then
                                                            r44 = "ipairs"
                                                            r38 = _env[r44]
                                                            r50 = upvalueValues[upvalues[6]]
                                                            r18 = "GetChildren"
                                                            r18 = r50[r18]
                                                            r34 = {
                                                                r18(r50)
                                                            }
                                                            r50 = {
                                                                r38(unpack(r34))
                                                            }
                                                            r44 = r50[1]
                                                            r16 = r50[3]
                                                            r8 = r50[2]
                                                            state = 202
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 201 then
                                                    if state <= 200 then
                                                        if state <= 199 then
                                                            if state == 199 then
                                                                r44 = 0
                                                                r38 = r41 > r44
                                                                state = r38 and (203) or (204)
                                                            end
                                                        else
                                                            if state == 200 then
                                                                r34 = "pcall"
                                                                state = _env[r34]
                                                                r52 = createClosure1(272, {
                                                                    r28,
                                                                    r50
                                                                })
                                                                r24 = {
                                                                    state(r52)
                                                                }
                                                                r34 = r24[1]
                                                                state = r34 and (205) or (206)
                                                                r18 = r24[2]
                                                            end
                                                        end
                                                    else
                                                        if state == 201 then
                                                            r50 = releaseUpvalue(r50)
                                                            r16 = nil
                                                            state = 193
                                                        end
                                                    end
                                                else
                                                    if state <= 203 then
                                                        if state <= 202 then
                                                            if state == 202 then
                                                                r16, r50 = r44(r8, r16)
                                                                state = r16 and (207) or (208)
                                                            end
                                                        else
                                                            if state == 203 then
                                                                r44 = "print"
                                                                r38 = _env[r44]
                                                                r16 = upvalueValues[upvalues[2]]
                                                                r50 = upvalueValues[upvalues[3]]
                                                                r52 = "\"\tw.\139\253\r\180_\235\181\r\132\144\141\024\220\169+3\196\216m\189Q\148\137`8X\171\185"
                                                                r24 = 27784163537546
                                                                r18 = r50(r52, r24)
                                                                r8 = r16[r18]
                                                                r44 = r38(r8, r41)
                                                                state = 204
                                                            end
                                                        end
                                                    else
                                                        if state == 204 then
                                                            ReturnVal = {}
                                                            r28 = releaseUpvalue(r28)
                                                            r41 = nil
                                                            state = nil
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 210 then
                                                if state <= 207 then
                                                    if state <= 206 then
                                                        if state <= 205 then
                                                            if state == 205 then
                                                                r52 = "print"
                                                                state = _env[r52]
                                                                r25 = upvalueValues[upvalues[2]]
                                                                r43 = upvalueValues[upvalues[3]]
                                                                r12 = 3087615280541
                                                                r35 = ")\018\1857r\242\t&\245F\130{\176a,\127\135#\242\232cp@x\212~\195\239K{\221m\237\170\140\131J"
                                                                r22 = r43(r35, r12)
                                                                r24 = r25[r22]
                                                                r43 = upvalueValues[r50]
                                                                r35 = upvalueValues[upvalues[2]]
                                                                r12 = upvalueValues[upvalues[3]]
                                                                r6 = 16519664557580
                                                                r4 = "g4mC"
                                                                r9 = r12(r4, r6)
                                                                r22 = r35[r9]
                                                                r25 = r43[r22]
                                                                r52 = state(r24, r25)
                                                                r52 = 1
                                                                state = r41 + r52
                                                                r41 = state
                                                                state = 209
                                                            end
                                                        else
                                                            if state == 206 then
                                                                r24 = "warn"
                                                                r52 = _env[r24]
                                                                r43 = upvalueValues[upvalues[2]]
                                                                r22 = upvalueValues[upvalues[3]]
                                                                r12 = "\251\233L\132\136\248y)\210\159S\173\242>\168G\178\016\171E\211\251\012\133\024\207lMy\142?\0241'\232\136\242"
                                                                r9 = 27238772388236
                                                                r35 = r22(r12, r9)
                                                                r25 = r43[r35]
                                                                r22 = upvalueValues[r50]
                                                                r12 = upvalueValues[upvalues[2]]
                                                                r9 = upvalueValues[upvalues[3]]
                                                                r32 = 27333485752760
                                                                r6 = "U\205]p"
                                                                r4 = r9(r6, r32)
                                                                r35 = r12[r4]
                                                                r43 = r22[r35]
                                                                r24 = r52(r25, r43, r18)
                                                                state = 209
                                                            end
                                                        end
                                                    else
                                                        if state == 207 then
                                                            r34 = allocUpvalue()
                                                            upvalueValues[r34] = r50
                                                            r50 = r34
                                                            r52 = upvalueValues[upvalues[5]]
                                                            r25 = upvalueValues[r50]
                                                            r24 = r52(r25)
                                                            r18 = state
                                                            state = r24 and (210) or (211)
                                                            r38 = r16
                                                            r34 = r24
                                                        end
                                                    end
                                                else
                                                    if state <= 209 then
                                                        if state <= 208 then
                                                            if state == 208 then
                                                                state = 199
                                                            end
                                                        else
                                                            if state == 209 then
                                                                r18 = nil
                                                                r34 = nil
                                                                state = 201
                                                            end
                                                        end
                                                    else
                                                        if state == 210 then
                                                            r24 = upvalueValues[r50]
                                                            r22 = upvalueValues[upvalues[2]]
                                                            r35 = upvalueValues[upvalues[3]]
                                                            r9 = "O"
                                                            r4 = 30074910258868
                                                            r12 = r35(r9, r4)
                                                            r43 = r22[r12]
                                                            r25 = "GetAttribute"
                                                            r25 = r24[r25]
                                                            r25 = r25(r24, r43)
                                                            r24 = true
                                                            r52 = r25 == r24
                                                            r34 = r52
                                                            state = 211
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 213 then
                                                    if state <= 212 then
                                                        if state <= 211 then
                                                            if state == 211 then
                                                                state = r18
                                                                state = r34 and (212) or (213)
                                                            end
                                                        else
                                                            if state == 212 then
                                                                r24 = createClosure2(273, {
                                                                    r28,
                                                                    r50
                                                                })
                                                                r18 = "pcall"
                                                                r34 = _env[r18]
                                                                r25 = {
                                                                    r34(r24)
                                                                }
                                                                r18 = r25[1]
                                                                state = r18 and (214) or (215)
                                                                r52 = r25[2]
                                                            end
                                                        end
                                                    else
                                                        if state == 213 then
                                                            r50 = releaseUpvalue(r50)
                                                            r38 = nil
                                                            state = 202
                                                        end
                                                    end
                                                else
                                                    if state <= 215 then
                                                        if state <= 214 then
                                                            if state == 214 then
                                                                r24 = "print"
                                                                r34 = _env[r24]
                                                                r43 = upvalueValues[upvalues[2]]
                                                                r22 = upvalueValues[upvalues[3]]
                                                                r12 = "m\185\207\203\2148Y(\162m\241\217b\215\194\144xl\160\165\150\159`V\127\0058\219X\231Q\129ww"
                                                                r9 = 19965303678033
                                                                r35 = r22(r12, r9)
                                                                r25 = r43[r35]
                                                                r22 = upvalueValues[r50]
                                                                r12 = upvalueValues[upvalues[2]]
                                                                r9 = upvalueValues[upvalues[3]]
                                                                r6 = "\030\229\184N"
                                                                r32 = 22663683320121
                                                                r4 = r9(r6, r32)
                                                                r35 = r12[r4]
                                                                r43 = r22[r35]
                                                                r24 = r34(r25, r43)
                                                                r24 = 1
                                                                r34 = r41 + r24
                                                                r41 = r34
                                                                state = 216
                                                            end
                                                        else
                                                            if state == 215 then
                                                                r25 = "warn"
                                                                r24 = _env[r25]
                                                                r22 = upvalueValues[upvalues[2]]
                                                                r35 = upvalueValues[upvalues[3]]
                                                                r9 = "\191\015\199\144W\231v\2214\145v\245\162I\226\014\212\022\213x\162\001\197\134\2490\160\155\0246\019\233\215G"
                                                                r4 = 3174028838342
                                                                r12 = r35(r9, r4)
                                                                r43 = r22[r12]
                                                                r35 = upvalueValues[r50]
                                                                r9 = upvalueValues[upvalues[2]]
                                                                r4 = upvalueValues[upvalues[3]]
                                                                r29 = 14767856720604
                                                                r32 = "\197\004\149%"
                                                                r6 = r4(r32, r29)
                                                                r12 = r9[r6]
                                                                r22 = r35[r12]
                                                                r25 = r24(r43, r22, r52)
                                                                state = 216
                                                            end
                                                        end
                                                    else
                                                        if state == 216 then
                                                            r18 = nil
                                                            r52 = nil
                                                            state = 213
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure1 entry 9642316 -> 217, states 217-229
                                        if state <= 223 then
                                            if state <= 220 then
                                                if state <= 218 then
                                                    if state <= 217 then
                                                        if state == 217 then -- entry 9642316 -> 217
                                                            state = upvalueValues[upvalues[1]]
                                                            ReturnVal = state()
                                                            ReturnVal = "ipairs"
                                                            state = _env[ReturnVal]
                                                            r38 = upvalueValues[upvalues[2]]
                                                            r8 = "GetChildren"
                                                            r8 = r38[r8]
                                                            r44 = {
                                                                r8(r38)
                                                            }
                                                            r38 = {
                                                                state(unpack(r44))
                                                            }
                                                            r28 = r38[2]
                                                            ReturnVal = r38[1]
                                                            r41 = r38[3]
                                                            r38 = ReturnVal
                                                            state = 218
                                                        end
                                                    else
                                                        if state == 218 then
                                                            r41, r8 = r38(r28, r41)
                                                            state = r41 and (219) or (220)
                                                        end
                                                    end
                                                else
                                                    if state <= 219 then
                                                        if state == 219 then
                                                            r50 = upvalueValues[upvalues[3]]
                                                            r34 = r50(r8)
                                                            state = r34 and (221) or (222)
                                                            r16 = r34
                                                            r44 = r41
                                                        end
                                                    else
                                                        if state == 220 then
                                                            r28 = "ipairs"
                                                            state = _env[r28]
                                                            r44 = upvalueValues[upvalues[2]]
                                                            r16 = "GetChildren"
                                                            r16 = r44[r16]
                                                            r8 = {
                                                                r16(r44)
                                                            }
                                                            r44 = {
                                                                state(unpack(r8))
                                                            }
                                                            r28 = r44[1]
                                                            r38 = r44[3]
                                                            r41 = r44[2]
                                                            state = 223
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 222 then
                                                    if state <= 221 then
                                                        if state == 221 then
                                                            r50 = upvalueValues[upvalues[4]]
                                                            r24 = upvalueValues[upvalues[5]]
                                                            r25 = upvalueValues[upvalues[6]]
                                                            r35 = 6692571270188
                                                            r22 = "?\239\146\249"
                                                            r43 = r25(r22, r35)
                                                            r52 = r24[r43]
                                                            r18 = r8[r52]
                                                            r34 = r50(r18)
                                                            r16 = r34
                                                            state = 222
                                                        end
                                                    else
                                                        if state == 222 then
                                                            state = r16 and (224) or (225)
                                                        end
                                                    end
                                                else
                                                    if state == 223 then
                                                        r38, r8 = r28(r41, r38)
                                                        state = r38 and (226) or (227)
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 226 then
                                                if state <= 225 then
                                                    if state <= 224 then
                                                        if state == 224 then
                                                            ReturnVal = {
                                                                r8
                                                            }
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 225 then
                                                            r8 = nil
                                                            r44 = nil
                                                            state = 218
                                                        end
                                                    end
                                                else
                                                    if state == 226 then
                                                        state = upvalueValues[upvalues[3]]
                                                        r16 = state(r8)
                                                        state = r16 and (228) or (229)
                                                        r44 = r38
                                                    end
                                                end
                                            else
                                                if state <= 228 then
                                                    if state <= 227 then
                                                        if state == 227 then
                                                            state = nil
                                                            ReturnVal = {
                                                                state
                                                            }
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 228 then
                                                            ReturnVal = {
                                                                r8
                                                            }
                                                            state = nil
                                                        end
                                                    end
                                                else
                                                    if state == 229 then
                                                        r44 = nil
                                                        r8 = nil
                                                        state = 223
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure2 entry 12334368 -> 230, states 230-240
                                    if state <= 235 then
                                        if state <= 232 then
                                            if state <= 231 then
                                                if state <= 230 then
                                                    if state == 230 then -- entry 12334368 -> 230
                                                        ReturnVal = "ipairs"
                                                        state = _env[ReturnVal]
                                                        r38 = upvalueValues[upvalues[1]]
                                                        r8 = "GetChildren"
                                                        r8 = r38[r8]
                                                        r44 = {
                                                            r8(r38)
                                                        }
                                                        r38 = {
                                                            state(unpack(r44))
                                                        }
                                                        r41 = r38[3]
                                                        r28 = r38[2]
                                                        ReturnVal = r38[1]
                                                        r38 = ReturnVal
                                                        state = 231
                                                    end
                                                else
                                                    if state == 231 then
                                                        r41, r8 = r38(r28, r41)
                                                        state = r41 and (232) or (233)
                                                    end
                                                end
                                            else
                                                if state == 232 then
                                                    state = allocUpvalue()
                                                    upvalueValues[state] = r8
                                                    r8 = state
                                                    r50 = upvalueValues[upvalues[2]]
                                                    r18 = upvalueValues[r8]
                                                    r34 = r50(r18)
                                                    state = r34 and (234) or (235)
                                                    r16 = r34
                                                    r44 = r41
                                                end
                                            end
                                        else
                                            if state <= 234 then
                                                if state <= 233 then
                                                    if state == 233 then
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                else
                                                    if state == 234 then
                                                        r34 = upvalueValues[r8]
                                                        r24 = upvalueValues[upvalues[3]]
                                                        r25 = upvalueValues[upvalues[4]]
                                                        r35 = 34442715266726
                                                        r22 = "\167"
                                                        r43 = r25(r22, r35)
                                                        r18 = "GetAttribute"
                                                        r18 = r34[r18]
                                                        r52 = r24[r43]
                                                        r18 = r18(r34, r52)
                                                        r34 = true
                                                        r50 = r18 == r34
                                                        r16 = r50
                                                        state = 235
                                                    end
                                                end
                                            else
                                                if state == 235 then
                                                    state = r16 and (236) or (237)
                                                end
                                            end
                                        end
                                    else
                                        if state <= 238 then
                                            if state <= 237 then
                                                if state <= 236 then
                                                    if state == 236 then
                                                        r34 = createClosure4(274, {
                                                            upvalues[3],
                                                            upvalues[4],
                                                            r8
                                                        })
                                                        r16 = "pcall"
                                                        state = _env[r16]
                                                        r18 = {
                                                            state(r34)
                                                        }
                                                        r16 = r18[1]
                                                        state = r16 and (238) or (239)
                                                        r50 = r18[2]
                                                    end
                                                else
                                                    if state == 237 then
                                                        r8 = releaseUpvalue(r8)
                                                        r44 = nil
                                                        state = 231
                                                    end
                                                end
                                            else
                                                if state == 238 then
                                                    r34 = "print"
                                                    state = _env[r34]
                                                    r52 = upvalueValues[upvalues[3]]
                                                    r24 = upvalueValues[upvalues[4]]
                                                    r43 = "fX\175T\181\164D\143*\213#\143\211\2165\236\204n\018,\143\208\156V\2172F\1863\026\153|@eV\135/"
                                                    r22 = 26384292720638
                                                    r25 = r24(r43, r22)
                                                    r18 = r52[r25]
                                                    r24 = upvalueValues[r8]
                                                    r43 = upvalueValues[upvalues[3]]
                                                    r22 = upvalueValues[upvalues[4]]
                                                    r12 = "'9U\152"
                                                    r9 = 8815477837833
                                                    r35 = r22(r12, r9)
                                                    r25 = r43[r35]
                                                    r52 = r24[r25]
                                                    r34 = state(r18, r52)
                                                    state = 240
                                                end
                                            end
                                        else
                                            if state <= 239 then
                                                if state == 239 then
                                                    r34 = "warn"
                                                    state = _env[r34]
                                                    r52 = upvalueValues[upvalues[3]]
                                                    r24 = upvalueValues[upvalues[4]]
                                                    r22 = 22010560194569
                                                    r43 = "J\160a\163\176\184\147\196O\\:\2345Xq\224\001\154\253*Na\228Ky"
                                                    r25 = r24(r43, r22)
                                                    r18 = r52[r25]
                                                    r24 = upvalueValues[r8]
                                                    r43 = upvalueValues[upvalues[3]]
                                                    r22 = upvalueValues[upvalues[4]]
                                                    r12 = "f\179\210&"
                                                    r9 = 24391867149406
                                                    r35 = r22(r12, r9)
                                                    r25 = r43[r35]
                                                    r52 = r24[r25]
                                                    r34 = state(r18, r52, r50)
                                                    state = 240
                                                end
                                            else
                                                if state == 240 then
                                                    r16 = nil
                                                    r50 = nil
                                                    state = 237
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 265 then
                                if state <= 264 then
                                    if state <= 243 then
                                        -- createClosure0 entry 16291391 -> 241, states 241-243
                                        if state <= 242 then
                                            if state <= 241 then
                                                if state == 241 then -- entry 16291391 -> 241
                                                    ReturnVal = "pcall"
                                                    state = _env[ReturnVal]
                                                    r41 = createClosure2(275, {
                                                        upvalues[1],
                                                        upvalues[2]
                                                    })
                                                    r38 = {
                                                        state(r41)
                                                    }
                                                    ReturnVal = r38[1]
                                                    r41 = ReturnVal
                                                    state = not r41
                                                    state = state and (242) or (243)
                                                    r28 = r38[2]
                                                end
                                            else
                                                if state == 242 then
                                                    ReturnVal = "warn"
                                                    state = _env[ReturnVal]
                                                    r44 = upvalueValues[upvalues[1]]
                                                    r8 = upvalueValues[upvalues[2]]
                                                    r34 = 6991750171831
                                                    r50 = "\243\250\151n\\G\030\133\231w~\171s]\231.\181_<\171\228\027\231\196\207\238\150\134\148\225"
                                                    r16 = r8(r50, r34)
                                                    r38 = r44[r16]
                                                    ReturnVal = state(r38, r28)
                                                    state = 243
                                                end
                                            end
                                        else
                                            if state == 243 then
                                                r28 = nil
                                                r41 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        -- createClosure0 entry 121739 -> 244, states 244-264
                                        if state <= 254 then
                                            if state <= 249 then
                                                if state <= 246 then
                                                    if state <= 245 then
                                                        if state <= 244 then
                                                            if state == 244 then -- entry 121739 -> 244
                                                                state = upvalueValues[upvalues[1]]
                                                                ReturnVal = state()
                                                                state = upvalueValues[upvalues[2]]
                                                                ReturnVal = state()
                                                                state = upvalueValues[upvalues[3]]
                                                                ReturnVal = state()
                                                                state = upvalueValues[upvalues[4]]
                                                                ReturnVal = state()
                                                                ReturnVal = "print"
                                                                state = _env[ReturnVal]
                                                                r41 = upvalueValues[upvalues[5]]
                                                                r38 = upvalueValues[upvalues[6]]
                                                                r16 = 8671955701702
                                                                r8 = "\131\140\175\144c\179@\226\250\215q\140/}\001\189\130\019VX\129%"
                                                                r44 = r38(r8, r16)
                                                                r28 = r41[r44]
                                                                ReturnVal = state(r28)
                                                                ReturnVal = "print"
                                                                state = _env[ReturnVal]
                                                                r41 = upvalueValues[upvalues[5]]
                                                                r38 = upvalueValues[upvalues[6]]
                                                                r16 = 16935585668814
                                                                r8 = "\225\145\002\020\000\025\252\221\215P\228\243\144\183\189\199\005r\145\138\177'3\219\226\1396N\019g\184\208E\177\146\030T\210\0056\142\246I\247>\145\132\234DP\226\004.zSY\232\027L5\226\206B\233\189.$\211\148\198\203\132\197|\022\174\007\214\161\242\169\204\151\177\016\194AY\212\249\214\138;\177\249Y\181C\003\150\245]\146\244\233\128\011\004\162\202\249\161\0249\159\205\004De\181be\235_\181I8\133\029\196\161"
                                                                r44 = r38(r8, r16)
                                                                r28 = r41[r44]
                                                                ReturnVal = state(r28)
                                                                ReturnVal = "print"
                                                                state = _env[ReturnVal]
                                                                r41 = upvalueValues[upvalues[5]]
                                                                r38 = upvalueValues[upvalues[6]]
                                                                r16 = 22608893634848
                                                                r8 = "\"\252\225\200%\231\155\1967.\147%\022\158\251T\254\226\029\167\207\160N\218\018.q.\198\162\197\017\165\014\252\180\230W\015\244rv\198\n\006fP\028\129\196\245V9]D\167\131aa\215\223{V\146DB$\150\029\237%\221"
                                                                r44 = r38(r8, r16)
                                                                r28 = r41[r44]
                                                                ReturnVal = state(r28)
                                                                state = 245
                                                            end
                                                        else
                                                            if state == 245 then
                                                                state = true
                                                                state = state and (246) or (247)
                                                            end
                                                        end
                                                    else
                                                        if state == 246 then
                                                            r28 = "task"
                                                            ReturnVal = _env[r28]
                                                            r41 = upvalueValues[upvalues[5]]
                                                            r38 = upvalueValues[upvalues[6]]
                                                            r16 = 1430594929306
                                                            r8 = "\170h\141!"
                                                            r44 = r38(r8, r16)
                                                            r28 = r41[r44]
                                                            state = ReturnVal[r28]
                                                            r28 = 0.1
                                                            ReturnVal = state(r28)
                                                            ReturnVal = upvalueValues[upvalues[7]]
                                                            r28 = ReturnVal()
                                                            state = not r28
                                                            state = state and (248) or (249)
                                                        end
                                                    end
                                                else
                                                    if state <= 248 then
                                                        if state <= 247 then
                                                            if state == 247 then
                                                                ReturnVal = {}
                                                                state = nil
                                                            end
                                                        else
                                                            if state == 248 then
                                                                state = upvalueValues[upvalues[8]]
                                                                ReturnVal = state()
                                                                upvalueValues[upvalues[9]] = ReturnVal
                                                                state = upvalueValues[upvalues[9]]
                                                                state = state and (250) or (251)
                                                            end
                                                        end
                                                    else
                                                        if state == 249 then
                                                            r41 = upvalueValues[upvalues[9]]
                                                            state = r41 and (252) or (253)
                                                            r28 = r41
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 252 then
                                                    if state <= 251 then
                                                        if state <= 250 then
                                                            if state == 250 then
                                                                r28 = "print"
                                                                state = _env[r28]
                                                                r38 = upvalueValues[upvalues[5]]
                                                                r44 = upvalueValues[upvalues[6]]
                                                                r16 = "\143\157\231Q\208d\219m\202~\222B\011}(\175/\157\2080"
                                                                r50 = 15086937119601
                                                                r8 = r44(r16, r50)
                                                                r41 = r38[r8]
                                                                r44 = upvalueValues[upvalues[9]]
                                                                r16 = upvalueValues[upvalues[5]]
                                                                r50 = upvalueValues[upvalues[6]]
                                                                r18 = "Q\232\215\179"
                                                                r52 = 27334234894776
                                                                r34 = r50(r18, r52)
                                                                r8 = r16[r34]
                                                                r38 = r44[r8]
                                                                r28 = state(r41, r38)
                                                                state = 251
                                                            end
                                                        else
                                                            if state == 251 then
                                                                state = 249
                                                            end
                                                        end
                                                    else
                                                        if state == 252 then
                                                            r41 = upvalueValues[upvalues[7]]
                                                            r38 = r41()
                                                            r28 = r38
                                                            state = 253
                                                        end
                                                    end
                                                else
                                                    if state <= 253 then
                                                        if state == 253 then
                                                            state = r28 and (254) or (255)
                                                        end
                                                    else
                                                        if state == 254 then
                                                            state = upvalueValues[upvalues[10]]
                                                            r38 = upvalueValues[upvalues[5]]
                                                            r44 = upvalueValues[upvalues[6]]
                                                            r16 = "D\206D/"
                                                            r50 = 4518210209847
                                                            r8 = r44(r16, r50)
                                                            r28 = "FindFirstChildWhichIsA"
                                                            r28 = state[r28]
                                                            r41 = r38[r8]
                                                            r28 = r28(state, r41)
                                                            state = r28 and (256) or (257)
                                                            r41 = r28
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 259 then
                                                if state <= 257 then
                                                    if state <= 256 then
                                                        if state <= 255 then
                                                            if state == 255 then
                                                                r38 = "task"
                                                                r41 = _env[r38]
                                                                r44 = upvalueValues[upvalues[5]]
                                                                r8 = upvalueValues[upvalues[6]]
                                                                r50 = "\172\208\225n"
                                                                r34 = 31743617235389
                                                                r16 = r8(r50, r34)
                                                                r38 = r44[r16]
                                                                r28 = r41[r38]
                                                                r38 = 1
                                                                r41 = r28(r38)
                                                                state = 258
                                                            end
                                                        else
                                                            if state == 256 then
                                                                r16 = upvalueValues[upvalues[5]]
                                                                r50 = upvalueValues[upvalues[6]]
                                                                r44 = "GetAttribute"
                                                                r44 = r28[r44]
                                                                r52 = 31606601677181
                                                                r18 = "(\240\002E\227\163\186A"
                                                                r34 = r50(r18, r52)
                                                                r8 = r16[r34]
                                                                r44 = r44(r28, r8)
                                                                r16 = upvalueValues[upvalues[5]]
                                                                r50 = upvalueValues[upvalues[6]]
                                                                r52 = 19388635177796
                                                                r18 = "b\187\253"
                                                                r34 = r50(r18, r52)
                                                                r8 = r16[r34]
                                                                r38 = r44 == r8
                                                                r41 = r38
                                                                state = 257
                                                            end
                                                        end
                                                    else
                                                        if state == 257 then
                                                            state = r41 and (259) or (260)
                                                        end
                                                    end
                                                else
                                                    if state <= 258 then
                                                        if state == 258 then
                                                            state = 245
                                                        end
                                                    else
                                                        if state == 259 then
                                                            state = upvalueValues[upvalues[11]]
                                                            r41 = "GivePet"
                                                            r41 = state[r41]
                                                            r38 = upvalueValues[upvalues[9]]
                                                            r41 = r41(state, r38)
                                                            r41 = "print"
                                                            state = _env[r41]
                                                            r44 = upvalueValues[upvalues[5]]
                                                            r8 = upvalueValues[upvalues[6]]
                                                            r34 = 31851695962608
                                                            r50 = "\218\207\206V\210\174&"
                                                            r16 = r8(r50, r34)
                                                            r38 = r44[r16]
                                                            r16 = upvalueValues[upvalues[5]]
                                                            r50 = upvalueValues[upvalues[6]]
                                                            r52 = 26497139830834
                                                            r18 = "\204Hsx"
                                                            r34 = r50(r18, r52)
                                                            r8 = r16[r34]
                                                            r44 = r28[r8]
                                                            r16 = upvalueValues[upvalues[5]]
                                                            r50 = upvalueValues[upvalues[6]]
                                                            r52 = 4169566750613
                                                            r18 = "\198\156"
                                                            r34 = r50(r18, r52)
                                                            r8 = r16[r34]
                                                            r50 = upvalueValues[upvalues[9]]
                                                            r18 = upvalueValues[upvalues[5]]
                                                            r52 = upvalueValues[upvalues[6]]
                                                            r25 = "?\173\234\015"
                                                            r43 = 19331007177513
                                                            r24 = r52(r25, r43)
                                                            r34 = r18[r24]
                                                            r16 = r50[r34]
                                                            r41 = state(r38, r44, r8, r16)
                                                            r38 = "task"
                                                            r41 = _env[r38]
                                                            r44 = upvalueValues[upvalues[5]]
                                                            r8 = upvalueValues[upvalues[6]]
                                                            r34 = 29671168685560
                                                            r50 = "\229\217O\151"
                                                            r16 = r8(r50, r34)
                                                            r38 = r44[r16]
                                                            state = r41[r38]
                                                            r38 = 0.1
                                                            r41 = state(r38)
                                                            state = upvalueValues[upvalues[12]]
                                                            r41 = "UnequipTools"
                                                            r41 = state[r41]
                                                            r41 = r41(state)
                                                            r38 = "task"
                                                            r41 = _env[r38]
                                                            r44 = upvalueValues[upvalues[5]]
                                                            r8 = upvalueValues[upvalues[6]]
                                                            r34 = 18937423487602
                                                            r50 = "\216\247\214C"
                                                            r16 = r8(r50, r34)
                                                            r38 = r44[r16]
                                                            state = r41[r38]
                                                            r38 = 0.1
                                                            r41 = state(r38)
                                                            state = 261
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 262 then
                                                    if state <= 261 then
                                                        if state <= 260 then
                                                            if state == 260 then
                                                                state = upvalueValues[upvalues[13]]
                                                                r41 = state()
                                                                state = r41 and (262) or (263)
                                                            end
                                                        else
                                                            if state == 261 then
                                                                r28 = nil
                                                                state = 258
                                                            end
                                                        end
                                                    else
                                                        if state == 262 then
                                                            state = upvalueValues[upvalues[12]]
                                                            r38 = "EquipTool"
                                                            r38 = state[r38]
                                                            r38 = r38(state, r41)
                                                            r38 = "print"
                                                            state = _env[r38]
                                                            r8 = upvalueValues[upvalues[5]]
                                                            r16 = upvalueValues[upvalues[6]]
                                                            r18 = 11930798626227
                                                            r34 = "\143\243C\247\168\183v\217i\008\190t\190K\157Wag+\tM"
                                                            r50 = r16(r34, r18)
                                                            r44 = r8[r50]
                                                            r50 = upvalueValues[upvalues[5]]
                                                            r34 = upvalueValues[upvalues[6]]
                                                            r52 = "\203\202\221\142"
                                                            r24 = 28929511847071
                                                            r18 = r34(r52, r24)
                                                            r16 = r50[r18]
                                                            r8 = r41[r16]
                                                            r38 = state(r44, r8)
                                                            r44 = "task"
                                                            r38 = _env[r44]
                                                            r8 = upvalueValues[upvalues[5]]
                                                            r16 = upvalueValues[upvalues[6]]
                                                            r34 = "\198O\130\240"
                                                            r18 = 8473223909225
                                                            r50 = r16(r34, r18)
                                                            r44 = r8[r50]
                                                            state = r38[r44]
                                                            r44 = 0.1
                                                            r38 = state(r44)
                                                            state = 264
                                                        end
                                                    end
                                                else
                                                    if state <= 263 then
                                                        if state == 263 then
                                                            r38 = "print"
                                                            state = _env[r38]
                                                            r8 = upvalueValues[upvalues[5]]
                                                            r16 = upvalueValues[upvalues[6]]
                                                            r34 = "\007\193K\215\210I\191#\127Y\006\207q\241\149k\157\r\174\247I\249\026"
                                                            r18 = 22928139397556
                                                            r50 = r16(r34, r18)
                                                            r44 = r8[r50]
                                                            r16 = upvalueValues[upvalues[9]]
                                                            r34 = upvalueValues[upvalues[5]]
                                                            r18 = upvalueValues[upvalues[6]]
                                                            r24 = "\206\210\t\000"
                                                            r25 = 33441518091476
                                                            r52 = r18(r24, r25)
                                                            r50 = r34[r52]
                                                            r8 = r16[r50]
                                                            r38 = state(r44, r8)
                                                            state = nil
                                                            upvalueValues[upvalues[9]] = state
                                                            r8 = "task"
                                                            r44 = _env[r8]
                                                            r16 = upvalueValues[upvalues[5]]
                                                            r50 = upvalueValues[upvalues[6]]
                                                            r18 = "\000\1660\023"
                                                            r52 = 34857516629863
                                                            r34 = r50(r18, r52)
                                                            r8 = r16[r34]
                                                            r38 = r44[r8]
                                                            r8 = 1
                                                            r44 = r38(r8)
                                                            state = 264
                                                        end
                                                    else
                                                        if state == 264 then
                                                            r41 = nil
                                                            state = 261
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure1 entry 6704154 -> 265, states 265-265
                                    if state == 265 then -- entry 6704154 -> 265
                                        r38 = 10279567
                                        r41 = "Nr86"
                                        r28 = r41 ^ r38
                                        ReturnVal = 2650968
                                        state = ReturnVal - r28
                                        r28 = state
                                        ReturnVal = "E8DKSPKYpbSOA"
                                        state = ReturnVal / r28
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 266 then
                                    -- createClosure0 entry 7030097 -> 266, states 266-266
                                    if state == 266 then -- entry 7030097 -> 266
                                        state = upvalueValues[upvalues[1]]
                                        r41 = upvalueValues[upvalues[2]]
                                        r38 = upvalueValues[upvalues[3]]
                                        r8 = "\211Q\232\1292\192\248\252\004\163"
                                        r16 = 22436238452943
                                        r44 = r38(r8, r16)
                                        r28 = r41[r44]
                                        r41 = upvalueValues[upvalues[4]]
                                        ReturnVal = "FireServer"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state, r28, r41)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure0 entry 3816771 -> 267, states 267-267
                                    if state == 267 then -- entry 3816771 -> 267
                                        ReturnVal = "request"
                                        state = _env[ReturnVal]
                                        r38 = upvalueValues[upvalues[1]]
                                        r44 = upvalueValues[upvalues[2]]
                                        r50 = 9169348776109
                                        r16 = "\136vH"
                                        r8 = r44(r16, r50)
                                        r41 = r38[r8]
                                        r38 = upvalueValues[upvalues[3]]
                                        r8 = upvalueValues[upvalues[1]]
                                        r16 = upvalueValues[upvalues[2]]
                                        r18 = 26896176509164
                                        r34 = "GV\206\189J]"
                                        r50 = r16(r34, r18)
                                        r44 = r8[r50]
                                        r16 = upvalueValues[upvalues[1]]
                                        r50 = upvalueValues[upvalues[2]]
                                        r52 = 14604959849104
                                        r18 = "\134pb\228"
                                        r34 = r50(r18, r52)
                                        r8 = r16[r34]
                                        r50 = upvalueValues[upvalues[1]]
                                        r34 = upvalueValues[upvalues[2]]
                                        r24 = 12244890850885
                                        r52 = "\189a\2120&T\232"
                                        r18 = r34(r52, r24)
                                        r16 = r50[r18]
                                        r18 = upvalueValues[upvalues[1]]
                                        r52 = upvalueValues[upvalues[2]]
                                        r43 = 31527826323801
                                        r25 = "\012\203*\223zE\206\230a\243\146\254"
                                        r24 = r52(r25, r43)
                                        r34 = r18[r24]
                                        r52 = upvalueValues[upvalues[1]]
                                        r24 = upvalueValues[upvalues[2]]
                                        r22 = 58956349467
                                        r43 = "\208~\029e\205\2090\154\180\246kE\138\174\139\185"
                                        r25 = r24(r43, r22)
                                        r18 = r52[r25]
                                        r50 = {
                                            [r34] = r18
                                        }
                                        r18 = upvalueValues[upvalues[1]]
                                        r52 = upvalueValues[upvalues[2]]
                                        r43 = 24659564637403
                                        r25 = "\031d\193\196"
                                        r24 = r52(r25, r43)
                                        r34 = r18[r24]
                                        r18 = upvalueValues[upvalues[4]]
                                        r28 = {
                                            [r41] = r38,
                                            [r44] = r8,
                                            [r16] = r50,
                                            [r34] = r18
                                        }
                                        ReturnVal = state(r28)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        end
                    else
                        if state <= 274 then
                            if state <= 272 then
                                if state <= 271 then
                                    if state <= 270 then
                                        -- createClosure3 entry 10087950 -> 268, states 268-270
                                        if state <= 269 then
                                            if state <= 268 then
                                                if state == 268 then -- entry 10087950 -> 268
                                                    r28 = allocUpvalue()
                                                    upvalueValues[r28] = args[1]
                                                    ReturnVal = upvalueValues[r28]
                                                    r41 = upvalueValues[upvalues[1]]
                                                    state = ReturnVal ~= r41
                                                    state = state and (269) or (270)
                                                end
                                            else
                                                if state == 269 then
                                                    ReturnVal = upvalueValues[r28]
                                                    r38 = upvalueValues[upvalues[2]]
                                                    r44 = upvalueValues[upvalues[3]]
                                                    r16 = "\174I]F\022\223\240;+\026#\144W\029"
                                                    r50 = 24245870472218
                                                    r8 = r44(r16, r50)
                                                    r41 = r38[r8]
                                                    state = ReturnVal[r41]
                                                    r41 = createClosure2(279, {
                                                        upvalues[2],
                                                        upvalues[3],
                                                        r28,
                                                        upvalues[4]
                                                    })
                                                    ReturnVal = "Connect"
                                                    ReturnVal = state[ReturnVal]
                                                    ReturnVal = ReturnVal(state, r41)
                                                    state = 270
                                                end
                                            end
                                        else
                                            if state == 270 then
                                                r28 = releaseUpvalue(r28)
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        -- createClosure0 entry 8271568 -> 271, states 271-271
                                        if state == 271 then -- entry 8271568 -> 271
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r41 = upvalueValues[upvalues[2]]
                                            r38 = upvalueValues[upvalues[3]]
                                            r8 = "R\186\234\180\182\150o"
                                            r16 = 30370302883646
                                            r44 = r38(r8, r16)
                                            r28 = r41[r44]
                                            state = ReturnVal[r28]
                                            r28 = createClosure1(282, {
                                                upvalues[2],
                                                upvalues[3],
                                                upvalues[4],
                                                upvalues[1]
                                            })
                                            ReturnVal = "Connect"
                                            ReturnVal = state[ReturnVal]
                                            ReturnVal = ReturnVal(state, r28)
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure1 entry 11408816 -> 272, states 272-272
                                    if state == 272 then -- entry 11408816 -> 272
                                        state = upvalueValues[upvalues[1]]
                                        r28 = upvalueValues[upvalues[2]]
                                        ReturnVal = "FireServer"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state, r28)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                if state <= 273 then
                                    -- createClosure2 entry 9772267 -> 273, states 273-273
                                    if state == 273 then -- entry 9772267 -> 273
                                        state = upvalueValues[upvalues[1]]
                                        ReturnVal = "FireServer"
                                        ReturnVal = state[ReturnVal]
                                        r28 = upvalueValues[upvalues[2]]
                                        ReturnVal = ReturnVal(state, r28)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure4 entry 11358601 -> 274, states 274-274
                                    if state == 274 then -- entry 11358601 -> 274
                                        r41 = "game"
                                        r28 = _env[r41]
                                        r41 = "GetService"
                                        r41 = r28[r41]
                                        r44 = upvalueValues[upvalues[1]]
                                        r8 = upvalueValues[upvalues[2]]
                                        r34 = 24720172526839
                                        r50 = "q\228TQ\2397\005jq\023b\149\031[\\u'"
                                        r16 = r8(r50, r34)
                                        r38 = r44[r16]
                                        r41 = r41(r28, r38)
                                        r38 = upvalueValues[upvalues[1]]
                                        r44 = upvalueValues[upvalues[2]]
                                        r50 = 10997340771329
                                        r16 = "qqFr\148\001`\250\239\134"
                                        r8 = r44(r16, r50)
                                        r28 = r38[r8]
                                        ReturnVal = r41[r28]
                                        r41 = upvalueValues[upvalues[1]]
                                        r38 = upvalueValues[upvalues[2]]
                                        r8 = "\255\190\134\189\008\160\157\218\214\2207\165t"
                                        r16 = 4512006244405
                                        r44 = r38(r8, r16)
                                        r28 = r41[r44]
                                        state = ReturnVal[r28]
                                        r28 = upvalueValues[upvalues[3]]
                                        ReturnVal = "FireServer"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state, r28)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 292 then
                                if state <= 281 then
                                    if state <= 278 then
                                        -- createClosure2 entry 3017171 -> 275, states 275-278
                                        if state <= 276 then
                                            if state <= 275 then
                                                if state == 275 then -- entry 3017171 -> 275
                                                    ReturnVal = "game"
                                                    state = _env[ReturnVal]
                                                    r41 = upvalueValues[upvalues[1]]
                                                    r38 = upvalueValues[upvalues[2]]
                                                    r16 = 18098843263211
                                                    r8 = "-\253\225#\231\1494\222|\129V^\128\247\247\174mY\138\142\029u\248\211\195\238\003\218O\150\148\028\255d\189\214\202\244UD\n\014+!\178\196l(^\227\144g\210\245\215\012\016\201xn\209\143\217r>\1282\234P\236o\180\008\031\152\179\163tD\187Od\132\210"
                                                    r44 = r38(r8, r16)
                                                    ReturnVal = "HttpGet"
                                                    ReturnVal = state[ReturnVal]
                                                    r28 = r41[r44]
                                                    ReturnVal = ReturnVal(state, r28)
                                                    r28 = ReturnVal
                                                    ReturnVal = "loadstring"
                                                    state = _env[ReturnVal]
                                                    ReturnVal = state(r28)
                                                    r41 = ReturnVal
                                                    state = r41 and (276) or (277)
                                                end
                                            else
                                                if state == 276 then
                                                    state = r41()
                                                    ReturnVal = "print"
                                                    state = _env[ReturnVal]
                                                    r44 = upvalueValues[upvalues[1]]
                                                    r8 = upvalueValues[upvalues[2]]
                                                    r34 = 7313620897101
                                                    r50 = "\221\017\211\182'\222\252<\211>C\174,\163\208\134m<\172\007\n\r\207'\245K.l\187\022._\248\253\220\199\172\182\234_\216(\178(\220\127\174\154\252"
                                                    r16 = r8(r50, r34)
                                                    r38 = r44[r16]
                                                    ReturnVal = state(r38)
                                                    state = 278
                                                end
                                            end
                                        else
                                            if state <= 277 then
                                                if state == 277 then
                                                    ReturnVal = "error"
                                                    state = _env[ReturnVal]
                                                    r44 = upvalueValues[upvalues[1]]
                                                    r8 = upvalueValues[upvalues[2]]
                                                    r50 = "\206\217\186\188\157\180\135\248\019\030\221\135\216_\149?\017\210\149a\230\003\237\030\246\179\145\215v\024g"
                                                    r34 = 12055452358125
                                                    r16 = r8(r50, r34)
                                                    r38 = r44[r16]
                                                    ReturnVal = state(r38)
                                                    state = 278
                                                end
                                            else
                                                if state == 278 then
                                                    r41 = nil
                                                    r28 = nil
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure2 entry 9728009 -> 279, states 279-281
                                        if state <= 280 then
                                            if state <= 279 then
                                                if state == 279 then -- entry 9728009 -> 279
                                                    r28 = "task"
                                                    ReturnVal = _env[r28]
                                                    r41 = upvalueValues[upvalues[1]]
                                                    r38 = upvalueValues[upvalues[2]]
                                                    r16 = 13555245684904
                                                    r8 = "\024\132\237z"
                                                    r44 = r38(r8, r16)
                                                    r28 = r41[r44]
                                                    state = ReturnVal[r28]
                                                    r28 = 1
                                                    ReturnVal = state(r28)
                                                    ReturnVal = "pcall"
                                                    state = _env[ReturnVal]
                                                    r41 = createClosure2(293, {
                                                        upvalues[3],
                                                        upvalues[1],
                                                        upvalues[2],
                                                        upvalues[4]
                                                    })
                                                    r38 = {
                                                        state(r41)
                                                    }
                                                    ReturnVal = r38[1]
                                                    r41 = ReturnVal
                                                    state = not r41
                                                    state = state and (280) or (281)
                                                    r28 = r38[2]
                                                end
                                            else
                                                if state == 280 then
                                                    ReturnVal = "warn"
                                                    state = _env[ReturnVal]
                                                    r44 = upvalueValues[upvalues[1]]
                                                    r8 = upvalueValues[upvalues[2]]
                                                    r34 = 5253663082894
                                                    r50 = "WG\134o\027t\148oh^ \225\134\217\131_\129\183\127g{)\229~\133X\135\220\210z\166(\179q\129 \222\172"
                                                    r16 = r8(r50, r34)
                                                    r38 = r44[r16]
                                                    r8 = upvalueValues[upvalues[3]]
                                                    r50 = upvalueValues[upvalues[1]]
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r24 = 1664120193798
                                                    r52 = "\2533Fo"
                                                    r18 = r34(r52, r24)
                                                    r16 = r50[r18]
                                                    r44 = r8[r16]
                                                    ReturnVal = state(r38, r44, r28)
                                                    state = 281
                                                end
                                            end
                                        else
                                            if state == 281 then
                                                r28 = nil
                                                r41 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure1 entry 4141215 -> 282, states 282-292
                                    if state <= 287 then
                                        if state <= 284 then
                                            if state <= 283 then
                                                if state <= 282 then
                                                    if state == 282 then -- entry 4141215 -> 282
                                                        r38 = "string"
                                                        r41 = _env[r38]
                                                        r44 = upvalueValues[upvalues[1]]
                                                        r8 = upvalueValues[upvalues[2]]
                                                        r28 = args[1]
                                                        r50 = "\201s!Z\006"
                                                        r34 = 11047598199832
                                                        r16 = r8(r50, r34)
                                                        r38 = r44[r16]
                                                        ReturnVal = r41[r38]
                                                        r41 = ReturnVal(r28)
                                                        r38 = upvalueValues[upvalues[1]]
                                                        r44 = upvalueValues[upvalues[2]]
                                                        r50 = 13545357662371
                                                        r16 = "_T\0051\202"
                                                        r8 = r44(r16, r50)
                                                        ReturnVal = r38[r8]
                                                        state = r41 == ReturnVal
                                                        state = state and (283) or (284)
                                                    end
                                                else
                                                    if state == 283 then
                                                        state = false
                                                        r41 = state
                                                        ReturnVal = "ipairs"
                                                        state = _env[ReturnVal]
                                                        r8 = upvalueValues[upvalues[3]]
                                                        r16 = {
                                                            state(r8)
                                                        }
                                                        ReturnVal = r16[1]
                                                        r8 = ReturnVal
                                                        r44 = r16[3]
                                                        r38 = r16[2]
                                                        state = 285
                                                    end
                                                end
                                            else
                                                if state == 284 then
                                                    r28 = nil
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state <= 286 then
                                                if state <= 285 then
                                                    if state == 285 then
                                                        r44, r50 = r8(r38, r44)
                                                        state = r44 and (286) or (287)
                                                    end
                                                else
                                                    if state == 286 then
                                                        r34 = upvalueValues[upvalues[4]]
                                                        state = r50 == r34
                                                        state = state and (288) or (289)
                                                        r16 = r44
                                                    end
                                                end
                                            else
                                                if state == 287 then
                                                    r38 = not r41
                                                    state = r38 and (290) or (291)
                                                end
                                            end
                                        end
                                    else
                                        if state <= 290 then
                                            if state <= 289 then
                                                if state <= 288 then
                                                    if state == 288 then
                                                        state = true
                                                        r41 = state
                                                        r16 = nil
                                                        r50 = nil
                                                        state = 287
                                                    end
                                                else
                                                    if state == 289 then
                                                        r50 = nil
                                                        r16 = nil
                                                        state = 285
                                                    end
                                                end
                                            else
                                                if state == 290 then
                                                    r8 = "table"
                                                    r44 = _env[r8]
                                                    r16 = upvalueValues[upvalues[1]]
                                                    r50 = upvalueValues[upvalues[2]]
                                                    r52 = 21050928588362
                                                    r18 = "\029pU\133%\145"
                                                    r34 = r50(r18, r52)
                                                    r8 = r16[r34]
                                                    r38 = r44[r8]
                                                    r8 = upvalueValues[upvalues[3]]
                                                    r16 = upvalueValues[upvalues[4]]
                                                    r44 = r38(r8, r16)
                                                    r44 = "print"
                                                    r38 = _env[r44]
                                                    r50 = upvalueValues[upvalues[4]]
                                                    r18 = upvalueValues[upvalues[1]]
                                                    r52 = upvalueValues[upvalues[2]]
                                                    r43 = 27142349189471
                                                    r25 = "\006FH\219"
                                                    r24 = r52(r25, r43)
                                                    r34 = r18[r24]
                                                    r16 = r50[r34]
                                                    r34 = upvalueValues[upvalues[1]]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r25 = 31326507972859
                                                    r24 = "\234\021r@\249H\222\152\200\168a\199\252\198\163\023\206]\028\218\241%!R+#\241\007^\243\0030QK\179\187`\207\1990"
                                                    r52 = r18(r24, r25)
                                                    r50 = r34[r52]
                                                    r8 = r16 .. r50
                                                    r44 = r38(r8)
                                                    state = 292
                                                end
                                            end
                                        else
                                            if state <= 291 then
                                                if state == 291 then
                                                    r44 = "print"
                                                    r38 = _env[r44]
                                                    r50 = upvalueValues[upvalues[4]]
                                                    r18 = upvalueValues[upvalues[1]]
                                                    r52 = upvalueValues[upvalues[2]]
                                                    r25 = "\153b\142t"
                                                    r43 = 23391888059020
                                                    r24 = r52(r25, r43)
                                                    r34 = r18[r24]
                                                    r16 = r50[r34]
                                                    r34 = upvalueValues[upvalues[1]]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r24 = "\011\217\189\t&\011\141K\235\198\174\241\011<\130\211:\159\185\t\237\219\196\221,\2521\143C\218"
                                                    r25 = 1098716348927
                                                    r52 = r18(r24, r25)
                                                    r50 = r34[r52]
                                                    r8 = r16 .. r50
                                                    r44 = r38(r8)
                                                    state = 292
                                                end
                                            else
                                                if state == 292 then
                                                    r41 = nil
                                                    state = 284
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 293 then
                                    -- createClosure2 entry 12560953 -> 293, states 293-293
                                    if state == 293 then -- entry 12560953 -> 293
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r41 = upvalueValues[upvalues[2]]
                                        r38 = upvalueValues[upvalues[3]]
                                        r8 = "\137\156\244\140(\251:"
                                        r16 = 27910903395013
                                        r44 = r38(r8, r16)
                                        r28 = r41[r44]
                                        state = ReturnVal[r28]
                                        r28 = createClosure4(294, {
                                            upvalues[2],
                                            upvalues[3],
                                            upvalues[4],
                                            upvalues[1]
                                        })
                                        ReturnVal = "Connect"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state, r28)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure4 entry 530513 -> 294, states 294-304
                                    if state <= 299 then
                                        if state <= 296 then
                                            if state <= 295 then
                                                if state <= 294 then
                                                    if state == 294 then -- entry 530513 -> 294
                                                        r28 = args[1]
                                                        r38 = "string"
                                                        r41 = _env[r38]
                                                        r44 = upvalueValues[upvalues[1]]
                                                        r8 = upvalueValues[upvalues[2]]
                                                        r50 = "L\245\162\179\252"
                                                        r34 = 30514569656193
                                                        r16 = r8(r50, r34)
                                                        r38 = r44[r16]
                                                        ReturnVal = r41[r38]
                                                        r41 = ReturnVal(r28)
                                                        r38 = upvalueValues[upvalues[1]]
                                                        r44 = upvalueValues[upvalues[2]]
                                                        r16 = "#\233z\003\224"
                                                        r50 = 8283490684689
                                                        r8 = r44(r16, r50)
                                                        ReturnVal = r38[r8]
                                                        state = r41 == ReturnVal
                                                        state = state and (295) or (296)
                                                    end
                                                else
                                                    if state == 295 then
                                                        state = false
                                                        r41 = state
                                                        ReturnVal = "ipairs"
                                                        state = _env[ReturnVal]
                                                        r8 = upvalueValues[upvalues[3]]
                                                        r16 = {
                                                            state(r8)
                                                        }
                                                        ReturnVal = r16[1]
                                                        r8 = ReturnVal
                                                        r44 = r16[3]
                                                        r38 = r16[2]
                                                        state = 297
                                                    end
                                                end
                                            else
                                                if state == 296 then
                                                    r28 = nil
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state <= 298 then
                                                if state <= 297 then
                                                    if state == 297 then
                                                        r44, r50 = r8(r38, r44)
                                                        state = r44 and (298) or (299)
                                                    end
                                                else
                                                    if state == 298 then
                                                        r34 = upvalueValues[upvalues[4]]
                                                        state = r50 == r34
                                                        state = state and (300) or (301)
                                                        r16 = r44
                                                    end
                                                end
                                            else
                                                if state == 299 then
                                                    r38 = not r41
                                                    state = r38 and (302) or (303)
                                                end
                                            end
                                        end
                                    else
                                        if state <= 302 then
                                            if state <= 301 then
                                                if state <= 300 then
                                                    if state == 300 then
                                                        r16 = nil
                                                        state = true
                                                        r41 = state
                                                        r50 = nil
                                                        state = 299
                                                    end
                                                else
                                                    if state == 301 then
                                                        r50 = nil
                                                        r16 = nil
                                                        state = 297
                                                    end
                                                end
                                            else
                                                if state == 302 then
                                                    r8 = "table"
                                                    r44 = _env[r8]
                                                    r16 = upvalueValues[upvalues[1]]
                                                    r50 = upvalueValues[upvalues[2]]
                                                    r52 = 29986925147787
                                                    r18 = "z\194m\242\245\220"
                                                    r34 = r50(r18, r52)
                                                    r8 = r16[r34]
                                                    r38 = r44[r8]
                                                    r8 = upvalueValues[upvalues[3]]
                                                    r16 = upvalueValues[upvalues[4]]
                                                    r44 = r38(r8, r16)
                                                    r44 = "print"
                                                    r38 = _env[r44]
                                                    r50 = upvalueValues[upvalues[4]]
                                                    r18 = upvalueValues[upvalues[1]]
                                                    r52 = upvalueValues[upvalues[2]]
                                                    r43 = 5120480217424
                                                    r25 = "\242\149\130\219"
                                                    r24 = r52(r25, r43)
                                                    r34 = r18[r24]
                                                    r16 = r50[r34]
                                                    r34 = upvalueValues[upvalues[1]]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r24 = "\169\215\170\008\246\000\\\\\004\254\194\1287\164\1742\139_+\174\129^\024\165\128\156[\219z \133\008\001\135\027\137\218\011Z\187"
                                                    r25 = 31268686412000
                                                    r52 = r18(r24, r25)
                                                    r50 = r34[r52]
                                                    r8 = r16 .. r50
                                                    r44 = r38(r8)
                                                    state = 304
                                                end
                                            end
                                        else
                                            if state <= 303 then
                                                if state == 303 then
                                                    r44 = "print"
                                                    r38 = _env[r44]
                                                    r50 = upvalueValues[upvalues[4]]
                                                    r18 = upvalueValues[upvalues[1]]
                                                    r52 = upvalueValues[upvalues[2]]
                                                    r25 = "`B\218\245"
                                                    r43 = 9952315789850
                                                    r24 = r52(r25, r43)
                                                    r34 = r18[r24]
                                                    r16 = r50[r34]
                                                    r34 = upvalueValues[upvalues[1]]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r24 = "2\171\146$C\204\006\019c\005\195\186\138Q\028\024B\137}\224 \173D\019<\146\214\254\212\166"
                                                    r25 = 18397549322615
                                                    r52 = r18(r24, r25)
                                                    r50 = r34[r52]
                                                    r8 = r16 .. r50
                                                    r44 = r38(r8)
                                                    state = 304
                                                end
                                            else
                                                if state == 304 then
                                                    r41 = nil
                                                    state = 296
                                                end
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
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 3341840
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 3341840
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
        upvalueValues = {}
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
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)