return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createUpvalueProxy, vm, createClosure, createClosure7, createClosure4, releaseUpvalues, createClosure1, createClosure3, createClosure5, releaseUpvalue, currentUpvalueId, createClosure0, createClosure2, createClosure6, allocUpvalue, upvalueRefCounts, upvalueValues)
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
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
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
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        upvalueRefCounts = {}
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, ReturnVal, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43
            while state do
                if state <= 91 then
                    if state <= 50 then
                        if state <= 33 then
                            if state <= 32 then
                                if state <= 31 then
                                    -- root entry 8358696 -> 1, states 1-31
                                    if state <= 16 then
                                        if state <= 8 then
                                            if state <= 4 then
                                                if state <= 2 then
                                                    if state <= 1 then
                                                        if state == 1 then -- entry 8358696 -> 1
                                                            r10 = allocUpvalue()
                                                            state = true
                                                            upvalueValues[r10] = state
                                                            r1 = allocUpvalue()
                                                            r33 = "string"
                                                            ReturnVal = _env[r33]
                                                            r23 = allocUpvalue()
                                                            r33 = "gmatch"
                                                            state = ReturnVal[r33]
                                                            r33 = allocUpvalue()
                                                            upvalueValues[r33] = state
                                                            state = createClosure3(32, {})
                                                            upvalueValues[r23] = state
                                                            state = false
                                                            upvalueValues[r1] = state
                                                            r4 = "pcall"
                                                            r9 = _env[r4]
                                                            r18 = createClosure3(33, {
                                                                r1
                                                            })
                                                            r4 = r9(r18)
                                                            state = r4 and (2) or (3)
                                                            r30 = args
                                                            ReturnVal = r4
                                                        end
                                                    else
                                                        if state == 2 then
                                                            r9 = upvalueValues[r1]
                                                            ReturnVal = r9
                                                            state = 3
                                                        end
                                                    end
                                                else
                                                    if state <= 3 then
                                                        if state == 3 then
                                                            r9 = ReturnVal
                                                            r4 = "math"
                                                            ReturnVal = _env[r4]
                                                            r4 = "random"
                                                            state = ReturnVal[r4]
                                                            r4 = allocUpvalue()
                                                            upvalueValues[r4] = state
                                                            r18 = "table"
                                                            ReturnVal = _env[r18]
                                                            r18 = "concat"
                                                            state = ReturnVal[r18]
                                                            r39 = state
                                                            r18 = state
                                                            r5 = "table"
                                                            r41 = _env[r5]
                                                            state = r41 and (4) or (5)
                                                            r35 = r41
                                                        end
                                                    else
                                                        if state == 4 then
                                                            r31 = "table"
                                                            r5 = _env[r31]
                                                            r31 = "unpack"
                                                            r41 = r5[r31]
                                                            r35 = r41
                                                            state = 5
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 6 then
                                                    if state <= 5 then
                                                        if state == 5 then
                                                            state = r39
                                                            state = r35 and (6) or (7)
                                                            ReturnVal = r35
                                                        end
                                                    else
                                                        if state == 6 then
                                                            r35 = allocUpvalue()
                                                            upvalueValues[r35] = ReturnVal
                                                            state = upvalueValues[r4]
                                                            r39 = 3
                                                            r41 = 65
                                                            ReturnVal = state(r39, r41)
                                                            r13 = createClosure5(34, {})
                                                            r39 = allocUpvalue()
                                                            upvalueValues[r39] = ReturnVal
                                                            state = 0
                                                            r31 = "pcall"
                                                            ReturnVal = _env[r31]
                                                            r31 = {
                                                                ReturnVal(r13)
                                                            }
                                                            r41 = state
                                                            state = 0
                                                            r5 = state
                                                            state = {
                                                                unpack(r31)
                                                            }
                                                            r31 = state
                                                            ReturnVal = 2
                                                            state = r31[ReturnVal]
                                                            r13 = state
                                                            ReturnVal = "tonumber"
                                                            state = _env[ReturnVal]
                                                            r11 = upvalueValues[r33]
                                                            r8 = "tostring"
                                                            r36 = _env[r8]
                                                            r8 = r36(r13)
                                                            r36 = ":(%d*):"
                                                            r34 = r11(r8, r36)
                                                            r11 = {
                                                                r34()
                                                            }
                                                            ReturnVal = state(unpack(r11))
                                                            r11 = allocUpvalue()
                                                            upvalueValues[r11] = ReturnVal
                                                            r34 = upvalueValues[r39]
                                                            r36 = r34
                                                            r34 = 1
                                                            r8 = r34
                                                            r34 = 0
                                                            r17 = r8 < r34
                                                            ReturnVal = 1
                                                            r34 = ReturnVal - r8
                                                            state = 8
                                                        end
                                                    end
                                                else
                                                    if state <= 7 then
                                                        if state == 7 then
                                                            r39 = "unpack"
                                                            r35 = _env[r39]
                                                            ReturnVal = r35
                                                            state = 6
                                                        end
                                                    else
                                                        if state == 8 then
                                                            r34 = r34 + r8
                                                            ReturnVal = r34 <= r36
                                                            r24 = not r17
                                                            ReturnVal = r24 and ReturnVal
                                                            r24 = r34 >= r36
                                                            r24 = r17 and r24
                                                            ReturnVal = r24 or ReturnVal
                                                            r24 = (9)
                                                            state = ReturnVal and r24
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
                                                            r24 = allocUpvalue()
                                                            upvalueValues[r24] = r34
                                                            r2 = "math"
                                                            ReturnVal = _env[r2]
                                                            r2 = "random"
                                                            state = ReturnVal[r2]
                                                            r6 = 100
                                                            r2 = 1
                                                            ReturnVal = state(r2, r6)
                                                            r2 = allocUpvalue()
                                                            upvalueValues[r2] = ReturnVal
                                                            state = upvalueValues[r4]
                                                            r43 = 255
                                                            r6 = 0
                                                            ReturnVal = state(r6, r43)
                                                            r6 = allocUpvalue()
                                                            upvalueValues[r6] = ReturnVal
                                                            state = upvalueValues[r4]
                                                            r27 = upvalueValues[r2]
                                                            r43 = 1
                                                            ReturnVal = state(r43, r27)
                                                            r43 = allocUpvalue()
                                                            upvalueValues[r43] = ReturnVal
                                                            ReturnVal = upvalueValues[r4]
                                                            r22 = 1
                                                            r32 = 2
                                                            r27 = ReturnVal(r22, r32)
                                                            ReturnVal = 1
                                                            state = r27 == ReturnVal
                                                            r27 = allocUpvalue()
                                                            upvalueValues[r27] = state
                                                            r26 = "tostring"
                                                            r16 = _env[r26]
                                                            r12 = upvalueValues[r4]
                                                            r29 = 10000
                                                            r21 = 0
                                                            r38 = {
                                                                r12(r21, r29)
                                                            }
                                                            r26 = r16(unpack(r38))
                                                            state = "gsub"
                                                            state = r13[state]
                                                            r16 = ":"
                                                            r28 = r26 .. r16
                                                            r32 = ":"
                                                            r22 = r32 .. r28
                                                            ReturnVal = ":(%d*):"
                                                            state = state(r13, ReturnVal, r22)
                                                            r22 = allocUpvalue()
                                                            r28 = createClosure3(35, {
                                                                r4,
                                                                r24,
                                                                r39,
                                                                r33,
                                                                r10,
                                                                r11,
                                                                r27,
                                                                r22,
                                                                r2,
                                                                r43,
                                                                r6,
                                                                r35
                                                            })
                                                            upvalueValues[r22] = state
                                                            r32 = "pcall"
                                                            ReturnVal = _env[r32]
                                                            r32 = {
                                                                ReturnVal(r28)
                                                            }
                                                            state = {
                                                                unpack(r32)
                                                            }
                                                            r32 = state
                                                            state = upvalueValues[r27]
                                                            state = state and (11) or (12)
                                                        end
                                                    else
                                                        if state == 10 then
                                                            r36 = upvalueValues[r10]
                                                            state = r36 and (13) or (14)
                                                            r34 = r36
                                                        end
                                                    end
                                                else
                                                    if state <= 11 then
                                                        if state == 11 then
                                                            r28 = upvalueValues[r10]
                                                            state = r28 and (15) or (16)
                                                            ReturnVal = r28
                                                        end
                                                    else
                                                        if state == 12 then
                                                            r16 = upvalueValues[r10]
                                                            state = r16 and (17) or (18)
                                                            r28 = r16
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 14 then
                                                    if state <= 13 then
                                                        if state == 13 then
                                                            r36 = r41 == r5
                                                            r34 = r36
                                                            state = 14
                                                        end
                                                    else
                                                        if state == 14 then
                                                            upvalueValues[r10] = r34
                                                            state = upvalueValues[r10]
                                                            state = state and (19) or (20)
                                                        end
                                                    end
                                                else
                                                    if state <= 15 then
                                                        if state == 15 then
                                                            r16 = state
                                                            r38 = 1
                                                            r12 = r32[r38]
                                                            r38 = false
                                                            r26 = r12 == r38
                                                            state = r26 and (21) or (22)
                                                            r28 = r26
                                                        end
                                                    else
                                                        if state == 16 then
                                                            upvalueValues[r10] = ReturnVal
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
                                                            r26 = 1
                                                            r16 = r32[r26]
                                                            r28 = r16
                                                            state = 18
                                                        end
                                                    else
                                                        if state == 18 then
                                                            upvalueValues[r10] = r28
                                                            r38 = upvalueValues[r43]
                                                            r21 = 1
                                                            r12 = r38 + r21
                                                            r26 = r32[r12]
                                                            r16 = r41 + r26
                                                            r26 = 256
                                                            state = r16 % r26
                                                            r41 = state
                                                            r12 = upvalueValues[r6]
                                                            r26 = r5 + r12
                                                            r12 = 256
                                                            r16 = r26 % r12
                                                            r5 = r16
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
                                                            r38 = 2
                                                            r12 = r32[r38]
                                                            r38 = upvalueValues[r22]
                                                            r26 = r12 == r38
                                                            r28 = r26
                                                            state = 22
                                                        end
                                                    else
                                                        if state == 22 then
                                                            state = r16
                                                            ReturnVal = r28
                                                            state = 16
                                                        end
                                                    end
                                                else
                                                    if state <= 23 then
                                                        if state == 23 then
                                                            r24 = releaseUpvalue(r24)
                                                            r43 = releaseUpvalue(r43)
                                                            r6 = releaseUpvalue(r6)
                                                            r2 = releaseUpvalue(r2)
                                                            r27 = releaseUpvalue(r27)
                                                            r32 = nil
                                                            r22 = releaseUpvalue(r22)
                                                            state = 8
                                                        end
                                                    else
                                                        if state == 24 then
                                                            r4 = releaseUpvalue(r4)
                                                            r33 = releaseUpvalue(r33)
                                                            r10 = releaseUpvalue(r10)
                                                            r11 = releaseUpvalue(r11)
                                                            r23 = releaseUpvalue(r23)
                                                            r23 = allocUpvalue()
                                                            r1 = releaseUpvalue(r1)
                                                            r35 = releaseUpvalue(r35)
                                                            r39 = releaseUpvalue(r39)
                                                            r41 = nil
                                                            r41 = {}
                                                            r10 = nil
                                                            upvalueValues[r23] = r10
                                                            r10 = allocUpvalue()
                                                            r33 = nil
                                                            upvalueValues[r10] = r33
                                                            r31 = nil
                                                            r31 = {}
                                                            r9 = nil
                                                            r9 = "math"
                                                            r1 = _env[r9]
                                                            r9 = "floor"
                                                            r33 = r1[r9]
                                                            r1 = allocUpvalue()
                                                            upvalueValues[r1] = r33
                                                            r4 = "math"
                                                            r9 = _env[r4]
                                                            r4 = "random"
                                                            r33 = r9[r4]
                                                            r18 = nil
                                                            r18 = "table"
                                                            r4 = _env[r18]
                                                            r18 = "remove"
                                                            r9 = r4[r18]
                                                            r35 = "string"
                                                            r18 = _env[r35]
                                                            r35 = "char"
                                                            r4 = r18[r35]
                                                            r39 = allocUpvalue()
                                                            r35 = allocUpvalue()
                                                            r11 = 256
                                                            r18 = 0
                                                            upvalueValues[r35] = r18
                                                            r18 = 2
                                                            upvalueValues[r39] = r18
                                                            r17 = r11
                                                            r11 = 1
                                                            r18 = {}
                                                            r5 = nil
                                                            r5 = allocUpvalue()
                                                            upvalueValues[r5] = r41
                                                            r24 = r11
                                                            r11 = 0
                                                            r2 = r24 < r11
                                                            r13 = nil
                                                            r13 = 1
                                                            r11 = r13 - r24
                                                            r41 = 0
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
                                                                r23
                                                            })
                                                            r36 = {
                                                                state()
                                                            }
                                                            ReturnVal = {
                                                                unpack(r36)
                                                            }
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 26 then
                                                            r11 = r11 + r24
                                                            r13 = r11 <= r17
                                                            r6 = not r2
                                                            r13 = r6 and r13
                                                            r6 = r11 >= r17
                                                            r6 = r2 and r6
                                                            r13 = r6 or r13
                                                            r6 = (27)
                                                            state = r13 and r6
                                                            r13 = (28)
                                                            state = state or r13
                                                        end
                                                    end
                                                else
                                                    if state <= 27 then
                                                        if state == 27 then
                                                            r13 = r11
                                                            r6 = r13
                                                            r31[r13] = r6
                                                            r13 = nil
                                                            state = 26
                                                        end
                                                    else
                                                        if state == 28 then
                                                            r11 = #r31
                                                            r17 = 0
                                                            r13 = r11 == r17
                                                            state = 29
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 30 then
                                                    if state <= 29 then
                                                        if state == 29 then
                                                            r17 = #r31
                                                            r11 = 1
                                                            r13 = r33(r11, r17)
                                                            r11 = r9(r31, r13)
                                                            r17 = upvalueValues[r5]
                                                            r6 = 1
                                                            r2 = r11 - r6
                                                            r24 = r4(r2)
                                                            r17[r11] = r24
                                                            r11 = nil
                                                            r13 = nil
                                                            state = 30
                                                        end
                                                    else
                                                        if state == 30 then
                                                            r11 = #r31
                                                            r17 = 0
                                                            r13 = r11 == r17
                                                            state = r13 and (31) or (29)
                                                        end
                                                    end
                                                else
                                                    if state == 31 then
                                                        r11 = allocUpvalue()
                                                        r13 = {}
                                                        r27 = "__index"
                                                        r6 = {}
                                                        r24 = allocUpvalue()
                                                        r17 = createClosure0(51, {
                                                            r11,
                                                            r35,
                                                            r39,
                                                            r1
                                                        })
                                                        r41 = nil
                                                        upvalueValues[r11] = r13
                                                        r13 = allocUpvalue()
                                                        upvalueValues[r13] = r17
                                                        r17 = {}
                                                        upvalueValues[r24] = r17
                                                        r2 = "setmetatable"
                                                        r17 = _env[r2]
                                                        r1 = releaseUpvalue(r1)
                                                        r22 = upvalueValues[r24]
                                                        r32 = "__metatable"
                                                        r26 = nil
                                                        r43 = {
                                                            [r27] = r22,
                                                            [r32] = r26
                                                        }
                                                        r2 = r17(r6, r43)
                                                        r17 = createClosure6(57, {
                                                            r24,
                                                            r11,
                                                            r5,
                                                            r35,
                                                            r39,
                                                            r13
                                                        })
                                                        upvalueValues[r23] = r2
                                                        r35 = releaseUpvalue(r35)
                                                        upvalueValues[r10] = r17
                                                        r1 = "game"
                                                        r41 = 17467970428870
                                                        r24 = releaseUpvalue(r24)
                                                        r11 = releaseUpvalue(r11)
                                                        r13 = releaseUpvalue(r13)
                                                        r5 = releaseUpvalue(r5)
                                                        r39 = releaseUpvalue(r39)
                                                        r33 = nil
                                                        r33 = _env[r1]
                                                        r6 = "\173\237\199"
                                                        r4 = nil
                                                        r4 = upvalueValues[r23]
                                                        r18 = nil
                                                        r18 = upvalueValues[r10]
                                                        r39 = "\183\165\247Uc\200&\204>+="
                                                        r35 = r18(r39, r41)
                                                        r9 = nil
                                                        r9 = r4[r35]
                                                        r17 = "\135HJ p\153\162M\207"
                                                        r1 = "GetService"
                                                        r1 = r33[r1]
                                                        r1 = r1(r33, r9)
                                                        r33 = allocUpvalue()
                                                        upvalueValues[r33] = r1
                                                        r18 = "game"
                                                        r4 = _env[r18]
                                                        r35 = upvalueValues[r23]
                                                        r39 = upvalueValues[r10]
                                                        r31 = nil
                                                        r31 = 6684362099752
                                                        r5 = "\167\146\166\247A\215;"
                                                        r41 = r39(r5, r31)
                                                        r18 = r35[r41]
                                                        r9 = r4[r18]
                                                        r18 = upvalueValues[r23]
                                                        r35 = upvalueValues[r10]
                                                        r41 = "\154\2365\247K\n\202\0263\202\208"
                                                        r5 = 33216924777579
                                                        r39 = r35(r41, r5)
                                                        r4 = r18[r39]
                                                        r1 = r9[r4]
                                                        r4 = createClosure4(64, {
                                                            r23,
                                                            r10
                                                        })
                                                        r9 = allocUpvalue()
                                                        r13 = "K\235\004"
                                                        upvalueValues[r9] = r4
                                                        r18 = createClosure4(75, {
                                                            r9,
                                                            r23,
                                                            r10
                                                        })
                                                        r4 = allocUpvalue()
                                                        upvalueValues[r4] = r18
                                                        r39 = "Instance"
                                                        r35 = _env[r39]
                                                        r41 = upvalueValues[r23]
                                                        r5 = upvalueValues[r10]
                                                        r11 = 5843256904352
                                                        r31 = r5(r13, r11)
                                                        r39 = r41[r31]
                                                        r13 = "U$+V\028\158\023\166\202"
                                                        r18 = r35[r39]
                                                        r41 = upvalueValues[r23]
                                                        r5 = upvalueValues[r10]
                                                        r11 = 3363050030622
                                                        r31 = r5(r13, r11)
                                                        r39 = r41[r31]
                                                        r31 = upvalueValues[r23]
                                                        r22 = "\200^\183\236\026\1626\203\184\140\255\"\167b\025"
                                                        r13 = upvalueValues[r10]
                                                        r24 = 23913073798015
                                                        r11 = r13(r17, r24)
                                                        r5 = r31[r11]
                                                        r13 = "\\W\\\184"
                                                        r31 = "WaitForChild"
                                                        r31 = r1[r31]
                                                        r41 = {
                                                            r31(r1, r5)
                                                        }
                                                        r17 = 3416465131062
                                                        r35 = r18(r39, unpack(r41))
                                                        r18 = allocUpvalue()
                                                        upvalueValues[r18] = r35
                                                        r35 = upvalueValues[r18]
                                                        r41 = upvalueValues[r23]
                                                        r43 = 22199623231585
                                                        r5 = upvalueValues[r10]
                                                        r11 = 25334574640661
                                                        r31 = r5(r13, r11)
                                                        r39 = r41[r31]
                                                        r5 = upvalueValues[r23]
                                                        r31 = upvalueValues[r10]
                                                        r11 = "\205\239F4"
                                                        r13 = r31(r11, r17)
                                                        r41 = r5[r13]
                                                        r35[r39] = r41
                                                        r41 = "Instance"
                                                        r39 = _env[r41]
                                                        r5 = upvalueValues[r23]
                                                        r17 = 8628557991857
                                                        r31 = upvalueValues[r10]
                                                        r11 = "k\250\162"
                                                        r13 = r31(r11, r17)
                                                        r41 = r5[r13]
                                                        r35 = r39[r41]
                                                        r32 = 12385380406919
                                                        r17 = 16853269667495
                                                        r5 = upvalueValues[r23]
                                                        r31 = upvalueValues[r10]
                                                        r11 = "\237\186\019\250~"
                                                        r13 = r31(r11, r17)
                                                        r41 = r5[r13]
                                                        r5 = upvalueValues[r18]
                                                        r39 = r35(r41, r5)
                                                        r35 = allocUpvalue()
                                                        upvalueValues[r35] = r39
                                                        r39 = upvalueValues[r35]
                                                        r5 = upvalueValues[r23]
                                                        r17 = 31730581223863
                                                        r31 = upvalueValues[r10]
                                                        r11 = "\212.g\216"
                                                        r13 = r31(r11, r17)
                                                        r41 = r5[r13]
                                                        r13 = "UDim2"
                                                        r31 = _env[r13]
                                                        r11 = upvalueValues[r23]
                                                        r17 = upvalueValues[r10]
                                                        r24 = r17(r6, r43)
                                                        r17 = 0
                                                        r13 = r11[r24]
                                                        r5 = r31[r13]
                                                        r13 = 0
                                                        r24 = 450
                                                        r11 = 380
                                                        r31 = r5(r13, r11, r17, r24)
                                                        r39[r41] = r31
                                                        r39 = upvalueValues[r35]
                                                        r5 = upvalueValues[r23]
                                                        r31 = upvalueValues[r10]
                                                        r17 = 9453764333874
                                                        r11 = "\195\254R\170\031\241\191\006"
                                                        r13 = r31(r11, r17)
                                                        r6 = "\169[\207"
                                                        r41 = r5[r13]
                                                        r13 = "UDim2"
                                                        r43 = 15590951427164
                                                        r31 = _env[r13]
                                                        r11 = upvalueValues[r23]
                                                        r17 = upvalueValues[r10]
                                                        r24 = r17(r6, r43)
                                                        r13 = r11[r24]
                                                        r5 = r31[r13]
                                                        r11 = -190
                                                        r6 = "e9\145\139\186\173\159"
                                                        r43 = 934127485362
                                                        r13 = 0.5
                                                        r17 = 0.5
                                                        r24 = -225
                                                        r31 = r5(r13, r11, r17, r24)
                                                        r39[r41] = r31
                                                        r39 = upvalueValues[r35]
                                                        r5 = upvalueValues[r23]
                                                        r31 = upvalueValues[r10]
                                                        r17 = 11646278735151
                                                        r11 = "h4\156\229\220/\150+\152n2\219\169T\254P"
                                                        r13 = r31(r11, r17)
                                                        r41 = r5[r13]
                                                        r13 = "Color3"
                                                        r31 = _env[r13]
                                                        r11 = upvalueValues[r23]
                                                        r17 = upvalueValues[r10]
                                                        r24 = r17(r6, r43)
                                                        r13 = r11[r24]
                                                        r5 = r31[r13]
                                                        r17 = 255
                                                        r13 = 255
                                                        r11 = 255
                                                        r31 = r5(r13, r11, r17)
                                                        r39[r41] = r31
                                                        r17 = 11098213602352
                                                        r39 = upvalueValues[r35]
                                                        r5 = upvalueValues[r23]
                                                        r31 = upvalueValues[r10]
                                                        r11 = "\000\242\137;\004\195\188!\221:\219\184a\243T"
                                                        r13 = r31(r11, r17)
                                                        r41 = r5[r13]
                                                        r17 = 6511522679768
                                                        r5 = 0
                                                        r39[r41] = r5
                                                        r39 = upvalueValues[r35]
                                                        r5 = upvalueValues[r23]
                                                        r31 = upvalueValues[r10]
                                                        r11 = "\166\231\225\161B\158"
                                                        r13 = r31(r11, r17)
                                                        r41 = r5[r13]
                                                        r5 = true
                                                        r39[r41] = r5
                                                        r39 = upvalueValues[r35]
                                                        r5 = upvalueValues[r23]
                                                        r17 = 15601737391201
                                                        r31 = upvalueValues[r10]
                                                        r11 = "\"\197b 8\022*(\194"
                                                        r13 = r31(r11, r17)
                                                        r41 = r5[r13]
                                                        r5 = true
                                                        r39[r41] = r5
                                                        r5 = "Instance"
                                                        r41 = _env[r5]
                                                        r31 = upvalueValues[r23]
                                                        r17 = "\017/\167"
                                                        r13 = upvalueValues[r10]
                                                        r43 = 25621562764954
                                                        r24 = 8153592336084
                                                        r11 = r13(r17, r24)
                                                        r5 = r31[r11]
                                                        r39 = r41[r5]
                                                        r31 = upvalueValues[r23]
                                                        r6 = "\250\225\001"
                                                        r13 = upvalueValues[r10]
                                                        r17 = "\176\156\140,?\182\027\161"
                                                        r24 = 27945495163605
                                                        r11 = r13(r17, r24)
                                                        r5 = r31[r11]
                                                        r31 = upvalueValues[r35]
                                                        r41 = r39(r5, r31)
                                                        r5 = upvalueValues[r23]
                                                        r17 = 9693068022177
                                                        r31 = upvalueValues[r10]
                                                        r11 = "\"\232#\018\177F\192\240\023\194\2408"
                                                        r13 = r31(r11, r17)
                                                        r39 = r5[r13]
                                                        r13 = "UDim"
                                                        r31 = _env[r13]
                                                        r11 = upvalueValues[r23]
                                                        r17 = upvalueValues[r10]
                                                        r24 = r17(r6, r43)
                                                        r13 = r11[r24]
                                                        r5 = r31[r13]
                                                        r6 = 34629857279741
                                                        r13 = 0
                                                        r11 = 20
                                                        r31 = r5(r13, r11)
                                                        r41[r39] = r31
                                                        r31 = "Instance"
                                                        r5 = _env[r31]
                                                        r13 = upvalueValues[r23]
                                                        r11 = upvalueValues[r10]
                                                        r24 = "\167\207\130"
                                                        r17 = r11(r24, r6)
                                                        r31 = r13[r17]
                                                        r39 = r5[r31]
                                                        r6 = 7725620694541
                                                        r13 = upvalueValues[r23]
                                                        r11 = upvalueValues[r10]
                                                        r24 = "\212_\249x7\236\218Z"
                                                        r17 = r11(r24, r6)
                                                        r31 = r13[r17]
                                                        r13 = upvalueValues[r35]
                                                        r6 = 10336410833613
                                                        r5 = r39(r31, r13)
                                                        r39 = allocUpvalue()
                                                        upvalueValues[r39] = r5
                                                        r5 = upvalueValues[r39]
                                                        r13 = upvalueValues[r23]
                                                        r11 = upvalueValues[r10]
                                                        r24 = "\244\152\207l$\026B\224\239"
                                                        r17 = r11(r24, r6)
                                                        r31 = r13[r17]
                                                        r6 = 8842599026709
                                                        r13 = 6
                                                        r5[r31] = r13
                                                        r5 = upvalueValues[r39]
                                                        r13 = upvalueValues[r23]
                                                        r11 = upvalueValues[r10]
                                                        r24 = "\175y\182\2532\216(\154{Ga5+\031Q"
                                                        r17 = r11(r24, r6)
                                                        r31 = r13[r17]
                                                        r24 = "Enum"
                                                        r17 = _env[r24]
                                                        r6 = upvalueValues[r23]
                                                        r43 = upvalueValues[r10]
                                                        r27 = r43(r22, r32)
                                                        r26 = 16232607604102
                                                        r32 = 6927841725594
                                                        r24 = r6[r27]
                                                        r11 = r17[r24]
                                                        r27 = "h\236j\228\175\216"
                                                        r24 = upvalueValues[r23]
                                                        r6 = upvalueValues[r10]
                                                        r22 = 22467272419550
                                                        r43 = r6(r27, r22)
                                                        r17 = r24[r43]
                                                        r13 = r11[r17]
                                                        r5[r31] = r13
                                                        r5 = upvalueValues[r39]
                                                        r13 = upvalueValues[r23]
                                                        r6 = 21682110408560
                                                        r27 = "\007\015\185\158$\147k"
                                                        r11 = upvalueValues[r10]
                                                        r24 = "\222\158\240\211\143"
                                                        r17 = r11(r24, r6)
                                                        r31 = r13[r17]
                                                        r17 = "Color3"
                                                        r11 = _env[r17]
                                                        r24 = upvalueValues[r23]
                                                        r22 = 27266031661464
                                                        r6 = upvalueValues[r10]
                                                        r43 = r6(r27, r22)
                                                        r17 = r24[r43]
                                                        r13 = r11[r17]
                                                        r17 = 85
                                                        r6 = 255
                                                        r24 = 170
                                                        r11 = r13(r17, r24, r6)
                                                        r5[r31] = r11
                                                        r5 = upvalueValues[r39]
                                                        r6 = 1084584821241
                                                        r13 = upvalueValues[r23]
                                                        r27 = 12869557573480
                                                        r11 = upvalueValues[r10]
                                                        r24 = ";\204\003\199\012b\1945\188\021\170\219"
                                                        r17 = r11(r24, r6)
                                                        r31 = r13[r17]
                                                        r13 = 0
                                                        r43 = "\197\253\008=\166\141x"
                                                        r5[r31] = r13
                                                        r11 = "Color3"
                                                        r13 = _env[r11]
                                                        r17 = upvalueValues[r23]
                                                        r24 = upvalueValues[r10]
                                                        r22 = 8942008815683
                                                        r6 = r24(r43, r27)
                                                        r27 = "\205\238\178\145?\210d"
                                                        r11 = r17[r6]
                                                        r17 = 170
                                                        r31 = r13[r11]
                                                        r24 = 255
                                                        r11 = 85
                                                        r13 = r31(r11, r17, r24)
                                                        r17 = "Color3"
                                                        r11 = _env[r17]
                                                        r24 = upvalueValues[r23]
                                                        r6 = upvalueValues[r10]
                                                        r43 = r6(r27, r22)
                                                        r17 = r24[r43]
                                                        r22 = "\161\127l\234\187\1698"
                                                        r6 = 219
                                                        r31 = r11[r17]
                                                        r17 = 52
                                                        r24 = 152
                                                        r11 = r31(r17, r24, r6)
                                                        r24 = "Color3"
                                                        r17 = _env[r24]
                                                        r6 = upvalueValues[r23]
                                                        r43 = upvalueValues[r10]
                                                        r27 = r43(r22, r32)
                                                        r24 = r6[r27]
                                                        r31 = r17[r24]
                                                        r43 = 237
                                                        r6 = 149
                                                        r24 = 100
                                                        r17 = r31(r24, r6, r43)
                                                        r6 = "Color3"
                                                        r24 = _env[r6]
                                                        r43 = upvalueValues[r23]
                                                        r27 = upvalueValues[r10]
                                                        r32 = "\127\1615\201\138S\014"
                                                        r38 = 32262416366255
                                                        r22 = r27(r32, r26)
                                                        r6 = r43[r22]
                                                        r31 = r24[r6]
                                                        r27 = 230
                                                        r26 = "\221\213\162\221A\211\022"
                                                        r43 = 216
                                                        r6 = 173
                                                        r24 = r31(r6, r43, r27)
                                                        r43 = "Color3"
                                                        r6 = _env[r43]
                                                        r27 = upvalueValues[r23]
                                                        r22 = upvalueValues[r10]
                                                        r12 = 32855082613699
                                                        r32 = r22(r26, r12)
                                                        r43 = r27[r32]
                                                        r22 = 255
                                                        r27 = 191
                                                        r31 = r6[r43]
                                                        r43 = 0
                                                        r6 = r31(r43, r27, r22)
                                                        r27 = "Color3"
                                                        r43 = _env[r27]
                                                        r22 = upvalueValues[r23]
                                                        r32 = upvalueValues[r10]
                                                        r12 = "\202f\155\025\185\158\168"
                                                        r26 = r32(r12, r38)
                                                        r27 = r22[r26]
                                                        r31 = r43[r27]
                                                        r27 = 135
                                                        r32 = 250
                                                        r22 = 206
                                                        r43 = {
                                                            r31(r27, r22, r32)
                                                        }
                                                        r32 = 22155259766860
                                                        r5 = {
                                                            r13,
                                                            r11,
                                                            r17,
                                                            r24,
                                                            r6,
                                                            unpack(r43)
                                                        }
                                                        r31 = allocUpvalue()
                                                        upvalueValues[r31] = r5
                                                        r43 = "\179Y\146\135\132"
                                                        r27 = 19649072735165
                                                        r11 = "task"
                                                        r13 = _env[r11]
                                                        r17 = upvalueValues[r23]
                                                        r24 = upvalueValues[r10]
                                                        r6 = r24(r43, r27)
                                                        r11 = r17[r6]
                                                        r5 = r13[r11]
                                                        r11 = createClosure2(84, {
                                                            r35,
                                                            r23,
                                                            r10,
                                                            r31,
                                                            r39
                                                        })
                                                        r27 = 14429639072319
                                                        r13 = r5(r11)
                                                        r43 = "0|\016"
                                                        r11 = "Instance"
                                                        r13 = _env[r11]
                                                        r17 = upvalueValues[r23]
                                                        r24 = upvalueValues[r10]
                                                        r6 = r24(r43, r27)
                                                        r22 = "\146o]"
                                                        r43 = "b\240\028\236\182\144H\227\000"
                                                        r11 = r17[r6]
                                                        r27 = 6290857806705
                                                        r5 = r13[r11]
                                                        r17 = upvalueValues[r23]
                                                        r24 = upvalueValues[r10]
                                                        r6 = r24(r43, r27)
                                                        r26 = 379936456880
                                                        r11 = r17[r6]
                                                        r17 = upvalueValues[r35]
                                                        r13 = r5(r11, r17)
                                                        r43 = 3678929307313
                                                        r11 = upvalueValues[r23]
                                                        r17 = upvalueValues[r10]
                                                        r6 = "[4?\217"
                                                        r24 = r17(r6, r43)
                                                        r5 = r11[r24]
                                                        r24 = "UDim2"
                                                        r17 = _env[r24]
                                                        r6 = upvalueValues[r23]
                                                        r43 = upvalueValues[r10]
                                                        r27 = r43(r22, r32)
                                                        r43 = 0.12
                                                        r24 = r6[r27]
                                                        r22 = "c\156."
                                                        r11 = r17[r24]
                                                        r6 = 0
                                                        r32 = 12521528334022
                                                        r27 = 0
                                                        r24 = 1
                                                        r17 = r11(r24, r6, r43, r27)
                                                        r13[r5] = r17
                                                        r20 = 11277904581763
                                                        r15 = "\228mX"
                                                        r7 = 5969577708251
                                                        r14 = "\142\250\027"
                                                        r25 = 30683909306320
                                                        r29 = 31314557794549
                                                        r42 = 488904655075
                                                        r3 = "\151\185\029"
                                                        r40 = 25551426776698
                                                        r11 = upvalueValues[r23]
                                                        r17 = upvalueValues[r10]
                                                        r6 = "\185\175\203\147\143_\221\148"
                                                        r1 = nil
                                                        r43 = 16627268640318
                                                        r24 = r17(r6, r43)
                                                        r5 = r11[r24]
                                                        r24 = "UDim2"
                                                        r17 = _env[r24]
                                                        r6 = upvalueValues[r23]
                                                        r43 = upvalueValues[r10]
                                                        r27 = r43(r22, r32)
                                                        r24 = r6[r27]
                                                        r11 = r17[r24]
                                                        r6 = 0
                                                        r27 = 0
                                                        r43 = 0
                                                        r24 = 0
                                                        r17 = r11(r24, r6, r43, r27)
                                                        r13[r5] = r17
                                                        r43 = 34540640173780
                                                        r11 = upvalueValues[r23]
                                                        r6 = "}WR\186"
                                                        r17 = upvalueValues[r10]
                                                        r27 = 3910168971036
                                                        r24 = r17(r6, r43)
                                                        r5 = r11[r24]
                                                        r43 = "\162\193Ey\225\209U\155\249i"
                                                        r17 = upvalueValues[r23]
                                                        r24 = upvalueValues[r10]
                                                        r6 = r24(r43, r27)
                                                        r11 = r17[r6]
                                                        r13[r5] = r11
                                                        r43 = 34203638758967
                                                        r32 = 4994753792277
                                                        r11 = upvalueValues[r23]
                                                        r17 = upvalueValues[r10]
                                                        r22 = "sx\1582\168\199S"
                                                        r6 = "BI\1863\233\249 \008\190\007\132\242\2150\1793.q\225\129\209T"
                                                        r24 = r17(r6, r43)
                                                        r43 = 26622299730028
                                                        r6 = "\139\153\195\146\238\222\204\134\026{"
                                                        r5 = r11[r24]
                                                        r11 = 1
                                                        r13[r5] = r11
                                                        r11 = upvalueValues[r23]
                                                        r21 = 5396568705488
                                                        r17 = upvalueValues[r10]
                                                        r24 = r17(r6, r43)
                                                        r5 = r11[r24]
                                                        r24 = "Color3"
                                                        r17 = _env[r24]
                                                        r6 = upvalueValues[r23]
                                                        r43 = upvalueValues[r10]
                                                        r27 = r43(r22, r32)
                                                        r43 = 40
                                                        r24 = r6[r27]
                                                        r6 = 40
                                                        r11 = r17[r24]
                                                        r24 = 40
                                                        r17 = r11(r24, r6, r43)
                                                        r6 = "\235g(\222"
                                                        r43 = 11888824227232
                                                        r13[r5] = r17
                                                        r11 = upvalueValues[r23]
                                                        r17 = upvalueValues[r10]
                                                        r24 = r17(r6, r43)
                                                        r5 = r11[r24]
                                                        r6 = "Enum"
                                                        r32 = "\171J\n\151"
                                                        r24 = _env[r6]
                                                        r43 = upvalueValues[r23]
                                                        r27 = upvalueValues[r10]
                                                        r22 = r27(r32, r26)
                                                        r6 = r43[r22]
                                                        r17 = r24[r6]
                                                        r6 = upvalueValues[r23]
                                                        r43 = upvalueValues[r10]
                                                        r22 = "]\145\143f\245P3@G\205y\201k\141"
                                                        r32 = 11922595517871
                                                        r27 = r43(r22, r32)
                                                        r24 = r6[r27]
                                                        r11 = r17[r24]
                                                        r13[r5] = r11
                                                        r22 = 33235019070580
                                                        r11 = upvalueValues[r23]
                                                        r43 = 28121431831335
                                                        r6 = "~\210\127\203\133\n\190\192\157\139"
                                                        r17 = upvalueValues[r10]
                                                        r24 = r17(r6, r43)
                                                        r27 = "\230\018\186"
                                                        r5 = r11[r24]
                                                        r17 = "Instance"
                                                        r31 = releaseUpvalue(r31)
                                                        r11 = true
                                                        r13[r5] = r11
                                                        r11 = _env[r17]
                                                        r24 = upvalueValues[r23]
                                                        r6 = upvalueValues[r10]
                                                        r43 = r6(r27, r22)
                                                        r17 = r24[r43]
                                                        r5 = r11[r17]
                                                        r27 = "\252\135=M\155*\166"
                                                        r24 = upvalueValues[r23]
                                                        r6 = upvalueValues[r10]
                                                        r22 = 9000639778911
                                                        r43 = r6(r27, r22)
                                                        r17 = r24[r43]
                                                        r24 = upvalueValues[r35]
                                                        r11 = r5(r17, r24)
                                                        r5 = allocUpvalue()
                                                        upvalueValues[r5] = r11
                                                        r11 = upvalueValues[r5]
                                                        r32 = 4349915482089
                                                        r24 = upvalueValues[r23]
                                                        r6 = upvalueValues[r10]
                                                        r22 = 12586132461284
                                                        r27 = "j\002\0253F/\154\140\238;\251\173\164\185\031"
                                                        r43 = r6(r27, r22)
                                                        r17 = r24[r43]
                                                        r22 = "U\141j7\231\195\030\217/5M\175:72"
                                                        r6 = upvalueValues[r23]
                                                        r43 = upvalueValues[r10]
                                                        r26 = "\225\232\027"
                                                        r27 = r43(r22, r32)
                                                        r22 = 22931953707446
                                                        r24 = r6[r27]
                                                        r11[r17] = r24
                                                        r11 = upvalueValues[r5]
                                                        r27 = "v\193s\153"
                                                        r24 = upvalueValues[r23]
                                                        r6 = upvalueValues[r10]
                                                        r43 = r6(r27, r22)
                                                        r17 = r24[r43]
                                                        r43 = "UDim2"
                                                        r6 = _env[r43]
                                                        r27 = upvalueValues[r23]
                                                        r22 = upvalueValues[r10]
                                                        r12 = 28781414331482
                                                        r32 = r22(r26, r12)
                                                        r43 = r27[r32]
                                                        r32 = 0
                                                        r22 = 0.1
                                                        r27 = 0
                                                        r24 = r6[r43]
                                                        r43 = 0.9
                                                        r6 = r24(r43, r27, r22, r32)
                                                        r22 = 32848807246784
                                                        r26 = "\239\231^"
                                                        r11[r17] = r6
                                                        r27 = "\254\002\233\216<7r\170"
                                                        r11 = upvalueValues[r5]
                                                        r24 = upvalueValues[r23]
                                                        r6 = upvalueValues[r10]
                                                        r43 = r6(r27, r22)
                                                        r17 = r24[r43]
                                                        r43 = "UDim2"
                                                        r6 = _env[r43]
                                                        r27 = upvalueValues[r23]
                                                        r22 = upvalueValues[r10]
                                                        r12 = 11132659881024
                                                        r32 = r22(r26, r12)
                                                        r22 = 0.14
                                                        r26 = "_\232\224b\168\196$"
                                                        r43 = r27[r32]
                                                        r27 = 0
                                                        r32 = 0
                                                        r24 = r6[r43]
                                                        r43 = 0.05
                                                        r6 = r24(r43, r27, r22, r32)
                                                        r22 = 25383275540012
                                                        r11[r17] = r6
                                                        r11 = upvalueValues[r5]
                                                        r27 = "ZW\151\186\178s\021\216 p\168\169g\154|~"
                                                        r24 = upvalueValues[r23]
                                                        r6 = upvalueValues[r10]
                                                        r43 = r6(r27, r22)
                                                        r17 = r24[r43]
                                                        r43 = "Color3"
                                                        r6 = _env[r43]
                                                        r27 = upvalueValues[r23]
                                                        r22 = upvalueValues[r10]
                                                        r12 = 2625233536198
                                                        r32 = r22(r26, r12)
                                                        r43 = r27[r32]
                                                        r22 = 240
                                                        r27 = 240
                                                        r24 = r6[r43]
                                                        r43 = 240
                                                        r6 = r24(r43, r27, r22)
                                                        r11[r17] = r6
                                                        r38 = 5004064590106
                                                        r27 = "\211\197\143\002Oc\188)<\000"
                                                        r11 = upvalueValues[r5]
                                                        r22 = 267493539964
                                                        r24 = upvalueValues[r23]
                                                        r6 = upvalueValues[r10]
                                                        r43 = r6(r27, r22)
                                                        r17 = r24[r43]
                                                        r26 = "(\166\142\163>\135\026"
                                                        r43 = "Color3"
                                                        r6 = _env[r43]
                                                        r27 = upvalueValues[r23]
                                                        r22 = upvalueValues[r10]
                                                        r12 = 33083350350893
                                                        r32 = r22(r26, r12)
                                                        r43 = r27[r32]
                                                        r27 = 40
                                                        r24 = r6[r43]
                                                        r22 = 40
                                                        r43 = 40
                                                        r6 = r24(r43, r27, r22)
                                                        r22 = 14097554610596
                                                        r11[r17] = r6
                                                        r27 = "*\162\137V"
                                                        r11 = upvalueValues[r5]
                                                        r24 = upvalueValues[r23]
                                                        r6 = upvalueValues[r10]
                                                        r43 = r6(r27, r22)
                                                        r27 = "Enum"
                                                        r17 = r24[r43]
                                                        r43 = _env[r27]
                                                        r22 = upvalueValues[r23]
                                                        r32 = upvalueValues[r10]
                                                        r12 = "g\164\136B"
                                                        r26 = r32(r12, r38)
                                                        r27 = r22[r26]
                                                        r6 = r43[r27]
                                                        r27 = upvalueValues[r23]
                                                        r22 = upvalueValues[r10]
                                                        r26 = "\242QA\203\014;oJ\224\137"
                                                        r12 = 13752645392644
                                                        r32 = r22(r26, r12)
                                                        r43 = r27[r32]
                                                        r24 = r6[r43]
                                                        r11[r17] = r24
                                                        r11 = upvalueValues[r5]
                                                        r24 = upvalueValues[r23]
                                                        r32 = 19433703662425
                                                        r27 = "?G\r\201\182\200\135\161(\202"
                                                        r6 = upvalueValues[r10]
                                                        r22 = 18330998743384
                                                        r43 = r6(r27, r22)
                                                        r17 = r24[r43]
                                                        r26 = "\198i\156"
                                                        r24 = true
                                                        r11[r17] = r24
                                                        r22 = "\198:\161"
                                                        r24 = "Instance"
                                                        r17 = _env[r24]
                                                        r6 = upvalueValues[r23]
                                                        r43 = upvalueValues[r10]
                                                        r27 = r43(r22, r32)
                                                        r32 = 20043503199349
                                                        r24 = r6[r27]
                                                        r11 = r17[r24]
                                                        r22 = "\181\197\176\159\2005F\179"
                                                        r6 = upvalueValues[r23]
                                                        r43 = upvalueValues[r10]
                                                        r27 = r43(r22, r32)
                                                        r24 = r6[r27]
                                                        r6 = upvalueValues[r5]
                                                        r17 = r11(r24, r6)
                                                        r24 = upvalueValues[r23]
                                                        r6 = upvalueValues[r10]
                                                        r27 = "\186\213\004\225'\177\140R\186\143}]"
                                                        r22 = 22009928067081
                                                        r43 = r6(r27, r22)
                                                        r11 = r24[r43]
                                                        r43 = "UDim"
                                                        r6 = _env[r43]
                                                        r27 = upvalueValues[r23]
                                                        r22 = upvalueValues[r10]
                                                        r12 = 6404591324070
                                                        r32 = r22(r26, r12)
                                                        r43 = r27[r32]
                                                        r24 = r6[r43]
                                                        r27 = 12
                                                        r43 = 0
                                                        r32 = "A7\228"
                                                        r26 = 1486399734452
                                                        r6 = r24(r43, r27)
                                                        r17[r11] = r6
                                                        r6 = "Instance"
                                                        r24 = _env[r6]
                                                        r43 = upvalueValues[r23]
                                                        r27 = upvalueValues[r10]
                                                        r22 = r27(r32, r26)
                                                        r6 = r43[r22]
                                                        r32 = "\n\237\131\140#\207\132\"\236"
                                                        r38 = "\230\209\178"
                                                        r11 = r24[r6]
                                                        r43 = upvalueValues[r23]
                                                        r26 = 34531456401103
                                                        r27 = upvalueValues[r10]
                                                        r22 = r27(r32, r26)
                                                        r6 = r43[r22]
                                                        r32 = "\1591C^"
                                                        r43 = upvalueValues[r35]
                                                        r26 = 5760859392634
                                                        r24 = r11(r6, r43)
                                                        r11 = allocUpvalue()
                                                        upvalueValues[r11] = r24
                                                        r24 = upvalueValues[r11]
                                                        r43 = upvalueValues[r23]
                                                        r27 = upvalueValues[r10]
                                                        r22 = r27(r32, r26)
                                                        r6 = r43[r22]
                                                        r22 = "UDim2"
                                                        r27 = _env[r22]
                                                        r32 = upvalueValues[r23]
                                                        r26 = upvalueValues[r10]
                                                        r12 = r26(r38, r21)
                                                        r38 = "\161\163\019"
                                                        r26 = 0.06
                                                        r22 = r32[r12]
                                                        r32 = 0
                                                        r21 = 32383159139047
                                                        r43 = r27[r22]
                                                        r22 = 0.9
                                                        r12 = 0
                                                        r27 = r43(r22, r32, r26, r12)
                                                        r24[r6] = r27
                                                        r26 = 33550723054855
                                                        r24 = upvalueValues[r11]
                                                        r32 = "\153\160\151{\163\\SP"
                                                        r43 = upvalueValues[r23]
                                                        r27 = upvalueValues[r10]
                                                        r22 = r27(r32, r26)
                                                        r6 = r43[r22]
                                                        r22 = "UDim2"
                                                        r27 = _env[r22]
                                                        r32 = upvalueValues[r23]
                                                        r26 = upvalueValues[r10]
                                                        r12 = r26(r38, r21)
                                                        r22 = r32[r12]
                                                        r32 = 0
                                                        r43 = r27[r22]
                                                        r12 = 0
                                                        r19 = 28926855230622
                                                        r41 = nil
                                                        r26 = 0.26
                                                        r22 = 0.05
                                                        r27 = r43(r22, r32, r26, r12)
                                                        r26 = 10391322497766
                                                        r24[r6] = r27
                                                        r24 = upvalueValues[r11]
                                                        r43 = upvalueValues[r23]
                                                        r27 = upvalueValues[r10]
                                                        r32 = "\131k\211\183\202\178\225\206\138\220\016\132^\178\156\143\003\02074@\197"
                                                        r22 = r27(r32, r26)
                                                        r12 = 32763095595928
                                                        r21 = 3192234902990
                                                        r32 = "\226h\027\234"
                                                        r13 = nil
                                                        r26 = 10255175176871
                                                        r6 = r43[r22]
                                                        r43 = 1
                                                        r24[r6] = r43
                                                        r24 = upvalueValues[r11]
                                                        r43 = upvalueValues[r23]
                                                        r27 = upvalueValues[r10]
                                                        r22 = r27(r32, r26)
                                                        r26 = ""
                                                        r6 = r43[r22]
                                                        r27 = upvalueValues[r23]
                                                        r38 = "-|N\128\245R\128"
                                                        r22 = upvalueValues[r10]
                                                        r32 = r22(r26, r12)
                                                        r43 = r27[r32]
                                                        r24[r6] = r43
                                                        r9 = releaseUpvalue(r9)
                                                        r26 = 22313918015638
                                                        r24 = upvalueValues[r11]
                                                        r32 = "\241\197\174\191\183\019^\021\198\240"
                                                        r43 = upvalueValues[r23]
                                                        r27 = upvalueValues[r10]
                                                        r22 = r27(r32, r26)
                                                        r6 = r43[r22]
                                                        r22 = "Color3"
                                                        r27 = _env[r22]
                                                        r32 = upvalueValues[r23]
                                                        r26 = upvalueValues[r10]
                                                        r12 = r26(r38, r21)
                                                        r22 = r32[r12]
                                                        r43 = r27[r22]
                                                        r32 = 40
                                                        r22 = 40
                                                        r26 = 40
                                                        r39 = releaseUpvalue(r39)
                                                        r27 = r43(r22, r32, r26)
                                                        r24[r6] = r27
                                                        r24 = upvalueValues[r11]
                                                        r43 = upvalueValues[r23]
                                                        r27 = upvalueValues[r10]
                                                        r32 = "\017\148&\248"
                                                        r21 = "\219\221\252&"
                                                        r26 = 30813742561292
                                                        r22 = r27(r32, r26)
                                                        r6 = r43[r22]
                                                        r32 = "Enum"
                                                        r22 = _env[r32]
                                                        r26 = upvalueValues[r23]
                                                        r12 = upvalueValues[r10]
                                                        r38 = r12(r21, r29)
                                                        r32 = r26[r38]
                                                        r27 = r22[r32]
                                                        r38 = "]\186\201\169+)\224\213\222\008\242g\244\003"
                                                        r21 = 15778367380659
                                                        r32 = upvalueValues[r23]
                                                        r26 = upvalueValues[r10]
                                                        r12 = r26(r38, r21)
                                                        r38 = 29079926781157
                                                        r26 = 35163658059766
                                                        r22 = r32[r12]
                                                        r43 = r27[r22]
                                                        r32 = "\157\141\254+\138YK\145\141\164"
                                                        r24[r6] = r43
                                                        r37 = 26658650271869
                                                        r17 = nil
                                                        r24 = upvalueValues[r11]
                                                        r43 = upvalueValues[r23]
                                                        r27 = upvalueValues[r10]
                                                        r22 = r27(r32, r26)
                                                        r6 = r43[r22]
                                                        r43 = true
                                                        r24[r6] = r43
                                                        r6 = createClosure7(91, {
                                                            r11,
                                                            r23,
                                                            r10
                                                        })
                                                        r24 = allocUpvalue()
                                                        r21 = 13359358744652
                                                        upvalueValues[r24] = r6
                                                        r6 = createClosure2(92, {
                                                            r23,
                                                            r10,
                                                            r35
                                                        })
                                                        r22 = upvalueValues[r23]
                                                        r32 = upvalueValues[r10]
                                                        r12 = "\167\003\139\227\007\004I\002\221"
                                                        r26 = r32(r12, r38)
                                                        r27 = r22[r26]
                                                        r22 = 0.35
                                                        r43 = r6(r27, r22)
                                                        r32 = upvalueValues[r23]
                                                        r26 = upvalueValues[r10]
                                                        r38 = "\137x\157\005\227\255\161>f\023\209\244\247"
                                                        r12 = r26(r38, r21)
                                                        r22 = r32[r12]
                                                        r32 = 0.45
                                                        r27 = r6(r22, r32)
                                                        r26 = upvalueValues[r23]
                                                        r12 = upvalueValues[r10]
                                                        r21 = "\207\163J\"`\188\031w\199\143\133l\186\188Dg"
                                                        r29 = 27491674403329
                                                        r38 = r12(r21, r29)
                                                        r32 = r26[r38]
                                                        r26 = 0.55
                                                        r22 = r6(r32, r26)
                                                        r12 = upvalueValues[r23]
                                                        r38 = upvalueValues[r10]
                                                        r29 = "\005\180\195\143j\217\028<\248"
                                                        r21 = r38(r29, r37)
                                                        r26 = r12[r21]
                                                        r12 = 0.65
                                                        r32 = r6(r26, r12)
                                                        r38 = upvalueValues[r23]
                                                        r21 = upvalueValues[r10]
                                                        r37 = "X\185\255\206^\169\\"
                                                        r29 = r21(r37, r42)
                                                        r12 = r38[r29]
                                                        r21 = "Instance"
                                                        r38 = 0.75
                                                        r26 = r6(r12, r38)
                                                        r38 = _env[r21]
                                                        r29 = upvalueValues[r23]
                                                        r37 = upvalueValues[r10]
                                                        r42 = r37(r15, r25)
                                                        r21 = r29[r42]
                                                        r12 = r38[r21]
                                                        r29 = upvalueValues[r23]
                                                        r37 = upvalueValues[r10]
                                                        r15 = "\136\238\011\146\166"
                                                        r25 = 22288020727946
                                                        r42 = r37(r15, r25)
                                                        r21 = r29[r42]
                                                        r29 = upvalueValues[r35]
                                                        r38 = r12(r21, r29)
                                                        r21 = upvalueValues[r23]
                                                        r29 = upvalueValues[r10]
                                                        r15 = 31803462466009
                                                        r42 = "t\166\182\225"
                                                        r37 = r29(r42, r15)
                                                        r12 = r21[r37]
                                                        r37 = "UDim2"
                                                        r29 = _env[r37]
                                                        r42 = upvalueValues[r23]
                                                        r15 = upvalueValues[r10]
                                                        r25 = r15(r14, r20)
                                                        r37 = r42[r25]
                                                        r21 = r29[r37]
                                                        r42 = 0
                                                        r25 = 0
                                                        r15 = 0.1
                                                        r37 = 0.9
                                                        r29 = r21(r37, r42, r15, r25)
                                                        r38[r12] = r29
                                                        r21 = upvalueValues[r23]
                                                        r29 = upvalueValues[r10]
                                                        r15 = 22267306682497
                                                        r42 = "\135\242\175\245\166\225\215\128"
                                                        r37 = r29(r42, r15)
                                                        r12 = r21[r37]
                                                        r37 = "UDim2"
                                                        r29 = _env[r37]
                                                        r42 = upvalueValues[r23]
                                                        r15 = upvalueValues[r10]
                                                        r20 = 15681229773958
                                                        r14 = "\234\248\222"
                                                        r25 = r15(r14, r20)
                                                        r37 = r42[r25]
                                                        r21 = r29[r37]
                                                        r42 = 0
                                                        r25 = 0
                                                        r15 = 0.87
                                                        r37 = 0.05
                                                        r29 = r21(r37, r42, r15, r25)
                                                        r38[r12] = r29
                                                        r21 = upvalueValues[r23]
                                                        r29 = upvalueValues[r10]
                                                        r15 = 20653314205073
                                                        r42 = "\2306\188ga\190c\191uT<[\2507J\153"
                                                        r37 = r29(r42, r15)
                                                        r12 = r21[r37]
                                                        r35 = releaseUpvalue(r35)
                                                        r37 = "Color3"
                                                        r29 = _env[r37]
                                                        r42 = upvalueValues[r23]
                                                        r15 = upvalueValues[r10]
                                                        r14 = "g\t?#\203\231O"
                                                        r20 = 19911027778615
                                                        r25 = r15(r14, r20)
                                                        r37 = r42[r25]
                                                        r21 = r29[r37]
                                                        r42 = 245
                                                        r15 = 245
                                                        r37 = 245
                                                        r29 = r21(r37, r42, r15)
                                                        r38[r12] = r29
                                                        r25 = "\155%\n"
                                                        r14 = 10691656962930
                                                        r29 = "Instance"
                                                        r6 = nil
                                                        r21 = _env[r29]
                                                        r37 = upvalueValues[r23]
                                                        r42 = upvalueValues[r10]
                                                        r15 = r42(r25, r14)
                                                        r29 = r37[r15]
                                                        r12 = r21[r29]
                                                        r37 = upvalueValues[r23]
                                                        r42 = upvalueValues[r10]
                                                        r14 = 20227627246795
                                                        r25 = "\208I\187\001\197\171H\128"
                                                        r15 = r42(r25, r14)
                                                        r29 = r37[r15]
                                                        r21 = r12(r29, r38)
                                                        r29 = upvalueValues[r23]
                                                        r37 = upvalueValues[r10]
                                                        r15 = "\029>\1311Ig\196\021\129\161\001\011"
                                                        r25 = 20179982410933
                                                        r42 = r37(r15, r25)
                                                        r12 = r29[r42]
                                                        r42 = "UDim"
                                                        r37 = _env[r42]
                                                        r15 = upvalueValues[r23]
                                                        r25 = upvalueValues[r10]
                                                        r20 = "Z\225\174"
                                                        r14 = r25(r20, r7)
                                                        r42 = r15[r14]
                                                        r29 = r37[r42]
                                                        r15 = 12
                                                        r42 = 0
                                                        r37 = r29(r42, r15)
                                                        r11 = releaseUpvalue(r11)
                                                        r21[r12] = r37
                                                        r37 = "Instance"
                                                        r29 = _env[r37]
                                                        r42 = upvalueValues[r23]
                                                        r15 = upvalueValues[r10]
                                                        r14 = "!\203\187"
                                                        r20 = 17700918550578
                                                        r25 = r15(r14, r20)
                                                        r37 = r42[r25]
                                                        r12 = r29[r37]
                                                        r42 = upvalueValues[r23]
                                                        r15 = upvalueValues[r10]
                                                        r20 = 34546491653846
                                                        r14 = "U'F\212\192(\220\025\011"
                                                        r25 = r15(r14, r20)
                                                        r37 = r42[r25]
                                                        ReturnVal = {}
                                                        r29 = r12(r37, r38)
                                                        r12 = allocUpvalue()
                                                        upvalueValues[r12] = r29
                                                        r29 = upvalueValues[r12]
                                                        r42 = upvalueValues[r23]
                                                        r15 = upvalueValues[r10]
                                                        r20 = 6251563060063
                                                        r14 = "\133<\031\204"
                                                        r25 = r15(r14, r20)
                                                        r37 = r42[r25]
                                                        r25 = "UDim2"
                                                        r15 = _env[r25]
                                                        r14 = upvalueValues[r23]
                                                        r20 = upvalueValues[r10]
                                                        r7 = r20(r3, r19)
                                                        r25 = r14[r7]
                                                        r14 = -10
                                                        r42 = r15[r25]
                                                        r7 = -10
                                                        r25 = 1
                                                        r20 = 1
                                                        r15 = r42(r25, r14, r20, r7)
                                                        r29[r37] = r15
                                                        r29 = upvalueValues[r12]
                                                        r42 = upvalueValues[r23]
                                                        r15 = upvalueValues[r10]
                                                        r14 = "!\002b\200L\247\026`"
                                                        r20 = 32059627551312
                                                        r25 = r15(r14, r20)
                                                        r37 = r42[r25]
                                                        r25 = "UDim2"
                                                        r15 = _env[r25]
                                                        r14 = upvalueValues[r23]
                                                        r20 = upvalueValues[r10]
                                                        r3 = "Y\234\236"
                                                        r19 = 25967252074299
                                                        r7 = r20(r3, r19)
                                                        r25 = r14[r7]
                                                        r42 = r15[r25]
                                                        r14 = 5
                                                        r7 = 5
                                                        r20 = 0
                                                        r25 = 0
                                                        r15 = r42(r25, r14, r20, r7)
                                                        r29[r37] = r15
                                                        r29 = upvalueValues[r12]
                                                        r42 = upvalueValues[r23]
                                                        r15 = upvalueValues[r10]
                                                        r20 = 25011923021183
                                                        r14 = "9\168\150\001\152\200\023\142\0187\168:\183\1671\242?\249q\252\155;"
                                                        r25 = r15(r14, r20)
                                                        r37 = r42[r25]
                                                        r42 = 1
                                                        r29[r37] = r42
                                                        r29 = upvalueValues[r12]
                                                        r42 = upvalueValues[r23]
                                                        r15 = upvalueValues[r10]
                                                        r14 = "P\153\129\200"
                                                        r20 = 16398319394260
                                                        r25 = r15(r14, r20)
                                                        r37 = r42[r25]
                                                        r15 = upvalueValues[r23]
                                                        r25 = upvalueValues[r10]
                                                        r7 = 16903160307391
                                                        r20 = ""
                                                        r14 = r25(r20, r7)
                                                        r42 = r15[r14]
                                                        r29[r37] = r42
                                                        r29 = upvalueValues[r12]
                                                        r42 = upvalueValues[r23]
                                                        r15 = upvalueValues[r10]
                                                        r14 = "\156\254\131\244.\252wp\183\210"
                                                        r20 = 22583390546196
                                                        r25 = r15(r14, r20)
                                                        r37 = r42[r25]
                                                        r25 = "Color3"
                                                        r15 = _env[r25]
                                                        r14 = upvalueValues[r23]
                                                        r20 = upvalueValues[r10]
                                                        r19 = 84095549479
                                                        r3 = "+\216\138\134\252Q\200"
                                                        r7 = r20(r3, r19)
                                                        r25 = r14[r7]
                                                        r42 = r15[r25]
                                                        r20 = 40
                                                        r14 = 40
                                                        r25 = 40
                                                        r15 = r42(r25, r14, r20)
                                                        r29[r37] = r15
                                                        r29 = upvalueValues[r12]
                                                        r42 = upvalueValues[r23]
                                                        r15 = upvalueValues[r10]
                                                        r20 = 13599927949500
                                                        r14 = "0\157\130B"
                                                        r25 = r15(r14, r20)
                                                        r37 = r42[r25]
                                                        r14 = "Enum"
                                                        r25 = _env[r14]
                                                        r20 = upvalueValues[r23]
                                                        r7 = upvalueValues[r10]
                                                        r19 = "=\192Ch"
                                                        r3 = r7(r19, r40)
                                                        r14 = r20[r3]
                                                        r15 = r25[r14]
                                                        r14 = upvalueValues[r23]
                                                        r20 = upvalueValues[r10]
                                                        r19 = 17320594775937
                                                        r3 = "\164f\140\140l\250*u&o\2017\026\188"
                                                        r7 = r20(r3, r19)
                                                        r25 = r14[r7]
                                                        r42 = r15[r25]
                                                        r29[r37] = r42
                                                        r29 = upvalueValues[r12]
                                                        r42 = upvalueValues[r23]
                                                        r15 = upvalueValues[r10]
                                                        r14 = "\003}\183\179\208\181\179\243J\155"
                                                        r20 = 7495482625442
                                                        r25 = r15(r14, r20)
                                                        r37 = r42[r25]
                                                        r42 = true
                                                        r29[r37] = r42
                                                        r29 = upvalueValues[r12]
                                                        r42 = upvalueValues[r23]
                                                        r15 = upvalueValues[r10]
                                                        r14 = "\176\151<\150Z\231\185\151\023g\135"
                                                        r20 = 3726413416135
                                                        r25 = r15(r14, r20)
                                                        r37 = r42[r25]
                                                        r42 = true
                                                        r29[r37] = r42
                                                        r29 = allocUpvalue()
                                                        r37 = createClosure4(93, {
                                                            r12,
                                                            r23,
                                                            r10
                                                        })
                                                        upvalueValues[r29] = r37
                                                        r37 = allocUpvalue()
                                                        r42 = createClosure2(94, {
                                                            r4,
                                                            r23,
                                                            r10,
                                                            r24
                                                        })
                                                        upvalueValues[r37] = r42
                                                        r25 = upvalueValues[r23]
                                                        r14 = upvalueValues[r10]
                                                        r3 = 16405338873303
                                                        r7 = "\180\212G6t\223\225\151\172\227\203F\201\188}\131\205"
                                                        r20 = r14(r7, r3)
                                                        r15 = r25[r20]
                                                        r7 = "s\132?/\019vd\132\244\209\030\129\154\008\251\t\242"
                                                        r38 = nil
                                                        r42 = r43[r15]
                                                        r25 = createClosure0(100, {
                                                            r5,
                                                            r23,
                                                            r10,
                                                            r24,
                                                            r4,
                                                            r33,
                                                            r18,
                                                            r37
                                                        })
                                                        r15 = "Connect"
                                                        r15 = r42[r15]
                                                        r15 = r15(r42, r25)
                                                        r25 = upvalueValues[r23]
                                                        r14 = upvalueValues[r10]
                                                        r24 = releaseUpvalue(r24)
                                                        r3 = 10771879269272
                                                        r20 = r14(r7, r3)
                                                        r43 = nil
                                                        r15 = r25[r20]
                                                        r42 = r27[r15]
                                                        r25 = createClosure5(114, {
                                                            r23,
                                                            r10,
                                                            r29
                                                        })
                                                        r15 = "Connect"
                                                        r15 = r42[r15]
                                                        r5 = releaseUpvalue(r5)
                                                        r37 = releaseUpvalue(r37)
                                                        r15 = r15(r42, r25)
                                                        r25 = upvalueValues[r23]
                                                        r14 = upvalueValues[r10]
                                                        r3 = 8103366856381
                                                        r7 = "\202\158\198\012#\241\015\178\200M\174/\210\212\147\166 "
                                                        r20 = r14(r7, r3)
                                                        r15 = r25[r20]
                                                        r42 = r22[r15]
                                                        r18 = releaseUpvalue(r18)
                                                        r15 = "Connect"
                                                        r15 = r42[r15]
                                                        r3 = 31995275541042
                                                        r7 = "Y\246V\207D\025\206v2\251\142^5\026\255;\135"
                                                        r21 = nil
                                                        r4 = releaseUpvalue(r4)
                                                        r25 = createClosure5(115, {
                                                            r23,
                                                            r10,
                                                            r29
                                                        })
                                                        r15 = r15(r42, r25)
                                                        r25 = upvalueValues[r23]
                                                        r14 = upvalueValues[r10]
                                                        r27 = nil
                                                        r20 = r14(r7, r3)
                                                        r15 = r25[r20]
                                                        r25 = createClosure1(116, {
                                                            r23,
                                                            r10,
                                                            r29
                                                        })
                                                        r42 = r32[r15]
                                                        r22 = nil
                                                        r15 = "Connect"
                                                        r15 = r42[r15]
                                                        r33 = releaseUpvalue(r33)
                                                        r15 = r15(r42, r25)
                                                        r3 = 9915073909257
                                                        r7 = "\209\220\014\153\204\206\175\153\239< \224\133\181}\018\004"
                                                        r25 = upvalueValues[r23]
                                                        r14 = upvalueValues[r10]
                                                        r32 = nil
                                                        r20 = r14(r7, r3)
                                                        r15 = r25[r20]
                                                        r25 = createClosure3(117, {
                                                            r23,
                                                            r10,
                                                            r29
                                                        })
                                                        r42 = r26[r15]
                                                        r10 = releaseUpvalue(r10)
                                                        r29 = releaseUpvalue(r29)
                                                        r15 = "Connect"
                                                        r15 = r42[r15]
                                                        r23 = releaseUpvalue(r23)
                                                        r26 = nil
                                                        r15 = r15(r42, r25)
                                                        r12 = releaseUpvalue(r12)
                                                        state = nil
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure3 entry 1798068 -> 32, states 32-32
                                    if state == 32 then -- entry 1798068 -> 32
                                        ReturnVal = "error"
                                        state = _env[ReturnVal]
                                        r30 = "Tamper Detected!"
                                        ReturnVal = state(r30)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure3 entry 9077288 -> 33, states 33-33
                                if state == 33 then -- entry 9077288 -> 33
                                    state = true
                                    upvalueValues[upvalues[1]] = state
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            if state <= 46 then
                                if state <= 34 then
                                    -- createClosure5 entry 3173106 -> 34, states 34-34
                                    if state == 34 then -- entry 3173106 -> 34
                                        r33 = 9166592
                                        r10 = "B6E6kA3OW"
                                        r30 = r10 ^ r33
                                        ReturnVal = 9287250
                                        state = ReturnVal - r30
                                        r30 = state
                                        ReturnVal = "V1wY3j"
                                        state = ReturnVal / r30
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure3 entry 15584916 -> 35, states 35-46
                                    if state <= 40 then
                                        if state <= 37 then
                                            if state <= 36 then
                                                if state <= 35 then
                                                    if state == 35 then -- entry 15584916 -> 35
                                                        r10 = upvalueValues[upvalues[1]]
                                                        r1 = 2
                                                        r23 = 1
                                                        r33 = r10(r23, r1)
                                                        r10 = 1
                                                        r30 = r33 == r10
                                                        state = r30 and (36) or (37)
                                                        ReturnVal = r30
                                                    end
                                                else
                                                    if state == 36 then
                                                        state = ReturnVal and (38) or (39)
                                                    end
                                                end
                                            else
                                                if state == 37 then
                                                    r10 = upvalueValues[upvalues[2]]
                                                    r33 = upvalueValues[upvalues[3]]
                                                    r30 = r10 == r33
                                                    ReturnVal = r30
                                                    state = 36
                                                end
                                            end
                                        else
                                            if state <= 39 then
                                                if state <= 38 then
                                                    if state == 38 then
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r30 = upvalueValues[upvalues[4]]
                                                        r35 = createClosure4(118, {})
                                                        r23 = "tostring"
                                                        r33 = _env[r23]
                                                        r18 = "pcall"
                                                        r4 = _env[r18]
                                                        r18 = {
                                                            r4(r35)
                                                        }
                                                        r9 = {
                                                            unpack(r18)
                                                        }
                                                        r4 = 2
                                                        r1 = r9[r4]
                                                        r23 = r33(r1)
                                                        r33 = ":(%d*):"
                                                        r10 = r30(r23, r33)
                                                        r30 = {
                                                            r10()
                                                        }
                                                        ReturnVal = state(unpack(r30))
                                                        r30 = ReturnVal
                                                        r10 = upvalueValues[upvalues[5]]
                                                        state = r10 and (40) or (41)
                                                        ReturnVal = r10
                                                    end
                                                else
                                                    if state == 39 then
                                                        state = upvalueValues[upvalues[7]]
                                                        state = state and (42) or (43)
                                                    end
                                                end
                                            else
                                                if state == 40 then
                                                    r33 = upvalueValues[upvalues[6]]
                                                    r10 = r33 == r30
                                                    ReturnVal = r10
                                                    state = 41
                                                end
                                            end
                                        end
                                    else
                                        if state <= 43 then
                                            if state <= 42 then
                                                if state <= 41 then
                                                    if state == 41 then
                                                        r30 = nil
                                                        upvalueValues[upvalues[5]] = ReturnVal
                                                        state = 39
                                                    end
                                                else
                                                    if state == 42 then
                                                        r30 = "error"
                                                        state = _env[r30]
                                                        r10 = upvalueValues[upvalues[8]]
                                                        r33 = 0
                                                        r30 = state(r10, r33)
                                                        state = 43
                                                    end
                                                end
                                            else
                                                if state == 43 then
                                                    r33 = upvalueValues[upvalues[9]]
                                                    r23 = r33
                                                    state = {}
                                                    r30 = state
                                                    r33 = 1
                                                    r1 = r33
                                                    r33 = 0
                                                    r9 = r1 < r33
                                                    r10 = 1
                                                    r33 = r10 - r1
                                                    state = 44
                                                end
                                            end
                                        else
                                            if state <= 45 then
                                                if state <= 44 then
                                                    if state == 44 then
                                                        r33 = r33 + r1
                                                        r4 = not r9
                                                        r10 = r33 <= r23
                                                        r10 = r4 and r10
                                                        r4 = r33 >= r23
                                                        r4 = r9 and r4
                                                        r10 = r4 or r10
                                                        r4 = (45)
                                                        state = r10 and r4
                                                        r10 = (46)
                                                        state = state or r10
                                                    end
                                                else
                                                    if state == 45 then
                                                        state = upvalueValues[upvalues[1]]
                                                        r35 = 255
                                                        r18 = 0
                                                        r4 = state(r18, r35)
                                                        r10 = r33
                                                        r30[r10] = r4
                                                        r10 = nil
                                                        state = 44
                                                    end
                                                end
                                            else
                                                if state == 46 then
                                                    state = upvalueValues[upvalues[10]]
                                                    r10 = upvalueValues[upvalues[11]]
                                                    r30[state] = r10
                                                    state = upvalueValues[upvalues[12]]
                                                    r10 = {
                                                        state(r30)
                                                    }
                                                    ReturnVal = {
                                                        unpack(r10)
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure0 entry 15258017 -> 47, states 47-50
                                if state <= 48 then
                                    if state <= 47 then
                                        if state == 47 then -- entry 15258017 -> 47
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
                                            r30 = "l1"
                                            ReturnVal = _env[r30]
                                            r30 = "l1"
                                            _env[r30] = state
                                            r30 = "l2"
                                            _env[r30] = ReturnVal
                                            r30 = upvalueValues[upvalues[1]]
                                            r10 = r30()
                                            state = 48
                                        end
                                    else
                                        if state == 50 then
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 74 then
                            if state <= 63 then
                                if state <= 56 then
                                    -- createClosure0 entry 3350499 -> 51, states 51-56
                                    if state <= 53 then
                                        if state <= 52 then
                                            if state <= 51 then
                                                if state == 51 then -- entry 3350499 -> 51
                                                    r30 = upvalueValues[upvalues[1]]
                                                    ReturnVal = #r30
                                                    r30 = 0
                                                    state = ReturnVal == r30
                                                    state = state and (52) or (53)
                                                end
                                            else
                                                if state == 52 then
                                                    r10 = upvalueValues[upvalues[2]]
                                                    r33 = 105
                                                    r30 = r10 * r33
                                                    r10 = 21433972483835
                                                    ReturnVal = r30 + r10
                                                    r30 = 35184372088832
                                                    state = ReturnVal % r30
                                                    upvalueValues[upvalues[2]] = state
                                                    r30 = upvalueValues[upvalues[3]]
                                                    r10 = 1
                                                    ReturnVal = r30 ~= r10
                                                    state = 54
                                                end
                                            end
                                        else
                                            if state == 53 then
                                                r33 = "table"
                                                r10 = _env[r33]
                                                r33 = "remove"
                                                r30 = r10[r33]
                                                r33 = upvalueValues[upvalues[1]]
                                                r10 = {
                                                    r30(r33)
                                                }
                                                ReturnVal = {
                                                    unpack(r10)
                                                }
                                                state = nil
                                            end
                                        end
                                    else
                                        if state <= 55 then
                                            if state <= 54 then
                                                if state == 54 then
                                                    r10 = upvalueValues[upvalues[3]]
                                                    r33 = 218
                                                    r30 = r10 * r33
                                                    r10 = 257
                                                    ReturnVal = r30 % r10
                                                    upvalueValues[upvalues[3]] = ReturnVal
                                                    state = 55
                                                end
                                            else
                                                if state == 55 then
                                                    r10 = upvalueValues[upvalues[3]]
                                                    r33 = 1
                                                    r30 = r10 ~= r33
                                                    state = r30 and (56) or (54)
                                                end
                                            end
                                        else
                                            if state == 56 then
                                                r10 = upvalueValues[upvalues[3]]
                                                r33 = 32
                                                r30 = r10 % r33
                                                r23 = upvalueValues[upvalues[4]]
                                                r35 = 2
                                                r4 = upvalueValues[upvalues[2]]
                                                r13 = upvalueValues[upvalues[3]]
                                                r31 = r13 - r30
                                                r13 = 32
                                                r5 = r31 / r13
                                                r41 = 13
                                                r39 = r41 - r5
                                                r18 = r35 ^ r39
                                                r9 = r4 / r18
                                                r1 = r23(r9)
                                                r23 = 4294967296
                                                r33 = r1 % r23
                                                r1 = 2
                                                r35 = 256
                                                r23 = r1 ^ r30
                                                r10 = r33 / r23
                                                r18 = 1
                                                r23 = upvalueValues[upvalues[4]]
                                                r4 = r10 % r18
                                                r18 = 4294967296
                                                r9 = r4 * r18
                                                r1 = r23(r9)
                                                r23 = upvalueValues[upvalues[4]]
                                                r4 = 65536
                                                r9 = r23(r10)
                                                r33 = r1 + r9
                                                r1 = 65536
                                                r23 = r33 % r1
                                                r9 = r33 - r23
                                                r1 = r9 / r4
                                                r4 = 256
                                                r9 = r23 % r4
                                                r41 = 256
                                                r10 = nil
                                                r18 = r23 - r9
                                                r4 = r18 / r35
                                                r35 = 256
                                                r30 = nil
                                                r33 = nil
                                                r18 = r1 % r35
                                                r39 = r1 - r18
                                                r23 = nil
                                                r1 = nil
                                                r35 = r39 / r41
                                                r39 = {
                                                    r9,
                                                    r4,
                                                    r18,
                                                    r35
                                                }
                                                r4 = nil
                                                r35 = nil
                                                upvalueValues[upvalues[1]] = r39
                                                r9 = nil
                                                r18 = nil
                                                state = 53
                                            end
                                        end
                                    end
                                else
                                    -- createClosure6 entry 10754510 -> 57, states 57-63
                                    if state <= 60 then
                                        if state <= 58 then
                                            if state <= 57 then
                                                if state == 57 then -- entry 10754510 -> 57
                                                    r30 = args[1]
                                                    state = upvalueValues[upvalues[1]]
                                                    r33 = state
                                                    r10 = args[2]
                                                    state = r33[r10]
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
                                                    r23 = ReturnVal
                                                    r1 = 35184372088832
                                                    ReturnVal = r10 % r1
                                                    upvalueValues[upvalues[4]] = ReturnVal
                                                    r4 = 255
                                                    r9 = r10 % r4
                                                    r4 = 2
                                                    r1 = r9 + r4
                                                    upvalueValues[upvalues[5]] = r1
                                                    r18 = "string"
                                                    r4 = _env[r18]
                                                    r18 = "len"
                                                    r9 = r4[r18]
                                                    r4 = r9(r30)
                                                    r9 = ""
                                                    r33[r10] = r9
                                                    r39 = 1
                                                    r41 = r39
                                                    r39 = 0
                                                    r5 = r41 < r39
                                                    r18 = 1
                                                    r39 = r18 - r41
                                                    r35 = r4
                                                    r9 = 213
                                                    state = 61
                                                end
                                            else
                                                if state == 60 then
                                                    ReturnVal = {
                                                        r10
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        if state <= 62 then
                                            if state <= 61 then
                                                if state == 61 then
                                                    r31 = not r5
                                                    r39 = r39 + r41
                                                    r18 = r39 <= r35
                                                    r18 = r31 and r18
                                                    r31 = r39 >= r35
                                                    r31 = r5 and r31
                                                    r18 = r31 or r18
                                                    r31 = (62)
                                                    state = r18 and r31
                                                    r18 = (63)
                                                    state = state or r18
                                                end
                                            else
                                                if state == 62 then
                                                    r18 = r39
                                                    r8 = "string"
                                                    r36 = _env[r8]
                                                    r8 = "byte"
                                                    r34 = r36[r8]
                                                    r36 = r34(r30, r18)
                                                    r34 = upvalueValues[upvalues[6]]
                                                    r8 = r34()
                                                    r11 = r36 + r8
                                                    r13 = r11 + r9
                                                    r11 = 256
                                                    r31 = r13 % r11
                                                    r9 = r31
                                                    r11 = r33[r10]
                                                    r8 = 1
                                                    r36 = r9 + r8
                                                    r34 = r23[r36]
                                                    r13 = r11 .. r34
                                                    r18 = nil
                                                    r33[r10] = r13
                                                    state = 61
                                                end
                                            end
                                        else
                                            if state == 63 then
                                                r9 = nil
                                                r4 = nil
                                                r23 = nil
                                                state = 60
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure4 entry 6007159 -> 64, states 64-74
                                if state <= 69 then
                                    if state <= 66 then
                                        if state <= 65 then
                                            if state <= 64 then
                                                if state == 64 then -- entry 6007159 -> 64
                                                    r10 = state
                                                    r23 = "syn"
                                                    r33 = _env[r23]
                                                    state = r33 and (65) or (66)
                                                    r30 = r33
                                                end
                                            else
                                                if state == 65 then
                                                    r1 = "syn"
                                                    r23 = _env[r1]
                                                    r9 = upvalueValues[upvalues[1]]
                                                    r4 = upvalueValues[upvalues[2]]
                                                    r39 = 19899220173874
                                                    r35 = "\131\222\141fza\166"
                                                    r18 = r4(r35, r39)
                                                    r1 = r9[r18]
                                                    r33 = r23[r1]
                                                    r30 = r33
                                                    state = 66
                                                end
                                            end
                                        else
                                            if state == 66 then
                                                state = r10
                                                state = r30 and (67) or (68)
                                                ReturnVal = r30
                                            end
                                        end
                                    else
                                        if state <= 68 then
                                            if state <= 67 then
                                                if state == 67 then
                                                    ReturnVal = {
                                                        ReturnVal
                                                    }
                                                    state = nil
                                                end
                                            else
                                                if state == 68 then
                                                    r10 = state
                                                    r23 = "http_request"
                                                    r33 = _env[r23]
                                                    state = r33 and (69) or (70)
                                                    r30 = r33
                                                end
                                            end
                                        else
                                            if state == 69 then
                                                state = r10
                                                ReturnVal = r30
                                                state = 67
                                            end
                                        end
                                    end
                                else
                                    if state <= 72 then
                                        if state <= 71 then
                                            if state <= 70 then
                                                if state == 70 then
                                                    r9 = "request"
                                                    r1 = _env[r9]
                                                    r23 = state
                                                    state = r1 and (71) or (72)
                                                    r33 = r1
                                                end
                                            else
                                                if state == 71 then
                                                    state = r23
                                                    r30 = r33
                                                    state = 69
                                                end
                                            end
                                        else
                                            if state == 72 then
                                                r18 = state
                                                r39 = "http"
                                                r35 = _env[r39]
                                                r9 = state
                                                state = r35 and (73) or (74)
                                                r4 = r35
                                            end
                                        end
                                    else
                                        if state <= 73 then
                                            if state == 73 then
                                                r41 = "http"
                                                r39 = _env[r41]
                                                r5 = upvalueValues[upvalues[1]]
                                                r31 = upvalueValues[upvalues[2]]
                                                r11 = "a\151nn\162\2541"
                                                r34 = 9397113852183
                                                r13 = r31(r11, r34)
                                                r41 = r5[r13]
                                                r35 = r39[r41]
                                                r4 = r35
                                                state = 74
                                            end
                                        else
                                            if state == 74 then
                                                state = r18
                                                r18 = nil
                                                r1 = r4 or r18
                                                r33 = r1
                                                state = 71
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 90 then
                                if state <= 83 then
                                    -- createClosure4 entry 15851349 -> 75, states 75-83
                                    if state <= 79 then
                                        if state <= 77 then
                                            if state <= 76 then
                                                if state <= 75 then
                                                    if state == 75 then -- entry 15851349 -> 75
                                                        r30 = allocUpvalue()
                                                        upvalueValues[r30] = args[1]
                                                        state = upvalueValues[upvalues[1]]
                                                        ReturnVal = state()
                                                        r10 = allocUpvalue()
                                                        upvalueValues[r10] = ReturnVal
                                                        ReturnVal = upvalueValues[r10]
                                                        state = not ReturnVal
                                                        state = state and (76) or (77)
                                                    end
                                                else
                                                    if state == 76 then
                                                        r33 = upvalueValues[upvalues[2]]
                                                        r23 = upvalueValues[upvalues[3]]
                                                        r4 = 4659759712377
                                                        r9 = "\023\253lW\023\137Zw\127\173\184\170\251\209w\160\145\005"
                                                        r1 = r23(r9, r4)
                                                        ReturnVal = r33[r1]
                                                        state = nil
                                                        ReturnVal = {
                                                            state,
                                                            ReturnVal
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state == 77 then
                                                    ReturnVal = "pcall"
                                                    state = _env[ReturnVal]
                                                    r23 = createClosure2(119, {
                                                        r10,
                                                        upvalues[2],
                                                        upvalues[3],
                                                        r30
                                                    })
                                                    r1 = {
                                                        state(r23)
                                                    }
                                                    ReturnVal = r1[1]
                                                    r23 = ReturnVal
                                                    state = r23 and (78) or (79)
                                                    ReturnVal = r23
                                                    r33 = r1[2]
                                                end
                                            end
                                        else
                                            if state <= 78 then
                                                if state == 78 then
                                                    r9 = state
                                                    state = r33 and (80) or (81)
                                                    r1 = r33
                                                end
                                            else
                                                if state == 79 then
                                                    state = ReturnVal and (82) or (83)
                                                end
                                            end
                                        end
                                    else
                                        if state <= 81 then
                                            if state <= 80 then
                                                if state == 80 then
                                                    r35 = upvalueValues[upvalues[2]]
                                                    r39 = upvalueValues[upvalues[3]]
                                                    r5 = "\138'l+"
                                                    r31 = 13801684490522
                                                    r41 = r39(r5, r31)
                                                    r18 = r35[r41]
                                                    r4 = r33[r18]
                                                    r1 = r4
                                                    state = 81
                                                end
                                            else
                                                if state == 81 then
                                                    state = r9
                                                    ReturnVal = r1
                                                    state = 79
                                                end
                                            end
                                        else
                                            if state <= 82 then
                                                if state == 82 then
                                                    r1 = upvalueValues[upvalues[2]]
                                                    r9 = upvalueValues[upvalues[3]]
                                                    r35 = 26371819253752
                                                    r18 = "Ol\137\156"
                                                    r4 = r9(r18, r35)
                                                    ReturnVal = r1[r4]
                                                    state = r33[ReturnVal]
                                                    ReturnVal = {
                                                        state
                                                    }
                                                    state = nil
                                                end
                                            else
                                                if state == 83 then
                                                    r1 = upvalueValues[upvalues[2]]
                                                    r9 = upvalueValues[upvalues[3]]
                                                    r35 = 16860349259435
                                                    r18 = "\1554\026\155\198\191\197f\140\197\255(\240:q\222u\187e"
                                                    r4 = r9(r18, r35)
                                                    ReturnVal = r1[r4]
                                                    state = nil
                                                    ReturnVal = {
                                                        state,
                                                        ReturnVal
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure2 entry 15365049 -> 84, states 84-90
                                    if state <= 87 then
                                        if state <= 85 then
                                            if state <= 84 then
                                                if state == 84 then -- entry 15365049 -> 84
                                                    state = 1
                                                    r30 = state
                                                    state = 85
                                                end
                                            else
                                                if state == 85 then
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r23 = upvalueValues[upvalues[3]]
                                                    r4 = 6299268516725
                                                    r9 = "\181\206\141=\209\216"
                                                    r1 = r23(r9, r4)
                                                    r10 = r33[r1]
                                                    state = ReturnVal[r10]
                                                    state = state and (86) or (87)
                                                end
                                            end
                                        else
                                            if state <= 86 then
                                                if state == 86 then
                                                    r33 = upvalueValues[upvalues[4]]
                                                    r10 = #r33
                                                    ReturnVal = r30 % r10
                                                    r10 = 1
                                                    state = ReturnVal + r10
                                                    r10 = state
                                                    r1 = 1
                                                    ReturnVal = upvalueValues[upvalues[4]]
                                                    state = ReturnVal[r30]
                                                    r33 = state
                                                    ReturnVal = upvalueValues[upvalues[4]]
                                                    state = ReturnVal[r10]
                                                    r23 = state
                                                    r9 = r1
                                                    r1 = 0.02
                                                    r4 = r1
                                                    r1 = 0
                                                    r18 = r4 < r1
                                                    ReturnVal = 0
                                                    r1 = ReturnVal - r4
                                                    state = 88
                                                end
                                            else
                                                if state == 87 then
                                                    r30 = nil
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        if state <= 89 then
                                            if state <= 88 then
                                                if state == 88 then
                                                    r1 = r1 + r4
                                                    r35 = not r18
                                                    ReturnVal = r1 <= r9
                                                    ReturnVal = r35 and ReturnVal
                                                    r35 = r1 >= r9
                                                    r35 = r18 and r35
                                                    ReturnVal = r35 or ReturnVal
                                                    r35 = (89)
                                                    state = ReturnVal and r35
                                                    ReturnVal = (90)
                                                    state = state or ReturnVal
                                                end
                                            else
                                                if state == 89 then
                                                    state = upvalueValues[upvalues[5]]
                                                    r35 = r1
                                                    r39 = upvalueValues[upvalues[2]]
                                                    r41 = upvalueValues[upvalues[3]]
                                                    r31 = ";a\025\170t"
                                                    r13 = 13931313928535
                                                    r5 = r41(r31, r13)
                                                    ReturnVal = r39[r5]
                                                    r5 = "Color3"
                                                    r41 = _env[r5]
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r13 = upvalueValues[upvalues[3]]
                                                    r34 = "\214\245\251"
                                                    r36 = 16195281870197
                                                    r11 = r13(r34, r36)
                                                    r5 = r31[r11]
                                                    r39 = r41[r5]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r17 = 28498891748310
                                                    r8 = "\000"
                                                    r36 = r34(r8, r17)
                                                    r13 = r11[r36]
                                                    r31 = r33[r13]
                                                    r8 = upvalueValues[upvalues[2]]
                                                    r17 = upvalueValues[upvalues[3]]
                                                    r2 = "\233"
                                                    r6 = 23385078278793
                                                    r24 = r17(r2, r6)
                                                    r36 = r8[r24]
                                                    r34 = r23[r36]
                                                    r17 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r43 = 31786233297361
                                                    r6 = "."
                                                    r2 = r24(r6, r43)
                                                    r8 = r17[r2]
                                                    r36 = r33[r8]
                                                    r11 = r34 - r36
                                                    r13 = r11 * r35
                                                    r5 = r31 + r13
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r36 = upvalueValues[upvalues[3]]
                                                    r24 = 4960798394630
                                                    r17 = "\236"
                                                    r8 = r36(r17, r24)
                                                    r11 = r34[r8]
                                                    r13 = r33[r11]
                                                    r17 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r6 = "\163"
                                                    r43 = 24319205764156
                                                    r2 = r24(r6, r43)
                                                    r8 = r17[r2]
                                                    r36 = r23[r8]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r2 = upvalueValues[upvalues[3]]
                                                    r27 = 7700074810881
                                                    r43 = "\\"
                                                    r6 = r2(r43, r27)
                                                    r17 = r24[r6]
                                                    r8 = r33[r17]
                                                    r34 = r36 - r8
                                                    r11 = r34 * r35
                                                    r31 = r13 + r11
                                                    r36 = upvalueValues[upvalues[2]]
                                                    r8 = upvalueValues[upvalues[3]]
                                                    r2 = 11472321074398
                                                    r24 = "+"
                                                    r17 = r8(r24, r2)
                                                    r34 = r36[r17]
                                                    r11 = r33[r34]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r2 = upvalueValues[upvalues[3]]
                                                    r43 = "\196"
                                                    r27 = 4736571050141
                                                    r6 = r2(r43, r27)
                                                    r17 = r24[r6]
                                                    r8 = r23[r17]
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r6 = upvalueValues[upvalues[3]]
                                                    r22 = 15853667146966
                                                    r27 = "\243"
                                                    r43 = r6(r27, r22)
                                                    r24 = r2[r43]
                                                    r17 = r33[r24]
                                                    r36 = r8 - r17
                                                    r34 = r36 * r35
                                                    r13 = r11 + r34
                                                    r41 = r39(r5, r31, r13)
                                                    state[ReturnVal] = r41
                                                    r11 = 4233444132787
                                                    r39 = "task"
                                                    ReturnVal = _env[r39]
                                                    r13 = "6\173\239b"
                                                    r41 = upvalueValues[upvalues[2]]
                                                    r35 = nil
                                                    r5 = upvalueValues[upvalues[3]]
                                                    r31 = r5(r13, r11)
                                                    r39 = r41[r31]
                                                    state = ReturnVal[r39]
                                                    r39 = 0.03
                                                    ReturnVal = state(r39)
                                                    state = 88
                                                end
                                            end
                                        else
                                            if state == 90 then
                                                state = r10
                                                r30 = state
                                                r10 = nil
                                                r33 = nil
                                                r23 = nil
                                                state = 85
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure7 entry 9322982 -> 91, states 91-91
                                if state == 91 then -- entry 9322982 -> 91
                                    state = upvalueValues[upvalues[1]]
                                    r33 = upvalueValues[upvalues[2]]
                                    r30 = args[1]
                                    r10 = args[2]
                                    r23 = upvalueValues[upvalues[3]]
                                    r9 = "\129\027\008\210"
                                    r4 = 19062139413164
                                    r1 = r23(r9, r4)
                                    ReturnVal = r33[r1]
                                    r33 = r30
                                    r9 = "mGq\168\164\181\181I\251\206"
                                    r30 = nil
                                    state[ReturnVal] = r33
                                    state = upvalueValues[upvalues[1]]
                                    r33 = upvalueValues[upvalues[2]]
                                    r23 = upvalueValues[upvalues[3]]
                                    r4 = 9375409606925
                                    r1 = r23(r9, r4)
                                    ReturnVal = r33[r1]
                                    r33 = r10
                                    r10 = nil
                                    state[ReturnVal] = r33
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        end
                    end
                else
                    if state <= 115 then
                        if state <= 99 then
                            if state <= 93 then
                                if state <= 92 then
                                    -- createClosure2 entry 199696 -> 92, states 92-92
                                    if state == 92 then -- entry 199696 -> 92
                                        r30 = args[1]
                                        r33 = "Instance"
                                        ReturnVal = _env[r33]
                                        r23 = upvalueValues[upvalues[1]]
                                        r1 = upvalueValues[upvalues[2]]
                                        r4 = "\148\212B"
                                        r18 = 32828093201334
                                        r9 = r1(r4, r18)
                                        r10 = args[2]
                                        r33 = r23[r9]
                                        state = ReturnVal[r33]
                                        r23 = upvalueValues[upvalues[1]]
                                        r1 = upvalueValues[upvalues[2]]
                                        r18 = 30194799294188
                                        r4 = "\159\231\008\239\017\210\241\238R0"
                                        r9 = r1(r4, r18)
                                        r33 = r23[r9]
                                        r23 = upvalueValues[upvalues[3]]
                                        ReturnVal = state(r33, r23)
                                        r33 = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r23 = upvalueValues[upvalues[2]]
                                        r9 = "\152\029>\199"
                                        r4 = 34758685146937
                                        r1 = r23(r9, r4)
                                        state = ReturnVal[r1]
                                        ReturnVal = r30
                                        r33[state] = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r23 = upvalueValues[upvalues[2]]
                                        r9 = "q\233dX"
                                        r4 = 268954632317
                                        r1 = r23(r9, r4)
                                        state = ReturnVal[r1]
                                        r1 = "UDim2"
                                        r23 = _env[r1]
                                        r9 = upvalueValues[upvalues[1]]
                                        r4 = upvalueValues[upvalues[2]]
                                        r35 = "\136^\227"
                                        r39 = 30462292850537
                                        r18 = r4(r35, r39)
                                        r1 = r9[r18]
                                        ReturnVal = r23[r1]
                                        r1 = 0.9
                                        r4 = 0.08
                                        r9 = 0
                                        r18 = 0
                                        r23 = ReturnVal(r1, r9, r4, r18)
                                        r33[state] = r23
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r23 = upvalueValues[upvalues[2]]
                                        r4 = 32657663392615
                                        r9 = ";\220\205&\176]\168+"
                                        r1 = r23(r9, r4)
                                        state = ReturnVal[r1]
                                        r1 = "UDim2"
                                        r23 = _env[r1]
                                        r9 = upvalueValues[upvalues[1]]
                                        r4 = upvalueValues[upvalues[2]]
                                        r39 = 14366509242913
                                        r35 = "\189(Y"
                                        r18 = r4(r35, r39)
                                        r1 = r9[r18]
                                        ReturnVal = r23[r1]
                                        r9 = 0
                                        r4 = 0
                                        r1 = 0.05
                                        r23 = ReturnVal(r1, r9, r10, r4)
                                        r33[state] = r23
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r23 = upvalueValues[upvalues[2]]
                                        r9 = "P9?'oW\127\210\242\159\237\201:\223\137#"
                                        r4 = 281985335427
                                        r1 = r23(r9, r4)
                                        state = ReturnVal[r1]
                                        r1 = "Color3"
                                        r23 = _env[r1]
                                        r9 = upvalueValues[upvalues[1]]
                                        r4 = upvalueValues[upvalues[2]]
                                        r35 = "\139\131\151\007\202\191\007"
                                        r39 = 11225936680043
                                        r18 = r4(r35, r39)
                                        r1 = r9[r18]
                                        ReturnVal = r23[r1]
                                        r4 = 230
                                        r1 = 230
                                        r9 = 230
                                        r23 = ReturnVal(r1, r9, r4)
                                        r33[state] = r23
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r23 = upvalueValues[upvalues[2]]
                                        r9 = "\191\223\150\179\128\219\220\200\025,"
                                        r4 = 32697507986297
                                        r1 = r23(r9, r4)
                                        state = ReturnVal[r1]
                                        r1 = "Color3"
                                        r23 = _env[r1]
                                        r9 = upvalueValues[upvalues[1]]
                                        r4 = upvalueValues[upvalues[2]]
                                        r35 = "/\181k\240\219\"\031"
                                        r39 = 19715689014236
                                        r18 = r4(r35, r39)
                                        r1 = r9[r18]
                                        ReturnVal = r23[r1]
                                        r4 = 40
                                        r1 = 40
                                        r9 = 40
                                        r23 = ReturnVal(r1, r9, r4)
                                        r33[state] = r23
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r23 = upvalueValues[upvalues[2]]
                                        r4 = 31269439879392
                                        r9 = "\223\179\140\196"
                                        r1 = r23(r9, r4)
                                        state = ReturnVal[r1]
                                        r9 = "Enum"
                                        r1 = _env[r9]
                                        r4 = upvalueValues[upvalues[1]]
                                        r18 = upvalueValues[upvalues[2]]
                                        r41 = 19523063948163
                                        r39 = "ye\004\137"
                                        r35 = r18(r39, r41)
                                        r9 = r4[r35]
                                        r23 = r1[r9]
                                        r9 = upvalueValues[upvalues[1]]
                                        r4 = upvalueValues[upvalues[2]]
                                        r39 = 26120280338307
                                        r35 = "\020\131\228\191\176\218\189+\187AL\244S\242"
                                        r18 = r4(r35, r39)
                                        r1 = r9[r18]
                                        ReturnVal = r23[r1]
                                        r33[state] = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r23 = upvalueValues[upvalues[2]]
                                        r4 = 32755839630229
                                        r9 = "#\195\148\210\153\020\166\216\233\138"
                                        r1 = r23(r9, r4)
                                        state = ReturnVal[r1]
                                        ReturnVal = true
                                        r33[state] = ReturnVal
                                        r23 = "Instance"
                                        ReturnVal = _env[r23]
                                        r1 = upvalueValues[upvalues[1]]
                                        r9 = upvalueValues[upvalues[2]]
                                        r18 = "\135\193\209"
                                        r35 = 18870148260435
                                        r4 = r9(r18, r35)
                                        r23 = r1[r4]
                                        state = ReturnVal[r23]
                                        r1 = upvalueValues[upvalues[1]]
                                        r9 = upvalueValues[upvalues[2]]
                                        r18 = "\012J]K\190\176\208\209"
                                        r35 = 31881139747325
                                        r4 = r9(r18, r35)
                                        r23 = r1[r4]
                                        ReturnVal = state(r23, r33)
                                        r23 = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r1 = upvalueValues[upvalues[2]]
                                        r18 = 2968036230502
                                        r4 = "\193\137\012\193\022&\131\189\146$eB"
                                        r9 = r1(r4, r18)
                                        state = ReturnVal[r9]
                                        r9 = "UDim"
                                        r1 = _env[r9]
                                        r4 = upvalueValues[upvalues[1]]
                                        r18 = upvalueValues[upvalues[2]]
                                        r41 = 17236499210074
                                        r39 = "\223j\008"
                                        r35 = r18(r39, r41)
                                        r9 = r4[r35]
                                        ReturnVal = r1[r9]
                                        r9 = 0
                                        r4 = 12
                                        r1 = ReturnVal(r9, r4)
                                        r23[state] = r1
                                        ReturnVal = {
                                            r33
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure4 entry 3496960 -> 93, states 93-93
                                    if state == 93 then -- entry 3496960 -> 93
                                        state = upvalueValues[upvalues[1]]
                                        r33 = upvalueValues[upvalues[2]]
                                        r23 = upvalueValues[upvalues[3]]
                                        r10 = args[2]
                                        r30 = args[1]
                                        r9 = "\169.4\178"
                                        r4 = 9627897074051
                                        r1 = r23(r9, r4)
                                        ReturnVal = r33[r1]
                                        r33 = r30
                                        state[ReturnVal] = r33
                                        r9 = "\\\145\243\200\236\237&\212|\139"
                                        r4 = 34154132897312
                                        state = upvalueValues[upvalues[1]]
                                        r30 = nil
                                        r33 = upvalueValues[upvalues[2]]
                                        r23 = upvalueValues[upvalues[3]]
                                        r1 = r23(r9, r4)
                                        ReturnVal = r33[r1]
                                        r33 = r10
                                        state[ReturnVal] = r33
                                        r10 = nil
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure2 entry 13729170 -> 94, states 94-99
                                if state <= 96 then
                                    if state <= 95 then
                                        if state <= 94 then
                                            if state == 94 then -- entry 13729170 -> 94
                                                state = upvalueValues[upvalues[1]]
                                                r33 = upvalueValues[upvalues[2]]
                                                r23 = upvalueValues[upvalues[3]]
                                                r4 = 4215318087594
                                                r9 = "KSr\241\197'\031\164:\196L\232\206^D\237\213\t\2154\224\187\129\134e\254\229}\140 \210.\006\145\016\183\139\235\155.\141o\015=\014\1625\138s\145\025\153RB\181\184=\166K!u\164.\217\016\209\192\183\159{\212\178\026\242\224\192\153\243\134\198"
                                                r1 = r23(r9, r4)
                                                r10 = r33[r1]
                                                r33 = {
                                                    state(r10)
                                                }
                                                ReturnVal = r33[1]
                                                r10 = ReturnVal
                                                state = r10 and (95) or (96)
                                                r30 = r33[2]
                                            end
                                        else
                                            if state == 95 then
                                                ReturnVal = "loadstring"
                                                state = _env[ReturnVal]
                                                ReturnVal = state(r10)
                                                r33 = ReturnVal
                                                state = r33 and (97) or (98)
                                            end
                                        end
                                    else
                                        if state == 96 then
                                            state = upvalueValues[upvalues[4]]
                                            r23 = upvalueValues[upvalues[2]]
                                            r1 = upvalueValues[upvalues[3]]
                                            r4 = "\173\244\014C\224\172\127(\n\166Xd\023\000\191\001:\0281\153\185\252\224"
                                            r18 = 21257781536426
                                            r9 = r1(r4, r18)
                                            r33 = r23[r9]
                                            r9 = "Color3"
                                            r1 = _env[r9]
                                            r4 = upvalueValues[upvalues[2]]
                                            r18 = upvalueValues[upvalues[3]]
                                            r39 = "\\\204\139'I\127i"
                                            r41 = 834408448388
                                            r35 = r18(r39, r41)
                                            r9 = r4[r35]
                                            r23 = r1[r9]
                                            r18 = 100
                                            r4 = 100
                                            r9 = 200
                                            r1 = {
                                                r23(r9, r4, r18)
                                            }
                                            ReturnVal = state(r33, unpack(r1))
                                            state = 99
                                        end
                                    end
                                else
                                    if state <= 98 then
                                        if state <= 97 then
                                            if state == 97 then
                                                r23 = "task"
                                                ReturnVal = _env[r23]
                                                r1 = upvalueValues[upvalues[2]]
                                                r9 = upvalueValues[upvalues[3]]
                                                r18 = "j\005]8K"
                                                r35 = 5127434275155
                                                r4 = r9(r18, r35)
                                                r23 = r1[r4]
                                                state = ReturnVal[r23]
                                                r23 = 0.5
                                                ReturnVal = state(r23, r33)
                                                state = 98
                                            end
                                        else
                                            if state == 98 then
                                                r33 = nil
                                                state = 99
                                            end
                                        end
                                    else
                                        if state == 99 then
                                            r30 = nil
                                            r10 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 114 then
                                if state <= 113 then
                                    -- createClosure0 entry 14389600 -> 100, states 100-113
                                    if state <= 106 then
                                        if state <= 103 then
                                            if state <= 101 then
                                                if state <= 100 then
                                                    if state == 100 then -- entry 14389600 -> 100
                                                        ReturnVal = upvalueValues[upvalues[1]]
                                                        r10 = upvalueValues[upvalues[2]]
                                                        r33 = upvalueValues[upvalues[3]]
                                                        r1 = "\236\000[\249"
                                                        r9 = 8340716113707
                                                        r23 = r33(r1, r9)
                                                        r30 = r10[r23]
                                                        state = ReturnVal[r30]
                                                        r10 = upvalueValues[upvalues[2]]
                                                        r33 = upvalueValues[upvalues[3]]
                                                        r9 = 16515638222346
                                                        r1 = "\255\201\030\136\132\221wk\235\228Y\225"
                                                        r23 = r33(r1, r9)
                                                        ReturnVal = "match"
                                                        ReturnVal = state[ReturnVal]
                                                        r30 = r10[r23]
                                                        ReturnVal = ReturnVal(state, r30)
                                                        r30 = ReturnVal
                                                        r10 = upvalueValues[upvalues[2]]
                                                        r33 = upvalueValues[upvalues[3]]
                                                        r1 = ""
                                                        r9 = 1874280973160
                                                        r23 = r33(r1, r9)
                                                        ReturnVal = r10[r23]
                                                        state = r30 == ReturnVal
                                                        state = state and (101) or (102)
                                                    end
                                                else
                                                    if state == 101 then
                                                        state = upvalueValues[upvalues[4]]
                                                        r33 = upvalueValues[upvalues[2]]
                                                        r23 = upvalueValues[upvalues[3]]
                                                        r4 = 28251743908707
                                                        r9 = "\253I\250\200\202?;\235\212\131N4\002\143\229\190ol%T\222\168"
                                                        r1 = r23(r9, r4)
                                                        r10 = r33[r1]
                                                        r1 = "Color3"
                                                        r23 = _env[r1]
                                                        r9 = upvalueValues[upvalues[2]]
                                                        r4 = upvalueValues[upvalues[3]]
                                                        r35 = "\254\189dD\249\234\168"
                                                        r39 = 27207295185277
                                                        r18 = r4(r35, r39)
                                                        r1 = r9[r18]
                                                        r33 = r23[r1]
                                                        r4 = 60
                                                        r9 = 76
                                                        r1 = 231
                                                        r23 = {
                                                            r33(r1, r9, r4)
                                                        }
                                                        ReturnVal = {
                                                            state(r10, unpack(r23))
                                                        }
                                                        ReturnVal = {
                                                            unpack(ReturnVal)
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state <= 102 then
                                                    if state == 102 then
                                                        state = upvalueValues[upvalues[4]]
                                                        r33 = upvalueValues[upvalues[2]]
                                                        r23 = upvalueValues[upvalues[3]]
                                                        r9 = "v\153Q\209z\214\002\232\008\161\182\209#g\204\244"
                                                        r4 = 22101908219956
                                                        r1 = r23(r9, r4)
                                                        r10 = r33[r1]
                                                        r1 = "Color3"
                                                        r23 = _env[r1]
                                                        r9 = upvalueValues[upvalues[2]]
                                                        r4 = upvalueValues[upvalues[3]]
                                                        r35 = "[\017\025\181\134\128\230"
                                                        r39 = 13247354214424
                                                        r18 = r4(r35, r39)
                                                        r1 = r9[r18]
                                                        r33 = r23[r1]
                                                        r4 = 219
                                                        r1 = 52
                                                        r9 = 152
                                                        r23 = {
                                                            r33(r1, r9, r4)
                                                        }
                                                        ReturnVal = state(r10, unpack(r23))
                                                        state = upvalueValues[upvalues[5]]
                                                        r1 = upvalueValues[upvalues[2]]
                                                        r9 = upvalueValues[upvalues[3]]
                                                        r18 = "\000m\222\031\232|\184s<(]Ml\205u*\131\178\027\002\190\001\"l\252\219\204\196\012\242\174bX\197\028\134\160\179\019"
                                                        r35 = 33176872909913
                                                        r4 = r9(r18, r35)
                                                        r23 = r1[r4]
                                                        r33 = r23 .. r30
                                                        r23 = {
                                                            state(r33)
                                                        }
                                                        ReturnVal = r23[1]
                                                        r33 = allocUpvalue()
                                                        upvalueValues[r33] = ReturnVal
                                                        ReturnVal = upvalueValues[r33]
                                                        state = not ReturnVal
                                                        state = state and (103) or (104)
                                                        r10 = r23[2]
                                                    end
                                                else
                                                    if state == 103 then
                                                        state = upvalueValues[upvalues[4]]
                                                        r9 = upvalueValues[upvalues[2]]
                                                        r4 = upvalueValues[upvalues[3]]
                                                        r39 = 4618454665318
                                                        r35 = "\155\141\158(\245\"\232"
                                                        r18 = r4(r35, r39)
                                                        r1 = r9[r18]
                                                        r4 = state
                                                        state = r10 and (105) or (106)
                                                        r9 = r10
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 105 then
                                                if state <= 104 then
                                                    if state == 104 then
                                                        r1 = createClosure1(120, {
                                                            upvalues[6],
                                                            r33
                                                        })
                                                        ReturnVal = "pcall"
                                                        state = _env[ReturnVal]
                                                        r9 = {
                                                            state(r1)
                                                        }
                                                        ReturnVal = r9[1]
                                                        r1 = ReturnVal
                                                        state = r1 and (107) or (108)
                                                        ReturnVal = r1
                                                        r23 = r9[2]
                                                    end
                                                else
                                                    if state == 105 then
                                                        state = r4
                                                        r23 = r1 .. r9
                                                        r4 = "Color3"
                                                        r9 = _env[r4]
                                                        r18 = upvalueValues[upvalues[2]]
                                                        r35 = upvalueValues[upvalues[3]]
                                                        r41 = "=\218{\138s\233N"
                                                        r5 = 4244063864760
                                                        r39 = r35(r41, r5)
                                                        r4 = r18[r39]
                                                        r1 = r9[r4]
                                                        r35 = 100
                                                        r18 = 100
                                                        r4 = 200
                                                        r9 = {
                                                            r1(r4, r18, r35)
                                                        }
                                                        ReturnVal = {
                                                            state(r23, unpack(r9))
                                                        }
                                                        ReturnVal = {
                                                            unpack(ReturnVal)
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state == 106 then
                                                    r35 = upvalueValues[upvalues[2]]
                                                    r39 = upvalueValues[upvalues[3]]
                                                    r5 = "\171\142\174\236;"
                                                    r31 = 12609473779439
                                                    r41 = r39(r5, r31)
                                                    r18 = r35[r41]
                                                    r9 = r18
                                                    state = 105
                                                end
                                            end
                                        end
                                    else
                                        if state <= 110 then
                                            if state <= 108 then
                                                if state <= 107 then
                                                    if state == 107 then
                                                        r4 = state
                                                        state = r23 and (109) or (110)
                                                        r9 = r23
                                                    end
                                                else
                                                    if state == 108 then
                                                        state = ReturnVal and (111) or (112)
                                                    end
                                                end
                                            else
                                                if state <= 109 then
                                                    if state == 109 then
                                                        r39 = upvalueValues[upvalues[2]]
                                                        r41 = upvalueValues[upvalues[3]]
                                                        r31 = "\163v @4"
                                                        r13 = 33545309912324
                                                        r5 = r41(r31, r13)
                                                        r35 = r39[r5]
                                                        r18 = r23[r35]
                                                        r9 = r18
                                                        state = 110
                                                    end
                                                else
                                                    if state == 110 then
                                                        state = r4
                                                        ReturnVal = r9
                                                        state = 108
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 112 then
                                                if state <= 111 then
                                                    if state == 111 then
                                                        state = upvalueValues[upvalues[4]]
                                                        r4 = upvalueValues[upvalues[2]]
                                                        r18 = upvalueValues[upvalues[3]]
                                                        r39 = "\214\138\026s\148\225\205\023\189s\142\146f{"
                                                        r41 = 9484729225536
                                                        r35 = r18(r39, r41)
                                                        r9 = r4[r35]
                                                        r35 = "Color3"
                                                        r18 = _env[r35]
                                                        r39 = upvalueValues[upvalues[2]]
                                                        r41 = upvalueValues[upvalues[3]]
                                                        r13 = 30211315939060
                                                        r31 = "\014\136U2!6\234"
                                                        r5 = r41(r31, r13)
                                                        r35 = r39[r5]
                                                        r4 = r18[r35]
                                                        r41 = 113
                                                        r39 = 204
                                                        r35 = 46
                                                        r18 = {
                                                            r4(r35, r39, r41)
                                                        }
                                                        ReturnVal = state(r9, unpack(r18))
                                                        r9 = "task"
                                                        ReturnVal = _env[r9]
                                                        r4 = upvalueValues[upvalues[2]]
                                                        r18 = upvalueValues[upvalues[3]]
                                                        r39 = "\181E\200\195;"
                                                        r41 = 23372860828291
                                                        r35 = r18(r39, r41)
                                                        r9 = r4[r35]
                                                        r4 = createClosure3(121, {
                                                            upvalues[7],
                                                            upvalues[8]
                                                        })
                                                        state = ReturnVal[r9]
                                                        r9 = 1
                                                        ReturnVal = state(r9, r4)
                                                        state = 113
                                                    end
                                                else
                                                    if state == 112 then
                                                        state = upvalueValues[upvalues[4]]
                                                        r4 = upvalueValues[upvalues[2]]
                                                        r18 = upvalueValues[upvalues[3]]
                                                        r39 = "\012\244\185U\014\162\248\192\212\173sP\128\134\235"
                                                        r41 = 25883048619796
                                                        r35 = r18(r39, r41)
                                                        r9 = r4[r35]
                                                        r35 = "Color3"
                                                        r18 = _env[r35]
                                                        r39 = upvalueValues[upvalues[2]]
                                                        r41 = upvalueValues[upvalues[3]]
                                                        r13 = 11930104141235
                                                        r31 = "\135AtE<\r\207"
                                                        r5 = r41(r31, r13)
                                                        r35 = r39[r5]
                                                        r4 = r18[r35]
                                                        r41 = 60
                                                        r39 = 76
                                                        r35 = 231
                                                        r18 = {
                                                            r4(r35, r39, r41)
                                                        }
                                                        ReturnVal = state(r9, unpack(r18))
                                                        state = 113
                                                    end
                                                end
                                            else
                                                if state == 113 then
                                                    r1 = nil
                                                    r23 = nil
                                                    r33 = releaseUpvalue(r33)
                                                    r30 = nil
                                                    r10 = nil
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure5 entry 2392683 -> 114, states 114-114
                                    if state == 114 then -- entry 2392683 -> 114
                                        ReturnVal = "setclipboard"
                                        state = _env[ReturnVal]
                                        r10 = upvalueValues[upvalues[1]]
                                        r33 = upvalueValues[upvalues[2]]
                                        r1 = "\205\006\024%p\203$\209W\202\230s\144\209\224\170I+`l\168\172\019tz\019\226\144\2038"
                                        r9 = 25967144185659
                                        r23 = r33(r1, r9)
                                        r30 = r10[r23]
                                        ReturnVal = state(r30)
                                        state = upvalueValues[upvalues[3]]
                                        r10 = upvalueValues[upvalues[1]]
                                        r33 = upvalueValues[upvalues[2]]
                                        r1 = "P\141\003\223\212\004\182M\134\2559.pT\166\165\249D\171u\"\193"
                                        r9 = 25530032107120
                                        r23 = r33(r1, r9)
                                        r30 = r10[r23]
                                        r23 = "Color3"
                                        r33 = _env[r23]
                                        r1 = upvalueValues[upvalues[1]]
                                        r9 = upvalueValues[upvalues[2]]
                                        r18 = "\136\011{\253\026\216\166"
                                        r35 = 1138933940754
                                        r4 = r9(r18, r35)
                                        r23 = r1[r4]
                                        r10 = r33[r23]
                                        r23 = 102
                                        r9 = 102
                                        r1 = 204
                                        r33 = {
                                            r10(r23, r1, r9)
                                        }
                                        ReturnVal = state(r30, unpack(r33))
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure5 entry 1509225 -> 115, states 115-115
                                if state == 115 then -- entry 1509225 -> 115
                                    ReturnVal = "setclipboard"
                                    state = _env[ReturnVal]
                                    r10 = upvalueValues[upvalues[1]]
                                    r33 = upvalueValues[upvalues[2]]
                                    r9 = 33025514732562
                                    r1 = ">\241zk\015$\201\029j\172\020\237\181Z`Y\145sM\162\143p\000\254wo\n\131i\251"
                                    r23 = r33(r1, r9)
                                    r30 = r10[r23]
                                    ReturnVal = state(r30)
                                    state = upvalueValues[upvalues[3]]
                                    r10 = upvalueValues[upvalues[1]]
                                    r33 = upvalueValues[upvalues[2]]
                                    r9 = 4865347373273
                                    r1 = "\253|\197d\\\249\192\232\191\199\135q\143\246\138\168U(\181\226W<M\016\183\020\019\213~\2507\1399A\005\031\253\003*\196l\015\188\012\194\167j~\005\201\206\\`\189\187\186\200)"
                                    r23 = r33(r1, r9)
                                    r30 = r10[r23]
                                    r23 = "Color3"
                                    r33 = _env[r23]
                                    r1 = upvalueValues[upvalues[1]]
                                    r9 = upvalueValues[upvalues[2]]
                                    r35 = 17731263930432
                                    r18 = "`i\154r\020\130j"
                                    r4 = r9(r18, r35)
                                    r23 = r1[r4]
                                    r10 = r33[r23]
                                    r23 = 255
                                    r1 = 128
                                    r9 = 128
                                    r33 = {
                                        r10(r23, r1, r9)
                                    }
                                    ReturnVal = state(r30, unpack(r33))
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        end
                    else
                        if state <= 118 then
                            if state <= 117 then
                                if state <= 116 then
                                    -- createClosure1 entry 11216084 -> 116, states 116-116
                                    if state == 116 then -- entry 11216084 -> 116
                                        ReturnVal = "setclipboard"
                                        state = _env[ReturnVal]
                                        r10 = upvalueValues[upvalues[1]]
                                        r33 = upvalueValues[upvalues[2]]
                                        r9 = 9080665460868
                                        r1 = "\205:I&\185Q\017,:\209X\175\191\016\t/G\205\021\202;\011\248Z\003\141\166X\197\2144\143\004\243\246\012"
                                        r23 = r33(r1, r9)
                                        r30 = r10[r23]
                                        ReturnVal = state(r30)
                                        state = upvalueValues[upvalues[3]]
                                        r10 = upvalueValues[upvalues[1]]
                                        r33 = upvalueValues[upvalues[2]]
                                        r9 = 22858698205588
                                        r1 = "\228\016\011@\196/\142E\206\177\236\227\132\250Y\233I\135&k\197*\198h\020"
                                        r23 = r33(r1, r9)
                                        r30 = r10[r23]
                                        r23 = "Color3"
                                        r33 = _env[r23]
                                        r1 = upvalueValues[upvalues[1]]
                                        r9 = upvalueValues[upvalues[2]]
                                        r18 = "\154\133\001\135-\r\234"
                                        r35 = 18068684972253
                                        r4 = r9(r18, r35)
                                        r23 = r1[r4]
                                        r10 = r33[r23]
                                        r9 = 15
                                        r1 = 196
                                        r23 = 241
                                        r33 = {
                                            r10(r23, r1, r9)
                                        }
                                        ReturnVal = state(r30, unpack(r33))
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure3 entry 1042185 -> 117, states 117-117
                                    if state == 117 then -- entry 1042185 -> 117
                                        ReturnVal = "setclipboard"
                                        state = _env[ReturnVal]
                                        r10 = upvalueValues[upvalues[1]]
                                        r33 = upvalueValues[upvalues[2]]
                                        r1 = "\162\171\199\230G\216P5\147d\015j\1488\220\127\190i\142\023\205\149\230\231S\242\225!\\"
                                        r9 = 4079664973675
                                        r23 = r33(r1, r9)
                                        r30 = r10[r23]
                                        ReturnVal = state(r30)
                                        state = upvalueValues[upvalues[3]]
                                        r10 = upvalueValues[upvalues[1]]
                                        r33 = upvalueValues[upvalues[2]]
                                        r1 = "\173\148\1347\225\255;W\161-\246\165\198\225\222d\021\219\249I\231\151s\246\167"
                                        r9 = 26409401085961
                                        r23 = r33(r1, r9)
                                        r30 = r10[r23]
                                        r23 = "Color3"
                                        r33 = _env[r23]
                                        r1 = upvalueValues[upvalues[1]]
                                        r9 = upvalueValues[upvalues[2]]
                                        r35 = 26430712131603
                                        r18 = "\133\144\159%b\200M"
                                        r4 = r9(r18, r35)
                                        r23 = r1[r4]
                                        r10 = r33[r23]
                                        r9 = 182
                                        r1 = 89
                                        r23 = 155
                                        r33 = {
                                            r10(r23, r1, r9)
                                        }
                                        ReturnVal = state(r30, unpack(r33))
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure4 entry 11849180 -> 118, states 118-118
                                if state == 118 then -- entry 11849180 -> 118
                                    r10 = "Cv"
                                    r33 = 4718871
                                    r30 = r10 ^ r33
                                    ReturnVal = 7550264
                                    state = ReturnVal - r30
                                    r30 = state
                                    ReturnVal = "3OUDzKa"
                                    state = ReturnVal / r30
                                    ReturnVal = {
                                        state
                                    }
                                    state = nil
                                end
                            end
                        else
                            if state <= 120 then
                                if state <= 119 then
                                    -- createClosure2 entry 5830022 -> 119, states 119-119
                                    if state == 119 then -- entry 5830022 -> 119
                                        state = upvalueValues[upvalues[1]]
                                        r33 = upvalueValues[upvalues[2]]
                                        r23 = upvalueValues[upvalues[3]]
                                        r4 = 12130861585936
                                        r9 = "\147\n\228"
                                        r1 = r23(r9, r4)
                                        r10 = r33[r1]
                                        r33 = upvalueValues[upvalues[4]]
                                        r1 = upvalueValues[upvalues[2]]
                                        r9 = upvalueValues[upvalues[3]]
                                        r18 = "l\145[\218\200\159"
                                        r35 = 12839511381850
                                        r4 = r9(r18, r35)
                                        r23 = r1[r4]
                                        r9 = upvalueValues[upvalues[2]]
                                        r4 = upvalueValues[upvalues[3]]
                                        r35 = "M.\254"
                                        r39 = 14880651254545
                                        r18 = r4(r35, r39)
                                        r1 = r9[r18]
                                        r30 = {
                                            [r10] = r33,
                                            [r23] = r1
                                        }
                                        ReturnVal = {
                                            state(r30)
                                        }
                                        ReturnVal = {
                                            unpack(ReturnVal)
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure1 entry 3026818 -> 120, states 120-120
                                    if state == 120 then -- entry 3026818 -> 120
                                        state = upvalueValues[upvalues[1]]
                                        r30 = upvalueValues[upvalues[2]]
                                        r10 = "JSONDecode"
                                        r10 = state[r10]
                                        ReturnVal = {
                                            r10(state, r30)
                                        }
                                        ReturnVal = {
                                            unpack(ReturnVal)
                                        }
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure3 entry 6461405 -> 121, states 121-121
                                if state == 121 then -- entry 6461405 -> 121
                                    state = upvalueValues[upvalues[1]]
                                    ReturnVal = "Destroy"
                                    ReturnVal = state[ReturnVal]
                                    ReturnVal = ReturnVal(state)
                                    state = upvalueValues[upvalues[2]]
                                    ReturnVal = state()
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
        currentUpvalueId = 0
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
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 2841724
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 2841724
                    end
                })
            end
        end
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)