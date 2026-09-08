return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalues, createClosure8, releaseUpvalue, createClosure3, createClosure5, vm, createClosure4, allocUpvalue, currentUpvalueId, createClosure2, createClosure, createUpvalueProxy, createClosure0, createClosure1, upvalueValues, upvalueRefCounts)
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, ReturnVal, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86
            while state do
                if state <= 204 then
                    if state <= 46 then
                        if state <= 33 then
                            if state <= 32 then
                                if state <= 31 then
                                    -- root entry 878068 -> 1, states 1-31
                                    if state <= 16 then
                                        if state <= 8 then
                                            if state <= 4 then
                                                if state <= 2 then
                                                    if state <= 1 then
                                                        if state == 1 then -- entry 878068 -> 1
                                                            r51 = allocUpvalue()
                                                            r79 = allocUpvalue()
                                                            state = true
                                                            upvalueValues[r79] = state
                                                            r21 = "string"
                                                            ReturnVal = _env[r21]
                                                            r21 = "gmatch"
                                                            state = ReturnVal[r21]
                                                            r21 = allocUpvalue()
                                                            upvalueValues[r21] = state
                                                            state = createClosure4(32, {})
                                                            upvalueValues[r51] = state
                                                            r61 = allocUpvalue()
                                                            r24 = createClosure4(33, {
                                                                r61
                                                            })
                                                            state = false
                                                            upvalueValues[r61] = state
                                                            r7 = "pcall"
                                                            r20 = _env[r7]
                                                            r7 = r20(r24)
                                                            state = r7 and (2) or (3)
                                                            r18 = args
                                                            ReturnVal = r7
                                                        end
                                                    else
                                                        if state == 2 then
                                                            r20 = upvalueValues[r61]
                                                            ReturnVal = r20
                                                            state = 3
                                                        end
                                                    end
                                                else
                                                    if state <= 3 then
                                                        if state == 3 then
                                                            r20 = ReturnVal
                                                            r7 = "math"
                                                            ReturnVal = _env[r7]
                                                            r7 = "random"
                                                            state = ReturnVal[r7]
                                                            r7 = allocUpvalue()
                                                            upvalueValues[r7] = state
                                                            r24 = "table"
                                                            ReturnVal = _env[r24]
                                                            r24 = "concat"
                                                            state = ReturnVal[r24]
                                                            r25 = state
                                                            r24 = state
                                                            r26 = "table"
                                                            r8 = _env[r26]
                                                            state = r8 and (4) or (5)
                                                            r66 = r8
                                                        end
                                                    else
                                                        if state == 4 then
                                                            r29 = "table"
                                                            r26 = _env[r29]
                                                            r29 = "unpack"
                                                            r8 = r26[r29]
                                                            r66 = r8
                                                            state = 5
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 6 then
                                                    if state <= 5 then
                                                        if state == 5 then
                                                            state = r25
                                                            state = r66 and (6) or (7)
                                                            ReturnVal = r66
                                                        end
                                                    else
                                                        if state == 6 then
                                                            r66 = allocUpvalue()
                                                            upvalueValues[r66] = ReturnVal
                                                            state = upvalueValues[r7]
                                                            r8 = 65
                                                            r25 = 3
                                                            ReturnVal = state(r25, r8)
                                                            r55 = createClosure0(34, {})
                                                            state = 0
                                                            r25 = allocUpvalue()
                                                            upvalueValues[r25] = ReturnVal
                                                            r8 = state
                                                            state = 0
                                                            r29 = "pcall"
                                                            ReturnVal = _env[r29]
                                                            r29 = {
                                                                ReturnVal(r55)
                                                            }
                                                            r26 = state
                                                            state = {
                                                                unpack(r29)
                                                            }
                                                            r29 = state
                                                            ReturnVal = 2
                                                            state = r29[ReturnVal]
                                                            r55 = state
                                                            ReturnVal = "tonumber"
                                                            state = _env[ReturnVal]
                                                            r75 = upvalueValues[r21]
                                                            r76 = "tostring"
                                                            r53 = _env[r76]
                                                            r76 = r53(r55)
                                                            r53 = ":(%d*):"
                                                            r30 = r75(r76, r53)
                                                            r75 = {
                                                                r30()
                                                            }
                                                            ReturnVal = state(unpack(r75))
                                                            r75 = allocUpvalue()
                                                            upvalueValues[r75] = ReturnVal
                                                            r30 = upvalueValues[r25]
                                                            r53 = r30
                                                            r30 = 1
                                                            r76 = r30
                                                            r30 = 0
                                                            r34 = r76 < r30
                                                            ReturnVal = 1
                                                            r30 = ReturnVal - r76
                                                            state = 8
                                                        end
                                                    end
                                                else
                                                    if state <= 7 then
                                                        if state == 7 then
                                                            r25 = "unpack"
                                                            r66 = _env[r25]
                                                            ReturnVal = r66
                                                            state = 6
                                                        end
                                                    else
                                                        if state == 8 then
                                                            r30 = r30 + r76
                                                            ReturnVal = r30 <= r53
                                                            r62 = not r34
                                                            ReturnVal = r62 and ReturnVal
                                                            r62 = r30 >= r53
                                                            r62 = r34 and r62
                                                            ReturnVal = r62 or ReturnVal
                                                            r62 = (9)
                                                            state = ReturnVal and r62
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
                                                            r62 = allocUpvalue()
                                                            upvalueValues[r62] = r30
                                                            r11 = "math"
                                                            ReturnVal = _env[r11]
                                                            r11 = "random"
                                                            state = ReturnVal[r11]
                                                            r14 = 100
                                                            r11 = 1
                                                            ReturnVal = state(r11, r14)
                                                            r11 = allocUpvalue()
                                                            upvalueValues[r11] = ReturnVal
                                                            state = upvalueValues[r7]
                                                            r81 = 255
                                                            r14 = 0
                                                            ReturnVal = state(r14, r81)
                                                            r14 = allocUpvalue()
                                                            upvalueValues[r14] = ReturnVal
                                                            state = upvalueValues[r7]
                                                            r36 = upvalueValues[r11]
                                                            r81 = 1
                                                            ReturnVal = state(r81, r36)
                                                            r81 = allocUpvalue()
                                                            upvalueValues[r81] = ReturnVal
                                                            ReturnVal = upvalueValues[r7]
                                                            r16 = 2
                                                            r9 = 1
                                                            r36 = ReturnVal(r9, r16)
                                                            ReturnVal = 1
                                                            state = r36 == ReturnVal
                                                            r36 = allocUpvalue()
                                                            upvalueValues[r36] = state
                                                            r22 = "tostring"
                                                            r31 = _env[r22]
                                                            r19 = upvalueValues[r7]
                                                            r40 = 0
                                                            r28 = 10000
                                                            r58 = {
                                                                r19(r40, r28)
                                                            }
                                                            r22 = r31(unpack(r58))
                                                            r31 = ":"
                                                            r37 = r22 .. r31
                                                            r16 = ":"
                                                            r9 = r16 .. r37
                                                            state = "gsub"
                                                            state = r55[state]
                                                            ReturnVal = ":(%d*):"
                                                            state = state(r55, ReturnVal, r9)
                                                            r9 = allocUpvalue()
                                                            upvalueValues[r9] = state
                                                            r16 = "pcall"
                                                            ReturnVal = _env[r16]
                                                            r37 = createClosure2(35, {
                                                                r7,
                                                                r62,
                                                                r25,
                                                                r21,
                                                                r79,
                                                                r75,
                                                                r36,
                                                                r9,
                                                                r11,
                                                                r81,
                                                                r14,
                                                                r66
                                                            })
                                                            r16 = {
                                                                ReturnVal(r37)
                                                            }
                                                            state = {
                                                                unpack(r16)
                                                            }
                                                            r16 = state
                                                            state = upvalueValues[r36]
                                                            state = state and (11) or (12)
                                                        end
                                                    else
                                                        if state == 10 then
                                                            r53 = upvalueValues[r79]
                                                            state = r53 and (13) or (14)
                                                            r30 = r53
                                                        end
                                                    end
                                                else
                                                    if state <= 11 then
                                                        if state == 11 then
                                                            r37 = upvalueValues[r79]
                                                            state = r37 and (15) or (16)
                                                            ReturnVal = r37
                                                        end
                                                    else
                                                        if state == 12 then
                                                            r31 = upvalueValues[r79]
                                                            state = r31 and (17) or (18)
                                                            r37 = r31
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 14 then
                                                    if state <= 13 then
                                                        if state == 13 then
                                                            r53 = r8 == r26
                                                            r30 = r53
                                                            state = 14
                                                        end
                                                    else
                                                        if state == 14 then
                                                            upvalueValues[r79] = r30
                                                            state = upvalueValues[r79]
                                                            state = state and (19) or (20)
                                                        end
                                                    end
                                                else
                                                    if state <= 15 then
                                                        if state == 15 then
                                                            r31 = state
                                                            r58 = 1
                                                            r19 = r16[r58]
                                                            r58 = false
                                                            r22 = r19 == r58
                                                            state = r22 and (21) or (22)
                                                            r37 = r22
                                                        end
                                                    else
                                                        if state == 16 then
                                                            upvalueValues[r79] = ReturnVal
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
                                                            r22 = 1
                                                            r31 = r16[r22]
                                                            r37 = r31
                                                            state = 18
                                                        end
                                                    else
                                                        if state == 18 then
                                                            upvalueValues[r79] = r37
                                                            r58 = upvalueValues[r81]
                                                            r40 = 1
                                                            r19 = r58 + r40
                                                            r22 = r16[r19]
                                                            r31 = r8 + r22
                                                            r22 = 256
                                                            state = r31 % r22
                                                            r8 = state
                                                            r19 = upvalueValues[r14]
                                                            r22 = r26 + r19
                                                            r19 = 256
                                                            r31 = r22 % r19
                                                            r26 = r31
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
                                                            r58 = 2
                                                            r19 = r16[r58]
                                                            r58 = upvalueValues[r9]
                                                            r22 = r19 == r58
                                                            r37 = r22
                                                            state = 22
                                                        end
                                                    else
                                                        if state == 22 then
                                                            state = r31
                                                            ReturnVal = r37
                                                            state = 16
                                                        end
                                                    end
                                                else
                                                    if state <= 23 then
                                                        if state == 23 then
                                                            r62 = releaseUpvalue(r62)
                                                            r11 = releaseUpvalue(r11)
                                                            r16 = nil
                                                            r9 = releaseUpvalue(r9)
                                                            r14 = releaseUpvalue(r14)
                                                            r81 = releaseUpvalue(r81)
                                                            r36 = releaseUpvalue(r36)
                                                            state = 8
                                                        end
                                                    else
                                                        if state == 24 then
                                                            r75 = releaseUpvalue(r75)
                                                            r66 = releaseUpvalue(r66)
                                                            r7 = releaseUpvalue(r7)
                                                            r79 = releaseUpvalue(r79)
                                                            r25 = releaseUpvalue(r25)
                                                            r61 = releaseUpvalue(r61)
                                                            r21 = releaseUpvalue(r21)
                                                            r51 = releaseUpvalue(r51)
                                                            r8 = nil
                                                            r8 = {}
                                                            r51 = allocUpvalue()
                                                            r79 = nil
                                                            upvalueValues[r51] = r79
                                                            r79 = allocUpvalue()
                                                            r21 = nil
                                                            upvalueValues[r79] = r21
                                                            r26 = nil
                                                            r26 = allocUpvalue()
                                                            r20 = nil
                                                            r20 = "math"
                                                            r61 = _env[r20]
                                                            r20 = "floor"
                                                            r21 = r61[r20]
                                                            r61 = allocUpvalue()
                                                            upvalueValues[r61] = r21
                                                            r7 = "math"
                                                            r20 = _env[r7]
                                                            r7 = "random"
                                                            r21 = r20[r7]
                                                            r25 = allocUpvalue()
                                                            r24 = nil
                                                            r24 = "table"
                                                            r7 = _env[r24]
                                                            r24 = "remove"
                                                            r20 = r7[r24]
                                                            r66 = "string"
                                                            r24 = _env[r66]
                                                            r66 = "char"
                                                            r7 = r24[r66]
                                                            r66 = allocUpvalue()
                                                            r24 = 0
                                                            upvalueValues[r66] = r24
                                                            r24 = 2
                                                            upvalueValues[r25] = r24
                                                            r29 = nil
                                                            r29 = {}
                                                            upvalueValues[r26] = r8
                                                            r24 = {}
                                                            r75 = 256
                                                            r34 = r75
                                                            r75 = 1
                                                            r62 = r75
                                                            r75 = 0
                                                            r11 = r62 < r75
                                                            r55 = nil
                                                            r55 = 1
                                                            r75 = r55 - r62
                                                            r8 = 0
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
                                                            state = createClosure3(47, {
                                                                r51
                                                            })
                                                            r53 = {
                                                                state()
                                                            }
                                                            ReturnVal = {
                                                                unpack(r53)
                                                            }
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 26 then
                                                            r75 = r75 + r62
                                                            r14 = not r11
                                                            r55 = r75 <= r34
                                                            r55 = r14 and r55
                                                            r14 = r75 >= r34
                                                            r14 = r11 and r14
                                                            r55 = r14 or r55
                                                            r14 = (27)
                                                            state = r55 and r14
                                                            r55 = (28)
                                                            state = state or r55
                                                        end
                                                    end
                                                else
                                                    if state <= 27 then
                                                        if state == 27 then
                                                            r55 = r75
                                                            r14 = r55
                                                            r29[r55] = r14
                                                            r55 = nil
                                                            state = 26
                                                        end
                                                    else
                                                        if state == 28 then
                                                            r75 = #r29
                                                            r34 = 0
                                                            r55 = r75 == r34
                                                            state = 29
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 30 then
                                                    if state <= 29 then
                                                        if state == 29 then
                                                            r75 = 1
                                                            r34 = #r29
                                                            r55 = r21(r75, r34)
                                                            r75 = r20(r29, r55)
                                                            r34 = upvalueValues[r26]
                                                            r14 = 1
                                                            r11 = r75 - r14
                                                            r55 = nil
                                                            r62 = r7(r11)
                                                            r34[r75] = r62
                                                            r75 = nil
                                                            state = 30
                                                        end
                                                    else
                                                        if state == 30 then
                                                            r75 = #r29
                                                            r34 = 0
                                                            r55 = r75 == r34
                                                            state = r55 and (31) or (29)
                                                        end
                                                    end
                                                else
                                                    if state == 31 then
                                                        r55 = {}
                                                        r75 = allocUpvalue()
                                                        r34 = createClosure0(51, {
                                                            r75,
                                                            r66,
                                                            r25,
                                                            r61
                                                        })
                                                        r7 = nil
                                                        r24 = nil
                                                        upvalueValues[r75] = r55
                                                        r55 = allocUpvalue()
                                                        r62 = allocUpvalue()
                                                        r14 = {}
                                                        upvalueValues[r55] = r34
                                                        r34 = {}
                                                        upvalueValues[r62] = r34
                                                        r11 = "setmetatable"
                                                        r34 = _env[r11]
                                                        r9 = upvalueValues[r62]
                                                        r22 = nil
                                                        r16 = "__metatable"
                                                        r36 = "__index"
                                                        r81 = {
                                                            [r36] = r9,
                                                            [r16] = r22
                                                        }
                                                        r61 = releaseUpvalue(r61)
                                                        r11 = r34(r14, r81)
                                                        r34 = createClosure5(57, {
                                                            r62,
                                                            r75,
                                                            r26,
                                                            r66,
                                                            r25,
                                                            r55
                                                        })
                                                        r20 = nil
                                                        r25 = releaseUpvalue(r25)
                                                        r55 = releaseUpvalue(r55)
                                                        r62 = releaseUpvalue(r62)
                                                        r66 = releaseUpvalue(r66)
                                                        upvalueValues[r79] = r11
                                                        upvalueValues[r51] = r34
                                                        r26 = releaseUpvalue(r26)
                                                        r20 = "game"
                                                        r61 = _env[r20]
                                                        r24 = upvalueValues[r79]
                                                        r75 = releaseUpvalue(r75)
                                                        r20 = "GetService"
                                                        r26 = 9476665119036
                                                        r66 = upvalueValues[r51]
                                                        r20 = r61[r20]
                                                        r8 = nil
                                                        r8 = "\176\021\131\027W'\184"
                                                        r25 = r66(r8, r26)
                                                        r7 = r24[r25]
                                                        r20 = r20(r61, r7)
                                                        r25 = "\170\016\244\206\190\212c\007vC."
                                                        r7 = upvalueValues[r79]
                                                        r24 = upvalueValues[r51]
                                                        r8 = 3656785774246
                                                        r66 = r24(r25, r8)
                                                        r61 = r7[r66]
                                                        r25 = "\156]\n\185\2185\251I\169"
                                                        r21 = nil
                                                        r21 = r20[r61]
                                                        r7 = upvalueValues[r79]
                                                        r24 = upvalueValues[r51]
                                                        r61 = "WaitForChild"
                                                        r26 = 31638165584268
                                                        r8 = 16153233874273
                                                        r66 = r24(r25, r8)
                                                        r20 = r7[r66]
                                                        r61 = r21[r61]
                                                        r61 = r61(r21, r20)
                                                        r7 = "Instance"
                                                        r20 = _env[r7]
                                                        r24 = upvalueValues[r79]
                                                        r66 = upvalueValues[r51]
                                                        r8 = "\142\195\137"
                                                        r25 = r66(r8, r26)
                                                        r7 = r24[r25]
                                                        r21 = r20[r7]
                                                        r24 = upvalueValues[r79]
                                                        r26 = 21906310129624
                                                        r66 = upvalueValues[r51]
                                                        r8 = "\168\187\225\246\148\223\1488~"
                                                        r25 = r66(r8, r26)
                                                        r7 = r24[r25]
                                                        r20 = r21(r7)
                                                        r25 = "\173\002\174\137"
                                                        r7 = upvalueValues[r79]
                                                        r26 = 23356374641276
                                                        r24 = upvalueValues[r51]
                                                        r8 = 34573667794659
                                                        r66 = r24(r25, r8)
                                                        r21 = r7[r66]
                                                        r24 = upvalueValues[r79]
                                                        r66 = upvalueValues[r51]
                                                        r8 = "g\252\145F\145M0\029\227\135\187Q\253\213\136d\215R\196u\182\026\250!_N\027\168H"
                                                        r25 = r66(r8, r26)
                                                        r7 = r24[r25]
                                                        r20[r21] = r7
                                                        r7 = upvalueValues[r79]
                                                        r25 = "d\176%\1299\208\142\229\139v\140\179"
                                                        r26 = "\004\146\162"
                                                        r24 = upvalueValues[r51]
                                                        r8 = 29165945058573
                                                        r66 = r24(r25, r8)
                                                        r21 = r7[r66]
                                                        r7 = false
                                                        r20[r21] = r7
                                                        r24 = "Instance"
                                                        r7 = _env[r24]
                                                        r55 = "\237>M"
                                                        r66 = upvalueValues[r79]
                                                        r25 = upvalueValues[r51]
                                                        r29 = nil
                                                        r29 = 8004369321615
                                                        r8 = r25(r26, r29)
                                                        r24 = r66[r8]
                                                        r21 = r7[r24]
                                                        r66 = upvalueValues[r79]
                                                        r26 = "\014\1730T\208"
                                                        r25 = upvalueValues[r51]
                                                        r29 = 6959467351208
                                                        r8 = r25(r26, r29)
                                                        r24 = r66[r8]
                                                        r7 = r21(r24)
                                                        r24 = upvalueValues[r79]
                                                        r66 = upvalueValues[r51]
                                                        r26 = 20111171396756
                                                        r8 = "\149\202\234\171"
                                                        r25 = r66(r8, r26)
                                                        r21 = r24[r25]
                                                        r25 = "UDim2"
                                                        r66 = _env[r25]
                                                        r8 = upvalueValues[r79]
                                                        r26 = upvalueValues[r51]
                                                        r75 = 2411280417890
                                                        r29 = r26(r55, r75)
                                                        r25 = r8[r29]
                                                        r26 = 0
                                                        r24 = r66[r25]
                                                        r25 = 0
                                                        r8 = 700
                                                        r29 = 420
                                                        r66 = r24(r25, r8, r26, r29)
                                                        r7[r21] = r66
                                                        r24 = upvalueValues[r79]
                                                        r66 = upvalueValues[r51]
                                                        r26 = 25034783305097
                                                        r8 = "h\176\166\137.%m\157"
                                                        r25 = r66(r8, r26)
                                                        r21 = r24[r25]
                                                        r25 = "UDim2"
                                                        r55 = "O\230}"
                                                        r66 = _env[r25]
                                                        r8 = upvalueValues[r79]
                                                        r26 = upvalueValues[r51]
                                                        r75 = 659145441586
                                                        r29 = r26(r55, r75)
                                                        r25 = r8[r29]
                                                        r8 = -350
                                                        r26 = 0.5
                                                        r24 = r66[r25]
                                                        r25 = 0.5
                                                        r29 = -210
                                                        r66 = r24(r25, r8, r26, r29)
                                                        r7[r21] = r66
                                                        r26 = 6163298159414
                                                        r24 = upvalueValues[r79]
                                                        r66 = upvalueValues[r51]
                                                        r55 = "\240N\148\nM%\240"
                                                        r8 = "\180\137:HA\182KL\005\163\220\241x\170\224)"
                                                        r25 = r66(r8, r26)
                                                        r21 = r24[r25]
                                                        r25 = "Color3"
                                                        r66 = _env[r25]
                                                        r8 = upvalueValues[r79]
                                                        r26 = upvalueValues[r51]
                                                        r75 = 34144168918555
                                                        r29 = r26(r55, r75)
                                                        r25 = r8[r29]
                                                        r26 = 40
                                                        r24 = r66[r25]
                                                        r25 = 30
                                                        r8 = 30
                                                        r66 = r24(r25, r8, r26)
                                                        r7[r21] = r66
                                                        r24 = upvalueValues[r79]
                                                        r66 = upvalueValues[r51]
                                                        r26 = 4354021328875
                                                        r8 = "\229\148\t\220\137\140\228\255\167\255\208c\223\134\202"
                                                        r25 = r66(r8, r26)
                                                        r21 = r24[r25]
                                                        r55 = "\004\191\192\222pz3"
                                                        r24 = 2
                                                        r26 = 14877487700751
                                                        r7[r21] = r24
                                                        r24 = upvalueValues[r79]
                                                        r66 = upvalueValues[r51]
                                                        r8 = "#\216!\018\135\018\203\236[\184I\210"
                                                        r25 = r66(r8, r26)
                                                        r21 = r24[r25]
                                                        r25 = "Color3"
                                                        r66 = _env[r25]
                                                        r8 = upvalueValues[r79]
                                                        r26 = upvalueValues[r51]
                                                        r75 = 24385389341787
                                                        r29 = r26(r55, r75)
                                                        r14 = 7410465033594
                                                        r25 = r8[r29]
                                                        r26 = 80
                                                        r55 = 29023418627275
                                                        r24 = r66[r25]
                                                        r81 = 9933776818705
                                                        r25 = 60
                                                        r8 = 60
                                                        r66 = r24(r25, r8, r26)
                                                        r7[r21] = r66
                                                        r66 = "Instance"
                                                        r24 = _env[r66]
                                                        r25 = upvalueValues[r79]
                                                        r8 = upvalueValues[r51]
                                                        r29 = "U\188\245"
                                                        r26 = r8(r29, r55)
                                                        r66 = r25[r26]
                                                        r21 = r24[r66]
                                                        r25 = upvalueValues[r79]
                                                        r55 = 32051637779021
                                                        r8 = upvalueValues[r51]
                                                        r29 = "\157;\221NhN\245\246\255"
                                                        r26 = r8(r29, r55)
                                                        r66 = r25[r26]
                                                        r24 = r21(r66)
                                                        r26 = "\174\1317\215"
                                                        r66 = upvalueValues[r79]
                                                        r25 = upvalueValues[r51]
                                                        r29 = 14324294818318
                                                        r8 = r25(r26, r29)
                                                        r21 = r66[r8]
                                                        r8 = "UDim2"
                                                        r25 = _env[r8]
                                                        r26 = upvalueValues[r79]
                                                        r29 = upvalueValues[r51]
                                                        r34 = 30226897614587
                                                        r75 = "*\031\011"
                                                        r55 = r29(r75, r34)
                                                        r8 = r26[r55]
                                                        r26 = 0
                                                        r55 = 36
                                                        r66 = r25[r8]
                                                        r29 = 0
                                                        r8 = 1
                                                        r25 = r66(r8, r26, r29, r55)
                                                        r24[r21] = r25
                                                        r26 = "\1769*\0122\162\239r\025\191x+3\237\188*"
                                                        r66 = upvalueValues[r79]
                                                        r25 = upvalueValues[r51]
                                                        r29 = 12671393699596
                                                        r8 = r25(r26, r29)
                                                        r21 = r66[r8]
                                                        r8 = "Color3"
                                                        r25 = _env[r8]
                                                        r26 = upvalueValues[r79]
                                                        r29 = upvalueValues[r51]
                                                        r75 = "\220\244\\S~=\188"
                                                        r34 = 19649432167357
                                                        r55 = r29(r75, r34)
                                                        r8 = r26[r55]
                                                        r26 = 40
                                                        r55 = 10229580731035
                                                        r66 = r25[r8]
                                                        r29 = 60
                                                        r8 = 40
                                                        r25 = r66(r8, r26, r29)
                                                        r24[r21] = r25
                                                        r66 = upvalueValues[r79]
                                                        r25 = upvalueValues[r51]
                                                        r26 = "\238\244\201\025"
                                                        r29 = 4163627730834
                                                        r8 = r25(r26, r29)
                                                        r21 = r66[r8]
                                                        r25 = upvalueValues[r79]
                                                        r8 = upvalueValues[r51]
                                                        r29 = "\173P\t\128\018\212K\194\248wl3\220%\147_\198\208\218\161\137 \022m\162\155E\193\030\243\237H\nH"
                                                        r26 = r8(r29, r55)
                                                        r66 = r25[r26]
                                                        r24[r21] = r66
                                                        r26 = "9\192O\023^%I\218N\179"
                                                        r66 = upvalueValues[r79]
                                                        r25 = upvalueValues[r51]
                                                        r29 = 19014980510358
                                                        r8 = r25(r26, r29)
                                                        r21 = r66[r8]
                                                        r8 = "Color3"
                                                        r25 = _env[r8]
                                                        r26 = upvalueValues[r79]
                                                        r29 = upvalueValues[r51]
                                                        r75 = "\254\254\133\192\206\000\188"
                                                        r34 = 13308003883061
                                                        r55 = r29(r75, r34)
                                                        r8 = r26[r55]
                                                        r26 = 220
                                                        r66 = r25[r8]
                                                        r29 = 255
                                                        r8 = 220
                                                        r25 = r66(r8, r26, r29)
                                                        r24[r21] = r25
                                                        r66 = upvalueValues[r79]
                                                        r25 = upvalueValues[r51]
                                                        r26 = "T+|D"
                                                        r29 = 741339513177
                                                        r8 = r25(r26, r29)
                                                        r21 = r66[r8]
                                                        r26 = "Enum"
                                                        r8 = _env[r26]
                                                        r29 = upvalueValues[r79]
                                                        r55 = upvalueValues[r51]
                                                        r62 = 12996671428516
                                                        r34 = "\197\188\202\177"
                                                        r75 = r55(r34, r62)
                                                        r26 = r29[r75]
                                                        r25 = r8[r26]
                                                        r26 = upvalueValues[r79]
                                                        r29 = upvalueValues[r51]
                                                        r34 = 22784669002097
                                                        r75 = "\227]\163\247"
                                                        r55 = r29(r75, r34)
                                                        r8 = r26[r55]
                                                        r66 = r25[r8]
                                                        r26 = "\166\135\214$\147\160\201^"
                                                        r24[r21] = r66
                                                        r66 = upvalueValues[r79]
                                                        r25 = upvalueValues[r51]
                                                        r29 = 4398125303808
                                                        r8 = r25(r26, r29)
                                                        r21 = r66[r8]
                                                        r26 = "y\015\171\218n\233\136Z.\190\211 \224\016\023"
                                                        r66 = 20
                                                        r24[r21] = r66
                                                        r66 = upvalueValues[r79]
                                                        r25 = upvalueValues[r51]
                                                        r29 = 29149905319173
                                                        r8 = r25(r26, r29)
                                                        r21 = r66[r8]
                                                        r55 = "?x\251"
                                                        r66 = 0
                                                        r24[r21] = r66
                                                        r25 = "Instance"
                                                        r66 = _env[r25]
                                                        r8 = upvalueValues[r79]
                                                        r26 = upvalueValues[r51]
                                                        r75 = 19238462481150
                                                        r29 = r26(r55, r75)
                                                        r25 = r8[r29]
                                                        r21 = r66[r25]
                                                        r8 = upvalueValues[r79]
                                                        r55 = "#\150\"\249\217\232(\221\159"
                                                        r26 = upvalueValues[r51]
                                                        r75 = 26304435433432
                                                        r29 = r26(r55, r75)
                                                        r25 = r8[r29]
                                                        r66 = r21(r25)
                                                        r55 = "\164\248\134S"
                                                        r21 = allocUpvalue()
                                                        upvalueValues[r21] = r66
                                                        r66 = upvalueValues[r21]
                                                        r8 = upvalueValues[r79]
                                                        r26 = upvalueValues[r51]
                                                        r75 = 28539201008617
                                                        r29 = r26(r55, r75)
                                                        r25 = r8[r29]
                                                        r29 = "UDim2"
                                                        r26 = _env[r29]
                                                        r55 = upvalueValues[r79]
                                                        r75 = upvalueValues[r51]
                                                        r62 = "\001\194{"
                                                        r34 = r75(r62, r14)
                                                        r29 = r55[r34]
                                                        r8 = r26[r29]
                                                        r55 = 0
                                                        r75 = 0
                                                        r29 = 1
                                                        r34 = 22
                                                        r26 = r8(r29, r55, r75, r34)
                                                        r55 = "\198\193T*\133\161\213\238"
                                                        r66[r25] = r26
                                                        r66 = upvalueValues[r21]
                                                        r8 = upvalueValues[r79]
                                                        r26 = upvalueValues[r51]
                                                        r75 = 20286008386790
                                                        r29 = r26(r55, r75)
                                                        r25 = r8[r29]
                                                        r29 = "UDim2"
                                                        r26 = _env[r29]
                                                        r55 = upvalueValues[r79]
                                                        r75 = upvalueValues[r51]
                                                        r14 = 1359198225016
                                                        r62 = ">?\138"
                                                        r34 = r75(r62, r14)
                                                        r29 = r55[r34]
                                                        r55 = 0
                                                        r8 = r26[r29]
                                                        r75 = 0
                                                        r34 = 36
                                                        r29 = 0
                                                        r26 = r8(r29, r55, r75, r34)
                                                        r66[r25] = r26
                                                        r14 = 5212807694715
                                                        r66 = upvalueValues[r21]
                                                        r55 = "\199\132\215\148\130\221\237\178P\209T\153\233\193(a"
                                                        r8 = upvalueValues[r79]
                                                        r26 = upvalueValues[r51]
                                                        r75 = 14369932384803
                                                        r29 = r26(r55, r75)
                                                        r25 = r8[r29]
                                                        r29 = "Color3"
                                                        r26 = _env[r29]
                                                        r55 = upvalueValues[r79]
                                                        r75 = upvalueValues[r51]
                                                        r62 = "\153.\174:\251L\134"
                                                        r34 = r75(r62, r14)
                                                        r29 = r55[r34]
                                                        r55 = 45
                                                        r14 = 4220343584685
                                                        r8 = r26[r29]
                                                        r75 = 65
                                                        r29 = 45
                                                        r26 = r8(r29, r55, r75)
                                                        r55 = "\173\025\175\254P\135\159\197\183\150"
                                                        r66[r25] = r26
                                                        r66 = upvalueValues[r21]
                                                        r8 = upvalueValues[r79]
                                                        r26 = upvalueValues[r51]
                                                        r75 = 3770478659291
                                                        r29 = r26(r55, r75)
                                                        r25 = r8[r29]
                                                        r29 = "Color3"
                                                        r26 = _env[r29]
                                                        r55 = upvalueValues[r79]
                                                        r75 = upvalueValues[r51]
                                                        r62 = "\129u\225:\003\147s"
                                                        r34 = r75(r62, r14)
                                                        r29 = r55[r34]
                                                        r8 = r26[r29]
                                                        r55 = 255
                                                        r75 = 200
                                                        r29 = 200
                                                        r26 = r8(r29, r55, r75)
                                                        r66[r25] = r26
                                                        r66 = upvalueValues[r21]
                                                        r55 = "M\031W\020"
                                                        r8 = upvalueValues[r79]
                                                        r26 = upvalueValues[r51]
                                                        r75 = 5871953136302
                                                        r29 = r26(r55, r75)
                                                        r14 = "226&"
                                                        r55 = "Enum"
                                                        r25 = r8[r29]
                                                        r29 = _env[r55]
                                                        r75 = upvalueValues[r79]
                                                        r34 = upvalueValues[r51]
                                                        r62 = r34(r14, r81)
                                                        r55 = r75[r62]
                                                        r14 = 3180140414408
                                                        r26 = r29[r55]
                                                        r55 = upvalueValues[r79]
                                                        r75 = upvalueValues[r51]
                                                        r62 = "\219\202\185\138"
                                                        r34 = r75(r62, r14)
                                                        r29 = r55[r34]
                                                        r8 = r26[r29]
                                                        r66[r25] = r8
                                                        r66 = upvalueValues[r21]
                                                        r8 = upvalueValues[r79]
                                                        r26 = upvalueValues[r51]
                                                        r55 = "S\146;\154\162\146i\155"
                                                        r75 = 10225974465177
                                                        r29 = r26(r55, r75)
                                                        r25 = r8[r29]
                                                        r8 = 14
                                                        r66[r25] = r8
                                                        r66 = upvalueValues[r21]
                                                        r8 = upvalueValues[r79]
                                                        r26 = upvalueValues[r51]
                                                        r55 = "\203r\221I)s3;\166\198\204\172>\004\024"
                                                        r75 = 24811264535841
                                                        r29 = r26(r55, r75)
                                                        r25 = r8[r29]
                                                        r8 = 0
                                                        r66[r25] = r8
                                                        r66 = upvalueValues[r21]
                                                        r55 = "\177C\008\129"
                                                        r8 = upvalueValues[r79]
                                                        r26 = upvalueValues[r51]
                                                        r75 = 27565529756196
                                                        r29 = r26(r55, r75)
                                                        r25 = r8[r29]
                                                        r26 = upvalueValues[r79]
                                                        r29 = upvalueValues[r51]
                                                        r34 = 4065020987236
                                                        r75 = "\129\170\250\152\025\144\0140\023\141+\159\015"
                                                        r55 = r29(r75, r34)
                                                        r81 = "\027aY"
                                                        r8 = r26[r55]
                                                        r66[r25] = r8
                                                        r14 = 34349923909243
                                                        r8 = "Instance"
                                                        r25 = _env[r8]
                                                        r26 = upvalueValues[r79]
                                                        r29 = upvalueValues[r51]
                                                        r75 = "[Q\252"
                                                        r34 = 21678530209646
                                                        r55 = r29(r75, r34)
                                                        r8 = r26[r55]
                                                        r66 = r25[r8]
                                                        r26 = upvalueValues[r79]
                                                        r29 = upvalueValues[r51]
                                                        r34 = 6705452469298
                                                        r75 = "c\161\189w\224e0\012j\003xI\228*"
                                                        r55 = r29(r75, r34)
                                                        r8 = r26[r55]
                                                        r25 = r66(r8)
                                                        r8 = upvalueValues[r79]
                                                        r26 = upvalueValues[r51]
                                                        r55 = "\146\021\145\254"
                                                        r75 = 34291918601824
                                                        r29 = r26(r55, r75)
                                                        r66 = r8[r29]
                                                        r29 = "UDim2"
                                                        r26 = _env[r29]
                                                        r55 = upvalueValues[r79]
                                                        r75 = upvalueValues[r51]
                                                        r62 = "\195\178\127"
                                                        r34 = r75(r62, r14)
                                                        r29 = r55[r34]
                                                        r55 = -20
                                                        r8 = r26[r29]
                                                        r34 = 270
                                                        r75 = 0
                                                        r29 = 1
                                                        r26 = r8(r29, r55, r75, r34)
                                                        r25[r66] = r26
                                                        r8 = upvalueValues[r79]
                                                        r55 = "\173r\245(\019\136\133\181"
                                                        r26 = upvalueValues[r51]
                                                        r75 = 26354884653040
                                                        r29 = r26(r55, r75)
                                                        r66 = r8[r29]
                                                        r29 = "UDim2"
                                                        r26 = _env[r29]
                                                        ReturnVal = {}
                                                        r55 = upvalueValues[r79]
                                                        r14 = 3271174227443
                                                        r75 = upvalueValues[r51]
                                                        r62 = "K\243\244"
                                                        r34 = r75(r62, r14)
                                                        r29 = r55[r34]
                                                        r8 = r26[r29]
                                                        r55 = 10
                                                        r75 = 0
                                                        r34 = 60
                                                        r29 = 0
                                                        r26 = r8(r29, r55, r75, r34)
                                                        r55 = "2\227\226\202\002'G\209|7\029\193\142a\245a"
                                                        r25[r66] = r26
                                                        r8 = upvalueValues[r79]
                                                        r14 = 10185493058182
                                                        r26 = upvalueValues[r51]
                                                        r75 = 9395132535062
                                                        r29 = r26(r55, r75)
                                                        r66 = r8[r29]
                                                        r29 = "Color3"
                                                        r26 = _env[r29]
                                                        r55 = upvalueValues[r79]
                                                        r75 = upvalueValues[r51]
                                                        r62 = "\025\138t\004\186t\019"
                                                        r34 = r75(r62, r14)
                                                        r29 = r55[r34]
                                                        r55 = 20
                                                        r8 = r26[r29]
                                                        r75 = 25
                                                        r29 = 20
                                                        r26 = r8(r29, r55, r75)
                                                        r25[r66] = r26
                                                        r8 = upvalueValues[r79]
                                                        r55 = "K\177\196\148\130\240\014<\193o\190A"
                                                        r26 = upvalueValues[r51]
                                                        r75 = 16579178110504
                                                        r29 = r26(r55, r75)
                                                        r66 = r8[r29]
                                                        r14 = 10136472064624
                                                        r29 = "Color3"
                                                        r26 = _env[r29]
                                                        r55 = upvalueValues[r79]
                                                        r75 = upvalueValues[r51]
                                                        r62 = "\133\030\136r\248/\247"
                                                        r34 = r75(r62, r14)
                                                        r29 = r55[r34]
                                                        r55 = 80
                                                        r8 = r26[r29]
                                                        r75 = 100
                                                        r29 = 80
                                                        r26 = r8(r29, r55, r75)
                                                        r25[r66] = r26
                                                        r55 = "[5]\127#\020\140jV\002n\191\028b\023"
                                                        r8 = upvalueValues[r79]
                                                        r26 = upvalueValues[r51]
                                                        r75 = 23182164503083
                                                        r29 = r26(r55, r75)
                                                        r66 = r8[r29]
                                                        r8 = 1
                                                        r25[r66] = r8
                                                        r8 = upvalueValues[r79]
                                                        r26 = upvalueValues[r51]
                                                        r55 = "\134s\191_g\012\026\0196\ry\226'8r@\237y"
                                                        r75 = 4179475023770
                                                        r29 = r26(r55, r75)
                                                        r26 = "Instance"
                                                        r66 = r8[r29]
                                                        r8 = 8
                                                        r25[r66] = r8
                                                        r8 = _env[r26]
                                                        r29 = upvalueValues[r79]
                                                        r55 = upvalueValues[r51]
                                                        r34 = "\0079l"
                                                        r62 = 14534597368432
                                                        r75 = r55(r34, r62)
                                                        r26 = r29[r75]
                                                        r66 = r8[r26]
                                                        r29 = upvalueValues[r79]
                                                        r55 = upvalueValues[r51]
                                                        r62 = 17147697717041
                                                        r34 = "\165\004Q\"s\140:"
                                                        r75 = r55(r34, r62)
                                                        r26 = r29[r75]
                                                        r8 = r66(r26)
                                                        r66 = allocUpvalue()
                                                        upvalueValues[r66] = r8
                                                        r8 = upvalueValues[r66]
                                                        r29 = upvalueValues[r79]
                                                        r55 = upvalueValues[r51]
                                                        r34 = "\166@\216\\"
                                                        r62 = 23417937504920
                                                        r75 = r55(r34, r62)
                                                        r26 = r29[r75]
                                                        r75 = "UDim2"
                                                        r55 = _env[r75]
                                                        r34 = upvalueValues[r79]
                                                        r62 = upvalueValues[r51]
                                                        r36 = 5654660696649
                                                        r14 = r62(r81, r36)
                                                        r75 = r34[r14]
                                                        r14 = -8
                                                        r29 = r55[r75]
                                                        r34 = -8
                                                        r62 = 1
                                                        r75 = 1
                                                        r55 = r29(r75, r34, r62, r14)
                                                        r8[r26] = r55
                                                        r8 = upvalueValues[r66]
                                                        r29 = upvalueValues[r79]
                                                        r81 = "\015e\174"
                                                        r55 = upvalueValues[r51]
                                                        r62 = 10502526620442
                                                        r34 = "\008\221%\006\208\197\134\165"
                                                        r75 = r55(r34, r62)
                                                        r26 = r29[r75]
                                                        r75 = "UDim2"
                                                        r55 = _env[r75]
                                                        r34 = upvalueValues[r79]
                                                        r62 = upvalueValues[r51]
                                                        r36 = 30828402538515
                                                        r14 = r62(r81, r36)
                                                        r75 = r34[r14]
                                                        r29 = r55[r75]
                                                        r14 = 4
                                                        r34 = 4
                                                        r75 = 0
                                                        r62 = 0
                                                        r55 = r29(r75, r34, r62, r14)
                                                        r8[r26] = r55
                                                        r8 = upvalueValues[r66]
                                                        r29 = upvalueValues[r79]
                                                        r55 = upvalueValues[r51]
                                                        r62 = 25940669083439
                                                        r34 = "nd\"\181\165C\149\176-\177\021\011\238'\027\185\229\017\200\239\226j"
                                                        r75 = r55(r34, r62)
                                                        r26 = r29[r75]
                                                        r81 = "\205xo\218\170`f"
                                                        r29 = 1
                                                        r8[r26] = r29
                                                        r8 = upvalueValues[r66]
                                                        r29 = upvalueValues[r79]
                                                        r55 = upvalueValues[r51]
                                                        r62 = 11861724845459
                                                        r34 = "L\199k\231o_\028\190\r6"
                                                        r75 = r55(r34, r62)
                                                        r26 = r29[r75]
                                                        r75 = "Color3"
                                                        r55 = _env[r75]
                                                        r34 = upvalueValues[r79]
                                                        r62 = upvalueValues[r51]
                                                        r36 = 10013962834487
                                                        r14 = r62(r81, r36)
                                                        r75 = r34[r14]
                                                        r29 = r55[r75]
                                                        r34 = 220
                                                        r75 = 200
                                                        r62 = 255
                                                        r55 = r29(r75, r34, r62)
                                                        r8[r26] = r55
                                                        r8 = upvalueValues[r66]
                                                        r29 = upvalueValues[r79]
                                                        r55 = upvalueValues[r51]
                                                        r62 = 31153476778154
                                                        r34 = "B\"\184\196"
                                                        r75 = r55(r34, r62)
                                                        r26 = r29[r75]
                                                        r34 = "Enum"
                                                        r75 = _env[r34]
                                                        r62 = upvalueValues[r79]
                                                        r14 = upvalueValues[r51]
                                                        r9 = 15632203504751
                                                        r36 = "\218\162\212\198"
                                                        r81 = r14(r36, r9)
                                                        r34 = r62[r81]
                                                        r55 = r75[r34]
                                                        r34 = upvalueValues[r79]
                                                        r81 = "\217\018\174\134"
                                                        r62 = upvalueValues[r51]
                                                        r36 = 14234306419172
                                                        r14 = r62(r81, r36)
                                                        r75 = r34[r14]
                                                        r29 = r55[r75]
                                                        r8[r26] = r29
                                                        r8 = upvalueValues[r66]
                                                        r29 = upvalueValues[r79]
                                                        r55 = upvalueValues[r51]
                                                        r62 = 1841057809241
                                                        r34 = "\194\254\156\231.t|\225"
                                                        r75 = r55(r34, r62)
                                                        r26 = r29[r75]
                                                        r29 = 14
                                                        r8[r26] = r29
                                                        r8 = upvalueValues[r66]
                                                        r29 = upvalueValues[r79]
                                                        r55 = upvalueValues[r51]
                                                        r34 = "\155\\Kp\166\011m\165:"
                                                        r62 = 25565980339841
                                                        r75 = r55(r34, r62)
                                                        r26 = r29[r75]
                                                        r29 = true
                                                        r8[r26] = r29
                                                        r8 = upvalueValues[r66]
                                                        r29 = upvalueValues[r79]
                                                        r55 = upvalueValues[r51]
                                                        r62 = 17414446833581
                                                        r34 = "\211\156\218uS\006\026T\213r\248E\027_\224G"
                                                        r75 = r55(r34, r62)
                                                        r26 = r29[r75]
                                                        r29 = false
                                                        r8[r26] = r29
                                                        r8 = upvalueValues[r66]
                                                        r29 = upvalueValues[r79]
                                                        r55 = upvalueValues[r51]
                                                        r34 = "\161=\202\249\194K_|1%^"
                                                        r62 = 12067032274419
                                                        r75 = r55(r34, r62)
                                                        r26 = r29[r75]
                                                        r29 = false
                                                        r8[r26] = r29
                                                        r8 = upvalueValues[r66]
                                                        r29 = upvalueValues[r79]
                                                        r55 = upvalueValues[r51]
                                                        r62 = 15192872770466
                                                        r34 = "9n\0198\017\238Yk\161gM\141M\025"
                                                        r75 = r55(r34, r62)
                                                        r26 = r29[r75]
                                                        r34 = "Enum"
                                                        r75 = _env[r34]
                                                        r62 = upvalueValues[r79]
                                                        r14 = upvalueValues[r51]
                                                        r36 = "\182<\237\239\180\192\225}\154%\147\\OD"
                                                        r9 = 9795604484561
                                                        r81 = r14(r36, r9)
                                                        r34 = r62[r81]
                                                        r55 = r75[r34]
                                                        r34 = upvalueValues[r79]
                                                        r62 = upvalueValues[r51]
                                                        r81 = "\173\163\014\167"
                                                        r36 = 16132053278040
                                                        r14 = r62(r81, r36)
                                                        r75 = r34[r14]
                                                        r29 = r55[r75]
                                                        r8[r26] = r29
                                                        r8 = upvalueValues[r66]
                                                        r29 = upvalueValues[r79]
                                                        r55 = upvalueValues[r51]
                                                        r62 = 1687030874897
                                                        r34 = "\031\170\002\145e,\031g\192b`\240\224\248"
                                                        r75 = r55(r34, r62)
                                                        r26 = r29[r75]
                                                        r34 = "Enum"
                                                        r75 = _env[r34]
                                                        r62 = upvalueValues[r79]
                                                        r14 = upvalueValues[r51]
                                                        r9 = 16501056970243
                                                        r36 = "T\021\237e\019i[4Jn\rg\002\153"
                                                        r81 = r14(r36, r9)
                                                        r34 = r62[r81]
                                                        r81 = "P\254\209"
                                                        r55 = r75[r34]
                                                        r34 = upvalueValues[r79]
                                                        r62 = upvalueValues[r51]
                                                        r36 = 15239599774648
                                                        r14 = r62(r81, r36)
                                                        r75 = r34[r14]
                                                        r29 = r55[r75]
                                                        r14 = 7671569518068
                                                        r8[r26] = r29
                                                        r8 = upvalueValues[r66]
                                                        r29 = upvalueValues[r79]
                                                        r55 = upvalueValues[r51]
                                                        r34 = "\233\141\027\195"
                                                        r62 = 852582695309
                                                        r75 = r55(r34, r62)
                                                        r26 = r29[r75]
                                                        r55 = upvalueValues[r79]
                                                        r75 = upvalueValues[r51]
                                                        r62 = "'\144\221\151\152\220\024\184\n\173\245H\215- \215\140\132Z\184X\0269\251V?\199\210\0269\021\232!\\"
                                                        r34 = r75(r62, r14)
                                                        r29 = r55[r34]
                                                        r8[r26] = r29
                                                        r8 = upvalueValues[r66]
                                                        r29 = upvalueValues[r79]
                                                        r55 = upvalueValues[r51]
                                                        r34 = "\031\2087\253\022@"
                                                        r62 = 18510774018475
                                                        r75 = r55(r34, r62)
                                                        r26 = r29[r75]
                                                        r29 = r25
                                                        r8[r26] = r29
                                                        r14 = 10247715230371
                                                        r29 = "Instance"
                                                        r26 = _env[r29]
                                                        r55 = upvalueValues[r79]
                                                        r81 = "\160m\191"
                                                        r75 = upvalueValues[r51]
                                                        r62 = "\151kW"
                                                        r34 = r75(r62, r14)
                                                        r29 = r55[r34]
                                                        r14 = 17857062576251
                                                        r8 = r26[r29]
                                                        r55 = upvalueValues[r79]
                                                        r75 = upvalueValues[r51]
                                                        r62 = "t[\nm\174\231\154\022\133"
                                                        r34 = r75(r62, r14)
                                                        r29 = r55[r34]
                                                        r26 = r8(r29)
                                                        r29 = upvalueValues[r79]
                                                        r55 = upvalueValues[r51]
                                                        r62 = 35089952128980
                                                        r34 = "\228d\129l"
                                                        r75 = r55(r34, r62)
                                                        r8 = r29[r75]
                                                        r75 = "UDim2"
                                                        r55 = _env[r75]
                                                        r34 = upvalueValues[r79]
                                                        r62 = upvalueValues[r51]
                                                        r36 = 20384187294996
                                                        r14 = r62(r81, r36)
                                                        r75 = r34[r14]
                                                        r29 = r55[r75]
                                                        r81 = "\186\250a"
                                                        r14 = 20
                                                        r34 = 130
                                                        r62 = 0
                                                        r75 = 0
                                                        r55 = r29(r75, r34, r62, r14)
                                                        r26[r8] = r55
                                                        r29 = upvalueValues[r79]
                                                        r55 = upvalueValues[r51]
                                                        r62 = 5854854974118
                                                        r34 = "\140\213\187\229\146\219\149\180"
                                                        r75 = r55(r34, r62)
                                                        r8 = r29[r75]
                                                        r75 = "UDim2"
                                                        r55 = _env[r75]
                                                        r34 = upvalueValues[r79]
                                                        r62 = upvalueValues[r51]
                                                        r36 = 4085055047534
                                                        r14 = r62(r81, r36)
                                                        r75 = r34[r14]
                                                        r14 = 338
                                                        r29 = r55[r75]
                                                        r75 = 0
                                                        r34 = 10
                                                        r62 = 0
                                                        r55 = r29(r75, r34, r62, r14)
                                                        r26[r8] = r55
                                                        r81 = "N\249\151\218Ma\236"
                                                        r29 = upvalueValues[r79]
                                                        r55 = upvalueValues[r51]
                                                        r14 = 27502992568839
                                                        r34 = "\191pi=\007\194\243\179\192\230\015\138B\181@\144\211\0043wX\194"
                                                        r62 = 34918784663428
                                                        r75 = r55(r34, r62)
                                                        r8 = r29[r75]
                                                        r29 = 1
                                                        r26[r8] = r29
                                                        r29 = upvalueValues[r79]
                                                        r55 = upvalueValues[r51]
                                                        r62 = 23002552691159
                                                        r34 = "s\019\031N"
                                                        r75 = r55(r34, r62)
                                                        r8 = r29[r75]
                                                        r55 = upvalueValues[r79]
                                                        r75 = upvalueValues[r51]
                                                        r62 = "v\159\142\1300\2015\153\229\191\0267\152\160\202\135"
                                                        r34 = r75(r62, r14)
                                                        r29 = r55[r34]
                                                        r26[r8] = r29
                                                        r29 = upvalueValues[r79]
                                                        r55 = upvalueValues[r51]
                                                        r62 = 5389073254861
                                                        r34 = "\189\180\006_fi\136f\176\136"
                                                        r75 = r55(r34, r62)
                                                        r8 = r29[r75]
                                                        r75 = "Color3"
                                                        r55 = _env[r75]
                                                        r34 = upvalueValues[r79]
                                                        r62 = upvalueValues[r51]
                                                        r36 = 33505079311602
                                                        r14 = r62(r81, r36)
                                                        r75 = r34[r14]
                                                        r29 = r55[r75]
                                                        r62 = 200
                                                        r34 = 200
                                                        r75 = 200
                                                        r55 = r29(r75, r34, r62)
                                                        r26[r8] = r55
                                                        r29 = upvalueValues[r79]
                                                        r55 = upvalueValues[r51]
                                                        r34 = "]\176\198\180"
                                                        r62 = 23147023002138
                                                        r75 = r55(r34, r62)
                                                        r8 = r29[r75]
                                                        r34 = "Enum"
                                                        r75 = _env[r34]
                                                        r62 = upvalueValues[r79]
                                                        r14 = upvalueValues[r51]
                                                        r9 = 31329742354685
                                                        r36 = "\165?\r\131"
                                                        r81 = r14(r36, r9)
                                                        r34 = r62[r81]
                                                        r55 = r75[r34]
                                                        r34 = upvalueValues[r79]
                                                        r62 = upvalueValues[r51]
                                                        r81 = "V;\162c"
                                                        r36 = 10182432068229
                                                        r14 = r62(r81, r36)
                                                        r75 = r34[r14]
                                                        r29 = r55[r75]
                                                        r26[r8] = r29
                                                        r29 = upvalueValues[r79]
                                                        r55 = upvalueValues[r51]
                                                        r62 = 33160985836625
                                                        r34 = "\\f+Q\018\214\131\203"
                                                        r75 = r55(r34, r62)
                                                        r8 = r29[r75]
                                                        r29 = 14
                                                        r26[r8] = r29
                                                        r29 = upvalueValues[r79]
                                                        r55 = upvalueValues[r51]
                                                        r34 = "\030v?\141M\2197P\197\162\214P\135\196"
                                                        r62 = 27298847027624
                                                        r75 = r55(r34, r62)
                                                        r8 = r29[r75]
                                                        r34 = "Enum"
                                                        r75 = _env[r34]
                                                        r62 = upvalueValues[r79]
                                                        r14 = upvalueValues[r51]
                                                        r36 = "\173\180\150c\004\024I\183TN/4\163\018"
                                                        r9 = 25814635572980
                                                        r81 = r14(r36, r9)
                                                        r34 = r62[r81]
                                                        r55 = r75[r34]
                                                        r34 = upvalueValues[r79]
                                                        r62 = upvalueValues[r51]
                                                        r81 = "A^\158\225"
                                                        r36 = 12210920166966
                                                        r14 = r62(r81, r36)
                                                        r81 = 29139904853249
                                                        r75 = r34[r14]
                                                        r29 = r55[r75]
                                                        r26[r8] = r29
                                                        r55 = "Instance"
                                                        r29 = _env[r55]
                                                        r75 = upvalueValues[r79]
                                                        r14 = "\253\008\242"
                                                        r34 = upvalueValues[r51]
                                                        r62 = r34(r14, r81)
                                                        r14 = "+\246\192\191n\195\004"
                                                        r55 = r75[r62]
                                                        r8 = r29[r55]
                                                        r81 = 16196243807605
                                                        r75 = upvalueValues[r79]
                                                        r34 = upvalueValues[r51]
                                                        r62 = r34(r14, r81)
                                                        r14 = "\188\014\174H"
                                                        r55 = r75[r62]
                                                        r81 = 29625367000547
                                                        r29 = r8(r55)
                                                        r8 = allocUpvalue()
                                                        upvalueValues[r8] = r29
                                                        r29 = upvalueValues[r8]
                                                        r75 = upvalueValues[r79]
                                                        r34 = upvalueValues[r51]
                                                        r62 = r34(r14, r81)
                                                        r55 = r75[r62]
                                                        r62 = "UDim2"
                                                        r34 = _env[r62]
                                                        r14 = upvalueValues[r79]
                                                        r81 = upvalueValues[r51]
                                                        r16 = 6022565022452
                                                        r9 = "@\143\145"
                                                        r36 = r81(r9, r16)
                                                        r62 = r14[r36]
                                                        r75 = r34[r62]
                                                        r81 = 0
                                                        r14 = 240
                                                        r36 = 22
                                                        r62 = 0
                                                        r34 = r75(r62, r14, r81, r36)
                                                        r81 = 31389116578072
                                                        r29[r55] = r34
                                                        r29 = upvalueValues[r8]
                                                        r75 = upvalueValues[r79]
                                                        r14 = "\017XE\2341\165V\163"
                                                        r34 = upvalueValues[r51]
                                                        r62 = r34(r14, r81)
                                                        r55 = r75[r62]
                                                        r62 = "UDim2"
                                                        r34 = _env[r62]
                                                        r14 = upvalueValues[r79]
                                                        r81 = upvalueValues[r51]
                                                        r9 = "\t\188_"
                                                        r16 = 4236599396276
                                                        r36 = r81(r9, r16)
                                                        r62 = r14[r36]
                                                        r14 = 140
                                                        r75 = r34[r62]
                                                        r81 = 0
                                                        r36 = 336
                                                        r62 = 0
                                                        r34 = r75(r62, r14, r81, r36)
                                                        r14 = "\166wW\004\184\177r\018\246\192\008\213c\249\241'"
                                                        r29[r55] = r34
                                                        r81 = 22154618300492
                                                        r29 = upvalueValues[r8]
                                                        r75 = upvalueValues[r79]
                                                        r34 = upvalueValues[r51]
                                                        r62 = r34(r14, r81)
                                                        r55 = r75[r62]
                                                        r62 = "Color3"
                                                        r34 = _env[r62]
                                                        r14 = upvalueValues[r79]
                                                        r81 = upvalueValues[r51]
                                                        r9 = "\132\143!\195\155p7"
                                                        r16 = 33076147469354
                                                        r36 = r81(r9, r16)
                                                        r81 = 45
                                                        r62 = r14[r36]
                                                        r14 = 35
                                                        r75 = r34[r62]
                                                        r62 = 35
                                                        r34 = r75(r62, r14, r81)
                                                        r81 = 20737656366520
                                                        r29[r55] = r34
                                                        r29 = upvalueValues[r8]
                                                        r75 = upvalueValues[r79]
                                                        r34 = upvalueValues[r51]
                                                        r14 = "LJ9\130\152h/\250\158\133"
                                                        r62 = r34(r14, r81)
                                                        r55 = r75[r62]
                                                        r62 = "Color3"
                                                        r34 = _env[r62]
                                                        r14 = upvalueValues[r79]
                                                        r81 = upvalueValues[r51]
                                                        r16 = 2209845986309
                                                        r9 = "\215\231\tl\002t`"
                                                        r36 = r81(r9, r16)
                                                        r81 = 220
                                                        r62 = r14[r36]
                                                        r14 = 220
                                                        r75 = r34[r62]
                                                        r62 = 220
                                                        r34 = r75(r62, r14, r81)
                                                        r29[r55] = r34
                                                        r81 = 33928730164663
                                                        r14 = "o\241\222\147"
                                                        r29 = upvalueValues[r8]
                                                        r75 = upvalueValues[r79]
                                                        r34 = upvalueValues[r51]
                                                        r62 = r34(r14, r81)
                                                        r14 = "Enum"
                                                        r55 = r75[r62]
                                                        r62 = _env[r14]
                                                        r81 = upvalueValues[r79]
                                                        r36 = upvalueValues[r51]
                                                        r22 = 28409225884589
                                                        r16 = "\130a\212r"
                                                        r9 = r36(r16, r22)
                                                        r14 = r81[r9]
                                                        r34 = r62[r14]
                                                        r14 = upvalueValues[r79]
                                                        r81 = upvalueValues[r51]
                                                        r16 = 20720620004784
                                                        r9 = "\221\133Cu"
                                                        r36 = r81(r9, r16)
                                                        r62 = r14[r36]
                                                        r75 = r34[r62]
                                                        r29[r55] = r75
                                                        r29 = upvalueValues[r8]
                                                        r14 = "\140j\146s$H\n\242"
                                                        r81 = 8992073289819
                                                        r75 = upvalueValues[r79]
                                                        r34 = upvalueValues[r51]
                                                        r62 = r34(r14, r81)
                                                        r55 = r75[r62]
                                                        r14 = "_\225\169\139\169\195\222\254\027FC\152c\207_\141"
                                                        r75 = 14
                                                        r29[r55] = r75
                                                        r29 = upvalueValues[r8]
                                                        r75 = upvalueValues[r79]
                                                        r81 = 11081916355624
                                                        r34 = upvalueValues[r51]
                                                        r62 = r34(r14, r81)
                                                        r55 = r75[r62]
                                                        r75 = false
                                                        r29[r55] = r75
                                                        r81 = 20626200028548
                                                        r29 = upvalueValues[r8]
                                                        r75 = upvalueValues[r79]
                                                        r14 = "el\164\166"
                                                        r34 = upvalueValues[r51]
                                                        r62 = r34(r14, r81)
                                                        r55 = r75[r62]
                                                        r34 = upvalueValues[r79]
                                                        r62 = upvalueValues[r51]
                                                        r81 = "\254b[\251\190\014\0073\211|\184^Y5i\164\175\015"
                                                        r36 = 29376260601199
                                                        r14 = r62(r81, r36)
                                                        r75 = r34[r14]
                                                        r29[r55] = r75
                                                        r75 = "Instance"
                                                        r55 = _env[r75]
                                                        r34 = upvalueValues[r79]
                                                        r81 = "\210lM"
                                                        r62 = upvalueValues[r51]
                                                        r36 = 16936771346126
                                                        r14 = r62(r81, r36)
                                                        r75 = r34[r14]
                                                        r29 = r55[r75]
                                                        r34 = upvalueValues[r79]
                                                        r81 = "3^\137'\203\153\143\137\144"
                                                        r62 = upvalueValues[r51]
                                                        r36 = 24711255092467
                                                        r14 = r62(r81, r36)
                                                        r75 = r34[r14]
                                                        r14 = "=8\199\142"
                                                        r55 = r29(r75)
                                                        r81 = 29110673159411
                                                        r75 = upvalueValues[r79]
                                                        r34 = upvalueValues[r51]
                                                        r62 = r34(r14, r81)
                                                        r29 = r75[r62]
                                                        r62 = "UDim2"
                                                        r34 = _env[r62]
                                                        r14 = upvalueValues[r79]
                                                        r81 = upvalueValues[r51]
                                                        r9 = "\129\199\180"
                                                        r16 = 4754951932070
                                                        r36 = r81(r9, r16)
                                                        r62 = r14[r36]
                                                        r75 = r34[r62]
                                                        r81 = 0
                                                        r14 = 120
                                                        r36 = 20
                                                        r62 = 0
                                                        r34 = r75(r62, r14, r81, r36)
                                                        r55[r29] = r34
                                                        r75 = upvalueValues[r79]
                                                        r81 = 17029875556090
                                                        r14 = "\150\028\134\011\174\248\181\206"
                                                        r34 = upvalueValues[r51]
                                                        r62 = r34(r14, r81)
                                                        r29 = r75[r62]
                                                        r62 = "UDim2"
                                                        r34 = _env[r62]
                                                        r14 = upvalueValues[r79]
                                                        r81 = upvalueValues[r51]
                                                        r16 = 34499746430657
                                                        r9 = "\005\169\254"
                                                        r36 = r81(r9, r16)
                                                        r62 = r14[r36]
                                                        r75 = r34[r62]
                                                        r14 = 10
                                                        r81 = 0
                                                        r62 = 0
                                                        r36 = 306
                                                        r34 = r75(r62, r14, r81, r36)
                                                        r81 = 3075659154840
                                                        r14 = "\216w\232\1374T\249\"\188\012\206\246O\028\030h\152yI|2\136"
                                                        r55[r29] = r34
                                                        r75 = upvalueValues[r79]
                                                        r34 = upvalueValues[r51]
                                                        r62 = r34(r14, r81)
                                                        r14 = "\001\1618v"
                                                        r29 = r75[r62]
                                                        r81 = 4992526453012
                                                        r75 = 1
                                                        r55[r29] = r75
                                                        r75 = upvalueValues[r79]
                                                        r34 = upvalueValues[r51]
                                                        r62 = r34(r14, r81)
                                                        r29 = r75[r62]
                                                        r34 = upvalueValues[r79]
                                                        r62 = upvalueValues[r51]
                                                        r81 = "'\240\208\1883F<0\003*w8!R"
                                                        r36 = 30645116680126
                                                        r14 = r62(r81, r36)
                                                        r75 = r34[r14]
                                                        r55[r29] = r75
                                                        r75 = upvalueValues[r79]
                                                        r34 = upvalueValues[r51]
                                                        r81 = 13258091223069
                                                        r14 = "\2227\164\157}`\15168A"
                                                        r62 = r34(r14, r81)
                                                        r29 = r75[r62]
                                                        r62 = "Color3"
                                                        r34 = _env[r62]
                                                        r14 = upvalueValues[r79]
                                                        r81 = upvalueValues[r51]
                                                        r16 = 2969140200806
                                                        r9 = "\003PrM\196\208\242"
                                                        r36 = r81(r9, r16)
                                                        r62 = r14[r36]
                                                        r81 = 200
                                                        r14 = 200
                                                        r75 = r34[r62]
                                                        r62 = 200
                                                        r34 = r75(r62, r14, r81)
                                                        r55[r29] = r34
                                                        r14 = "VF\203i"
                                                        r75 = upvalueValues[r79]
                                                        r34 = upvalueValues[r51]
                                                        r81 = 22759591602534
                                                        r62 = r34(r14, r81)
                                                        r29 = r75[r62]
                                                        r14 = "Enum"
                                                        r62 = _env[r14]
                                                        r81 = upvalueValues[r79]
                                                        r36 = upvalueValues[r51]
                                                        r22 = 3888354690834
                                                        r16 = "A\145\007\008"
                                                        r9 = r36(r16, r22)
                                                        r14 = r81[r9]
                                                        r34 = r62[r14]
                                                        r14 = upvalueValues[r79]
                                                        r81 = upvalueValues[r51]
                                                        r16 = 15180060367772
                                                        r9 = "G6\205\031"
                                                        r36 = r81(r9, r16)
                                                        r81 = 16715124350567
                                                        r62 = r14[r36]
                                                        r75 = r34[r62]
                                                        r55[r29] = r75
                                                        r14 = "\212\014\147\157OA\150t"
                                                        r75 = upvalueValues[r79]
                                                        r34 = upvalueValues[r51]
                                                        r62 = r34(r14, r81)
                                                        r29 = r75[r62]
                                                        r81 = 20084598514824
                                                        r14 = "yT\019f\142\2359g\170>*\236b\247"
                                                        r75 = 14
                                                        r55[r29] = r75
                                                        r75 = upvalueValues[r79]
                                                        r34 = upvalueValues[r51]
                                                        r62 = r34(r14, r81)
                                                        r29 = r75[r62]
                                                        r14 = "Enum"
                                                        r62 = _env[r14]
                                                        r81 = upvalueValues[r79]
                                                        r36 = upvalueValues[r51]
                                                        r22 = 9621055263104
                                                        r16 = "j\139\215lcZ\251.$k\163\210\133\131"
                                                        r9 = r36(r16, r22)
                                                        r14 = r81[r9]
                                                        r34 = r62[r14]
                                                        r14 = upvalueValues[r79]
                                                        r81 = upvalueValues[r51]
                                                        r16 = 22737689389404
                                                        r9 = "\230\251\133j"
                                                        r36 = r81(r9, r16)
                                                        r62 = r14[r36]
                                                        r75 = r34[r62]
                                                        r55[r29] = r75
                                                        r34 = "Instance"
                                                        r75 = _env[r34]
                                                        r62 = upvalueValues[r79]
                                                        r14 = upvalueValues[r51]
                                                        r9 = 16289342987681
                                                        r36 = "1\246\200"
                                                        r81 = r14(r36, r9)
                                                        r34 = r62[r81]
                                                        r29 = r75[r34]
                                                        r62 = upvalueValues[r79]
                                                        r14 = upvalueValues[r51]
                                                        r9 = 13857654659380
                                                        r36 = "z\ra\154\207\194\212"
                                                        r81 = r14(r36, r9)
                                                        r34 = r62[r81]
                                                        r75 = r29(r34)
                                                        r29 = allocUpvalue()
                                                        upvalueValues[r29] = r75
                                                        r75 = upvalueValues[r29]
                                                        r62 = upvalueValues[r79]
                                                        r14 = upvalueValues[r51]
                                                        r36 = "\030<d\252"
                                                        r9 = 9707935584680
                                                        r81 = r14(r36, r9)
                                                        r34 = r62[r81]
                                                        r81 = "UDim2"
                                                        r14 = _env[r81]
                                                        r36 = upvalueValues[r79]
                                                        r9 = upvalueValues[r51]
                                                        r19 = 14181118351819
                                                        r22 = "A5\161"
                                                        r16 = r9(r22, r19)
                                                        r81 = r36[r16]
                                                        r62 = r14[r81]
                                                        r81 = 0
                                                        r9 = 0
                                                        r36 = 240
                                                        r16 = 22
                                                        r14 = r62(r81, r36, r9, r16)
                                                        r75[r34] = r14
                                                        r75 = upvalueValues[r29]
                                                        r62 = upvalueValues[r79]
                                                        r14 = upvalueValues[r51]
                                                        r9 = 34595311025901
                                                        r36 = "t\180\172x\158\015ma"
                                                        r81 = r14(r36, r9)
                                                        r34 = r62[r81]
                                                        r81 = "UDim2"
                                                        r14 = _env[r81]
                                                        r36 = upvalueValues[r79]
                                                        r9 = upvalueValues[r51]
                                                        r19 = 11917781570989
                                                        r22 = "\137\175;"
                                                        r16 = r9(r22, r19)
                                                        r81 = r36[r16]
                                                        r62 = r14[r81]
                                                        r81 = 0
                                                        r9 = 0
                                                        r16 = 304
                                                        r36 = 140
                                                        r14 = r62(r81, r36, r9, r16)
                                                        r75[r34] = r14
                                                        r75 = upvalueValues[r29]
                                                        r62 = upvalueValues[r79]
                                                        r14 = upvalueValues[r51]
                                                        r36 = "\023\229\230qX\201h\217\215\230\181_.\181Ja"
                                                        r9 = 12925476411266
                                                        r81 = r14(r36, r9)
                                                        r34 = r62[r81]
                                                        r81 = "Color3"
                                                        r14 = _env[r81]
                                                        r36 = upvalueValues[r79]
                                                        r9 = upvalueValues[r51]
                                                        r22 = "\192\246\008\197\235U\189"
                                                        r19 = 27820164805274
                                                        r16 = r9(r22, r19)
                                                        r81 = r36[r16]
                                                        r62 = r14[r81]
                                                        r81 = 35
                                                        r9 = 45
                                                        r36 = 35
                                                        r14 = r62(r81, r36, r9)
                                                        r75[r34] = r14
                                                        r75 = upvalueValues[r29]
                                                        r62 = upvalueValues[r79]
                                                        r14 = upvalueValues[r51]
                                                        r36 = "4n\170\143\166\252\140\\i\221"
                                                        r9 = 32638401575774
                                                        r81 = r14(r36, r9)
                                                        r34 = r62[r81]
                                                        r81 = "Color3"
                                                        r14 = _env[r81]
                                                        r36 = upvalueValues[r79]
                                                        r9 = upvalueValues[r51]
                                                        r22 = "lR\tu\203\148u"
                                                        r19 = 21917549717470
                                                        r16 = r9(r22, r19)
                                                        r81 = r36[r16]
                                                        r62 = r14[r81]
                                                        r81 = 220
                                                        r36 = 220
                                                        r9 = 220
                                                        r14 = r62(r81, r36, r9)
                                                        r75[r34] = r14
                                                        r75 = upvalueValues[r29]
                                                        r62 = upvalueValues[r79]
                                                        r14 = upvalueValues[r51]
                                                        r36 = "\242\214\230{"
                                                        r9 = 3717709072067
                                                        r81 = r14(r36, r9)
                                                        r34 = r62[r81]
                                                        r36 = "Enum"
                                                        r81 = _env[r36]
                                                        r9 = upvalueValues[r79]
                                                        r16 = upvalueValues[r51]
                                                        r58 = 18080229515491
                                                        r19 = "\168\254\241\175"
                                                        r22 = r16(r19, r58)
                                                        r36 = r9[r22]
                                                        r14 = r81[r36]
                                                        r36 = upvalueValues[r79]
                                                        r9 = upvalueValues[r51]
                                                        r19 = 16109438213453
                                                        r22 = "\219b\253\019"
                                                        r16 = r9(r22, r19)
                                                        r81 = r36[r16]
                                                        r62 = r14[r81]
                                                        r75[r34] = r62
                                                        r75 = upvalueValues[r29]
                                                        r62 = upvalueValues[r79]
                                                        r14 = upvalueValues[r51]
                                                        r9 = 20654480418193
                                                        r36 = "\135K\029>\191 \139\242"
                                                        r81 = r14(r36, r9)
                                                        r34 = r62[r81]
                                                        r62 = 14
                                                        r75[r34] = r62
                                                        r75 = upvalueValues[r29]
                                                        r62 = upvalueValues[r79]
                                                        r14 = upvalueValues[r51]
                                                        r36 = "\226\161\138`g\181\253\145J\239b\161\185\172\005\025"
                                                        r9 = 7607112502742
                                                        r81 = r14(r36, r9)
                                                        r34 = r62[r81]
                                                        r62 = false
                                                        r75[r34] = r62
                                                        r75 = upvalueValues[r29]
                                                        r62 = upvalueValues[r79]
                                                        r14 = upvalueValues[r51]
                                                        r36 = "}\173\000\151"
                                                        r9 = 10035739267649
                                                        r81 = r14(r36, r9)
                                                        r34 = r62[r81]
                                                        r14 = upvalueValues[r79]
                                                        r81 = upvalueValues[r51]
                                                        r9 = ";1W\180X\250\252\127(\248\160\239\184\184J\214\240R\150\196\172"
                                                        r16 = 25409432350264
                                                        r36 = r81(r9, r16)
                                                        r62 = r14[r36]
                                                        r75[r34] = r62
                                                        r62 = "Instance"
                                                        r34 = _env[r62]
                                                        r14 = upvalueValues[r79]
                                                        r81 = upvalueValues[r51]
                                                        r16 = 24636988058832
                                                        r9 = "\019\175\186"
                                                        r36 = r81(r9, r16)
                                                        r62 = r14[r36]
                                                        r75 = r34[r62]
                                                        r14 = upvalueValues[r79]
                                                        r81 = upvalueValues[r51]
                                                        r16 = 9351113593090
                                                        r9 = "\247I\147m\184\133\253=\222"
                                                        r36 = r81(r9, r16)
                                                        r62 = r14[r36]
                                                        r34 = r75(r62)
                                                        r75 = allocUpvalue()
                                                        upvalueValues[r75] = r34
                                                        r34 = upvalueValues[r75]
                                                        r14 = upvalueValues[r79]
                                                        r81 = upvalueValues[r51]
                                                        r16 = 28485091505104
                                                        r9 = "N\2457\178"
                                                        r36 = r81(r9, r16)
                                                        r62 = r14[r36]
                                                        r36 = "UDim2"
                                                        r81 = _env[r36]
                                                        r9 = upvalueValues[r79]
                                                        r16 = upvalueValues[r51]
                                                        r19 = "nZ\150"
                                                        r58 = 29629514511845
                                                        r22 = r16(r19, r58)
                                                        r36 = r9[r22]
                                                        r14 = r81[r36]
                                                        r16 = 0
                                                        r22 = 18
                                                        r9 = 80
                                                        r36 = 0
                                                        r81 = r14(r36, r9, r16, r22)
                                                        r34[r62] = r81
                                                        r34 = upvalueValues[r75]
                                                        r14 = upvalueValues[r79]
                                                        r81 = upvalueValues[r51]
                                                        r9 = "\005\019\175\150\130\250\194\173"
                                                        r16 = 4811858168000
                                                        r36 = r81(r9, r16)
                                                        r62 = r14[r36]
                                                        r36 = "UDim2"
                                                        r81 = _env[r36]
                                                        r9 = upvalueValues[r79]
                                                        r16 = upvalueValues[r51]
                                                        r19 = "\008\142\131"
                                                        r58 = 6558810622958
                                                        r22 = r16(r19, r58)
                                                        r36 = r9[r22]
                                                        r14 = r81[r36]
                                                        r9 = -360
                                                        r36 = 1
                                                        r16 = 0
                                                        r22 = 336
                                                        r81 = r14(r36, r9, r16, r22)
                                                        r34[r62] = r81
                                                        r34 = upvalueValues[r75]
                                                        r14 = upvalueValues[r79]
                                                        r81 = upvalueValues[r51]
                                                        r16 = 32598654712651
                                                        r9 = "\214{\210m\026\197\200\162o)\215\130\211\208Z\221\138s}\206\025\201"
                                                        r36 = r81(r9, r16)
                                                        r62 = r14[r36]
                                                        r14 = 1
                                                        r34[r62] = r14
                                                        r34 = upvalueValues[r75]
                                                        r14 = upvalueValues[r79]
                                                        r81 = upvalueValues[r51]
                                                        r9 = "\001\\\004~"
                                                        r16 = 27571449786918
                                                        r36 = r81(r9, r16)
                                                        r62 = r14[r36]
                                                        r81 = upvalueValues[r79]
                                                        r36 = upvalueValues[r51]
                                                        r22 = 10447165330176
                                                        r16 = "\011\138{\255\223R\249t\132\223\226\182"
                                                        r9 = r36(r16, r22)
                                                        r14 = r81[r9]
                                                        r34[r62] = r14
                                                        r34 = upvalueValues[r75]
                                                        r14 = upvalueValues[r79]
                                                        r81 = upvalueValues[r51]
                                                        r16 = 12594342975208
                                                        r9 = "\129jC\185"
                                                        r36 = r81(r9, r16)
                                                        r62 = r14[r36]
                                                        r9 = "Enum"
                                                        r36 = _env[r9]
                                                        r16 = upvalueValues[r79]
                                                        r22 = upvalueValues[r51]
                                                        r40 = 9102202032270
                                                        r58 = "v\154\232\152"
                                                        r19 = r22(r58, r40)
                                                        r9 = r16[r19]
                                                        r81 = r36[r9]
                                                        r9 = upvalueValues[r79]
                                                        r16 = upvalueValues[r51]
                                                        r58 = 30531763845001
                                                        r19 = "\177\001\220E"
                                                        r22 = r16(r19, r58)
                                                        r36 = r9[r22]
                                                        r14 = r81[r36]
                                                        r34[r62] = r14
                                                        r34 = upvalueValues[r75]
                                                        r14 = upvalueValues[r79]
                                                        r81 = upvalueValues[r51]
                                                        r16 = 22215398254696
                                                        r9 = "\002z\225o\209\1450\172"
                                                        r36 = r81(r9, r16)
                                                        r62 = r14[r36]
                                                        r14 = 14
                                                        r34[r62] = r14
                                                        r34 = upvalueValues[r75]
                                                        r14 = upvalueValues[r79]
                                                        r81 = upvalueValues[r51]
                                                        r9 = "\160\242\161\160\007\2179\190\003\236"
                                                        r16 = 31839891421674
                                                        r36 = r81(r9, r16)
                                                        r62 = r14[r36]
                                                        r36 = "Color3"
                                                        r81 = _env[r36]
                                                        r9 = upvalueValues[r79]
                                                        r16 = upvalueValues[r51]
                                                        r58 = 11636734727466
                                                        r19 = "\142`l\188\012\167\243"
                                                        r22 = r16(r19, r58)
                                                        r36 = r9[r22]
                                                        r14 = r81[r36]
                                                        r16 = 0
                                                        r9 = 0
                                                        r36 = 0
                                                        r81 = r14(r36, r9, r16)
                                                        r34[r62] = r81
                                                        r34 = upvalueValues[r75]
                                                        r14 = upvalueValues[r79]
                                                        r81 = upvalueValues[r51]
                                                        r9 = "E\145t\005\233\193[\143\193\248q\218S\139"
                                                        r16 = 888680808861
                                                        r36 = r81(r9, r16)
                                                        r62 = r14[r36]
                                                        r9 = "Enum"
                                                        r36 = _env[r9]
                                                        r16 = upvalueValues[r79]
                                                        r22 = upvalueValues[r51]
                                                        r58 = "\015\005\236u,R\169\183)\031\201\243\167\228"
                                                        r40 = 6363454917523
                                                        r19 = r22(r58, r40)
                                                        r9 = r16[r19]
                                                        r81 = r36[r9]
                                                        r9 = upvalueValues[r79]
                                                        r16 = upvalueValues[r51]
                                                        r58 = 25817853095670
                                                        r19 = "Y=J\130"
                                                        r22 = r16(r19, r58)
                                                        r36 = r9[r22]
                                                        r14 = r81[r36]
                                                        r34[r62] = r14
                                                        r14 = "Instance"
                                                        r62 = _env[r14]
                                                        r81 = upvalueValues[r79]
                                                        r36 = upvalueValues[r51]
                                                        r22 = 299619745931
                                                        r16 = "\254W\255"
                                                        r9 = r36(r16, r22)
                                                        r14 = r81[r9]
                                                        r34 = r62[r14]
                                                        r81 = upvalueValues[r79]
                                                        r36 = upvalueValues[r51]
                                                        r22 = 18281236488512
                                                        r16 = "-\162\255\205\235y\234\191\140a"
                                                        r9 = r36(r16, r22)
                                                        r14 = r81[r9]
                                                        r62 = r34(r14)
                                                        r34 = allocUpvalue()
                                                        upvalueValues[r34] = r62
                                                        r62 = upvalueValues[r34]
                                                        r81 = upvalueValues[r79]
                                                        r36 = upvalueValues[r51]
                                                        r22 = 3558957401721
                                                        r16 = "\237 `S"
                                                        r9 = r36(r16, r22)
                                                        r14 = r81[r9]
                                                        r9 = "UDim2"
                                                        r36 = _env[r9]
                                                        r16 = upvalueValues[r79]
                                                        r22 = upvalueValues[r51]
                                                        r58 = "m\024@"
                                                        r40 = 28119784551206
                                                        r19 = r22(r58, r40)
                                                        r9 = r16[r19]
                                                        r81 = r36[r9]
                                                        r22 = 0
                                                        r19 = 20
                                                        r16 = 20
                                                        r9 = 0
                                                        r36 = r81(r9, r16, r22, r19)
                                                        r62[r14] = r36
                                                        r62 = upvalueValues[r34]
                                                        r81 = upvalueValues[r79]
                                                        r36 = upvalueValues[r51]
                                                        r22 = 15735265975455
                                                        r16 = "u\014\164\155'?O\160"
                                                        r9 = r36(r16, r22)
                                                        r14 = r81[r9]
                                                        r9 = "UDim2"
                                                        r36 = _env[r9]
                                                        r16 = upvalueValues[r79]
                                                        r22 = upvalueValues[r51]
                                                        r58 = "j\154\178"
                                                        r40 = 25476507119191
                                                        r19 = r22(r58, r40)
                                                        r9 = r16[r19]
                                                        r81 = r36[r9]
                                                        r16 = -360
                                                        r19 = 356
                                                        r22 = 0
                                                        r9 = 1
                                                        r36 = r81(r9, r16, r22, r19)
                                                        r62[r14] = r36
                                                        r62 = upvalueValues[r34]
                                                        r81 = upvalueValues[r79]
                                                        r36 = upvalueValues[r51]
                                                        r22 = 31837493623273
                                                        r16 = "\015\223L\247\143\031\152\230\008\204u\016\189\230.&"
                                                        r9 = r36(r16, r22)
                                                        r14 = r81[r9]
                                                        r9 = "Color3"
                                                        r36 = _env[r9]
                                                        r16 = upvalueValues[r79]
                                                        r22 = upvalueValues[r51]
                                                        r40 = 33815495490946
                                                        r58 = "=\248\220\023\167\0011"
                                                        r19 = r22(r58, r40)
                                                        r9 = r16[r19]
                                                        r81 = r36[r9]
                                                        r22 = 90
                                                        r16 = 80
                                                        r9 = 80
                                                        r36 = r81(r9, r16, r22)
                                                        r62[r14] = r36
                                                        r62 = upvalueValues[r34]
                                                        r81 = upvalueValues[r79]
                                                        r36 = upvalueValues[r51]
                                                        r22 = 6401573227428
                                                        r16 = "1:\019\172\024\026\142&\019\007V\206\2205\023"
                                                        r9 = r36(r16, r22)
                                                        r14 = r81[r9]
                                                        r81 = 1
                                                        r62[r14] = r81
                                                        r62 = upvalueValues[r34]
                                                        r81 = upvalueValues[r79]
                                                        r36 = upvalueValues[r51]
                                                        r16 = "\152#Q\227"
                                                        r22 = 17307601936251
                                                        r9 = r36(r16, r22)
                                                        r14 = r81[r9]
                                                        r36 = upvalueValues[r79]
                                                        r9 = upvalueValues[r51]
                                                        r19 = 6238235888472
                                                        r22 = ""
                                                        r16 = r9(r22, r19)
                                                        r81 = r36[r16]
                                                        r62[r14] = r81
                                                        r81 = "Instance"
                                                        r14 = _env[r81]
                                                        r36 = upvalueValues[r79]
                                                        r9 = upvalueValues[r51]
                                                        r19 = 16437312511462
                                                        r22 = "\166\214h"
                                                        r16 = r9(r22, r19)
                                                        r81 = r36[r16]
                                                        r62 = r14[r81]
                                                        r36 = upvalueValues[r79]
                                                        r9 = upvalueValues[r51]
                                                        r22 = "R\161\196\018/\161\130\165'\022"
                                                        r19 = 7532662197683
                                                        r16 = r9(r22, r19)
                                                        r81 = r36[r16]
                                                        r14 = r62(r81)
                                                        r81 = upvalueValues[r79]
                                                        r36 = upvalueValues[r51]
                                                        r16 = "\201(Ck"
                                                        r22 = 30875223947305
                                                        r9 = r36(r16, r22)
                                                        r62 = r81[r9]
                                                        r9 = "UDim2"
                                                        r36 = _env[r9]
                                                        r16 = upvalueValues[r79]
                                                        r22 = upvalueValues[r51]
                                                        r40 = 25788426104552
                                                        r58 = "\252\177\239"
                                                        r19 = r22(r58, r40)
                                                        r9 = r16[r19]
                                                        r81 = r36[r9]
                                                        r22 = 0
                                                        r9 = 0
                                                        r16 = 170
                                                        r19 = 30
                                                        r36 = r81(r9, r16, r22, r19)
                                                        r14[r62] = r36
                                                        r81 = upvalueValues[r79]
                                                        r36 = upvalueValues[r51]
                                                        r22 = 833381597572
                                                        r16 = "\014\233\247\246Q\138>r"
                                                        r9 = r36(r16, r22)
                                                        r62 = r81[r9]
                                                        r9 = "UDim2"
                                                        r36 = _env[r9]
                                                        r16 = upvalueValues[r79]
                                                        r22 = upvalueValues[r51]
                                                        r40 = 25320366353934
                                                        r58 = "\232\130c"
                                                        r19 = r22(r58, r40)
                                                        r9 = r16[r19]
                                                        r81 = r36[r9]
                                                        r16 = -180
                                                        r22 = 0
                                                        r9 = 1
                                                        r19 = 336
                                                        r36 = r81(r9, r16, r22, r19)
                                                        r14[r62] = r36
                                                        r81 = upvalueValues[r79]
                                                        r36 = upvalueValues[r51]
                                                        r22 = 30600284288937
                                                        r16 = "M\2360\225R>Y\168\224\152\231I\229\1302\183"
                                                        r9 = r36(r16, r22)
                                                        r62 = r81[r9]
                                                        r9 = "Color3"
                                                        r36 = _env[r9]
                                                        r16 = upvalueValues[r79]
                                                        r22 = upvalueValues[r51]
                                                        r40 = 7392192236914
                                                        r58 = "\247\017\006\254\0068\\"
                                                        r19 = r22(r58, r40)
                                                        r9 = r16[r19]
                                                        r81 = r36[r9]
                                                        r22 = 100
                                                        r9 = 120
                                                        r16 = 80
                                                        r36 = r81(r9, r16, r22)
                                                        r14[r62] = r36
                                                        r81 = upvalueValues[r79]
                                                        r36 = upvalueValues[r51]
                                                        r22 = 22734648977754
                                                        r16 = "Y\029\208\206\140\"\171\196\177\002"
                                                        r9 = r36(r16, r22)
                                                        r62 = r81[r9]
                                                        r9 = "Color3"
                                                        r36 = _env[r9]
                                                        r16 = upvalueValues[r79]
                                                        r22 = upvalueValues[r51]
                                                        r58 = "c\203\163#\143T\011"
                                                        r40 = 22987361970640
                                                        r19 = r22(r58, r40)
                                                        r9 = r16[r19]
                                                        r81 = r36[r9]
                                                        r22 = 255
                                                        r9 = 255
                                                        r16 = 255
                                                        r36 = r81(r9, r16, r22)
                                                        r14[r62] = r36
                                                        r81 = upvalueValues[r79]
                                                        r36 = upvalueValues[r51]
                                                        r22 = 17839357567091
                                                        r16 = "Nq`p"
                                                        r9 = r36(r16, r22)
                                                        r62 = r81[r9]
                                                        r16 = "Enum"
                                                        r9 = _env[r16]
                                                        r22 = upvalueValues[r79]
                                                        r19 = upvalueValues[r51]
                                                        r28 = 144619847747
                                                        r40 = "\149&\026\250"
                                                        r58 = r19(r40, r28)
                                                        r16 = r22[r58]
                                                        r36 = r9[r16]
                                                        r16 = upvalueValues[r79]
                                                        r22 = upvalueValues[r51]
                                                        r58 = "\"\136\231\005"
                                                        r40 = 32089564002910
                                                        r19 = r22(r58, r40)
                                                        r9 = r16[r19]
                                                        r81 = r36[r9]
                                                        r14[r62] = r81
                                                        r81 = upvalueValues[r79]
                                                        r36 = upvalueValues[r51]
                                                        r22 = 13186749306876
                                                        r16 = "4H\203\198\180\153\019\249"
                                                        r9 = r36(r16, r22)
                                                        r62 = r81[r9]
                                                        r81 = 16
                                                        r14[r62] = r81
                                                        r81 = upvalueValues[r79]
                                                        r36 = upvalueValues[r51]
                                                        r16 = "\132\157\172\141"
                                                        r22 = 22360018102444
                                                        r9 = r36(r16, r22)
                                                        r62 = r81[r9]
                                                        r36 = upvalueValues[r79]
                                                        r9 = upvalueValues[r51]
                                                        r19 = 28745083335753
                                                        r22 = "\218L\222\215\250\217Sc')-\180"
                                                        r16 = r9(r22, r19)
                                                        r81 = r36[r16]
                                                        r14[r62] = r81
                                                        r36 = "Instance"
                                                        r81 = _env[r36]
                                                        r9 = upvalueValues[r79]
                                                        r16 = upvalueValues[r51]
                                                        r58 = 24823484034343
                                                        r19 = "\174B\130"
                                                        r22 = r16(r19, r58)
                                                        r36 = r9[r22]
                                                        r62 = r81[r36]
                                                        r9 = upvalueValues[r79]
                                                        r16 = upvalueValues[r51]
                                                        r58 = 23248698927690
                                                        r19 = "\236A\181\196\201\144\002\023p"
                                                        r22 = r16(r19, r58)
                                                        r36 = r9[r22]
                                                        r81 = r62(r36)
                                                        r36 = upvalueValues[r79]
                                                        r9 = upvalueValues[r51]
                                                        r22 = "WM\127\138"
                                                        r19 = 35108538253276
                                                        r16 = r9(r22, r19)
                                                        r62 = r36[r16]
                                                        r16 = "UDim2"
                                                        r9 = _env[r16]
                                                        r22 = upvalueValues[r79]
                                                        r19 = upvalueValues[r51]
                                                        r40 = "\247m\148"
                                                        r28 = 15456965024797
                                                        r58 = r19(r40, r28)
                                                        r16 = r22[r58]
                                                        r36 = r9[r16]
                                                        r22 = -20
                                                        r19 = 0
                                                        r16 = 1
                                                        r58 = 20
                                                        r9 = r36(r16, r22, r19, r58)
                                                        r81[r62] = r9
                                                        r36 = upvalueValues[r79]
                                                        r9 = upvalueValues[r51]
                                                        r19 = 23548318673621
                                                        r22 = "\002(\241\247\228\170\167X"
                                                        r16 = r9(r22, r19)
                                                        r62 = r36[r16]
                                                        r16 = "UDim2"
                                                        r9 = _env[r16]
                                                        r22 = upvalueValues[r79]
                                                        r19 = upvalueValues[r51]
                                                        r40 = "\221&\244"
                                                        r28 = 18205402636573
                                                        r58 = r19(r40, r28)
                                                        r16 = r22[r58]
                                                        r36 = r9[r16]
                                                        r19 = 0
                                                        r22 = 10
                                                        r16 = 0
                                                        r58 = 372
                                                        r9 = r36(r16, r22, r19, r58)
                                                        r81[r62] = r9
                                                        r36 = upvalueValues[r79]
                                                        r9 = upvalueValues[r51]
                                                        r19 = 19015922442902
                                                        r22 = "\146\157\025\163\146=x77+\030\217\2208\018\197\016\014b\162\155G"
                                                        r16 = r9(r22, r19)
                                                        r62 = r36[r16]
                                                        r36 = 1
                                                        r81[r62] = r36
                                                        r36 = upvalueValues[r79]
                                                        r9 = upvalueValues[r51]
                                                        r22 = "\1880\150w\127\140G\222\218\212"
                                                        r19 = 16483731119611
                                                        r16 = r9(r22, r19)
                                                        r62 = r36[r16]
                                                        r16 = "Color3"
                                                        r9 = _env[r16]
                                                        r22 = upvalueValues[r79]
                                                        r19 = upvalueValues[r51]
                                                        r40 = "\168/\152\232/\168E"
                                                        r28 = 33940668612028
                                                        r58 = r19(r40, r28)
                                                        r16 = r22[r58]
                                                        r36 = r9[r16]
                                                        r19 = 170
                                                        r16 = 170
                                                        r22 = 170
                                                        r9 = r36(r16, r22, r19)
                                                        r81[r62] = r9
                                                        r36 = upvalueValues[r79]
                                                        r9 = upvalueValues[r51]
                                                        r22 = "\1590\136\221"
                                                        r19 = 9308057456878
                                                        r16 = r9(r22, r19)
                                                        r62 = r36[r16]
                                                        r22 = "Enum"
                                                        r16 = _env[r22]
                                                        r19 = upvalueValues[r79]
                                                        r58 = upvalueValues[r51]
                                                        r77 = 13136852654053
                                                        r28 = "\024\197E@"
                                                        r40 = r58(r28, r77)
                                                        r22 = r19[r40]
                                                        r9 = r16[r22]
                                                        r22 = upvalueValues[r79]
                                                        r19 = upvalueValues[r51]
                                                        r28 = 32571791997759
                                                        r40 = "\160v\000j"
                                                        r58 = r19(r40, r28)
                                                        r16 = r22[r58]
                                                        r36 = r9[r16]
                                                        r81[r62] = r36
                                                        r36 = upvalueValues[r79]
                                                        r9 = upvalueValues[r51]
                                                        r22 = "v\190\153\232\148\008\"\192"
                                                        r19 = 15709630700691
                                                        r16 = r9(r22, r19)
                                                        r62 = r36[r16]
                                                        r36 = 13
                                                        r81[r62] = r36
                                                        r36 = upvalueValues[r79]
                                                        r9 = upvalueValues[r51]
                                                        r19 = 30444454590304
                                                        r22 = "\218\024\156h)\244\175\169t\202yi{\182"
                                                        r16 = r9(r22, r19)
                                                        r62 = r36[r16]
                                                        r22 = "Enum"
                                                        r16 = _env[r22]
                                                        r19 = upvalueValues[r79]
                                                        r58 = upvalueValues[r51]
                                                        r77 = 3625655781016
                                                        r28 = "y\003\218,9\221>V\196~\1570\237("
                                                        r40 = r58(r28, r77)
                                                        r22 = r19[r40]
                                                        r9 = r16[r22]
                                                        r22 = upvalueValues[r79]
                                                        r19 = upvalueValues[r51]
                                                        r28 = 32146943212153
                                                        r40 = "\245Y\203\230"
                                                        r58 = r19(r40, r28)
                                                        r16 = r22[r58]
                                                        r36 = r9[r16]
                                                        r81[r62] = r36
                                                        r36 = upvalueValues[r79]
                                                        r9 = upvalueValues[r51]
                                                        r19 = 2792744682772
                                                        r22 = "\140\"[\005"
                                                        r16 = r9(r22, r19)
                                                        r62 = r36[r16]
                                                        r9 = upvalueValues[r79]
                                                        r16 = upvalueValues[r51]
                                                        r58 = 34500879728321
                                                        r19 = "\128\252\142\133\169\144\172\232\172C<\233%\029\184\012 ~\147,\213J\011\214\0190\002\161\203\008\221]}\233\198zi\232"
                                                        r22 = r16(r19, r58)
                                                        r36 = r9[r22]
                                                        r81[r62] = r36
                                                        r36 = upvalueValues[r79]
                                                        r9 = upvalueValues[r51]
                                                        r22 = "G\214=\237E\151"
                                                        r19 = 22750997211490
                                                        r16 = r9(r22, r19)
                                                        r62 = r36[r16]
                                                        r36 = r7
                                                        r24[r62] = r36
                                                        r62 = upvalueValues[r21]
                                                        r9 = upvalueValues[r79]
                                                        r16 = upvalueValues[r51]
                                                        r19 = "Au\027\193(1"
                                                        r58 = 3626126296728
                                                        r22 = r16(r19, r58)
                                                        r36 = r9[r22]
                                                        r9 = r7
                                                        r62[r36] = r9
                                                        r36 = upvalueValues[r79]
                                                        r9 = upvalueValues[r51]
                                                        r19 = 24636873993424
                                                        r22 = "\135\245\182\029e:"
                                                        r16 = r9(r22, r19)
                                                        r62 = r36[r16]
                                                        r36 = r7
                                                        r25[r62] = r36
                                                        r36 = upvalueValues[r79]
                                                        r9 = upvalueValues[r51]
                                                        r22 = "\031<\237\142\001\169"
                                                        r19 = 18166909395211
                                                        r16 = r9(r22, r19)
                                                        r58 = 11018318533642
                                                        r25 = nil
                                                        r62 = r36[r16]
                                                        r36 = r7
                                                        r26[r62] = r36
                                                        r62 = upvalueValues[r8]
                                                        r9 = upvalueValues[r79]
                                                        r16 = upvalueValues[r51]
                                                        r19 = "},\134\138\186\198"
                                                        r22 = r16(r19, r58)
                                                        r36 = r9[r22]
                                                        r9 = r7
                                                        r62[r36] = r9
                                                        r36 = upvalueValues[r79]
                                                        r9 = upvalueValues[r51]
                                                        r22 = "\143\228y\232}'"
                                                        r19 = 12187150865963
                                                        r16 = r9(r22, r19)
                                                        r62 = r36[r16]
                                                        r36 = r7
                                                        r14[r62] = r36
                                                        r36 = upvalueValues[r79]
                                                        r9 = upvalueValues[r51]
                                                        r19 = 5969899260635
                                                        r22 = "\238\210<D\026\239"
                                                        r16 = r9(r22, r19)
                                                        r62 = r36[r16]
                                                        r36 = r7
                                                        r81[r62] = r36
                                                        r22 = "\002\213\248;dl"
                                                        r19 = 28857676100733
                                                        r77 = 2413426410595
                                                        r36 = upvalueValues[r79]
                                                        r26 = nil
                                                        r9 = upvalueValues[r51]
                                                        r16 = r9(r22, r19)
                                                        r62 = r36[r16]
                                                        r36 = r7
                                                        r55[r62] = r36
                                                        r62 = upvalueValues[r29]
                                                        r9 = upvalueValues[r79]
                                                        r16 = upvalueValues[r51]
                                                        r19 = "\233\193\008_\018\240"
                                                        r58 = 12331770713710
                                                        r22 = r16(r19, r58)
                                                        r36 = r9[r22]
                                                        r9 = r7
                                                        r62[r36] = r9
                                                        r62 = upvalueValues[r75]
                                                        r9 = upvalueValues[r79]
                                                        r16 = upvalueValues[r51]
                                                        r58 = 2875091174714
                                                        r19 = "h\n\008\012\204)"
                                                        r22 = r16(r19, r58)
                                                        r36 = r9[r22]
                                                        r9 = r7
                                                        r62[r36] = r9
                                                        r62 = upvalueValues[r34]
                                                        r9 = upvalueValues[r79]
                                                        r16 = upvalueValues[r51]
                                                        r58 = 6860053302394
                                                        r19 = "7L\192\134\246,"
                                                        r22 = r16(r19, r58)
                                                        r36 = r9[r22]
                                                        r9 = r7
                                                        r62[r36] = r9
                                                        r36 = upvalueValues[r79]
                                                        r9 = upvalueValues[r51]
                                                        r19 = 34691788832538
                                                        r22 = "O\193\016\249\005\232"
                                                        r16 = r9(r22, r19)
                                                        r62 = r36[r16]
                                                        r36 = r20
                                                        r7[r62] = r36
                                                        r28 = "\164\213U\018\0078\030\191\222\253\143\004:\233iP\248"
                                                        r19 = 31620174510468
                                                        r22 = "\165q\220\219\142X"
                                                        r81 = nil
                                                        r36 = upvalueValues[r79]
                                                        r9 = upvalueValues[r51]
                                                        r16 = r9(r22, r19)
                                                        r62 = r36[r16]
                                                        r36 = r61
                                                        r20[r62] = r36
                                                        r62 = allocUpvalue()
                                                        r9 = allocUpvalue()
                                                        r36 = createClosure1(64, {
                                                            r79,
                                                            r51
                                                        })
                                                        upvalueValues[r62] = r36
                                                        r36 = false
                                                        upvalueValues[r9] = r36
                                                        r24 = nil
                                                        r16 = upvalueValues[r34]
                                                        r19 = upvalueValues[r79]
                                                        r58 = upvalueValues[r51]
                                                        r40 = r58(r28, r77)
                                                        r22 = r19[r40]
                                                        r36 = r16[r22]
                                                        r16 = "Connect"
                                                        r16 = r36[r16]
                                                        r22 = createClosure4(201, {
                                                            r9,
                                                            r75,
                                                            r79,
                                                            r51,
                                                            r34
                                                        })
                                                        r16 = r16(r36, r22)
                                                        r22 = upvalueValues[r79]
                                                        r19 = upvalueValues[r51]
                                                        r40 = "\244\011\153\008u92s\145\166R\228\024x\253\007\012"
                                                        r28 = 5898715073210
                                                        r58 = r19(r40, r28)
                                                        r34 = releaseUpvalue(r34)
                                                        r16 = r22[r58]
                                                        r75 = releaseUpvalue(r75)
                                                        r22 = createClosure4(205, {
                                                            r66,
                                                            r79,
                                                            r51,
                                                            r9,
                                                            r29,
                                                            r21,
                                                            r62,
                                                            r8
                                                        })
                                                        r29 = releaseUpvalue(r29)
                                                        r36 = r14[r16]
                                                        r77 = 13909328402765
                                                        r40 = "\0044QS"
                                                        r61 = nil
                                                        r16 = "Connect"
                                                        r16 = r36[r16]
                                                        r62 = releaseUpvalue(r62)
                                                        r28 = 19621560132529
                                                        r7 = nil
                                                        r16 = r16(r36, r22)
                                                        r36 = upvalueValues[r21]
                                                        r22 = upvalueValues[r79]
                                                        r19 = upvalueValues[r51]
                                                        r58 = r19(r40, r28)
                                                        r14 = nil
                                                        r21 = releaseUpvalue(r21)
                                                        r55 = nil
                                                        r8 = releaseUpvalue(r8)
                                                        r9 = releaseUpvalue(r9)
                                                        r16 = r22[r58]
                                                        r28 = "\153\187(i\024xq\131\217xY\183\164\199\237\223@\212=2?X\016\138\180\192\207\202\021\145\017"
                                                        r20 = nil
                                                        r19 = upvalueValues[r79]
                                                        r58 = upvalueValues[r51]
                                                        r51 = releaseUpvalue(r51)
                                                        r40 = r58(r28, r77)
                                                        r79 = releaseUpvalue(r79)
                                                        r22 = r19[r40]
                                                        r66 = releaseUpvalue(r66)
                                                        r36[r16] = r22
                                                        state = nil
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure4 entry 1269674 -> 32, states 32-32
                                    if state == 32 then -- entry 1269674 -> 32
                                        ReturnVal = "error"
                                        state = _env[ReturnVal]
                                        r18 = "Tamper Detected!"
                                        ReturnVal = state(r18)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure4 entry 9893112 -> 33, states 33-33
                                if state == 33 then -- entry 9893112 -> 33
                                    state = true
                                    upvalueValues[upvalues[1]] = state
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            if state <= 34 then
                                -- createClosure0 entry 10444592 -> 34, states 34-34
                                if state == 34 then -- entry 10444592 -> 34
                                    r21 = 7437240
                                    r79 = "cyqmd2evZ3DDb"
                                    r18 = r79 ^ r21
                                    ReturnVal = 12354482
                                    state = ReturnVal - r18
                                    r18 = state
                                    ReturnVal = "dpgFa"
                                    state = ReturnVal / r18
                                    ReturnVal = {
                                        state
                                    }
                                    state = nil
                                end
                            else
                                -- createClosure2 entry 10020113 -> 35, states 35-46
                                if state <= 40 then
                                    if state <= 37 then
                                        if state <= 36 then
                                            if state <= 35 then
                                                if state == 35 then -- entry 10020113 -> 35
                                                    r79 = upvalueValues[upvalues[1]]
                                                    r51 = 1
                                                    r61 = 2
                                                    r21 = r79(r51, r61)
                                                    r79 = 1
                                                    r18 = r21 == r79
                                                    state = r18 and (36) or (37)
                                                    ReturnVal = r18
                                                end
                                            else
                                                if state == 36 then
                                                    state = ReturnVal and (38) or (39)
                                                end
                                            end
                                        else
                                            if state == 37 then
                                                r79 = upvalueValues[upvalues[2]]
                                                r21 = upvalueValues[upvalues[3]]
                                                r18 = r79 == r21
                                                ReturnVal = r18
                                                state = 36
                                            end
                                        end
                                    else
                                        if state <= 39 then
                                            if state <= 38 then
                                                if state == 38 then
                                                    ReturnVal = "tonumber"
                                                    state = _env[ReturnVal]
                                                    r18 = upvalueValues[upvalues[4]]
                                                    r66 = createClosure4(280, {})
                                                    r51 = "tostring"
                                                    r21 = _env[r51]
                                                    r24 = "pcall"
                                                    r7 = _env[r24]
                                                    r24 = {
                                                        r7(r66)
                                                    }
                                                    r20 = {
                                                        unpack(r24)
                                                    }
                                                    r7 = 2
                                                    r61 = r20[r7]
                                                    r51 = r21(r61)
                                                    r21 = ":(%d*):"
                                                    r79 = r18(r51, r21)
                                                    r18 = {
                                                        r79()
                                                    }
                                                    ReturnVal = state(unpack(r18))
                                                    r18 = ReturnVal
                                                    r79 = upvalueValues[upvalues[5]]
                                                    state = r79 and (40) or (41)
                                                    ReturnVal = r79
                                                end
                                            else
                                                if state == 39 then
                                                    state = upvalueValues[upvalues[7]]
                                                    state = state and (42) or (43)
                                                end
                                            end
                                        else
                                            if state == 40 then
                                                r21 = upvalueValues[upvalues[6]]
                                                r79 = r21 == r18
                                                ReturnVal = r79
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
                                                    r18 = nil
                                                    state = 39
                                                end
                                            else
                                                if state == 42 then
                                                    r18 = "error"
                                                    state = _env[r18]
                                                    r79 = upvalueValues[upvalues[8]]
                                                    r21 = 0
                                                    r18 = state(r79, r21)
                                                    state = 43
                                                end
                                            end
                                        else
                                            if state == 43 then
                                                state = {}
                                                r18 = state
                                                r21 = upvalueValues[upvalues[9]]
                                                r51 = r21
                                                r21 = 1
                                                r61 = r21
                                                r21 = 0
                                                r20 = r61 < r21
                                                r79 = 1
                                                r21 = r79 - r61
                                                state = 44
                                            end
                                        end
                                    else
                                        if state <= 45 then
                                            if state <= 44 then
                                                if state == 44 then
                                                    r21 = r21 + r61
                                                    r79 = r21 <= r51
                                                    r7 = not r20
                                                    r79 = r7 and r79
                                                    r7 = r21 >= r51
                                                    r7 = r20 and r7
                                                    r79 = r7 or r79
                                                    r7 = (45)
                                                    state = r79 and r7
                                                    r79 = (46)
                                                    state = state or r79
                                                end
                                            else
                                                if state == 45 then
                                                    r79 = r21
                                                    state = upvalueValues[upvalues[1]]
                                                    r24 = 0
                                                    r66 = 255
                                                    r7 = state(r24, r66)
                                                    r18[r79] = r7
                                                    r79 = nil
                                                    state = 44
                                                end
                                            end
                                        else
                                            if state == 46 then
                                                state = upvalueValues[upvalues[10]]
                                                r79 = upvalueValues[upvalues[11]]
                                                r18[state] = r79
                                                state = upvalueValues[upvalues[12]]
                                                r79 = {
                                                    state(r18)
                                                }
                                                ReturnVal = {
                                                    unpack(r79)
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 63 then
                            if state <= 56 then
                                if state <= 50 then
                                    -- createClosure3 entry 6238798 -> 47, states 47-50
                                    if state <= 48 then
                                        if state <= 47 then
                                            if state == 47 then -- entry 6238798 -> 47
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
                                                r18 = "l1"
                                                ReturnVal = _env[r18]
                                                r18 = "l1"
                                                _env[r18] = state
                                                r18 = "l2"
                                                _env[r18] = ReturnVal
                                                r18 = upvalueValues[upvalues[1]]
                                                r79 = r18()
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
                                    -- createClosure0 entry 842072 -> 51, states 51-56
                                    if state <= 53 then
                                        if state <= 52 then
                                            if state <= 51 then
                                                if state == 51 then -- entry 842072 -> 51
                                                    r18 = upvalueValues[upvalues[1]]
                                                    ReturnVal = #r18
                                                    r18 = 0
                                                    state = ReturnVal == r18
                                                    state = state and (52) or (53)
                                                end
                                            else
                                                if state == 52 then
                                                    r79 = upvalueValues[upvalues[2]]
                                                    r21 = 249
                                                    r18 = r79 * r21
                                                    r79 = 25696130887357
                                                    ReturnVal = r18 + r79
                                                    r18 = 35184372088832
                                                    state = ReturnVal % r18
                                                    upvalueValues[upvalues[2]] = state
                                                    r18 = upvalueValues[upvalues[3]]
                                                    r79 = 1
                                                    ReturnVal = r18 ~= r79
                                                    state = 54
                                                end
                                            end
                                        else
                                            if state == 53 then
                                                r21 = "table"
                                                r79 = _env[r21]
                                                r21 = "remove"
                                                r18 = r79[r21]
                                                r21 = upvalueValues[upvalues[1]]
                                                r79 = {
                                                    r18(r21)
                                                }
                                                ReturnVal = {
                                                    unpack(r79)
                                                }
                                                state = nil
                                            end
                                        end
                                    else
                                        if state <= 55 then
                                            if state <= 54 then
                                                if state == 54 then
                                                    r79 = upvalueValues[upvalues[3]]
                                                    r21 = 82
                                                    r18 = r79 * r21
                                                    r79 = 257
                                                    ReturnVal = r18 % r79
                                                    upvalueValues[upvalues[3]] = ReturnVal
                                                    state = 55
                                                end
                                            else
                                                if state == 55 then
                                                    r79 = upvalueValues[upvalues[3]]
                                                    r21 = 1
                                                    r18 = r79 ~= r21
                                                    state = r18 and (56) or (54)
                                                end
                                            end
                                        else
                                            if state == 56 then
                                                r21 = 32
                                                r79 = upvalueValues[upvalues[3]]
                                                r66 = 2
                                                r18 = r79 % r21
                                                r51 = upvalueValues[upvalues[4]]
                                                r7 = upvalueValues[upvalues[2]]
                                                r55 = upvalueValues[upvalues[3]]
                                                r29 = r55 - r18
                                                r55 = 32
                                                r26 = r29 / r55
                                                r8 = 13
                                                r25 = r8 - r26
                                                r24 = r66 ^ r25
                                                r20 = r7 / r24
                                                r61 = r51(r20)
                                                r24 = 1
                                                r51 = 4294967296
                                                r21 = r61 % r51
                                                r61 = 2
                                                r51 = r61 ^ r18
                                                r79 = r21 / r51
                                                r51 = upvalueValues[upvalues[4]]
                                                r7 = r79 % r24
                                                r24 = 4294967296
                                                r20 = r7 * r24
                                                r61 = r51(r20)
                                                r51 = upvalueValues[upvalues[4]]
                                                r20 = r51(r79)
                                                r21 = r61 + r20
                                                r18 = nil
                                                r61 = 65536
                                                r7 = 65536
                                                r51 = r21 % r61
                                                r20 = r21 - r51
                                                r61 = r20 / r7
                                                r21 = nil
                                                r7 = 256
                                                r20 = r51 % r7
                                                r24 = r51 - r20
                                                r66 = 256
                                                r51 = nil
                                                r7 = r24 / r66
                                                r66 = 256
                                                r24 = r61 % r66
                                                r79 = nil
                                                r25 = r61 - r24
                                                r8 = 256
                                                r61 = nil
                                                r66 = r25 / r8
                                                r25 = {
                                                    r20,
                                                    r7,
                                                    r24,
                                                    r66
                                                }
                                                r66 = nil
                                                r20 = nil
                                                upvalueValues[upvalues[1]] = r25
                                                r7 = nil
                                                r24 = nil
                                                state = 53
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure5 entry 13946783 -> 57, states 57-63
                                if state <= 60 then
                                    if state <= 58 then
                                        if state <= 57 then
                                            if state == 57 then -- entry 13946783 -> 57
                                                r18 = args[1]
                                                r79 = args[2]
                                                state = upvalueValues[upvalues[1]]
                                                r21 = state
                                                state = r21[r79]
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
                                                r51 = ReturnVal
                                                r61 = 35184372088832
                                                ReturnVal = r79 % r61
                                                upvalueValues[upvalues[4]] = ReturnVal
                                                r7 = 255
                                                r20 = r79 % r7
                                                r7 = 2
                                                r61 = r20 + r7
                                                upvalueValues[upvalues[5]] = r61
                                                r24 = "string"
                                                r7 = _env[r24]
                                                r24 = "len"
                                                r20 = r7[r24]
                                                r7 = r20(r18)
                                                r20 = ""
                                                r21[r79] = r20
                                                r25 = 1
                                                r8 = r25
                                                r25 = 0
                                                r26 = r8 < r25
                                                r24 = 1
                                                r25 = r24 - r8
                                                r66 = r7
                                                r20 = 212
                                                state = 61
                                            end
                                        else
                                            if state == 60 then
                                                ReturnVal = {
                                                    r79
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    if state <= 62 then
                                        if state <= 61 then
                                            if state == 61 then
                                                r29 = not r26
                                                r25 = r25 + r8
                                                r24 = r25 <= r66
                                                r24 = r29 and r24
                                                r29 = r25 >= r66
                                                r29 = r26 and r29
                                                r24 = r29 or r24
                                                r29 = (62)
                                                state = r24 and r29
                                                r24 = (63)
                                                state = state or r24
                                            end
                                        else
                                            if state == 62 then
                                                r76 = "string"
                                                r53 = _env[r76]
                                                r24 = r25
                                                r76 = "byte"
                                                r30 = r53[r76]
                                                r53 = r30(r18, r24)
                                                r24 = nil
                                                r30 = upvalueValues[upvalues[6]]
                                                r76 = r30()
                                                r75 = r53 + r76
                                                r55 = r75 + r20
                                                r75 = 256
                                                r29 = r55 % r75
                                                r20 = r29
                                                r75 = r21[r79]
                                                r76 = 1
                                                r53 = r20 + r76
                                                r30 = r51[r53]
                                                r55 = r75 .. r30
                                                r21[r79] = r55
                                                state = 61
                                            end
                                        end
                                    else
                                        if state == 63 then
                                            r7 = nil
                                            r20 = nil
                                            r51 = nil
                                            state = 60
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 200 then
                                -- createClosure1 entry 12536225 -> 64, states 64-200
                                if state <= 132 then
                                    if state <= 98 then
                                        if state <= 81 then
                                            if state <= 72 then
                                                if state <= 68 then
                                                    if state <= 66 then
                                                        if state <= 65 then
                                                            if state <= 64 then
                                                                if state == 64 then -- entry 12536225 -> 64
                                                                    r18 = args[1]
                                                                    r79 = allocUpvalue()
                                                                    state = {}
                                                                    upvalueValues[r79] = state
                                                                    r21 = allocUpvalue()
                                                                    state = {}
                                                                    upvalueValues[r21] = state
                                                                    state = createClosure8(281, {
                                                                        upvalues[1],
                                                                        upvalues[2],
                                                                        r21,
                                                                        r79
                                                                    })
                                                                    r51 = state
                                                                    r61 = upvalueValues[upvalues[1]]
                                                                    r20 = upvalueValues[upvalues[2]]
                                                                    r24 = "\180a\188\016\160Y\214\195m>\212v\237J"
                                                                    r66 = 14565371189886
                                                                    r7 = r20(r24, r66)
                                                                    ReturnVal = r61[r7]
                                                                    state = "gsub"
                                                                    state = r18[state]
                                                                    r20 = upvalueValues[upvalues[1]]
                                                                    r7 = upvalueValues[upvalues[2]]
                                                                    r25 = 30972052715606
                                                                    r66 = ""
                                                                    r24 = r7(r66, r25)
                                                                    r61 = r20[r24]
                                                                    state = state(r18, ReturnVal, r61)
                                                                    r20 = upvalueValues[upvalues[1]]
                                                                    r7 = upvalueValues[upvalues[2]]
                                                                    r66 = "\237\244Y\131\134\140\233"
                                                                    r25 = 27603793343030
                                                                    r24 = r7(r66, r25)
                                                                    r61 = r20[r24]
                                                                    r7 = upvalueValues[upvalues[1]]
                                                                    r24 = upvalueValues[upvalues[2]]
                                                                    r8 = 13321667713083
                                                                    r25 = "\196"
                                                                    r66 = r24(r25, r8)
                                                                    r20 = r7[r66]
                                                                    ReturnVal = "gsub"
                                                                    ReturnVal = state[ReturnVal]
                                                                    ReturnVal = ReturnVal(state, r61, r20)
                                                                    r61 = ReturnVal
                                                                    r24 = upvalueValues[upvalues[1]]
                                                                    r66 = upvalueValues[upvalues[2]]
                                                                    r26 = 5095738067268
                                                                    r8 = "#\212b\149\180\235\154\222\207\177\030\219"
                                                                    r25 = r66(r8, r26)
                                                                    r7 = r24[r25]
                                                                    r24 = "gmatch"
                                                                    r24 = r61[r24]
                                                                    r24 = {
                                                                        r24(r61, r7)
                                                                    }
                                                                    state = r24[1]
                                                                    ReturnVal = r24[2]
                                                                    r20 = r24[3]
                                                                    r7 = state
                                                                    state = upvalueValues[r79]
                                                                    r66 = state
                                                                    r24 = ReturnVal
                                                                    state = 65
                                                                end
                                                            else
                                                                if state == 65 then
                                                                    state = true
                                                                    state = state and (66) or (67)
                                                                end
                                                            end
                                                        else
                                                            if state == 66 then
                                                                r8 = {
                                                                    r7(r24, r20)
                                                                }
                                                                ReturnVal = r8[2]
                                                                state = nil
                                                                r25 = state
                                                                state = r8[1]
                                                                r20 = state
                                                                r26 = nil
                                                                r8 = r20 == r26
                                                                state = r8 and (68) or (69)
                                                                r25 = ReturnVal
                                                            end
                                                        end
                                                    else
                                                        if state <= 67 then
                                                            if state == 67 then
                                                                r55 = upvalueValues[upvalues[1]]
                                                                r75 = upvalueValues[upvalues[2]]
                                                                r76 = 20805368767960
                                                                r53 = "\018t&\1924\011\235&\215\129\160\150"
                                                                r30 = r75(r53, r76)
                                                                r29 = r55[r30]
                                                                r55 = "gmatch"
                                                                r55 = r61[r55]
                                                                r55 = {
                                                                    r55(r61, r29)
                                                                }
                                                                r25 = r55[1]
                                                                r26 = r55[3]
                                                                r8 = r55[2]
                                                                state = 70
                                                            end
                                                        else
                                                            if state == 68 then
                                                                r25 = nil
                                                                state = 67
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 70 then
                                                        if state <= 69 then
                                                            if state == 69 then
                                                                r26 = #r25
                                                                r29 = 0
                                                                r8 = r26 > r29
                                                                state = r8 and (71) or (72)
                                                            end
                                                        else
                                                            if state == 70 then
                                                                r29 = true
                                                                state = r29 and (73) or (74)
                                                            end
                                                        end
                                                    else
                                                        if state <= 71 then
                                                            if state == 71 then
                                                                r29 = upvalueValues[upvalues[1]]
                                                                r55 = upvalueValues[upvalues[2]]
                                                                r53 = 5556273891867
                                                                r30 = "C\196~\194a?"
                                                                r75 = r55(r30, r53)
                                                                r26 = r29[r75]
                                                                r55 = r25 .. r20
                                                                r29 = r20 .. r55
                                                                r30 = upvalueValues[upvalues[1]]
                                                                r53 = upvalueValues[upvalues[2]]
                                                                r62 = 10709087605626
                                                                r34 = "\142Yq"
                                                                r76 = r53(r34, r62)
                                                                r75 = r30[r76]
                                                                r30 = #r25
                                                                r55 = {
                                                                    [r75] = r30
                                                                }
                                                                r8 = r51(r26, r25, r29, r55)
                                                                state = 72
                                                            end
                                                        else
                                                            if state == 72 then
                                                                r25 = nil
                                                                state = 65
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 77 then
                                                    if state <= 75 then
                                                        if state <= 74 then
                                                            if state <= 73 then
                                                                if state == 73 then
                                                                    r29 = r25(r8, r26)
                                                                    r26 = r29
                                                                    r75 = nil
                                                                    r55 = r26 == r75
                                                                    state = r55 and (75) or (76)
                                                                end
                                                            else
                                                                if state == 74 then
                                                                    r76 = upvalueValues[upvalues[1]]
                                                                    r34 = upvalueValues[upvalues[2]]
                                                                    r11 = "nRph\249e"
                                                                    r14 = 13651251026132
                                                                    r62 = r34(r11, r14)
                                                                    r53 = r76[r62]
                                                                    r76 = "gmatch"
                                                                    r76 = r61[r76]
                                                                    r76 = {
                                                                        r76(r61, r53)
                                                                    }
                                                                    r55 = r76[1]
                                                                    r30 = r76[3]
                                                                    r75 = r76[2]
                                                                    state = 77
                                                                end
                                                            end
                                                        else
                                                            if state == 75 then
                                                                state = 74
                                                            end
                                                        end
                                                    else
                                                        if state <= 76 then
                                                            if state == 76 then
                                                                r75 = #r26
                                                                r30 = 0
                                                                r55 = r75 > r30
                                                                state = r55 and (78) or (79)
                                                            end
                                                        else
                                                            if state == 77 then
                                                                r53 = true
                                                                state = r53 and (80) or (81)
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 79 then
                                                        if state <= 78 then
                                                            if state == 78 then
                                                                r30 = upvalueValues[upvalues[1]]
                                                                r53 = upvalueValues[upvalues[2]]
                                                                r34 = "\192\247r\240\187g\127\1304\133\190"
                                                                r62 = 816356393340
                                                                r76 = r53(r34, r62)
                                                                r75 = r30[r76]
                                                                r76 = upvalueValues[upvalues[1]]
                                                                r34 = upvalueValues[upvalues[2]]
                                                                r11 = "\226\206"
                                                                r14 = 14334743403027
                                                                r62 = r34(r11, r14)
                                                                r53 = r76[r62]
                                                                r62 = upvalueValues[upvalues[1]]
                                                                r11 = upvalueValues[upvalues[2]]
                                                                r36 = 17767939874897
                                                                r81 = ".\027"
                                                                r14 = r11(r81, r36)
                                                                r34 = r62[r14]
                                                                r76 = r26 .. r34
                                                                r30 = r53 .. r76
                                                                r34 = upvalueValues[upvalues[1]]
                                                                r62 = upvalueValues[upvalues[2]]
                                                                r81 = 3609101076112
                                                                r14 = "\186\130\185"
                                                                r11 = r62(r14, r81)
                                                                r76 = r34[r11]
                                                                r34 = #r26
                                                                r53 = {
                                                                    [r76] = r34
                                                                }
                                                                r55 = r51(r75, r26, r30, r53)
                                                                state = 79
                                                            end
                                                        else
                                                            if state == 79 then
                                                                state = 70
                                                            end
                                                        end
                                                    else
                                                        if state <= 80 then
                                                            if state == 80 then
                                                                r53 = r55(r75, r30)
                                                                r30 = r53
                                                                r34 = nil
                                                                r76 = r30 == r34
                                                                state = r76 and (82) or (83)
                                                            end
                                                        else
                                                            if state == 81 then
                                                                r14 = upvalueValues[upvalues[1]]
                                                                r81 = upvalueValues[upvalues[2]]
                                                                r16 = 18253545906483
                                                                r9 = "z\234\140\173#Q\142\156\017\001\020D6\236\151Ef\205\199\250\196k\202)\253\132\210"
                                                                r36 = r81(r9, r16)
                                                                r11 = r14[r36]
                                                                r14 = "gmatch"
                                                                r14 = r61[r14]
                                                                r14 = {
                                                                    r14(r61, r11)
                                                                }
                                                                r34 = r14[2]
                                                                r76 = r14[1]
                                                                r62 = r14[3]
                                                                state = 84
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 90 then
                                                if state <= 86 then
                                                    if state <= 84 then
                                                        if state <= 83 then
                                                            if state <= 82 then
                                                                if state == 82 then
                                                                    state = 81
                                                                end
                                                            else
                                                                if state == 83 then
                                                                    r34 = #r30
                                                                    r62 = 0
                                                                    r76 = r34 > r62
                                                                    state = r76 and (85) or (86)
                                                                end
                                                            end
                                                        else
                                                            if state == 84 then
                                                                r11 = true
                                                                state = r11 and (87) or (88)
                                                            end
                                                        end
                                                    else
                                                        if state <= 85 then
                                                            if state == 85 then
                                                                r62 = upvalueValues[upvalues[1]]
                                                                r11 = upvalueValues[upvalues[2]]
                                                                r36 = 5334564997556
                                                                r81 = "j\234!\161\244\255o\201\177}\r"
                                                                r14 = r11(r81, r36)
                                                                r34 = r62[r14]
                                                                r14 = upvalueValues[upvalues[1]]
                                                                r81 = upvalueValues[upvalues[2]]
                                                                r16 = 7235227372841
                                                                r9 = "\155"
                                                                r36 = r81(r9, r16)
                                                                r11 = r14[r36]
                                                                r36 = upvalueValues[upvalues[1]]
                                                                r9 = upvalueValues[upvalues[2]]
                                                                r31 = 3103752914341
                                                                r37 = "\008"
                                                                r16 = r9(r37, r31)
                                                                r81 = r36[r16]
                                                                r14 = r30 .. r81
                                                                r62 = r11 .. r14
                                                                r81 = upvalueValues[upvalues[1]]
                                                                r36 = upvalueValues[upvalues[2]]
                                                                r16 = "J\143\017"
                                                                r37 = 23501474392767
                                                                r9 = r36(r16, r37)
                                                                r14 = r81[r9]
                                                                r81 = #r30
                                                                r11 = {
                                                                    [r14] = r81
                                                                }
                                                                r76 = r51(r34, r30, r62, r11)
                                                                state = 86
                                                            end
                                                        else
                                                            if state == 86 then
                                                                state = 77
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 88 then
                                                        if state <= 87 then
                                                            if state == 87 then
                                                                r11 = r76(r34, r62)
                                                                r62 = r11
                                                                r81 = nil
                                                                r14 = r62 == r81
                                                                state = r14 and (89) or (90)
                                                            end
                                                        else
                                                            if state == 88 then
                                                                r16 = upvalueValues[upvalues[1]]
                                                                r31 = upvalueValues[upvalues[2]]
                                                                r58 = 28782267249754
                                                                r19 = "\254\204\222&g?/\2476\159@\255\201"
                                                                r22 = r31(r19, r58)
                                                                r9 = r16[r22]
                                                                r16 = "gmatch"
                                                                r16 = r61[r16]
                                                                r16 = {
                                                                    r16(r61, r9)
                                                                }
                                                                r36 = r16[3]
                                                                r14 = r16[1]
                                                                r81 = r16[2]
                                                                state = 91
                                                            end
                                                        end
                                                    else
                                                        if state <= 89 then
                                                            if state == 89 then
                                                                r16 = nil
                                                                r14 = nil
                                                                r36 = nil
                                                                r9 = nil
                                                                r81 = nil
                                                                state = 88
                                                            end
                                                        else
                                                            if state == 90 then
                                                                r58 = upvalueValues[upvalues[1]]
                                                                r40 = upvalueValues[upvalues[2]]
                                                                r77 = "x\1683"
                                                                r69 = 15290903780304
                                                                r28 = r40(r77, r69)
                                                                r19 = r58[r28]
                                                                r58 = "gmatch"
                                                                r58 = r62[r58]
                                                                r58 = {
                                                                    r58(r62, r19)
                                                                }
                                                                r31 = r58[2]
                                                                r22 = r58[3]
                                                                r37 = r58[1]
                                                                r14 = r37
                                                                r37 = {}
                                                                r9 = r62
                                                                r81 = r31
                                                                r36 = r22
                                                                r16 = r37
                                                                state = 92
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 94 then
                                                    if state <= 92 then
                                                        if state <= 91 then
                                                            if state == 91 then
                                                                r9 = true
                                                                state = r9 and (93) or (94)
                                                            end
                                                        else
                                                            if state == 92 then
                                                                r37 = true
                                                                state = r37 and (95) or (96)
                                                            end
                                                        end
                                                    else
                                                        if state <= 93 then
                                                            if state == 93 then
                                                                r9 = r14(r81, r36)
                                                                r36 = r9
                                                                r31 = nil
                                                                r16 = r36 == r31
                                                                state = r16 and (97) or (98)
                                                            end
                                                        else
                                                            if state == 94 then
                                                                r58 = upvalueValues[upvalues[1]]
                                                                r40 = upvalueValues[upvalues[2]]
                                                                r77 = "\204\218\1469\149Ec"
                                                                r69 = 14701834787518
                                                                r28 = r40(r77, r69)
                                                                r19 = r58[r28]
                                                                r58 = "gmatch"
                                                                r58 = r61[r58]
                                                                r58 = {
                                                                    r58(r61, r19)
                                                                }
                                                                r16 = r58[1]
                                                                r22 = r58[3]
                                                                r31 = r58[2]
                                                                state = 99
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 96 then
                                                        if state <= 95 then
                                                            if state == 95 then
                                                                r37 = r14(r81, r36)
                                                                r36 = r37
                                                                r22 = nil
                                                                r31 = r36 == r22
                                                                state = r31 and (100) or (101)
                                                            end
                                                        else
                                                            if state == 96 then
                                                                r22 = #r16
                                                                r19 = 0
                                                                r31 = r22 > r19
                                                                state = r31 and (102) or (103)
                                                            end
                                                        end
                                                    else
                                                        if state <= 97 then
                                                            if state == 97 then
                                                                r16 = nil
                                                                state = 94
                                                            end
                                                        else
                                                            if state == 98 then
                                                                r22 = "tonumber"
                                                                r31 = _env[r22]
                                                                r22 = r31(r36)
                                                                r16 = r22
                                                                state = r16 and (104) or (105)
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 115 then
                                            if state <= 107 then
                                                if state <= 103 then
                                                    if state <= 101 then
                                                        if state <= 100 then
                                                            if state <= 99 then
                                                                if state == 99 then
                                                                    r19 = true
                                                                    state = r19 and (106) or (107)
                                                                end
                                                            else
                                                                if state == 100 then
                                                                    r31 = nil
                                                                    state = 96
                                                                end
                                                            end
                                                        else
                                                            if state == 101 then
                                                                r19 = "tonumber"
                                                                r22 = _env[r19]
                                                                r19 = r22(r36)
                                                                r31 = r19
                                                                r19 = state
                                                                state = r31 and (108) or (109)
                                                                r22 = r31
                                                            end
                                                        end
                                                    else
                                                        if state <= 102 then
                                                            if state == 102 then
                                                                r19 = upvalueValues[upvalues[1]]
                                                                r58 = upvalueValues[upvalues[2]]
                                                                r77 = 11926849902001
                                                                r28 = "\127\149\129\248T\184\159\168\157M6"
                                                                r40 = r58(r28, r77)
                                                                r22 = r19[r40]
                                                                r40 = "table"
                                                                r58 = _env[r40]
                                                                r28 = upvalueValues[upvalues[1]]
                                                                r77 = upvalueValues[upvalues[2]]
                                                                r10 = 27622674510398
                                                                r74 = "4\200X\128ux"
                                                                r69 = r77(r74, r10)
                                                                r40 = r28[r69]
                                                                r19 = r58[r40]
                                                                r58 = r19(r16)
                                                                r28 = upvalueValues[upvalues[1]]
                                                                r77 = upvalueValues[upvalues[2]]
                                                                r10 = 32346464844502
                                                                r74 = "!\131t\253w\175s\153G\247\149\227"
                                                                r69 = r77(r74, r10)
                                                                r40 = r28[r69]
                                                                r69 = upvalueValues[upvalues[1]]
                                                                r74 = upvalueValues[upvalues[2]]
                                                                r39 = "\156"
                                                                r15 = 18786903204396
                                                                r10 = r74(r39, r15)
                                                                r77 = r69[r10]
                                                                r28 = r9 .. r77
                                                                r19 = r40 .. r28
                                                                r77 = upvalueValues[upvalues[1]]
                                                                r69 = upvalueValues[upvalues[2]]
                                                                r39 = 27130091237721
                                                                r10 = "\229\022\182&\148"
                                                                r74 = r69(r10, r39)
                                                                r28 = r77[r74]
                                                                r77 = #r16
                                                                r40 = {
                                                                    [r28] = r77
                                                                }
                                                                r31 = r51(r22, r58, r19, r40)
                                                                state = 103
                                                            end
                                                        else
                                                            if state == 103 then
                                                                r81 = nil
                                                                r9 = nil
                                                                r36 = nil
                                                                r14 = nil
                                                                r16 = nil
                                                                state = 84
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 105 then
                                                        if state <= 104 then
                                                            if state == 104 then
                                                                r19 = upvalueValues[upvalues[1]]
                                                                r58 = upvalueValues[upvalues[2]]
                                                                r28 = "\179\220t"
                                                                r77 = 15286068452302
                                                                r40 = r58(r28, r77)
                                                                r22 = r19[r40]
                                                                r58 = "tostring"
                                                                r19 = _env[r58]
                                                                r58 = {
                                                                    r19(r16)
                                                                }
                                                                r31 = r51(r22, r36, unpack(r58))
                                                                state = 105
                                                            end
                                                        else
                                                            if state == 105 then
                                                                r16 = nil
                                                                state = 91
                                                            end
                                                        end
                                                    else
                                                        if state <= 106 then
                                                            if state == 106 then
                                                                r19 = r16(r31, r22)
                                                                r22 = r19
                                                                r40 = nil
                                                                r58 = r22 == r40
                                                                state = r58 and (110) or (111)
                                                            end
                                                        else
                                                            if state == 107 then
                                                                r69 = upvalueValues[upvalues[1]]
                                                                r74 = upvalueValues[upvalues[2]]
                                                                r15 = 27242198725005
                                                                r39 = "F\011\016\189m\196\155\160"
                                                                r10 = r74(r39, r15)
                                                                r77 = r69[r10]
                                                                r69 = "gmatch"
                                                                r69 = r61[r69]
                                                                r69 = {
                                                                    r69(r61, r77)
                                                                }
                                                                r58 = r69[1]
                                                                r28 = r69[3]
                                                                r40 = r69[2]
                                                                state = 112
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 111 then
                                                    if state <= 109 then
                                                        if state <= 108 then
                                                            if state == 108 then
                                                                r40 = state
                                                                r77 = 0
                                                                r28 = r77 <= r31
                                                                state = r28 and (113) or (114)
                                                                r58 = r28
                                                            end
                                                        else
                                                            if state == 109 then
                                                                state = r19
                                                                state = r22 and (115) or (116)
                                                            end
                                                        end
                                                    else
                                                        if state <= 110 then
                                                            if state == 110 then
                                                                r58 = nil
                                                                state = 107
                                                            end
                                                        else
                                                            if state == 111 then
                                                                r28 = "tonumber"
                                                                r40 = _env[r28]
                                                                r77 = "sub"
                                                                r77 = r22[r77]
                                                                r69 = 3
                                                                r77 = r77(r22, r69)
                                                                r69 = 2
                                                                r28 = r40(r77, r69)
                                                                r58 = r28
                                                                state = r58 and (117) or (118)
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 113 then
                                                        if state <= 112 then
                                                            if state == 112 then
                                                                r77 = true
                                                                state = r77 and (119) or (120)
                                                            end
                                                        else
                                                            if state == 113 then
                                                                r77 = 255
                                                                r28 = r31 <= r77
                                                                r58 = r28
                                                                state = 114
                                                            end
                                                        end
                                                    else
                                                        if state <= 114 then
                                                            if state == 114 then
                                                                state = r40
                                                                r22 = r58
                                                                state = 109
                                                            end
                                                        else
                                                            if state == 115 then
                                                                r19 = #r16
                                                                r58 = 1
                                                                r22 = r19 + r58
                                                                r40 = "string"
                                                                r58 = _env[r40]
                                                                r28 = upvalueValues[upvalues[1]]
                                                                r77 = upvalueValues[upvalues[2]]
                                                                r10 = 29471373669787
                                                                r74 = "WqT4"
                                                                r69 = r77(r74, r10)
                                                                r40 = r28[r69]
                                                                r19 = r58[r40]
                                                                r58 = r19(r31)
                                                                r16[r22] = r58
                                                                state = 116
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 124 then
                                                if state <= 120 then
                                                    if state <= 118 then
                                                        if state <= 117 then
                                                            if state <= 116 then
                                                                if state == 116 then
                                                                    r31 = nil
                                                                    state = 92
                                                                end
                                                            else
                                                                if state == 117 then
                                                                    r77 = upvalueValues[upvalues[1]]
                                                                    r69 = upvalueValues[upvalues[2]]
                                                                    r39 = 25142235803067
                                                                    r10 = "\208;>O\240\229"
                                                                    r74 = r69(r10, r39)
                                                                    r28 = r77[r74]
                                                                    r69 = "tostring"
                                                                    r77 = _env[r69]
                                                                    r69 = {
                                                                        r77(r58)
                                                                    }
                                                                    r40 = r51(r28, r22, unpack(r69))
                                                                    state = 118
                                                                end
                                                            end
                                                        else
                                                            if state == 118 then
                                                                r58 = nil
                                                                state = 99
                                                            end
                                                        end
                                                    else
                                                        if state <= 119 then
                                                            if state == 119 then
                                                                r77 = r58(r40, r28)
                                                                r28 = r77
                                                                r74 = nil
                                                                r69 = r28 == r74
                                                                state = r69 and (121) or (122)
                                                            end
                                                        else
                                                            if state == 120 then
                                                                r15 = upvalueValues[upvalues[1]]
                                                                r56 = upvalueValues[upvalues[2]]
                                                                r54 = "\232\179\015zg\164\016\001W\216\139\"?Zy\026.\247\171\026Orw\229V&"
                                                                r52 = 4523234887738
                                                                r13 = r56(r54, r52)
                                                                r39 = r15[r13]
                                                                r15 = "gmatch"
                                                                r15 = r61[r15]
                                                                r15 = {
                                                                    r15(r61, r39)
                                                                }
                                                                r69 = r15[1]
                                                                r10 = r15[3]
                                                                r74 = r15[2]
                                                                state = 123
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 122 then
                                                        if state <= 121 then
                                                            if state == 121 then
                                                                r69 = nil
                                                                state = 120
                                                            end
                                                        else
                                                            if state == 122 then
                                                                r10 = "tonumber"
                                                                r74 = _env[r10]
                                                                r39 = "sub"
                                                                r39 = r28[r39]
                                                                r15 = 3
                                                                r39 = r39(r28, r15)
                                                                r15 = 8
                                                                r10 = r74(r39, r15)
                                                                r69 = r10
                                                                state = r69 and (124) or (125)
                                                            end
                                                        end
                                                    else
                                                        if state <= 123 then
                                                            if state == 123 then
                                                                r39 = true
                                                                state = r39 and (126) or (127)
                                                            end
                                                        else
                                                            if state == 124 then
                                                                r39 = upvalueValues[upvalues[1]]
                                                                r15 = upvalueValues[upvalues[2]]
                                                                r13 = "\011\012:b\170"
                                                                r54 = 25821897010936
                                                                r56 = r15(r13, r54)
                                                                r10 = r39[r56]
                                                                r15 = "tostring"
                                                                r39 = _env[r15]
                                                                r15 = {
                                                                    r39(r69)
                                                                }
                                                                r74 = r51(r10, r28, unpack(r15))
                                                                state = 125
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 128 then
                                                    if state <= 126 then
                                                        if state <= 125 then
                                                            if state == 125 then
                                                                r69 = nil
                                                                state = 112
                                                            end
                                                        else
                                                            if state == 126 then
                                                                r39 = r69(r74, r10)
                                                                r10 = r39
                                                                r56 = nil
                                                                r15 = r10 == r56
                                                                state = r15 and (128) or (129)
                                                            end
                                                        end
                                                    else
                                                        if state <= 127 then
                                                            if state == 127 then
                                                                r52 = upvalueValues[upvalues[1]]
                                                                r43 = upvalueValues[upvalues[2]]
                                                                r82 = 18241318248750
                                                                r59 = "`\172\252a\018\235\149\t\141X\244\238\130\169"
                                                                r17 = r43(r59, r82)
                                                                r54 = r52[r17]
                                                                r52 = "gmatch"
                                                                r52 = r61[r52]
                                                                r52 = {
                                                                    r52(r61, r54)
                                                                }
                                                                r13 = r52[3]
                                                                r56 = r52[2]
                                                                r15 = r52[1]
                                                                state = 130
                                                            end
                                                        else
                                                            if state == 128 then
                                                                r15 = nil
                                                                state = 127
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 130 then
                                                        if state <= 129 then
                                                            if state == 129 then
                                                                r13 = "tonumber"
                                                                r56 = _env[r13]
                                                                r13 = r56(r10)
                                                                r15 = r13
                                                                state = r15 and (131) or (132)
                                                            end
                                                        else
                                                            if state == 130 then
                                                                r54 = true
                                                                state = r54 and (133) or (134)
                                                            end
                                                        end
                                                    else
                                                        if state <= 131 then
                                                            if state == 131 then
                                                                r54 = upvalueValues[upvalues[1]]
                                                                r52 = upvalueValues[upvalues[2]]
                                                                r59 = 23029879335396
                                                                r17 = "=|9\\N\023\152\179\217\236"
                                                                r43 = r52(r17, r59)
                                                                r13 = r54[r43]
                                                                r52 = "tostring"
                                                                r54 = _env[r52]
                                                                r52 = {
                                                                    r54(r15)
                                                                }
                                                                r56 = r51(r13, r10, unpack(r52))
                                                                state = 132
                                                            end
                                                        else
                                                            if state == 132 then
                                                                r15 = nil
                                                                state = 123
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    if state <= 166 then
                                        if state <= 149 then
                                            if state <= 141 then
                                                if state <= 137 then
                                                    if state <= 135 then
                                                        if state <= 134 then
                                                            if state <= 133 then
                                                                if state == 133 then
                                                                    r54 = r15(r56, r13)
                                                                    r13 = r54
                                                                    r43 = nil
                                                                    r52 = r13 == r43
                                                                    state = r52 and (135) or (136)
                                                                end
                                                            else
                                                                if state == 134 then
                                                                    r82 = upvalueValues[upvalues[1]]
                                                                    r71 = upvalueValues[upvalues[2]]
                                                                    r48 = 23797592157001
                                                                    r83 = "J\004\150\018H\030\255a\161\149zX\164=\147O\203\132]R\130hZ\211L_\204(\228`*\022\182\007\222.\141+\027\146t\017\n\139\218\158\247\241\"\153g\238).U\138\001"
                                                                    r64 = r71(r83, r48)
                                                                    r59 = r82[r64]
                                                                    r82 = "gmatch"
                                                                    r82 = r61[r82]
                                                                    r82 = {
                                                                        r82(r61, r59)
                                                                    }
                                                                    r17 = r82[3]
                                                                    r43 = r82[2]
                                                                    r52 = r82[1]
                                                                    state = 137
                                                                end
                                                            end
                                                        else
                                                            if state == 135 then
                                                                r52 = nil
                                                                state = 134
                                                            end
                                                        end
                                                    else
                                                        if state <= 136 then
                                                            if state == 136 then
                                                                r17 = "tonumber"
                                                                r43 = _env[r17]
                                                                r17 = r43(r13)
                                                                r52 = r17
                                                                r17 = state
                                                                state = r52 and (138) or (139)
                                                                r43 = r52
                                                            end
                                                        else
                                                            if state == 137 then
                                                                r59 = true
                                                                state = r59 and (140) or (141)
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 139 then
                                                        if state <= 138 then
                                                            if state == 138 then
                                                                r64 = "math"
                                                                r71 = _env[r64]
                                                                r83 = upvalueValues[upvalues[1]]
                                                                r48 = upvalueValues[upvalues[2]]
                                                                r80 = "g\127\029"
                                                                r65 = 17844902600821
                                                                r41 = r48(r80, r65)
                                                                r64 = r83[r41]
                                                                r82 = r71[r64]
                                                                r71 = r82(r52)
                                                                r82 = 1
                                                                r59 = r71 > r82
                                                                r43 = r59
                                                                state = 139
                                                            end
                                                        else
                                                            if state == 139 then
                                                                state = r17
                                                                state = r43 and (142) or (143)
                                                            end
                                                        end
                                                    else
                                                        if state <= 140 then
                                                            if state == 140 then
                                                                r59 = r52(r43, r17)
                                                                r17 = r59
                                                                r71 = nil
                                                                r82 = r17 == r71
                                                                state = r82 and (144) or (145)
                                                            end
                                                        else
                                                            if state == 141 then
                                                                r48 = upvalueValues[upvalues[1]]
                                                                r41 = upvalueValues[upvalues[2]]
                                                                r44 = 24613948550341
                                                                r65 = "\193\175r\018R\130\173\016\253\003"
                                                                r80 = r41(r65, r44)
                                                                r83 = r48[r80]
                                                                r48 = "gmatch"
                                                                r48 = r61[r48]
                                                                r48 = {
                                                                    r48(r61, r83)
                                                                }
                                                                r82 = r48[1]
                                                                r64 = r48[3]
                                                                r71 = r48[2]
                                                                state = 146
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 145 then
                                                    if state <= 143 then
                                                        if state <= 142 then
                                                            if state == 142 then
                                                                r59 = upvalueValues[upvalues[1]]
                                                                r82 = upvalueValues[upvalues[2]]
                                                                r64 = ".\211\201{\2266"
                                                                r83 = 28125617402665
                                                                r71 = r82(r64, r83)
                                                                r17 = r59[r71]
                                                                r82 = "tostring"
                                                                r59 = _env[r82]
                                                                r82 = {
                                                                    r59(r52)
                                                                }
                                                                r43 = r51(r17, r13, unpack(r82))
                                                                state = 143
                                                            end
                                                        else
                                                            if state == 143 then
                                                                r52 = nil
                                                                state = 130
                                                            end
                                                        end
                                                    else
                                                        if state <= 144 then
                                                            if state == 144 then
                                                                state = 141
                                                            end
                                                        else
                                                            if state == 145 then
                                                                r83 = #r17
                                                                r48 = 24
                                                                r64 = r83 > r48
                                                                r71 = state
                                                                state = r64 and (147) or (148)
                                                                r82 = r64
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 147 then
                                                        if state <= 146 then
                                                            if state == 146 then
                                                                r83 = true
                                                                state = r83 and (149) or (150)
                                                            end
                                                        else
                                                            if state == 147 then
                                                                r48 = #r17
                                                                r41 = 4
                                                                r83 = r48 % r41
                                                                r48 = 0
                                                                r64 = r83 == r48
                                                                r82 = r64
                                                                state = 148
                                                            end
                                                        end
                                                    else
                                                        if state <= 148 then
                                                            if state == 148 then
                                                                state = r71
                                                                state = r82 and (151) or (152)
                                                            end
                                                        else
                                                            if state == 149 then
                                                                r83 = r82(r71, r64)
                                                                r64 = r83
                                                                r41 = nil
                                                                r48 = r64 == r41
                                                                state = r48 and (153) or (154)
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 158 then
                                                if state <= 154 then
                                                    if state <= 152 then
                                                        if state <= 151 then
                                                            if state <= 150 then
                                                                if state == 150 then
                                                                    r44 = upvalueValues[upvalues[1]]
                                                                    r27 = upvalueValues[upvalues[2]]
                                                                    r45 = 273904910463
                                                                    r5 = "\150]\165Pai\008s\182\230\193\244\207\004\154\182\140\018\175\011\198\159\253e\255@"
                                                                    r12 = r27(r5, r45)
                                                                    r65 = r44[r12]
                                                                    r44 = "gmatch"
                                                                    r44 = r61[r44]
                                                                    r44 = {
                                                                        r44(r61, r65)
                                                                    }
                                                                    r41 = r44[2]
                                                                    r80 = r44[3]
                                                                    r48 = r44[1]
                                                                    state = 155
                                                                end
                                                            else
                                                                if state == 151 then
                                                                    r64 = upvalueValues[upvalues[1]]
                                                                    r83 = upvalueValues[upvalues[2]]
                                                                    r41 = "\227\224\216\128y\028\000Wj\143Y"
                                                                    r80 = 28553990222832
                                                                    r48 = r83(r41, r80)
                                                                    r71 = r64[r48]
                                                                    r48 = upvalueValues[upvalues[1]]
                                                                    r41 = upvalueValues[upvalues[2]]
                                                                    r44 = 13746614081793
                                                                    r65 = "\n\025\209"
                                                                    r80 = r41(r65, r44)
                                                                    r83 = r48[r80]
                                                                    r48 = #r17
                                                                    r64 = {
                                                                        [r83] = r48
                                                                    }
                                                                    r82 = r51(r71, r17, r17, r64)
                                                                    state = 152
                                                                end
                                                            end
                                                        else
                                                            if state == 152 then
                                                                state = 137
                                                            end
                                                        end
                                                    else
                                                        if state <= 153 then
                                                            if state == 153 then
                                                                r41 = nil
                                                                r44 = nil
                                                                r65 = nil
                                                                r48 = nil
                                                                r80 = nil
                                                                state = 150
                                                            end
                                                        else
                                                            if state == 154 then
                                                                r45 = upvalueValues[upvalues[1]]
                                                                r85 = upvalueValues[upvalues[2]]
                                                                r68 = 7704361520643
                                                                r50 = "\2400\152"
                                                                r63 = r85(r50, r68)
                                                                r5 = r45[r63]
                                                                r45 = "gmatch"
                                                                r45 = r64[r45]
                                                                r45 = {
                                                                    r45(r64, r5)
                                                                }
                                                                r27 = r45[2]
                                                                r42 = r45[1]
                                                                r12 = r45[3]
                                                                r48 = r42
                                                                r42 = {}
                                                                r80 = r12
                                                                r41 = r27
                                                                r65 = r64
                                                                r44 = r42
                                                                state = 156
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 156 then
                                                        if state <= 155 then
                                                            if state == 155 then
                                                                r65 = true
                                                                state = r65 and (157) or (158)
                                                            end
                                                        else
                                                            if state == 156 then
                                                                r42 = true
                                                                state = r42 and (159) or (160)
                                                            end
                                                        end
                                                    else
                                                        if state <= 157 then
                                                            if state == 157 then
                                                                r65 = r48(r41, r80)
                                                                r80 = r65
                                                                r27 = nil
                                                                r44 = r80 == r27
                                                                state = r44 and (161) or (162)
                                                            end
                                                        else
                                                            if state == 158 then
                                                                r45 = upvalueValues[upvalues[1]]
                                                                r85 = upvalueValues[upvalues[2]]
                                                                r50 = "ZR\164\162Z\210P\030\196u\011UFNiSEI/\240{\182\185\220\191\206o"
                                                                r68 = 4565897152590
                                                                r63 = r85(r50, r68)
                                                                r5 = r45[r63]
                                                                r45 = "gmatch"
                                                                r45 = r61[r45]
                                                                r45 = {
                                                                    r45(r61, r5)
                                                                }
                                                                r44 = r45[1]
                                                                r12 = r45[3]
                                                                r27 = r45[2]
                                                                state = 163
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 162 then
                                                    if state <= 160 then
                                                        if state <= 159 then
                                                            if state == 159 then
                                                                r42 = r48(r41, r80)
                                                                r80 = r42
                                                                r12 = nil
                                                                r27 = r80 == r12
                                                                state = r27 and (164) or (165)
                                                            end
                                                        else
                                                            if state == 160 then
                                                                r12 = #r44
                                                                r5 = 6
                                                                r27 = r12 >= r5
                                                                state = r27 and (166) or (167)
                                                            end
                                                        end
                                                    else
                                                        if state <= 161 then
                                                            if state == 161 then
                                                                state = 158
                                                            end
                                                        else
                                                            if state == 162 then
                                                                r12 = upvalueValues[upvalues[1]]
                                                                r5 = upvalueValues[upvalues[2]]
                                                                r85 = "Z\015^H\208\025\226\176\129\202\178*\129>"
                                                                r63 = 24459365477501
                                                                r45 = r5(r85, r63)
                                                                r27 = r12[r45]
                                                                r45 = upvalueValues[upvalues[1]]
                                                                r85 = upvalueValues[upvalues[2]]
                                                                r50 = "\159\190'\181\161\229\208|\135'X"
                                                                r68 = 25166221258182
                                                                r63 = r85(r50, r68)
                                                                r5 = r45[r63]
                                                                r63 = upvalueValues[upvalues[1]]
                                                                r50 = upvalueValues[upvalues[2]]
                                                                r70 = 18527450816947
                                                                r78 = "\172"
                                                                r68 = r50(r78, r70)
                                                                r85 = r63[r68]
                                                                r45 = r80 .. r85
                                                                r12 = r5 .. r45
                                                                r44 = r51(r27, r80, r12)
                                                                state = 155
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 164 then
                                                        if state <= 163 then
                                                            if state == 163 then
                                                                r5 = true
                                                                state = r5 and (168) or (169)
                                                            end
                                                        else
                                                            if state == 164 then
                                                                r27 = nil
                                                                state = 160
                                                            end
                                                        end
                                                    else
                                                        if state <= 165 then
                                                            if state == 165 then
                                                                r5 = "tonumber"
                                                                r12 = _env[r5]
                                                                r5 = r12(r80)
                                                                r27 = r5
                                                                r5 = state
                                                                state = r27 and (170) or (171)
                                                                r12 = r27
                                                            end
                                                        else
                                                            if state == 166 then
                                                                r5 = upvalueValues[upvalues[1]]
                                                                r45 = upvalueValues[upvalues[2]]
                                                                r63 = "\023\1860]\239\219y%\234\150\t\189y\138\127"
                                                                r50 = 28223049626454
                                                                r85 = r45(r63, r50)
                                                                r12 = r5[r85]
                                                                r85 = "table"
                                                                r45 = _env[r85]
                                                                r63 = upvalueValues[upvalues[1]]
                                                                r50 = upvalueValues[upvalues[2]]
                                                                r78 = "\015\213\139\026Iy"
                                                                r70 = 21355612546776
                                                                r68 = r50(r78, r70)
                                                                r85 = r63[r68]
                                                                r5 = r45[r85]
                                                                r45 = r5(r44)
                                                                r63 = upvalueValues[upvalues[1]]
                                                                r50 = upvalueValues[upvalues[2]]
                                                                r78 = "^\246[\129\012"
                                                                r70 = 1664746849031
                                                                r68 = r50(r78, r70)
                                                                r85 = r63[r68]
                                                                r63 = #r44
                                                                r5 = {
                                                                    [r85] = r63
                                                                }
                                                                r27 = r51(r12, r45, r65, r5)
                                                                state = 167
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 183 then
                                            if state <= 175 then
                                                if state <= 171 then
                                                    if state <= 169 then
                                                        if state <= 168 then
                                                            if state <= 167 then
                                                                if state == 167 then
                                                                    r41 = nil
                                                                    r80 = nil
                                                                    r44 = nil
                                                                    r65 = nil
                                                                    r48 = nil
                                                                    state = 146
                                                                end
                                                            else
                                                                if state == 168 then
                                                                    r5 = r44(r27, r12)
                                                                    r12 = r5
                                                                    r85 = nil
                                                                    r45 = r12 == r85
                                                                    state = r45 and (172) or (173)
                                                                end
                                                            end
                                                        else
                                                            if state == 169 then
                                                                r68 = upvalueValues[upvalues[1]]
                                                                r70 = upvalueValues[upvalues[2]]
                                                                r38 = "Q\185\173\183\213\252\182\139\t\198!\004n\2208t+\215\178"
                                                                r3 = 29342900286815
                                                                r84 = r70(r38, r3)
                                                                r50 = r68[r84]
                                                                r68 = "gmatch"
                                                                r68 = r61[r68]
                                                                r68 = {
                                                                    r68(r61, r50)
                                                                }
                                                                r45 = r68[1]
                                                                r63 = r68[3]
                                                                r85 = r68[2]
                                                                state = 174
                                                            end
                                                        end
                                                    else
                                                        if state <= 170 then
                                                            if state == 170 then
                                                                r50 = 0
                                                                r63 = r50 <= r27
                                                                r85 = state
                                                                state = r63 and (175) or (176)
                                                                r45 = r63
                                                            end
                                                        else
                                                            if state == 171 then
                                                                state = r5
                                                                state = r12 and (177) or (178)
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 173 then
                                                        if state <= 172 then
                                                            if state == 172 then
                                                                r45 = nil
                                                                r50 = nil
                                                                r63 = nil
                                                                r68 = nil
                                                                r85 = nil
                                                                state = 169
                                                            end
                                                        else
                                                            if state == 173 then
                                                                r3 = upvalueValues[upvalues[1]]
                                                                r23 = upvalueValues[upvalues[2]]
                                                                r57 = 19453222822754
                                                                r1 = "\160\151\129"
                                                                r2 = r23(r1, r57)
                                                                r38 = r3[r2]
                                                                r3 = "gmatch"
                                                                r3 = r12[r3]
                                                                r3 = {
                                                                    r3(r12, r38)
                                                                }
                                                                r70 = r3[2]
                                                                r78 = r3[1]
                                                                r84 = r3[3]
                                                                r45 = r78
                                                                r78 = {}
                                                                r50 = r12
                                                                r85 = r70
                                                                r63 = r84
                                                                r68 = r78
                                                                state = 179
                                                            end
                                                        end
                                                    else
                                                        if state <= 174 then
                                                            if state == 174 then
                                                                r50 = true
                                                                state = r50 and (180) or (181)
                                                            end
                                                        else
                                                            if state == 175 then
                                                                r50 = 255
                                                                r63 = r27 <= r50
                                                                r45 = r63
                                                                state = 176
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 179 then
                                                    if state <= 177 then
                                                        if state <= 176 then
                                                            if state == 176 then
                                                                state = r85
                                                                r12 = r45
                                                                state = 171
                                                            end
                                                        else
                                                            if state == 177 then
                                                                r5 = #r44
                                                                r45 = 1
                                                                r12 = r5 + r45
                                                                r85 = "string"
                                                                r45 = _env[r85]
                                                                r63 = upvalueValues[upvalues[1]]
                                                                r50 = upvalueValues[upvalues[2]]
                                                                r70 = 31514553956691
                                                                r78 = "\t.\137~"
                                                                r68 = r50(r78, r70)
                                                                r85 = r63[r68]
                                                                r5 = r45[r85]
                                                                r45 = r5(r27)
                                                                r44[r12] = r45
                                                                state = 178
                                                            end
                                                        end
                                                    else
                                                        if state <= 178 then
                                                            if state == 178 then
                                                                r27 = nil
                                                                state = 156
                                                            end
                                                        else
                                                            if state == 179 then
                                                                r78 = true
                                                                state = r78 and (182) or (183)
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 181 then
                                                        if state <= 180 then
                                                            if state == 180 then
                                                                r50 = r45(r85, r63)
                                                                r63 = r50
                                                                r70 = nil
                                                                r68 = r63 == r70
                                                                state = r68 and (184) or (185)
                                                            end
                                                        else
                                                            if state == 181 then
                                                                r84 = "table"
                                                                r70 = _env[r84]
                                                                r38 = upvalueValues[upvalues[1]]
                                                                r3 = upvalueValues[upvalues[2]]
                                                                r2 = "\198x\179="
                                                                r1 = 29473650488732
                                                                r23 = r3(r2, r1)
                                                                r84 = r38[r23]
                                                                r68 = r70[r84]
                                                                r84 = createClosure5(284, {
                                                                    upvalues[1],
                                                                    upvalues[2]
                                                                })
                                                                r70 = r68(r66, r84)
                                                                r3 = "v95"
                                                                r38 = _env[r3]
                                                                r84 = #r38
                                                                r38 = 1
                                                                r70 = r84 + r38
                                                                r38 = upvalueValues[upvalues[1]]
                                                                r3 = upvalueValues[upvalues[2]]
                                                                r2 = "!c\179\208%P\239K|\029)\006\169*t\157K'\152\191\253\242\018\002\006|\001\231\223\252T\176\179\185&d\234\177\218\t_\1799\253\203\172"
                                                                r1 = 15908830026992
                                                                r23 = r3(r2, r1)
                                                                r84 = r38[r23]
                                                                r2 = "v95"
                                                                r23 = _env[r2]
                                                                r3 = #r23
                                                                r23 = 1
                                                                r38 = r3 + r23
                                                                r2 = upvalueValues[upvalues[1]]
                                                                r1 = upvalueValues[upvalues[2]]
                                                                r72 = "\135d=\239\251\181\222D\231\140\031\229t\172J$2D?r\027\200\239D"
                                                                r33 = 15934093532411
                                                                r57 = r1(r72, r33)
                                                                r23 = r2[r57]
                                                                r2 = #r66
                                                                r3 = r23 .. r2
                                                                r57 = "v95"
                                                                r1 = _env[r57]
                                                                r2 = #r1
                                                                r1 = 1
                                                                r23 = r2 + r1
                                                                r1 = upvalueValues[upvalues[1]]
                                                                r57 = upvalueValues[upvalues[2]]
                                                                r33 = ""
                                                                r6 = 25757765250778
                                                                r72 = r57(r33, r6)
                                                                r2 = r1[r72]
                                                                r68 = {
                                                                    [r70] = r84,
                                                                    [r38] = r3,
                                                                    [r23] = r2
                                                                }
                                                                r84 = "ipairs"
                                                                r70 = _env[r84]
                                                                r23 = {
                                                                    r70(r66)
                                                                }
                                                                r38 = r23[2]
                                                                r84 = r23[1]
                                                                r3 = r23[3]
                                                                state = 186
                                                            end
                                                        end
                                                    else
                                                        if state <= 182 then
                                                            if state == 182 then
                                                                r78 = r45(r85, r63)
                                                                r63 = r78
                                                                r84 = nil
                                                                r70 = r63 == r84
                                                                state = r70 and (187) or (188)
                                                            end
                                                        else
                                                            if state == 183 then
                                                                r84 = #r68
                                                                r38 = 8
                                                                r70 = r84 > r38
                                                                state = r70 and (189) or (190)
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 192 then
                                                if state <= 188 then
                                                    if state <= 186 then
                                                        if state <= 185 then
                                                            if state <= 184 then
                                                                if state == 184 then
                                                                    state = 181
                                                                end
                                                            else
                                                                if state == 185 then
                                                                    r84 = upvalueValues[upvalues[1]]
                                                                    r38 = upvalueValues[upvalues[2]]
                                                                    r2 = 3651753477796
                                                                    r23 = "\t\133i\n,\008(\191\015\148\231\243\017\185\178\157\193"
                                                                    r3 = r38(r23, r2)
                                                                    r70 = r84[r3]
                                                                    r3 = upvalueValues[upvalues[1]]
                                                                    r23 = upvalueValues[upvalues[2]]
                                                                    r1 = "\020\243\030\194\001=\000\021M"
                                                                    r57 = 171074404431
                                                                    r2 = r23(r1, r57)
                                                                    r38 = r3[r2]
                                                                    r2 = upvalueValues[upvalues[1]]
                                                                    r1 = upvalueValues[upvalues[2]]
                                                                    r72 = "f"
                                                                    r33 = 21400726906605
                                                                    r57 = r1(r72, r33)
                                                                    r23 = r2[r57]
                                                                    r3 = r63 .. r23
                                                                    r84 = r38 .. r3
                                                                    r68 = r51(r70, r63, r84)
                                                                    state = 174
                                                                end
                                                            end
                                                        else
                                                            if state == 186 then
                                                                r70 = true
                                                                state = r70 and (191) or (192)
                                                            end
                                                        end
                                                    else
                                                        if state <= 187 then
                                                            if state == 187 then
                                                                r70 = nil
                                                                state = 183
                                                            end
                                                        else
                                                            if state == 188 then
                                                                r38 = "tonumber"
                                                                r84 = _env[r38]
                                                                r38 = r84(r63)
                                                                r70 = r38
                                                                r38 = state
                                                                state = r70 and (193) or (194)
                                                                r84 = r70
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 190 then
                                                        if state <= 189 then
                                                            if state == 189 then
                                                                r38 = upvalueValues[upvalues[1]]
                                                                r3 = upvalueValues[upvalues[2]]
                                                                r2 = "\008`\235\167\183\213\127C71\027?\188"
                                                                r1 = 32188571662988
                                                                r23 = r3(r2, r1)
                                                                r84 = r38[r23]
                                                                r23 = "table"
                                                                r3 = _env[r23]
                                                                r2 = upvalueValues[upvalues[1]]
                                                                r1 = upvalueValues[upvalues[2]]
                                                                r33 = 16615315562041
                                                                r72 = "\134\208p\016b\""
                                                                r57 = r1(r72, r33)
                                                                r23 = r2[r57]
                                                                r38 = r3[r23]
                                                                r3 = r38(r68)
                                                                r2 = upvalueValues[upvalues[1]]
                                                                r1 = upvalueValues[upvalues[2]]
                                                                r72 = "\211"
                                                                r33 = 14056831834513
                                                                r57 = r1(r72, r33)
                                                                r23 = r2[r57]
                                                                r57 = upvalueValues[upvalues[1]]
                                                                r72 = upvalueValues[upvalues[2]]
                                                                r6 = "\248"
                                                                r32 = 24134290795494
                                                                r33 = r72(r6, r32)
                                                                r1 = r57[r33]
                                                                r2 = r50 .. r1
                                                                r38 = r23 .. r2
                                                                r1 = upvalueValues[upvalues[1]]
                                                                r57 = upvalueValues[upvalues[2]]
                                                                r6 = 10213210706579
                                                                r33 = ".\015\246\255k"
                                                                r72 = r57(r33, r6)
                                                                r2 = r1[r72]
                                                                r1 = #r68
                                                                r23 = {
                                                                    [r2] = r1
                                                                }
                                                                r70 = r51(r84, r3, r38, r23)
                                                                state = 190
                                                            end
                                                        else
                                                            if state == 190 then
                                                                r63 = nil
                                                                r68 = nil
                                                                r45 = nil
                                                                r85 = nil
                                                                r50 = nil
                                                                state = 163
                                                            end
                                                        end
                                                    else
                                                        if state <= 191 then
                                                            if state == 191 then
                                                                r1 = {
                                                                    r84(r38, r3)
                                                                }
                                                                r23 = r1[1]
                                                                r3 = r23
                                                                r2 = r1[2]
                                                                r57 = nil
                                                                r1 = r3 == r57
                                                                state = r1 and (195) or (196)
                                                                r70 = nil
                                                                r70 = r2
                                                            end
                                                        else
                                                            if state == 192 then
                                                                r1 = #r68
                                                                r57 = 1
                                                                r70 = r1 + r57
                                                                r57 = upvalueValues[upvalues[1]]
                                                                r72 = upvalueValues[upvalues[2]]
                                                                r6 = "\231\219k\241;\254\017\172\228[\211\195\145\187/;\027\r~\004sP\136&\018uEz#E\193)\"\180\170o\180%\025\142f:"
                                                                r32 = 19070347682480
                                                                r33 = r72(r6, r32)
                                                                r1 = r57[r33]
                                                                r68[r70] = r1
                                                                r57 = "table"
                                                                r1 = _env[r57]
                                                                r72 = upvalueValues[upvalues[1]]
                                                                r33 = upvalueValues[upvalues[2]]
                                                                r32 = "f\028lO\229\015"
                                                                r73 = 34243797466698
                                                                r6 = r33(r32, r73)
                                                                r57 = r72[r6]
                                                                r70 = r1[r57]
                                                                r72 = upvalueValues[upvalues[1]]
                                                                r33 = upvalueValues[upvalues[2]]
                                                                r73 = 3910871402269
                                                                r32 = "!"
                                                                r6 = r33(r32, r73)
                                                                r57 = r72[r6]
                                                                r1 = {
                                                                    r70(r68, r57)
                                                                }
                                                                ReturnVal = {
                                                                    unpack(r1)
                                                                }
                                                                state = nil
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 196 then
                                                    if state <= 194 then
                                                        if state <= 193 then
                                                            if state == 193 then
                                                                r23 = state
                                                                r1 = 0
                                                                r2 = r1 <= r70
                                                                state = r2 and (197) or (198)
                                                                r3 = r2
                                                            end
                                                        else
                                                            if state == 194 then
                                                                state = r38
                                                                state = r84 and (199) or (200)
                                                            end
                                                        end
                                                    else
                                                        if state <= 195 then
                                                            if state == 195 then
                                                                r70 = nil
                                                                state = 192
                                                            end
                                                        else
                                                            if state == 196 then
                                                                r57 = #r68
                                                                r72 = 1
                                                                r1 = r57 + r72
                                                                r33 = "string"
                                                                r72 = _env[r33]
                                                                r6 = upvalueValues[upvalues[1]]
                                                                r32 = upvalueValues[upvalues[2]]
                                                                r35 = "\195\213I\135\168\029"
                                                                r86 = 23613191547635
                                                                r73 = r32(r35, r86)
                                                                r33 = r6[r73]
                                                                r57 = r72[r33]
                                                                r6 = upvalueValues[upvalues[1]]
                                                                r32 = upvalueValues[upvalues[2]]
                                                                r35 = "\211\177\199\216\231WDp\208}Ug\025\183M\177\198&\1633\166\175\247\027 "
                                                                r86 = 12264275383886
                                                                r73 = r32(r35, r86)
                                                                r33 = r6[r73]
                                                                r73 = upvalueValues[upvalues[1]]
                                                                r35 = upvalueValues[upvalues[2]]
                                                                r67 = 18796442772016
                                                                r60 = "3"
                                                                r86 = r35(r60, r67)
                                                                r32 = r73[r86]
                                                                r6 = r70[r32]
                                                                r32 = "upper"
                                                                r32 = r6[r32]
                                                                r32 = r32(r6)
                                                                r73 = "tostring"
                                                                r6 = _env[r73]
                                                                r60 = upvalueValues[upvalues[1]]
                                                                r67 = upvalueValues[upvalues[2]]
                                                                r4 = "u"
                                                                r47 = 9784431989196
                                                                r46 = r67(r4, r47)
                                                                r86 = r60[r46]
                                                                r35 = r70[r86]
                                                                r73 = r6(r35)
                                                                r35 = "tostring"
                                                                r6 = _env[r35]
                                                                r67 = upvalueValues[upvalues[1]]
                                                                r46 = upvalueValues[upvalues[2]]
                                                                r49 = 13929022249302
                                                                r47 = "\016"
                                                                r4 = r46(r47, r49)
                                                                r60 = r67[r4]
                                                                r86 = r70[r60]
                                                                r35 = {
                                                                    r6(r86)
                                                                }
                                                                r70 = nil
                                                                r72 = r57(r33, r3, r32, r73, unpack(r35))
                                                                r68[r1] = r72
                                                                state = 186
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 198 then
                                                        if state <= 197 then
                                                            if state == 197 then
                                                                r1 = 255
                                                                r2 = r70 <= r1
                                                                r3 = r2
                                                                state = 198
                                                            end
                                                        else
                                                            if state == 198 then
                                                                state = r23
                                                                r84 = r3
                                                                state = 194
                                                            end
                                                        end
                                                    else
                                                        if state <= 199 then
                                                            if state == 199 then
                                                                r38 = #r68
                                                                r3 = 1
                                                                r84 = r38 + r3
                                                                r23 = "string"
                                                                r3 = _env[r23]
                                                                r2 = upvalueValues[upvalues[1]]
                                                                r1 = upvalueValues[upvalues[2]]
                                                                r72 = "SN\236\243"
                                                                r33 = 30454300735333
                                                                r57 = r1(r72, r33)
                                                                r23 = r2[r57]
                                                                r38 = r3[r23]
                                                                r3 = r38(r70)
                                                                r68[r84] = r3
                                                                state = 200
                                                            end
                                                        else
                                                            if state == 200 then
                                                                r70 = nil
                                                                state = 179
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure4 entry 8212260 -> 201, states 201-204
                                if state <= 202 then
                                    if state <= 201 then
                                        if state == 201 then -- entry 8212260 -> 201
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            state = not ReturnVal
                                            upvalueValues[upvalues[1]] = state
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            state = ReturnVal and (202) or (203)
                                        end
                                    else
                                        if state == 202 then
                                            ReturnVal = upvalueValues[upvalues[2]]
                                            r79 = upvalueValues[upvalues[3]]
                                            r21 = upvalueValues[upvalues[4]]
                                            r20 = 3625322530456
                                            r61 = "\016IN\250|}\232e\146\149"
                                            r51 = r21(r61, r20)
                                            r18 = r79[r51]
                                            r51 = "Color3"
                                            r21 = _env[r51]
                                            r61 = upvalueValues[upvalues[3]]
                                            r20 = upvalueValues[upvalues[4]]
                                            r24 = "\242\253c\158QZn"
                                            r66 = 23364094225023
                                            r7 = r20(r24, r66)
                                            r51 = r61[r7]
                                            r79 = r21[r51]
                                            r20 = 0
                                            r61 = 200
                                            r51 = 0
                                            r21 = r79(r51, r61, r20)
                                            ReturnVal[r18] = r21
                                            ReturnVal = upvalueValues[upvalues[5]]
                                            r79 = upvalueValues[upvalues[3]]
                                            r21 = upvalueValues[upvalues[4]]
                                            r61 = "\198z\139\137\253~5\011q\167G\186K\160\029\145"
                                            r20 = 32867727145929
                                            r51 = r21(r61, r20)
                                            r18 = r79[r51]
                                            r51 = "Color3"
                                            r21 = _env[r51]
                                            r61 = upvalueValues[upvalues[3]]
                                            r20 = upvalueValues[upvalues[4]]
                                            r24 = "J\1608\015\192\172p"
                                            r66 = 629522088229
                                            r7 = r20(r24, r66)
                                            r51 = r61[r7]
                                            r79 = r21[r51]
                                            r20 = 60
                                            r51 = 50
                                            r61 = 120
                                            r21 = r79(r51, r61, r20)
                                            ReturnVal[r18] = r21
                                            state = 204
                                        end
                                    end
                                else
                                    if state <= 203 then
                                        if state == 203 then
                                            ReturnVal = upvalueValues[upvalues[2]]
                                            r79 = upvalueValues[upvalues[3]]
                                            r21 = upvalueValues[upvalues[4]]
                                            r61 = "\027\151u`\217\220\021\218\133\031"
                                            r20 = 4795037681848
                                            r51 = r21(r61, r20)
                                            r18 = r79[r51]
                                            r51 = "Color3"
                                            r21 = _env[r51]
                                            r61 = upvalueValues[upvalues[3]]
                                            r20 = upvalueValues[upvalues[4]]
                                            r66 = 11740186875226
                                            r24 = "\188\128\243\2106\149M"
                                            r7 = r20(r24, r66)
                                            r51 = r61[r7]
                                            r79 = r21[r51]
                                            r51 = 0
                                            r20 = 0
                                            r61 = 0
                                            r21 = r79(r51, r61, r20)
                                            ReturnVal[r18] = r21
                                            ReturnVal = upvalueValues[upvalues[5]]
                                            r79 = upvalueValues[upvalues[3]]
                                            r21 = upvalueValues[upvalues[4]]
                                            r20 = 24763812900107
                                            r61 = "\021\252\003\2025\162U\198\247\t\132\2089\222\229F"
                                            r51 = r21(r61, r20)
                                            r18 = r79[r51]
                                            r51 = "Color3"
                                            r21 = _env[r51]
                                            r61 = upvalueValues[upvalues[3]]
                                            r20 = upvalueValues[upvalues[4]]
                                            r66 = 15008248388428
                                            r24 = "\1813>\n\217\148\030"
                                            r7 = r20(r24, r66)
                                            r51 = r61[r7]
                                            r79 = r21[r51]
                                            r51 = 80
                                            r20 = 90
                                            r61 = 80
                                            r21 = r79(r51, r61, r20)
                                            ReturnVal[r18] = r21
                                            state = 204
                                        end
                                    else
                                        if state == 204 then
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 287 then
                        if state <= 283 then
                            if state <= 280 then
                                if state <= 279 then
                                    -- createClosure4 entry 7728216 -> 205, states 205-279
                                    if state <= 242 then
                                        if state <= 223 then
                                            if state <= 214 then
                                                if state <= 209 then
                                                    if state <= 207 then
                                                        if state <= 206 then
                                                            if state <= 205 then
                                                                if state == 205 then -- entry 7728216 -> 205
                                                                    r79 = upvalueValues[upvalues[1]]
                                                                    r51 = upvalueValues[upvalues[2]]
                                                                    r61 = upvalueValues[upvalues[3]]
                                                                    r24 = 28415566377904
                                                                    r7 = "\227\211t\251"
                                                                    r20 = r61(r7, r24)
                                                                    r21 = r51[r20]
                                                                    r18 = r79[r21]
                                                                    state = r18 and (206) or (207)
                                                                    ReturnVal = r18
                                                                end
                                                            else
                                                                if state == 206 then
                                                                    r18 = allocUpvalue()
                                                                    upvalueValues[r18] = ReturnVal
                                                                    state = upvalueValues[upvalues[4]]
                                                                    state = state and (208) or (209)
                                                                end
                                                            end
                                                        else
                                                            if state == 207 then
                                                                r79 = upvalueValues[upvalues[2]]
                                                                r21 = upvalueValues[upvalues[3]]
                                                                r61 = ""
                                                                r20 = 15179322792860
                                                                r51 = r21(r61, r20)
                                                                r18 = r79[r51]
                                                                ReturnVal = r18
                                                                state = 206
                                                            end
                                                        end
                                                    else
                                                        if state <= 208 then
                                                            if state == 208 then
                                                                ReturnVal = "tostring"
                                                                state = _env[ReturnVal]
                                                                r21 = state
                                                                r61 = upvalueValues[upvalues[5]]
                                                                r7 = upvalueValues[upvalues[2]]
                                                                r24 = upvalueValues[upvalues[3]]
                                                                r8 = 27299441979816
                                                                r25 = "\147W.\191"
                                                                r66 = r24(r25, r8)
                                                                r20 = r7[r66]
                                                                r51 = r61[r20]
                                                                state = r51 and (210) or (211)
                                                                r79 = r51
                                                            end
                                                        else
                                                            if state == 209 then
                                                                r51 = upvalueValues[r18]
                                                                r21 = #r51
                                                                r51 = 4
                                                                r79 = r21 >= r51
                                                                state = r79 and (212) or (213)
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 212 then
                                                        if state <= 211 then
                                                            if state <= 210 then
                                                                if state == 210 then
                                                                    state = r21
                                                                    ReturnVal = state(r79)
                                                                    r79 = allocUpvalue()
                                                                    upvalueValues[r79] = ReturnVal
                                                                    ReturnVal = upvalueValues[r79]
                                                                    r51 = upvalueValues[upvalues[2]]
                                                                    r61 = upvalueValues[upvalues[3]]
                                                                    r24 = 19873632085030
                                                                    r7 = ""
                                                                    r20 = r61(r7, r24)
                                                                    r21 = r51[r20]
                                                                    state = ReturnVal == r21
                                                                    state = state and (214) or (215)
                                                                end
                                                            else
                                                                if state == 211 then
                                                                    r61 = upvalueValues[upvalues[2]]
                                                                    r20 = upvalueValues[upvalues[3]]
                                                                    r24 = ""
                                                                    r66 = 22704844777804
                                                                    r7 = r20(r24, r66)
                                                                    r51 = r61[r7]
                                                                    r79 = r51
                                                                    state = 210
                                                                end
                                                            end
                                                        else
                                                            if state == 212 then
                                                                r79 = upvalueValues[upvalues[6]]
                                                                r51 = upvalueValues[upvalues[2]]
                                                                r61 = upvalueValues[upvalues[3]]
                                                                r29 = 24664823360733
                                                                r25 = "o\245]\007"
                                                                r24 = r61(r25, r29)
                                                                r21 = r51[r24]
                                                                r61 = upvalueValues[upvalues[2]]
                                                                r24 = upvalueValues[upvalues[3]]
                                                                r29 = "\189\155DC\145\233\231FI\210\017\241u~\194\208\228\143\154\219m\167R\217\252\252\012\172\2375"
                                                                r55 = 7377433742699
                                                                r25 = r24(r29, r55)
                                                                r51 = r61[r25]
                                                                r79[r21] = r51
                                                                r21 = "pcall"
                                                                r79 = _env[r21]
                                                                r61 = createClosure4(287, {
                                                                    upvalues[7],
                                                                    r18
                                                                })
                                                                r24 = {
                                                                    r79(r61)
                                                                }
                                                                r21 = r24[1]
                                                                r51 = r24[2]
                                                                r79 = allocUpvalue()
                                                                upvalueValues[r79] = r51
                                                                r61 = state
                                                                state = r21 and (216) or (217)
                                                                r51 = r21
                                                            end
                                                        end
                                                    else
                                                        if state <= 213 then
                                                            if state == 213 then
                                                                r79 = upvalueValues[upvalues[6]]
                                                                r51 = upvalueValues[upvalues[2]]
                                                                r61 = upvalueValues[upvalues[3]]
                                                                ReturnVal = {}
                                                                r29 = 24428877147247
                                                                r25 = "\149\244\253*"
                                                                r24 = r61(r25, r29)
                                                                r21 = r51[r24]
                                                                r61 = upvalueValues[upvalues[2]]
                                                                r24 = upvalueValues[upvalues[3]]
                                                                r55 = 17549696098284
                                                                r29 = "\133\n\182$\169\030\243\161\140\012\003?\188\204\132b$\235l9\178\1711\241\020=\163\189\174"
                                                                r25 = r24(r29, r55)
                                                                r51 = r61[r25]
                                                                r79[r21] = r51
                                                                state = nil
                                                            end
                                                        else
                                                            if state == 214 then
                                                                state = upvalueValues[upvalues[6]]
                                                                r21 = upvalueValues[upvalues[2]]
                                                                r51 = upvalueValues[upvalues[3]]
                                                                r7 = 1361304027769
                                                                r20 = "\253\154\174\194"
                                                                r61 = r51(r20, r7)
                                                                ReturnVal = r21[r61]
                                                                r51 = upvalueValues[upvalues[2]]
                                                                r61 = upvalueValues[upvalues[3]]
                                                                r24 = 51069321239
                                                                r7 = "\141\022\014\234\006#,L\\7\026\011N\167\195\254%\169\170\r\001\148D|a\230\212\198I\238"
                                                                r20 = r61(r7, r24)
                                                                r21 = r51[r20]
                                                                state[ReturnVal] = r21
                                                                ReturnVal = {}
                                                                state = nil
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 219 then
                                                    if state <= 217 then
                                                        if state <= 216 then
                                                            if state <= 215 then
                                                                if state == 215 then
                                                                    state = upvalueValues[upvalues[6]]
                                                                    r21 = upvalueValues[upvalues[2]]
                                                                    r51 = upvalueValues[upvalues[3]]
                                                                    r20 = "b![n"
                                                                    r7 = 7228471889190
                                                                    r61 = r51(r20, r7)
                                                                    ReturnVal = r21[r61]
                                                                    r51 = upvalueValues[upvalues[2]]
                                                                    r61 = upvalueValues[upvalues[3]]
                                                                    r24 = 3548783478388
                                                                    r7 = "\018\137\150X\219\245\237\19473\147\023\198\163 \135H\214\216j\162u\215:\249\015\158\156\180\2175|\176\227\147K"
                                                                    r20 = r61(r7, r24)
                                                                    r61 = createClosure3(288, {
                                                                        upvalues[2],
                                                                        upvalues[3],
                                                                        r79
                                                                    })
                                                                    r21 = r51[r20]
                                                                    state[ReturnVal] = r21
                                                                    state = nil
                                                                    r21 = state
                                                                    ReturnVal = "pcall"
                                                                    state = _env[ReturnVal]
                                                                    r20 = {
                                                                        state(r61)
                                                                    }
                                                                    ReturnVal = r20[1]
                                                                    r61 = ReturnVal
                                                                    r51 = r20[2]
                                                                    r20 = not r61
                                                                    state = r20 and (218) or (219)
                                                                    ReturnVal = r20
                                                                end
                                                            else
                                                                if state == 216 then
                                                                    r24 = upvalueValues[r79]
                                                                    r51 = r24
                                                                    state = 217
                                                                end
                                                            end
                                                        else
                                                            if state == 217 then
                                                                state = r61
                                                                state = r51 and (220) or (221)
                                                            end
                                                        end
                                                    else
                                                        if state <= 218 then
                                                            if state == 218 then
                                                                state = ReturnVal and (222) or (223)
                                                            end
                                                        else
                                                            if state == 219 then
                                                                r25 = "type"
                                                                r66 = _env[r25]
                                                                r25 = r66(r51)
                                                                r8 = upvalueValues[upvalues[2]]
                                                                r26 = upvalueValues[upvalues[3]]
                                                                r55 = "E\163\150B\205\007"
                                                                r75 = 19482877010800
                                                                r29 = r26(r55, r75)
                                                                r66 = r8[r29]
                                                                r24 = r25 ~= r66
                                                                r7 = state
                                                                state = r24 and (224) or (225)
                                                                r20 = r24
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 221 then
                                                        if state <= 220 then
                                                            if state == 220 then
                                                                r61 = state
                                                                r75 = upvalueValues[upvalues[8]]
                                                                r53 = upvalueValues[upvalues[2]]
                                                                r76 = upvalueValues[upvalues[3]]
                                                                r62 = "s\196\222\209"
                                                                r11 = 6287665859439
                                                                r34 = r76(r62, r11)
                                                                r30 = r53[r34]
                                                                r55 = r75[r30]
                                                                r30 = upvalueValues[upvalues[2]]
                                                                r53 = upvalueValues[upvalues[3]]
                                                                r34 = ""
                                                                r62 = 14244264155625
                                                                r76 = r53(r34, r62)
                                                                r75 = r30[r76]
                                                                r29 = r55 ~= r75
                                                                r25 = state
                                                                state = r29 and (226) or (227)
                                                                r24 = r29
                                                            end
                                                        else
                                                            if state == 221 then
                                                                r51 = upvalueValues[upvalues[6]]
                                                                r24 = upvalueValues[upvalues[2]]
                                                                r25 = upvalueValues[upvalues[3]]
                                                                r55 = "\234\155P\201"
                                                                r75 = 14967300021049
                                                                r29 = r25(r55, r75)
                                                                r61 = r24[r29]
                                                                r25 = upvalueValues[upvalues[2]]
                                                                r29 = upvalueValues[upvalues[3]]
                                                                r30 = 25074081148316
                                                                r75 = "|\145\171\185\235l\015x\"%\201!@\169\026^J\030%\000\184\133\140\233"
                                                                r55 = r29(r75, r30)
                                                                r24 = r25[r55]
                                                                r51[r61] = r24
                                                                state = 228
                                                            end
                                                        end
                                                    else
                                                        if state <= 222 then
                                                            if state == 222 then
                                                                r20 = "type"
                                                                ReturnVal = _env[r20]
                                                                r24 = "loadfile"
                                                                r7 = _env[r24]
                                                                r20 = ReturnVal(r7)
                                                                r7 = upvalueValues[upvalues[2]]
                                                                r24 = upvalueValues[upvalues[3]]
                                                                r25 = "e\029\022I\1835\253\177"
                                                                r8 = 26952651272454
                                                                r66 = r24(r25, r8)
                                                                ReturnVal = r7[r66]
                                                                state = r20 ~= ReturnVal
                                                                state = state and (229) or (230)
                                                            end
                                                        else
                                                            if state == 223 then
                                                                state = r51 and (231) or (232)
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 233 then
                                                if state <= 228 then
                                                    if state <= 226 then
                                                        if state <= 225 then
                                                            if state <= 224 then
                                                                if state == 224 then
                                                                    state = r7
                                                                    ReturnVal = r20
                                                                    state = 218
                                                                end
                                                            else
                                                                if state == 225 then
                                                                    r66 = #r51
                                                                    r25 = 0
                                                                    r24 = r66 <= r25
                                                                    r20 = r24
                                                                    state = 224
                                                                end
                                                            end
                                                        else
                                                            if state == 226 then
                                                                r55 = upvalueValues[upvalues[8]]
                                                                r30 = upvalueValues[upvalues[2]]
                                                                r53 = upvalueValues[upvalues[3]]
                                                                r34 = "\137\019\015\016"
                                                                r62 = 22385682131128
                                                                r76 = r53(r34, r62)
                                                                r75 = r30[r76]
                                                                r29 = r55[r75]
                                                                r24 = r29
                                                                state = 227
                                                            end
                                                        end
                                                    else
                                                        if state <= 227 then
                                                            if state == 227 then
                                                                state = r25
                                                                state = r24 and (233) or (234)
                                                                r51 = r24
                                                            end
                                                        else
                                                            if state == 228 then
                                                                r79 = releaseUpvalue(r79)
                                                                r21 = nil
                                                                state = 235
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 231 then
                                                        if state <= 230 then
                                                            if state <= 229 then
                                                                if state == 229 then
                                                                    state = r21
                                                                    r51 = state
                                                                    state = 236
                                                                end
                                                            else
                                                                if state == 230 then
                                                                    r20 = "pcall"
                                                                    ReturnVal = _env[r20]
                                                                    r66 = "loadfile"
                                                                    r24 = _env[r66]
                                                                    r66 = upvalueValues[r79]
                                                                    r25 = {
                                                                        ReturnVal(r24, r66)
                                                                    }
                                                                    r20 = r25[1]
                                                                    r7 = r25[2]
                                                                    r24 = allocUpvalue()
                                                                    upvalueValues[r24] = r7
                                                                    r7 = state
                                                                    state = r20 and (237) or (238)
                                                                    ReturnVal = r20
                                                                end
                                                            end
                                                        else
                                                            if state == 231 then
                                                                r20 = r51
                                                                upvalueValues[r18] = r20
                                                                state = 239
                                                            end
                                                        end
                                                    else
                                                        if state <= 232 then
                                                            if state == 232 then
                                                                r24 = upvalueValues[upvalues[6]]
                                                                r29 = upvalueValues[upvalues[2]]
                                                                r55 = upvalueValues[upvalues[3]]
                                                                r30 = "\148\213\227+"
                                                                r53 = 2582396060850
                                                                r75 = r55(r30, r53)
                                                                r25 = r29[r75]
                                                                r55 = upvalueValues[upvalues[2]]
                                                                r75 = upvalueValues[upvalues[3]]
                                                                r53 = "\161 e\130\225\005/\231\2375\218)\204\186\244\171*\030\1313?-\156\154\195\022\139\154\164\005\198\198\160\166\220\023\242R\160RT\006\157\127\006\005\175s"
                                                                r76 = 29731851089428
                                                                r30 = r75(r53, r76)
                                                                r29 = r55[r30]
                                                                r24[r25] = r29
                                                                state = 239
                                                            end
                                                        else
                                                            if state == 233 then
                                                                state = r61
                                                                r61 = allocUpvalue()
                                                                upvalueValues[r61] = r51
                                                                r24 = allocUpvalue()
                                                                r29 = createClosure3(291, {
                                                                    upvalues[2],
                                                                    upvalues[3],
                                                                    r61,
                                                                    r79,
                                                                    r24
                                                                })
                                                                r51 = false
                                                                upvalueValues[r24] = r51
                                                                r25 = "pcall"
                                                                r51 = _env[r25]
                                                                r25 = r51(r29)
                                                                r51 = upvalueValues[r24]
                                                                state = r51 and (240) or (241)
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 238 then
                                                    if state <= 236 then
                                                        if state <= 235 then
                                                            if state <= 234 then
                                                                if state == 234 then
                                                                    r25 = upvalueValues[upvalues[2]]
                                                                    r29 = upvalueValues[upvalues[3]]
                                                                    r30 = 12186380932650
                                                                    r75 = "\168\026\156\158\221\159\230\159@\137h\1679\240$\023\136\128"
                                                                    r55 = r29(r75, r30)
                                                                    r24 = r25[r55]
                                                                    r51 = r24
                                                                    state = 233
                                                                end
                                                            else
                                                                if state == 235 then
                                                                    ReturnVal = {}
                                                                    r18 = releaseUpvalue(r18)
                                                                    state = nil
                                                                end
                                                            end
                                                        else
                                                            if state == 236 then
                                                                state = 223
                                                            end
                                                        end
                                                    else
                                                        if state <= 237 then
                                                            if state == 237 then
                                                                r8 = "type"
                                                                r25 = _env[r8]
                                                                r26 = upvalueValues[r24]
                                                                r8 = r25(r26)
                                                                r26 = upvalueValues[upvalues[2]]
                                                                r29 = upvalueValues[upvalues[3]]
                                                                r30 = 11566121358601
                                                                r75 = "C\217\207\t\168xY\163"
                                                                r55 = r29(r75, r30)
                                                                r25 = r26[r55]
                                                                r66 = r8 == r25
                                                                ReturnVal = r66
                                                                state = 238
                                                            end
                                                        else
                                                            if state == 238 then
                                                                state = r7
                                                                state = ReturnVal and (242) or (243)
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 240 then
                                                        if state <= 239 then
                                                            if state == 239 then
                                                                r61 = nil
                                                                r79 = releaseUpvalue(r79)
                                                                r21 = nil
                                                                r51 = nil
                                                                state = 209
                                                            end
                                                        else
                                                            if state == 240 then
                                                                r51 = upvalueValues[upvalues[6]]
                                                                r29 = upvalueValues[upvalues[2]]
                                                                r55 = upvalueValues[upvalues[3]]
                                                                r53 = 4301450823635
                                                                r30 = "\234\020\1592"
                                                                r75 = r55(r30, r53)
                                                                r25 = r29[r75]
                                                                r75 = upvalueValues[upvalues[2]]
                                                                r30 = upvalueValues[upvalues[3]]
                                                                r34 = 30180303206117
                                                                r76 = "\020}\156\r\187O\163u\245\168\208\137\240Q\219\163\229(\0083.0\186"
                                                                r53 = r30(r76, r34)
                                                                r55 = r75[r53]
                                                                r75 = upvalueValues[r61]
                                                                r29 = r55 .. r75
                                                                r51[r25] = r29
                                                                state = 244
                                                            end
                                                        end
                                                    else
                                                        if state <= 241 then
                                                            if state == 241 then
                                                                r25 = "pcall"
                                                                r51 = _env[r25]
                                                                r29 = createClosure2(297, {
                                                                    upvalues[2],
                                                                    upvalues[3],
                                                                    r79
                                                                })
                                                                r25 = r51(r29)
                                                                state = r25 and (245) or (246)
                                                            end
                                                        else
                                                            if state == 242 then
                                                                r66 = state
                                                                r7 = allocUpvalue()
                                                                ReturnVal = nil
                                                                upvalueValues[r7] = ReturnVal
                                                                r8 = "debug"
                                                                r25 = _env[r8]
                                                                state = r25 and (247) or (248)
                                                                ReturnVal = r25
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 261 then
                                            if state <= 252 then
                                                if state <= 247 then
                                                    if state <= 245 then
                                                        if state <= 244 then
                                                            if state <= 243 then
                                                                if state == 243 then
                                                                    r7 = r21
                                                                    r51 = r7
                                                                    state = 249
                                                                end
                                                            else
                                                                if state == 244 then
                                                                    r29 = upvalueValues[upvalues[4]]
                                                                    r25 = state
                                                                    state = r29 and (250) or (251)
                                                                    r51 = r29
                                                                end
                                                            end
                                                        else
                                                            if state == 245 then
                                                                r51 = upvalueValues[upvalues[6]]
                                                                r29 = upvalueValues[upvalues[2]]
                                                                r55 = upvalueValues[upvalues[3]]
                                                                r30 = "I\0083g"
                                                                r53 = 29482736809376
                                                                r75 = r55(r30, r53)
                                                                r25 = r29[r75]
                                                                r55 = upvalueValues[upvalues[2]]
                                                                r75 = upvalueValues[upvalues[3]]
                                                                r76 = 9211538329793
                                                                r53 = "\160\004\004C\222\198\230y\222\251+C4\163\133\204\140\152\029Y\029\174\131\147\189P\232\003"
                                                                r30 = r75(r53, r76)
                                                                r29 = r55[r30]
                                                                r51[r25] = r29
                                                                state = 244
                                                            end
                                                        end
                                                    else
                                                        if state <= 246 then
                                                            if state == 246 then
                                                                r51 = upvalueValues[upvalues[6]]
                                                                r29 = upvalueValues[upvalues[2]]
                                                                r55 = upvalueValues[upvalues[3]]
                                                                r53 = 31426258549033
                                                                r30 = "=,\166\235"
                                                                r75 = r55(r30, r53)
                                                                r25 = r29[r75]
                                                                r55 = upvalueValues[upvalues[2]]
                                                                r75 = upvalueValues[upvalues[3]]
                                                                r76 = 17435666636727
                                                                r53 = "\205}y\244\135O\220\162\131=\243,d\004\229\193T\198x\214\234\020\012<2\128L|e\217\233\158\176t8"
                                                                r30 = r75(r53, r76)
                                                                r29 = r55[r30]
                                                                r51[r25] = r29
                                                                state = 244
                                                            end
                                                        else
                                                            if state == 247 then
                                                                r26 = "debug"
                                                                r8 = _env[r26]
                                                                r29 = upvalueValues[upvalues[2]]
                                                                r55 = upvalueValues[upvalues[3]]
                                                                r53 = 31747152394687
                                                                r30 = "\237\129hc6E5"
                                                                r75 = r55(r30, r53)
                                                                r26 = r29[r75]
                                                                r25 = r8[r26]
                                                                ReturnVal = r25
                                                                state = 248
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 250 then
                                                        if state <= 249 then
                                                            if state <= 248 then
                                                                if state == 248 then
                                                                    state = r66
                                                                    state = ReturnVal and (252) or (253)
                                                                end
                                                            else
                                                                if state == 249 then
                                                                    r24 = releaseUpvalue(r24)
                                                                    r20 = nil
                                                                    state = 236
                                                                end
                                                            end
                                                        else
                                                            if state == 250 then
                                                                r75 = "type"
                                                                r55 = _env[r75]
                                                                r53 = "loadfile"
                                                                r30 = _env[r53]
                                                                r75 = r55(r30)
                                                                r30 = upvalueValues[upvalues[2]]
                                                                r53 = upvalueValues[upvalues[3]]
                                                                r34 = "\203u\238\171ca\138\203"
                                                                r62 = 28694415340593
                                                                r76 = r53(r34, r62)
                                                                r55 = r30[r76]
                                                                r29 = r75 == r55
                                                                r51 = r29
                                                                state = 251
                                                            end
                                                        end
                                                    else
                                                        if state <= 251 then
                                                            if state == 251 then
                                                                state = r25
                                                                state = r51 and (254) or (255)
                                                            end
                                                        else
                                                            if state == 252 then
                                                                r25 = createClosure5(304, {
                                                                    upvalues[2],
                                                                    upvalues[3],
                                                                    r24,
                                                                    r7
                                                                })
                                                                r66 = "pcall"
                                                                ReturnVal = _env[r66]
                                                                r66 = ReturnVal(r25)
                                                                state = 253
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 257 then
                                                    if state <= 255 then
                                                        if state <= 254 then
                                                            if state <= 253 then
                                                                if state == 253 then
                                                                    r66 = state
                                                                    r25 = upvalueValues[r7]
                                                                    state = r25 and (256) or (257)
                                                                    ReturnVal = r25
                                                                end
                                                            else
                                                                if state == 254 then
                                                                    r55 = state
                                                                    r25 = "tostring"
                                                                    r51 = _env[r25]
                                                                    r30 = upvalueValues[upvalues[5]]
                                                                    r76 = upvalueValues[upvalues[2]]
                                                                    r34 = upvalueValues[upvalues[3]]
                                                                    r11 = "\1752\226B"
                                                                    r14 = 23194537716272
                                                                    r62 = r34(r11, r14)
                                                                    r53 = r76[r62]
                                                                    r75 = r30[r53]
                                                                    state = r75 and (258) or (259)
                                                                    r29 = r75
                                                                end
                                                            end
                                                        else
                                                            if state == 255 then
                                                                r61 = releaseUpvalue(r61)
                                                                r24 = releaseUpvalue(r24)
                                                                state = 228
                                                            end
                                                        end
                                                    else
                                                        if state <= 256 then
                                                            if state == 256 then
                                                                r8 = state
                                                                r29 = upvalueValues[r7]
                                                                r75 = upvalueValues[upvalues[2]]
                                                                r30 = upvalueValues[upvalues[3]]
                                                                r76 = "\255\153\143\207\251\229"
                                                                r34 = 21350553364182
                                                                r53 = r30(r76, r34)
                                                                r55 = r75[r53]
                                                                r26 = r29[r55]
                                                                state = r26 and (260) or (261)
                                                                r25 = r26
                                                            end
                                                        else
                                                            if state == 257 then
                                                                state = r66
                                                                state = ReturnVal and (262) or (263)
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 259 then
                                                        if state <= 258 then
                                                            if state == 258 then
                                                                r25 = r51(r29)
                                                                state = r55
                                                                r55 = upvalueValues[upvalues[2]]
                                                                r75 = upvalueValues[upvalues[3]]
                                                                r53 = ""
                                                                r76 = 25257195630065
                                                                r30 = r75(r53, r76)
                                                                r29 = r55[r30]
                                                                r51 = r25 ~= r29
                                                                state = r51 and (264) or (265)
                                                            end
                                                        else
                                                            if state == 259 then
                                                                r30 = upvalueValues[upvalues[2]]
                                                                r53 = upvalueValues[upvalues[3]]
                                                                r62 = 29001787995329
                                                                r34 = ""
                                                                r76 = r53(r34, r62)
                                                                r75 = r30[r76]
                                                                r29 = r75
                                                                state = 258
                                                            end
                                                        end
                                                    else
                                                        if state <= 260 then
                                                            if state == 260 then
                                                                r55 = "tostring"
                                                                r29 = _env[r55]
                                                                r30 = upvalueValues[r7]
                                                                r76 = upvalueValues[upvalues[2]]
                                                                r34 = upvalueValues[upvalues[3]]
                                                                r11 = "&\001\236r\r\203"
                                                                r14 = 10491802538773
                                                                r62 = r34(r11, r14)
                                                                r53 = r76[r62]
                                                                r75 = r30[r53]
                                                                r55 = r29(r75)
                                                                r29 = "sub"
                                                                r29 = r55[r29]
                                                                r30 = 1
                                                                r75 = 1
                                                                r29 = r29(r55, r75, r30)
                                                                r75 = upvalueValues[upvalues[2]]
                                                                r30 = upvalueValues[upvalues[3]]
                                                                r34 = 29635069638119
                                                                r76 = "\238"
                                                                r53 = r30(r76, r34)
                                                                r55 = r75[r53]
                                                                r26 = r29 == r55
                                                                r25 = r26
                                                                state = 261
                                                            end
                                                        else
                                                            if state == 261 then
                                                                state = r8
                                                                ReturnVal = r25
                                                                state = 257
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 270 then
                                                if state <= 266 then
                                                    if state <= 264 then
                                                        if state <= 263 then
                                                            if state <= 262 then
                                                                if state == 262 then
                                                                    r66 = "tostring"
                                                                    ReturnVal = _env[r66]
                                                                    r8 = upvalueValues[r7]
                                                                    r29 = upvalueValues[upvalues[2]]
                                                                    r55 = upvalueValues[upvalues[3]]
                                                                    r30 = "\207M\008\155\226j"
                                                                    r53 = 20409978725664
                                                                    r75 = r55(r30, r53)
                                                                    r26 = r29[r75]
                                                                    r25 = r8[r26]
                                                                    r66 = ReturnVal(r25)
                                                                    ReturnVal = "sub"
                                                                    ReturnVal = r66[ReturnVal]
                                                                    r25 = 2
                                                                    ReturnVal = ReturnVal(r66, r25)
                                                                    r66 = allocUpvalue()
                                                                    upvalueValues[r66] = ReturnVal
                                                                    ReturnVal = nil
                                                                    r25 = ReturnVal
                                                                    r8 = "pcall"
                                                                    ReturnVal = _env[r8]
                                                                    r29 = createClosure3(305, {
                                                                        upvalues[2],
                                                                        upvalues[3],
                                                                        r66
                                                                    })
                                                                    r55 = {
                                                                        ReturnVal(r29)
                                                                    }
                                                                    r8 = r55[1]
                                                                    r26 = r55[2]
                                                                    r25 = r8
                                                                    r55 = not r25
                                                                    r29 = state
                                                                    state = r55 and (266) or (267)
                                                                    r51 = r26
                                                                    ReturnVal = r55
                                                                end
                                                            else
                                                                if state == 263 then
                                                                    r66 = r21
                                                                    r51 = r66
                                                                    state = 268
                                                                end
                                                            end
                                                        else
                                                            if state == 264 then
                                                                r29 = "pcall"
                                                                r51 = _env[r29]
                                                                r30 = "loadfile"
                                                                r75 = _env[r30]
                                                                r30 = {
                                                                    r51(r75, r25)
                                                                }
                                                                r29 = r30[1]
                                                                r75 = state
                                                                state = r29 and (269) or (270)
                                                                r51 = r29
                                                                r55 = r30[2]
                                                            end
                                                        end
                                                    else
                                                        if state <= 265 then
                                                            if state == 265 then
                                                                r25 = nil
                                                                state = 255
                                                            end
                                                        else
                                                            if state == 266 then
                                                                state = r29
                                                                state = ReturnVal and (271) or (272)
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 268 then
                                                        if state <= 267 then
                                                            if state == 267 then
                                                                r75 = state
                                                                r76 = "type"
                                                                r53 = _env[r76]
                                                                r76 = r53(r51)
                                                                r34 = upvalueValues[upvalues[2]]
                                                                r62 = upvalueValues[upvalues[3]]
                                                                r14 = "\127\171\029\170\248$"
                                                                r81 = 24035301256120
                                                                r11 = r62(r14, r81)
                                                                r53 = r34[r11]
                                                                r30 = r76 ~= r53
                                                                state = r30 and (273) or (274)
                                                                r55 = r30
                                                            end
                                                        else
                                                            if state == 268 then
                                                                r7 = releaseUpvalue(r7)
                                                                state = 249
                                                            end
                                                        end
                                                    else
                                                        if state <= 269 then
                                                            if state == 269 then
                                                                r76 = "type"
                                                                r53 = _env[r76]
                                                                r76 = r53(r55)
                                                                r34 = upvalueValues[upvalues[2]]
                                                                r62 = upvalueValues[upvalues[3]]
                                                                r14 = "\234m\199\187\152L\249a"
                                                                r81 = 33759259671912
                                                                r11 = r62(r14, r81)
                                                                r53 = r34[r11]
                                                                r30 = r76 == r53
                                                                r51 = r30
                                                                state = 270
                                                            end
                                                        else
                                                            if state == 270 then
                                                                state = r75
                                                                state = r51 and (275) or (276)
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 275 then
                                                    if state <= 273 then
                                                        if state <= 272 then
                                                            if state <= 271 then
                                                                if state == 271 then
                                                                    ReturnVal = r21
                                                                    r51 = ReturnVal
                                                                    state = 272
                                                                end
                                                            else
                                                                if state == 272 then
                                                                    r66 = releaseUpvalue(r66)
                                                                    r25 = nil
                                                                    state = 268
                                                                end
                                                            end
                                                        else
                                                            if state == 273 then
                                                                state = r75
                                                                ReturnVal = r55
                                                                state = 266
                                                            end
                                                        end
                                                    else
                                                        if state <= 274 then
                                                            if state == 274 then
                                                                r53 = #r51
                                                                r76 = 0
                                                                r30 = r53 <= r76
                                                                r55 = r30
                                                                state = 273
                                                            end
                                                        else
                                                            if state == 275 then
                                                                r75 = "pcall"
                                                                r51 = _env[r75]
                                                                r53 = {
                                                                    r51(r55)
                                                                }
                                                                r75 = r53[1]
                                                                state = r75 and (277) or (278)
                                                                r30 = r53[2]
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 277 then
                                                        if state <= 276 then
                                                            if state == 276 then
                                                                r55 = nil
                                                                r29 = nil
                                                                state = 265
                                                            end
                                                        else
                                                            if state == 277 then
                                                                r51 = upvalueValues[upvalues[6]]
                                                                r76 = upvalueValues[upvalues[2]]
                                                                r34 = upvalueValues[upvalues[3]]
                                                                r14 = 15167969254295
                                                                r11 = "X]\250\127"
                                                                r62 = r34(r11, r14)
                                                                r53 = r76[r62]
                                                                r34 = upvalueValues[upvalues[2]]
                                                                r62 = upvalueValues[upvalues[3]]
                                                                r14 = ",\011\015\154\030\228\186\176\242\233A)\165\r\025\194\128K\r\208U\147\188h0b\178<\219>\210\204<V96\225\019e\156\181e"
                                                                r81 = 564626080006
                                                                r11 = r62(r14, r81)
                                                                r76 = r34[r11]
                                                                r51[r53] = r76
                                                                state = 279
                                                            end
                                                        end
                                                    else
                                                        if state <= 278 then
                                                            if state == 278 then
                                                                r51 = upvalueValues[upvalues[6]]
                                                                r76 = upvalueValues[upvalues[2]]
                                                                r34 = upvalueValues[upvalues[3]]
                                                                r11 = "\194l\214K"
                                                                r14 = 28209957204816
                                                                r62 = r34(r11, r14)
                                                                r53 = r76[r62]
                                                                r34 = upvalueValues[upvalues[2]]
                                                                r62 = upvalueValues[upvalues[3]]
                                                                r81 = 393575891127
                                                                r14 = "M\192\237d\156p\166F\r=\189\191\216\211n\209MS\238\194\031\213\021\025\135]rm\139\024\144\1837)\132O\135\031\134\134"
                                                                r11 = r62(r14, r81)
                                                                r76 = r34[r11]
                                                                r51[r53] = r76
                                                                state = 279
                                                            end
                                                        else
                                                            if state == 279 then
                                                                r75 = nil
                                                                r30 = nil
                                                                state = 276
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure4 entry 3736865 -> 280, states 280-280
                                    if state == 280 then -- entry 3736865 -> 280
                                        r79 = "SXcuzZNrIpo"
                                        r21 = 9183737
                                        r18 = r79 ^ r21
                                        ReturnVal = 726942
                                        state = ReturnVal - r18
                                        r18 = state
                                        ReturnVal = "xmSKpTxC3"
                                        state = ReturnVal / r18
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure8 entry 9634410 -> 281, states 281-283
                                if state <= 282 then
                                    if state <= 281 then
                                        if state == 281 then -- entry 9634410 -> 281
                                            r79 = args[2]
                                            r21 = args[3]
                                            r18 = args[1]
                                            r51 = args[4]
                                            r20 = upvalueValues[upvalues[1]]
                                            r7 = upvalueValues[upvalues[2]]
                                            r66 = "0"
                                            r25 = 31683537336737
                                            r24 = r7(r66, r25)
                                            r61 = r20[r24]
                                            r7 = "tostring"
                                            r20 = _env[r7]
                                            r7 = r20(r21)
                                            ReturnVal = r61 .. r7
                                            state = r18 .. ReturnVal
                                            r61 = state
                                            r20 = upvalueValues[upvalues[3]]
                                            ReturnVal = r20[r61]
                                            state = not ReturnVal
                                            state = state and (282) or (283)
                                        end
                                    else
                                        if state == 282 then
                                            state = upvalueValues[upvalues[3]]
                                            ReturnVal = true
                                            state[r61] = ReturnVal
                                            state = upvalueValues[upvalues[4]]
                                            r7 = upvalueValues[upvalues[4]]
                                            r20 = #r7
                                            r7 = 1
                                            ReturnVal = r20 + r7
                                            r24 = upvalueValues[upvalues[1]]
                                            r66 = upvalueValues[upvalues[2]]
                                            r8 = "\240"
                                            r26 = 22756115655012
                                            r25 = r66(r8, r26)
                                            r7 = r24[r25]
                                            r66 = upvalueValues[upvalues[1]]
                                            r25 = upvalueValues[upvalues[2]]
                                            r29 = 31544340658528
                                            r26 = "["
                                            r8 = r25(r26, r29)
                                            r24 = r66[r8]
                                            r25 = upvalueValues[upvalues[1]]
                                            r8 = upvalueValues[upvalues[2]]
                                            r55 = 11956130272703
                                            r29 = "\238"
                                            r26 = r8(r29, r55)
                                            r66 = r25[r26]
                                            r8 = upvalueValues[upvalues[1]]
                                            r26 = upvalueValues[upvalues[2]]
                                            r75 = 11120062223418
                                            r55 = "/"
                                            r29 = r26(r55, r75)
                                            r25 = r8[r29]
                                            r20 = {
                                                [r7] = r18,
                                                [r24] = r79,
                                                [r66] = r21,
                                                [r25] = r51
                                            }
                                            state[ReturnVal] = r20
                                            state = 283
                                        end
                                    end
                                else
                                    if state == 283 then
                                        r61 = nil
                                        r79 = nil
                                        r21 = nil
                                        r51 = nil
                                        r18 = nil
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 286 then
                                -- createClosure5 entry 7464541 -> 284, states 284-286
                                if state <= 285 then
                                    if state <= 284 then
                                        if state == 284 then -- entry 7464541 -> 284
                                            r18 = args[1]
                                            r51 = upvalueValues[upvalues[1]]
                                            r61 = upvalueValues[upvalues[2]]
                                            r24 = 4694309292169
                                            r7 = "6"
                                            r20 = r61(r7, r24)
                                            r21 = r51[r20]
                                            r79 = args[2]
                                            ReturnVal = r18[r21]
                                            r61 = upvalueValues[upvalues[1]]
                                            r20 = upvalueValues[upvalues[2]]
                                            r66 = 9246234136785
                                            r24 = "\017"
                                            r7 = r20(r24, r66)
                                            r51 = r61[r7]
                                            r21 = r79[r51]
                                            state = ReturnVal ~= r21
                                            state = state and (285) or (286)
                                        end
                                    else
                                        if state == 285 then
                                            r51 = upvalueValues[upvalues[1]]
                                            r61 = upvalueValues[upvalues[2]]
                                            r24 = 12530596648651
                                            r7 = "\223"
                                            r20 = r61(r7, r24)
                                            r21 = r51[r20]
                                            ReturnVal = r18[r21]
                                            r61 = upvalueValues[upvalues[1]]
                                            r20 = upvalueValues[upvalues[2]]
                                            r66 = 22539211909375
                                            r24 = "\204"
                                            r7 = r20(r24, r66)
                                            r51 = r61[r7]
                                            r21 = r79[r51]
                                            state = ReturnVal < r21
                                            ReturnVal = {
                                                state
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    if state == 286 then
                                        r21 = "tostring"
                                        ReturnVal = _env[r21]
                                        r20 = upvalueValues[upvalues[1]]
                                        r7 = upvalueValues[upvalues[2]]
                                        r25 = 2187479450618
                                        r66 = "\221"
                                        r24 = r7(r66, r25)
                                        r61 = r20[r24]
                                        r51 = r18[r61]
                                        r21 = ReturnVal(r51)
                                        r51 = "tostring"
                                        ReturnVal = _env[r51]
                                        r7 = upvalueValues[upvalues[1]]
                                        r24 = upvalueValues[upvalues[2]]
                                        r8 = 1143816700436
                                        r25 = "\195"
                                        r66 = r24(r25, r8)
                                        r20 = r7[r66]
                                        r61 = r79[r20]
                                        r51 = ReturnVal(r61)
                                        state = r21 < r51
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure4 entry 10064794 -> 287, states 287-287
                                if state == 287 then -- entry 10064794 -> 287
                                    state = upvalueValues[upvalues[1]]
                                    r18 = upvalueValues[upvalues[2]]
                                    ReturnVal = {
                                        state(r18)
                                    }
                                    ReturnVal = {
                                        unpack(ReturnVal)
                                    }
                                    state = nil
                                end
                            end
                        end
                    else
                        if state <= 303 then
                            if state <= 296 then
                                if state <= 290 then
                                    -- createClosure3 entry 5053593 -> 288, states 288-290
                                    if state <= 289 then
                                        if state <= 288 then
                                            if state == 288 then -- entry 5053593 -> 288
                                                r18 = "type"
                                                ReturnVal = _env[r18]
                                                r21 = "readfile"
                                                r79 = _env[r21]
                                                r18 = ReturnVal(r79)
                                                r79 = upvalueValues[upvalues[1]]
                                                r21 = upvalueValues[upvalues[2]]
                                                r20 = 1194886021676
                                                r61 = "\136\194G\247#\0058\164"
                                                r51 = r21(r61, r20)
                                                ReturnVal = r79[r51]
                                                state = r18 == ReturnVal
                                                state = state and (289) or (290)
                                            end
                                        else
                                            if state == 289 then
                                                ReturnVal = "readfile"
                                                state = _env[ReturnVal]
                                                r18 = upvalueValues[upvalues[3]]
                                                ReturnVal = {
                                                    state(r18)
                                                }
                                                ReturnVal = {
                                                    unpack(ReturnVal)
                                                }
                                                state = nil
                                            end
                                        end
                                    else
                                        if state == 290 then
                                            ReturnVal = "error"
                                            state = _env[ReturnVal]
                                            r79 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r20 = 23137301916182
                                            r61 = "{\005\168\"\145\151\228\201\220\011`"
                                            r51 = r21(r61, r20)
                                            r18 = r79[r51]
                                            ReturnVal = state(r18)
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure3 entry 13698055 -> 291, states 291-296
                                    if state <= 293 then
                                        if state <= 292 then
                                            if state <= 291 then
                                                if state == 291 then -- entry 13698055 -> 291
                                                    r18 = "type"
                                                    ReturnVal = _env[r18]
                                                    r21 = "writefile"
                                                    r79 = _env[r21]
                                                    r18 = ReturnVal(r79)
                                                    r79 = upvalueValues[upvalues[1]]
                                                    r21 = upvalueValues[upvalues[2]]
                                                    r61 = "\151\203\159\184\2378\247\146"
                                                    r20 = 7475458428313
                                                    r51 = r21(r61, r20)
                                                    ReturnVal = r79[r51]
                                                    state = r18 ~= ReturnVal
                                                    state = state and (292) or (293)
                                                end
                                            else
                                                if state == 292 then
                                                    r18 = "type"
                                                    ReturnVal = _env[r18]
                                                    r21 = "write_file"
                                                    r79 = _env[r21]
                                                    r18 = ReturnVal(r79)
                                                    r79 = upvalueValues[upvalues[1]]
                                                    r21 = upvalueValues[upvalues[2]]
                                                    r61 = "\224\200\255\224\251\162\203\211"
                                                    r20 = 2380632818772
                                                    r51 = r21(r61, r20)
                                                    ReturnVal = r79[r51]
                                                    state = r18 == ReturnVal
                                                    state = state and (294) or (295)
                                                end
                                            end
                                        else
                                            if state == 293 then
                                                r18 = "writefile"
                                                ReturnVal = _env[r18]
                                                r79 = upvalueValues[upvalues[3]]
                                                r21 = upvalueValues[upvalues[4]]
                                                r18 = ReturnVal(r79, r21)
                                                ReturnVal = true
                                                upvalueValues[upvalues[5]] = ReturnVal
                                                state = 296
                                            end
                                        end
                                    else
                                        if state <= 295 then
                                            if state <= 294 then
                                                if state == 294 then
                                                    ReturnVal = "write_file"
                                                    state = _env[ReturnVal]
                                                    r18 = upvalueValues[upvalues[3]]
                                                    r79 = upvalueValues[upvalues[4]]
                                                    ReturnVal = state(r18, r79)
                                                    state = true
                                                    upvalueValues[upvalues[5]] = state
                                                    state = 295
                                                end
                                            else
                                                if state == 295 then
                                                    state = 296
                                                end
                                            end
                                        else
                                            if state == 296 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure2 entry 4387063 -> 297, states 297-303
                                if state <= 300 then
                                    if state <= 298 then
                                        if state <= 297 then
                                            if state == 297 then -- entry 4387063 -> 297
                                                r18 = "type"
                                                ReturnVal = _env[r18]
                                                r21 = "setclipboard"
                                                r79 = _env[r21]
                                                r18 = ReturnVal(r79)
                                                r79 = upvalueValues[upvalues[1]]
                                                r21 = upvalueValues[upvalues[2]]
                                                r20 = 22254264920186
                                                r61 = "\r\014f\171L\199\227\139"
                                                r51 = r21(r61, r20)
                                                ReturnVal = r79[r51]
                                                state = r18 ~= ReturnVal
                                                state = state and (298) or (299)
                                            end
                                        else
                                            if state == 298 then
                                                r18 = "type"
                                                ReturnVal = _env[r18]
                                                r21 = "toClipboard"
                                                r79 = _env[r21]
                                                r18 = ReturnVal(r79)
                                                r79 = upvalueValues[upvalues[1]]
                                                r21 = upvalueValues[upvalues[2]]
                                                r20 = 5662754851404
                                                r61 = "r\171\143*\250\150\030\136"
                                                r51 = r21(r61, r20)
                                                ReturnVal = r79[r51]
                                                state = r18 ~= ReturnVal
                                                state = state and (300) or (301)
                                            end
                                        end
                                    else
                                        if state <= 299 then
                                            if state == 299 then
                                                ReturnVal = "setclipboard"
                                                state = _env[ReturnVal]
                                                r18 = upvalueValues[upvalues[3]]
                                                ReturnVal = state(r18)
                                                state = 302
                                            end
                                        else
                                            if state == 300 then
                                                ReturnVal = "error"
                                                state = _env[ReturnVal]
                                                r79 = upvalueValues[upvalues[1]]
                                                r21 = upvalueValues[upvalues[2]]
                                                r61 = "B\164P{\229L?\000r"
                                                r20 = 30231372527357
                                                r51 = r21(r61, r20)
                                                r18 = r79[r51]
                                                ReturnVal = state(r18)
                                                state = 303
                                            end
                                        end
                                    end
                                else
                                    if state <= 302 then
                                        if state <= 301 then
                                            if state == 301 then
                                                ReturnVal = "toClipboard"
                                                state = _env[ReturnVal]
                                                r18 = upvalueValues[upvalues[3]]
                                                ReturnVal = state(r18)
                                                state = 303
                                            end
                                        else
                                            if state == 302 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        if state == 303 then
                                            state = 302
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 304 then
                                -- createClosure5 entry 8636377 -> 304, states 304-304
                                if state == 304 then -- entry 8636377 -> 304
                                    r18 = "debug"
                                    ReturnVal = _env[r18]
                                    r79 = upvalueValues[upvalues[1]]
                                    r21 = upvalueValues[upvalues[2]]
                                    r61 = "\176\0026\027\006\208\154"
                                    r20 = 10564721939255
                                    r51 = r21(r61, r20)
                                    r18 = r79[r51]
                                    state = ReturnVal[r18]
                                    r18 = upvalueValues[upvalues[3]]
                                    ReturnVal = state(r18)
                                    upvalueValues[upvalues[4]] = ReturnVal
                                    ReturnVal = {}
                                    state = nil
                                end
                            else
                                -- createClosure3 entry 11224012 -> 305, states 305-307
                                if state <= 306 then
                                    if state <= 305 then
                                        if state == 305 then -- entry 11224012 -> 305
                                            r18 = "type"
                                            ReturnVal = _env[r18]
                                            r21 = "readfile"
                                            r79 = _env[r21]
                                            r18 = ReturnVal(r79)
                                            r79 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r61 = "\200\241 \242\216/H9"
                                            r20 = 14402673941042
                                            r51 = r21(r61, r20)
                                            ReturnVal = r79[r51]
                                            state = r18 == ReturnVal
                                            state = state and (306) or (307)
                                        end
                                    else
                                        if state == 306 then
                                            ReturnVal = "readfile"
                                            state = _env[ReturnVal]
                                            r18 = upvalueValues[upvalues[3]]
                                            ReturnVal = {
                                                state(r18)
                                            }
                                            ReturnVal = {
                                                unpack(ReturnVal)
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    if state == 307 then
                                        ReturnVal = "error"
                                        state = _env[ReturnVal]
                                        r79 = upvalueValues[upvalues[1]]
                                        r21 = upvalueValues[upvalues[2]]
                                        r61 = "\004\209V\152\191\206D\196\000\141J"
                                        r20 = 32048496048715
                                        r51 = r21(r61, r20)
                                        r18 = r79[r51]
                                        ReturnVal = state(r18)
                                        ReturnVal = {}
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
        createClosure8 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
                return vm(entryId, {
                    arg1,
                    arg2,
                    arg3,
                    arg4,
                    arg5,
                    arg6,
                    arg7,
                    arg8
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
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 2304896
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 2304896
                    end
                })
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
        upvalueValues = {}
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)