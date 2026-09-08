return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, allocUpvalue, upvalueRefCounts, createClosure, createClosure4, createClosure5, createClosure3, createClosure6, vm, createClosure2, releaseUpvalues, createUpvalueProxy, createClosure1, upvalueValues, releaseUpvalue, createClosure7, createClosure0, currentUpvalueId)
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
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
            end
            return closure
        end
        upvalueValues = {}
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, ReturnVal, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35
            while state do
                if state <= 78 then
                    if state <= 63 then
                        if state <= 34 then
                            if state <= 32 then
                                if state <= 31 then
                                    -- root entry 13566955 -> 1, states 1-31
                                    if state <= 16 then
                                        if state <= 8 then
                                            if state <= 4 then
                                                if state <= 2 then
                                                    if state <= 1 then
                                                        if state == 1 then -- entry 13566955 -> 1
                                                            r22 = allocUpvalue()
                                                            state = true
                                                            upvalueValues[r22] = state
                                                            r19 = "string"
                                                            ReturnVal = _env[r19]
                                                            r19 = "gmatch"
                                                            state = ReturnVal[r19]
                                                            r5 = allocUpvalue()
                                                            r19 = allocUpvalue()
                                                            upvalueValues[r19] = state
                                                            state = createClosure1(32, {})
                                                            upvalueValues[r5] = state
                                                            r25 = allocUpvalue()
                                                            r11 = createClosure5(33, {
                                                                r25
                                                            })
                                                            state = false
                                                            upvalueValues[r25] = state
                                                            r6 = "pcall"
                                                            r14 = _env[r6]
                                                            r6 = r14(r11)
                                                            state = r6 and (2) or (3)
                                                            r16 = args
                                                            ReturnVal = r6
                                                        end
                                                    else
                                                        if state == 2 then
                                                            r14 = upvalueValues[r25]
                                                            ReturnVal = r14
                                                            state = 3
                                                        end
                                                    end
                                                else
                                                    if state <= 3 then
                                                        if state == 3 then
                                                            r14 = ReturnVal
                                                            r6 = "math"
                                                            ReturnVal = _env[r6]
                                                            r6 = "random"
                                                            state = ReturnVal[r6]
                                                            r6 = allocUpvalue()
                                                            upvalueValues[r6] = state
                                                            r11 = "table"
                                                            ReturnVal = _env[r11]
                                                            r11 = "concat"
                                                            state = ReturnVal[r11]
                                                            r11 = state
                                                            r24 = state
                                                            r20 = "table"
                                                            r12 = _env[r20]
                                                            state = r12 and (4) or (5)
                                                            r17 = r12
                                                        end
                                                    else
                                                        if state == 4 then
                                                            r30 = "table"
                                                            r20 = _env[r30]
                                                            r30 = "unpack"
                                                            r12 = r20[r30]
                                                            r17 = r12
                                                            state = 5
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 6 then
                                                    if state <= 5 then
                                                        if state == 5 then
                                                            state = r24
                                                            state = r17 and (6) or (7)
                                                            ReturnVal = r17
                                                        end
                                                    else
                                                        if state == 6 then
                                                            r17 = allocUpvalue()
                                                            upvalueValues[r17] = ReturnVal
                                                            state = upvalueValues[r6]
                                                            r31 = createClosure0(34, {})
                                                            r24 = 3
                                                            r12 = 65
                                                            ReturnVal = state(r24, r12)
                                                            r24 = allocUpvalue()
                                                            upvalueValues[r24] = ReturnVal
                                                            r30 = "pcall"
                                                            ReturnVal = _env[r30]
                                                            state = 0
                                                            r30 = {
                                                                ReturnVal(r31)
                                                            }
                                                            r12 = state
                                                            state = 0
                                                            r20 = state
                                                            state = {
                                                                unpack(r30)
                                                            }
                                                            r30 = state
                                                            ReturnVal = 2
                                                            state = r30[ReturnVal]
                                                            r31 = state
                                                            ReturnVal = "tonumber"
                                                            state = _env[ReturnVal]
                                                            r9 = upvalueValues[r19]
                                                            r18 = "tostring"
                                                            r23 = _env[r18]
                                                            r18 = r23(r31)
                                                            r23 = ":(%d*):"
                                                            r33 = r9(r18, r23)
                                                            r9 = {
                                                                r33()
                                                            }
                                                            ReturnVal = state(unpack(r9))
                                                            r9 = allocUpvalue()
                                                            upvalueValues[r9] = ReturnVal
                                                            r33 = upvalueValues[r24]
                                                            r23 = r33
                                                            r33 = 1
                                                            r18 = r33
                                                            r33 = 0
                                                            r32 = r18 < r33
                                                            ReturnVal = 1
                                                            r33 = ReturnVal - r18
                                                            state = 8
                                                        end
                                                    end
                                                else
                                                    if state <= 7 then
                                                        if state == 7 then
                                                            r24 = "unpack"
                                                            r17 = _env[r24]
                                                            ReturnVal = r17
                                                            state = 6
                                                        end
                                                    else
                                                        if state == 8 then
                                                            r13 = not r32
                                                            r33 = r33 + r18
                                                            ReturnVal = r33 <= r23
                                                            ReturnVal = r13 and ReturnVal
                                                            r13 = r33 >= r23
                                                            r13 = r32 and r13
                                                            ReturnVal = r13 or ReturnVal
                                                            r13 = (9)
                                                            state = ReturnVal and r13
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
                                                            r13 = allocUpvalue()
                                                            upvalueValues[r13] = r33
                                                            r10 = "math"
                                                            ReturnVal = _env[r10]
                                                            r10 = "random"
                                                            state = ReturnVal[r10]
                                                            r35 = 100
                                                            r10 = 1
                                                            ReturnVal = state(r10, r35)
                                                            r10 = allocUpvalue()
                                                            upvalueValues[r10] = ReturnVal
                                                            state = upvalueValues[r6]
                                                            r28 = 255
                                                            r35 = 0
                                                            ReturnVal = state(r35, r28)
                                                            r35 = allocUpvalue()
                                                            upvalueValues[r35] = ReturnVal
                                                            state = upvalueValues[r6]
                                                            r2 = upvalueValues[r10]
                                                            r28 = 1
                                                            ReturnVal = state(r28, r2)
                                                            r28 = allocUpvalue()
                                                            upvalueValues[r28] = ReturnVal
                                                            ReturnVal = upvalueValues[r6]
                                                            r27 = 2
                                                            r7 = 1
                                                            r2 = ReturnVal(r7, r27)
                                                            ReturnVal = 1
                                                            state = r2 == ReturnVal
                                                            r2 = allocUpvalue()
                                                            upvalueValues[r2] = state
                                                            r26 = "tostring"
                                                            r21 = _env[r26]
                                                            r29 = upvalueValues[r6]
                                                            r15 = 10000
                                                            r1 = 0
                                                            r8 = {
                                                                r29(r1, r15)
                                                            }
                                                            r26 = r21(unpack(r8))
                                                            r21 = ":"
                                                            r34 = r26 .. r21
                                                            r27 = ":"
                                                            r7 = r27 .. r34
                                                            state = "gsub"
                                                            state = r31[state]
                                                            ReturnVal = ":(%d*):"
                                                            state = state(r31, ReturnVal, r7)
                                                            r7 = allocUpvalue()
                                                            upvalueValues[r7] = state
                                                            r27 = "pcall"
                                                            ReturnVal = _env[r27]
                                                            r34 = createClosure3(35, {
                                                                r6,
                                                                r13,
                                                                r24,
                                                                r19,
                                                                r22,
                                                                r9,
                                                                r2,
                                                                r7,
                                                                r10,
                                                                r28,
                                                                r35,
                                                                r17
                                                            })
                                                            r27 = {
                                                                ReturnVal(r34)
                                                            }
                                                            state = {
                                                                unpack(r27)
                                                            }
                                                            r27 = state
                                                            state = upvalueValues[r2]
                                                            state = state and (11) or (12)
                                                        end
                                                    else
                                                        if state == 10 then
                                                            r23 = upvalueValues[r22]
                                                            state = r23 and (13) or (14)
                                                            r33 = r23
                                                        end
                                                    end
                                                else
                                                    if state <= 11 then
                                                        if state == 11 then
                                                            r34 = upvalueValues[r22]
                                                            state = r34 and (15) or (16)
                                                            ReturnVal = r34
                                                        end
                                                    else
                                                        if state == 12 then
                                                            r21 = upvalueValues[r22]
                                                            state = r21 and (17) or (18)
                                                            r34 = r21
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 14 then
                                                    if state <= 13 then
                                                        if state == 13 then
                                                            r23 = r12 == r20
                                                            r33 = r23
                                                            state = 14
                                                        end
                                                    else
                                                        if state == 14 then
                                                            upvalueValues[r22] = r33
                                                            state = upvalueValues[r22]
                                                            state = state and (19) or (20)
                                                        end
                                                    end
                                                else
                                                    if state <= 15 then
                                                        if state == 15 then
                                                            r21 = state
                                                            r8 = 1
                                                            r29 = r27[r8]
                                                            r8 = false
                                                            r26 = r29 == r8
                                                            state = r26 and (21) or (22)
                                                            r34 = r26
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
                                                            r26 = 1
                                                            r21 = r27[r26]
                                                            r34 = r21
                                                            state = 18
                                                        end
                                                    else
                                                        if state == 18 then
                                                            upvalueValues[r22] = r34
                                                            r8 = upvalueValues[r28]
                                                            r1 = 1
                                                            r29 = r8 + r1
                                                            r26 = r27[r29]
                                                            r21 = r12 + r26
                                                            r26 = 256
                                                            state = r21 % r26
                                                            r12 = state
                                                            r29 = upvalueValues[r35]
                                                            r26 = r20 + r29
                                                            r29 = 256
                                                            r21 = r26 % r29
                                                            r20 = r21
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
                                                            r8 = 2
                                                            r29 = r27[r8]
                                                            r8 = upvalueValues[r7]
                                                            r26 = r29 == r8
                                                            r34 = r26
                                                            state = 22
                                                        end
                                                    else
                                                        if state == 22 then
                                                            state = r21
                                                            ReturnVal = r34
                                                            state = 16
                                                        end
                                                    end
                                                else
                                                    if state <= 23 then
                                                        if state == 23 then
                                                            r7 = releaseUpvalue(r7)
                                                            r13 = releaseUpvalue(r13)
                                                            r2 = releaseUpvalue(r2)
                                                            r27 = nil
                                                            r28 = releaseUpvalue(r28)
                                                            r10 = releaseUpvalue(r10)
                                                            r35 = releaseUpvalue(r35)
                                                            state = 8
                                                        end
                                                    else
                                                        if state == 24 then
                                                            r24 = releaseUpvalue(r24)
                                                            r9 = releaseUpvalue(r9)
                                                            r19 = releaseUpvalue(r19)
                                                            r25 = releaseUpvalue(r25)
                                                            r22 = releaseUpvalue(r22)
                                                            r17 = releaseUpvalue(r17)
                                                            r5 = releaseUpvalue(r5)
                                                            r5 = allocUpvalue()
                                                            r6 = releaseUpvalue(r6)
                                                            r22 = nil
                                                            upvalueValues[r5] = r22
                                                            r22 = allocUpvalue()
                                                            r24 = allocUpvalue()
                                                            r19 = nil
                                                            upvalueValues[r22] = r19
                                                            r14 = nil
                                                            r14 = "math"
                                                            r25 = _env[r14]
                                                            r14 = "floor"
                                                            r19 = r25[r14]
                                                            r25 = allocUpvalue()
                                                            upvalueValues[r25] = r19
                                                            r20 = nil
                                                            r20 = allocUpvalue()
                                                            r6 = "math"
                                                            r14 = _env[r6]
                                                            r6 = "random"
                                                            r19 = r14[r6]
                                                            r11 = nil
                                                            r11 = "table"
                                                            r6 = _env[r11]
                                                            r11 = "remove"
                                                            r14 = r6[r11]
                                                            r12 = nil
                                                            r12 = {}
                                                            r17 = "string"
                                                            r11 = _env[r17]
                                                            r17 = "char"
                                                            r6 = r11[r17]
                                                            r17 = allocUpvalue()
                                                            r11 = 0
                                                            upvalueValues[r17] = r11
                                                            r11 = 2
                                                            upvalueValues[r24] = r11
                                                            r30 = nil
                                                            r30 = {}
                                                            r11 = {}
                                                            upvalueValues[r20] = r12
                                                            r9 = 256
                                                            r32 = r9
                                                            r9 = 1
                                                            r13 = r9
                                                            r9 = 0
                                                            r10 = r13 < r9
                                                            r31 = nil
                                                            r31 = 1
                                                            r9 = r31 - r13
                                                            r12 = 0
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
                                                                r5
                                                            })
                                                            r23 = {
                                                                state()
                                                            }
                                                            ReturnVal = {
                                                                unpack(r23)
                                                            }
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 26 then
                                                            r35 = not r10
                                                            r9 = r9 + r13
                                                            r31 = r9 <= r32
                                                            r31 = r35 and r31
                                                            r35 = r9 >= r32
                                                            r35 = r10 and r35
                                                            r31 = r35 or r31
                                                            r35 = (27)
                                                            state = r31 and r35
                                                            r31 = (28)
                                                            state = state or r31
                                                        end
                                                    end
                                                else
                                                    if state <= 27 then
                                                        if state == 27 then
                                                            r31 = r9
                                                            r35 = r31
                                                            r30[r31] = r35
                                                            r31 = nil
                                                            state = 26
                                                        end
                                                    else
                                                        if state == 28 then
                                                            r9 = #r30
                                                            r32 = 0
                                                            r31 = r9 == r32
                                                            state = 29
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 30 then
                                                    if state <= 29 then
                                                        if state == 29 then
                                                            r9 = 1
                                                            r32 = #r30
                                                            r31 = r19(r9, r32)
                                                            r9 = r14(r30, r31)
                                                            r32 = upvalueValues[r20]
                                                            r35 = 1
                                                            r10 = r9 - r35
                                                            r31 = nil
                                                            r13 = r6(r10)
                                                            r32[r9] = r13
                                                            r9 = nil
                                                            state = 30
                                                        end
                                                    else
                                                        if state == 30 then
                                                            r9 = #r30
                                                            r32 = 0
                                                            r31 = r9 == r32
                                                            state = r31 and (31) or (29)
                                                        end
                                                    end
                                                else
                                                    if state == 31 then
                                                        r12 = nil
                                                        r31 = {}
                                                        r13 = allocUpvalue()
                                                        r9 = allocUpvalue()
                                                        r35 = {}
                                                        r32 = createClosure5(51, {
                                                            r9,
                                                            r17,
                                                            r24,
                                                            r25
                                                        })
                                                        r25 = releaseUpvalue(r25)
                                                        r25 = "game"
                                                        upvalueValues[r9] = r31
                                                        r31 = allocUpvalue()
                                                        r14 = nil
                                                        r12 = 34657371422474
                                                        upvalueValues[r31] = r32
                                                        r32 = {}
                                                        r2 = "__index"
                                                        upvalueValues[r13] = r32
                                                        r10 = "setmetatable"
                                                        r32 = _env[r10]
                                                        r19 = nil
                                                        r7 = upvalueValues[r13]
                                                        r26 = nil
                                                        r27 = "__metatable"
                                                        r28 = {
                                                            [r2] = r7,
                                                            [r27] = r26
                                                        }
                                                        r10 = r32(r35, r28)
                                                        upvalueValues[r22] = r10
                                                        r32 = createClosure3(57, {
                                                            r13,
                                                            r9,
                                                            r20,
                                                            r17,
                                                            r24,
                                                            r31
                                                        })
                                                        upvalueValues[r5] = r32
                                                        r20 = releaseUpvalue(r20)
                                                        r17 = releaseUpvalue(r17)
                                                        r13 = releaseUpvalue(r13)
                                                        r31 = releaseUpvalue(r31)
                                                        r24 = releaseUpvalue(r24)
                                                        r19 = _env[r25]
                                                        r9 = releaseUpvalue(r9)
                                                        r6 = nil
                                                        r6 = upvalueValues[r22]
                                                        r11 = nil
                                                        r11 = upvalueValues[r5]
                                                        r20 = 27413142532573
                                                        r24 = "&n\156{>\006\251"
                                                        r25 = "GetService"
                                                        r25 = r19[r25]
                                                        r17 = r11(r24, r12)
                                                        r14 = r6[r17]
                                                        r25 = r25(r19, r14)
                                                        r13 = "\131\214\220"
                                                        r6 = upvalueValues[r22]
                                                        r12 = 27763438088832
                                                        r24 = "\023U\002\182\217?\191\149i\186\151"
                                                        r11 = upvalueValues[r5]
                                                        r17 = r11(r24, r12)
                                                        r12 = "\246\144#\025\143\1551nn"
                                                        r14 = r6[r17]
                                                        r19 = r25[r14]
                                                        r11 = upvalueValues[r22]
                                                        r14 = "WaitForChild"
                                                        r17 = upvalueValues[r5]
                                                        r14 = r19[r14]
                                                        r31 = 32805779405740
                                                        r24 = r17(r12, r20)
                                                        r6 = r11[r24]
                                                        r14 = r14(r19, r6)
                                                        r17 = "Instance"
                                                        r11 = _env[r17]
                                                        r24 = upvalueValues[r22]
                                                        r12 = upvalueValues[r5]
                                                        r9 = 2544230073504
                                                        r30 = nil
                                                        r30 = "\250_\162"
                                                        r20 = r12(r30, r31)
                                                        r17 = r24[r20]
                                                        r31 = 17948568510629
                                                        r6 = r11[r17]
                                                        r24 = upvalueValues[r22]
                                                        r12 = upvalueValues[r5]
                                                        r30 = "\141\217*J\183q\188=\187"
                                                        r20 = r12(r30, r31)
                                                        r17 = r24[r20]
                                                        r11 = r6(r17)
                                                        r31 = 5531246922255
                                                        r6 = allocUpvalue()
                                                        upvalueValues[r6] = r11
                                                        r11 = upvalueValues[r6]
                                                        r24 = upvalueValues[r22]
                                                        r12 = upvalueValues[r5]
                                                        r30 = "C\166Sa"
                                                        r20 = r12(r30, r31)
                                                        r32 = 27127540609368
                                                        r27 = 24709113392370
                                                        r19 = nil
                                                        r31 = " \197s\247\153>\240\180\164\172\n"
                                                        r17 = r24[r20]
                                                        r12 = upvalueValues[r22]
                                                        r20 = upvalueValues[r5]
                                                        r30 = r20(r31, r9)
                                                        r24 = r12[r30]
                                                        r11[r17] = r24
                                                        r11 = upvalueValues[r6]
                                                        r35 = 30115651565255
                                                        r24 = upvalueValues[r22]
                                                        r31 = 25593546141325
                                                        r12 = upvalueValues[r5]
                                                        r30 = "\223\174\176\251X\209\027\215\001\221\030+"
                                                        r20 = r12(r30, r31)
                                                        r17 = r24[r20]
                                                        r24 = false
                                                        r9 = 23959250381716
                                                        r11[r17] = r24
                                                        r31 = 31322808940793
                                                        r11 = upvalueValues[r6]
                                                        r24 = upvalueValues[r22]
                                                        r12 = upvalueValues[r5]
                                                        r30 = "\199\201%\226\211\183"
                                                        r20 = r12(r30, r31)
                                                        r17 = r24[r20]
                                                        r24 = r14
                                                        r11[r17] = r24
                                                        r31 = "\195\006H"
                                                        r24 = "Instance"
                                                        r17 = _env[r24]
                                                        r12 = upvalueValues[r22]
                                                        r20 = upvalueValues[r5]
                                                        r30 = r20(r31, r9)
                                                        r24 = r12[r30]
                                                        r9 = 10746694210444
                                                        r11 = r17[r24]
                                                        r12 = upvalueValues[r22]
                                                        r31 = "\024\231\030\222#"
                                                        r20 = upvalueValues[r5]
                                                        r30 = r20(r31, r9)
                                                        r9 = 4682929784964
                                                        r24 = r12[r30]
                                                        r17 = r11(r24)
                                                        r11 = allocUpvalue()
                                                        upvalueValues[r11] = r17
                                                        r17 = upvalueValues[r11]
                                                        r12 = upvalueValues[r22]
                                                        r20 = upvalueValues[r5]
                                                        r31 = "\174\000\015\232"
                                                        r30 = r20(r31, r9)
                                                        r24 = r12[r30]
                                                        r20 = upvalueValues[r22]
                                                        r30 = upvalueValues[r5]
                                                        r9 = "\0149\136\230A\178Z1\216"
                                                        r31 = r30(r9, r32)
                                                        r9 = 5183511120237
                                                        r12 = r20[r31]
                                                        r17[r24] = r12
                                                        r17 = upvalueValues[r11]
                                                        r12 = upvalueValues[r22]
                                                        r20 = upvalueValues[r5]
                                                        r31 = "(;oT"
                                                        r30 = r20(r31, r9)
                                                        r24 = r12[r30]
                                                        r30 = "UDim2"
                                                        r20 = _env[r30]
                                                        r31 = upvalueValues[r22]
                                                        r9 = upvalueValues[r5]
                                                        r32 = r9(r13, r35)
                                                        r30 = r31[r32]
                                                        r12 = r20[r30]
                                                        r9 = 0
                                                        r31 = 350
                                                        r30 = 0
                                                        r32 = 200
                                                        r20 = r12(r30, r31, r9, r32)
                                                        r17[r24] = r20
                                                        r31 = "g\255\135\174\209\145\177\223"
                                                        r17 = upvalueValues[r11]
                                                        r9 = 32357092588251
                                                        r12 = upvalueValues[r22]
                                                        r35 = 28605549769736
                                                        r20 = upvalueValues[r5]
                                                        r30 = r20(r31, r9)
                                                        r13 = "\198\237\t"
                                                        r24 = r12[r30]
                                                        r30 = "UDim2"
                                                        r20 = _env[r30]
                                                        r31 = upvalueValues[r22]
                                                        r9 = upvalueValues[r5]
                                                        r32 = r9(r13, r35)
                                                        r30 = r31[r32]
                                                        r12 = r20[r30]
                                                        r31 = -175
                                                        r9 = 0.5
                                                        r32 = -100
                                                        r30 = 0.5
                                                        r20 = r12(r30, r31, r9, r32)
                                                        r9 = 22175639644246
                                                        r17[r24] = r20
                                                        r17 = upvalueValues[r11]
                                                        r12 = upvalueValues[r22]
                                                        r20 = upvalueValues[r5]
                                                        r31 = "\021\002(L\204Y@,$\196\186g\224\205\133\186"
                                                        r13 = "\004\137\215\253*o\150"
                                                        r35 = 5752010754678
                                                        r30 = r20(r31, r9)
                                                        r24 = r12[r30]
                                                        r30 = "Color3"
                                                        r20 = _env[r30]
                                                        r31 = upvalueValues[r22]
                                                        r9 = upvalueValues[r5]
                                                        r32 = r9(r13, r35)
                                                        r30 = r31[r32]
                                                        r12 = r20[r30]
                                                        r31 = 30
                                                        r9 = 30
                                                        r30 = 30
                                                        r20 = r12(r30, r31, r9)
                                                        r17[r24] = r20
                                                        r31 = "g3\174\175\1930Y?%\235\222Z|\192Y"
                                                        r17 = upvalueValues[r11]
                                                        r9 = 2259070518299
                                                        r12 = upvalueValues[r22]
                                                        r20 = upvalueValues[r5]
                                                        r30 = r20(r31, r9)
                                                        r24 = r12[r30]
                                                        r12 = 0
                                                        r9 = 31704660277675
                                                        r17[r24] = r12
                                                        r17 = upvalueValues[r11]
                                                        r31 = "9\159\238\030\127}"
                                                        r12 = upvalueValues[r22]
                                                        r20 = upvalueValues[r5]
                                                        r30 = r20(r31, r9)
                                                        r24 = r12[r30]
                                                        r9 = 7800041705008
                                                        r12 = true
                                                        r17[r24] = r12
                                                        r17 = upvalueValues[r11]
                                                        r12 = upvalueValues[r22]
                                                        r31 = "5\254\192\147St\201WM"
                                                        r20 = upvalueValues[r5]
                                                        r30 = r20(r31, r9)
                                                        r9 = 14087616354720
                                                        r24 = r12[r30]
                                                        r35 = 6218775120719
                                                        r12 = true
                                                        r17[r24] = r12
                                                        r17 = upvalueValues[r11]
                                                        r12 = upvalueValues[r22]
                                                        r31 = "\174\251\234\021L\221"
                                                        r20 = upvalueValues[r5]
                                                        r30 = r20(r31, r9)
                                                        r24 = r12[r30]
                                                        r12 = upvalueValues[r6]
                                                        r9 = "\190\242("
                                                        r13 = "\003\006\1410\197F\216"
                                                        r17[r24] = r12
                                                        r12 = "Instance"
                                                        r24 = _env[r12]
                                                        r20 = upvalueValues[r22]
                                                        r30 = upvalueValues[r5]
                                                        r32 = 18355232678243
                                                        r31 = r30(r9, r32)
                                                        r12 = r20[r31]
                                                        r17 = r24[r12]
                                                        r9 = "0c\235\222U\189\0250"
                                                        r20 = upvalueValues[r22]
                                                        r30 = upvalueValues[r5]
                                                        r32 = 9508374303051
                                                        r31 = r30(r9, r32)
                                                        r12 = r20[r31]
                                                        r9 = 3057893377423
                                                        r31 = "\249\176\164\012\n"
                                                        r24 = r17(r12)
                                                        r12 = upvalueValues[r22]
                                                        r20 = upvalueValues[r5]
                                                        r30 = r20(r31, r9)
                                                        r17 = r12[r30]
                                                        r30 = "Color3"
                                                        r20 = _env[r30]
                                                        r31 = upvalueValues[r22]
                                                        r9 = upvalueValues[r5]
                                                        r32 = r9(r13, r35)
                                                        r30 = r31[r32]
                                                        r13 = 15763299720364
                                                        r12 = r20[r30]
                                                        r31 = 120
                                                        r9 = 255
                                                        r2 = 17009340604144
                                                        r30 = 0
                                                        r20 = r12(r30, r31, r9)
                                                        r9 = 1886353163118
                                                        r24[r17] = r20
                                                        r12 = upvalueValues[r22]
                                                        r35 = "\227\205\155"
                                                        r20 = upvalueValues[r5]
                                                        r31 = "\248EHZ\209\020\174\135\235"
                                                        r30 = r20(r31, r9)
                                                        r17 = r12[r30]
                                                        r9 = 14547695311478
                                                        r12 = 3
                                                        r24[r17] = r12
                                                        r12 = upvalueValues[r22]
                                                        r20 = upvalueValues[r5]
                                                        r31 = "9\008(\1476o"
                                                        r30 = r20(r31, r9)
                                                        r20 = "Instance"
                                                        r17 = r12[r30]
                                                        r12 = upvalueValues[r11]
                                                        r24[r17] = r12
                                                        r12 = _env[r20]
                                                        r30 = upvalueValues[r22]
                                                        r31 = upvalueValues[r5]
                                                        r32 = "os\147"
                                                        r9 = r31(r32, r13)
                                                        r20 = r30[r9]
                                                        r17 = r12[r20]
                                                        r30 = upvalueValues[r22]
                                                        r13 = 23110886402569
                                                        r31 = upvalueValues[r5]
                                                        r32 = "\246\028r\164\192\196\189+"
                                                        r9 = r31(r32, r13)
                                                        r20 = r30[r9]
                                                        r9 = "D:\248\170\023\178\166\247P\215\203\213"
                                                        r12 = r17(r20)
                                                        r20 = upvalueValues[r22]
                                                        r30 = upvalueValues[r5]
                                                        r32 = 14020694645120
                                                        r31 = r30(r9, r32)
                                                        r17 = r20[r31]
                                                        r31 = "UDim"
                                                        r30 = _env[r31]
                                                        r9 = upvalueValues[r22]
                                                        r32 = upvalueValues[r5]
                                                        r28 = 8342365703980
                                                        r13 = r32(r35, r28)
                                                        r31 = r9[r13]
                                                        r9 = 8
                                                        r20 = r30[r31]
                                                        r31 = 0
                                                        r30 = r20(r31, r9)
                                                        r9 = "\152\nu j\200"
                                                        r12[r17] = r30
                                                        r20 = upvalueValues[r22]
                                                        r35 = 11642101945645
                                                        r30 = upvalueValues[r5]
                                                        r32 = 15339656829927
                                                        r31 = r30(r9, r32)
                                                        r17 = r20[r31]
                                                        r20 = upvalueValues[r11]
                                                        r13 = "\224t\139"
                                                        r12[r17] = r20
                                                        r7 = 3614817404563
                                                        r26 = 5976582048479
                                                        r30 = "Instance"
                                                        r20 = _env[r30]
                                                        r14 = nil
                                                        r31 = upvalueValues[r22]
                                                        r9 = upvalueValues[r5]
                                                        r32 = r9(r13, r35)
                                                        r35 = 26290934214610
                                                        r13 = "\203\253\030*\198\127\209\028\145"
                                                        r30 = r31[r32]
                                                        r17 = r20[r30]
                                                        r31 = upvalueValues[r22]
                                                        r9 = upvalueValues[r5]
                                                        r32 = r9(r13, r35)
                                                        r35 = 14186332035534
                                                        r30 = r31[r32]
                                                        r20 = r17(r30)
                                                        r30 = upvalueValues[r22]
                                                        r31 = upvalueValues[r5]
                                                        r13 = 20870903768566
                                                        r32 = "\151hV<"
                                                        r9 = r31(r32, r13)
                                                        r17 = r30[r9]
                                                        r31 = upvalueValues[r22]
                                                        r9 = upvalueValues[r5]
                                                        r13 = "\189\188N\216\206\196\002b\147\192"
                                                        r32 = r9(r13, r35)
                                                        r30 = r31[r32]
                                                        r13 = 16700108267104
                                                        r20[r17] = r30
                                                        r30 = upvalueValues[r22]
                                                        r31 = upvalueValues[r5]
                                                        r32 = "\006\216\203\023"
                                                        r9 = r31(r32, r13)
                                                        r17 = r30[r9]
                                                        r9 = "UDim2"
                                                        r31 = _env[r9]
                                                        r32 = upvalueValues[r22]
                                                        r13 = upvalueValues[r5]
                                                        r28 = "\185\214`"
                                                        r35 = r13(r28, r2)
                                                        r9 = r32[r35]
                                                        r35 = 40
                                                        r2 = 27446802477548
                                                        r30 = r31[r9]
                                                        r9 = 1
                                                        r32 = -20
                                                        r13 = 0
                                                        r31 = r30(r9, r32, r13, r35)
                                                        r20[r17] = r31
                                                        r13 = 2961210312034
                                                        r30 = upvalueValues[r22]
                                                        r31 = upvalueValues[r5]
                                                        r32 = "\206Na\245>\137\203\137"
                                                        r9 = r31(r32, r13)
                                                        r17 = r30[r9]
                                                        r9 = "UDim2"
                                                        r31 = _env[r9]
                                                        r32 = upvalueValues[r22]
                                                        r13 = upvalueValues[r5]
                                                        r28 = "\212#r"
                                                        r35 = r13(r28, r2)
                                                        r9 = r32[r35]
                                                        r30 = r31[r9]
                                                        r35 = 10
                                                        r13 = 0
                                                        r9 = 0
                                                        r32 = 10
                                                        r31 = r30(r9, r32, r13, r35)
                                                        r20[r17] = r31
                                                        r30 = upvalueValues[r22]
                                                        r31 = upvalueValues[r5]
                                                        r13 = 21692270405493
                                                        r32 = "\229\192\251\220\244\255\220\029\006\247\254\247\180\141a\231\024\017p\173\212F"
                                                        r9 = r31(r32, r13)
                                                        r17 = r30[r9]
                                                        r30 = 1
                                                        r20[r17] = r30
                                                        r30 = upvalueValues[r22]
                                                        r31 = upvalueValues[r5]
                                                        r13 = 30088750921403
                                                        r32 = "\166\211b\023"
                                                        r9 = r31(r32, r13)
                                                        r35 = 32630313614170
                                                        r17 = r30[r9]
                                                        r31 = upvalueValues[r22]
                                                        r9 = upvalueValues[r5]
                                                        r13 = "=I\163\234\026\0298\025\223\242;w"
                                                        r32 = r9(r13, r35)
                                                        r30 = r31[r32]
                                                        r13 = 16623549865532
                                                        r20[r17] = r30
                                                        r32 = "\139\165\004\198\211\241\193\012\184\252"
                                                        r28 = "\224\n\189\250}\196\023"
                                                        r2 = 27261471404438
                                                        r12 = nil
                                                        r30 = upvalueValues[r22]
                                                        r31 = upvalueValues[r5]
                                                        r9 = r31(r32, r13)
                                                        r17 = r30[r9]
                                                        r9 = "Color3"
                                                        r31 = _env[r9]
                                                        r32 = upvalueValues[r22]
                                                        r13 = upvalueValues[r5]
                                                        r35 = r13(r28, r2)
                                                        r9 = r32[r35]
                                                        r13 = 255
                                                        r30 = r31[r9]
                                                        r2 = "\181N\000l"
                                                        r9 = 255
                                                        r32 = 255
                                                        r31 = r30(r9, r32, r13)
                                                        r20[r17] = r31
                                                        r30 = upvalueValues[r22]
                                                        r13 = 26051491278691
                                                        r31 = upvalueValues[r5]
                                                        r32 = "\154Q\156h"
                                                        r9 = r31(r32, r13)
                                                        r17 = r30[r9]
                                                        r32 = "Enum"
                                                        r9 = _env[r32]
                                                        r13 = upvalueValues[r22]
                                                        r35 = upvalueValues[r5]
                                                        r28 = r35(r2, r7)
                                                        r32 = r13[r28]
                                                        r31 = r9[r32]
                                                        r32 = upvalueValues[r22]
                                                        r2 = 33013482159117
                                                        r13 = upvalueValues[r5]
                                                        r28 = ">\008\138+\201\237\194A\159M"
                                                        r35 = r13(r28, r2)
                                                        r9 = r32[r35]
                                                        r30 = r31[r9]
                                                        r20[r17] = r30
                                                        r13 = 28310561796991
                                                        r30 = upvalueValues[r22]
                                                        r31 = upvalueValues[r5]
                                                        r32 = "/\166\211\241\1340\004\168"
                                                        r9 = r31(r32, r13)
                                                        r17 = r30[r9]
                                                        r30 = 20
                                                        r20[r17] = r30
                                                        r30 = upvalueValues[r22]
                                                        r31 = upvalueValues[r5]
                                                        r13 = 135105593406
                                                        r32 = "V\185\206-\182\238"
                                                        r9 = r31(r32, r13)
                                                        r2 = 15137526061960
                                                        r17 = r30[r9]
                                                        r31 = "Instance"
                                                        r30 = upvalueValues[r11]
                                                        r20[r17] = r30
                                                        r30 = _env[r31]
                                                        r35 = "\246\158."
                                                        r9 = upvalueValues[r22]
                                                        r32 = upvalueValues[r5]
                                                        r28 = 5629151758909
                                                        r13 = r32(r35, r28)
                                                        r31 = r9[r13]
                                                        r35 = "T\018\189\007\164\"\151\155\128\193"
                                                        r17 = r30[r31]
                                                        r9 = upvalueValues[r22]
                                                        r32 = upvalueValues[r5]
                                                        r28 = 7213806062879
                                                        r13 = r32(r35, r28)
                                                        r31 = r9[r13]
                                                        r30 = r17(r31)
                                                        r17 = allocUpvalue()
                                                        r35 = "\190L\1472"
                                                        upvalueValues[r17] = r30
                                                        r30 = upvalueValues[r17]
                                                        r9 = upvalueValues[r22]
                                                        r32 = upvalueValues[r5]
                                                        r28 = 18490338271650
                                                        r13 = r32(r35, r28)
                                                        r31 = r9[r13]
                                                        r32 = upvalueValues[r22]
                                                        r13 = upvalueValues[r5]
                                                        r28 = "\176\2056\237\228G\242\003\204lZ"
                                                        r35 = r13(r28, r2)
                                                        r9 = r32[r35]
                                                        r30[r31] = r9
                                                        r30 = upvalueValues[r17]
                                                        r9 = upvalueValues[r22]
                                                        r32 = upvalueValues[r5]
                                                        r35 = "\1443\153\025"
                                                        r28 = 10271699440303
                                                        r13 = r32(r35, r28)
                                                        r31 = r9[r13]
                                                        r13 = "UDim2"
                                                        r32 = _env[r13]
                                                        r35 = upvalueValues[r22]
                                                        r28 = upvalueValues[r5]
                                                        r7 = "\243Q\023"
                                                        r2 = r28(r7, r27)
                                                        r13 = r35[r2]
                                                        r9 = r32[r13]
                                                        r35 = 30
                                                        r2 = 30
                                                        r13 = 0
                                                        r28 = 0
                                                        r32 = r9(r13, r35, r28, r2)
                                                        r30[r31] = r32
                                                        r30 = upvalueValues[r17]
                                                        r35 = "\171\127\244\145\136\156R\165"
                                                        r9 = upvalueValues[r22]
                                                        r32 = upvalueValues[r5]
                                                        r28 = 17023879241463
                                                        r13 = r32(r35, r28)
                                                        r31 = r9[r13]
                                                        r13 = "UDim2"
                                                        r32 = _env[r13]
                                                        r35 = upvalueValues[r22]
                                                        r28 = upvalueValues[r5]
                                                        r27 = 24819394751781
                                                        r7 = "\205w\167"
                                                        r2 = r28(r7, r27)
                                                        r13 = r35[r2]
                                                        r35 = -35
                                                        r9 = r32[r13]
                                                        r13 = 1
                                                        r2 = 5
                                                        r28 = 0
                                                        r32 = r9(r13, r35, r28, r2)
                                                        r30[r31] = r32
                                                        r35 = "\173\023kN\208\146tx\184b\174\n(\171\208\210"
                                                        r30 = upvalueValues[r17]
                                                        r9 = upvalueValues[r22]
                                                        r32 = upvalueValues[r5]
                                                        r28 = 5288041007518
                                                        r13 = r32(r35, r28)
                                                        r31 = r9[r13]
                                                        r4 = 5085687007552
                                                        r27 = 4950393538817
                                                        r25 = nil
                                                        r13 = "Color3"
                                                        r32 = _env[r13]
                                                        r35 = upvalueValues[r22]
                                                        r28 = upvalueValues[r5]
                                                        r7 = "\156\017p\194\194\204G"
                                                        r2 = r28(r7, r27)
                                                        r13 = r35[r2]
                                                        r9 = r32[r13]
                                                        r35 = 50
                                                        r13 = 200
                                                        r28 = 50
                                                        r32 = r9(r13, r35, r28)
                                                        r30[r31] = r32
                                                        r30 = upvalueValues[r17]
                                                        r9 = upvalueValues[r22]
                                                        r35 = "\135)\252\157"
                                                        r32 = upvalueValues[r5]
                                                        r28 = 3655717291686
                                                        r13 = r32(r35, r28)
                                                        r31 = r9[r13]
                                                        r2 = 13630406727883
                                                        r32 = upvalueValues[r22]
                                                        r13 = upvalueValues[r5]
                                                        r28 = "E"
                                                        r35 = r13(r28, r2)
                                                        r9 = r32[r35]
                                                        r30[r31] = r9
                                                        r30 = upvalueValues[r17]
                                                        r35 = "o2\147\155lQ\211\245\206L"
                                                        r9 = upvalueValues[r22]
                                                        r32 = upvalueValues[r5]
                                                        r28 = 20290050385128
                                                        r13 = r32(r35, r28)
                                                        r31 = r9[r13]
                                                        r13 = "Color3"
                                                        r32 = _env[r13]
                                                        r35 = upvalueValues[r22]
                                                        r28 = upvalueValues[r5]
                                                        r27 = 15297819253715
                                                        r7 = "'\011\223\181\153\014\018"
                                                        r2 = r28(r7, r27)
                                                        r13 = r35[r2]
                                                        r9 = r32[r13]
                                                        r13 = 255
                                                        r35 = 255
                                                        r28 = 255
                                                        r32 = r9(r13, r35, r28)
                                                        r30[r31] = r32
                                                        r35 = "f9^\217"
                                                        r30 = upvalueValues[r17]
                                                        r9 = upvalueValues[r22]
                                                        r32 = upvalueValues[r5]
                                                        r28 = 4736968837277
                                                        r13 = r32(r35, r28)
                                                        r31 = r9[r13]
                                                        r35 = "Enum"
                                                        r13 = _env[r35]
                                                        r28 = upvalueValues[r22]
                                                        r2 = upvalueValues[r5]
                                                        r27 = "\172\137\1694"
                                                        r7 = r2(r27, r26)
                                                        r35 = r28[r7]
                                                        r32 = r13[r35]
                                                        r35 = upvalueValues[r22]
                                                        r28 = upvalueValues[r5]
                                                        r7 = "\247\203\172\177\194I|\136\162\253"
                                                        r27 = 29484151289249
                                                        r2 = r28(r7, r27)
                                                        r13 = r35[r2]
                                                        r9 = r32[r13]
                                                        r30[r31] = r9
                                                        r30 = upvalueValues[r17]
                                                        r9 = upvalueValues[r22]
                                                        r35 = "@\025!t\230to["
                                                        r32 = upvalueValues[r5]
                                                        r2 = 13699507493099
                                                        r28 = 21437077104382
                                                        r13 = r32(r35, r28)
                                                        r31 = r9[r13]
                                                        r35 = "\022_\241M\t\025\180\183]\158\193\179Y\147\217"
                                                        r9 = 18
                                                        r30[r31] = r9
                                                        r30 = upvalueValues[r17]
                                                        r9 = upvalueValues[r22]
                                                        r32 = upvalueValues[r5]
                                                        r28 = 22985922652623
                                                        r13 = r32(r35, r28)
                                                        r31 = r9[r13]
                                                        r9 = 0
                                                        r30[r31] = r9
                                                        r30 = upvalueValues[r17]
                                                        r35 = "\187\\\168\194\000p"
                                                        r9 = upvalueValues[r22]
                                                        r32 = upvalueValues[r5]
                                                        r28 = 32445361601284
                                                        r13 = r32(r35, r28)
                                                        r31 = r9[r13]
                                                        r9 = upvalueValues[r11]
                                                        r30[r31] = r9
                                                        r9 = "Instance"
                                                        r31 = _env[r9]
                                                        r32 = upvalueValues[r22]
                                                        r13 = upvalueValues[r5]
                                                        r28 = "\196o\153"
                                                        r35 = r13(r28, r2)
                                                        r9 = r32[r35]
                                                        r2 = 9493820952900
                                                        r30 = r31[r9]
                                                        r32 = upvalueValues[r22]
                                                        r13 = upvalueValues[r5]
                                                        r28 = "F\200\221\147\nX\007\251"
                                                        r35 = r13(r28, r2)
                                                        r9 = r32[r35]
                                                        r31 = r30(r9)
                                                        r26 = 29867293832788
                                                        r3 = 25882121006868
                                                        r8 = 26305630384089
                                                        r27 = 11145449002054
                                                        r9 = upvalueValues[r22]
                                                        r35 = "\152\171=d@u\236B\240\158\198\171"
                                                        r32 = upvalueValues[r5]
                                                        r28 = 27349740417471
                                                        r13 = r32(r35, r28)
                                                        r30 = r9[r13]
                                                        r7 = "\015\194\138"
                                                        r20 = nil
                                                        r13 = "UDim"
                                                        r32 = _env[r13]
                                                        r35 = upvalueValues[r22]
                                                        r28 = upvalueValues[r5]
                                                        r2 = r28(r7, r27)
                                                        r13 = r35[r2]
                                                        r9 = r32[r13]
                                                        r13 = 0
                                                        r35 = 6
                                                        r32 = r9(r13, r35)
                                                        r31[r30] = r32
                                                        r9 = upvalueValues[r22]
                                                        r32 = upvalueValues[r5]
                                                        r35 = "\174>\244\203\017\204"
                                                        r2 = "\148f\241"
                                                        r28 = 26117370834817
                                                        r13 = r32(r35, r28)
                                                        r30 = r9[r13]
                                                        r9 = upvalueValues[r17]
                                                        r7 = 19426839733078
                                                        r27 = "E\226\130"
                                                        r24 = nil
                                                        r31[r30] = r9
                                                        r32 = "Instance"
                                                        r9 = _env[r32]
                                                        r13 = upvalueValues[r22]
                                                        r35 = upvalueValues[r5]
                                                        r28 = r35(r2, r7)
                                                        r32 = r13[r28]
                                                        r30 = r9[r32]
                                                        r2 = "\229\228\135:m\165Ee\142"
                                                        r13 = upvalueValues[r22]
                                                        r35 = upvalueValues[r5]
                                                        r7 = 2012568175529
                                                        r28 = r35(r2, r7)
                                                        r32 = r13[r28]
                                                        r9 = r30(r32)
                                                        r32 = upvalueValues[r22]
                                                        r13 = upvalueValues[r5]
                                                        r2 = 29732188239381
                                                        r28 = "\204I\237\018"
                                                        r35 = r13(r28, r2)
                                                        r30 = r32[r35]
                                                        r13 = upvalueValues[r22]
                                                        r2 = "C\165\015\1299}\017\200>{\225E\027"
                                                        r35 = upvalueValues[r5]
                                                        r7 = 17255949786979
                                                        r28 = r35(r2, r7)
                                                        r32 = r13[r28]
                                                        r2 = 30323129988904
                                                        r9[r30] = r32
                                                        r32 = upvalueValues[r22]
                                                        r13 = upvalueValues[r5]
                                                        r28 = "\254\152\r-"
                                                        r35 = r13(r28, r2)
                                                        r30 = r32[r35]
                                                        r35 = "UDim2"
                                                        r13 = _env[r35]
                                                        r28 = upvalueValues[r22]
                                                        r2 = upvalueValues[r5]
                                                        r7 = r2(r27, r26)
                                                        r35 = r28[r7]
                                                        r2 = 0
                                                        r32 = r13[r35]
                                                        r35 = 1
                                                        r28 = -40
                                                        r7 = 25
                                                        r13 = r32(r35, r28, r2, r7)
                                                        r9[r30] = r13
                                                        r2 = 22885101562272
                                                        r32 = upvalueValues[r22]
                                                        r13 = upvalueValues[r5]
                                                        r28 = "\212\246s[\156\230\004S"
                                                        r35 = r13(r28, r2)
                                                        r30 = r32[r35]
                                                        r35 = "UDim2"
                                                        r13 = _env[r35]
                                                        r28 = upvalueValues[r22]
                                                        r2 = upvalueValues[r5]
                                                        r26 = 2352563946567
                                                        r27 = "!\001s"
                                                        r7 = r2(r27, r26)
                                                        r2 = 0
                                                        r35 = r28[r7]
                                                        r32 = r13[r35]
                                                        r35 = 0
                                                        r28 = 20
                                                        r7 = 60
                                                        r13 = r32(r35, r28, r2, r7)
                                                        r9[r30] = r13
                                                        r2 = 13173259999222
                                                        r32 = upvalueValues[r22]
                                                        r13 = upvalueValues[r5]
                                                        r28 = "\129\156\142\144\201\018\163\014\155_\214\142|\176\135\t\210C.9\189\242"
                                                        r35 = r13(r28, r2)
                                                        r30 = r32[r35]
                                                        r32 = 1
                                                        r9[r30] = r32
                                                        r32 = upvalueValues[r22]
                                                        r2 = 2838255519017
                                                        r13 = upvalueValues[r5]
                                                        r28 = "\216\167\173\005"
                                                        r35 = r13(r28, r2)
                                                        r2 = "+\132YY2\169\188M_\198\176\240\250\201"
                                                        r30 = r32[r35]
                                                        r13 = upvalueValues[r22]
                                                        r35 = upvalueValues[r5]
                                                        r7 = 12624263386870
                                                        r28 = r35(r2, r7)
                                                        r32 = r13[r28]
                                                        r9[r30] = r32
                                                        r32 = upvalueValues[r22]
                                                        r13 = upvalueValues[r5]
                                                        r2 = 2698001286376
                                                        r28 = "\155&H*\1725\006`\2456"
                                                        r35 = r13(r28, r2)
                                                        r30 = r32[r35]
                                                        r35 = "Color3"
                                                        r13 = _env[r35]
                                                        r28 = upvalueValues[r22]
                                                        r2 = upvalueValues[r5]
                                                        r27 = "\014w\002\141.\177@"
                                                        r26 = 19862134760481
                                                        r7 = r2(r27, r26)
                                                        r35 = r28[r7]
                                                        r32 = r13[r35]
                                                        r35 = 200
                                                        r2 = 200
                                                        r28 = 200
                                                        r13 = r32(r35, r28, r2)
                                                        r9[r30] = r13
                                                        r32 = upvalueValues[r22]
                                                        r2 = 2259286033436
                                                        r13 = upvalueValues[r5]
                                                        r28 = "@\138q\021"
                                                        r35 = r13(r28, r2)
                                                        r30 = r32[r35]
                                                        r28 = "Enum"
                                                        r35 = _env[r28]
                                                        r2 = upvalueValues[r22]
                                                        r7 = upvalueValues[r5]
                                                        r29 = 7986042310278
                                                        r26 = "\197G\157\030"
                                                        r27 = r7(r26, r29)
                                                        r28 = r2[r27]
                                                        r13 = r35[r28]
                                                        r28 = upvalueValues[r22]
                                                        r2 = upvalueValues[r5]
                                                        r26 = 24812528315682
                                                        r27 = "\148\180\253\254\020\183"
                                                        r7 = r2(r27, r26)
                                                        r35 = r28[r7]
                                                        r32 = r13[r35]
                                                        r2 = 5915003341506
                                                        r9[r30] = r32
                                                        r32 = upvalueValues[r22]
                                                        r13 = upvalueValues[r5]
                                                        r28 = "y\019\209\1827\241|\143"
                                                        r35 = r13(r28, r2)
                                                        r30 = r32[r35]
                                                        r2 = 21616449038161
                                                        r32 = 14
                                                        r9[r30] = r32
                                                        r32 = upvalueValues[r22]
                                                        r13 = upvalueValues[r5]
                                                        r28 = "\238q\000\130fR\187\198\1349/[\026s"
                                                        r35 = r13(r28, r2)
                                                        r30 = r32[r35]
                                                        r28 = "Enum"
                                                        r35 = _env[r28]
                                                        r2 = upvalueValues[r22]
                                                        r7 = upvalueValues[r5]
                                                        r29 = 9918206595594
                                                        r26 = "X\017\232=\250P\242^\222t\021\191O\022"
                                                        r27 = r7(r26, r29)
                                                        r28 = r2[r27]
                                                        r13 = r35[r28]
                                                        r28 = upvalueValues[r22]
                                                        r2 = upvalueValues[r5]
                                                        r26 = 21212822595221
                                                        r27 = "$\209\222\""
                                                        r7 = r2(r27, r26)
                                                        r35 = r28[r7]
                                                        r32 = r13[r35]
                                                        r2 = 26353417875439
                                                        r9[r30] = r32
                                                        r32 = upvalueValues[r22]
                                                        r13 = upvalueValues[r5]
                                                        r28 = "\127\205%N\147\240"
                                                        r35 = r13(r28, r2)
                                                        r30 = r32[r35]
                                                        r32 = upvalueValues[r11]
                                                        r9[r30] = r32
                                                        r13 = "Instance"
                                                        r32 = _env[r13]
                                                        r35 = upvalueValues[r22]
                                                        r28 = upvalueValues[r5]
                                                        r27 = 15894788644073
                                                        r7 = "\164\014^"
                                                        r2 = r28(r7, r27)
                                                        r13 = r35[r2]
                                                        r30 = r32[r13]
                                                        r35 = upvalueValues[r22]
                                                        r28 = upvalueValues[r5]
                                                        ReturnVal = {}
                                                        r7 = "7\1861\237\005.T"
                                                        r27 = 15512601779255
                                                        r2 = r28(r7, r27)
                                                        r13 = r35[r2]
                                                        r32 = r30(r13)
                                                        r30 = allocUpvalue()
                                                        upvalueValues[r30] = r32
                                                        r32 = upvalueValues[r30]
                                                        r35 = upvalueValues[r22]
                                                        r28 = upvalueValues[r5]
                                                        r7 = "\200\221*\173"
                                                        r27 = 12606122890990
                                                        r2 = r28(r7, r27)
                                                        r13 = r35[r2]
                                                        r28 = upvalueValues[r22]
                                                        r2 = upvalueValues[r5]
                                                        r26 = 3696339191481
                                                        r27 = "\240\160\180\243\136\171\215\255\154\224\197"
                                                        r7 = r2(r27, r26)
                                                        r35 = r28[r7]
                                                        r32[r13] = r35
                                                        r32 = upvalueValues[r30]
                                                        r35 = upvalueValues[r22]
                                                        r28 = upvalueValues[r5]
                                                        r27 = 12773591275324
                                                        r7 = "\\s>\169"
                                                        r2 = r28(r7, r27)
                                                        r13 = r35[r2]
                                                        r2 = "UDim2"
                                                        r28 = _env[r2]
                                                        r7 = upvalueValues[r22]
                                                        r27 = upvalueValues[r5]
                                                        r29 = "rI\241"
                                                        r26 = r27(r29, r8)
                                                        r2 = r7[r26]
                                                        r7 = -40
                                                        r35 = r28[r2]
                                                        r2 = 1
                                                        r26 = 35
                                                        r27 = 0
                                                        r28 = r35(r2, r7, r27, r26)
                                                        r32[r13] = r28
                                                        r32 = upvalueValues[r30]
                                                        r35 = upvalueValues[r22]
                                                        r28 = upvalueValues[r5]
                                                        r27 = 13190160160766
                                                        r7 = "w\127\205\007\014\139\185\225"
                                                        r2 = r28(r7, r27)
                                                        r13 = r35[r2]
                                                        r2 = "UDim2"
                                                        r28 = _env[r2]
                                                        r7 = upvalueValues[r22]
                                                        r27 = upvalueValues[r5]
                                                        r8 = 4938959587579
                                                        r29 = "\012\193n"
                                                        r26 = r27(r29, r8)
                                                        r2 = r7[r26]
                                                        r35 = r28[r2]
                                                        r2 = 0
                                                        r27 = 0
                                                        r26 = 90
                                                        r7 = 20
                                                        r28 = r35(r2, r7, r27, r26)
                                                        r32[r13] = r28
                                                        r32 = upvalueValues[r30]
                                                        r35 = upvalueValues[r22]
                                                        r28 = upvalueValues[r5]
                                                        r27 = 2266707280927
                                                        r7 = "5\240\191\197\244\007\031at\204\202y\184\165\155\245"
                                                        r2 = r28(r7, r27)
                                                        r13 = r35[r2]
                                                        r2 = "Color3"
                                                        r28 = _env[r2]
                                                        r7 = upvalueValues[r22]
                                                        r27 = upvalueValues[r5]
                                                        r29 = "\127SJ\024\167\170\188"
                                                        r8 = 4123158890367
                                                        r26 = r27(r29, r8)
                                                        r2 = r7[r26]
                                                        r35 = r28[r2]
                                                        r2 = 45
                                                        r27 = 45
                                                        r7 = 45
                                                        r28 = r35(r2, r7, r27)
                                                        r32[r13] = r28
                                                        r32 = upvalueValues[r30]
                                                        r35 = upvalueValues[r22]
                                                        r28 = upvalueValues[r5]
                                                        r27 = 24365799320658
                                                        r7 = "\028-v\020"
                                                        r2 = r28(r7, r27)
                                                        r13 = r35[r2]
                                                        r28 = upvalueValues[r22]
                                                        r2 = upvalueValues[r5]
                                                        r26 = 4279275456456
                                                        r27 = ""
                                                        r7 = r2(r27, r26)
                                                        r35 = r28[r7]
                                                        r32[r13] = r35
                                                        r32 = upvalueValues[r30]
                                                        r35 = upvalueValues[r22]
                                                        r28 = upvalueValues[r5]
                                                        r27 = 33855347129749
                                                        r7 = "\027\136\152\224}\003!\180Y;u}\169\020C"
                                                        r2 = r28(r7, r27)
                                                        r13 = r35[r2]
                                                        r28 = upvalueValues[r22]
                                                        r2 = upvalueValues[r5]
                                                        r26 = 6437377018805
                                                        r27 = "\1666\208F\150\012\008|\252+\176\198\201X\174\1388"
                                                        r7 = r2(r27, r26)
                                                        r35 = r28[r7]
                                                        r32[r13] = r35
                                                        r32 = upvalueValues[r30]
                                                        r35 = upvalueValues[r22]
                                                        r28 = upvalueValues[r5]
                                                        r27 = 34602405445361
                                                        r7 = "|\172\170sJu\015\246\242I"
                                                        r2 = r28(r7, r27)
                                                        r13 = r35[r2]
                                                        r2 = "Color3"
                                                        r28 = _env[r2]
                                                        r7 = upvalueValues[r22]
                                                        r27 = upvalueValues[r5]
                                                        r8 = 28538268873705
                                                        r29 = "t\020`B\188\000e"
                                                        r26 = r27(r29, r8)
                                                        r2 = r7[r26]
                                                        r35 = r28[r2]
                                                        r2 = 255
                                                        r27 = 255
                                                        r7 = 255
                                                        r28 = r35(r2, r7, r27)
                                                        r32[r13] = r28
                                                        r32 = upvalueValues[r30]
                                                        r35 = upvalueValues[r22]
                                                        r28 = upvalueValues[r5]
                                                        r7 = ";_\131\219G\220\2263,\226\186\180\249\167\t\160\144"
                                                        r27 = 29322478581078
                                                        r2 = r28(r7, r27)
                                                        r13 = r35[r2]
                                                        r2 = "Color3"
                                                        r28 = _env[r2]
                                                        r7 = upvalueValues[r22]
                                                        r27 = upvalueValues[r5]
                                                        r29 = "k\155\132\220fWa"
                                                        r8 = 1770597286712
                                                        r26 = r27(r29, r8)
                                                        r2 = r7[r26]
                                                        r35 = r28[r2]
                                                        r2 = 120
                                                        r7 = 120
                                                        r27 = 120
                                                        r28 = r35(r2, r7, r27)
                                                        r32[r13] = r28
                                                        r32 = upvalueValues[r30]
                                                        r35 = upvalueValues[r22]
                                                        r28 = upvalueValues[r5]
                                                        r7 = "\211\144B>"
                                                        r27 = 6527156767711
                                                        r2 = r28(r7, r27)
                                                        r13 = r35[r2]
                                                        r7 = "Enum"
                                                        r2 = _env[r7]
                                                        r27 = upvalueValues[r22]
                                                        r26 = upvalueValues[r5]
                                                        r1 = 32160734100096
                                                        r8 = "\1747\168W"
                                                        r29 = r26(r8, r1)
                                                        r7 = r27[r29]
                                                        r28 = r2[r7]
                                                        r7 = upvalueValues[r22]
                                                        r27 = upvalueValues[r5]
                                                        r8 = 14394860673583
                                                        r29 = "*;\197\151\176\233"
                                                        r26 = r27(r29, r8)
                                                        r2 = r7[r26]
                                                        r35 = r28[r2]
                                                        r32[r13] = r35
                                                        r32 = upvalueValues[r30]
                                                        r35 = upvalueValues[r22]
                                                        r28 = upvalueValues[r5]
                                                        r27 = 9225158070471
                                                        r7 = ",\162\204y<`g4"
                                                        r2 = r28(r7, r27)
                                                        r13 = r35[r2]
                                                        r35 = 14
                                                        r32[r13] = r35
                                                        r32 = upvalueValues[r30]
                                                        r15 = "\188\007\130"
                                                        r1 = 7418445974910
                                                        r27 = 16838496771745
                                                        r31 = nil
                                                        r35 = upvalueValues[r22]
                                                        r28 = upvalueValues[r5]
                                                        r7 = " \202\190c\134\027,\135e\016\134\215\238\139\rb"
                                                        r2 = r28(r7, r27)
                                                        r13 = r35[r2]
                                                        r35 = false
                                                        r32[r13] = r35
                                                        r32 = upvalueValues[r30]
                                                        r35 = upvalueValues[r22]
                                                        r28 = upvalueValues[r5]
                                                        r7 = "\220\138\189\147\"\016]\128\1899\137\189^\158\014"
                                                        r27 = 16654146723403
                                                        r2 = r28(r7, r27)
                                                        r13 = r35[r2]
                                                        r35 = 0
                                                        r32[r13] = r35
                                                        r32 = upvalueValues[r30]
                                                        r35 = upvalueValues[r22]
                                                        r28 = upvalueValues[r5]
                                                        r27 = 17211200380750
                                                        r7 = "\025\005O\210q{"
                                                        r2 = r28(r7, r27)
                                                        r13 = r35[r2]
                                                        r29 = "J,#"
                                                        r9 = nil
                                                        r35 = upvalueValues[r11]
                                                        r32[r13] = r35
                                                        r35 = "Instance"
                                                        r13 = _env[r35]
                                                        r28 = upvalueValues[r22]
                                                        r2 = upvalueValues[r5]
                                                        r27 = "*\180\167"
                                                        r26 = 6466652982211
                                                        r7 = r2(r27, r26)
                                                        r35 = r28[r7]
                                                        r32 = r13[r35]
                                                        r28 = upvalueValues[r22]
                                                        r2 = upvalueValues[r5]
                                                        r27 = "\016(x.\234\144\182V"
                                                        r26 = 22569150064909
                                                        r7 = r2(r27, r26)
                                                        r35 = r28[r7]
                                                        r13 = r32(r35)
                                                        r35 = upvalueValues[r22]
                                                        r28 = upvalueValues[r5]
                                                        r7 = "y\128\r\235$\245a\030I\242\158\192"
                                                        r27 = 3643277313696
                                                        r2 = r28(r7, r27)
                                                        r32 = r35[r2]
                                                        r2 = "UDim"
                                                        r28 = _env[r2]
                                                        r7 = upvalueValues[r22]
                                                        r27 = upvalueValues[r5]
                                                        r8 = 16384859577805
                                                        r26 = r27(r29, r8)
                                                        r2 = r7[r26]
                                                        r35 = r28[r2]
                                                        r2 = 0
                                                        r7 = 6
                                                        r28 = r35(r2, r7)
                                                        r13[r32] = r28
                                                        r35 = upvalueValues[r22]
                                                        r28 = upvalueValues[r5]
                                                        r27 = 8597600554915
                                                        r7 = "\165\197\224_\020\205"
                                                        r2 = r28(r7, r27)
                                                        r32 = r35[r2]
                                                        r35 = upvalueValues[r30]
                                                        r13[r32] = r35
                                                        r28 = "Instance"
                                                        r35 = _env[r28]
                                                        r2 = upvalueValues[r22]
                                                        r7 = upvalueValues[r5]
                                                        r26 = "\170\199\198"
                                                        r29 = 29996695189136
                                                        r27 = r7(r26, r29)
                                                        r28 = r2[r27]
                                                        r32 = r35[r28]
                                                        r2 = upvalueValues[r22]
                                                        r7 = upvalueValues[r5]
                                                        r26 = "\018H\214\005\023\228\152\236"
                                                        r29 = 32279648221879
                                                        r27 = r7(r26, r29)
                                                        r28 = r2[r27]
                                                        r35 = r32(r28)
                                                        r28 = upvalueValues[r22]
                                                        r2 = upvalueValues[r5]
                                                        r26 = 24110202334171
                                                        r27 = "\212\019\177\002\217"
                                                        r7 = r2(r27, r26)
                                                        r32 = r28[r7]
                                                        r7 = "Color3"
                                                        r2 = _env[r7]
                                                        r27 = upvalueValues[r22]
                                                        r26 = upvalueValues[r5]
                                                        r8 = "\019$\176\196U\007\196"
                                                        r29 = r26(r8, r1)
                                                        r7 = r27[r29]
                                                        r28 = r2[r7]
                                                        r26 = 255
                                                        r27 = 120
                                                        r7 = 0
                                                        r2 = r28(r7, r27, r26)
                                                        r35[r32] = r2
                                                        r28 = upvalueValues[r22]
                                                        r2 = upvalueValues[r5]
                                                        r27 = "\255\238\177~\133I\191\t\163"
                                                        r26 = 791615308144
                                                        r7 = r2(r27, r26)
                                                        r32 = r28[r7]
                                                        r28 = 2
                                                        r35[r32] = r28
                                                        r28 = upvalueValues[r22]
                                                        r2 = upvalueValues[r5]
                                                        r26 = 1699421504279
                                                        r27 = "\222\160=9\028\191\196\233\204(\166\139"
                                                        r7 = r2(r27, r26)
                                                        r32 = r28[r7]
                                                        r28 = 0.5
                                                        r35[r32] = r28
                                                        r28 = upvalueValues[r22]
                                                        r2 = upvalueValues[r5]
                                                        r27 = "\183\0026U\189\158"
                                                        r26 = 33724076358999
                                                        r7 = r2(r27, r26)
                                                        r32 = r28[r7]
                                                        r2 = "Instance"
                                                        r28 = upvalueValues[r30]
                                                        r35[r32] = r28
                                                        r28 = _env[r2]
                                                        r7 = upvalueValues[r22]
                                                        r27 = upvalueValues[r5]
                                                        r8 = 13981775468910
                                                        r29 = "\132\146\188"
                                                        r26 = r27(r29, r8)
                                                        r2 = r7[r26]
                                                        r32 = r28[r2]
                                                        r7 = upvalueValues[r22]
                                                        r27 = upvalueValues[r5]
                                                        r29 = "\157G8\021T\188\148J\016\168"
                                                        r8 = 6638381091859
                                                        r26 = r27(r29, r8)
                                                        r2 = r7[r26]
                                                        r28 = r32(r2)
                                                        r32 = allocUpvalue()
                                                        upvalueValues[r32] = r28
                                                        r28 = upvalueValues[r32]
                                                        r7 = upvalueValues[r22]
                                                        r27 = upvalueValues[r5]
                                                        r29 = "1\228\189r"
                                                        r8 = 806411534711
                                                        r26 = r27(r29, r8)
                                                        r2 = r7[r26]
                                                        r27 = upvalueValues[r22]
                                                        r26 = upvalueValues[r5]
                                                        r1 = 18104934359278
                                                        r8 = "n\021\184\134\145\206\222\168\202\198\207\189"
                                                        r29 = r26(r8, r1)
                                                        r7 = r27[r29]
                                                        r28[r2] = r7
                                                        r28 = upvalueValues[r32]
                                                        r7 = upvalueValues[r22]
                                                        r27 = upvalueValues[r5]
                                                        r8 = 31004180428901
                                                        r29 = "\022\186Ej"
                                                        r26 = r27(r29, r8)
                                                        r2 = r7[r26]
                                                        r26 = "UDim2"
                                                        r27 = _env[r26]
                                                        r29 = upvalueValues[r22]
                                                        r8 = upvalueValues[r5]
                                                        r1 = r8(r15, r4)
                                                        r26 = r29[r1]
                                                        r7 = r27[r26]
                                                        r29 = -40
                                                        r26 = 1
                                                        r8 = 0
                                                        r1 = 35
                                                        r27 = r7(r26, r29, r8, r1)
                                                        r28[r2] = r27
                                                        r15 = "&\161\145"
                                                        r35 = nil
                                                        r28 = upvalueValues[r32]
                                                        r7 = upvalueValues[r22]
                                                        r27 = upvalueValues[r5]
                                                        r8 = 16775909400195
                                                        r29 = ".\177YoV\1717\177"
                                                        r26 = r27(r29, r8)
                                                        r2 = r7[r26]
                                                        r26 = "UDim2"
                                                        r27 = _env[r26]
                                                        r29 = upvalueValues[r22]
                                                        r8 = upvalueValues[r5]
                                                        r4 = 2257185342491
                                                        r1 = r8(r15, r4)
                                                        r26 = r29[r1]
                                                        r7 = r27[r26]
                                                        r8 = 0
                                                        r1 = 140
                                                        r26 = 0
                                                        r29 = 20
                                                        r27 = r7(r26, r29, r8, r1)
                                                        r28[r2] = r27
                                                        r28 = upvalueValues[r32]
                                                        r7 = upvalueValues[r22]
                                                        r27 = upvalueValues[r5]
                                                        r29 = "\202\200\003\019\136\023<\143\200\023\202J\031%l\173"
                                                        r8 = 4503720347697
                                                        r26 = r27(r29, r8)
                                                        r2 = r7[r26]
                                                        r26 = "Color3"
                                                        r27 = _env[r26]
                                                        r29 = upvalueValues[r22]
                                                        r8 = upvalueValues[r5]
                                                        r15 = "\226\186e\183\2364\250"
                                                        r4 = 10129806168685
                                                        r1 = r8(r15, r4)
                                                        r26 = r29[r1]
                                                        r7 = r27[r26]
                                                        r8 = 255
                                                        r29 = 120
                                                        r26 = 0
                                                        r27 = r7(r26, r29, r8)
                                                        r28[r2] = r27
                                                        r28 = upvalueValues[r32]
                                                        r7 = upvalueValues[r22]
                                                        r27 = upvalueValues[r5]
                                                        r8 = 31579663923569
                                                        r29 = "\228g@P"
                                                        r26 = r27(r29, r8)
                                                        r2 = r7[r26]
                                                        r27 = upvalueValues[r22]
                                                        r26 = upvalueValues[r5]
                                                        r1 = 6274317650793
                                                        r8 = "\227=6\n7C"
                                                        r29 = r26(r8, r1)
                                                        r7 = r27[r29]
                                                        r28[r2] = r7
                                                        r28 = upvalueValues[r32]
                                                        r7 = upvalueValues[r22]
                                                        r27 = upvalueValues[r5]
                                                        r29 = "\008\137\204\143\216\2482,\162\011"
                                                        r8 = 16656962936396
                                                        r26 = r27(r29, r8)
                                                        r2 = r7[r26]
                                                        r26 = "Color3"
                                                        r27 = _env[r26]
                                                        r29 = upvalueValues[r22]
                                                        r8 = upvalueValues[r5]
                                                        r15 = "\190\145\183\255dO\184"
                                                        r4 = 28556025918449
                                                        r1 = r8(r15, r4)
                                                        r26 = r29[r1]
                                                        r7 = r27[r26]
                                                        r8 = 255
                                                        r26 = 255
                                                        r29 = 255
                                                        r27 = r7(r26, r29, r8)
                                                        r28[r2] = r27
                                                        r28 = upvalueValues[r32]
                                                        r7 = upvalueValues[r22]
                                                        r27 = upvalueValues[r5]
                                                        r29 = "@\136\154="
                                                        r8 = 20669178324376
                                                        r26 = r27(r29, r8)
                                                        r2 = r7[r26]
                                                        r29 = "Enum"
                                                        r26 = _env[r29]
                                                        r8 = upvalueValues[r22]
                                                        r1 = upvalueValues[r5]
                                                        r4 = "xw%\229"
                                                        r15 = r1(r4, r3)
                                                        r29 = r8[r15]
                                                        r27 = r26[r29]
                                                        r15 = "P\204\189\1747<,5#\222"
                                                        r29 = upvalueValues[r22]
                                                        r8 = upvalueValues[r5]
                                                        r13 = nil
                                                        r4 = 10210150584978
                                                        r1 = r8(r15, r4)
                                                        r26 = r29[r1]
                                                        r7 = r27[r26]
                                                        r28[r2] = r7
                                                        r28 = upvalueValues[r32]
                                                        r7 = upvalueValues[r22]
                                                        r27 = upvalueValues[r5]
                                                        r8 = 2138952942564
                                                        r29 = "\138\152\142\001\203\200\186\004"
                                                        r26 = r27(r29, r8)
                                                        r2 = r7[r26]
                                                        r7 = 16
                                                        r28[r2] = r7
                                                        r28 = upvalueValues[r32]
                                                        r7 = upvalueValues[r22]
                                                        r27 = upvalueValues[r5]
                                                        r29 = "2\179\000\1362\143Jc\218\187gT,\221W"
                                                        r8 = 7908949282402
                                                        r26 = r27(r29, r8)
                                                        r2 = r7[r26]
                                                        r7 = 0
                                                        r28[r2] = r7
                                                        r28 = upvalueValues[r32]
                                                        r7 = upvalueValues[r22]
                                                        r27 = upvalueValues[r5]
                                                        r8 = 16676803567189
                                                        r29 = "n<>\021\252["
                                                        r26 = r27(r29, r8)
                                                        r2 = r7[r26]
                                                        r7 = upvalueValues[r11]
                                                        r28[r2] = r7
                                                        r7 = "Instance"
                                                        r2 = _env[r7]
                                                        r27 = upvalueValues[r22]
                                                        r26 = upvalueValues[r5]
                                                        r1 = 24708103007473
                                                        r8 = "\161\232\138"
                                                        r29 = r26(r8, r1)
                                                        r7 = r27[r29]
                                                        r28 = r2[r7]
                                                        r27 = upvalueValues[r22]
                                                        r26 = upvalueValues[r5]
                                                        r1 = 11552226596099
                                                        r8 = "O\177\194\187\238\140\187)"
                                                        r29 = r26(r8, r1)
                                                        r7 = r27[r29]
                                                        r2 = r28(r7)
                                                        r7 = upvalueValues[r22]
                                                        r27 = upvalueValues[r5]
                                                        r8 = 33061663144995
                                                        r29 = "\025\152\205\247\1641\210\137\182\237\157\031"
                                                        r26 = r27(r29, r8)
                                                        r28 = r7[r26]
                                                        r26 = "UDim"
                                                        r27 = _env[r26]
                                                        r29 = upvalueValues[r22]
                                                        r8 = upvalueValues[r5]
                                                        r15 = "\144\250\005"
                                                        r4 = 33305703562389
                                                        r1 = r8(r15, r4)
                                                        r26 = r29[r1]
                                                        r7 = r27[r26]
                                                        r29 = 6
                                                        r26 = 0
                                                        r27 = r7(r26, r29)
                                                        r2[r28] = r27
                                                        r7 = upvalueValues[r22]
                                                        r27 = upvalueValues[r5]
                                                        r8 = 6364549696403
                                                        r29 = "y\"\129Az\\"
                                                        r26 = r27(r29, r8)
                                                        r28 = r7[r26]
                                                        r7 = upvalueValues[r32]
                                                        r2[r28] = r7
                                                        r7 = upvalueValues[r22]
                                                        r27 = upvalueValues[r5]
                                                        r29 = "Z\021\193\007\233\211\173\t\0033\218;"
                                                        r8 = 30156939261658
                                                        r26 = r27(r29, r8)
                                                        r28 = r7[r26]
                                                        r7 = allocUpvalue()
                                                        upvalueValues[r7] = r28
                                                        r27 = upvalueValues[r17]
                                                        r29 = upvalueValues[r22]
                                                        r8 = upvalueValues[r5]
                                                        r15 = "\191\240M\027\253j4\247\196R\178\r\014J\1487\016"
                                                        r4 = 22231533791344
                                                        r1 = r8(r15, r4)
                                                        r26 = r29[r1]
                                                        r28 = r27[r26]
                                                        r3 = 12327998183020
                                                        r2 = nil
                                                        r26 = createClosure2(64, {
                                                            r6
                                                        })
                                                        r27 = "Connect"
                                                        r27 = r28[r27]
                                                        r27 = r27(r28, r26)
                                                        r27 = createClosure3(65, {
                                                            r30,
                                                            r22,
                                                            r5,
                                                            r7,
                                                            r6,
                                                            r11
                                                        })
                                                        r28 = allocUpvalue()
                                                        upvalueValues[r28] = r27
                                                        r26 = upvalueValues[r32]
                                                        r8 = upvalueValues[r22]
                                                        r1 = upvalueValues[r5]
                                                        r4 = "\136C\205\136\184\234\1615\019\230\030z|\251f\1643"
                                                        r15 = r1(r4, r3)
                                                        r29 = r8[r15]
                                                        r27 = r26[r29]
                                                        r29 = upvalueValues[r28]
                                                        r26 = "Connect"
                                                        r26 = r27[r26]
                                                        r26 = r26(r27, r29)
                                                        r26 = upvalueValues[r30]
                                                        r8 = upvalueValues[r22]
                                                        r1 = upvalueValues[r5]
                                                        r3 = 2289273357354
                                                        r4 = "\223n(\016\195k\000\142|"
                                                        r15 = r1(r4, r3)
                                                        r29 = r8[r15]
                                                        r27 = r26[r29]
                                                        r26 = "Connect"
                                                        r26 = r27[r26]
                                                        r29 = createClosure5(72, {
                                                            r28
                                                        })
                                                        r26 = r26(r27, r29)
                                                        r26 = upvalueValues[r32]
                                                        r8 = upvalueValues[r22]
                                                        r1 = upvalueValues[r5]
                                                        r3 = 26575080976470
                                                        r4 = "\234\006yV.\n[\129;\007"
                                                        r15 = r1(r4, r3)
                                                        r29 = r8[r15]
                                                        r27 = r26[r29]
                                                        r29 = createClosure4(75, {
                                                            r32,
                                                            r22,
                                                            r5
                                                        })
                                                        r11 = releaseUpvalue(r11)
                                                        r26 = "Connect"
                                                        r26 = r27[r26]
                                                        r26 = r26(r27, r29)
                                                        r26 = upvalueValues[r32]
                                                        r8 = upvalueValues[r22]
                                                        r1 = upvalueValues[r5]
                                                        r3 = 10195985388171
                                                        r4 = "\240\156\166g\143\167n\017\213y"
                                                        r15 = r1(r4, r3)
                                                        r29 = r8[r15]
                                                        r27 = r26[r29]
                                                        r29 = createClosure2(76, {
                                                            r32,
                                                            r22,
                                                            r5
                                                        })
                                                        r26 = "Connect"
                                                        r26 = r27[r26]
                                                        r26 = r26(r27, r29)
                                                        r26 = upvalueValues[r17]
                                                        r8 = upvalueValues[r22]
                                                        r1 = upvalueValues[r5]
                                                        r3 = 22146578753608
                                                        r4 = "\157\250\163\226Y\147\194s\165\001"
                                                        r15 = r1(r4, r3)
                                                        r29 = r8[r15]
                                                        r27 = r26[r29]
                                                        r29 = createClosure0(77, {
                                                            r17,
                                                            r22,
                                                            r5
                                                        })
                                                        r26 = "Connect"
                                                        r26 = r27[r26]
                                                        r26 = r26(r27, r29)
                                                        r26 = "setclipboard"
                                                        r27 = _env[r26]
                                                        r6 = releaseUpvalue(r6)
                                                        r8 = upvalueValues[r22]
                                                        r1 = upvalueValues[r5]
                                                        r3 = 32475444656914
                                                        r4 = "]\149\187\027Y&\245\237\030\143p\"\239Z\255\138\183\210\246\169{G\130\2006\230j\252\152\213t\233\129\215\215\174|\253\0006\012` \249"
                                                        r15 = r1(r4, r3)
                                                        r29 = r8[r15]
                                                        r26 = r27(r29)
                                                        r7 = releaseUpvalue(r7)
                                                        r26 = upvalueValues[r17]
                                                        r8 = upvalueValues[r22]
                                                        r1 = upvalueValues[r5]
                                                        r4 = "\245\149\2146.\012:\189~a"
                                                        r3 = 31337766156544
                                                        r15 = r1(r4, r3)
                                                        r28 = releaseUpvalue(r28)
                                                        r29 = r8[r15]
                                                        r27 = r26[r29]
                                                        r32 = releaseUpvalue(r32)
                                                        r29 = createClosure3(78, {
                                                            r17,
                                                            r22,
                                                            r5
                                                        })
                                                        r5 = releaseUpvalue(r5)
                                                        r22 = releaseUpvalue(r22)
                                                        r26 = "Connect"
                                                        r26 = r27[r26]
                                                        r30 = releaseUpvalue(r30)
                                                        r26 = r26(r27, r29)
                                                        r17 = releaseUpvalue(r17)
                                                        state = nil
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure1 entry 196407 -> 32, states 32-32
                                    if state == 32 then -- entry 196407 -> 32
                                        ReturnVal = "error"
                                        state = _env[ReturnVal]
                                        r16 = "Tamper Detected!"
                                        ReturnVal = state(r16)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                if state <= 33 then
                                    -- createClosure5 entry 10358887 -> 33, states 33-33
                                    if state == 33 then -- entry 10358887 -> 33
                                        state = true
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure0 entry 9818165 -> 34, states 34-34
                                    if state == 34 then -- entry 9818165 -> 34
                                        r19 = 10236758
                                        r22 = "xrLBj"
                                        r16 = r22 ^ r19
                                        ReturnVal = 195899
                                        state = ReturnVal - r16
                                        r16 = state
                                        ReturnVal = "i4"
                                        state = ReturnVal / r16
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 50 then
                                if state <= 46 then
                                    -- createClosure3 entry 3786582 -> 35, states 35-46
                                    if state <= 40 then
                                        if state <= 37 then
                                            if state <= 36 then
                                                if state <= 35 then
                                                    if state == 35 then -- entry 3786582 -> 35
                                                        r22 = upvalueValues[upvalues[1]]
                                                        r25 = 2
                                                        r5 = 1
                                                        r19 = r22(r5, r25)
                                                        r22 = 1
                                                        r16 = r19 == r22
                                                        state = r16 and (36) or (37)
                                                        ReturnVal = r16
                                                    end
                                                else
                                                    if state == 36 then
                                                        state = ReturnVal and (38) or (39)
                                                    end
                                                end
                                            else
                                                if state == 37 then
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r19 = upvalueValues[upvalues[3]]
                                                    r16 = r22 == r19
                                                    ReturnVal = r16
                                                    state = 36
                                                end
                                            end
                                        else
                                            if state <= 39 then
                                                if state <= 38 then
                                                    if state == 38 then
                                                        r17 = createClosure2(79, {})
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r16 = upvalueValues[upvalues[4]]
                                                        r5 = "tostring"
                                                        r19 = _env[r5]
                                                        r11 = "pcall"
                                                        r6 = _env[r11]
                                                        r11 = {
                                                            r6(r17)
                                                        }
                                                        r14 = {
                                                            unpack(r11)
                                                        }
                                                        r6 = 2
                                                        r25 = r14[r6]
                                                        r5 = r19(r25)
                                                        r19 = ":(%d*):"
                                                        r22 = r16(r5, r19)
                                                        r16 = {
                                                            r22()
                                                        }
                                                        ReturnVal = state(unpack(r16))
                                                        r16 = ReturnVal
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
                                                    r19 = upvalueValues[upvalues[6]]
                                                    r22 = r19 == r16
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
                                                        r16 = nil
                                                        state = 39
                                                    end
                                                else
                                                    if state == 42 then
                                                        r16 = "error"
                                                        state = _env[r16]
                                                        r22 = upvalueValues[upvalues[8]]
                                                        r19 = 0
                                                        r16 = state(r22, r19)
                                                        state = 43
                                                    end
                                                end
                                            else
                                                if state == 43 then
                                                    r19 = upvalueValues[upvalues[9]]
                                                    r5 = r19
                                                    state = {}
                                                    r16 = state
                                                    r19 = 1
                                                    r25 = r19
                                                    r19 = 0
                                                    r14 = r25 < r19
                                                    r22 = 1
                                                    r19 = r22 - r25
                                                    state = 44
                                                end
                                            end
                                        else
                                            if state <= 45 then
                                                if state <= 44 then
                                                    if state == 44 then
                                                        r19 = r19 + r25
                                                        r22 = r19 <= r5
                                                        r6 = not r14
                                                        r22 = r6 and r22
                                                        r6 = r19 >= r5
                                                        r6 = r14 and r6
                                                        r22 = r6 or r22
                                                        r6 = (45)
                                                        state = r22 and r6
                                                        r22 = (46)
                                                        state = state or r22
                                                    end
                                                else
                                                    if state == 45 then
                                                        state = upvalueValues[upvalues[1]]
                                                        r22 = r19
                                                        r11 = 0
                                                        r17 = 255
                                                        r6 = state(r11, r17)
                                                        r16[r22] = r6
                                                        r22 = nil
                                                        state = 44
                                                    end
                                                end
                                            else
                                                if state == 46 then
                                                    state = upvalueValues[upvalues[10]]
                                                    r22 = upvalueValues[upvalues[11]]
                                                    r16[state] = r22
                                                    state = upvalueValues[upvalues[12]]
                                                    r22 = {
                                                        state(r16)
                                                    }
                                                    ReturnVal = {
                                                        unpack(r22)
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure3 entry 5084805 -> 47, states 47-50
                                    if state <= 48 then
                                        if state <= 47 then
                                            if state == 47 then -- entry 5084805 -> 47
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
                                                r16 = "l1"
                                                ReturnVal = _env[r16]
                                                r16 = "l1"
                                                _env[r16] = state
                                                r16 = "l2"
                                                _env[r16] = ReturnVal
                                                r16 = upvalueValues[upvalues[1]]
                                                r22 = r16()
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
                            else
                                if state <= 56 then
                                    -- createClosure5 entry 773788 -> 51, states 51-56
                                    if state <= 53 then
                                        if state <= 52 then
                                            if state <= 51 then
                                                if state == 51 then -- entry 773788 -> 51
                                                    r16 = upvalueValues[upvalues[1]]
                                                    ReturnVal = #r16
                                                    r16 = 0
                                                    state = ReturnVal == r16
                                                    state = state and (52) or (53)
                                                end
                                            else
                                                if state == 52 then
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r19 = 201
                                                    r16 = r22 * r19
                                                    r22 = 9544524599643
                                                    ReturnVal = r16 + r22
                                                    r16 = 35184372088832
                                                    state = ReturnVal % r16
                                                    upvalueValues[upvalues[2]] = state
                                                    r16 = upvalueValues[upvalues[3]]
                                                    r22 = 1
                                                    ReturnVal = r16 ~= r22
                                                    state = 54
                                                end
                                            end
                                        else
                                            if state == 53 then
                                                r19 = "table"
                                                r22 = _env[r19]
                                                r19 = "remove"
                                                r16 = r22[r19]
                                                r19 = upvalueValues[upvalues[1]]
                                                r22 = {
                                                    r16(r19)
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
                                                    r19 = 115
                                                    r16 = r22 * r19
                                                    r22 = 257
                                                    ReturnVal = r16 % r22
                                                    upvalueValues[upvalues[3]] = ReturnVal
                                                    state = 55
                                                end
                                            else
                                                if state == 55 then
                                                    r22 = upvalueValues[upvalues[3]]
                                                    r19 = 1
                                                    r16 = r22 ~= r19
                                                    state = r16 and (56) or (54)
                                                end
                                            end
                                        else
                                            if state == 56 then
                                                r22 = upvalueValues[upvalues[3]]
                                                r19 = 32
                                                r17 = 2
                                                r16 = r22 % r19
                                                r5 = upvalueValues[upvalues[4]]
                                                r6 = upvalueValues[upvalues[2]]
                                                r31 = upvalueValues[upvalues[3]]
                                                r30 = r31 - r16
                                                r31 = 32
                                                r20 = r30 / r31
                                                r12 = 13
                                                r24 = r12 - r20
                                                r11 = r17 ^ r24
                                                r14 = r6 / r11
                                                r17 = 256
                                                r25 = r5(r14)
                                                r5 = 4294967296
                                                r19 = r25 % r5
                                                r25 = 2
                                                r5 = r25 ^ r16
                                                r16 = nil
                                                r11 = 1
                                                r22 = r19 / r5
                                                r5 = upvalueValues[upvalues[4]]
                                                r6 = r22 % r11
                                                r11 = 4294967296
                                                r14 = r6 * r11
                                                r25 = r5(r14)
                                                r5 = upvalueValues[upvalues[4]]
                                                r14 = r5(r22)
                                                r19 = r25 + r14
                                                r25 = 65536
                                                r5 = r19 % r25
                                                r6 = 65536
                                                r14 = r19 - r5
                                                r25 = r14 / r6
                                                r6 = 256
                                                r14 = r5 % r6
                                                r11 = r5 - r14
                                                r22 = nil
                                                r6 = r11 / r17
                                                r17 = 256
                                                r11 = r25 % r17
                                                r12 = 256
                                                r5 = nil
                                                r24 = r25 - r11
                                                r17 = r24 / r12
                                                r25 = nil
                                                r24 = {
                                                    r14,
                                                    r6,
                                                    r11,
                                                    r17
                                                }
                                                upvalueValues[upvalues[1]] = r24
                                                r19 = nil
                                                r6 = nil
                                                r11 = nil
                                                r17 = nil
                                                r14 = nil
                                                state = 53
                                            end
                                        end
                                    end
                                else
                                    -- createClosure3 entry 639738 -> 57, states 57-63
                                    if state <= 60 then
                                        if state <= 58 then
                                            if state <= 57 then
                                                if state == 57 then -- entry 639738 -> 57
                                                    r16 = args[1]
                                                    r22 = args[2]
                                                    state = upvalueValues[upvalues[1]]
                                                    r19 = state
                                                    state = r19[r22]
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
                                                    r5 = ReturnVal
                                                    r25 = 35184372088832
                                                    ReturnVal = r22 % r25
                                                    upvalueValues[upvalues[4]] = ReturnVal
                                                    r6 = 255
                                                    r14 = r22 % r6
                                                    r24 = 1
                                                    r6 = 2
                                                    r25 = r14 + r6
                                                    upvalueValues[upvalues[5]] = r25
                                                    r12 = r24
                                                    r11 = "string"
                                                    r6 = _env[r11]
                                                    r11 = "len"
                                                    r14 = r6[r11]
                                                    r6 = r14(r16)
                                                    r14 = ""
                                                    r19[r22] = r14
                                                    r24 = 0
                                                    r20 = r12 < r24
                                                    r11 = 1
                                                    r24 = r11 - r12
                                                    r17 = r6
                                                    r14 = 154
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
                                                    r24 = r24 + r12
                                                    r11 = r24 <= r17
                                                    r30 = not r20
                                                    r11 = r30 and r11
                                                    r30 = r24 >= r17
                                                    r30 = r20 and r30
                                                    r11 = r30 or r11
                                                    r30 = (62)
                                                    state = r11 and r30
                                                    r11 = (63)
                                                    state = state or r11
                                                end
                                            else
                                                if state == 62 then
                                                    r11 = r24
                                                    r18 = "string"
                                                    r23 = _env[r18]
                                                    r18 = "byte"
                                                    r33 = r23[r18]
                                                    r23 = r33(r16, r11)
                                                    r33 = upvalueValues[upvalues[6]]
                                                    r18 = r33()
                                                    r9 = r23 + r18
                                                    r31 = r9 + r14
                                                    r9 = 256
                                                    r30 = r31 % r9
                                                    r14 = r30
                                                    r18 = 1
                                                    r9 = r19[r22]
                                                    r11 = nil
                                                    r23 = r14 + r18
                                                    r33 = r5[r23]
                                                    r31 = r9 .. r33
                                                    r19[r22] = r31
                                                    state = 61
                                                end
                                            end
                                        else
                                            if state == 63 then
                                                r5 = nil
                                                r6 = nil
                                                r14 = nil
                                                state = 60
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 75 then
                            if state <= 71 then
                                if state <= 64 then
                                    -- createClosure2 entry 7446844 -> 64, states 64-64
                                    if state == 64 then -- entry 7446844 -> 64
                                        state = upvalueValues[upvalues[1]]
                                        ReturnVal = "Destroy"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure3 entry 1142541 -> 65, states 65-71
                                    if state <= 68 then
                                        if state <= 66 then
                                            if state <= 65 then
                                                if state == 65 then -- entry 1142541 -> 65
                                                    r16 = upvalueValues[upvalues[1]]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r5 = upvalueValues[upvalues[3]]
                                                    r14 = "yF'\247"
                                                    r6 = 13782995671314
                                                    r25 = r5(r14, r6)
                                                    r22 = r19[r25]
                                                    ReturnVal = r16[r22]
                                                    r16 = upvalueValues[upvalues[4]]
                                                    state = ReturnVal == r16
                                                    state = state and (66) or (67)
                                                end
                                            else
                                                if state == 66 then
                                                    state = upvalueValues[upvalues[5]]
                                                    ReturnVal = "Destroy"
                                                    ReturnVal = state[ReturnVal]
                                                    r25 = "\007\203\231\169\194\245\183\026Lnr\2314\193L\248\181\144\175\177\255\023\243\159`\131+eU\171x\208\243I\249\201\017\250"
                                                    r14 = 30948554586187
                                                    ReturnVal = ReturnVal(state)
                                                    ReturnVal = "print"
                                                    state = _env[ReturnVal]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r19 = upvalueValues[upvalues[3]]
                                                    r5 = r19(r25, r14)
                                                    r16 = r22[r5]
                                                    ReturnVal = state(r16)
                                                    r16 = "Instance"
                                                    ReturnVal = _env[r16]
                                                    r14 = 23930955295623
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r19 = upvalueValues[upvalues[3]]
                                                    r17 = "k>\224\246\247\156\213~\\\140\006\127\216\241"
                                                    r25 = "\019\248C"
                                                    r5 = r19(r25, r14)
                                                    r25 = "\175Y\029Gg\197\216\157\169"
                                                    r16 = r22[r5]
                                                    state = ReturnVal[r16]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r19 = upvalueValues[upvalues[3]]
                                                    r14 = 12322699941482
                                                    r5 = r19(r25, r14)
                                                    r16 = r22[r5]
                                                    ReturnVal = state(r16)
                                                    r16 = allocUpvalue()
                                                    r14 = 9745957949882
                                                    upvalueValues[r16] = ReturnVal
                                                    state = upvalueValues[r16]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r19 = upvalueValues[upvalues[3]]
                                                    r25 = ";\189\r\207"
                                                    r5 = r19(r25, r14)
                                                    r14 = "w\220}(5\r\150"
                                                    ReturnVal = r22[r5]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r6 = 30569336403866
                                                    r5 = upvalueValues[upvalues[3]]
                                                    r25 = r5(r14, r6)
                                                    r22 = r19[r25]
                                                    state[ReturnVal] = r22
                                                    state = upvalueValues[r16]
                                                    r14 = 13129111476193
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r25 = "P\174\141\\\015\029\127\150U\193\239\137"
                                                    r19 = upvalueValues[upvalues[3]]
                                                    r5 = r19(r25, r14)
                                                    r25 = "*\236c\164+\1969x\n\184\188\004$r"
                                                    r14 = 27850892325545
                                                    ReturnVal = r22[r5]
                                                    r22 = false
                                                    state[ReturnVal] = r22
                                                    state = upvalueValues[r16]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r19 = upvalueValues[upvalues[3]]
                                                    r5 = r19(r25, r14)
                                                    ReturnVal = r22[r5]
                                                    r25 = "Enum"
                                                    r5 = _env[r25]
                                                    r14 = upvalueValues[upvalues[2]]
                                                    r6 = upvalueValues[upvalues[3]]
                                                    r24 = 26389144727552
                                                    r11 = r6(r17, r24)
                                                    r25 = r14[r11]
                                                    r17 = 18214798483745
                                                    r19 = r5[r25]
                                                    r11 = "g\151\026\203\212\240\136"
                                                    r25 = upvalueValues[upvalues[2]]
                                                    r14 = upvalueValues[upvalues[3]]
                                                    r6 = r14(r11, r17)
                                                    r5 = r25[r6]
                                                    r25 = "\156k\171B\138\n"
                                                    r22 = r19[r5]
                                                    r14 = 9442429620524
                                                    r17 = "\193\2559\1923+\229"
                                                    state[ReturnVal] = r22
                                                    state = upvalueValues[r16]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r19 = upvalueValues[upvalues[3]]
                                                    r5 = r19(r25, r14)
                                                    ReturnVal = r22[r5]
                                                    r25 = "game"
                                                    r5 = _env[r25]
                                                    r14 = upvalueValues[upvalues[2]]
                                                    r6 = upvalueValues[upvalues[3]]
                                                    r24 = 28646330070043
                                                    r11 = r6(r17, r24)
                                                    r25 = r14[r11]
                                                    r17 = 22718518847827
                                                    r19 = r5[r25]
                                                    r11 = "f\006\2248iD\181R\020\008\022"
                                                    r25 = upvalueValues[upvalues[2]]
                                                    r14 = upvalueValues[upvalues[3]]
                                                    r6 = r14(r11, r17)
                                                    r5 = r25[r6]
                                                    r22 = r19[r5]
                                                    r25 = upvalueValues[upvalues[2]]
                                                    r14 = upvalueValues[upvalues[3]]
                                                    r17 = 19572235789210
                                                    r11 = "\r{Vh\1500\029\167\005"
                                                    r19 = "WaitForChild"
                                                    r19 = r22[r19]
                                                    r6 = r14(r11, r17)
                                                    r17 = "r\251\r"
                                                    r5 = r25[r6]
                                                    r19 = r19(r22, r5)
                                                    state[ReturnVal] = r19
                                                    r6 = 25041621888396
                                                    r14 = "kB\192"
                                                    r22 = "Instance"
                                                    ReturnVal = _env[r22]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r5 = upvalueValues[upvalues[3]]
                                                    r11 = 18413275701630
                                                    r25 = r5(r14, r6)
                                                    r22 = r19[r25]
                                                    r6 = 28992836498620
                                                    state = ReturnVal[r22]
                                                    r14 = "D\194\006p!"
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r5 = upvalueValues[upvalues[3]]
                                                    r25 = r5(r14, r6)
                                                    r22 = r19[r25]
                                                    ReturnVal = state(r22)
                                                    r22 = allocUpvalue()
                                                    r14 = "\211FK#"
                                                    upvalueValues[r22] = ReturnVal
                                                    state = upvalueValues[r22]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r6 = 1044826620390
                                                    r5 = upvalueValues[upvalues[3]]
                                                    r25 = r5(r14, r6)
                                                    ReturnVal = r19[r25]
                                                    r5 = upvalueValues[upvalues[2]]
                                                    r25 = upvalueValues[upvalues[3]]
                                                    r6 = "\130H\018\194\137).k9"
                                                    r14 = r25(r6, r11)
                                                    r19 = r5[r14]
                                                    state[ReturnVal] = r19
                                                    state = upvalueValues[r22]
                                                    r12 = 1142376645139
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r14 = "\026B\218*"
                                                    r5 = upvalueValues[upvalues[3]]
                                                    r6 = 14477642717781
                                                    r25 = r5(r14, r6)
                                                    ReturnVal = r19[r25]
                                                    r25 = "UDim2"
                                                    r5 = _env[r25]
                                                    r14 = upvalueValues[upvalues[2]]
                                                    r6 = upvalueValues[upvalues[3]]
                                                    r24 = 26926947643642
                                                    r11 = r6(r17, r24)
                                                    r6 = 0
                                                    r25 = r14[r11]
                                                    r19 = r5[r25]
                                                    r25 = 0
                                                    r11 = 400
                                                    r14 = 350
                                                    r5 = r19(r25, r14, r6, r11)
                                                    r14 = "uZ\225\172\225#\001H"
                                                    r6 = 28623426302992
                                                    state[ReturnVal] = r5
                                                    state = upvalueValues[r22]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r5 = upvalueValues[upvalues[3]]
                                                    r25 = r5(r14, r6)
                                                    ReturnVal = r19[r25]
                                                    r25 = "UDim2"
                                                    r17 = "\170%\170"
                                                    r5 = _env[r25]
                                                    r14 = upvalueValues[upvalues[2]]
                                                    r6 = upvalueValues[upvalues[3]]
                                                    r24 = 16616595676729
                                                    r11 = r6(r17, r24)
                                                    r25 = r14[r11]
                                                    r6 = 0.5
                                                    r14 = -175
                                                    r19 = r5[r25]
                                                    r25 = 0.5
                                                    r11 = -200
                                                    r5 = r19(r25, r14, r6, r11)
                                                    state[ReturnVal] = r5
                                                    r17 = "m\2536\127-\226\187"
                                                    state = upvalueValues[r22]
                                                    r14 = "\177\235\225\021)\212!3\253j\127;\191\215-R"
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r5 = upvalueValues[upvalues[3]]
                                                    r6 = 34835896926045
                                                    r25 = r5(r14, r6)
                                                    ReturnVal = r19[r25]
                                                    r25 = "Color3"
                                                    r5 = _env[r25]
                                                    r14 = upvalueValues[upvalues[2]]
                                                    r6 = upvalueValues[upvalues[3]]
                                                    r24 = 10115857764966
                                                    r11 = r6(r17, r24)
                                                    r6 = 35
                                                    r25 = r14[r11]
                                                    r19 = r5[r25]
                                                    r25 = 30
                                                    r14 = 30
                                                    r5 = r19(r25, r14, r6)
                                                    state[ReturnVal] = r5
                                                    r14 = "CI'h\022\209-\164\227%\004\254\133\006\020"
                                                    r6 = 6140326578987
                                                    state = upvalueValues[r22]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r11 = 4261658052544
                                                    r5 = upvalueValues[upvalues[3]]
                                                    r25 = r5(r14, r6)
                                                    r14 = "T8\131d\161\136"
                                                    r6 = 11203751433313
                                                    ReturnVal = r19[r25]
                                                    r19 = 0
                                                    state[ReturnVal] = r19
                                                    state = upvalueValues[r22]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r5 = upvalueValues[upvalues[3]]
                                                    r25 = r5(r14, r6)
                                                    ReturnVal = r19[r25]
                                                    r19 = true
                                                    r6 = 7993148821130
                                                    r14 = "\214\198S\159\147("
                                                    state[ReturnVal] = r19
                                                    state = upvalueValues[r22]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r5 = upvalueValues[upvalues[3]]
                                                    r25 = r5(r14, r6)
                                                    ReturnVal = r19[r25]
                                                    r19 = upvalueValues[r16]
                                                    state[ReturnVal] = r19
                                                    r6 = "X\016\211"
                                                    r19 = "Instance"
                                                    r17 = "\019\231@"
                                                    ReturnVal = _env[r19]
                                                    r5 = upvalueValues[upvalues[2]]
                                                    r25 = upvalueValues[upvalues[3]]
                                                    r14 = r25(r6, r11)
                                                    r19 = r5[r14]
                                                    state = ReturnVal[r19]
                                                    r5 = upvalueValues[upvalues[2]]
                                                    r25 = upvalueValues[upvalues[3]]
                                                    r11 = 17568301129716
                                                    r6 = "*\179\027F\230\187\220\006"
                                                    r14 = r25(r6, r11)
                                                    r19 = r5[r14]
                                                    ReturnVal = state(r19)
                                                    r14 = "<\194%X\004\210\006\230\151Dz\231"
                                                    r19 = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r6 = 2965715977573
                                                    r5 = upvalueValues[upvalues[3]]
                                                    r25 = r5(r14, r6)
                                                    state = ReturnVal[r25]
                                                    r25 = "UDim"
                                                    r5 = _env[r25]
                                                    r14 = upvalueValues[upvalues[2]]
                                                    r6 = upvalueValues[upvalues[3]]
                                                    r24 = 26493191843888
                                                    r11 = r6(r17, r24)
                                                    r6 = 31351296801031
                                                    r25 = r14[r11]
                                                    r14 = 12
                                                    ReturnVal = r5[r25]
                                                    r25 = 0
                                                    r5 = ReturnVal(r25, r14)
                                                    r11 = "\210\246\023"
                                                    r19[state] = r5
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r14 = "_\247\147)\249M"
                                                    r5 = upvalueValues[upvalues[3]]
                                                    r17 = 33914270563760
                                                    r25 = r5(r14, r6)
                                                    state = ReturnVal[r25]
                                                    ReturnVal = upvalueValues[r22]
                                                    r5 = "Instance"
                                                    r19[state] = ReturnVal
                                                    ReturnVal = _env[r5]
                                                    r25 = upvalueValues[upvalues[2]]
                                                    r14 = upvalueValues[upvalues[3]]
                                                    r6 = r14(r11, r17)
                                                    r5 = r25[r6]
                                                    state = ReturnVal[r5]
                                                    r25 = upvalueValues[upvalues[2]]
                                                    r14 = upvalueValues[upvalues[3]]
                                                    r11 = "-\144y%@2\143\218\160\229"
                                                    r17 = 15239775050680
                                                    r6 = r14(r11, r17)
                                                    r5 = r25[r6]
                                                    r17 = 8475856424810
                                                    r6 = "\160\024\166\018"
                                                    ReturnVal = state(r5)
                                                    r5 = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r11 = 8489624637297
                                                    r25 = upvalueValues[upvalues[3]]
                                                    r14 = r25(r6, r11)
                                                    state = ReturnVal[r14]
                                                    r25 = upvalueValues[upvalues[2]]
                                                    r14 = upvalueValues[upvalues[3]]
                                                    r11 = "\142[1\"\248\230"
                                                    r6 = r14(r11, r17)
                                                    ReturnVal = r25[r6]
                                                    r5[state] = ReturnVal
                                                    r11 = 10624739349331
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r6 = "\224\025\233\017gW\158P\227\250_\154l\155s\246}\212\158\021\2427"
                                                    r25 = upvalueValues[upvalues[3]]
                                                    r14 = r25(r6, r11)
                                                    r11 = 21618736129875
                                                    state = ReturnVal[r14]
                                                    ReturnVal = 1
                                                    r5[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r6 = "\146;Op\200'\210."
                                                    r25 = upvalueValues[upvalues[3]]
                                                    r14 = r25(r6, r11)
                                                    state = ReturnVal[r14]
                                                    r14 = "UDim2"
                                                    r25 = _env[r14]
                                                    r6 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r24 = "\164n\154"
                                                    r17 = r11(r24, r12)
                                                    r14 = r6[r17]
                                                    ReturnVal = r25[r14]
                                                    r17 = -15
                                                    r6 = -15
                                                    r11 = 0
                                                    r14 = 0
                                                    r25 = ReturnVal(r14, r6, r11, r17)
                                                    r5[state] = r25
                                                    r11 = 1829511971667
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r25 = upvalueValues[upvalues[3]]
                                                    r6 = "@\n\244\192"
                                                    r14 = r25(r6, r11)
                                                    state = ReturnVal[r14]
                                                    r14 = "UDim2"
                                                    r25 = _env[r14]
                                                    r12 = 4649162508404
                                                    r6 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r24 = "\000FE"
                                                    r17 = r11(r24, r12)
                                                    r11 = 1
                                                    r14 = r6[r17]
                                                    ReturnVal = r25[r14]
                                                    r6 = 30
                                                    r14 = 1
                                                    r17 = 30
                                                    r25 = ReturnVal(r14, r6, r11, r17)
                                                    r11 = 10584806265664
                                                    r6 = "\017C\248\218\179&"
                                                    r12 = 20333091824892
                                                    r5[state] = r25
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r25 = upvalueValues[upvalues[3]]
                                                    r14 = r25(r6, r11)
                                                    state = ReturnVal[r14]
                                                    r11 = 30475842041711
                                                    ReturnVal = 0
                                                    r5[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r25 = upvalueValues[upvalues[3]]
                                                    r6 = "\186+,\251}"
                                                    r14 = r25(r6, r11)
                                                    r17 = 27367681356232
                                                    state = ReturnVal[r14]
                                                    r11 = "D\176\128vNkF\216z~F\246\196\176\179\253k1x\210\128\001%\2029\172\021\216\247\134&p\002\247\237\020\128\n4\187\153\029\236\180\177\140"
                                                    r25 = upvalueValues[upvalues[2]]
                                                    r14 = upvalueValues[upvalues[3]]
                                                    r6 = r14(r11, r17)
                                                    ReturnVal = r25[r6]
                                                    r5[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r6 = "\030^\133|3i\200\155M\023\169"
                                                    r11 = 30157042054874
                                                    r25 = upvalueValues[upvalues[3]]
                                                    r14 = r25(r6, r11)
                                                    state = ReturnVal[r14]
                                                    r14 = "Color3"
                                                    r25 = _env[r14]
                                                    r6 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r24 = "p/\015\160\031\n\199"
                                                    r17 = r11(r24, r12)
                                                    r14 = r6[r17]
                                                    r6 = 0
                                                    ReturnVal = r25[r14]
                                                    r11 = 0
                                                    r14 = 0
                                                    r25 = ReturnVal(r14, r6, r11)
                                                    r20 = 3561995421306
                                                    r6 = "H7\t1\172\012\156\246\157$\202\003\168\226]\233L"
                                                    r5[state] = r25
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r25 = upvalueValues[upvalues[3]]
                                                    r11 = 21176145749636
                                                    r14 = r25(r6, r11)
                                                    state = ReturnVal[r14]
                                                    r11 = 31201868675265
                                                    r30 = 25281527098876
                                                    ReturnVal = 0.5
                                                    r5[state] = ReturnVal
                                                    r6 = "m\252WJ\025Y\140H\182"
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r25 = upvalueValues[upvalues[3]]
                                                    r14 = r25(r6, r11)
                                                    r6 = "Enum"
                                                    state = ReturnVal[r14]
                                                    r12 = "V9\0158](\168))"
                                                    r14 = _env[r6]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r17 = upvalueValues[upvalues[3]]
                                                    r24 = r17(r12, r20)
                                                    r6 = r11[r24]
                                                    r25 = r14[r6]
                                                    r6 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r12 = 469416378586
                                                    r24 = "V\157\001\017\132"
                                                    r17 = r11(r24, r12)
                                                    r14 = r6[r17]
                                                    r11 = 22944444213692
                                                    ReturnVal = r25[r14]
                                                    r5[state] = ReturnVal
                                                    r12 = 32185421724299
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r25 = upvalueValues[upvalues[3]]
                                                    r6 = "\138\175\180k\232\003}\187\0313\174"
                                                    r14 = r25(r6, r11)
                                                    r20 = 27487996686848
                                                    state = ReturnVal[r14]
                                                    r14 = "Rect"
                                                    r25 = _env[r14]
                                                    r6 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r24 = "L\018\018"
                                                    r17 = r11(r24, r12)
                                                    r14 = r6[r17]
                                                    r17 = 118
                                                    r11 = 118
                                                    ReturnVal = r25[r14]
                                                    r6 = 10
                                                    r14 = 10
                                                    r25 = ReturnVal(r14, r6, r11, r17)
                                                    r5[state] = r25
                                                    r17 = "\243\138\207"
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r25 = upvalueValues[upvalues[3]]
                                                    r11 = 17086012055316
                                                    r6 = "A1#\234\230C"
                                                    r14 = r25(r6, r11)
                                                    state = ReturnVal[r14]
                                                    ReturnVal = upvalueValues[r22]
                                                    r5[state] = ReturnVal
                                                    r25 = "Instance"
                                                    ReturnVal = _env[r25]
                                                    r14 = upvalueValues[upvalues[2]]
                                                    r6 = upvalueValues[upvalues[3]]
                                                    r24 = 22595969050906
                                                    r11 = r6(r17, r24)
                                                    r12 = "\219~\158"
                                                    r25 = r14[r11]
                                                    state = ReturnVal[r25]
                                                    r17 = "p\1779\238c"
                                                    r14 = upvalueValues[upvalues[2]]
                                                    r6 = upvalueValues[upvalues[3]]
                                                    r24 = 7116907400434
                                                    r11 = r6(r17, r24)
                                                    r17 = 23226338634303
                                                    r31 = 6597940644864
                                                    r25 = r14[r11]
                                                    ReturnVal = state(r25)
                                                    r25 = ReturnVal
                                                    r11 = "V\223\205\165"
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r14 = upvalueValues[upvalues[3]]
                                                    r6 = r14(r11, r17)
                                                    r17 = "\238\000b2B\200"
                                                    state = ReturnVal[r6]
                                                    r14 = upvalueValues[upvalues[2]]
                                                    r6 = upvalueValues[upvalues[3]]
                                                    r24 = 33799720484219
                                                    r11 = r6(r17, r24)
                                                    ReturnVal = r14[r11]
                                                    r17 = 15110056221564
                                                    r25[state] = ReturnVal
                                                    r11 = "\204\236\208G"
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r14 = upvalueValues[upvalues[3]]
                                                    r6 = r14(r11, r17)
                                                    state = ReturnVal[r6]
                                                    r6 = "UDim2"
                                                    r14 = _env[r6]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r17 = upvalueValues[upvalues[3]]
                                                    r24 = r17(r12, r20)
                                                    r17 = 0
                                                    r6 = r11[r24]
                                                    r11 = 0
                                                    ReturnVal = r14[r6]
                                                    r6 = 1
                                                    r24 = 50
                                                    r14 = ReturnVal(r6, r11, r17, r24)
                                                    r25[state] = r14
                                                    r20 = 18075772199137
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r11 = "'j]\143\139c\217/\1970\216\174:\135v\136"
                                                    r17 = 16183649508720
                                                    r14 = upvalueValues[upvalues[3]]
                                                    r6 = r14(r11, r17)
                                                    state = ReturnVal[r6]
                                                    r6 = "Color3"
                                                    r12 = "v\180Lv\193M\177"
                                                    r14 = _env[r6]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r17 = upvalueValues[upvalues[3]]
                                                    r24 = r17(r12, r20)
                                                    r6 = r11[r24]
                                                    r17 = 55
                                                    r11 = 45
                                                    ReturnVal = r14[r6]
                                                    r6 = 45
                                                    r14 = ReturnVal(r6, r11, r17)
                                                    r25[state] = r14
                                                    r17 = 18796816441904
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r11 = "\242\143\150\198\176=Q\129\232\233\214L\227\234y"
                                                    r14 = upvalueValues[upvalues[3]]
                                                    r6 = r14(r11, r17)
                                                    state = ReturnVal[r6]
                                                    r17 = 12350574204535
                                                    ReturnVal = 0
                                                    r25[state] = ReturnVal
                                                    r11 = "\154#(\018\024\135"
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r20 = "g\156}"
                                                    r14 = upvalueValues[upvalues[3]]
                                                    r6 = r14(r11, r17)
                                                    r12 = 16805670674065
                                                    state = ReturnVal[r6]
                                                    ReturnVal = upvalueValues[r22]
                                                    r14 = "Instance"
                                                    r25[state] = ReturnVal
                                                    ReturnVal = _env[r14]
                                                    r6 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r24 = "\172\202\186"
                                                    r17 = r11(r24, r12)
                                                    r14 = r6[r17]
                                                    state = ReturnVal[r14]
                                                    r6 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r12 = 34036591492585
                                                    r24 = "j\245\020Q!\027T\029"
                                                    r17 = r11(r24, r12)
                                                    r14 = r6[r17]
                                                    ReturnVal = state(r14)
                                                    r14 = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r6 = upvalueValues[upvalues[3]]
                                                    r17 = "\149zm\192\242$\224\196\197\255!\183"
                                                    r24 = 20840198858216
                                                    r11 = r6(r17, r24)
                                                    state = ReturnVal[r11]
                                                    r11 = "UDim"
                                                    r6 = _env[r11]
                                                    r17 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r12 = r24(r20, r30)
                                                    r11 = r17[r12]
                                                    r17 = 12
                                                    ReturnVal = r6[r11]
                                                    r11 = 0
                                                    r20 = 7274562882875
                                                    r6 = ReturnVal(r11, r17)
                                                    r17 = "_\200\141\207\157|"
                                                    r30 = ")vH"
                                                    r14[state] = r6
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r6 = upvalueValues[upvalues[3]]
                                                    r24 = 9476958736701
                                                    r11 = r6(r17, r24)
                                                    state = ReturnVal[r11]
                                                    ReturnVal = r25
                                                    r12 = "\202\131\138"
                                                    r14[state] = ReturnVal
                                                    r6 = "Instance"
                                                    ReturnVal = _env[r6]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r17 = upvalueValues[upvalues[3]]
                                                    r24 = r17(r12, r20)
                                                    r6 = r11[r24]
                                                    state = ReturnVal[r6]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r20 = 26423903744016
                                                    r12 = "3\224\159X\151\170h\1401"
                                                    r17 = upvalueValues[upvalues[3]]
                                                    r24 = r17(r12, r20)
                                                    r6 = r11[r24]
                                                    ReturnVal = state(r6)
                                                    r12 = 11306470708368
                                                    r20 = 11923725391280
                                                    r6 = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r24 = "\231m\184k"
                                                    r17 = r11(r24, r12)
                                                    state = ReturnVal[r17]
                                                    r12 = "YUA<m"
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r17 = upvalueValues[upvalues[3]]
                                                    r24 = r17(r12, r20)
                                                    ReturnVal = r11[r24]
                                                    r6[state] = ReturnVal
                                                    r12 = 1824337904465
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r24 = "!Y\147\174"
                                                    r17 = r11(r24, r12)
                                                    state = ReturnVal[r17]
                                                    r17 = "UDim2"
                                                    r11 = _env[r17]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r20 = r12(r30, r31)
                                                    r31 = 31981379959340
                                                    r17 = r24[r20]
                                                    r12 = 1
                                                    r20 = 0
                                                    ReturnVal = r11[r17]
                                                    r17 = 1
                                                    r24 = -100
                                                    r11 = ReturnVal(r17, r24, r12, r20)
                                                    r6[state] = r11
                                                    r12 = 4107034658680
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r24 = "\239\170+Qr\132\145\172"
                                                    r17 = r11(r24, r12)
                                                    r30 = "\169:\237"
                                                    state = ReturnVal[r17]
                                                    r17 = "UDim2"
                                                    r11 = _env[r17]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r20 = r12(r30, r31)
                                                    r17 = r24[r20]
                                                    r12 = 0
                                                    ReturnVal = r11[r17]
                                                    r17 = 0
                                                    r20 = 0
                                                    r24 = 15
                                                    r11 = ReturnVal(r17, r24, r12, r20)
                                                    r6[state] = r11
                                                    r12 = 26931032469756
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r24 = "G\152\028{b\239hA\204,\234\132x\169\186\194\142\006\148\016\022\143"
                                                    r17 = r11(r24, r12)
                                                    r12 = 25283180408317
                                                    r20 = 27998876529389
                                                    state = ReturnVal[r17]
                                                    ReturnVal = 1
                                                    r6[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r24 = "\132iI\152"
                                                    r17 = r11(r24, r12)
                                                    r33 = 32579136453442
                                                    r9 = 25752596786903
                                                    r26 = "\142\209\211L\157qn\029\149\199\204"
                                                    r8 = 10328865886921
                                                    r29 = 34410310794903
                                                    r19 = nil
                                                    r31 = "Gbp5"
                                                    state = ReturnVal[r17]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r12 = "\028\186\131U5\030K\137}\239\200T\027"
                                                    r17 = upvalueValues[upvalues[3]]
                                                    r24 = r17(r12, r20)
                                                    ReturnVal = r11[r24]
                                                    r6[state] = ReturnVal
                                                    r12 = 30493027891063
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r24 = "\187&L\178"
                                                    r17 = r11(r24, r12)
                                                    state = ReturnVal[r17]
                                                    r24 = "Enum"
                                                    r17 = _env[r24]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r30 = r20(r31, r9)
                                                    r24 = r12[r30]
                                                    r11 = r17[r24]
                                                    r31 = 15758948654250
                                                    r30 = "o^y\143\017\166N\171\025n"
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r20 = r12(r30, r31)
                                                    r31 = 3170545599940
                                                    r17 = r24[r20]
                                                    ReturnVal = r11[r17]
                                                    r6[state] = ReturnVal
                                                    r12 = 27494077526530
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r24 = "\176\167\215/@~\246,"
                                                    r17 = r11(r24, r12)
                                                    state = ReturnVal[r17]
                                                    ReturnVal = 20
                                                    r6[state] = ReturnVal
                                                    r30 = "\132\142\231fLa\224"
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r12 = 7654236737004
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r24 = "\177\235\144\253\173\193J\234g\148"
                                                    r17 = r11(r24, r12)
                                                    state = ReturnVal[r17]
                                                    r17 = "Color3"
                                                    r11 = _env[r17]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r20 = r12(r30, r31)
                                                    r12 = 255
                                                    r17 = r24[r20]
                                                    ReturnVal = r11[r17]
                                                    r17 = 255
                                                    r24 = 255
                                                    r11 = ReturnVal(r17, r24, r12)
                                                    r6[state] = r11
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r12 = 34610984926964
                                                    r24 = "\012Z\029\026w\171\190$\247\005x{:s"
                                                    r17 = r11(r24, r12)
                                                    state = ReturnVal[r17]
                                                    r24 = "Enum"
                                                    r17 = _env[r24]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r31 = "\153q\166?\207\186\246(\220\152L\239\235\215"
                                                    r9 = 30880575387691
                                                    r30 = r20(r31, r9)
                                                    r24 = r12[r30]
                                                    r31 = 1785893978943
                                                    r11 = r17[r24]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r30 = "\030\251\153?"
                                                    r20 = r12(r30, r31)
                                                    r17 = r24[r20]
                                                    ReturnVal = r11[r17]
                                                    r5 = nil
                                                    r30 = 23184199969323
                                                    r6[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r12 = 14536669043313
                                                    r24 = "\001\011Bz\236C"
                                                    r17 = r11(r24, r12)
                                                    r11 = "Instance"
                                                    state = ReturnVal[r17]
                                                    ReturnVal = r25
                                                    r6[state] = ReturnVal
                                                    r20 = "~\225$"
                                                    ReturnVal = _env[r11]
                                                    r17 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r12 = r24(r20, r30)
                                                    r11 = r17[r12]
                                                    r30 = 17969543487663
                                                    state = ReturnVal[r11]
                                                    r20 = "\162N\181'\170k\204\177\234g"
                                                    r17 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r12 = r24(r20, r30)
                                                    r11 = r17[r12]
                                                    r20 = 32612441242450
                                                    ReturnVal = state(r11)
                                                    r11 = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r12 = "$\193\202\132"
                                                    r30 = 6796644306012
                                                    r17 = upvalueValues[upvalues[3]]
                                                    r24 = r17(r12, r20)
                                                    r20 = "\137\132\191\149.\193/\011X\186\028"
                                                    state = ReturnVal[r24]
                                                    r17 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r12 = r24(r20, r30)
                                                    ReturnVal = r17[r12]
                                                    r31 = "\228\217\197"
                                                    r11[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r17 = upvalueValues[upvalues[3]]
                                                    r20 = 30320117692198
                                                    r12 = "J\\\246\138"
                                                    r24 = r17(r12, r20)
                                                    state = ReturnVal[r24]
                                                    r24 = "UDim2"
                                                    r17 = _env[r24]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r9 = 14233739811300
                                                    r30 = r20(r31, r9)
                                                    r24 = r12[r30]
                                                    r20 = 0
                                                    ReturnVal = r17[r24]
                                                    r12 = 40
                                                    r30 = 40
                                                    r24 = 0
                                                    r17 = ReturnVal(r24, r12, r20, r30)
                                                    r12 = "\029|tKu\226\160\247"
                                                    r11[state] = r17
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r17 = upvalueValues[upvalues[3]]
                                                    r20 = 5648863693382
                                                    r24 = r17(r12, r20)
                                                    r31 = "\135O\133"
                                                    state = ReturnVal[r24]
                                                    r24 = "UDim2"
                                                    r17 = _env[r24]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r9 = 15975944445199
                                                    r30 = r20(r31, r9)
                                                    r24 = r12[r30]
                                                    r12 = -45
                                                    r30 = 5
                                                    r20 = 0
                                                    ReturnVal = r17[r24]
                                                    r24 = 1
                                                    r17 = ReturnVal(r24, r12, r20, r30)
                                                    r12 = "z\159\233 \248,8L>\168\190TNg\244\153"
                                                    r11[state] = r17
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r17 = upvalueValues[upvalues[3]]
                                                    r20 = 4330894804960
                                                    r24 = r17(r12, r20)
                                                    r31 = "\144\005\154Ob\138\166"
                                                    state = ReturnVal[r24]
                                                    r24 = "Color3"
                                                    r17 = _env[r24]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r9 = 15125822430083
                                                    r30 = r20(r31, r9)
                                                    r24 = r12[r30]
                                                    r20 = 50
                                                    r30 = 26432293138452
                                                    r12 = 50
                                                    ReturnVal = r17[r24]
                                                    r24 = 220
                                                    r17 = ReturnVal(r24, r12, r20)
                                                    r12 = "\006\244;\194\031Y\143\176\198\237\029\n^\190p"
                                                    r11[state] = r17
                                                    r20 = 23250507328074
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r17 = upvalueValues[upvalues[3]]
                                                    r24 = r17(r12, r20)
                                                    state = ReturnVal[r24]
                                                    r12 = "\220d\222\r"
                                                    ReturnVal = 0
                                                    r11[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r20 = 30754798548977
                                                    r17 = upvalueValues[upvalues[3]]
                                                    r24 = r17(r12, r20)
                                                    state = ReturnVal[r24]
                                                    r20 = "\231\194"
                                                    r17 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r12 = r24(r20, r30)
                                                    ReturnVal = r17[r12]
                                                    r12 = "CJnc"
                                                    r11[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r20 = 35174232735739
                                                    r17 = upvalueValues[upvalues[3]]
                                                    r24 = r17(r12, r20)
                                                    r12 = "Enum"
                                                    state = ReturnVal[r24]
                                                    r24 = _env[r12]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r28 = "LU\145N\n\173\209s?6"
                                                    r30 = upvalueValues[upvalues[3]]
                                                    r9 = "UH\"V"
                                                    r31 = r30(r9, r33)
                                                    r12 = r20[r31]
                                                    r17 = r24[r12]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r31 = "_\143\018i;\246\162\176\1421"
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r9 = 33030233783316
                                                    r30 = r20(r31, r9)
                                                    r20 = 4096895289203
                                                    r24 = r12[r30]
                                                    ReturnVal = r17[r24]
                                                    r11[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r12 = "\160k\185\241\017\016\167m"
                                                    r17 = upvalueValues[upvalues[3]]
                                                    r24 = r17(r12, r20)
                                                    r31 = "Q\1801\146\2240|"
                                                    r20 = 29376144307567
                                                    state = ReturnVal[r24]
                                                    ReturnVal = 24
                                                    r11[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r17 = upvalueValues[upvalues[3]]
                                                    r12 = ".\227\224\030\027\197\134\249X\199"
                                                    r24 = r17(r12, r20)
                                                    state = ReturnVal[r24]
                                                    r24 = "Color3"
                                                    r17 = _env[r24]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r9 = 24776894147857
                                                    r30 = r20(r31, r9)
                                                    r24 = r12[r30]
                                                    r20 = 255
                                                    ReturnVal = r17[r24]
                                                    r12 = 255
                                                    r24 = 255
                                                    r17 = ReturnVal(r24, r12, r20)
                                                    r20 = 29380075697521
                                                    r11[state] = r17
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r31 = 22190648748125
                                                    r17 = upvalueValues[upvalues[3]]
                                                    r12 = "\155\215\002\236{/"
                                                    r24 = r17(r12, r20)
                                                    state = ReturnVal[r24]
                                                    ReturnVal = r25
                                                    r11[state] = ReturnVal
                                                    r17 = "Instance"
                                                    ReturnVal = _env[r17]
                                                    r30 = "\170\1995"
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r20 = r12(r30, r31)
                                                    r17 = r24[r20]
                                                    r31 = 20085549950089
                                                    state = ReturnVal[r17]
                                                    r30 = ";4\235[\242F\210\154"
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r20 = r12(r30, r31)
                                                    r17 = r24[r20]
                                                    r30 = 19948300395593
                                                    ReturnVal = state(r17)
                                                    r17 = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r20 = "\018\015l(\n\146%EW\176o\231"
                                                    r12 = r24(r20, r30)
                                                    state = ReturnVal[r12]
                                                    r12 = "UDim"
                                                    r24 = _env[r12]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r30 = upvalueValues[upvalues[3]]
                                                    r9 = "\251\205\014"
                                                    r33 = 2765225297159
                                                    r31 = r30(r9, r33)
                                                    r12 = r20[r31]
                                                    ReturnVal = r24[r12]
                                                    r20 = 8
                                                    r12 = 0
                                                    r24 = ReturnVal(r12, r20)
                                                    r17[state] = r24
                                                    r20 = "\166i>\022\1504"
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r30 = 12395255371403
                                                    r12 = r24(r20, r30)
                                                    state = ReturnVal[r12]
                                                    ReturnVal = r11
                                                    r31 = "\ns\186"
                                                    r17[state] = ReturnVal
                                                    r24 = "Instance"
                                                    ReturnVal = _env[r24]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r9 = 27602537132597
                                                    r30 = r20(r31, r9)
                                                    r24 = r12[r30]
                                                    state = ReturnVal[r24]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r31 = "\212\252\185\248\233l\149\212\253\024\147\138f."
                                                    r9 = 5935770897100
                                                    r30 = r20(r31, r9)
                                                    r24 = r12[r30]
                                                    r31 = "\136\176\221\190"
                                                    ReturnVal = state(r24)
                                                    r24 = allocUpvalue()
                                                    upvalueValues[r24] = ReturnVal
                                                    state = upvalueValues[r24]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r9 = 11821868193152
                                                    r30 = r20(r31, r9)
                                                    ReturnVal = r12[r30]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r30 = upvalueValues[upvalues[3]]
                                                    r33 = 23298740415073
                                                    r9 = "\233\2539\230\149\136\137"
                                                    r31 = r30(r9, r33)
                                                    r12 = r20[r31]
                                                    state[ReturnVal] = r12
                                                    state = upvalueValues[r24]
                                                    r31 = "\245\212\218\011"
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r9 = 7721664876043
                                                    r30 = r20(r31, r9)
                                                    ReturnVal = r12[r30]
                                                    r30 = "UDim2"
                                                    r20 = _env[r30]
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r9 = upvalueValues[upvalues[3]]
                                                    r23 = "X\2456"
                                                    r18 = 26358537236466
                                                    r33 = r9(r23, r18)
                                                    r30 = r31[r33]
                                                    r31 = -20
                                                    r12 = r20[r30]
                                                    r33 = -65
                                                    r30 = 1
                                                    r9 = 1
                                                    r20 = r12(r30, r31, r9, r33)
                                                    state[ReturnVal] = r20
                                                    state = upvalueValues[r24]
                                                    r31 = "t\168\019w\127y\196\012"
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r9 = 11298568295565
                                                    r30 = r20(r31, r9)
                                                    ReturnVal = r12[r30]
                                                    r30 = "UDim2"
                                                    r20 = _env[r30]
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r9 = upvalueValues[upvalues[3]]
                                                    r18 = 25691208363707
                                                    r23 = "\203\247\198"
                                                    r33 = r9(r23, r18)
                                                    r30 = r31[r33]
                                                    r12 = r20[r30]
                                                    r31 = 10
                                                    r30 = 0
                                                    r33 = 55
                                                    r9 = 0
                                                    r20 = r12(r30, r31, r9, r33)
                                                    state[ReturnVal] = r20
                                                    state = upvalueValues[r24]
                                                    r31 = "\150q \127wr\224+\135\177\158\190F\240RGlueq\191\204"
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r9 = 23786606373700
                                                    r30 = r20(r31, r9)
                                                    ReturnVal = r12[r30]
                                                    r12 = 1
                                                    r31 = "<\027\214\206\188\003\026\217\204\151\127\186\222_\137"
                                                    state[ReturnVal] = r12
                                                    state = upvalueValues[r24]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r9 = 18095212601578
                                                    r30 = r20(r31, r9)
                                                    ReturnVal = r12[r30]
                                                    r12 = 0
                                                    state[ReturnVal] = r12
                                                    r31 = "A\224\211KE\223\011\206\205\005\000\221\179dY\235i\211"
                                                    state = upvalueValues[r24]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r9 = 20826953950690
                                                    r30 = r20(r31, r9)
                                                    ReturnVal = r12[r30]
                                                    r12 = 4
                                                    r31 = "\187\207\2367l\018\159\136EO"
                                                    state[ReturnVal] = r12
                                                    state = upvalueValues[r24]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r9 = 2835974096168
                                                    r30 = r20(r31, r9)
                                                    ReturnVal = r12[r30]
                                                    r30 = "UDim2"
                                                    r20 = _env[r30]
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r9 = upvalueValues[upvalues[3]]
                                                    r18 = 23744076311344
                                                    r23 = "\180Dr"
                                                    r33 = r9(r23, r18)
                                                    r30 = r31[r33]
                                                    r31 = 0
                                                    r12 = r20[r30]
                                                    r30 = 0
                                                    r33 = 0
                                                    r9 = 0
                                                    r20 = r12(r30, r31, r9, r33)
                                                    state[ReturnVal] = r20
                                                    state = upvalueValues[r24]
                                                    r18 = "\247\173\166\238\178\183a\184\248\140\223\248J"
                                                    r2 = 750797078877
                                                    r27 = "\002\129\154"
                                                    r6 = nil
                                                    r31 = "\150A\166O\168\008?\239\149u\210\147\132\163<\189\205Or"
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r9 = 1618526307057
                                                    r30 = r20(r31, r9)
                                                    ReturnVal = r12[r30]
                                                    r31 = "Enum"
                                                    r30 = _env[r31]
                                                    r9 = upvalueValues[upvalues[2]]
                                                    r33 = upvalueValues[upvalues[3]]
                                                    r32 = 7166868901129
                                                    r23 = r33(r18, r32)
                                                    r31 = r9[r23]
                                                    r20 = r30[r31]
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r9 = upvalueValues[upvalues[3]]
                                                    r18 = 3685526636212
                                                    r23 = "\246"
                                                    r33 = r9(r23, r18)
                                                    r30 = r31[r33]
                                                    r31 = "\243<U*\215\t"
                                                    r12 = r20[r30]
                                                    state[ReturnVal] = r12
                                                    state = upvalueValues[r24]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r9 = 24869033635132
                                                    r30 = r20(r31, r9)
                                                    ReturnVal = r12[r30]
                                                    r12 = upvalueValues[r22]
                                                    state[ReturnVal] = r12
                                                    r12 = "Instance"
                                                    ReturnVal = _env[r12]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r30 = upvalueValues[upvalues[3]]
                                                    r9 = "\219\227="
                                                    r33 = 2737295361274
                                                    r31 = r30(r9, r33)
                                                    r12 = r20[r31]
                                                    state = ReturnVal[r12]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r30 = upvalueValues[upvalues[3]]
                                                    r9 = "-\213\170\214\241\135\027\004\207\186\192\222"
                                                    r33 = 30117819791048
                                                    r31 = r30(r9, r33)
                                                    r12 = r20[r31]
                                                    ReturnVal = state(r12)
                                                    r31 = "\182\221\189\215\217\247\236"
                                                    r12 = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r9 = 24858894265655
                                                    r30 = r20(r31, r9)
                                                    state = ReturnVal[r30]
                                                    r32 = 28955789554859
                                                    r18 = 132059709501
                                                    r30 = "UDim"
                                                    r17 = nil
                                                    r20 = _env[r30]
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r9 = upvalueValues[upvalues[3]]
                                                    r23 = "\199\207\214"
                                                    r33 = r9(r23, r18)
                                                    r30 = r31[r33]
                                                    ReturnVal = r20[r30]
                                                    r31 = 10
                                                    r30 = 0
                                                    r20 = ReturnVal(r30, r31)
                                                    r12[state] = r20
                                                    r31 = "8B\029.\216\172qO0"
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r9 = 27963681469149
                                                    r30 = r20(r31, r9)
                                                    state = ReturnVal[r30]
                                                    r31 = "Enum"
                                                    r30 = _env[r31]
                                                    r9 = upvalueValues[upvalues[2]]
                                                    r33 = upvalueValues[upvalues[3]]
                                                    r18 = "\228G\254yF\029\231\197a"
                                                    r23 = r33(r18, r32)
                                                    r31 = r9[r23]
                                                    r20 = r30[r31]
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r9 = upvalueValues[upvalues[3]]
                                                    r18 = 29508204033452
                                                    r23 = "\149\2129\253U\129\223\221\166k\179"
                                                    r33 = r9(r23, r18)
                                                    r30 = r31[r33]
                                                    ReturnVal = r20[r30]
                                                    r12[state] = ReturnVal
                                                    r31 = "\130q\144+8\202"
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r9 = 17556203528175
                                                    r30 = r20(r31, r9)
                                                    state = ReturnVal[r30]
                                                    ReturnVal = upvalueValues[r24]
                                                    r12[state] = ReturnVal
                                                    state = createClosure7(80, {
                                                        upvalues[2],
                                                        upvalues[3],
                                                        r24
                                                    })
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r20 = state
                                                    r9 = upvalueValues[upvalues[3]]
                                                    state = createClosure4(81, {
                                                        upvalues[2],
                                                        upvalues[3],
                                                        r24
                                                    })
                                                    r18 = 2902896641351
                                                    r23 = "\192o(\142\001\185O\179"
                                                    r33 = r9(r23, r18)
                                                    ReturnVal = r31[r33]
                                                    r9 = upvalueValues[upvalues[2]]
                                                    r30 = state
                                                    r33 = upvalueValues[upvalues[3]]
                                                    r32 = 8366465240887
                                                    r18 = "\154%M\136\190^\221\137\020I\029b"
                                                    r23 = r33(r18, r32)
                                                    r31 = r9[r23]
                                                    r9 = createClosure3(82, {
                                                        upvalues[2],
                                                        upvalues[3]
                                                    })
                                                    state = r20(ReturnVal, r31, r9)
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r9 = upvalueValues[upvalues[3]]
                                                    r23 = "S\219\189G"
                                                    r18 = 32113603590762
                                                    r33 = r9(r23, r18)
                                                    ReturnVal = r31[r33]
                                                    r9 = upvalueValues[upvalues[2]]
                                                    r33 = upvalueValues[upvalues[3]]
                                                    r18 = "\132%\219\n\145F\021q"
                                                    r32 = 24331068910658
                                                    r23 = r33(r18, r32)
                                                    r31 = r9[r23]
                                                    r9 = createClosure6(83, {
                                                        upvalues[2],
                                                        upvalues[3]
                                                    })
                                                    state = r20(ReturnVal, r31, r9)
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r9 = upvalueValues[upvalues[3]]
                                                    r23 = "\174G\187.\005\252\182W"
                                                    r18 = 18479685050781
                                                    r33 = r9(r23, r18)
                                                    ReturnVal = r31[r33]
                                                    r9 = upvalueValues[upvalues[2]]
                                                    r33 = upvalueValues[upvalues[3]]
                                                    r32 = 5232955656580
                                                    r18 = "\133\"\127X7SD=\242C\232\141_\147"
                                                    r23 = r33(r18, r32)
                                                    r31 = r9[r23]
                                                    r9 = createClosure5(84, {
                                                        upvalues[2],
                                                        upvalues[3]
                                                    })
                                                    state = r30(ReturnVal, r31, r9)
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r9 = upvalueValues[upvalues[3]]
                                                    r23 = "9\161Fv\020S\247\167A"
                                                    r18 = 20418019927331
                                                    r33 = r9(r23, r18)
                                                    ReturnVal = r31[r33]
                                                    r9 = upvalueValues[upvalues[2]]
                                                    r33 = upvalueValues[upvalues[3]]
                                                    r32 = 14418378168890
                                                    r18 = "\183j\217Dt)\203\176&\002\024ZG"
                                                    r23 = r33(r18, r32)
                                                    r31 = r9[r23]
                                                    r9 = createClosure0(85, {
                                                        upvalues[2],
                                                        upvalues[3]
                                                    })
                                                    state = r30(ReturnVal, r31, r9)
                                                    ReturnVal = "game"
                                                    state = _env[ReturnVal]
                                                    r9 = upvalueValues[upvalues[2]]
                                                    r33 = upvalueValues[upvalues[3]]
                                                    ReturnVal = "GetService"
                                                    ReturnVal = state[ReturnVal]
                                                    r32 = 26694543650958
                                                    r18 = "\139s\211\233n:yP\178\165\165|\217*\205\231"
                                                    r23 = r33(r18, r32)
                                                    r31 = r9[r23]
                                                    r23 = allocUpvalue()
                                                    r18 = allocUpvalue()
                                                    r33 = allocUpvalue()
                                                    ReturnVal = ReturnVal(state, r31)
                                                    r9 = allocUpvalue()
                                                    r31 = ReturnVal
                                                    state = nil
                                                    upvalueValues[r9] = state
                                                    state = nil
                                                    upvalueValues[r33] = state
                                                    state = nil
                                                    upvalueValues[r23] = state
                                                    r32 = allocUpvalue()
                                                    state = nil
                                                    upvalueValues[r18] = state
                                                    state = createClosure4(86, {
                                                        upvalues[2],
                                                        upvalues[3],
                                                        r23,
                                                        r22,
                                                        r18
                                                    })
                                                    upvalueValues[r32] = state
                                                    r13 = upvalueValues[upvalues[2]]
                                                    r10 = upvalueValues[upvalues[3]]
                                                    r35 = r10(r28, r2)
                                                    ReturnVal = r13[r35]
                                                    state = r25[ReturnVal]
                                                    r13 = createClosure6(87, {
                                                        upvalues[2],
                                                        upvalues[3],
                                                        r9,
                                                        r23,
                                                        r22,
                                                        r18
                                                    })
                                                    ReturnVal = "Connect"
                                                    ReturnVal = state[ReturnVal]
                                                    ReturnVal = ReturnVal(state, r13)
                                                    r28 = "S{\244\162\021\143}\244\019\204gK"
                                                    r13 = upvalueValues[upvalues[2]]
                                                    r18 = releaseUpvalue(r18)
                                                    r10 = upvalueValues[upvalues[3]]
                                                    r2 = 26893572141291
                                                    r35 = r10(r28, r2)
                                                    ReturnVal = r13[r35]
                                                    r28 = "\243z\207uF\229z\235\221\219\237\226"
                                                    state = r25[ReturnVal]
                                                    r13 = createClosure4(92, {
                                                        upvalues[2],
                                                        upvalues[3],
                                                        r33
                                                    })
                                                    ReturnVal = "Connect"
                                                    ReturnVal = state[ReturnVal]
                                                    ReturnVal = ReturnVal(state, r13)
                                                    r13 = upvalueValues[upvalues[2]]
                                                    r10 = upvalueValues[upvalues[3]]
                                                    r2 = 23127173179921
                                                    r35 = r10(r28, r2)
                                                    ReturnVal = r13[r35]
                                                    state = r31[ReturnVal]
                                                    r13 = createClosure1(97, {
                                                        r33,
                                                        r9,
                                                        r32
                                                    })
                                                    ReturnVal = "Connect"
                                                    ReturnVal = state[ReturnVal]
                                                    ReturnVal = ReturnVal(state, r13)
                                                    r28 = "\209\160P\221\191H\221J]\210%\204w\147\2493q"
                                                    r13 = upvalueValues[upvalues[2]]
                                                    r10 = upvalueValues[upvalues[3]]
                                                    r2 = 13651767417045
                                                    r35 = r10(r28, r2)
                                                    ReturnVal = r13[r35]
                                                    r13 = createClosure0(102, {
                                                        upvalues[2],
                                                        upvalues[3],
                                                        r22,
                                                        r16
                                                    })
                                                    state = r11[ReturnVal]
                                                    ReturnVal = "Connect"
                                                    ReturnVal = state[ReturnVal]
                                                    ReturnVal = ReturnVal(state, r13)
                                                    state = upvalueValues[r22]
                                                    r28 = ">\175\247\220"
                                                    r23 = releaseUpvalue(r23)
                                                    r13 = upvalueValues[upvalues[2]]
                                                    r10 = upvalueValues[upvalues[3]]
                                                    r2 = 18805276500532
                                                    r35 = r10(r28, r2)
                                                    r34 = 16366461918661
                                                    r30 = nil
                                                    r16 = releaseUpvalue(r16)
                                                    ReturnVal = r13[r35]
                                                    r35 = "UDim2"
                                                    r10 = _env[r35]
                                                    r28 = upvalueValues[upvalues[2]]
                                                    r2 = upvalueValues[upvalues[3]]
                                                    r7 = r2(r27, r34)
                                                    r35 = r28[r7]
                                                    r13 = r10[r35]
                                                    r7 = 0
                                                    r12 = nil
                                                    r35 = 0
                                                    r28 = 0
                                                    r2 = 0
                                                    r10 = r13(r35, r28, r2, r7)
                                                    state[ReturnVal] = r10
                                                    ReturnVal = "game"
                                                    state = _env[ReturnVal]
                                                    r10 = upvalueValues[upvalues[2]]
                                                    r35 = upvalueValues[upvalues[3]]
                                                    r2 = "\132t4\199\224v\157>\017\t\172\204"
                                                    r7 = 8834640154641
                                                    r28 = r35(r2, r7)
                                                    r33 = releaseUpvalue(r33)
                                                    r13 = r10[r28]
                                                    r7 = "\243\158{"
                                                    ReturnVal = "GetService"
                                                    r10 = "TweenInfo"
                                                    r31 = nil
                                                    ReturnVal = state[ReturnVal]
                                                    ReturnVal = ReturnVal(state, r13)
                                                    r13 = ReturnVal
                                                    ReturnVal = _env[r10]
                                                    r9 = releaseUpvalue(r9)
                                                    r35 = upvalueValues[upvalues[2]]
                                                    r28 = upvalueValues[upvalues[3]]
                                                    r27 = 11950593365436
                                                    r2 = r28(r7, r27)
                                                    r10 = r35[r2]
                                                    state = ReturnVal[r10]
                                                    r10 = 0.4
                                                    r7 = "Enum"
                                                    r2 = _env[r7]
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r24 = releaseUpvalue(r24)
                                                    r11 = nil
                                                    r21 = r34(r26, r29)
                                                    r7 = r27[r21]
                                                    r28 = r2[r7]
                                                    r7 = upvalueValues[upvalues[2]]
                                                    r27 = upvalueValues[upvalues[3]]
                                                    r21 = "=\019\174\254"
                                                    r26 = 34510614036166
                                                    r34 = r27(r21, r26)
                                                    r2 = r7[r34]
                                                    r35 = r28[r2]
                                                    r27 = "Enum"
                                                    r7 = _env[r27]
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r21 = upvalueValues[upvalues[3]]
                                                    r29 = "g\147W\190:\237\230\228\165R*8kG\212"
                                                    r26 = r21(r29, r8)
                                                    r27 = r34[r26]
                                                    r2 = r7[r27]
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r20 = nil
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r26 = "E#)"
                                                    r29 = 28495172989909
                                                    r21 = r34(r26, r29)
                                                    r7 = r27[r21]
                                                    r28 = r2[r7]
                                                    ReturnVal = state(r10, r35, r28)
                                                    r32 = releaseUpvalue(r32)
                                                    r7 = "\153\213\026\213"
                                                    r27 = 804972347766
                                                    r14 = nil
                                                    r35 = upvalueValues[upvalues[2]]
                                                    r28 = upvalueValues[upvalues[3]]
                                                    r10 = ReturnVal
                                                    r2 = r28(r7, r27)
                                                    ReturnVal = r35[r2]
                                                    r2 = "UDim2"
                                                    r28 = _env[r2]
                                                    r7 = upvalueValues[upvalues[2]]
                                                    r27 = upvalueValues[upvalues[3]]
                                                    r21 = "\201#^"
                                                    r26 = 14363879709216
                                                    r34 = r27(r21, r26)
                                                    r2 = r7[r34]
                                                    r35 = r28[r2]
                                                    r34 = 400
                                                    r27 = 0
                                                    r7 = 350
                                                    r2 = 0
                                                    r28 = r35(r2, r7, r27, r34)
                                                    state = {
                                                        [ReturnVal] = r28
                                                    }
                                                    r35 = state
                                                    ReturnVal = upvalueValues[r22]
                                                    r25 = nil
                                                    state = "Create"
                                                    state = r13[state]
                                                    state = state(r13, ReturnVal, r10, r35)
                                                    r28 = state
                                                    state = "Play"
                                                    r13 = nil
                                                    state = r28[state]
                                                    r10 = nil
                                                    r22 = releaseUpvalue(r22)
                                                    state = state(r28)
                                                    r35 = nil
                                                    r28 = nil
                                                    state = 68
                                                end
                                            end
                                        else
                                            if state <= 67 then
                                                if state == 67 then
                                                    state = upvalueValues[upvalues[1]]
                                                    r16 = upvalueValues[upvalues[2]]
                                                    r22 = upvalueValues[upvalues[3]]
                                                    r5 = "\242*\195\026"
                                                    r25 = 29616980194783
                                                    r19 = r22(r5, r25)
                                                    ReturnVal = r16[r19]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r19 = upvalueValues[upvalues[3]]
                                                    r14 = 22701722708299
                                                    r25 = ""
                                                    r5 = r19(r25, r14)
                                                    r16 = r22[r5]
                                                    state[ReturnVal] = r16
                                                    state = upvalueValues[upvalues[1]]
                                                    r16 = upvalueValues[upvalues[2]]
                                                    r22 = upvalueValues[upvalues[3]]
                                                    r25 = 32817271716785
                                                    r5 = "J\168\006\142\2120i\014\198\247Q\015\246\021y"
                                                    r19 = r22(r5, r25)
                                                    ReturnVal = r16[r19]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r19 = upvalueValues[upvalues[3]]
                                                    r25 = "3\251\171\166\011\018\176@\136\030\239*\204\011a\008\006N\139"
                                                    r14 = 21326180230858
                                                    r5 = r19(r25, r14)
                                                    r16 = r22[r5]
                                                    state[ReturnVal] = r16
                                                    state = upvalueValues[upvalues[1]]
                                                    r16 = upvalueValues[upvalues[2]]
                                                    r22 = upvalueValues[upvalues[3]]
                                                    r25 = 1599000036072
                                                    r5 = "f\233\250k\218\008l\n\210\166+\026w|J\250i"
                                                    r19 = r22(r5, r25)
                                                    ReturnVal = r16[r19]
                                                    r19 = "Color3"
                                                    r22 = _env[r19]
                                                    r5 = upvalueValues[upvalues[2]]
                                                    r25 = upvalueValues[upvalues[3]]
                                                    r6 = "\152\155\173\016h+L"
                                                    r11 = 15801223666878
                                                    r14 = r25(r6, r11)
                                                    r19 = r5[r14]
                                                    r16 = r22[r19]
                                                    r25 = 100
                                                    r5 = 100
                                                    r19 = 255
                                                    r22 = r16(r19, r5, r25)
                                                    state[ReturnVal] = r22
                                                    ReturnVal = upvalueValues[upvalues[6]]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r19 = upvalueValues[upvalues[3]]
                                                    r14 = 16367843843525
                                                    r25 = "\243\174\192y\184\014\168^"
                                                    r5 = r19(r25, r14)
                                                    r16 = r22[r5]
                                                    state = ReturnVal[r16]
                                                    r16 = state
                                                    r22 = 3
                                                    r19 = r22
                                                    r22 = 1
                                                    r5 = r22
                                                    r22 = 0
                                                    r25 = r5 < r22
                                                    ReturnVal = 1
                                                    r22 = ReturnVal - r5
                                                    state = 69
                                                end
                                            else
                                                if state == 68 then
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        if state <= 70 then
                                            if state <= 69 then
                                                if state == 69 then
                                                    r22 = r22 + r5
                                                    ReturnVal = r22 <= r19
                                                    r14 = not r25
                                                    ReturnVal = r14 and ReturnVal
                                                    r14 = r22 >= r19
                                                    r14 = r25 and r14
                                                    ReturnVal = r14 or ReturnVal
                                                    r14 = (70)
                                                    state = ReturnVal and r14
                                                    ReturnVal = (71)
                                                    state = state or ReturnVal
                                                end
                                            else
                                                if state == 70 then
                                                    r14 = r22
                                                    state = upvalueValues[upvalues[6]]
                                                    r6 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r24 = "\005Vn\192'\242R\173"
                                                    r12 = 7190821014804
                                                    r17 = r11(r24, r12)
                                                    ReturnVal = r6[r17]
                                                    r24 = "UDim2"
                                                    r17 = _env[r24]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r9 = 31563333794153
                                                    r31 = "&\204|"
                                                    r30 = r20(r31, r9)
                                                    r24 = r12[r30]
                                                    r11 = r17[r24]
                                                    r12 = 10
                                                    r24 = 0
                                                    r30 = 0
                                                    r20 = 0
                                                    r17 = r11(r24, r12, r20, r30)
                                                    r6 = r16 + r17
                                                    state[ReturnVal] = r6
                                                    r9 = 30317994194725
                                                    ReturnVal = "wait"
                                                    state = _env[ReturnVal]
                                                    r6 = 0.05
                                                    ReturnVal = state(r6)
                                                    state = upvalueValues[upvalues[6]]
                                                    r31 = "\199\149\005"
                                                    r6 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r24 = ">w\165\183\023(\190\135"
                                                    r12 = 7820471504441
                                                    r17 = r11(r24, r12)
                                                    ReturnVal = r6[r17]
                                                    r24 = "UDim2"
                                                    r17 = _env[r24]
                                                    r14 = nil
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r30 = r20(r31, r9)
                                                    r24 = r12[r30]
                                                    r11 = r17[r24]
                                                    r12 = -10
                                                    r30 = 0
                                                    r20 = 0
                                                    r24 = 0
                                                    r17 = r11(r24, r12, r20, r30)
                                                    r6 = r16 + r17
                                                    state[ReturnVal] = r6
                                                    ReturnVal = "wait"
                                                    state = _env[ReturnVal]
                                                    r6 = 0.05
                                                    ReturnVal = state(r6)
                                                    state = 69
                                                end
                                            end
                                        else
                                            if state == 71 then
                                                state = upvalueValues[upvalues[6]]
                                                r22 = upvalueValues[upvalues[2]]
                                                r19 = upvalueValues[upvalues[3]]
                                                r25 = "\243=\218*\223\132\180\208"
                                                r14 = 10030729105982
                                                r5 = r19(r25, r14)
                                                ReturnVal = r22[r5]
                                                r22 = r16
                                                state[ReturnVal] = r22
                                                ReturnVal = "wait"
                                                state = _env[ReturnVal]
                                                r22 = 1
                                                ReturnVal = state(r22)
                                                state = upvalueValues[upvalues[1]]
                                                r22 = upvalueValues[upvalues[2]]
                                                r19 = upvalueValues[upvalues[3]]
                                                r25 = "\220\002\246\203h3e\014\221Z\022\017\231\132\141"
                                                r14 = 29472059815323
                                                r5 = r19(r25, r14)
                                                ReturnVal = r22[r5]
                                                r19 = upvalueValues[upvalues[2]]
                                                r5 = upvalueValues[upvalues[3]]
                                                r6 = 19334630335275
                                                r14 = "\180pP?\195\1406\255\135\011\026\127H=\180\003>"
                                                r25 = r5(r14, r6)
                                                r22 = r19[r25]
                                                state[ReturnVal] = r22
                                                r17 = 8520601554815
                                                state = upvalueValues[upvalues[1]]
                                                r11 = "\237x\1551\230\159i"
                                                r25 = "\137i\227\228\148\149\172\179R]*\207\239]\174\007P"
                                                r14 = 20940135278103
                                                r16 = nil
                                                r22 = upvalueValues[upvalues[2]]
                                                r19 = upvalueValues[upvalues[3]]
                                                r5 = r19(r25, r14)
                                                ReturnVal = r22[r5]
                                                r5 = "Color3"
                                                r19 = _env[r5]
                                                r25 = upvalueValues[upvalues[2]]
                                                r14 = upvalueValues[upvalues[3]]
                                                r6 = r14(r11, r17)
                                                r5 = r25[r6]
                                                r22 = r19[r5]
                                                r25 = 120
                                                r5 = 120
                                                r14 = 120
                                                r19 = r22(r5, r25, r14)
                                                state[ReturnVal] = r19
                                                state = 68
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 74 then
                                    -- createClosure5 entry 4483732 -> 72, states 72-74
                                    if state <= 73 then
                                        if state <= 72 then
                                            if state == 72 then -- entry 4483732 -> 72
                                                r16 = args[1]
                                                state = r16 and (73) or (74)
                                            end
                                        else
                                            if state == 73 then
                                                state = upvalueValues[upvalues[1]]
                                                ReturnVal = state()
                                                state = 74
                                            end
                                        end
                                    else
                                        if state == 74 then
                                            r16 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure4 entry 1909785 -> 75, states 75-75
                                    if state == 75 then -- entry 1909785 -> 75
                                        state = upvalueValues[upvalues[1]]
                                        r16 = upvalueValues[upvalues[2]]
                                        r22 = upvalueValues[upvalues[3]]
                                        r25 = 22434564663502
                                        r5 = "\130\"\147f\213Iu\185\t\221+t\188y\252\216"
                                        r19 = r22(r5, r25)
                                        ReturnVal = r16[r19]
                                        r19 = "Color3"
                                        r22 = _env[r19]
                                        r5 = upvalueValues[upvalues[2]]
                                        r25 = upvalueValues[upvalues[3]]
                                        r6 = "\249\025\166~5\200\222"
                                        r11 = 3927624697636
                                        r14 = r25(r6, r11)
                                        r19 = r5[r14]
                                        r16 = r22[r19]
                                        r25 = 255
                                        r5 = 140
                                        r19 = 0
                                        r22 = r16(r19, r5, r25)
                                        state[ReturnVal] = r22
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 77 then
                                if state <= 76 then
                                    -- createClosure2 entry 3331847 -> 76, states 76-76
                                    if state == 76 then -- entry 3331847 -> 76
                                        state = upvalueValues[upvalues[1]]
                                        r16 = upvalueValues[upvalues[2]]
                                        r22 = upvalueValues[upvalues[3]]
                                        r5 = "\n*\135\234 \182\210\189\204.\250\1327\150\192\155"
                                        r25 = 3616654476948
                                        r19 = r22(r5, r25)
                                        ReturnVal = r16[r19]
                                        r19 = "Color3"
                                        r22 = _env[r19]
                                        r5 = upvalueValues[upvalues[2]]
                                        r25 = upvalueValues[upvalues[3]]
                                        r6 = "Dg\160\130\021b\179"
                                        r11 = 12762264868662
                                        r14 = r25(r6, r11)
                                        r19 = r5[r14]
                                        r16 = r22[r19]
                                        r25 = 255
                                        r19 = 0
                                        r5 = 120
                                        r22 = r16(r19, r5, r25)
                                        state[ReturnVal] = r22
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure0 entry 11095485 -> 77, states 77-77
                                    if state == 77 then -- entry 11095485 -> 77
                                        state = upvalueValues[upvalues[1]]
                                        r16 = upvalueValues[upvalues[2]]
                                        r22 = upvalueValues[upvalues[3]]
                                        r25 = 2842593166635
                                        r5 = "a\150\000can\182\218\211,\208\240\181\254\154\154"
                                        r19 = r22(r5, r25)
                                        ReturnVal = r16[r19]
                                        r19 = "Color3"
                                        r22 = _env[r19]
                                        r5 = upvalueValues[upvalues[2]]
                                        r25 = upvalueValues[upvalues[3]]
                                        r6 = "\014\235U\002;A\235"
                                        r11 = 12088506799613
                                        r14 = r25(r6, r11)
                                        r19 = r5[r14]
                                        r16 = r22[r19]
                                        r25 = 70
                                        r19 = 220
                                        r5 = 70
                                        r22 = r16(r19, r5, r25)
                                        state[ReturnVal] = r22
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure3 entry 9694837 -> 78, states 78-78
                                if state == 78 then -- entry 9694837 -> 78
                                    state = upvalueValues[upvalues[1]]
                                    r16 = upvalueValues[upvalues[2]]
                                    r22 = upvalueValues[upvalues[3]]
                                    r5 = "\1332E\183\207\129\192(\164\226\182\225\130\128\210\225"
                                    r25 = 12893479147379
                                    r19 = r22(r5, r25)
                                    ReturnVal = r16[r19]
                                    r19 = "Color3"
                                    r22 = _env[r19]
                                    r5 = upvalueValues[upvalues[2]]
                                    r25 = upvalueValues[upvalues[3]]
                                    r6 = "1B\169\136\235\015\247"
                                    r11 = 11654952260915
                                    r14 = r25(r6, r11)
                                    r19 = r5[r14]
                                    r16 = r22[r19]
                                    r5 = 50
                                    r25 = 50
                                    r19 = 200
                                    r22 = r16(r19, r5, r25)
                                    state[ReturnVal] = r22
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        end
                    end
                else
                    if state <= 86 then
                        if state <= 82 then
                            if state <= 80 then
                                if state <= 79 then
                                    -- createClosure2 entry 1946438 -> 79, states 79-79
                                    if state == 79 then -- entry 1946438 -> 79
                                        r22 = "TuwO2GHpCwV"
                                        r19 = 14165088
                                        r16 = r22 ^ r19
                                        ReturnVal = 14490216
                                        state = ReturnVal - r16
                                        r16 = state
                                        ReturnVal = "KZZeEXl"
                                        state = ReturnVal / r16
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure7 entry 5526423 -> 80, states 80-80
                                    if state == 80 then -- entry 5526423 -> 80
                                        r22 = args[2]
                                        r19 = allocUpvalue()
                                        upvalueValues[r19] = args[3]
                                        r5 = "Instance"
                                        ReturnVal = _env[r5]
                                        r16 = args[1]
                                        r25 = upvalueValues[upvalues[1]]
                                        r14 = upvalueValues[upvalues[2]]
                                        r17 = 23151493163548
                                        r11 = "\189\129\208"
                                        r6 = r14(r11, r17)
                                        r5 = r25[r6]
                                        state = ReturnVal[r5]
                                        r25 = upvalueValues[upvalues[1]]
                                        r14 = upvalueValues[upvalues[2]]
                                        r11 = "\194{\199\003P"
                                        r17 = 16514480676362
                                        r6 = r14(r11, r17)
                                        r5 = r25[r6]
                                        ReturnVal = state(r5)
                                        r5 = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r25 = upvalueValues[upvalues[2]]
                                        r6 = "!\006\131\004"
                                        r11 = 2457381373048
                                        r14 = r25(r6, r11)
                                        state = ReturnVal[r14]
                                        r14 = upvalueValues[upvalues[1]]
                                        r6 = upvalueValues[upvalues[2]]
                                        r24 = 7915421453925
                                        r17 = "\214\029\007<\016\012y"
                                        r11 = r6(r17, r24)
                                        r25 = r14[r11]
                                        ReturnVal = r16 .. r25
                                        r5[state] = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r25 = upvalueValues[upvalues[2]]
                                        r6 = "@j(\136"
                                        r11 = 19279705973521
                                        r14 = r25(r6, r11)
                                        state = ReturnVal[r14]
                                        r14 = "UDim2"
                                        r25 = _env[r14]
                                        r6 = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r12 = 14852636744452
                                        r24 = "\149\216\154"
                                        r17 = r11(r24, r12)
                                        r14 = r6[r17]
                                        ReturnVal = r25[r14]
                                        r6 = 0
                                        r17 = 100
                                        r14 = 1
                                        r11 = 0
                                        r25 = ReturnVal(r14, r6, r11, r17)
                                        r5[state] = r25
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r25 = upvalueValues[upvalues[2]]
                                        r11 = 333586481307
                                        r6 = "[\209\242\170\187\017\006i\132T\197\251\154Cu\221"
                                        r14 = r25(r6, r11)
                                        state = ReturnVal[r14]
                                        r14 = "Color3"
                                        r25 = _env[r14]
                                        r6 = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r24 = "\219\003\025\212\132\243\163"
                                        r12 = 25215476870621
                                        r17 = r11(r24, r12)
                                        r14 = r6[r17]
                                        ReturnVal = r25[r14]
                                        r11 = 48
                                        r14 = 40
                                        r6 = 40
                                        r25 = ReturnVal(r14, r6, r11)
                                        r5[state] = r25
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r25 = upvalueValues[upvalues[2]]
                                        r11 = 26674504937605
                                        r6 = "S\003\150\178#T&\225]\218\241\186j\207\192"
                                        r14 = r25(r6, r11)
                                        state = ReturnVal[r14]
                                        ReturnVal = 0
                                        r5[state] = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r25 = upvalueValues[upvalues[2]]
                                        r6 = "2\029\131\255\155\147"
                                        r11 = 23632326912764
                                        r14 = r25(r6, r11)
                                        state = ReturnVal[r14]
                                        ReturnVal = upvalueValues[upvalues[3]]
                                        r5[state] = ReturnVal
                                        r25 = "Instance"
                                        ReturnVal = _env[r25]
                                        r14 = upvalueValues[upvalues[1]]
                                        r6 = upvalueValues[upvalues[2]]
                                        r17 = "\246\192\178"
                                        r24 = 32937141746665
                                        r11 = r6(r17, r24)
                                        r25 = r14[r11]
                                        state = ReturnVal[r25]
                                        r14 = upvalueValues[upvalues[1]]
                                        r6 = upvalueValues[upvalues[2]]
                                        r24 = 17848670068855
                                        r17 = "t\140Bp\137^\242s"
                                        r11 = r6(r17, r24)
                                        r25 = r14[r11]
                                        ReturnVal = state(r25)
                                        r25 = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r14 = upvalueValues[upvalues[2]]
                                        r17 = 34930895208329
                                        r11 = "<ui>\001\216\184c\171\204oj"
                                        r6 = r14(r11, r17)
                                        state = ReturnVal[r6]
                                        r6 = "UDim"
                                        r14 = _env[r6]
                                        r11 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r20 = 23443978005156
                                        r12 = "\148\016\018"
                                        r24 = r17(r12, r20)
                                        r6 = r11[r24]
                                        ReturnVal = r14[r6]
                                        r6 = 0
                                        r11 = 8
                                        r14 = ReturnVal(r6, r11)
                                        r25[state] = r14
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r14 = upvalueValues[upvalues[2]]
                                        r17 = 6450904337339
                                        r11 = "d\130&7\130\187"
                                        r6 = r14(r11, r17)
                                        state = ReturnVal[r6]
                                        ReturnVal = r5
                                        r25[state] = ReturnVal
                                        r14 = "Instance"
                                        ReturnVal = _env[r14]
                                        r6 = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r12 = 17841735704692
                                        r24 = "l\019D"
                                        r17 = r11(r24, r12)
                                        r14 = r6[r17]
                                        state = ReturnVal[r14]
                                        r6 = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r24 = "\163\130x\203\003=b\146e"
                                        r12 = 9086559850631
                                        r17 = r11(r24, r12)
                                        r14 = r6[r17]
                                        ReturnVal = state(r14)
                                        r14 = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r6 = upvalueValues[upvalues[2]]
                                        r24 = 9286878433508
                                        r17 = "Q\005T\165"
                                        r11 = r6(r17, r24)
                                        state = ReturnVal[r11]
                                        r11 = "UDim2"
                                        r6 = _env[r11]
                                        r17 = upvalueValues[upvalues[1]]
                                        r24 = upvalueValues[upvalues[2]]
                                        r30 = 6401439910820
                                        r20 = "\249L#"
                                        r12 = r24(r20, r30)
                                        r11 = r17[r12]
                                        ReturnVal = r6[r11]
                                        r17 = -20
                                        r24 = 0
                                        r12 = 25
                                        r11 = 1
                                        r6 = ReturnVal(r11, r17, r24, r12)
                                        r14[state] = r6
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r6 = upvalueValues[upvalues[2]]
                                        r24 = 10705086157688
                                        r17 = "\225\214\209\196\205A\216\170"
                                        r11 = r6(r17, r24)
                                        state = ReturnVal[r11]
                                        r11 = "UDim2"
                                        r6 = _env[r11]
                                        r17 = upvalueValues[upvalues[1]]
                                        r24 = upvalueValues[upvalues[2]]
                                        r30 = 16453747351021
                                        r20 = "\196\152\176"
                                        r12 = r24(r20, r30)
                                        r11 = r17[r12]
                                        ReturnVal = r6[r11]
                                        r12 = 10
                                        r17 = 10
                                        r24 = 0
                                        r11 = 0
                                        r6 = ReturnVal(r11, r17, r24, r12)
                                        r14[state] = r6
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r6 = upvalueValues[upvalues[2]]
                                        r24 = 10086966563417
                                        r17 = "\014\131E\185\237\017\156L\152\004\207\005\1447\204\167\150\139\136\157C\202"
                                        r11 = r6(r17, r24)
                                        state = ReturnVal[r11]
                                        ReturnVal = 1
                                        r14[state] = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r6 = upvalueValues[upvalues[2]]
                                        r24 = 389747703989
                                        r17 = "LN\022;"
                                        r11 = r6(r17, r24)
                                        state = ReturnVal[r11]
                                        ReturnVal = r16
                                        r14[state] = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r6 = upvalueValues[upvalues[2]]
                                        r24 = 19191042712296
                                        r17 = "L\178`\149"
                                        r11 = r6(r17, r24)
                                        state = ReturnVal[r11]
                                        r17 = "Enum"
                                        r11 = _env[r17]
                                        r24 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r31 = 5020414249249
                                        r30 = "\187XQ\164"
                                        r20 = r12(r30, r31)
                                        r17 = r24[r20]
                                        r6 = r11[r17]
                                        r17 = upvalueValues[upvalues[1]]
                                        r24 = upvalueValues[upvalues[2]]
                                        r30 = 25248641969645
                                        r20 = "6\200\173\135i\212w\164\189\237$["
                                        r12 = r24(r20, r30)
                                        r11 = r17[r12]
                                        ReturnVal = r6[r11]
                                        r14[state] = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r6 = upvalueValues[upvalues[2]]
                                        r17 = "D\132h\020\011\249ES"
                                        r24 = 19323102421798
                                        r11 = r6(r17, r24)
                                        state = ReturnVal[r11]
                                        ReturnVal = 14
                                        r14[state] = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r6 = upvalueValues[upvalues[2]]
                                        r24 = 32984095718399
                                        r17 = "\236\157\006J[\163N:\213="
                                        r11 = r6(r17, r24)
                                        state = ReturnVal[r11]
                                        r11 = "Color3"
                                        r6 = _env[r11]
                                        r17 = upvalueValues[upvalues[1]]
                                        r24 = upvalueValues[upvalues[2]]
                                        r20 = "\149a\170\012\231\139\142"
                                        r30 = 19020059435672
                                        r12 = r24(r20, r30)
                                        r11 = r17[r12]
                                        ReturnVal = r6[r11]
                                        r24 = 200
                                        r17 = 200
                                        r11 = 200
                                        r6 = ReturnVal(r11, r17, r24)
                                        r14[state] = r6
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r6 = upvalueValues[upvalues[2]]
                                        r24 = 13646934350034
                                        r17 = "b\217\028\179~\245b\183l\174\005\250\000\180"
                                        r11 = r6(r17, r24)
                                        state = ReturnVal[r11]
                                        r17 = "Enum"
                                        r11 = _env[r17]
                                        r24 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r31 = 15355927141358
                                        r30 = "<e\202\255*Db;\226\243\168\214\177N"
                                        r20 = r12(r30, r31)
                                        r17 = r24[r20]
                                        r6 = r11[r17]
                                        r17 = upvalueValues[upvalues[1]]
                                        r24 = upvalueValues[upvalues[2]]
                                        r20 = "\179\017UE"
                                        r30 = 6987180494005
                                        r12 = r24(r20, r30)
                                        r11 = r17[r12]
                                        ReturnVal = r6[r11]
                                        r14[state] = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r6 = upvalueValues[upvalues[2]]
                                        r24 = 30161415026397
                                        r17 = "r/\225\171\169\127"
                                        r11 = r6(r17, r24)
                                        state = ReturnVal[r11]
                                        ReturnVal = r5
                                        r14[state] = ReturnVal
                                        r6 = "Instance"
                                        ReturnVal = _env[r6]
                                        r11 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r20 = 17813308514406
                                        r12 = "E\201\017"
                                        r24 = r17(r12, r20)
                                        r6 = r11[r24]
                                        state = ReturnVal[r6]
                                        r11 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r20 = 14902601947931
                                        r12 = "\178\188O,\199\149\174"
                                        r24 = r17(r12, r20)
                                        r6 = r11[r24]
                                        ReturnVal = state(r6)
                                        r6 = allocUpvalue()
                                        upvalueValues[r6] = ReturnVal
                                        state = upvalueValues[r6]
                                        r11 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r12 = "\160tU;"
                                        r20 = 14256748894702
                                        r24 = r17(r12, r20)
                                        ReturnVal = r11[r24]
                                        r17 = upvalueValues[upvalues[1]]
                                        r24 = upvalueValues[upvalues[2]]
                                        r30 = 32665945258859
                                        r20 = "\174\169\146p\r"
                                        r12 = r24(r20, r30)
                                        r11 = r17[r12]
                                        state[ReturnVal] = r11
                                        state = upvalueValues[r6]
                                        r11 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r12 = "\249\192\136\204"
                                        r20 = 15236188429238
                                        r24 = r17(r12, r20)
                                        ReturnVal = r11[r24]
                                        r24 = "UDim2"
                                        r17 = _env[r24]
                                        r12 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r9 = 4287853660108
                                        r31 = "Lb\133"
                                        r30 = r20(r31, r9)
                                        r24 = r12[r30]
                                        r11 = r17[r24]
                                        r12 = -20
                                        r24 = 1
                                        r20 = 0
                                        r30 = 30
                                        r17 = r11(r24, r12, r20, r30)
                                        state[ReturnVal] = r17
                                        state = upvalueValues[r6]
                                        r11 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r20 = 24156078091248
                                        r12 = "2\232\160)\158~\218\249"
                                        r24 = r17(r12, r20)
                                        ReturnVal = r11[r24]
                                        r24 = "UDim2"
                                        r17 = _env[r24]
                                        r12 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r31 = "\134F\195"
                                        r9 = 3684143236787
                                        r30 = r20(r31, r9)
                                        r24 = r12[r30]
                                        r11 = r17[r24]
                                        r20 = 0
                                        r12 = 10
                                        r30 = 35
                                        r24 = 0
                                        r17 = r11(r24, r12, r20, r30)
                                        state[ReturnVal] = r17
                                        state = upvalueValues[r6]
                                        r11 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r20 = 2040623301558
                                        r12 = "\001\028\132,w\145&\218r=\138\219(w\216G"
                                        r24 = r17(r12, r20)
                                        ReturnVal = r11[r24]
                                        r24 = "Color3"
                                        r17 = _env[r24]
                                        r12 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r9 = 6820376054887
                                        r31 = "\203\136\004b\235\252n"
                                        r30 = r20(r31, r9)
                                        r24 = r12[r30]
                                        r11 = r17[r24]
                                        r12 = 25
                                        r20 = 30
                                        r24 = 25
                                        r17 = r11(r24, r12, r20)
                                        state[ReturnVal] = r17
                                        state = upvalueValues[r6]
                                        r11 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r20 = 3430666339901
                                        r12 = "\201\211\136\029\027e\224J\152\002X\212M\166\227"
                                        r24 = r17(r12, r20)
                                        ReturnVal = r11[r24]
                                        r11 = 0
                                        state[ReturnVal] = r11
                                        state = upvalueValues[r6]
                                        r11 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r20 = 25484601306715
                                        r12 = "j$&\016"
                                        r24 = r17(r12, r20)
                                        ReturnVal = r11[r24]
                                        r17 = upvalueValues[upvalues[1]]
                                        r24 = upvalueValues[upvalues[2]]
                                        r30 = 13271280408611
                                        r20 = "y\234\2212"
                                        r12 = r24(r20, r30)
                                        r11 = r17[r12]
                                        state[ReturnVal] = r11
                                        state = upvalueValues[r6]
                                        r11 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r20 = 21272402060977
                                        r12 = "\018\207\216p\245\217\171VLA0xu\223\225"
                                        r24 = r17(r12, r20)
                                        ReturnVal = r11[r24]
                                        r17 = upvalueValues[upvalues[1]]
                                        r24 = upvalueValues[upvalues[2]]
                                        r30 = 34571161173730
                                        r20 = "Y\169\236/\026\014%\188I\143\029=|\251"
                                        r12 = r24(r20, r30)
                                        r11 = r17[r12]
                                        state[ReturnVal] = r11
                                        state = upvalueValues[r6]
                                        r11 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r12 = "/\231\223\223"
                                        r20 = 22558158842120
                                        r24 = r17(r12, r20)
                                        ReturnVal = r11[r24]
                                        r12 = "Enum"
                                        r24 = _env[r12]
                                        r20 = upvalueValues[upvalues[1]]
                                        r30 = upvalueValues[upvalues[2]]
                                        r9 = "\144\137J|"
                                        r33 = 27673841971798
                                        r31 = r30(r9, r33)
                                        r12 = r20[r31]
                                        r17 = r24[r12]
                                        r12 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r9 = 10091875226203
                                        r31 = "\235\011h\173\247\027"
                                        r30 = r20(r31, r9)
                                        r24 = r12[r30]
                                        r11 = r17[r24]
                                        state[ReturnVal] = r11
                                        state = upvalueValues[r6]
                                        r11 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r12 = "\146Zdj\016\205-?"
                                        r20 = 3827534087926
                                        r24 = r17(r12, r20)
                                        ReturnVal = r11[r24]
                                        r11 = 14
                                        state[ReturnVal] = r11
                                        state = upvalueValues[r6]
                                        r11 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r20 = 2576436429999
                                        r12 = "\014D\220\189\218V%l\n\194"
                                        r24 = r17(r12, r20)
                                        ReturnVal = r11[r24]
                                        r24 = "Color3"
                                        r17 = _env[r24]
                                        r12 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r9 = 10481622930192
                                        r31 = ";nb\155\209Cl"
                                        r30 = r20(r31, r9)
                                        r24 = r12[r30]
                                        r11 = r17[r24]
                                        r20 = 255
                                        r24 = 255
                                        r12 = 255
                                        r17 = r11(r24, r12, r20)
                                        state[ReturnVal] = r17
                                        state = upvalueValues[r6]
                                        r11 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r12 = "\004V\197W\015\139\024Je\179\251\129\002v<Z\219"
                                        r20 = 23018576800222
                                        r24 = r17(r12, r20)
                                        ReturnVal = r11[r24]
                                        r24 = "Color3"
                                        r17 = _env[r24]
                                        r12 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r31 = "\223l'\025\230\213A"
                                        r9 = 7596850679249
                                        r30 = r20(r31, r9)
                                        r24 = r12[r30]
                                        r11 = r17[r24]
                                        r24 = 120
                                        r12 = 120
                                        r20 = 120
                                        r17 = r11(r24, r12, r20)
                                        state[ReturnVal] = r17
                                        state = upvalueValues[r6]
                                        r11 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r20 = 545892811006
                                        r12 = "\237\149-\192\144\022\156\003\2053\n\189\231\006\185\214"
                                        r24 = r17(r12, r20)
                                        ReturnVal = r11[r24]
                                        r11 = false
                                        state[ReturnVal] = r11
                                        state = upvalueValues[r6]
                                        r11 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r20 = 7157307133188
                                        r12 = "\146\174\239\149\185\226"
                                        r24 = r17(r12, r20)
                                        ReturnVal = r11[r24]
                                        r11 = r5
                                        state[ReturnVal] = r11
                                        r11 = "Instance"
                                        ReturnVal = _env[r11]
                                        r17 = upvalueValues[upvalues[1]]
                                        r24 = upvalueValues[upvalues[2]]
                                        r20 = "\006\227\157"
                                        r30 = 5396574308816
                                        r12 = r24(r20, r30)
                                        r11 = r17[r12]
                                        state = ReturnVal[r11]
                                        r17 = upvalueValues[upvalues[1]]
                                        r24 = upvalueValues[upvalues[2]]
                                        r30 = 19565952246679
                                        r20 = "nr:\182)\008\158\231"
                                        r12 = r24(r20, r30)
                                        r11 = r17[r12]
                                        ReturnVal = state(r11)
                                        r11 = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r20 = 20804241483223
                                        r12 = "91 y\141\154J\228I\004[F"
                                        r24 = r17(r12, r20)
                                        state = ReturnVal[r24]
                                        r24 = "UDim"
                                        r17 = _env[r24]
                                        r12 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r9 = 20752501450175
                                        r31 = "\237\195\169"
                                        r30 = r20(r31, r9)
                                        r24 = r12[r30]
                                        ReturnVal = r17[r24]
                                        r24 = 0
                                        r12 = 6
                                        r17 = ReturnVal(r24, r12)
                                        r11[state] = r17
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r20 = 26553132740684
                                        r12 = "9\178\169U*G"
                                        r24 = r17(r12, r20)
                                        state = ReturnVal[r24]
                                        ReturnVal = upvalueValues[r6]
                                        r11[state] = ReturnVal
                                        r17 = "Instance"
                                        ReturnVal = _env[r17]
                                        r24 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r31 = 15781284420788
                                        r30 = "\226\183\249"
                                        r20 = r12(r30, r31)
                                        r17 = r24[r20]
                                        state = ReturnVal[r17]
                                        r24 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r30 = " P\017H\208\241Ef*2"
                                        r31 = 3381437875750
                                        r20 = r12(r30, r31)
                                        r17 = r24[r20]
                                        ReturnVal = state(r17)
                                        r17 = allocUpvalue()
                                        upvalueValues[r17] = ReturnVal
                                        state = upvalueValues[r17]
                                        r24 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r31 = 6271362583400
                                        r30 = "P\163\008P"
                                        r20 = r12(r30, r31)
                                        ReturnVal = r24[r20]
                                        r12 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r9 = 30038033315491
                                        r31 = "\227I/\017\235\171"
                                        r30 = r20(r31, r9)
                                        r24 = r12[r30]
                                        state[ReturnVal] = r24
                                        state = upvalueValues[r17]
                                        r24 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r31 = 863011029393
                                        r30 = "\128\243\192\232"
                                        r20 = r12(r30, r31)
                                        ReturnVal = r24[r20]
                                        r20 = "UDim2"
                                        r12 = _env[r20]
                                        r30 = upvalueValues[upvalues[1]]
                                        r31 = upvalueValues[upvalues[2]]
                                        r23 = 21507551012639
                                        r33 = "\178\191q"
                                        r9 = r31(r33, r23)
                                        r20 = r30[r9]
                                        r24 = r12[r20]
                                        r30 = -20
                                        r9 = 30
                                        r20 = 1
                                        r31 = 0
                                        r12 = r24(r20, r30, r31, r9)
                                        state[ReturnVal] = r12
                                        state = upvalueValues[r17]
                                        r24 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r30 = "\154J5s\147.\214\187"
                                        r31 = 34325886991984
                                        r20 = r12(r30, r31)
                                        ReturnVal = r24[r20]
                                        r20 = "UDim2"
                                        r12 = _env[r20]
                                        r30 = upvalueValues[upvalues[1]]
                                        r31 = upvalueValues[upvalues[2]]
                                        r23 = 25019089137026
                                        r33 = "<\145\016"
                                        r9 = r31(r33, r23)
                                        r20 = r30[r9]
                                        r24 = r12[r20]
                                        r31 = 0
                                        r30 = 10
                                        r9 = 70
                                        r20 = 0
                                        r12 = r24(r20, r30, r31, r9)
                                        state[ReturnVal] = r12
                                        state = upvalueValues[r17]
                                        r24 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r31 = 25191694265810
                                        r30 = "\018\212\019\179u\187\243\193\182E\208lE\006\025\183"
                                        r20 = r12(r30, r31)
                                        ReturnVal = r24[r20]
                                        r20 = "Color3"
                                        r12 = _env[r20]
                                        r30 = upvalueValues[upvalues[1]]
                                        r31 = upvalueValues[upvalues[2]]
                                        r23 = 1182138188326
                                        r33 = "\168\204\153r\216\209V"
                                        r9 = r31(r33, r23)
                                        r20 = r30[r9]
                                        r24 = r12[r20]
                                        r31 = 255
                                        r30 = 130
                                        r20 = 70
                                        r12 = r24(r20, r30, r31)
                                        state[ReturnVal] = r12
                                        state = upvalueValues[r17]
                                        r24 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r30 = "(\138\194j\238\208\242\192\137\004\030F\252\237\006"
                                        r31 = 31839465191914
                                        r20 = r12(r30, r31)
                                        ReturnVal = r24[r20]
                                        r24 = 0
                                        state[ReturnVal] = r24
                                        state = upvalueValues[r17]
                                        r24 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r30 = "\\\234\241\030"
                                        r31 = 28622360605712
                                        r20 = r12(r30, r31)
                                        ReturnVal = r24[r20]
                                        r24 = r22
                                        state[ReturnVal] = r24
                                        state = upvalueValues[r17]
                                        r24 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r30 = "\023?I`"
                                        r31 = 26666739511425
                                        r20 = r12(r30, r31)
                                        ReturnVal = r24[r20]
                                        r30 = "Enum"
                                        r20 = _env[r30]
                                        r31 = upvalueValues[upvalues[1]]
                                        r9 = upvalueValues[upvalues[2]]
                                        r18 = 9926373495310
                                        r23 = "\176\141\149\169"
                                        r33 = r9(r23, r18)
                                        r30 = r31[r33]
                                        r12 = r20[r30]
                                        r30 = upvalueValues[upvalues[1]]
                                        r31 = upvalueValues[upvalues[2]]
                                        r23 = 14710390561474
                                        r33 = "|\2352N\146\228\197\169|\\"
                                        r9 = r31(r33, r23)
                                        r20 = r30[r9]
                                        r24 = r12[r20]
                                        state[ReturnVal] = r24
                                        state = upvalueValues[r17]
                                        r24 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r31 = 26053528579940
                                        r30 = "2Y\1648\238\136i\133"
                                        r20 = r12(r30, r31)
                                        ReturnVal = r24[r20]
                                        r24 = 14
                                        state[ReturnVal] = r24
                                        state = upvalueValues[r17]
                                        r24 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r31 = 32484532353814
                                        r30 = "*\201h\159\185\140\206y\230\167"
                                        r20 = r12(r30, r31)
                                        ReturnVal = r24[r20]
                                        r20 = "Color3"
                                        r12 = _env[r20]
                                        r30 = upvalueValues[upvalues[1]]
                                        r31 = upvalueValues[upvalues[2]]
                                        r33 = "\016%\252\031\182\160\""
                                        r23 = 7199860444440
                                        r9 = r31(r33, r23)
                                        r20 = r30[r9]
                                        r24 = r12[r20]
                                        r31 = 255
                                        r30 = 255
                                        r20 = 255
                                        r12 = r24(r20, r30, r31)
                                        state[ReturnVal] = r12
                                        state = upvalueValues[r17]
                                        r24 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r30 = "ds\006B\t\127"
                                        r31 = 961031700927
                                        r20 = r12(r30, r31)
                                        ReturnVal = r24[r20]
                                        r24 = r5
                                        state[ReturnVal] = r24
                                        r24 = "Instance"
                                        ReturnVal = _env[r24]
                                        r12 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r9 = 1127694336525
                                        r31 = ">\006|"
                                        r30 = r20(r31, r9)
                                        r24 = r12[r30]
                                        state = ReturnVal[r24]
                                        r12 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r9 = 9776296874440
                                        r31 = "@\216=\029\176\237\168\193"
                                        r30 = r20(r31, r9)
                                        r24 = r12[r30]
                                        ReturnVal = state(r24)
                                        r24 = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r30 = "mx\196\177\204\028\186\154|%\251y"
                                        r31 = 11442654647504
                                        r20 = r12(r30, r31)
                                        state = ReturnVal[r20]
                                        r20 = "UDim"
                                        r12 = _env[r20]
                                        r30 = upvalueValues[upvalues[1]]
                                        r31 = upvalueValues[upvalues[2]]
                                        r33 = "f\241\169"
                                        r23 = 24146271153131
                                        r9 = r31(r33, r23)
                                        r20 = r30[r9]
                                        ReturnVal = r12[r20]
                                        r30 = 6
                                        r20 = 0
                                        r12 = ReturnVal(r20, r30)
                                        r24[state] = r12
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r31 = 17373147570074
                                        r30 = "\177\2460`\001Z"
                                        r20 = r12(r30, r31)
                                        state = ReturnVal[r20]
                                        ReturnVal = upvalueValues[r17]
                                        r24[state] = ReturnVal
                                        ReturnVal = upvalueValues[r17]
                                        r20 = upvalueValues[upvalues[1]]
                                        r30 = upvalueValues[upvalues[2]]
                                        r33 = 11988547458510
                                        r9 = "\179\134,\199M\165\006+\029\222\151\022\204c\024<\166"
                                        r31 = r30(r9, r33)
                                        r12 = r20[r31]
                                        state = ReturnVal[r12]
                                        r12 = createClosure2(103, {
                                            r17,
                                            upvalues[1],
                                            upvalues[2],
                                            r6,
                                            r19
                                        })
                                        ReturnVal = "Connect"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state, r12)
                                        ReturnVal = {
                                            r5
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 81 then
                                    -- createClosure4 entry 9671160 -> 81, states 81-81
                                    if state == 81 then -- entry 9671160 -> 81
                                        r22 = args[2]
                                        r16 = args[1]
                                        r19 = allocUpvalue()
                                        upvalueValues[r19] = args[3]
                                        r5 = "Instance"
                                        ReturnVal = _env[r5]
                                        r25 = upvalueValues[upvalues[1]]
                                        r14 = upvalueValues[upvalues[2]]
                                        r11 = "\219\131v"
                                        r17 = 22923260340658
                                        r6 = r14(r11, r17)
                                        r5 = r25[r6]
                                        state = ReturnVal[r5]
                                        r25 = upvalueValues[upvalues[1]]
                                        r14 = upvalueValues[upvalues[2]]
                                        r11 = "\200\194\213\019\200"
                                        r17 = 32704732085117
                                        r6 = r14(r11, r17)
                                        r5 = r25[r6]
                                        ReturnVal = state(r5)
                                        r5 = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r25 = upvalueValues[upvalues[2]]
                                        r11 = 11719289099601
                                        r6 = "\137\201\216\181"
                                        r14 = r25(r6, r11)
                                        state = ReturnVal[r14]
                                        r14 = upvalueValues[upvalues[1]]
                                        r6 = upvalueValues[upvalues[2]]
                                        r24 = 29194622924058
                                        r17 = "2\182\254\219z%A"
                                        r11 = r6(r17, r24)
                                        r25 = r14[r11]
                                        ReturnVal = r16 .. r25
                                        r5[state] = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r25 = upvalueValues[upvalues[2]]
                                        r6 = "\243\008\180\191"
                                        r11 = 27558393311776
                                        r14 = r25(r6, r11)
                                        state = ReturnVal[r14]
                                        r14 = "UDim2"
                                        r25 = _env[r14]
                                        r6 = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r12 = 12582300145379
                                        r24 = "KNs"
                                        r17 = r11(r24, r12)
                                        r14 = r6[r17]
                                        ReturnVal = r25[r14]
                                        r17 = 50
                                        r11 = 0
                                        r14 = 1
                                        r6 = 0
                                        r25 = ReturnVal(r14, r6, r11, r17)
                                        r5[state] = r25
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r25 = upvalueValues[upvalues[2]]
                                        r11 = 15517801831482
                                        r6 = "!\144\164!\152\160\029\140\163\221\002:\0259\222h"
                                        r14 = r25(r6, r11)
                                        state = ReturnVal[r14]
                                        r14 = "Color3"
                                        r25 = _env[r14]
                                        r6 = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r12 = 26699908198545
                                        r24 = "\128\178l\151\241\240\234"
                                        r17 = r11(r24, r12)
                                        r14 = r6[r17]
                                        ReturnVal = r25[r14]
                                        r6 = 40
                                        r11 = 48
                                        r14 = 40
                                        r25 = ReturnVal(r14, r6, r11)
                                        r5[state] = r25
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r25 = upvalueValues[upvalues[2]]
                                        r11 = 2417017177189
                                        r6 = "b\165\222r5pDk6\r\182\231\220\232|"
                                        r14 = r25(r6, r11)
                                        state = ReturnVal[r14]
                                        ReturnVal = 0
                                        r5[state] = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r25 = upvalueValues[upvalues[2]]
                                        r11 = 5525123992076
                                        r6 = "<\181\234#q\027"
                                        r14 = r25(r6, r11)
                                        state = ReturnVal[r14]
                                        ReturnVal = upvalueValues[upvalues[3]]
                                        r5[state] = ReturnVal
                                        r25 = "Instance"
                                        ReturnVal = _env[r25]
                                        r14 = upvalueValues[upvalues[1]]
                                        r6 = upvalueValues[upvalues[2]]
                                        r17 = "\158\191\242"
                                        r24 = 27882046386871
                                        r11 = r6(r17, r24)
                                        r25 = r14[r11]
                                        state = ReturnVal[r25]
                                        r14 = upvalueValues[upvalues[1]]
                                        r6 = upvalueValues[upvalues[2]]
                                        r17 = "\1795\2370\149\219#{"
                                        r24 = 34256482369103
                                        r11 = r6(r17, r24)
                                        r25 = r14[r11]
                                        ReturnVal = state(r25)
                                        r25 = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r14 = upvalueValues[upvalues[2]]
                                        r17 = 34147484614173
                                        r11 = "\\\202\243\240zE%\0065_R,"
                                        r6 = r14(r11, r17)
                                        state = ReturnVal[r6]
                                        r6 = "UDim"
                                        r14 = _env[r6]
                                        r11 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r20 = 19364413793081
                                        r12 = "\128\161\007"
                                        r24 = r17(r12, r20)
                                        r6 = r11[r24]
                                        ReturnVal = r14[r6]
                                        r11 = 8
                                        r6 = 0
                                        r14 = ReturnVal(r6, r11)
                                        r25[state] = r14
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r14 = upvalueValues[upvalues[2]]
                                        r17 = 8998483775582
                                        r11 = "\207\r\\6>\149"
                                        r6 = r14(r11, r17)
                                        state = ReturnVal[r6]
                                        ReturnVal = r5
                                        r25[state] = ReturnVal
                                        r14 = "Instance"
                                        ReturnVal = _env[r14]
                                        r6 = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r12 = 13673503070431
                                        r24 = "5\006&"
                                        r17 = r11(r24, r12)
                                        r14 = r6[r17]
                                        state = ReturnVal[r14]
                                        r6 = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r24 = "\221ew\241\000.>\190%r"
                                        r12 = 10233570267805
                                        r17 = r11(r24, r12)
                                        r14 = r6[r17]
                                        ReturnVal = state(r14)
                                        r14 = allocUpvalue()
                                        upvalueValues[r14] = ReturnVal
                                        state = upvalueValues[r14]
                                        r6 = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r24 = "\172\004u\180"
                                        r12 = 6298644024181
                                        r17 = r11(r24, r12)
                                        ReturnVal = r6[r17]
                                        r11 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r20 = 20873363514871
                                        r12 = "',4H\005\020"
                                        r24 = r17(r12, r20)
                                        r6 = r11[r24]
                                        state[ReturnVal] = r6
                                        state = upvalueValues[r14]
                                        r6 = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r12 = 11194601985116
                                        r24 = "J{\198\245"
                                        r17 = r11(r24, r12)
                                        ReturnVal = r6[r17]
                                        r17 = "UDim2"
                                        r11 = _env[r17]
                                        r24 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r30 = "\155\165\r"
                                        r31 = 7426338360706
                                        r20 = r12(r30, r31)
                                        r17 = r24[r20]
                                        r6 = r11[r17]
                                        r24 = -20
                                        r12 = 0
                                        r20 = 35
                                        r17 = 1
                                        r11 = r6(r17, r24, r12, r20)
                                        state[ReturnVal] = r11
                                        state = upvalueValues[r14]
                                        r6 = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r24 = "g\021\002\128\018\030\234\201"
                                        r12 = 30649660405696
                                        r17 = r11(r24, r12)
                                        ReturnVal = r6[r17]
                                        r17 = "UDim2"
                                        r11 = _env[r17]
                                        r24 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r30 = "\252%\023"
                                        r31 = 22637256632621
                                        r20 = r12(r30, r31)
                                        r17 = r24[r20]
                                        r6 = r11[r17]
                                        r20 = 7.5
                                        r24 = 10
                                        r17 = 0
                                        r12 = 0
                                        r11 = r6(r17, r24, r12, r20)
                                        state[ReturnVal] = r11
                                        state = upvalueValues[r14]
                                        r6 = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r24 = "\229\145n\147j\223\144\167\199\211\\s\022\011\005\163"
                                        r12 = 31572609513838
                                        r17 = r11(r24, r12)
                                        ReturnVal = r6[r17]
                                        r17 = "Color3"
                                        r11 = _env[r17]
                                        r24 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r30 = "%Z\173W8\031\171"
                                        r31 = 12838435870554
                                        r20 = r12(r30, r31)
                                        r17 = r24[r20]
                                        r6 = r11[r17]
                                        r24 = 200
                                        r12 = 100
                                        r17 = 100
                                        r11 = r6(r17, r24, r12)
                                        state[ReturnVal] = r11
                                        state = upvalueValues[r14]
                                        r6 = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r12 = 34625804091131
                                        r24 = "\254k\251\005\017\196\202\176L\211\141\191\233\143\149"
                                        r17 = r11(r24, r12)
                                        ReturnVal = r6[r17]
                                        r6 = 0
                                        state[ReturnVal] = r6
                                        state = upvalueValues[r14]
                                        r6 = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r24 = "P\178\181\002"
                                        r12 = 27691815694943
                                        r17 = r11(r24, r12)
                                        ReturnVal = r6[r17]
                                        r6 = r22
                                        state[ReturnVal] = r6
                                        state = upvalueValues[r14]
                                        r6 = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r12 = 423785644229
                                        r24 = "\180\222'\185"
                                        r17 = r11(r24, r12)
                                        ReturnVal = r6[r17]
                                        r24 = "Enum"
                                        r17 = _env[r24]
                                        r12 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r9 = 30995931691105
                                        r31 = "\174\189\171\187"
                                        r30 = r20(r31, r9)
                                        r24 = r12[r30]
                                        r11 = r17[r24]
                                        r24 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r30 = "\193\0034\183\130\175\212@\177\030"
                                        r31 = 9430891270439
                                        r20 = r12(r30, r31)
                                        r17 = r24[r20]
                                        r6 = r11[r17]
                                        state[ReturnVal] = r6
                                        state = upvalueValues[r14]
                                        r6 = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r24 = "\204\228\237\225\242r\206\234"
                                        r12 = 8761636868079
                                        r17 = r11(r24, r12)
                                        ReturnVal = r6[r17]
                                        r6 = 14
                                        state[ReturnVal] = r6
                                        state = upvalueValues[r14]
                                        r6 = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r24 = "VM\254\149\184\129}sT\137"
                                        r12 = 18734819926548
                                        r17 = r11(r24, r12)
                                        ReturnVal = r6[r17]
                                        r17 = "Color3"
                                        r11 = _env[r17]
                                        r24 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r31 = 6951251250340
                                        r30 = "g\194~#%89"
                                        r20 = r12(r30, r31)
                                        r17 = r24[r20]
                                        r6 = r11[r17]
                                        r24 = 255
                                        r17 = 255
                                        r12 = 255
                                        r11 = r6(r17, r24, r12)
                                        state[ReturnVal] = r11
                                        state = upvalueValues[r14]
                                        r6 = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r24 = "\165\023\r\162\240\176"
                                        r12 = 20480925984065
                                        r17 = r11(r24, r12)
                                        ReturnVal = r6[r17]
                                        r6 = r5
                                        state[ReturnVal] = r6
                                        r6 = "Instance"
                                        ReturnVal = _env[r6]
                                        r11 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r12 = "\\\165I"
                                        r20 = 12745070745390
                                        r24 = r17(r12, r20)
                                        r6 = r11[r24]
                                        state = ReturnVal[r6]
                                        r11 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r20 = 34509644562117
                                        r12 = "f\135n\201\220\13270"
                                        r24 = r17(r12, r20)
                                        r6 = r11[r24]
                                        ReturnVal = state(r6)
                                        r6 = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r12 = 33063226129444
                                        r24 = "S\128\133\213\184NM\147Sy\165\210"
                                        r17 = r11(r24, r12)
                                        state = ReturnVal[r17]
                                        r17 = "UDim"
                                        r11 = _env[r17]
                                        r24 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r31 = 28262872576872
                                        r30 = "0\179\187"
                                        r20 = r12(r30, r31)
                                        r17 = r24[r20]
                                        ReturnVal = r11[r17]
                                        r17 = 0
                                        r24 = 6
                                        r11 = ReturnVal(r17, r24)
                                        r6[state] = r11
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r12 = 26025180655446
                                        r24 = "\172\206?\134&\030"
                                        r17 = r11(r24, r12)
                                        state = ReturnVal[r17]
                                        ReturnVal = upvalueValues[r14]
                                        r6[state] = ReturnVal
                                        ReturnVal = upvalueValues[r14]
                                        r17 = upvalueValues[upvalues[1]]
                                        r24 = upvalueValues[upvalues[2]]
                                        r20 = "\231\215y\027\201\194\240\020\139\206\132w\127.)\000\211"
                                        r30 = 295871201417
                                        r12 = r24(r20, r30)
                                        r11 = r17[r12]
                                        state = ReturnVal[r11]
                                        r11 = createClosure0(106, {
                                            r14,
                                            upvalues[1],
                                            upvalues[2],
                                            r19
                                        })
                                        ReturnVal = "Connect"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state, r11)
                                        ReturnVal = {
                                            r5
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure3 entry 14386129 -> 82, states 82-82
                                    if state == 82 then -- entry 14386129 -> 82
                                        r16 = args[1]
                                        r19 = "game"
                                        r22 = _env[r19]
                                        r25 = upvalueValues[upvalues[1]]
                                        r14 = upvalueValues[upvalues[2]]
                                        r11 = "F'$=dj\196\172|%\174\014\190\176I\170\173"
                                        r17 = 11240240059506
                                        r6 = r14(r11, r17)
                                        r19 = "GetService"
                                        r19 = r22[r19]
                                        r5 = r25[r6]
                                        r19 = r19(r22, r5)
                                        r5 = upvalueValues[upvalues[1]]
                                        r25 = upvalueValues[upvalues[2]]
                                        r6 = "\136\244\141\247T"
                                        r11 = 13136466925541
                                        r14 = r25(r6, r11)
                                        r22 = r5[r14]
                                        ReturnVal = r19[r22]
                                        r19 = upvalueValues[upvalues[1]]
                                        r5 = upvalueValues[upvalues[2]]
                                        r14 = "YZ;\239\201"
                                        r6 = 14665109265068
                                        r25 = r5(r14, r6)
                                        r22 = r19[r25]
                                        state = ReturnVal[r22]
                                        ReturnVal = "FireServer"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state, r16)
                                        r16 = nil
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 84 then
                                if state <= 83 then
                                    -- createClosure6 entry 7358755 -> 83, states 83-83
                                    if state == 83 then -- entry 7358755 -> 83
                                        r16 = args[1]
                                        r19 = "game"
                                        r22 = _env[r19]
                                        r25 = upvalueValues[upvalues[1]]
                                        r14 = upvalueValues[upvalues[2]]
                                        r11 = "i|\137\157T(f\0244Z\138)\162\165\152\030*"
                                        r17 = 22091447642159
                                        r6 = r14(r11, r17)
                                        r5 = r25[r6]
                                        r19 = "GetService"
                                        r19 = r22[r19]
                                        r19 = r19(r22, r5)
                                        r5 = upvalueValues[upvalues[1]]
                                        r25 = upvalueValues[upvalues[2]]
                                        r11 = 27578891891242
                                        r6 = "\239\132Z\157H"
                                        r14 = r25(r6, r11)
                                        r22 = r5[r14]
                                        ReturnVal = r19[r22]
                                        r19 = upvalueValues[upvalues[1]]
                                        r5 = upvalueValues[upvalues[2]]
                                        r14 = "\181\222\186\019\255\234d"
                                        r6 = 11783953438063
                                        r25 = r5(r14, r6)
                                        r22 = r19[r25]
                                        state = ReturnVal[r22]
                                        ReturnVal = "FireServer"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state, r16)
                                        r16 = nil
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure5 entry 10916725 -> 84, states 84-84
                                    if state == 84 then -- entry 10916725 -> 84
                                        r22 = "game"
                                        r16 = _env[r22]
                                        r5 = upvalueValues[upvalues[1]]
                                        r25 = upvalueValues[upvalues[2]]
                                        r6 = "+\217\144C_\171#L\155\232\146\192\004&\016\233\012"
                                        r11 = 11225385423979
                                        r14 = r25(r6, r11)
                                        r19 = r5[r14]
                                        r22 = "GetService"
                                        r22 = r16[r22]
                                        r22 = r22(r16, r19)
                                        r19 = upvalueValues[upvalues[1]]
                                        r5 = upvalueValues[upvalues[2]]
                                        r6 = 10987128656892
                                        r14 = "\162n_\187]"
                                        r25 = r5(r14, r6)
                                        r16 = r19[r25]
                                        ReturnVal = r22[r16]
                                        r22 = upvalueValues[upvalues[1]]
                                        r19 = upvalueValues[upvalues[2]]
                                        r14 = 5656741300810
                                        r25 = "\177\230\012&\n8\023v"
                                        r5 = r19(r25, r14)
                                        r16 = r22[r5]
                                        state = ReturnVal[r16]
                                        r22 = upvalueValues[upvalues[1]]
                                        r19 = upvalueValues[upvalues[2]]
                                        r25 = ".\204\2370"
                                        r14 = 7036945009868
                                        r5 = r19(r25, r14)
                                        r16 = r22[r5]
                                        ReturnVal = "FireServer"
                                        ReturnVal = state[ReturnVal]
                                        r22 = 450000000000000
                                        ReturnVal = ReturnVal(state, r16, r22)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                if state <= 85 then
                                    -- createClosure0 entry 16649581 -> 85, states 85-85
                                    if state == 85 then -- entry 16649581 -> 85
                                        r22 = "game"
                                        r16 = _env[r22]
                                        r5 = upvalueValues[upvalues[1]]
                                        r25 = upvalueValues[upvalues[2]]
                                        r11 = 25771764936416
                                        r6 = "y\031\248~\000\217\0284\144\129\127&Be\193I\219"
                                        r14 = r25(r6, r11)
                                        r22 = "GetService"
                                        r22 = r16[r22]
                                        r19 = r5[r14]
                                        r22 = r22(r16, r19)
                                        r19 = upvalueValues[upvalues[1]]
                                        r5 = upvalueValues[upvalues[2]]
                                        r6 = 27369271177672
                                        r14 = "\239\168\239\031\021"
                                        r25 = r5(r14, r6)
                                        r16 = r19[r25]
                                        ReturnVal = r22[r16]
                                        r22 = upvalueValues[upvalues[1]]
                                        r19 = upvalueValues[upvalues[2]]
                                        r14 = 34899304152955
                                        r25 = "S)\008\225\195;b\018o"
                                        r5 = r19(r25, r14)
                                        r16 = r22[r5]
                                        state = ReturnVal[r16]
                                        r5 = "math"
                                        r19 = _env[r5]
                                        r25 = upvalueValues[upvalues[1]]
                                        r14 = upvalueValues[upvalues[2]]
                                        ReturnVal = "FireServer"
                                        ReturnVal = state[ReturnVal]
                                        r17 = 3332463576591
                                        r11 = "j\198j\167"
                                        r6 = r14(r11, r17)
                                        r5 = r25[r6]
                                        r22 = r19[r5]
                                        r16 = 1
                                        ReturnVal = ReturnVal(state, r16, r22)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure4 entry 9061056 -> 86, states 86-86
                                    if state == 86 then -- entry 9061056 -> 86
                                        r33 = "\007"
                                        r30 = 33074029378601
                                        r16 = args[1]
                                        r19 = upvalueValues[upvalues[1]]
                                        r5 = upvalueValues[upvalues[2]]
                                        r6 = 32778158177183
                                        r14 = "\233\153\129\191\225\147\173X"
                                        r25 = r5(r14, r6)
                                        r22 = r19[r25]
                                        ReturnVal = r16[r22]
                                        r22 = upvalueValues[upvalues[3]]
                                        state = ReturnVal - r22
                                        r22 = state
                                        r9 = 1073835049460
                                        state = upvalueValues[upvalues[4]]
                                        r19 = upvalueValues[upvalues[1]]
                                        r5 = upvalueValues[upvalues[2]]
                                        r14 = "\158\147\224/NT\138\167"
                                        r6 = 31595336153464
                                        r25 = r5(r14, r6)
                                        ReturnVal = r19[r25]
                                        r25 = "UDim2"
                                        r5 = _env[r25]
                                        r14 = upvalueValues[upvalues[1]]
                                        r6 = upvalueValues[upvalues[2]]
                                        r24 = 17535352201189
                                        r17 = "\240P/"
                                        r11 = r6(r17, r24)
                                        r25 = r14[r11]
                                        r19 = r5[r25]
                                        r20 = "W"
                                        r31 = "K"
                                        r6 = upvalueValues[upvalues[5]]
                                        r16 = nil
                                        r17 = upvalueValues[upvalues[1]]
                                        r24 = upvalueValues[upvalues[2]]
                                        r12 = r24(r20, r30)
                                        r11 = r17[r12]
                                        r14 = r6[r11]
                                        r11 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r20 = 30198960633582
                                        r12 = "f\132\219\221\201"
                                        r24 = r17(r12, r20)
                                        r6 = r11[r24]
                                        r25 = r14[r6]
                                        r17 = upvalueValues[upvalues[5]]
                                        r12 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r30 = r20(r31, r9)
                                        r24 = r12[r30]
                                        r11 = r17[r24]
                                        r24 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r31 = 32442010860290
                                        r30 = "\141\242\166r\209\199"
                                        r20 = r12(r30, r31)
                                        r17 = r24[r20]
                                        r6 = r11[r17]
                                        r24 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r31 = 27765697622657
                                        r30 = "\222"
                                        r20 = r12(r30, r31)
                                        r17 = r24[r20]
                                        r11 = r22[r17]
                                        r14 = r6 + r11
                                        r17 = upvalueValues[upvalues[5]]
                                        r12 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r9 = 3976731707195
                                        r31 = "j"
                                        r30 = r20(r31, r9)
                                        r24 = r12[r30]
                                        r11 = r17[r24]
                                        r24 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r31 = 5624103995962
                                        r30 = "x-n\1683"
                                        r20 = r12(r30, r31)
                                        r17 = r24[r20]
                                        r6 = r11[r17]
                                        r12 = upvalueValues[upvalues[5]]
                                        r30 = upvalueValues[upvalues[1]]
                                        r31 = upvalueValues[upvalues[2]]
                                        r23 = 3821565593331
                                        r9 = r31(r33, r23)
                                        r20 = r30[r9]
                                        r24 = r12[r20]
                                        r20 = upvalueValues[upvalues[1]]
                                        r30 = upvalueValues[upvalues[2]]
                                        r9 = "E\021\196\195[`"
                                        r33 = 17113198632736
                                        r31 = r30(r9, r33)
                                        r12 = r20[r31]
                                        r17 = r24[r12]
                                        r20 = upvalueValues[upvalues[1]]
                                        r30 = upvalueValues[upvalues[2]]
                                        r33 = 20289213277415
                                        r9 = "="
                                        r31 = r30(r9, r33)
                                        r12 = r20[r31]
                                        r24 = r22[r12]
                                        r22 = nil
                                        r11 = r17 + r24
                                        r5 = r19(r25, r14, r6, r11)
                                        state[ReturnVal] = r5
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        end
                    else
                        if state <= 102 then
                            if state <= 96 then
                                if state <= 91 then
                                    -- createClosure6 entry 9866717 -> 87, states 87-91
                                    if state <= 89 then
                                        if state <= 88 then
                                            if state <= 87 then
                                                if state == 87 then -- entry 9866717 -> 87
                                                    r16 = allocUpvalue()
                                                    upvalueValues[r16] = args[1]
                                                    r5 = upvalueValues[r16]
                                                    r14 = upvalueValues[upvalues[1]]
                                                    r6 = upvalueValues[upvalues[2]]
                                                    r17 = "9\025\199\167\171\191\192\251D\231:\171\214"
                                                    r24 = 6259895438178
                                                    r11 = r6(r17, r24)
                                                    r25 = r14[r11]
                                                    r19 = r5[r25]
                                                    r6 = "Enum"
                                                    r14 = _env[r6]
                                                    r11 = upvalueValues[upvalues[1]]
                                                    r17 = upvalueValues[upvalues[2]]
                                                    r20 = 7196288814359
                                                    r12 = "M\002h\022P\168\130\139\024z\031\211\145"
                                                    r24 = r17(r12, r20)
                                                    r6 = r11[r24]
                                                    r25 = r14[r6]
                                                    r6 = upvalueValues[upvalues[1]]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r12 = 28329688970120
                                                    r24 = "\209\210\234\166D\164\008\031\164\200t\210"
                                                    r17 = r11(r24, r12)
                                                    r14 = r6[r17]
                                                    r5 = r25[r14]
                                                    r22 = r19 == r5
                                                    state = r22 and (88) or (89)
                                                    ReturnVal = r22
                                                end
                                            else
                                                if state == 88 then
                                                    state = ReturnVal and (90) or (91)
                                                end
                                            end
                                        else
                                            if state == 89 then
                                                r5 = upvalueValues[r16]
                                                r14 = upvalueValues[upvalues[1]]
                                                r6 = upvalueValues[upvalues[2]]
                                                r17 = "\132\168\188\142\222$;$\181\201\166W\225"
                                                r24 = 18043848876242
                                                r11 = r6(r17, r24)
                                                r25 = r14[r11]
                                                r19 = r5[r25]
                                                r6 = "Enum"
                                                r14 = _env[r6]
                                                r11 = upvalueValues[upvalues[1]]
                                                r17 = upvalueValues[upvalues[2]]
                                                r20 = 25675973865140
                                                r12 = "\194B|\169o'b\152\184\r\n\250O"
                                                r24 = r17(r12, r20)
                                                r6 = r11[r24]
                                                r25 = r14[r6]
                                                r6 = upvalueValues[upvalues[1]]
                                                r11 = upvalueValues[upvalues[2]]
                                                r24 = "o;\152\187\t"
                                                r12 = 33562644626700
                                                r17 = r11(r24, r12)
                                                r14 = r6[r17]
                                                r5 = r25[r14]
                                                r22 = r19 == r5
                                                ReturnVal = r22
                                                state = 88
                                            end
                                        end
                                    else
                                        if state <= 90 then
                                            if state == 90 then
                                                state = true
                                                upvalueValues[upvalues[3]] = state
                                                r22 = upvalueValues[r16]
                                                r5 = upvalueValues[upvalues[1]]
                                                r25 = upvalueValues[upvalues[2]]
                                                r11 = 29269234300221
                                                r6 = "\189\192\173\000\018\151\178Z"
                                                r14 = r25(r6, r11)
                                                r19 = r5[r14]
                                                ReturnVal = r22[r19]
                                                upvalueValues[upvalues[4]] = ReturnVal
                                                r19 = upvalueValues[upvalues[5]]
                                                r25 = upvalueValues[upvalues[1]]
                                                r14 = upvalueValues[upvalues[2]]
                                                r17 = 1478730416816
                                                r11 = "\254\137DP\236=`\023"
                                                r6 = r14(r11, r17)
                                                r5 = r25[r6]
                                                r22 = r19[r5]
                                                upvalueValues[upvalues[6]] = r22
                                                r5 = upvalueValues[r16]
                                                r14 = upvalueValues[upvalues[1]]
                                                r6 = upvalueValues[upvalues[2]]
                                                r24 = 4035013822294
                                                r17 = "\150\213Ealm\249"
                                                r11 = r6(r17, r24)
                                                r25 = r14[r11]
                                                r19 = r5[r25]
                                                r5 = "Connect"
                                                r5 = r19[r5]
                                                r25 = createClosure3(107, {
                                                    r16,
                                                    upvalues[1],
                                                    upvalues[2],
                                                    upvalues[3]
                                                })
                                                r5 = r5(r19, r25)
                                                state = 91
                                            end
                                        else
                                            if state == 91 then
                                                ReturnVal = {}
                                                r16 = releaseUpvalue(r16)
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure4 entry 11285878 -> 92, states 92-96
                                    if state <= 94 then
                                        if state <= 93 then
                                            if state <= 92 then
                                                if state == 92 then -- entry 11285878 -> 92
                                                    r16 = args[1]
                                                    r25 = upvalueValues[upvalues[1]]
                                                    r14 = upvalueValues[upvalues[2]]
                                                    r17 = 14081649432989
                                                    r11 = "#\199\0254N|\2513\217\015\"\178\169"
                                                    r6 = r14(r11, r17)
                                                    r5 = r25[r6]
                                                    r19 = r16[r5]
                                                    r6 = "Enum"
                                                    r14 = _env[r6]
                                                    r11 = upvalueValues[upvalues[1]]
                                                    r17 = upvalueValues[upvalues[2]]
                                                    r20 = 18168324055308
                                                    r12 = "\230\135n\012X\154\1502\215c\175\206\207"
                                                    r24 = r17(r12, r20)
                                                    r6 = r11[r24]
                                                    r25 = r14[r6]
                                                    r6 = upvalueValues[upvalues[1]]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r24 = "\227\235~\2148q\176\224\173\217\168\134\r"
                                                    r12 = 30226035717883
                                                    r17 = r11(r24, r12)
                                                    r14 = r6[r17]
                                                    r5 = r25[r14]
                                                    r22 = r19 == r5
                                                    state = r22 and (93) or (94)
                                                    ReturnVal = r22
                                                end
                                            else
                                                if state == 93 then
                                                    state = ReturnVal and (95) or (96)
                                                end
                                            end
                                        else
                                            if state == 94 then
                                                r25 = upvalueValues[upvalues[1]]
                                                r14 = upvalueValues[upvalues[2]]
                                                r17 = 5591820978731
                                                r11 = "T\209\170\027\172\253\170u*\011\157\144\233"
                                                r6 = r14(r11, r17)
                                                r5 = r25[r6]
                                                r19 = r16[r5]
                                                r6 = "Enum"
                                                r14 = _env[r6]
                                                r11 = upvalueValues[upvalues[1]]
                                                r17 = upvalueValues[upvalues[2]]
                                                r20 = 15762110127275
                                                r12 = "\002\252\233Nb\025\nt\154\2183\202\170"
                                                r24 = r17(r12, r20)
                                                r6 = r11[r24]
                                                r25 = r14[r6]
                                                r6 = upvalueValues[upvalues[1]]
                                                r11 = upvalueValues[upvalues[2]]
                                                r24 = "w\183B\216\235"
                                                r12 = 26636999766131
                                                r17 = r11(r24, r12)
                                                r14 = r6[r17]
                                                r5 = r25[r14]
                                                r22 = r19 == r5
                                                ReturnVal = r22
                                                state = 93
                                            end
                                        end
                                    else
                                        if state <= 95 then
                                            if state == 95 then
                                                state = r16
                                                upvalueValues[upvalues[3]] = state
                                                state = 96
                                            end
                                        else
                                            if state == 96 then
                                                r16 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 101 then
                                    -- createClosure1 entry 12565819 -> 97, states 97-101
                                    if state <= 99 then
                                        if state <= 98 then
                                            if state <= 97 then
                                                if state == 97 then -- entry 12565819 -> 97
                                                    r19 = upvalueValues[upvalues[1]]
                                                    r16 = args[1]
                                                    r22 = r16 == r19
                                                    state = r22 and (98) or (99)
                                                    ReturnVal = r22
                                                end
                                            else
                                                if state == 98 then
                                                    r22 = upvalueValues[upvalues[2]]
                                                    ReturnVal = r22
                                                    state = 99
                                                end
                                            end
                                        else
                                            if state == 99 then
                                                state = ReturnVal and (100) or (101)
                                            end
                                        end
                                    else
                                        if state <= 100 then
                                            if state == 100 then
                                                state = upvalueValues[upvalues[3]]
                                                ReturnVal = state(r16)
                                                state = 101
                                            end
                                        else
                                            if state == 101 then
                                                r16 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure0 entry 13097590 -> 102, states 102-102
                                    if state == 102 then -- entry 13097590 -> 102
                                        ReturnVal = "game"
                                        state = _env[ReturnVal]
                                        r22 = upvalueValues[upvalues[1]]
                                        r19 = upvalueValues[upvalues[2]]
                                        ReturnVal = "GetService"
                                        ReturnVal = state[ReturnVal]
                                        r25 = "|]\223\193\002\145<\199sj\030\196"
                                        r14 = 21651588310882
                                        r5 = r19(r25, r14)
                                        r16 = r22[r5]
                                        r22 = "TweenInfo"
                                        ReturnVal = ReturnVal(state, r16)
                                        r16 = ReturnVal
                                        ReturnVal = _env[r22]
                                        r19 = upvalueValues[upvalues[1]]
                                        r5 = upvalueValues[upvalues[2]]
                                        r6 = 24201008245765
                                        r14 = "\144\209\020"
                                        r25 = r5(r14, r6)
                                        r22 = r19[r25]
                                        state = ReturnVal[r22]
                                        r14 = "Enum"
                                        r25 = _env[r14]
                                        r6 = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r22 = 0.3
                                        r24 = "\005\2002\147U\002\228\022\236w\021"
                                        r12 = 10909406172120
                                        r17 = r11(r24, r12)
                                        r14 = r6[r17]
                                        r5 = r25[r14]
                                        r14 = upvalueValues[upvalues[1]]
                                        r6 = upvalueValues[upvalues[2]]
                                        r24 = 14232913828323
                                        r17 = "_\226\253\142"
                                        r11 = r6(r17, r24)
                                        r25 = r14[r11]
                                        r19 = r5[r25]
                                        r6 = "Enum"
                                        r14 = _env[r6]
                                        r11 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r20 = 28177739952961
                                        r12 = "\198\212Y\253;+\13294Pe\\\167\247_"
                                        r24 = r17(r12, r20)
                                        r6 = r11[r24]
                                        r25 = r14[r6]
                                        r6 = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r12 = 16533510168083
                                        r24 = "Z\228"
                                        r17 = r11(r24, r12)
                                        r14 = r6[r17]
                                        r5 = r25[r14]
                                        ReturnVal = state(r22, r19, r5)
                                        r22 = ReturnVal
                                        r19 = upvalueValues[upvalues[1]]
                                        r5 = upvalueValues[upvalues[2]]
                                        r14 = "\228\131\197\165"
                                        r6 = 18054479421655
                                        r25 = r5(r14, r6)
                                        ReturnVal = r19[r25]
                                        r25 = "UDim2"
                                        r5 = _env[r25]
                                        r14 = upvalueValues[upvalues[1]]
                                        r6 = upvalueValues[upvalues[2]]
                                        r17 = "NQ\018"
                                        r24 = 10106566480482
                                        r11 = r6(r17, r24)
                                        r25 = r14[r11]
                                        r19 = r5[r25]
                                        r6 = 0
                                        r11 = 0
                                        r25 = 0
                                        r14 = 0
                                        r5 = r19(r25, r14, r6, r11)
                                        state = {
                                            [ReturnVal] = r5
                                        }
                                        ReturnVal = upvalueValues[upvalues[3]]
                                        r19 = state
                                        state = "Create"
                                        state = r16[state]
                                        state = state(r16, ReturnVal, r22, r19)
                                        r5 = state
                                        state = "Play"
                                        state = r5[state]
                                        state = state(r5)
                                        r17 = 1638351340282
                                        r19 = nil
                                        r25 = upvalueValues[upvalues[1]]
                                        r14 = upvalueValues[upvalues[2]]
                                        r11 = "3\234\008\175\254\189w\016\250"
                                        r6 = r14(r11, r17)
                                        ReturnVal = r25[r6]
                                        state = r5[ReturnVal]
                                        ReturnVal = "Wait"
                                        r22 = nil
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state)
                                        state = upvalueValues[upvalues[4]]
                                        ReturnVal = "Destroy"
                                        ReturnVal = state[ReturnVal]
                                        r16 = nil
                                        r5 = nil
                                        ReturnVal = ReturnVal(state)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 106 then
                                if state <= 105 then
                                    -- createClosure2 entry 4570408 -> 103, states 103-105
                                    if state <= 104 then
                                        if state <= 103 then
                                            if state == 103 then -- entry 4570408 -> 103
                                                state = upvalueValues[upvalues[1]]
                                                r16 = upvalueValues[upvalues[2]]
                                                r22 = upvalueValues[upvalues[3]]
                                                r5 = "\167\129pN\245\159\211\128\190;0\157 8\201<"
                                                r25 = 31303578286320
                                                r19 = r22(r5, r25)
                                                ReturnVal = r16[r19]
                                                r19 = "Color3"
                                                r22 = _env[r19]
                                                r5 = upvalueValues[upvalues[2]]
                                                r25 = upvalueValues[upvalues[3]]
                                                r6 = "\001\169\252:\174\226\195"
                                                r11 = 22769721878890
                                                r14 = r25(r6, r11)
                                                r19 = r5[r14]
                                                r16 = r22[r19]
                                                r25 = 235
                                                r5 = 110
                                                r19 = 50
                                                r22 = r16(r19, r5, r25)
                                                state[ReturnVal] = r22
                                                ReturnVal = "wait"
                                                state = _env[ReturnVal]
                                                r16 = 0.1
                                                ReturnVal = state(r16)
                                                state = upvalueValues[upvalues[1]]
                                                r16 = upvalueValues[upvalues[2]]
                                                r22 = upvalueValues[upvalues[3]]
                                                r5 = "\183\190f\007\211\014\159\194VJ8\205\19045\229"
                                                r25 = 31554499705189
                                                r19 = r22(r5, r25)
                                                ReturnVal = r16[r19]
                                                r19 = "Color3"
                                                r22 = _env[r19]
                                                r5 = upvalueValues[upvalues[2]]
                                                r25 = upvalueValues[upvalues[3]]
                                                r11 = 16923447664328
                                                r6 = "]q~'`\020\175"
                                                r14 = r25(r6, r11)
                                                r19 = r5[r14]
                                                r16 = r22[r19]
                                                r25 = 255
                                                r5 = 130
                                                r19 = 70
                                                r22 = r16(r19, r5, r25)
                                                state[ReturnVal] = r22
                                                ReturnVal = "tonumber"
                                                state = _env[ReturnVal]
                                                r22 = upvalueValues[upvalues[4]]
                                                r5 = upvalueValues[upvalues[2]]
                                                r25 = upvalueValues[upvalues[3]]
                                                r6 = "\198\143\181\192"
                                                r11 = 8337851223850
                                                r14 = r25(r6, r11)
                                                r19 = r5[r14]
                                                r16 = r22[r19]
                                                ReturnVal = state(r16)
                                                r16 = ReturnVal
                                                state = r16 and (104) or (105)
                                            end
                                        else
                                            if state == 104 then
                                                state = upvalueValues[upvalues[5]]
                                                ReturnVal = state(r16)
                                                state = 105
                                            end
                                        end
                                    else
                                        if state == 105 then
                                            r16 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure0 entry 14288444 -> 106, states 106-106
                                    if state == 106 then -- entry 14288444 -> 106
                                        state = upvalueValues[upvalues[1]]
                                        r16 = upvalueValues[upvalues[2]]
                                        r22 = upvalueValues[upvalues[3]]
                                        r25 = 33787996585333
                                        r5 = "\221\149\181\222p\202\r\213\194\180\184\201\024\194bf"
                                        r19 = r22(r5, r25)
                                        ReturnVal = r16[r19]
                                        r19 = "Color3"
                                        r22 = _env[r19]
                                        r5 = upvalueValues[upvalues[2]]
                                        r25 = upvalueValues[upvalues[3]]
                                        r11 = 18722854953486
                                        r6 = "\143\139r\148\238\015\166"
                                        r14 = r25(r6, r11)
                                        r19 = r5[r14]
                                        r16 = r22[r19]
                                        r25 = 80
                                        r5 = 180
                                        r19 = 80
                                        r22 = r16(r19, r5, r25)
                                        state[ReturnVal] = r22
                                        ReturnVal = "wait"
                                        state = _env[ReturnVal]
                                        r16 = 0.1
                                        ReturnVal = state(r16)
                                        state = upvalueValues[upvalues[1]]
                                        r16 = upvalueValues[upvalues[2]]
                                        r22 = upvalueValues[upvalues[3]]
                                        r25 = 34552353570521
                                        r5 = "\132\173\027\155d\024\154\222\019\017\212\144\025/y\r"
                                        r19 = r22(r5, r25)
                                        ReturnVal = r16[r19]
                                        r19 = "Color3"
                                        r22 = _env[r19]
                                        r5 = upvalueValues[upvalues[2]]
                                        r25 = upvalueValues[upvalues[3]]
                                        r11 = 32751109094290
                                        r6 = "\022,V\132V\159\008"
                                        r14 = r25(r6, r11)
                                        r19 = r5[r14]
                                        r16 = r22[r19]
                                        r25 = 100
                                        r5 = 200
                                        r19 = 100
                                        r22 = r16(r19, r5, r25)
                                        state[ReturnVal] = r22
                                        state = upvalueValues[upvalues[4]]
                                        ReturnVal = state()
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure3 entry 4550865 -> 107, states 107-109
                                if state <= 108 then
                                    if state <= 107 then
                                        if state == 107 then -- entry 4550865 -> 107
                                            r16 = upvalueValues[upvalues[1]]
                                            r19 = upvalueValues[upvalues[2]]
                                            r5 = upvalueValues[upvalues[3]]
                                            r14 = "\027I~\184|*\136 \179D?\128\244\023"
                                            r6 = 1121807204874
                                            r25 = r5(r14, r6)
                                            r22 = r19[r25]
                                            ReturnVal = r16[r22]
                                            r5 = "Enum"
                                            r19 = _env[r5]
                                            r25 = upvalueValues[upvalues[2]]
                                            r14 = upvalueValues[upvalues[3]]
                                            r11 = "i9\026?\146\144\000\172\148\208=n\008-"
                                            r17 = 21896750344148
                                            r6 = r14(r11, r17)
                                            r5 = r25[r6]
                                            r22 = r19[r5]
                                            r5 = upvalueValues[upvalues[2]]
                                            r25 = upvalueValues[upvalues[3]]
                                            r6 = "\223bP"
                                            r11 = 18453391991185
                                            r14 = r25(r6, r11)
                                            r19 = r5[r14]
                                            r16 = r22[r19]
                                            state = ReturnVal == r16
                                            state = state and (108) or (109)
                                        end
                                    else
                                        if state == 108 then
                                            state = false
                                            upvalueValues[upvalues[4]] = state
                                            state = 109
                                        end
                                    end
                                else
                                    if state == 109 then
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
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        currentUpvalueId = 0
        createClosure1 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1)
                return vm(entryId, {
                    arg1
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 2566751
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 2566751
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
        createClosure = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(...)
                return vm(entryId, {
                    ...
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