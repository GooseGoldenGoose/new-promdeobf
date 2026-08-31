return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure, createUpvalueProxy, releaseUpvalue, createClosure3, createClosure7, upvalueRefCounts, createClosure5, vm, createClosure2, createClosure1, allocUpvalue, createClosure6, upvalueValues, releaseUpvalues, createClosure8, createClosure4, currentUpvalueId)
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
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, ReturnVal, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36
            while state do
                if state <= 88 then
                    if state <= 58 then
                        if state <= 45 then
                            if state <= 44 then
                                if state <= 43 then
                                    -- root entry 15839772 -> 1, states 1-43
                                    if state <= 22 then
                                        if state <= 11 then
                                            if state <= 6 then
                                                if state <= 3 then
                                                    if state <= 2 then
                                                        if state <= 1 then
                                                            if state == 1 then -- entry 15839772 -> 1
                                                                state = true
                                                                r5 = allocUpvalue()
                                                                upvalueValues[r5] = state
                                                                r3 = "string"
                                                                ReturnVal = _env[r3]
                                                                r3 = "gmatch"
                                                                state = ReturnVal[r3]
                                                                r36 = allocUpvalue()
                                                                r3 = allocUpvalue()
                                                                upvalueValues[r3] = state
                                                                r1 = allocUpvalue()
                                                                state = createClosure3(44, {})
                                                                r18 = createClosure4(45, {
                                                                    r1
                                                                })
                                                                upvalueValues[r36] = state
                                                                state = false
                                                                upvalueValues[r1] = state
                                                                r9 = "pcall"
                                                                r16 = _env[r9]
                                                                r9 = r16(r18)
                                                                state = r9 and 2 or 3
                                                                r28 = args
                                                                ReturnVal = r9
                                                            end
                                                        else
                                                            if state == 2 then
                                                                r16 = upvalueValues[r1]
                                                                ReturnVal = r16
                                                                state = 3
                                                            end
                                                        end
                                                    else
                                                        if state == 3 then
                                                            r16 = ReturnVal
                                                            r9 = "math"
                                                            ReturnVal = _env[r9]
                                                            r9 = "random"
                                                            state = ReturnVal[r9]
                                                            r9 = allocUpvalue()
                                                            upvalueValues[r9] = state
                                                            r18 = "table"
                                                            ReturnVal = _env[r18]
                                                            r18 = "concat"
                                                            state = ReturnVal[r18]
                                                            r18 = state
                                                            r7 = state
                                                            r15 = "table"
                                                            r12 = _env[r15]
                                                            state = r12 and 4 or 5
                                                            r20 = r12
                                                        end
                                                    end
                                                else
                                                    if state <= 5 then
                                                        if state <= 4 then
                                                            if state == 4 then
                                                                r11 = "table"
                                                                r15 = _env[r11]
                                                                r11 = "unpack"
                                                                r12 = r15[r11]
                                                                r20 = r12
                                                                state = 5
                                                            end
                                                        else
                                                            if state == 5 then
                                                                state = r7
                                                                state = r20 and 6 or 7
                                                                ReturnVal = r20
                                                            end
                                                        end
                                                    else
                                                        if state == 6 then
                                                            r20 = allocUpvalue()
                                                            upvalueValues[r20] = ReturnVal
                                                            state = upvalueValues[r9]
                                                            r7 = 3
                                                            r12 = 65
                                                            ReturnVal = state(r7, r12)
                                                            r7 = allocUpvalue()
                                                            upvalueValues[r7] = ReturnVal
                                                            r11 = "pcall"
                                                            ReturnVal = _env[r11]
                                                            state = 0
                                                            r12 = state
                                                            state = 0
                                                            r29 = createClosure3(46, {})
                                                            r11 = {
                                                                ReturnVal(r29)
                                                            }
                                                            r15 = state
                                                            state = {
                                                                unpack(r11)
                                                            }
                                                            r11 = state
                                                            ReturnVal = 2
                                                            state = r11[ReturnVal]
                                                            r29 = state
                                                            ReturnVal = "tonumber"
                                                            state = _env[ReturnVal]
                                                            r26 = upvalueValues[r3]
                                                            r32 = "tostring"
                                                            r23 = _env[r32]
                                                            r32 = r23(r29)
                                                            r23 = ":(%d*):"
                                                            r31 = r26(r32, r23)
                                                            r26 = {
                                                                r31()
                                                            }
                                                            ReturnVal = state(unpack(r26))
                                                            r26 = allocUpvalue()
                                                            upvalueValues[r26] = ReturnVal
                                                            r31 = upvalueValues[r7]
                                                            r23 = r31
                                                            r31 = 1
                                                            r32 = r31
                                                            r31 = 0
                                                            r35 = r32 < r31
                                                            ReturnVal = 1
                                                            r31 = ReturnVal - r32
                                                            state = 8
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 9 then
                                                    if state <= 8 then
                                                        if state <= 7 then
                                                            if state == 7 then
                                                                r7 = "unpack"
                                                                r20 = _env[r7]
                                                                ReturnVal = r20
                                                                state = 6
                                                            end
                                                        else
                                                            if state == 8 then
                                                                r33 = not r35
                                                                r31 = r31 + r32
                                                                ReturnVal = r31 <= r23
                                                                ReturnVal = r33 and ReturnVal
                                                                r33 = r31 >= r23
                                                                r33 = r35 and r33
                                                                ReturnVal = r33 or ReturnVal
                                                                r33 = 9
                                                                state = ReturnVal and r33
                                                                ReturnVal = 10
                                                                state = state or ReturnVal
                                                            end
                                                        end
                                                    else
                                                        if state == 9 then
                                                            r33 = allocUpvalue()
                                                            upvalueValues[r33] = r31
                                                            r19 = "math"
                                                            ReturnVal = _env[r19]
                                                            r19 = "random"
                                                            state = ReturnVal[r19]
                                                            r24 = 100
                                                            r19 = 1
                                                            ReturnVal = state(r19, r24)
                                                            r19 = allocUpvalue()
                                                            upvalueValues[r19] = ReturnVal
                                                            state = upvalueValues[r9]
                                                            r2 = 255
                                                            r24 = 0
                                                            ReturnVal = state(r24, r2)
                                                            r24 = allocUpvalue()
                                                            upvalueValues[r24] = ReturnVal
                                                            state = upvalueValues[r9]
                                                            r34 = upvalueValues[r19]
                                                            r2 = 1
                                                            ReturnVal = state(r2, r34)
                                                            r2 = allocUpvalue()
                                                            upvalueValues[r2] = ReturnVal
                                                            ReturnVal = upvalueValues[r9]
                                                            r14 = 2
                                                            r6 = 1
                                                            r34 = ReturnVal(r6, r14)
                                                            ReturnVal = 1
                                                            state = r34 == ReturnVal
                                                            r34 = allocUpvalue()
                                                            upvalueValues[r34] = state
                                                            r25 = "tostring"
                                                            r21 = _env[r25]
                                                            r8 = upvalueValues[r9]
                                                            r17 = 10000
                                                            r10 = 0
                                                            r30 = {
                                                                r8(r10, r17)
                                                            }
                                                            r25 = r21(unpack(r30))
                                                            state = "gsub"
                                                            r21 = ":"
                                                            r4 = r25 .. r21
                                                            state = r29[state]
                                                            r14 = ":"
                                                            r6 = r14 .. r4
                                                            ReturnVal = ":(%d*):"
                                                            state = state(r29, ReturnVal, r6)
                                                            r6 = allocUpvalue()
                                                            upvalueValues[r6] = state
                                                            r4 = createClosure2(47, {
                                                                r9,
                                                                r33,
                                                                r7,
                                                                r3,
                                                                r5,
                                                                r26,
                                                                r34,
                                                                r6,
                                                                r19,
                                                                r2,
                                                                r24,
                                                                r20
                                                            })
                                                            r14 = "pcall"
                                                            ReturnVal = _env[r14]
                                                            r14 = {
                                                                ReturnVal(r4)
                                                            }
                                                            state = {
                                                                unpack(r14)
                                                            }
                                                            r14 = state
                                                            state = upvalueValues[r34]
                                                            state = state and 11 or 12
                                                        end
                                                    end
                                                else
                                                    if state <= 10 then
                                                        if state == 10 then
                                                            r23 = upvalueValues[r5]
                                                            state = r23 and 13 or 14
                                                            r31 = r23
                                                        end
                                                    else
                                                        if state == 11 then
                                                            r4 = upvalueValues[r5]
                                                            state = r4 and 15 or 16
                                                            ReturnVal = r4
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 17 then
                                                if state <= 14 then
                                                    if state <= 13 then
                                                        if state <= 12 then
                                                            if state == 12 then
                                                                r21 = upvalueValues[r5]
                                                                state = r21 and 17 or 18
                                                                r4 = r21
                                                            end
                                                        else
                                                            if state == 13 then
                                                                r23 = r12 == r15
                                                                r31 = r23
                                                                state = 14
                                                            end
                                                        end
                                                    else
                                                        if state == 14 then
                                                            upvalueValues[r5] = r31
                                                            state = upvalueValues[r5]
                                                            state = state and 19 or 20
                                                        end
                                                    end
                                                else
                                                    if state <= 16 then
                                                        if state <= 15 then
                                                            if state == 15 then
                                                                r21 = state
                                                                r30 = 1
                                                                r8 = r14[r30]
                                                                r30 = false
                                                                r25 = r8 == r30
                                                                state = r25 and 21 or 22
                                                                r4 = r25
                                                            end
                                                        else
                                                            if state == 16 then
                                                                upvalueValues[r5] = ReturnVal
                                                                state = 23
                                                            end
                                                        end
                                                    else
                                                        if state == 17 then
                                                            r25 = 1
                                                            r21 = r14[r25]
                                                            r4 = r21
                                                            state = 18
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 20 then
                                                    if state <= 19 then
                                                        if state <= 18 then
                                                            if state == 18 then
                                                                upvalueValues[r5] = r4
                                                                r30 = upvalueValues[r2]
                                                                r10 = 1
                                                                r8 = r30 + r10
                                                                r25 = r14[r8]
                                                                r21 = r12 + r25
                                                                r25 = 256
                                                                state = r21 % r25
                                                                r12 = state
                                                                r8 = upvalueValues[r24]
                                                                r25 = r15 + r8
                                                                r8 = 256
                                                                r21 = r25 % r8
                                                                r15 = r21
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
                                                            r30 = 2
                                                            r8 = r14[r30]
                                                            r30 = upvalueValues[r6]
                                                            r25 = r8 == r30
                                                            r4 = r25
                                                            state = 22
                                                        end
                                                    else
                                                        if state == 22 then
                                                            state = r21
                                                            ReturnVal = r4
                                                            state = 16
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 33 then
                                            if state <= 28 then
                                                if state <= 25 then
                                                    if state <= 24 then
                                                        if state <= 23 then
                                                            if state == 23 then
                                                                r19 = releaseUpvalue(r19)
                                                                r34 = releaseUpvalue(r34)
                                                                r6 = releaseUpvalue(r6)
                                                                r2 = releaseUpvalue(r2)
                                                                r24 = releaseUpvalue(r24)
                                                                r33 = releaseUpvalue(r33)
                                                                r14 = nil
                                                                state = 8
                                                            end
                                                        else
                                                            if state == 24 then
                                                                r3 = releaseUpvalue(r3)
                                                                r1 = releaseUpvalue(r1)
                                                                r9 = releaseUpvalue(r9)
                                                                r26 = releaseUpvalue(r26)
                                                                r7 = releaseUpvalue(r7)
                                                                r36 = releaseUpvalue(r36)
                                                                r5 = releaseUpvalue(r5)
                                                                r20 = releaseUpvalue(r20)
                                                                r36 = allocUpvalue()
                                                                r5 = nil
                                                                upvalueValues[r36] = r5
                                                                r5 = allocUpvalue()
                                                                r3 = nil
                                                                upvalueValues[r5] = r3
                                                                r16 = nil
                                                                r16 = "math"
                                                                r1 = _env[r16]
                                                                r12 = nil
                                                                r12 = {}
                                                                r7 = allocUpvalue()
                                                                r16 = "floor"
                                                                r3 = r1[r16]
                                                                r1 = allocUpvalue()
                                                                r26 = 256
                                                                upvalueValues[r1] = r3
                                                                r9 = "math"
                                                                r16 = _env[r9]
                                                                r9 = "random"
                                                                r3 = r16[r9]
                                                                r18 = nil
                                                                r18 = "table"
                                                                r9 = _env[r18]
                                                                r18 = "remove"
                                                                r16 = r9[r18]
                                                                r20 = "string"
                                                                r18 = _env[r20]
                                                                r20 = "char"
                                                                r9 = r18[r20]
                                                                r20 = allocUpvalue()
                                                                r18 = 0
                                                                upvalueValues[r20] = r18
                                                                r15 = nil
                                                                r15 = allocUpvalue()
                                                                r18 = 2
                                                                upvalueValues[r7] = r18
                                                                r18 = {}
                                                                upvalueValues[r15] = r12
                                                                r35 = r26
                                                                r11 = nil
                                                                r11 = {}
                                                                r26 = 1
                                                                r33 = r26
                                                                r26 = 0
                                                                r19 = r33 < r26
                                                                r29 = nil
                                                                r29 = 1
                                                                r26 = r29 - r33
                                                                r12 = 0
                                                                state = 26
                                                            end
                                                        end
                                                    else
                                                        if state == 25 then
                                                            state = createClosure4(59, {
                                                                r36
                                                            })
                                                            r23 = {
                                                                state()
                                                            }
                                                            ReturnVal = {
                                                                unpack(r23)
                                                            }
                                                            state = nil
                                                        end
                                                    end
                                                else
                                                    if state <= 27 then
                                                        if state <= 26 then
                                                            if state == 26 then
                                                                r26 = r26 + r33
                                                                r24 = not r19
                                                                r29 = r26 <= r35
                                                                r29 = r24 and r29
                                                                r24 = r26 >= r35
                                                                r24 = r19 and r24
                                                                r29 = r24 or r29
                                                                r24 = 27
                                                                state = r29 and r24
                                                                r29 = 28
                                                                state = state or r29
                                                            end
                                                        else
                                                            if state == 27 then
                                                                r29 = r26
                                                                r24 = r29
                                                                r11[r29] = r24
                                                                r29 = nil
                                                                state = 26
                                                            end
                                                        end
                                                    else
                                                        if state == 28 then
                                                            r26 = #r11
                                                            r35 = 0
                                                            r29 = r26 == r35
                                                            state = 29
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 31 then
                                                    if state <= 30 then
                                                        if state <= 29 then
                                                            if state == 29 then
                                                                r35 = #r11
                                                                r26 = 1
                                                                r29 = r3(r26, r35)
                                                                r26 = r16(r11, r29)
                                                                r35 = upvalueValues[r15]
                                                                r24 = 1
                                                                r19 = r26 - r24
                                                                r33 = r9(r19)
                                                                r35[r26] = r33
                                                                r29 = nil
                                                                r26 = nil
                                                                state = 30
                                                            end
                                                        else
                                                            if state == 30 then
                                                                r26 = #r11
                                                                r35 = 0
                                                                r29 = r26 == r35
                                                                state = r29 and 31 or 29
                                                            end
                                                        end
                                                    else
                                                        if state == 31 then
                                                            r29 = {}
                                                            r24 = {}
                                                            r26 = allocUpvalue()
                                                            r35 = createClosure3(63, {
                                                                r26,
                                                                r20,
                                                                r7,
                                                                r1
                                                            })
                                                            upvalueValues[r26] = r29
                                                            r29 = allocUpvalue()
                                                            upvalueValues[r29] = r35
                                                            r33 = allocUpvalue()
                                                            r35 = {}
                                                            upvalueValues[r33] = r35
                                                            r1 = releaseUpvalue(r1)
                                                            r19 = "setmetatable"
                                                            r35 = _env[r19]
                                                            r6 = upvalueValues[r33]
                                                            r25 = nil
                                                            r14 = "__metatable"
                                                            r34 = "__index"
                                                            r2 = {
                                                                [r34] = r6,
                                                                [r14] = r25
                                                            }
                                                            r19 = r35(r24, r2)
                                                            upvalueValues[r36] = r19
                                                            r35 = createClosure3(69, {
                                                                r33,
                                                                r26,
                                                                r15,
                                                                r20,
                                                                r7,
                                                                r29
                                                            })
                                                            r15 = releaseUpvalue(r15)
                                                            r33 = releaseUpvalue(r33)
                                                            r26 = releaseUpvalue(r26)
                                                            r29 = releaseUpvalue(r29)
                                                            r20 = releaseUpvalue(r20)
                                                            r7 = releaseUpvalue(r7)
                                                            upvalueValues[r5] = r35
                                                            r1 = "game"
                                                            r3 = nil
                                                            r3 = _env[r1]
                                                            r1 = "IsLoaded"
                                                            r1 = r3[r1]
                                                            r1 = r1(r3)
                                                            r11 = nil
                                                            r16 = nil
                                                            r9 = nil
                                                            r18 = nil
                                                            r12 = nil
                                                            state = 32
                                                        end
                                                    end
                                                else
                                                    if state <= 32 then
                                                        if state == 32 then
                                                            r16 = "task"
                                                            r1 = _env[r16]
                                                            r9 = upvalueValues[r36]
                                                            r18 = upvalueValues[r5]
                                                            r7 = "\t\147\027Z"
                                                            r12 = 20547751176110
                                                            r20 = r18(r7, r12)
                                                            r16 = r9[r20]
                                                            r3 = r1[r16]
                                                            r16 = 5
                                                            r1 = r3(r16)
                                                            state = 33
                                                        end
                                                    else
                                                        if state == 33 then
                                                            r1 = "game"
                                                            r3 = _env[r1]
                                                            r1 = "IsLoaded"
                                                            r1 = r3[r1]
                                                            r1 = r1(r3)
                                                            state = r1 and 34 or 32
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 38 then
                                                if state <= 36 then
                                                    if state <= 35 then
                                                        if state <= 34 then
                                                            if state == 34 then
                                                                r1 = "game"
                                                                r3 = _env[r1]
                                                                r9 = upvalueValues[r36]
                                                                r18 = upvalueValues[r5]
                                                                r7 = "\t\028\222d\155*\230\011\0187"
                                                                r12 = 10436547578286
                                                                r20 = r18(r7, r12)
                                                                r1 = "GetService"
                                                                r1 = r3[r1]
                                                                r16 = r9[r20]
                                                                r1 = r1(r3, r16)
                                                                r3 = "Set3dRenderingEnabled"
                                                                r3 = r1[r3]
                                                                r16 = false
                                                                r3 = r3(r1, r16)
                                                                r16 = upvalueValues[r36]
                                                                r9 = upvalueValues[r5]
                                                                r20 = "\219\180\018Wg\166\222TJi\194\192\182C)0l"
                                                                r7 = 18581203864545
                                                                r18 = r9(r20, r7)
                                                                r1 = r16[r18]
                                                                r18 = upvalueValues[r36]
                                                                r20 = upvalueValues[r5]
                                                                r15 = 29211787304480
                                                                r12 = "^\139\192-\027\002\173\137\240}\150\161\193\017`\135"
                                                                r7 = r20(r12, r15)
                                                                r9 = r18[r7]
                                                                r7 = upvalueValues[r36]
                                                                r12 = upvalueValues[r5]
                                                                r29 = 17749087108931
                                                                r11 = "\242\140 \190\254~\211\171k\181V{P\157J\151"
                                                                r15 = r12(r11, r29)
                                                                r20 = r7[r15]
                                                                r15 = upvalueValues[r36]
                                                                r11 = upvalueValues[r5]
                                                                r35 = 14911655216320
                                                                r26 = "\199I\209\232f\217!\169\228>\237\174\170b\006\191"
                                                                r29 = r11(r26, r35)
                                                                r12 = r15[r29]
                                                                r29 = upvalueValues[r36]
                                                                r26 = upvalueValues[r5]
                                                                r24 = 9026736746064
                                                                r33 = "\227\253\246\\\004\186\155\242\007\176"
                                                                r35 = r26(r33, r24)
                                                                r11 = r29[r35]
                                                                r26 = upvalueValues[r36]
                                                                r35 = upvalueValues[r5]
                                                                r2 = 3910373929586
                                                                r24 = "\182"
                                                                r33 = r35(r24, r2)
                                                                r29 = r26[r33]
                                                                r35 = upvalueValues[r36]
                                                                r33 = upvalueValues[r5]
                                                                r34 = 25575292179532
                                                                r2 = "\147\184%J\134\154,\196\r\008"
                                                                r24 = r33(r2, r34)
                                                                r26 = r35[r24]
                                                                r24 = upvalueValues[r36]
                                                                r2 = upvalueValues[r5]
                                                                r6 = "\167\211\r\140\249E\248\\"
                                                                r14 = 28559188495573
                                                                r34 = r2(r6, r14)
                                                                r33 = r24[r34]
                                                                r2 = 12345678
                                                                r34 = 87654321
                                                                r24 = {
                                                                    r2,
                                                                    r34
                                                                }
                                                                r34 = upvalueValues[r36]
                                                                r6 = upvalueValues[r5]
                                                                r8 = 29507539491263
                                                                r25 = "\022\135\211Xc\235\134"
                                                                r14 = r6(r25, r8)
                                                                r2 = r34[r14]
                                                                r14 = upvalueValues[r36]
                                                                r25 = upvalueValues[r5]
                                                                r30 = "\183;\169\0167\234\203f\243\151\222\129"
                                                                r10 = 27197856855579
                                                                r8 = r25(r30, r10)
                                                                r6 = r14[r8]
                                                                r16 = 15
                                                                r18 = 12
                                                                r7 = 12
                                                                r15 = 15
                                                                r35 = true
                                                                r34 = 33720745
                                                                r14 = 250
                                                                r3 = {
                                                                    [r1] = r16,
                                                                    [r9] = r18,
                                                                    [r20] = r7,
                                                                    [r12] = r15,
                                                                    [r11] = r29,
                                                                    [r26] = r35,
                                                                    [r33] = r24,
                                                                    [r2] = r34,
                                                                    [r6] = r14
                                                                }
                                                                r1 = allocUpvalue()
                                                                upvalueValues[r1] = r3
                                                                r16 = "game"
                                                                r3 = _env[r16]
                                                                r18 = upvalueValues[r36]
                                                                r20 = upvalueValues[r5]
                                                                r15 = 19091174798461
                                                                r12 = "\152\145F\230S\015\222"
                                                                r7 = r20(r12, r15)
                                                                r16 = "GetService"
                                                                r16 = r3[r16]
                                                                r9 = r18[r7]
                                                                r16 = r16(r3, r9)
                                                                r3 = allocUpvalue()
                                                                upvalueValues[r3] = r16
                                                                r9 = "game"
                                                                r16 = _env[r9]
                                                                r20 = upvalueValues[r36]
                                                                r9 = "GetService"
                                                                r9 = r16[r9]
                                                                r7 = upvalueValues[r5]
                                                                r11 = 5923984362794
                                                                r15 = "\222>\215%Mc\172\004D\130\017"
                                                                r12 = r7(r15, r11)
                                                                r18 = r20[r12]
                                                                r9 = r9(r16, r18)
                                                                r7 = allocUpvalue()
                                                                r16 = allocUpvalue()
                                                                upvalueValues[r16] = r9
                                                                r18 = "tick"
                                                                r9 = _env[r18]
                                                                r18 = r9()
                                                                r9 = allocUpvalue()
                                                                upvalueValues[r9] = r18
                                                                r20 = createClosure5(76, {
                                                                    r36,
                                                                    r5,
                                                                    r1
                                                                })
                                                                r18 = allocUpvalue()
                                                                upvalueValues[r18] = r20
                                                                r20 = nil
                                                                upvalueValues[r7] = r20
                                                                r20 = allocUpvalue()
                                                                r12 = createClosure8(89, {
                                                                    r1,
                                                                    r36,
                                                                    r5,
                                                                    r3,
                                                                    r7,
                                                                    r16
                                                                })
                                                                upvalueValues[r20] = r12
                                                                r15 = createClosure6(100, {
                                                                    r3,
                                                                    r36,
                                                                    r5,
                                                                    r7,
                                                                    r16,
                                                                    r1,
                                                                    r20
                                                                })
                                                                r12 = createClosure7(128, {
                                                                    r36,
                                                                    r5,
                                                                    r16
                                                                })
                                                                upvalueValues[r7] = r12
                                                                r12 = allocUpvalue()
                                                                upvalueValues[r12] = r15
                                                                r11 = upvalueValues[r3]
                                                                r26 = upvalueValues[r36]
                                                                r35 = upvalueValues[r5]
                                                                r24 = "\183SP\243\031\128*X\028\157\222"
                                                                r2 = 19406821498156
                                                                r33 = r35(r24, r2)
                                                                r29 = r26[r33]
                                                                r15 = r11[r29]
                                                                r29 = createClosure2(143, {
                                                                    r1,
                                                                    r36,
                                                                    r5,
                                                                    r18,
                                                                    r12
                                                                })
                                                                r11 = "Connect"
                                                                r11 = r15[r11]
                                                                r11 = r11(r15, r29)
                                                                r11 = "ipairs"
                                                                r15 = _env[r11]
                                                                r35 = upvalueValues[r3]
                                                                r24 = "GetPlayers"
                                                                r24 = r35[r24]
                                                                r33 = {
                                                                    r24(r35)
                                                                }
                                                                r35 = {
                                                                    r15(unpack(r33))
                                                                }
                                                                r11 = r35[1]
                                                                r29 = r35[2]
                                                                r26 = r35[3]
                                                                state = 35
                                                            end
                                                        else
                                                            if state == 35 then
                                                                r26, r35 = r11(r29, r26)
                                                                state = r26 and 36 or 37
                                                            end
                                                        end
                                                    else
                                                        if state == 36 then
                                                            r2 = upvalueValues[r3]
                                                            r6 = upvalueValues[r36]
                                                            r14 = upvalueValues[r5]
                                                            r30 = 8801463804536
                                                            r8 = "qB\217\018\1615~^\133\182\129"
                                                            r25 = r14(r8, r30)
                                                            r34 = r6[r25]
                                                            r24 = r2[r34]
                                                            r33 = r35 ~= r24
                                                            state = r33 and 38 or 39
                                                            r15 = r26
                                                        end
                                                    end
                                                else
                                                    if state <= 37 then
                                                        if state == 37 then
                                                            r29 = "task"
                                                            r11 = _env[r29]
                                                            r26 = upvalueValues[r36]
                                                            ReturnVal = {}
                                                            r35 = upvalueValues[r5]
                                                            r7 = releaseUpvalue(r7)
                                                            r2 = "\243\243X\157;"
                                                            r34 = 34315568445233
                                                            r33 = r35(r2, r34)
                                                            r29 = r26[r33]
                                                            r16 = releaseUpvalue(r16)
                                                            r15 = r11[r29]
                                                            r29 = createClosure3(148, {
                                                                r36,
                                                                r5,
                                                                r3,
                                                                r9,
                                                                r1,
                                                                r12
                                                            })
                                                            r1 = releaseUpvalue(r1)
                                                            r3 = releaseUpvalue(r3)
                                                            r9 = releaseUpvalue(r9)
                                                            r12 = releaseUpvalue(r12)
                                                            r11 = r15(r29)
                                                            r20 = releaseUpvalue(r20)
                                                            r11 = "print"
                                                            r15 = _env[r11]
                                                            r26 = upvalueValues[r36]
                                                            r35 = upvalueValues[r5]
                                                            r2 = "m\254i1\029\245"
                                                            r34 = 22851065957568
                                                            r33 = r35(r2, r34)
                                                            r36 = releaseUpvalue(r36)
                                                            r29 = r26[r33]
                                                            r18 = releaseUpvalue(r18)
                                                            r11 = r15(r29)
                                                            r5 = releaseUpvalue(r5)
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 38 then
                                                            r6 = upvalueValues[r1]
                                                            r25 = upvalueValues[r36]
                                                            r8 = upvalueValues[r5]
                                                            r10 = "5\178\2171\022tGw\027z"
                                                            r17 = 2374458282470
                                                            r30 = r8(r10, r17)
                                                            r14 = r25[r30]
                                                            r34 = r6[r14]
                                                            r2 = state
                                                            state = r34 and 40 or 41
                                                            r24 = r34
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 41 then
                                                    if state <= 40 then
                                                        if state <= 39 then
                                                            if state == 39 then
                                                                state = r33 and 42 or 43
                                                            end
                                                        else
                                                            if state == 40 then
                                                                r34 = upvalueValues[r18]
                                                                r6 = r34(r35)
                                                                r24 = r6
                                                                state = 41
                                                            end
                                                        end
                                                    else
                                                        if state == 41 then
                                                            state = r2
                                                            r33 = r24
                                                            state = 39
                                                        end
                                                    end
                                                else
                                                    if state <= 42 then
                                                        if state == 42 then
                                                            r34 = "print"
                                                            r2 = _env[r34]
                                                            r25 = upvalueValues[r36]
                                                            r8 = upvalueValues[r5]
                                                            r10 = "\129qXm\241\254\026 \006\180P\196F\215< J\011i+X\246\218,\169\232\191\179\212\214\133\005\137\219\134xqw\028D~(z\180+X*\175p\128\225\023(\229\132R\238k\204J\150~\248\185a\228\225b`\158E\153\134U@\170K2r.}\142"
                                                            r17 = 16956735693173
                                                            r30 = r8(r10, r17)
                                                            r14 = r25[r30]
                                                            r10 = upvalueValues[r36]
                                                            r17 = upvalueValues[r5]
                                                            r22 = "\225\227\233\210"
                                                            r13 = 19209119436556
                                                            r27 = r17(r22, r13)
                                                            r30 = r10[r27]
                                                            r8 = r35[r30]
                                                            r10 = upvalueValues[r36]
                                                            r17 = upvalueValues[r5]
                                                            r13 = 5514832096575
                                                            r22 = "\157\0013\186\021GR\003\030E\163\1633],\191\014\130\214\147o\252\192\216\018\023\245\227\008@\184\029\186\136#\150\230~\160]\150\158\006\130\218\155\173\n\243."
                                                            r27 = r17(r22, r13)
                                                            r30 = r10[r27]
                                                            r25 = r8 .. r30
                                                            r6 = r14 .. r25
                                                            r34 = r2(r6)
                                                            r2 = upvalueValues[r12]
                                                            r14 = upvalueValues[r36]
                                                            r25 = upvalueValues[r5]
                                                            r30 = "iu\022q\143"
                                                            r10 = 26234984852168
                                                            r8 = r25(r30, r10)
                                                            r6 = r14[r8]
                                                            r34 = r2(r6)
                                                            r15 = nil
                                                            r35 = nil
                                                            r33 = nil
                                                            state = 37
                                                        end
                                                    else
                                                        if state == 43 then
                                                            r33 = nil
                                                            r15 = nil
                                                            r35 = nil
                                                            state = 35
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure3 entry 5879897 -> 44, states 44-44
                                    if state == 44 then -- entry 5879897 -> 44
                                        ReturnVal = "error"
                                        state = _env[ReturnVal]
                                        r28 = "Tamper Detected!"
                                        ReturnVal = state(r28)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure4 entry 3927427 -> 45, states 45-45
                                if state == 45 then -- entry 3927427 -> 45
                                    state = true
                                    upvalueValues[upvalues[1]] = state
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            if state <= 46 then
                                -- createClosure3 entry 5217037 -> 46, states 46-46
                                if state == 46 then -- entry 5217037 -> 46
                                    r5 = "2yOCmnZDLD4m"
                                    r3 = 1095544
                                    r28 = r5 ^ r3
                                    ReturnVal = 12955214
                                    state = ReturnVal - r28
                                    r28 = state
                                    ReturnVal = "ZCAwRAG57RKfNC"
                                    state = ReturnVal / r28
                                    ReturnVal = {
                                        state
                                    }
                                    state = nil
                                end
                            else
                                -- createClosure2 entry 11886069 -> 47, states 47-58
                                if state <= 52 then
                                    if state <= 49 then
                                        if state <= 48 then
                                            if state <= 47 then
                                                if state == 47 then -- entry 11886069 -> 47
                                                    r5 = upvalueValues[upvalues[1]]
                                                    r1 = 2
                                                    r36 = 1
                                                    r3 = r5(r36, r1)
                                                    r5 = 1
                                                    r28 = r3 == r5
                                                    state = r28 and 48 or 49
                                                    ReturnVal = r28
                                                end
                                            else
                                                if state == 48 then
                                                    state = ReturnVal and 50 or 51
                                                end
                                            end
                                        else
                                            if state == 49 then
                                                r5 = upvalueValues[upvalues[2]]
                                                r3 = upvalueValues[upvalues[3]]
                                                r28 = r5 == r3
                                                ReturnVal = r28
                                                state = 48
                                            end
                                        end
                                    else
                                        if state <= 51 then
                                            if state <= 50 then
                                                if state == 50 then
                                                    r20 = createClosure1(156, {})
                                                    ReturnVal = "tonumber"
                                                    state = _env[ReturnVal]
                                                    r28 = upvalueValues[upvalues[4]]
                                                    r36 = "tostring"
                                                    r3 = _env[r36]
                                                    r18 = "pcall"
                                                    r9 = _env[r18]
                                                    r18 = {
                                                        r9(r20)
                                                    }
                                                    r16 = {
                                                        unpack(r18)
                                                    }
                                                    r9 = 2
                                                    r1 = r16[r9]
                                                    r36 = r3(r1)
                                                    r3 = ":(%d*):"
                                                    r5 = r28(r36, r3)
                                                    r28 = {
                                                        r5()
                                                    }
                                                    ReturnVal = state(unpack(r28))
                                                    r28 = ReturnVal
                                                    r5 = upvalueValues[upvalues[5]]
                                                    state = r5 and 52 or 53
                                                    ReturnVal = r5
                                                end
                                            else
                                                if state == 51 then
                                                    state = upvalueValues[upvalues[7]]
                                                    state = state and 54 or 55
                                                end
                                            end
                                        else
                                            if state == 52 then
                                                r3 = upvalueValues[upvalues[6]]
                                                r5 = r3 == r28
                                                ReturnVal = r5
                                                state = 53
                                            end
                                        end
                                    end
                                else
                                    if state <= 55 then
                                        if state <= 54 then
                                            if state <= 53 then
                                                if state == 53 then
                                                    upvalueValues[upvalues[5]] = ReturnVal
                                                    r28 = nil
                                                    state = 51
                                                end
                                            else
                                                if state == 54 then
                                                    r28 = "error"
                                                    state = _env[r28]
                                                    r5 = upvalueValues[upvalues[8]]
                                                    r3 = 0
                                                    r28 = state(r5, r3)
                                                    state = 55
                                                end
                                            end
                                        else
                                            if state == 55 then
                                                state = {}
                                                r28 = state
                                                r3 = upvalueValues[upvalues[9]]
                                                r36 = r3
                                                r3 = 1
                                                r1 = r3
                                                r3 = 0
                                                r16 = r1 < r3
                                                r5 = 1
                                                r3 = r5 - r1
                                                state = 56
                                            end
                                        end
                                    else
                                        if state <= 57 then
                                            if state <= 56 then
                                                if state == 56 then
                                                    r3 = r3 + r1
                                                    r9 = not r16
                                                    r5 = r3 <= r36
                                                    r5 = r9 and r5
                                                    r9 = r3 >= r36
                                                    r9 = r16 and r9
                                                    r5 = r9 or r5
                                                    r9 = 57
                                                    state = r5 and r9
                                                    r5 = 58
                                                    state = state or r5
                                                end
                                            else
                                                if state == 57 then
                                                    state = upvalueValues[upvalues[1]]
                                                    r20 = 255
                                                    r18 = 0
                                                    r9 = state(r18, r20)
                                                    r5 = r3
                                                    r28[r5] = r9
                                                    r5 = nil
                                                    state = 56
                                                end
                                            end
                                        else
                                            if state == 58 then
                                                state = upvalueValues[upvalues[10]]
                                                r5 = upvalueValues[upvalues[11]]
                                                r28[state] = r5
                                                state = upvalueValues[upvalues[12]]
                                                r5 = {
                                                    state(r28)
                                                }
                                                ReturnVal = {
                                                    unpack(r5)
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 68 then
                            if state <= 62 then
                                -- createClosure4 entry 5056556 -> 59, states 59-62
                                if state <= 60 then
                                    if state <= 59 then
                                        if state == 59 then -- entry 5056556 -> 59
                                            state = 60
                                        end
                                    else
                                        if state == 60 then
                                            state = true
                                            state = state and 61 or 62
                                        end
                                    end
                                else
                                    if state <= 61 then
                                        if state == 61 then
                                            ReturnVal = "l2"
                                            state = _env[ReturnVal]
                                            r28 = "l1"
                                            ReturnVal = _env[r28]
                                            r28 = "l1"
                                            _env[r28] = state
                                            r28 = "l2"
                                            _env[r28] = ReturnVal
                                            r28 = upvalueValues[upvalues[1]]
                                            r5 = r28()
                                            state = 60
                                        end
                                    else
                                        if state == 62 then
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            else
                                -- createClosure3 entry 7445679 -> 63, states 63-68
                                if state <= 65 then
                                    if state <= 64 then
                                        if state <= 63 then
                                            if state == 63 then -- entry 7445679 -> 63
                                                r28 = upvalueValues[upvalues[1]]
                                                ReturnVal = #r28
                                                r28 = 0
                                                state = ReturnVal == r28
                                                state = state and 64 or 65
                                            end
                                        else
                                            if state == 64 then
                                                r5 = upvalueValues[upvalues[2]]
                                                r3 = 49
                                                r28 = r5 * r3
                                                r5 = 28563986425721
                                                ReturnVal = r28 + r5
                                                r28 = 35184372088832
                                                state = ReturnVal % r28
                                                upvalueValues[upvalues[2]] = state
                                                r28 = upvalueValues[upvalues[3]]
                                                r5 = 1
                                                ReturnVal = r28 ~= r5
                                                state = 66
                                            end
                                        end
                                    else
                                        if state == 65 then
                                            r3 = "table"
                                            r5 = _env[r3]
                                            r3 = "remove"
                                            r28 = r5[r3]
                                            r3 = upvalueValues[upvalues[1]]
                                            r5 = {
                                                r28(r3)
                                            }
                                            ReturnVal = {
                                                unpack(r5)
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    if state <= 67 then
                                        if state <= 66 then
                                            if state == 66 then
                                                r5 = upvalueValues[upvalues[3]]
                                                r3 = 174
                                                r28 = r5 * r3
                                                r5 = 257
                                                ReturnVal = r28 % r5
                                                upvalueValues[upvalues[3]] = ReturnVal
                                                state = 67
                                            end
                                        else
                                            if state == 67 then
                                                r5 = upvalueValues[upvalues[3]]
                                                r3 = 1
                                                r28 = r5 ~= r3
                                                state = r28 and 68 or 66
                                            end
                                        end
                                    else
                                        if state == 68 then
                                            r5 = upvalueValues[upvalues[3]]
                                            r3 = 32
                                            r28 = r5 % r3
                                            r36 = upvalueValues[upvalues[4]]
                                            r9 = upvalueValues[upvalues[2]]
                                            r29 = upvalueValues[upvalues[3]]
                                            r11 = r29 - r28
                                            r29 = 32
                                            r15 = r11 / r29
                                            r12 = 13
                                            r7 = r12 - r15
                                            r20 = 2
                                            r18 = r20 ^ r7
                                            r16 = r9 / r18
                                            r1 = r36(r16)
                                            r36 = 4294967296
                                            r3 = r1 % r36
                                            r1 = 2
                                            r36 = r1 ^ r28
                                            r5 = r3 / r36
                                            r36 = upvalueValues[upvalues[4]]
                                            r18 = 1
                                            r9 = r5 % r18
                                            r18 = 4294967296
                                            r16 = r9 * r18
                                            r1 = r36(r16)
                                            r36 = upvalueValues[upvalues[4]]
                                            r16 = r36(r5)
                                            r3 = r1 + r16
                                            r1 = 65536
                                            r36 = r3 % r1
                                            r16 = r3 - r36
                                            r9 = 65536
                                            r1 = r16 / r9
                                            r9 = 256
                                            r16 = r36 % r9
                                            r18 = r36 - r16
                                            r20 = 256
                                            r9 = r18 / r20
                                            r20 = 256
                                            r18 = r1 % r20
                                            r7 = r1 - r18
                                            r12 = 256
                                            r20 = r7 / r12
                                            r7 = {
                                                r16,
                                                r9,
                                                r18,
                                                r20
                                            }
                                            upvalueValues[upvalues[1]] = r7
                                            r20 = nil
                                            r9 = nil
                                            r16 = nil
                                            r18 = nil
                                            r5 = nil
                                            r3 = nil
                                            r36 = nil
                                            r28 = nil
                                            r1 = nil
                                            state = 65
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 75 then
                                -- createClosure3 entry 4974172 -> 69, states 69-75
                                if state <= 72 then
                                    if state <= 70 then
                                        if state <= 69 then
                                            if state == 69 then -- entry 4974172 -> 69
                                                r5 = args[2]
                                                state = upvalueValues[upvalues[1]]
                                                r3 = state
                                                r28 = args[1]
                                                state = r3[r5]
                                                state = state and 70 or 71
                                            end
                                        else
                                            if state == 70 then
                                                state = 72
                                            end
                                        end
                                    else
                                        if state <= 71 then
                                            if state == 71 then
                                                state = {}
                                                upvalueValues[upvalues[2]] = state
                                                ReturnVal = upvalueValues[upvalues[3]]
                                                r36 = ReturnVal
                                                r1 = 35184372088832
                                                ReturnVal = r5 % r1
                                                upvalueValues[upvalues[4]] = ReturnVal
                                                r9 = 255
                                                r16 = r5 % r9
                                                r9 = 2
                                                r1 = r16 + r9
                                                upvalueValues[upvalues[5]] = r1
                                                r7 = 1
                                                r12 = r7
                                                r18 = "string"
                                                r9 = _env[r18]
                                                r18 = "len"
                                                r16 = r9[r18]
                                                r9 = r16(r28)
                                                r16 = ""
                                                r3[r5] = r16
                                                r7 = 0
                                                r15 = r12 < r7
                                                r18 = 1
                                                r7 = r18 - r12
                                                r20 = r9
                                                r16 = 179
                                                state = 73
                                            end
                                        else
                                            if state == 72 then
                                                ReturnVal = {
                                                    r5
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    if state <= 74 then
                                        if state <= 73 then
                                            if state == 73 then
                                                r11 = not r15
                                                r7 = r7 + r12
                                                r18 = r7 <= r20
                                                r18 = r11 and r18
                                                r11 = r7 >= r20
                                                r11 = r15 and r11
                                                r18 = r11 or r18
                                                r11 = 74
                                                state = r18 and r11
                                                r18 = 75
                                                state = state or r18
                                            end
                                        else
                                            if state == 74 then
                                                r18 = r7
                                                r32 = "string"
                                                r23 = _env[r32]
                                                r32 = "byte"
                                                r31 = r23[r32]
                                                r23 = r31(r28, r18)
                                                r31 = upvalueValues[upvalues[6]]
                                                r32 = r31()
                                                r26 = r23 + r32
                                                r29 = r26 + r16
                                                r26 = 256
                                                r11 = r29 % r26
                                                r16 = r11
                                                r26 = r3[r5]
                                                r32 = 1
                                                r23 = r16 + r32
                                                r31 = r36[r23]
                                                r29 = r26 .. r31
                                                r3[r5] = r29
                                                r18 = nil
                                                state = 73
                                            end
                                        end
                                    else
                                        if state == 75 then
                                            r16 = nil
                                            r9 = nil
                                            r36 = nil
                                            state = 72
                                        end
                                    end
                                end
                            else
                                -- createClosure5 entry 15287315 -> 76, states 76-88
                                if state <= 82 then
                                    if state <= 79 then
                                        if state <= 77 then
                                            if state <= 76 then
                                                if state == 76 then -- entry 15287315 -> 76
                                                    r28 = allocUpvalue()
                                                    upvalueValues[r28] = args[1]
                                                    r5 = "table"
                                                    ReturnVal = _env[r5]
                                                    r3 = upvalueValues[upvalues[1]]
                                                    r36 = upvalueValues[upvalues[2]]
                                                    r9 = 34201956859087
                                                    r16 = " \026#\133"
                                                    r1 = r36(r16, r9)
                                                    r5 = r3[r1]
                                                    state = ReturnVal[r5]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r1 = upvalueValues[upvalues[1]]
                                                    r16 = upvalueValues[upvalues[2]]
                                                    r20 = 15621505249097
                                                    r18 = "\175\225\143d\023\185\187b"
                                                    r9 = r16(r18, r20)
                                                    r36 = r1[r9]
                                                    r5 = r3[r36]
                                                    r36 = upvalueValues[r28]
                                                    r16 = upvalueValues[upvalues[1]]
                                                    r9 = upvalueValues[upvalues[2]]
                                                    r20 = "\007\238t\232\246\192"
                                                    r7 = 26083109735103
                                                    r18 = r9(r20, r7)
                                                    r1 = r16[r18]
                                                    r3 = r36[r1]
                                                    ReturnVal = state(r5, r3)
                                                    state = ReturnVal and 77 or 78
                                                end
                                            else
                                                if state == 77 then
                                                    state = true
                                                    ReturnVal = {
                                                        state
                                                    }
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state <= 78 then
                                                if state == 78 then
                                                    r3 = "game"
                                                    r5 = _env[r3]
                                                    r36 = upvalueValues[upvalues[1]]
                                                    r1 = upvalueValues[upvalues[2]]
                                                    r18 = 15284660425150
                                                    r9 = "\199\003\"\234\001I#\219\157`b"
                                                    r16 = r1(r9, r18)
                                                    r3 = r36[r16]
                                                    ReturnVal = r5[r3]
                                                    r1 = "Enum"
                                                    r36 = _env[r1]
                                                    r16 = upvalueValues[upvalues[1]]
                                                    r9 = upvalueValues[upvalues[2]]
                                                    r20 = "\218\255\132\t^\156H\031)\227\132"
                                                    r7 = 33078033934337
                                                    r18 = r9(r20, r7)
                                                    r1 = r16[r18]
                                                    r3 = r36[r1]
                                                    r1 = upvalueValues[upvalues[1]]
                                                    r16 = upvalueValues[upvalues[2]]
                                                    r20 = 33778800137954
                                                    r18 = "\142\008Ei"
                                                    r9 = r16(r18, r20)
                                                    r36 = r1[r9]
                                                    r5 = r3[r36]
                                                    state = ReturnVal == r5
                                                    r5 = state
                                                    state = r5 and 79 or 80
                                                end
                                            else
                                                if state == 79 then
                                                    r3 = upvalueValues[r28]
                                                    r1 = upvalueValues[upvalues[1]]
                                                    r16 = upvalueValues[upvalues[2]]
                                                    r20 = 33742941045501
                                                    r18 = "\175#\133\022\141\131"
                                                    r9 = r16(r18, r20)
                                                    r36 = r1[r9]
                                                    ReturnVal = r3[r36]
                                                    r1 = "game"
                                                    r36 = _env[r1]
                                                    r16 = upvalueValues[upvalues[1]]
                                                    r9 = upvalueValues[upvalues[2]]
                                                    r20 = "\149T\007_T`\248mR"
                                                    r7 = 31903036115013
                                                    r18 = r9(r20, r7)
                                                    r1 = r16[r18]
                                                    r3 = r36[r1]
                                                    state = ReturnVal == r3
                                                    r5 = state
                                                    state = 80
                                                end
                                            end
                                        end
                                    else
                                        if state <= 81 then
                                            if state <= 80 then
                                                if state == 80 then
                                                    state = r5 and 81 or 82
                                                end
                                            else
                                                if state == 81 then
                                                    ReturnVal = true
                                                    ReturnVal = {
                                                        ReturnVal
                                                    }
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state == 82 then
                                                r36 = upvalueValues[upvalues[3]]
                                                r16 = upvalueValues[upvalues[1]]
                                                r9 = upvalueValues[upvalues[2]]
                                                r7 = 16597430258917
                                                r20 = "O\175g:B-\133"
                                                r18 = r9(r20, r7)
                                                r1 = r16[r18]
                                                r3 = r36[r1]
                                                r36 = 0
                                                ReturnVal = r3 > r36
                                                state = ReturnVal and 83 or 84
                                            end
                                        end
                                    end
                                else
                                    if state <= 85 then
                                        if state <= 84 then
                                            if state <= 83 then
                                                if state == 83 then
                                                    r1 = createClosure2(157, {
                                                        r28,
                                                        upvalues[3],
                                                        upvalues[1],
                                                        upvalues[2]
                                                    })
                                                    r3 = "pcall"
                                                    ReturnVal = _env[r3]
                                                    r16 = {
                                                        ReturnVal(r1)
                                                    }
                                                    r36 = r16[2]
                                                    r3 = r16[1]
                                                    state = r3 and 85 or 86
                                                end
                                            else
                                                if state == 84 then
                                                    r3 = false
                                                    ReturnVal = {
                                                        r3
                                                    }
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state == 85 then
                                                r16 = upvalueValues[upvalues[3]]
                                                r18 = upvalueValues[upvalues[1]]
                                                r20 = upvalueValues[upvalues[2]]
                                                r12 = "\206 \155\221n\203#,h\030\151\131"
                                                r15 = 34603838892643
                                                r7 = r20(r12, r15)
                                                r9 = r18[r7]
                                                r1 = r16[r9]
                                                ReturnVal = r36 >= r1
                                                r3 = ReturnVal
                                                state = 86
                                            end
                                        end
                                    else
                                        if state <= 87 then
                                            if state <= 86 then
                                                if state == 86 then
                                                    state = r3 and 87 or 88
                                                end
                                            else
                                                if state == 87 then
                                                    r1 = true
                                                    ReturnVal = {
                                                        r1
                                                    }
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state == 88 then
                                                r36 = nil
                                                r3 = nil
                                                state = 84
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 155 then
                        if state <= 142 then
                            if state <= 127 then
                                if state <= 99 then
                                    -- createClosure8 entry 905317 -> 89, states 89-99
                                    if state <= 94 then
                                        if state <= 91 then
                                            if state <= 90 then
                                                if state <= 89 then
                                                    if state == 89 then -- entry 905317 -> 89
                                                        r16 = args[6]
                                                        r9 = upvalueValues[upvalues[1]]
                                                        r20 = upvalueValues[upvalues[2]]
                                                        r36 = args[4]
                                                        r5 = args[2]
                                                        r1 = args[5]
                                                        r28 = args[1]
                                                        r3 = args[3]
                                                        r7 = upvalueValues[upvalues[3]]
                                                        r15 = "\213b\245\142\031\191Q\000\206<"
                                                        r11 = 14436480284674
                                                        r12 = r7(r15, r11)
                                                        r18 = r20[r12]
                                                        ReturnVal = r9[r18]
                                                        r18 = upvalueValues[upvalues[2]]
                                                        r20 = upvalueValues[upvalues[3]]
                                                        r12 = ""
                                                        r15 = 21183601614836
                                                        r7 = r20(r12, r15)
                                                        r9 = r18[r7]
                                                        state = ReturnVal == r9
                                                        state = state and 90 or 91
                                                    end
                                                else
                                                    if state == 90 then
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state == 91 then
                                                    r20 = not r1
                                                    r18 = state
                                                    state = r20 and 92 or 93
                                                    r9 = r20
                                                end
                                            end
                                        else
                                            if state <= 93 then
                                                if state <= 92 then
                                                    if state == 92 then
                                                        r7 = upvalueValues[upvalues[2]]
                                                        r12 = upvalueValues[upvalues[3]]
                                                        r11 = "\1643\149\13567\014\224\224\133\211\248GY}v\149\170Wd$\249s\019\1313F"
                                                        r29 = 7308861055347
                                                        r15 = r12(r11, r29)
                                                        r20 = r7[r15]
                                                        r9 = r20
                                                        state = 93
                                                    end
                                                else
                                                    if state == 93 then
                                                        state = r18
                                                        state = r9 and 94 or 95
                                                        ReturnVal = r9
                                                    end
                                                end
                                            else
                                                if state == 94 then
                                                    state = 45055
                                                    r18 = state
                                                    state = r1 and 96 or 97
                                                    r9 = ReturnVal
                                                end
                                            end
                                        end
                                    else
                                        if state <= 97 then
                                            if state <= 96 then
                                                if state <= 95 then
                                                    if state == 95 then
                                                        r18 = upvalueValues[upvalues[2]]
                                                        r20 = upvalueValues[upvalues[3]]
                                                        r15 = 28971886885852
                                                        r12 = "\005s\151\248\141\142e\211`&\226\246B\136$\247u\159\201z\204G\018\030\138\006z\"\182\162\214\245\004\021\233\233\166w\189\200\142D\167\165Qr\158\177hL"
                                                        r7 = r20(r12, r15)
                                                        r9 = r18[r7]
                                                        ReturnVal = r9
                                                        state = 94
                                                    end
                                                else
                                                    if state == 96 then
                                                        state = 5763719
                                                        r18 = state
                                                        state = 97
                                                    end
                                                end
                                            else
                                                if state == 97 then
                                                    r7 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r29 = 26329190084906
                                                    r11 = "\184\007\179Y\232"
                                                    r15 = r12(r11, r29)
                                                    r20 = r7[r15]
                                                    ReturnVal = r16 == r20
                                                    state = ReturnVal and 98 or 99
                                                end
                                            end
                                        else
                                            if state <= 98 then
                                                if state == 98 then
                                                    r7 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    ReturnVal = 16711680
                                                    r29 = 11035739048105
                                                    r11 = "Do4\0292\222\239l\139+\139\219\2256\179\255\177\2286\024\213~'h\029\2226S\168\131\176\220B\173\179\1485\1475\173\145\172\232\006\142\170p\163\rW,\208!0T\027\001R\"iH<,\167\233\194+\136\207\147\158\231\017^\145\211\030\025[\022"
                                                    r15 = r12(r11, r29)
                                                    r20 = r7[r15]
                                                    r28 = r20
                                                    r18 = ReturnVal
                                                    state = 99
                                                end
                                            else
                                                if state == 99 then
                                                    r15 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r26 = "nZ\173\252\012\023\148G\165\140\026;\004\138\015L\031\154FJW\219\140"
                                                    r31 = 8779280248214
                                                    r29 = r11(r26, r31)
                                                    r12 = r15[r29]
                                                    r7 = r12 .. r9
                                                    r29 = "game"
                                                    r11 = _env[r29]
                                                    r26 = upvalueValues[upvalues[2]]
                                                    ReturnVal = {}
                                                    r31 = upvalueValues[upvalues[3]]
                                                    r32 = "-\173v\230"
                                                    r35 = 23346285924263
                                                    r23 = r31(r32, r35)
                                                    r29 = r26[r23]
                                                    r15 = r11[r29]
                                                    r26 = upvalueValues[upvalues[2]]
                                                    r31 = upvalueValues[upvalues[3]]
                                                    r35 = 18204354940150
                                                    r32 = "\232\201\221\182\029\228"
                                                    r23 = r31(r32, r35)
                                                    r29 = r26[r23]
                                                    r23 = "tostring"
                                                    r31 = _env[r23]
                                                    r33 = "game"
                                                    r35 = _env[r33]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r34 = "\214\176\248h\027\159\024"
                                                    r6 = 10494213858554
                                                    r2 = r24(r34, r6)
                                                    r33 = r19[r2]
                                                    r32 = r35[r33]
                                                    r23 = r31(r32)
                                                    r32 = upvalueValues[upvalues[2]]
                                                    r35 = upvalueValues[upvalues[3]]
                                                    r19 = "<"
                                                    r24 = 20690182300264
                                                    r33 = r35(r19, r24)
                                                    r31 = r32[r33]
                                                    r26 = r23 .. r31
                                                    r11 = r29 .. r26
                                                    r12 = r15 .. r11
                                                    r29 = upvalueValues[upvalues[2]]
                                                    r26 = upvalueValues[upvalues[3]]
                                                    r32 = 28235986220493
                                                    r23 = "\147\199\213\243"
                                                    r31 = r26(r23, r32)
                                                    r11 = r29[r31]
                                                    r26 = upvalueValues[upvalues[2]]
                                                    r31 = upvalueValues[upvalues[3]]
                                                    r35 = 3387331581826
                                                    r32 = "8\r\234)I\168\021\250\185}0\000\255\165\189\195P\137\188T7"
                                                    r23 = r31(r32, r35)
                                                    r29 = r26[r23]
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r23 = upvalueValues[upvalues[3]]
                                                    r33 = 945716142817
                                                    r35 = "n\228\014N\227"
                                                    r32 = r23(r35, r33)
                                                    r26 = r31[r32]
                                                    r23 = upvalueValues[upvalues[2]]
                                                    r32 = upvalueValues[upvalues[3]]
                                                    r19 = 28955327910993
                                                    r33 = "\229\244y\238\004w"
                                                    r35 = r32(r33, r19)
                                                    r31 = r23[r35]
                                                    r23 = false
                                                    r15 = {
                                                        [r11] = r29,
                                                        [r26] = r12,
                                                        [r31] = r23
                                                    }
                                                    r26 = upvalueValues[upvalues[4]]
                                                    r23 = upvalueValues[upvalues[2]]
                                                    r32 = upvalueValues[upvalues[3]]
                                                    r33 = "6\169\136\018\212\011\170`\019\245Y"
                                                    r19 = 16531988776855
                                                    r35 = r32(r33, r19)
                                                    r31 = r23[r35]
                                                    r29 = r26[r31]
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r23 = upvalueValues[upvalues[3]]
                                                    r33 = 30409729612671
                                                    r35 = "5Jx0"
                                                    r32 = r23(r35, r33)
                                                    r26 = r31[r32]
                                                    r11 = r29[r26]
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r23 = upvalueValues[upvalues[3]]
                                                    r35 = "\245\127\019\190"
                                                    r33 = 16575578874254
                                                    r32 = r23(r35, r33)
                                                    r26 = r31[r32]
                                                    r23 = upvalueValues[upvalues[2]]
                                                    r32 = upvalueValues[upvalues[3]]
                                                    r19 = 506099592751
                                                    r33 = "\2153\244\237\184\206\159\142&\182`\242"
                                                    r35 = r32(r33, r19)
                                                    r31 = r23[r35]
                                                    r32 = upvalueValues[upvalues[2]]
                                                    r35 = upvalueValues[upvalues[3]]
                                                    r24 = 33561591989827
                                                    r19 = "\142\154\136.."
                                                    r33 = r35(r19, r24)
                                                    r23 = r32[r33]
                                                    r35 = upvalueValues[upvalues[2]]
                                                    r33 = upvalueValues[upvalues[3]]
                                                    r2 = 16298073991479
                                                    r24 = "\015\206\140\184\252\236"
                                                    r19 = r33(r24, r2)
                                                    r32 = r35[r19]
                                                    r35 = true
                                                    r29 = {
                                                        [r26] = r31,
                                                        [r23] = r11,
                                                        [r32] = r35
                                                    }
                                                    r23 = upvalueValues[upvalues[2]]
                                                    r32 = upvalueValues[upvalues[3]]
                                                    r33 = "\219\232Qe"
                                                    r19 = 2670975459583
                                                    r35 = r32(r33, r19)
                                                    r31 = r23[r35]
                                                    r32 = upvalueValues[upvalues[2]]
                                                    r35 = upvalueValues[upvalues[3]]
                                                    r24 = 29417721458865
                                                    r19 = "j\225\156\194H\166m\179D\027Z"
                                                    r33 = r35(r19, r24)
                                                    r23 = r32[r33]
                                                    r35 = upvalueValues[upvalues[2]]
                                                    r33 = upvalueValues[upvalues[3]]
                                                    r2 = 16376470918951
                                                    r24 = ")\008!\144\243"
                                                    r19 = r33(r24, r2)
                                                    r32 = r35[r19]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r19 = upvalueValues[upvalues[3]]
                                                    r34 = 27310276098883
                                                    r2 = "\161B/Lf\239"
                                                    r24 = r19(r2, r34)
                                                    r35 = r33[r24]
                                                    r33 = true
                                                    r26 = {
                                                        [r31] = r23,
                                                        [r32] = r28,
                                                        [r35] = r33
                                                    }
                                                    r32 = "tostring"
                                                    r23 = _env[r32]
                                                    r32 = r23(r5)
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r19 = upvalueValues[upvalues[3]]
                                                    r34 = 33378301770575
                                                    r2 = "RDk"
                                                    r24 = r19(r2, r34)
                                                    r35 = r33[r24]
                                                    r19 = "tostring"
                                                    r33 = _env[r19]
                                                    r19 = r33(r3)
                                                    r23 = r35 .. r19
                                                    r31 = r32 .. r23
                                                    r35 = upvalueValues[upvalues[2]]
                                                    r33 = upvalueValues[upvalues[3]]
                                                    r24 = "@U9\144"
                                                    r2 = 24984255269710
                                                    r19 = r33(r24, r2)
                                                    r32 = r35[r19]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r19 = upvalueValues[upvalues[3]]
                                                    r34 = 21042296093097
                                                    r2 = "\206\183u(\254R\242\180\177\138\248\018"
                                                    r24 = r19(r2, r34)
                                                    r35 = r33[r24]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r6 = 32419307053370
                                                    r34 = "ai$\169\160"
                                                    r2 = r24(r34, r6)
                                                    r33 = r19[r2]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r2 = upvalueValues[upvalues[3]]
                                                    r14 = 15465591344551
                                                    r6 = "S\188\152a5\165"
                                                    r34 = r2(r6, r14)
                                                    r19 = r24[r34]
                                                    r24 = true
                                                    r23 = {
                                                        [r32] = r35,
                                                        [r33] = r31,
                                                        [r19] = r24
                                                    }
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r19 = upvalueValues[upvalues[3]]
                                                    r2 = "\1405\191"
                                                    r34 = 5208842728068
                                                    r24 = r19(r2, r34)
                                                    r35 = r33[r24]
                                                    r24 = "tostring"
                                                    r19 = _env[r24]
                                                    r24 = r19(r36)
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r4 = 22537503093592
                                                    r14 = "\251\006\162"
                                                    r6 = r34(r14, r4)
                                                    r19 = r2[r6]
                                                    r33 = r24 .. r19
                                                    r32 = r35 .. r33
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r34 = "\165\169h\136"
                                                    r6 = 2029811688242
                                                    r2 = r24(r34, r6)
                                                    r33 = r19[r2]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r2 = upvalueValues[upvalues[3]]
                                                    r14 = 27424081216084
                                                    r6 = "\215!\011\153u\141u6\218{"
                                                    r34 = r2(r6, r14)
                                                    r19 = r24[r34]
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r14 = "N\211{X\018"
                                                    r4 = 2125297605377
                                                    r6 = r34(r14, r4)
                                                    r24 = r2[r6]
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r6 = upvalueValues[upvalues[3]]
                                                    r21 = 3668006070588
                                                    r4 = "\223\233\222\217\140v"
                                                    r14 = r6(r4, r21)
                                                    r2 = r34[r14]
                                                    r34 = false
                                                    r35 = {
                                                        [r33] = r19,
                                                        [r24] = r32,
                                                        [r2] = r34
                                                    }
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r2 = upvalueValues[upvalues[3]]
                                                    r14 = 32753118827104
                                                    r6 = " \153\2036&@L"
                                                    r34 = r2(r6, r14)
                                                    r19 = r24[r34]
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r4 = 1084654826058
                                                    r14 = "\222\1960\242\181U"
                                                    r6 = r34(r14, r4)
                                                    r24 = r2[r6]
                                                    r14 = upvalueValues[upvalues[2]]
                                                    r4 = upvalueValues[upvalues[3]]
                                                    r8 = 11818954891999
                                                    r25 = "Bkq\003\026"
                                                    r21 = r4(r25, r8)
                                                    r6 = r14[r21]
                                                    r4 = upvalueValues[upvalues[2]]
                                                    r21 = upvalueValues[upvalues[3]]
                                                    r30 = 32393662485612
                                                    r8 = "L\247Js\230P"
                                                    r25 = r21(r8, r30)
                                                    r14 = r4[r25]
                                                    r4 = {
                                                        r15,
                                                        r29,
                                                        r26,
                                                        r23,
                                                        r35
                                                    }
                                                    r34 = {
                                                        [r6] = r18,
                                                        [r14] = r4
                                                    }
                                                    r2 = {
                                                        r34
                                                    }
                                                    r33 = {
                                                        [r19] = r7,
                                                        [r24] = r2
                                                    }
                                                    r19 = upvalueValues[upvalues[5]]
                                                    r34 = upvalueValues[upvalues[1]]
                                                    r14 = upvalueValues[upvalues[2]]
                                                    r4 = upvalueValues[upvalues[3]]
                                                    r25 = "\218k\025\237%\015By\168\006"
                                                    r8 = 32285861796015
                                                    r21 = r4(r25, r8)
                                                    r6 = r14[r21]
                                                    r2 = r34[r6]
                                                    r6 = upvalueValues[upvalues[2]]
                                                    r14 = upvalueValues[upvalues[3]]
                                                    r25 = 7821668915662
                                                    r21 = "MV\215\230"
                                                    r4 = r14(r21, r25)
                                                    r34 = r6[r4]
                                                    r6 = upvalueValues[upvalues[6]]
                                                    r4 = "JSONEncode"
                                                    r4 = r6[r4]
                                                    r14 = {
                                                        r4(r6, r33)
                                                    }
                                                    r24 = r19(r2, r34, unpack(r14))
                                                    r16 = nil
                                                    r3 = nil
                                                    r12 = nil
                                                    r1 = nil
                                                    r5 = nil
                                                    r36 = nil
                                                    r9 = nil
                                                    r31 = nil
                                                    r28 = nil
                                                    r11 = nil
                                                    r32 = nil
                                                    r7 = nil
                                                    r23 = nil
                                                    r18 = nil
                                                    r35 = nil
                                                    r29 = nil
                                                    r15 = nil
                                                    r26 = nil
                                                    r33 = nil
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure6 entry 5004684 -> 100, states 100-127
                                    if state <= 113 then
                                        if state <= 106 then
                                            if state <= 103 then
                                                if state <= 101 then
                                                    if state <= 100 then
                                                        if state == 100 then -- entry 5004684 -> 100
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r28 = args[1]
                                                            r5 = "GetPlayers"
                                                            r5 = ReturnVal[r5]
                                                            r5 = r5(ReturnVal)
                                                            state = #r5
                                                            r5 = state
                                                            r3 = upvalueValues[upvalues[2]]
                                                            r36 = upvalueValues[upvalues[3]]
                                                            r9 = 3946287601233
                                                            r16 = "j\176\n\144\189\2098`\162^\159\252BX\133n\234\170K\139\136:2\024\143\194[#\152\234\026\154\159\230"
                                                            r1 = r36(r16, r9)
                                                            ReturnVal = r3[r1]
                                                            r16 = "game"
                                                            r1 = _env[r16]
                                                            r9 = upvalueValues[upvalues[2]]
                                                            r18 = upvalueValues[upvalues[3]]
                                                            r12 = 19420558437523
                                                            r7 = "\"\212\202%\145Fk"
                                                            r20 = r18(r7, r12)
                                                            r16 = r9[r20]
                                                            r36 = r1[r16]
                                                            r16 = upvalueValues[upvalues[2]]
                                                            r9 = upvalueValues[upvalues[3]]
                                                            r7 = 14967031624524
                                                            r20 = "\222J{\238\194\195M\200\2111&m>\018\206W\196e\001T-\187g\018\164\227\195\201\201O\128\251\195\016\182\177G\203\205"
                                                            r18 = r9(r20, r7)
                                                            r1 = r16[r18]
                                                            r3 = r36 .. r1
                                                            state = ReturnVal .. r3
                                                            r3 = state
                                                            r36 = "tostring"
                                                            ReturnVal = _env[r36]
                                                            r9 = "game"
                                                            r16 = _env[r9]
                                                            r18 = upvalueValues[upvalues[2]]
                                                            r20 = upvalueValues[upvalues[3]]
                                                            r12 = "\154\172\166\161\238\207\226"
                                                            r15 = 7877774976633
                                                            r7 = r20(r12, r15)
                                                            r9 = r18[r7]
                                                            r1 = r16[r9]
                                                            r36 = ReturnVal(r1)
                                                            r1 = upvalueValues[upvalues[2]]
                                                            r16 = upvalueValues[upvalues[3]]
                                                            r18 = "\205\030\188\172Q\157\182\177\209C\143E\238pf\012"
                                                            r20 = 3509540755595
                                                            r9 = r16(r18, r20)
                                                            ReturnVal = r1[r9]
                                                            state = r36 .. ReturnVal
                                                            r36 = allocUpvalue()
                                                            r16 = allocUpvalue()
                                                            upvalueValues[r36] = state
                                                            state = upvalueValues[upvalues[4]]
                                                            ReturnVal = state(r3)
                                                            state = nil
                                                            upvalueValues[r16] = state
                                                            r1 = ReturnVal
                                                            state = false
                                                            r9 = state
                                                            r18 = upvalueValues[upvalues[2]]
                                                            r20 = upvalueValues[upvalues[3]]
                                                            r15 = 9426679977735
                                                            r12 = "\251#\132\144[\183\t"
                                                            r7 = r20(r12, r15)
                                                            ReturnVal = r18[r7]
                                                            state = r1[ReturnVal]
                                                            r18 = state
                                                            state = r18 and 101 or 102
                                                        end
                                                    else
                                                        if state == 101 then
                                                            r20 = upvalueValues[upvalues[2]]
                                                            r7 = upvalueValues[upvalues[3]]
                                                            r11 = 11279124456906
                                                            r15 = "\158\159s\139"
                                                            r12 = r7(r15, r11)
                                                            ReturnVal = r20[r12]
                                                            state = r1[ReturnVal]
                                                            r18 = state
                                                            state = r18 and 103 or 104
                                                        end
                                                    end
                                                else
                                                    if state <= 102 then
                                                        if state == 102 then
                                                            state = r18 and 105 or 106
                                                        end
                                                    else
                                                        if state == 103 then
                                                            r12 = upvalueValues[upvalues[2]]
                                                            r15 = upvalueValues[upvalues[3]]
                                                            r29 = "\189=}\179"
                                                            r26 = 19261393304528
                                                            r11 = r15(r29, r26)
                                                            r7 = r12[r11]
                                                            r20 = r1[r7]
                                                            r15 = upvalueValues[upvalues[2]]
                                                            r11 = upvalueValues[upvalues[3]]
                                                            r31 = 13270883151036
                                                            r26 = "\199\253\018\168;"
                                                            r29 = r11(r26, r31)
                                                            r7 = "find"
                                                            r7 = r20[r7]
                                                            r12 = r15[r29]
                                                            r7 = r7(r20, r12)
                                                            ReturnVal = not r7
                                                            r18 = ReturnVal
                                                            state = 104
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 105 then
                                                    if state <= 104 then
                                                        if state == 104 then
                                                            state = 102
                                                        end
                                                    else
                                                        if state == 105 then
                                                            r20 = upvalueValues[upvalues[5]]
                                                            r11 = upvalueValues[upvalues[2]]
                                                            r29 = upvalueValues[upvalues[3]]
                                                            r31 = "Dr~\191"
                                                            r23 = 13718529793808
                                                            r26 = r29(r31, r23)
                                                            r15 = r11[r26]
                                                            r7 = "JSONDecode"
                                                            r7 = r20[r7]
                                                            r12 = r1[r15]
                                                            r7 = r7(r20, r12)
                                                            state = r7 and 107 or 108
                                                            r20 = r7
                                                        end
                                                    end
                                                else
                                                    if state == 106 then
                                                        r29 = upvalueValues[r16]
                                                        r11 = not r29
                                                        r7 = state
                                                        state = r11 and 109 or 110
                                                        r20 = r11
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 110 then
                                                if state <= 108 then
                                                    if state <= 107 then
                                                        if state == 107 then
                                                            r15 = state
                                                            r26 = upvalueValues[upvalues[2]]
                                                            r31 = upvalueValues[upvalues[3]]
                                                            r32 = "|5\154\129"
                                                            r35 = 12257498324810
                                                            r23 = r31(r32, r35)
                                                            r29 = r26[r23]
                                                            r11 = r7[r29]
                                                            state = r11 and 111 or 112
                                                            r12 = r11
                                                        end
                                                    else
                                                        if state == 108 then
                                                            state = r20 and 113 or 114
                                                        end
                                                    end
                                                else
                                                    if state <= 109 then
                                                        if state == 109 then
                                                            r29 = "isfile"
                                                            r11 = _env[r29]
                                                            r26 = upvalueValues[r36]
                                                            r29 = r11(r26)
                                                            r20 = r29
                                                            state = 110
                                                        end
                                                    else
                                                        if state == 110 then
                                                            state = r7
                                                            state = r20 and 115 or 116
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 112 then
                                                    if state <= 111 then
                                                        if state == 111 then
                                                            r23 = upvalueValues[upvalues[2]]
                                                            r32 = upvalueValues[upvalues[3]]
                                                            r33 = "\029\167\135\251"
                                                            r19 = 21166548817143
                                                            r35 = r32(r33, r19)
                                                            r31 = r23[r35]
                                                            r26 = r7[r31]
                                                            r29 = #r26
                                                            r26 = 0
                                                            r11 = r29 > r26
                                                            r12 = r11
                                                            state = 112
                                                        end
                                                    else
                                                        if state == 112 then
                                                            state = r15
                                                            r20 = r12
                                                            state = 108
                                                        end
                                                    end
                                                else
                                                    if state == 113 then
                                                        r29 = upvalueValues[upvalues[2]]
                                                        r26 = upvalueValues[upvalues[3]]
                                                        r23 = "w\rI?"
                                                        r32 = 20928907472485
                                                        r31 = r26(r23, r32)
                                                        r26 = createClosure4(158, {
                                                            r36,
                                                            upvalues[5],
                                                            r16
                                                        })
                                                        r11 = r29[r31]
                                                        r15 = r7[r11]
                                                        upvalueValues[r16] = r15
                                                        r29 = "pcall"
                                                        r11 = _env[r29]
                                                        r29 = r11(r26)
                                                        state = 114
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 120 then
                                            if state <= 117 then
                                                if state <= 115 then
                                                    if state <= 114 then
                                                        if state == 114 then
                                                            r7 = nil
                                                            r20 = nil
                                                            state = 106
                                                        end
                                                    else
                                                        if state == 115 then
                                                            r20 = upvalueValues[upvalues[5]]
                                                            r29 = "readfile"
                                                            r11 = _env[r29]
                                                            r7 = "JSONDecode"
                                                            r7 = r20[r7]
                                                            r26 = upvalueValues[r36]
                                                            r29 = {
                                                                r11(r26)
                                                            }
                                                            r7 = r7(r20, unpack(r29))
                                                            r20 = true
                                                            upvalueValues[r16] = r7
                                                            r9 = r20
                                                            state = 116
                                                        end
                                                    end
                                                else
                                                    if state <= 116 then
                                                        if state == 116 then
                                                            r11 = upvalueValues[r16]
                                                            state = r11 and 117 or 118
                                                        end
                                                    else
                                                        if state == 117 then
                                                            r26 = "math"
                                                            r29 = _env[r26]
                                                            r31 = upvalueValues[upvalues[2]]
                                                            r23 = upvalueValues[upvalues[3]]
                                                            r35 = "\030\224\208 \165\236\193\t\148\247"
                                                            r33 = 26876350148059
                                                            r32 = r23(r35, r33)
                                                            r26 = r31[r32]
                                                            r11 = r29[r26]
                                                            r23 = "tick"
                                                            r31 = _env[r23]
                                                            r23 = r31()
                                                            r35 = "math"
                                                            r32 = _env[r35]
                                                            r33 = upvalueValues[upvalues[2]]
                                                            r19 = upvalueValues[upvalues[3]]
                                                            r34 = 9132718652790
                                                            r2 = "\234p\172\235w\226"
                                                            r24 = r19(r2, r34)
                                                            r35 = r33[r24]
                                                            r31 = r32[r35]
                                                            r35 = 1
                                                            r33 = 100000
                                                            r32 = r31(r35, r33)
                                                            r26 = r23 + r32
                                                            r29 = r11(r26)
                                                            r11 = {}
                                                            r26 = "ipairs"
                                                            r29 = _env[r26]
                                                            r32 = upvalueValues[r16]
                                                            r35 = {
                                                                r29(r32)
                                                            }
                                                            r23 = r35[3]
                                                            r26 = r35[1]
                                                            r31 = r35[2]
                                                            state = 119
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 119 then
                                                    if state <= 118 then
                                                        if state == 118 then
                                                            r36 = releaseUpvalue(r36)
                                                            ReturnVal = {}
                                                            r16 = releaseUpvalue(r16)
                                                            r1 = nil
                                                            r28 = nil
                                                            r5 = nil
                                                            r18 = nil
                                                            r9 = nil
                                                            r3 = nil
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 119 then
                                                            r23, r32 = r26(r31, r23)
                                                            state = r23 and 120 or 121
                                                        end
                                                    end
                                                else
                                                    if state == 120 then
                                                        r24 = upvalueValues[upvalues[2]]
                                                        r2 = upvalueValues[upvalues[3]]
                                                        r6 = "\247\172"
                                                        r14 = 22099698604530
                                                        r34 = r2(r6, r14)
                                                        r19 = r24[r34]
                                                        r33 = r32[r19]
                                                        r2 = "game"
                                                        r24 = _env[r2]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r6 = upvalueValues[upvalues[3]]
                                                        r4 = "\137UH\202r"
                                                        r21 = 10641762227162
                                                        r14 = r6(r4, r21)
                                                        r2 = r34[r14]
                                                        r19 = r24[r2]
                                                        r35 = r33 ~= r19
                                                        state = r35 and 122 or 123
                                                        r29 = r23
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 124 then
                                                if state <= 122 then
                                                    if state <= 121 then
                                                        if state == 121 then
                                                            r26 = #r11
                                                            r31 = 0
                                                            r29 = r26 > r31
                                                            state = r29 and 124 or 125
                                                        end
                                                    else
                                                        if state == 122 then
                                                            r2 = upvalueValues[upvalues[2]]
                                                            r34 = upvalueValues[upvalues[3]]
                                                            r4 = 28759223051845
                                                            r14 = "v\015\148!&\226W"
                                                            r6 = r34(r14, r4)
                                                            r24 = r2[r6]
                                                            r19 = r32[r24]
                                                            r2 = upvalueValues[upvalues[6]]
                                                            r6 = upvalueValues[upvalues[2]]
                                                            r14 = upvalueValues[upvalues[3]]
                                                            r25 = 25251314194872
                                                            r21 = "\189O\189)\152\166\1987\248p\027\173\238w(@"
                                                            r4 = r14(r21, r25)
                                                            r34 = r6[r4]
                                                            r24 = r2[r34]
                                                            r33 = r19 <= r24
                                                            r35 = r33
                                                            state = 123
                                                        end
                                                    end
                                                else
                                                    if state <= 123 then
                                                        if state == 123 then
                                                            state = r35 and 126 or 127
                                                        end
                                                    else
                                                        if state == 124 then
                                                            r23 = "math"
                                                            r31 = _env[r23]
                                                            r32 = upvalueValues[upvalues[2]]
                                                            r35 = upvalueValues[upvalues[3]]
                                                            r2 = 3585009882161
                                                            r24 = "\139\233\018r\225\247"
                                                            r19 = r35(r24, r2)
                                                            r23 = r32[r19]
                                                            r26 = r31[r23]
                                                            r32 = #r11
                                                            r23 = 1
                                                            r31 = r26(r23, r32)
                                                            r29 = r11[r31]
                                                            r26 = upvalueValues[upvalues[7]]
                                                            r32 = upvalueValues[upvalues[2]]
                                                            r35 = upvalueValues[upvalues[3]]
                                                            r2 = 19172142938628
                                                            r24 = "\175\232\158\196\180\180o'1\145= \178\253\164y\240\134\252\248\205{\213\007\1338\242\197\211L\127xa~gh>\222:S\147\221+&\134\192\162\239\214\026\176g\203\004\192\228\"2\170\221\178qu\176"
                                                            r19 = r35(r24, r2)
                                                            r23 = r32[r19]
                                                            r19 = upvalueValues[upvalues[2]]
                                                            r24 = upvalueValues[upvalues[3]]
                                                            r6 = 14919205667880
                                                            r34 = "e\234*\171\209\165g"
                                                            r2 = r24(r34, r6)
                                                            r35 = r19[r2]
                                                            r32 = r29[r35]
                                                            ReturnVal = {}
                                                            r24 = upvalueValues[upvalues[2]]
                                                            r2 = upvalueValues[upvalues[3]]
                                                            r14 = 3121846495395
                                                            r6 = "\197O"
                                                            r34 = r2(r6, r14)
                                                            r19 = r24[r34]
                                                            r35 = r29[r19]
                                                            r31 = r26(r23, r5, r32, r35, r9, r28)
                                                            r23 = "task"
                                                            r31 = _env[r23]
                                                            r32 = upvalueValues[upvalues[2]]
                                                            r35 = upvalueValues[upvalues[3]]
                                                            r24 = "<s$s"
                                                            r2 = 9610356876755
                                                            r19 = r35(r24, r2)
                                                            r23 = r32[r19]
                                                            r26 = r31[r23]
                                                            r23 = 1
                                                            r31 = r26(r23)
                                                            r31 = "game"
                                                            r26 = _env[r31]
                                                            r32 = upvalueValues[upvalues[2]]
                                                            r31 = "GetService"
                                                            r31 = r26[r31]
                                                            r35 = upvalueValues[upvalues[3]]
                                                            r2 = 7782383664314
                                                            r24 = "65\139\"\210\205\168\249\017KZGZ4\176"
                                                            r19 = r35(r24, r2)
                                                            r23 = r32[r19]
                                                            r31 = r31(r26, r23)
                                                            r35 = "game"
                                                            r32 = _env[r35]
                                                            r19 = upvalueValues[upvalues[2]]
                                                            r24 = upvalueValues[upvalues[3]]
                                                            r6 = 6229968467445
                                                            r34 = "1\008z\2281\209\203"
                                                            r2 = r24(r34, r6)
                                                            r35 = r19[r2]
                                                            r23 = r32[r35]
                                                            r19 = upvalueValues[upvalues[2]]
                                                            r24 = upvalueValues[upvalues[3]]
                                                            r34 = "\146\234"
                                                            r6 = 28868454939828
                                                            r2 = r24(r34, r6)
                                                            r35 = r19[r2]
                                                            r32 = r29[r35]
                                                            r19 = upvalueValues[upvalues[1]]
                                                            r2 = upvalueValues[upvalues[2]]
                                                            r26 = "TeleportToPlaceInstance"
                                                            r26 = r31[r26]
                                                            r34 = upvalueValues[upvalues[3]]
                                                            r4 = 16611153332683
                                                            r14 = "W\224\230\183<\230\131\163{\004\135"
                                                            r6 = r34(r14, r4)
                                                            r24 = r2[r6]
                                                            r35 = r19[r24]
                                                            r26 = r26(r31, r23, r32, r35)
                                                            state = nil
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 126 then
                                                    if state <= 125 then
                                                        if state == 125 then
                                                            r11 = nil
                                                            state = 118
                                                        end
                                                    else
                                                        if state == 126 then
                                                            r2 = "table"
                                                            r24 = _env[r2]
                                                            r34 = upvalueValues[upvalues[2]]
                                                            r6 = upvalueValues[upvalues[3]]
                                                            r21 = 17134632672811
                                                            r4 = ";\195\024\\E\216"
                                                            r14 = r6(r4, r21)
                                                            r2 = r34[r14]
                                                            r19 = r24[r2]
                                                            r24 = r19(r11, r32)
                                                            state = 127
                                                        end
                                                    end
                                                else
                                                    if state == 127 then
                                                        r35 = nil
                                                        r29 = nil
                                                        r32 = nil
                                                        state = 119
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure7 entry 13995981 -> 128, states 128-142
                                if state <= 135 then
                                    if state <= 131 then
                                        if state <= 129 then
                                            if state <= 128 then
                                                if state == 128 then -- entry 13995981 -> 128
                                                    r28 = allocUpvalue()
                                                    r5 = allocUpvalue()
                                                    upvalueValues[r28] = args[1]
                                                    r3 = allocUpvalue()
                                                    upvalueValues[r5] = args[2]
                                                    upvalueValues[r3] = args[3]
                                                    ReturnVal = "syn"
                                                    state = _env[ReturnVal]
                                                    r36 = state
                                                    state = r36 and 129 or 130
                                                end
                                            else
                                                if state == 129 then
                                                    r1 = "syn"
                                                    ReturnVal = _env[r1]
                                                    r16 = upvalueValues[upvalues[1]]
                                                    r9 = upvalueValues[upvalues[2]]
                                                    r20 = "\166z\021\166\236/k"
                                                    r7 = 15223860298167
                                                    r18 = r9(r20, r7)
                                                    r1 = r16[r18]
                                                    state = ReturnVal[r1]
                                                    r36 = state
                                                    state = 130
                                                end
                                            end
                                        else
                                            if state <= 130 then
                                                if state == 130 then
                                                    ReturnVal = not r36
                                                    state = ReturnVal and 131 or 132
                                                end
                                            else
                                                if state == 131 then
                                                    r1 = "http_request"
                                                    ReturnVal = _env[r1]
                                                    r36 = ReturnVal
                                                    r1 = not r36
                                                    state = r1 and 133 or 134
                                                end
                                            end
                                        end
                                    else
                                        if state <= 133 then
                                            if state <= 132 then
                                                if state == 132 then
                                                    state = r36 and 135 or 136
                                                end
                                            else
                                                if state == 133 then
                                                    r16 = "request"
                                                    r1 = _env[r16]
                                                    r36 = r1
                                                    r16 = not r36
                                                    state = r16 and 137 or 138
                                                end
                                            end
                                        else
                                            if state <= 134 then
                                                if state == 134 then
                                                    state = 132
                                                end
                                            else
                                                if state == 135 then
                                                    r7 = upvalueValues[r5]
                                                    r20 = state
                                                    state = r7 and 139 or 140
                                                    r18 = r7
                                                end
                                            end
                                        end
                                    end
                                else
                                    if state <= 139 then
                                        if state <= 137 then
                                            if state <= 136 then
                                                if state == 136 then
                                                    r12 = createClosure3(159, {
                                                        r5,
                                                        upvalues[1],
                                                        upvalues[2],
                                                        upvalues[3],
                                                        r28,
                                                        r3
                                                    })
                                                    r20 = "pcall"
                                                    r18 = _env[r20]
                                                    r15 = {
                                                        r18(r12)
                                                    }
                                                    r20 = r15[1]
                                                    r7 = r15[2]
                                                    r15 = upvalueValues[upvalues[1]]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r26 = "\154\031\243\029\150\140\012"
                                                    r31 = 28789639139387
                                                    r29 = r11(r26, r31)
                                                    r12 = r15[r29]
                                                    r11 = upvalueValues[upvalues[1]]
                                                    r29 = upvalueValues[upvalues[2]]
                                                    r23 = 32606107978090
                                                    r31 = "R\2241\026"
                                                    r26 = r29(r31, r23)
                                                    r15 = r11[r26]
                                                    r18 = {
                                                        [r12] = r20,
                                                        [r15] = r7
                                                    }
                                                    ReturnVal = {
                                                        r18
                                                    }
                                                    state = nil
                                                end
                                            else
                                                if state == 137 then
                                                    r9 = "http"
                                                    r16 = _env[r9]
                                                    r36 = r16
                                                    state = r36 and 141 or 142
                                                end
                                            end
                                        else
                                            if state <= 138 then
                                                if state == 138 then
                                                    state = 134
                                                end
                                            else
                                                if state == 139 then
                                                    state = r20
                                                    r12 = upvalueValues[upvalues[1]]
                                                    r15 = upvalueValues[upvalues[2]]
                                                    r29 = "\2491p\030$\163\134\002\213L]]"
                                                    r26 = 22442819057474
                                                    r11 = r15(r29, r26)
                                                    r7 = r12[r11]
                                                    r15 = upvalueValues[upvalues[1]]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r31 = 11216414332159
                                                    r26 = "\209\020\139*\157\242\143S\235.\194P\159Yl\189"
                                                    r29 = r11(r26, r31)
                                                    r12 = r15[r29]
                                                    r20 = {
                                                        [r7] = r12
                                                    }
                                                    r11 = upvalueValues[upvalues[1]]
                                                    r29 = upvalueValues[upvalues[2]]
                                                    r23 = 16983391139823
                                                    r31 = ">\017\182"
                                                    r26 = r29(r31, r23)
                                                    r15 = r11[r26]
                                                    r11 = upvalueValues[r28]
                                                    r26 = upvalueValues[upvalues[1]]
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r35 = 4983827501272
                                                    r32 = "\218\237\235.\170\209"
                                                    r23 = r31(r32, r35)
                                                    r29 = r26[r23]
                                                    r31 = upvalueValues[upvalues[1]]
                                                    r23 = upvalueValues[upvalues[2]]
                                                    r33 = 10481602577650
                                                    r35 = "\138\"\163\235\023rV"
                                                    r32 = r23(r35, r33)
                                                    r26 = r31[r32]
                                                    r23 = upvalueValues[upvalues[1]]
                                                    r32 = upvalueValues[upvalues[2]]
                                                    r19 = 22987772851262
                                                    r33 = "\208\225\008/"
                                                    r35 = r32(r33, r19)
                                                    r31 = r23[r35]
                                                    r23 = upvalueValues[r3]
                                                    r12 = {
                                                        [r15] = r11,
                                                        [r29] = r18,
                                                        [r26] = r20,
                                                        [r31] = r23
                                                    }
                                                    r7 = {
                                                        r36(r12)
                                                    }
                                                    ReturnVal = {
                                                        unpack(r7)
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        if state <= 141 then
                                            if state <= 140 then
                                                if state == 140 then
                                                    r12 = upvalueValues[upvalues[1]]
                                                    r15 = upvalueValues[upvalues[2]]
                                                    r29 = "\025Y3"
                                                    r26 = 19907362452353
                                                    r11 = r15(r29, r26)
                                                    r7 = r12[r11]
                                                    r18 = r7
                                                    state = 139
                                                end
                                            else
                                                if state == 141 then
                                                    r20 = "http"
                                                    r18 = _env[r20]
                                                    r7 = upvalueValues[upvalues[1]]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r29 = 29900039219005
                                                    r11 = "$U@\141\rTB"
                                                    r15 = r12(r11, r29)
                                                    r20 = r7[r15]
                                                    r9 = r18[r20]
                                                    r36 = r9
                                                    state = 142
                                                end
                                            end
                                        else
                                            if state == 142 then
                                                state = 138
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 147 then
                                -- createClosure2 entry 7795169 -> 143, states 143-147
                                if state <= 145 then
                                    if state <= 144 then
                                        if state <= 143 then
                                            if state == 143 then -- entry 7795169 -> 143
                                                r28 = args[1]
                                                r3 = upvalueValues[upvalues[1]]
                                                r1 = upvalueValues[upvalues[2]]
                                                r16 = upvalueValues[upvalues[3]]
                                                r18 = "\174f\219\221K\182iBT\156"
                                                r20 = 28116961556482
                                                r9 = r16(r18, r20)
                                                r36 = r1[r9]
                                                r5 = r3[r36]
                                                state = r5 and 144 or 145
                                                ReturnVal = r5
                                            end
                                        else
                                            if state == 144 then
                                                r5 = upvalueValues[upvalues[4]]
                                                r3 = r5(r28)
                                                ReturnVal = r3
                                                state = 145
                                            end
                                        end
                                    else
                                        if state == 145 then
                                            state = ReturnVal and 146 or 147
                                        end
                                    end
                                else
                                    if state <= 146 then
                                        if state == 146 then
                                            ReturnVal = "print"
                                            state = _env[ReturnVal]
                                            r36 = upvalueValues[upvalues[2]]
                                            r1 = upvalueValues[upvalues[3]]
                                            r9 = "\221d\210\031\tG\192\200\031\021\186\141\219\186\031e\031\027\2262B|\141\176Y\179lz\219\028\197/\204\004\172\161\167\021>[o\218\006"
                                            r18 = 15421249931765
                                            r16 = r1(r9, r18)
                                            r3 = r36[r16]
                                            r9 = upvalueValues[upvalues[2]]
                                            r18 = upvalueValues[upvalues[3]]
                                            r12 = 26705535132357
                                            r7 = "[#\164L"
                                            r20 = r18(r7, r12)
                                            r16 = r9[r20]
                                            r1 = r28[r16]
                                            r9 = upvalueValues[upvalues[2]]
                                            r18 = upvalueValues[upvalues[3]]
                                            r7 = "O\021\233\242%\005\202\242n&w+\160\234\210\205\"\249/\246\005y\234\247&\008kZT\191\238!D\203!\254E:\241\173\134\244\164'\147\172P\253.\190"
                                            r12 = 10651555083493
                                            r20 = r18(r7, r12)
                                            r16 = r9[r20]
                                            r36 = r1 .. r16
                                            r5 = r3 .. r36
                                            ReturnVal = state(r5)
                                            state = upvalueValues[upvalues[5]]
                                            r3 = upvalueValues[upvalues[2]]
                                            r36 = upvalueValues[upvalues[3]]
                                            r16 = "y\181\166\182d"
                                            r9 = 33004189678755
                                            r1 = r36(r16, r9)
                                            r5 = r3[r1]
                                            ReturnVal = state(r5)
                                            state = 147
                                        end
                                    else
                                        if state == 147 then
                                            r28 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            else
                                -- createClosure3 entry 1334274 -> 148, states 148-155
                                if state <= 151 then
                                    if state <= 149 then
                                        if state <= 148 then
                                            if state == 148 then -- entry 1334274 -> 148
                                                state = 149
                                            end
                                        else
                                            if state == 149 then
                                                r28 = "task"
                                                ReturnVal = _env[r28]
                                                r5 = upvalueValues[upvalues[1]]
                                                r3 = upvalueValues[upvalues[2]]
                                                r16 = 10629284087142
                                                r1 = "\254\240:\161"
                                                r36 = r3(r1, r16)
                                                r28 = r5[r36]
                                                state = ReturnVal[r28]
                                                r28 = 5
                                                ReturnVal = state(r28)
                                                state = ReturnVal and 150 or 151
                                            end
                                        end
                                    else
                                        if state <= 150 then
                                            if state == 150 then
                                                state = upvalueValues[upvalues[3]]
                                                ReturnVal = "GetPlayers"
                                                ReturnVal = state[ReturnVal]
                                                ReturnVal = ReturnVal(state)
                                                r28 = ReturnVal
                                                ReturnVal = "tick"
                                                state = _env[ReturnVal]
                                                r5 = state
                                                state = #r28
                                                r36 = r5()
                                                r1 = upvalueValues[upvalues[4]]
                                                ReturnVal = r36 - r1
                                                r3 = state
                                                r36 = 60
                                                state = ReturnVal / r36
                                                r36 = state
                                                r1 = upvalueValues[upvalues[5]]
                                                r9 = upvalueValues[upvalues[1]]
                                                r18 = upvalueValues[upvalues[2]]
                                                r12 = 26338884479061
                                                r7 = "\185\178\228\224\127p\255\020N\160`1\188\225\132\210\157"
                                                r20 = r18(r7, r12)
                                                r16 = r9[r20]
                                                ReturnVal = r1[r16]
                                                state = r3 > ReturnVal
                                                r1 = state
                                                state = not r1
                                                state = state and 152 or 153
                                            end
                                        else
                                            if state == 151 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    if state <= 153 then
                                        if state <= 152 then
                                            if state == 152 then
                                                r16 = upvalueValues[upvalues[5]]
                                                r18 = upvalueValues[upvalues[1]]
                                                r20 = upvalueValues[upvalues[2]]
                                                r15 = 17709878794397
                                                r12 = "\208\189o\239~\223\000\239\228\169\139\2177\211&%"
                                                r7 = r20(r12, r15)
                                                r9 = r18[r7]
                                                ReturnVal = r16[r9]
                                                state = r36 >= ReturnVal
                                                r1 = state
                                                state = 153
                                            end
                                        else
                                            if state == 153 then
                                                state = r1 and 154 or 155
                                            end
                                        end
                                    else
                                        if state <= 154 then
                                            if state == 154 then
                                                ReturnVal = upvalueValues[upvalues[6]]
                                                r18 = upvalueValues[upvalues[1]]
                                                r20 = upvalueValues[upvalues[2]]
                                                r15 = 28603647477040
                                                r12 = "\220V\153\227mI"
                                                r7 = r20(r12, r15)
                                                r9 = r18[r7]
                                                r16 = ReturnVal(r9)
                                                r9 = "task"
                                                r16 = _env[r9]
                                                r18 = upvalueValues[upvalues[1]]
                                                r20 = upvalueValues[upvalues[2]]
                                                r15 = 34912696561303
                                                r12 = "\\\251{o"
                                                r7 = r20(r12, r15)
                                                r9 = r18[r7]
                                                ReturnVal = r16[r9]
                                                r9 = 10
                                                r16 = ReturnVal(r9)
                                                state = 155
                                            end
                                        else
                                            if state == 155 then
                                                r1 = nil
                                                r36 = nil
                                                r3 = nil
                                                r5 = nil
                                                r28 = nil
                                                state = 149
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 157 then
                            if state <= 156 then
                                -- createClosure1 entry 10966548 -> 156, states 156-156
                                if state == 156 then -- entry 10966548 -> 156
                                    r5 = "Zqi"
                                    r3 = 10382352
                                    r28 = r5 ^ r3
                                    ReturnVal = 3606072
                                    state = ReturnVal - r28
                                    r28 = state
                                    ReturnVal = "qvgccvr"
                                    state = ReturnVal / r28
                                    ReturnVal = {
                                        state
                                    }
                                    state = nil
                                end
                            else
                                -- createClosure2 entry 5478058 -> 157, states 157-157
                                if state == 157 then -- entry 5478058 -> 157
                                    state = upvalueValues[upvalues[1]]
                                    r5 = upvalueValues[upvalues[2]]
                                    r36 = upvalueValues[upvalues[3]]
                                    r1 = upvalueValues[upvalues[4]]
                                    r18 = 20574517110243
                                    r9 = "\156e\211-\214\195\023"
                                    r16 = r1(r9, r18)
                                    r3 = r36[r16]
                                    r28 = r5[r3]
                                    r5 = "GetRankInGroup"
                                    r5 = state[r5]
                                    ReturnVal = {
                                        r5(state, r28)
                                    }
                                    ReturnVal = {
                                        unpack(ReturnVal)
                                    }
                                    state = nil
                                end
                            end
                        else
                            if state <= 158 then
                                -- createClosure4 entry 10795198 -> 158, states 158-158
                                if state == 158 then -- entry 10795198 -> 158
                                    ReturnVal = "writefile"
                                    state = _env[ReturnVal]
                                    r28 = upvalueValues[upvalues[1]]
                                    r5 = upvalueValues[upvalues[2]]
                                    r36 = upvalueValues[upvalues[3]]
                                    r1 = "JSONEncode"
                                    r1 = r5[r1]
                                    r3 = {
                                        r1(r5, r36)
                                    }
                                    ReturnVal = state(r28, unpack(r3))
                                    ReturnVal = {}
                                    state = nil
                                end
                            else
                                -- createClosure3 entry 3304155 -> 159, states 159-163
                                if state <= 161 then
                                    if state <= 160 then
                                        if state <= 159 then
                                            if state == 159 then -- entry 3304155 -> 159
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r5 = upvalueValues[upvalues[2]]
                                                r3 = upvalueValues[upvalues[3]]
                                                r16 = 30365842022460
                                                r1 = "7\194\209+"
                                                r36 = r3(r1, r16)
                                                r28 = r5[r36]
                                                state = ReturnVal == r28
                                                r28 = state
                                                state = r28 and 160 or 161
                                            end
                                        else
                                            if state == 160 then
                                                state = upvalueValues[upvalues[4]]
                                                ReturnVal = "PostAsync"
                                                ReturnVal = state[ReturnVal]
                                                r5 = upvalueValues[upvalues[5]]
                                                r3 = upvalueValues[upvalues[6]]
                                                ReturnVal = ReturnVal(state, r5, r3)
                                                r28 = ReturnVal
                                                state = 161
                                            end
                                        end
                                    else
                                        if state == 161 then
                                            state = not r28
                                            state = state and 162 or 163
                                        end
                                    end
                                else
                                    if state <= 162 then
                                        if state == 162 then
                                            r5 = "game"
                                            state = _env[r5]
                                            r3 = upvalueValues[upvalues[5]]
                                            r5 = "HttpGet"
                                            r5 = state[r5]
                                            r5 = r5(state, r3)
                                            r28 = r5
                                            state = 163
                                        end
                                    else
                                        if state == 163 then
                                            ReturnVal = {
                                                r28
                                            }
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 2452321
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 2452321
                    end
                })
            end
        end
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        createClosure = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(...)
                return vm(entryId, {
                    ...
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
        upvalueValues = {}
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
                upvalueRefCounts[upvalueId], captureIndex = upvalueRefCounts[upvalueId] - (1), captureIndex + (1)
                if upvalueRefCounts[upvalueId] == 0 then
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