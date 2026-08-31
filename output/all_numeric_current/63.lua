return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, allocUpvalue, createClosure, createClosure2, createUpvalueProxy, createClosure3, currentUpvalueId, releaseUpvalue, upvalueValues, createClosure5, createClosure1, createClosure7, vm, upvalueRefCounts, createClosure4, releaseUpvalues, createClosure6, createClosure0)
        upvalueRefCounts = {}
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
        createClosure1 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1)
                return vm(entryId, {
                    arg1
                }, captures, gcProxy)
            end
            return closure
        end
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r9, r10, r11, r12, r13, r14, r15, r16, ReturnVal, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40
            while state do
                if state <= 133 then
                    if state <= 97 then
                        if state <= 76 then
                            if state <= 59 then
                                if state <= 58 then
                                    if state <= 57 then
                                        -- root entry 10170340 -> 1, states 1-57
                                        if state <= 29 then
                                            if state <= 15 then
                                                if state <= 8 then
                                                    if state <= 4 then
                                                        if state <= 2 then
                                                            if state <= 1 then
                                                                if state == 1 then -- entry 10170340 -> 1
                                                                    r18 = allocUpvalue()
                                                                    state = true
                                                                    r37 = createClosure4(58, {
                                                                        r18
                                                                    })
                                                                    r25 = allocUpvalue()
                                                                    upvalueValues[r25] = state
                                                                    r22 = "string"
                                                                    ReturnVal = _env[r22]
                                                                    r22 = "gmatch"
                                                                    state = ReturnVal[r22]
                                                                    r22 = allocUpvalue()
                                                                    upvalueValues[r22] = state
                                                                    state = createClosure5(59, {})
                                                                    r26 = allocUpvalue()
                                                                    upvalueValues[r26] = state
                                                                    state = false
                                                                    upvalueValues[r18] = state
                                                                    r38 = "pcall"
                                                                    r17 = _env[r38]
                                                                    r38 = r17(r37)
                                                                    state = r38 and 2 or 3
                                                                    r11 = args
                                                                    ReturnVal = r38
                                                                end
                                                            else
                                                                if state == 2 then
                                                                    r17 = upvalueValues[r18]
                                                                    ReturnVal = r17
                                                                    state = 3
                                                                end
                                                            end
                                                        else
                                                            if state <= 3 then
                                                                if state == 3 then
                                                                    r17 = ReturnVal
                                                                    r38 = "math"
                                                                    ReturnVal = _env[r38]
                                                                    r38 = "random"
                                                                    state = ReturnVal[r38]
                                                                    r38 = allocUpvalue()
                                                                    upvalueValues[r38] = state
                                                                    r37 = "table"
                                                                    ReturnVal = _env[r37]
                                                                    r37 = "concat"
                                                                    state = ReturnVal[r37]
                                                                    r39 = state
                                                                    r37 = state
                                                                    r34 = "table"
                                                                    r20 = _env[r34]
                                                                    state = r20 and 4 or 5
                                                                    r31 = r20
                                                                end
                                                            else
                                                                if state == 4 then
                                                                    r35 = "table"
                                                                    r34 = _env[r35]
                                                                    r35 = "unpack"
                                                                    r20 = r34[r35]
                                                                    r31 = r20
                                                                    state = 5
                                                                end
                                                            end
                                                        end
                                                    else
                                                        if state <= 6 then
                                                            if state <= 5 then
                                                                if state == 5 then
                                                                    state = r39
                                                                    state = r31 and 6 or 7
                                                                    ReturnVal = r31
                                                                end
                                                            else
                                                                if state == 6 then
                                                                    r31 = allocUpvalue()
                                                                    upvalueValues[r31] = ReturnVal
                                                                    state = upvalueValues[r38]
                                                                    r39 = 3
                                                                    r20 = 65
                                                                    ReturnVal = state(r39, r20)
                                                                    r39 = allocUpvalue()
                                                                    state = 0
                                                                    r20 = state
                                                                    state = 0
                                                                    r32 = createClosure0(60, {})
                                                                    upvalueValues[r39] = ReturnVal
                                                                    r35 = "pcall"
                                                                    ReturnVal = _env[r35]
                                                                    r35 = {
                                                                        ReturnVal(r32)
                                                                    }
                                                                    r34 = state
                                                                    state = {
                                                                        unpack(r35)
                                                                    }
                                                                    r35 = state
                                                                    ReturnVal = 2
                                                                    state = r35[ReturnVal]
                                                                    r32 = state
                                                                    ReturnVal = "tonumber"
                                                                    state = _env[ReturnVal]
                                                                    r29 = upvalueValues[r22]
                                                                    r5 = "tostring"
                                                                    r2 = _env[r5]
                                                                    r5 = r2(r32)
                                                                    r2 = ":(%d*):"
                                                                    r33 = r29(r5, r2)
                                                                    r29 = {
                                                                        r33()
                                                                    }
                                                                    ReturnVal = state(unpack(r29))
                                                                    r29 = allocUpvalue()
                                                                    upvalueValues[r29] = ReturnVal
                                                                    r33 = upvalueValues[r39]
                                                                    r2 = r33
                                                                    r33 = 1
                                                                    r5 = r33
                                                                    r33 = 0
                                                                    r27 = r5 < r33
                                                                    ReturnVal = 1
                                                                    r33 = ReturnVal - r5
                                                                    state = 8
                                                                end
                                                            end
                                                        else
                                                            if state <= 7 then
                                                                if state == 7 then
                                                                    r39 = "unpack"
                                                                    r31 = _env[r39]
                                                                    ReturnVal = r31
                                                                    state = 6
                                                                end
                                                            else
                                                                if state == 8 then
                                                                    r14 = not r27
                                                                    r33 = r33 + r5
                                                                    ReturnVal = r33 <= r2
                                                                    ReturnVal = r14 and ReturnVal
                                                                    r14 = r33 >= r2
                                                                    r14 = r27 and r14
                                                                    ReturnVal = r14 or ReturnVal
                                                                    r14 = 9
                                                                    state = ReturnVal and r14
                                                                    ReturnVal = 10
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
                                                                    r14 = allocUpvalue()
                                                                    upvalueValues[r14] = r33
                                                                    r21 = "math"
                                                                    ReturnVal = _env[r21]
                                                                    r21 = "random"
                                                                    state = ReturnVal[r21]
                                                                    r1 = 100
                                                                    r21 = 1
                                                                    ReturnVal = state(r21, r1)
                                                                    r21 = allocUpvalue()
                                                                    upvalueValues[r21] = ReturnVal
                                                                    state = upvalueValues[r38]
                                                                    r15 = 255
                                                                    r1 = 0
                                                                    ReturnVal = state(r1, r15)
                                                                    r1 = allocUpvalue()
                                                                    upvalueValues[r1] = ReturnVal
                                                                    state = upvalueValues[r38]
                                                                    r12 = upvalueValues[r21]
                                                                    r15 = 1
                                                                    ReturnVal = state(r15, r12)
                                                                    r15 = allocUpvalue()
                                                                    upvalueValues[r15] = ReturnVal
                                                                    ReturnVal = upvalueValues[r38]
                                                                    r24 = 1
                                                                    r40 = 2
                                                                    r12 = ReturnVal(r24, r40)
                                                                    ReturnVal = 1
                                                                    state = r12 == ReturnVal
                                                                    r12 = allocUpvalue()
                                                                    upvalueValues[r12] = state
                                                                    r36 = "tostring"
                                                                    r23 = _env[r36]
                                                                    r7 = upvalueValues[r38]
                                                                    state = "gsub"
                                                                    r19 = 0
                                                                    r3 = 10000
                                                                    r30 = {
                                                                        r7(r19, r3)
                                                                    }
                                                                    state = r32[state]
                                                                    r36 = r23(unpack(r30))
                                                                    r23 = ":"
                                                                    r16 = r36 .. r23
                                                                    r40 = ":"
                                                                    r24 = r40 .. r16
                                                                    ReturnVal = ":(%d*):"
                                                                    state = state(r32, ReturnVal, r24)
                                                                    r24 = allocUpvalue()
                                                                    upvalueValues[r24] = state
                                                                    r16 = createClosure4(61, {
                                                                        r38,
                                                                        r14,
                                                                        r39,
                                                                        r22,
                                                                        r25,
                                                                        r29,
                                                                        r12,
                                                                        r24,
                                                                        r21,
                                                                        r15,
                                                                        r1,
                                                                        r31
                                                                    })
                                                                    r40 = "pcall"
                                                                    ReturnVal = _env[r40]
                                                                    r40 = {
                                                                        ReturnVal(r16)
                                                                    }
                                                                    state = {
                                                                        unpack(r40)
                                                                    }
                                                                    r40 = state
                                                                    state = upvalueValues[r12]
                                                                    state = state and 11 or 12
                                                                end
                                                            else
                                                                if state == 10 then
                                                                    r2 = upvalueValues[r25]
                                                                    state = r2 and 13 or 14
                                                                    r33 = r2
                                                                end
                                                            end
                                                        else
                                                            if state <= 11 then
                                                                if state == 11 then
                                                                    r16 = upvalueValues[r25]
                                                                    state = r16 and 15 or 16
                                                                    ReturnVal = r16
                                                                end
                                                            else
                                                                if state == 12 then
                                                                    r23 = upvalueValues[r25]
                                                                    state = r23 and 17 or 18
                                                                    r16 = r23
                                                                end
                                                            end
                                                        end
                                                    else
                                                        if state <= 14 then
                                                            if state <= 13 then
                                                                if state == 13 then
                                                                    r2 = r20 == r34
                                                                    r33 = r2
                                                                    state = 14
                                                                end
                                                            else
                                                                if state == 14 then
                                                                    upvalueValues[r25] = r33
                                                                    state = upvalueValues[r25]
                                                                    state = state and 19 or 20
                                                                end
                                                            end
                                                        else
                                                            if state == 15 then
                                                                r30 = 1
                                                                r7 = r40[r30]
                                                                r30 = false
                                                                r36 = r7 == r30
                                                                r23 = state
                                                                state = r36 and 21 or 22
                                                                r16 = r36
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
                                                                    upvalueValues[r25] = ReturnVal
                                                                    state = 23
                                                                end
                                                            else
                                                                if state == 17 then
                                                                    r36 = 1
                                                                    r23 = r40[r36]
                                                                    r16 = r23
                                                                    state = 18
                                                                end
                                                            end
                                                        else
                                                            if state <= 18 then
                                                                if state == 18 then
                                                                    upvalueValues[r25] = r16
                                                                    r30 = upvalueValues[r15]
                                                                    r19 = 1
                                                                    r7 = r30 + r19
                                                                    r36 = r40[r7]
                                                                    r23 = r20 + r36
                                                                    r36 = 256
                                                                    state = r23 % r36
                                                                    r20 = state
                                                                    r7 = upvalueValues[r1]
                                                                    r36 = r34 + r7
                                                                    r7 = 256
                                                                    r23 = r36 % r7
                                                                    r34 = r23
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
                                                                    r30 = 2
                                                                    r7 = r40[r30]
                                                                    r30 = upvalueValues[r24]
                                                                    r36 = r7 == r30
                                                                    r16 = r36
                                                                    state = 22
                                                                end
                                                            end
                                                        else
                                                            if state == 22 then
                                                                state = r23
                                                                ReturnVal = r16
                                                                state = 16
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 26 then
                                                        if state <= 24 then
                                                            if state <= 23 then
                                                                if state == 23 then
                                                                    r14 = releaseUpvalue(r14)
                                                                    r1 = releaseUpvalue(r1)
                                                                    r12 = releaseUpvalue(r12)
                                                                    r21 = releaseUpvalue(r21)
                                                                    r15 = releaseUpvalue(r15)
                                                                    r24 = releaseUpvalue(r24)
                                                                    r40 = nil
                                                                    state = 8
                                                                end
                                                            else
                                                                if state == 24 then
                                                                    r38 = releaseUpvalue(r38)
                                                                    r31 = releaseUpvalue(r31)
                                                                    r18 = releaseUpvalue(r18)
                                                                    r22 = releaseUpvalue(r22)
                                                                    r25 = releaseUpvalue(r25)
                                                                    r34 = nil
                                                                    r34 = allocUpvalue()
                                                                    r29 = releaseUpvalue(r29)
                                                                    r26 = releaseUpvalue(r26)
                                                                    r39 = releaseUpvalue(r39)
                                                                    r35 = nil
                                                                    r35 = {}
                                                                    r26 = allocUpvalue()
                                                                    r25 = nil
                                                                    upvalueValues[r26] = r25
                                                                    r25 = allocUpvalue()
                                                                    r22 = nil
                                                                    upvalueValues[r25] = r22
                                                                    r20 = nil
                                                                    r20 = {}
                                                                    r17 = nil
                                                                    r17 = "math"
                                                                    r18 = _env[r17]
                                                                    r17 = "floor"
                                                                    r22 = r18[r17]
                                                                    r18 = allocUpvalue()
                                                                    upvalueValues[r18] = r22
                                                                    r38 = "math"
                                                                    r17 = _env[r38]
                                                                    r38 = "random"
                                                                    r22 = r17[r38]
                                                                    r37 = nil
                                                                    r37 = "table"
                                                                    r38 = _env[r37]
                                                                    r37 = "remove"
                                                                    r17 = r38[r37]
                                                                    r39 = allocUpvalue()
                                                                    r31 = "string"
                                                                    r37 = _env[r31]
                                                                    r31 = "char"
                                                                    r38 = r37[r31]
                                                                    r31 = allocUpvalue()
                                                                    r37 = 0
                                                                    upvalueValues[r31] = r37
                                                                    r37 = 2
                                                                    upvalueValues[r39] = r37
                                                                    r29 = 256
                                                                    r37 = {}
                                                                    upvalueValues[r34] = r20
                                                                    r27 = r29
                                                                    r29 = 1
                                                                    r14 = r29
                                                                    r29 = 0
                                                                    r21 = r14 < r29
                                                                    r32 = nil
                                                                    r32 = 1
                                                                    r29 = r32 - r14
                                                                    r20 = 0
                                                                    state = 26
                                                                end
                                                            end
                                                        else
                                                            if state <= 25 then
                                                                if state == 25 then
                                                                    state = createClosure4(73, {
                                                                        r26
                                                                    })
                                                                    r2 = {
                                                                        state()
                                                                    }
                                                                    ReturnVal = {
                                                                        unpack(r2)
                                                                    }
                                                                    state = nil
                                                                end
                                                            else
                                                                if state == 26 then
                                                                    r1 = not r21
                                                                    r29 = r29 + r14
                                                                    r32 = r29 <= r27
                                                                    r32 = r1 and r32
                                                                    r1 = r29 >= r27
                                                                    r1 = r21 and r1
                                                                    r32 = r1 or r32
                                                                    r1 = 27
                                                                    state = r32 and r1
                                                                    r32 = 28
                                                                    state = state or r32
                                                                end
                                                            end
                                                        end
                                                    else
                                                        if state <= 28 then
                                                            if state <= 27 then
                                                                if state == 27 then
                                                                    r32 = r29
                                                                    r1 = r32
                                                                    r35[r32] = r1
                                                                    r32 = nil
                                                                    state = 26
                                                                end
                                                            else
                                                                if state == 28 then
                                                                    r29 = #r35
                                                                    r27 = 0
                                                                    r32 = r29 == r27
                                                                    state = 29
                                                                end
                                                            end
                                                        else
                                                            if state == 29 then
                                                                r27 = #r35
                                                                r29 = 1
                                                                r32 = r22(r29, r27)
                                                                r29 = r17(r35, r32)
                                                                r27 = upvalueValues[r34]
                                                                r1 = 1
                                                                r21 = r29 - r1
                                                                r14 = r38(r21)
                                                                r27[r29] = r14
                                                                r32 = nil
                                                                r29 = nil
                                                                state = 30
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 43 then
                                                if state <= 36 then
                                                    if state <= 33 then
                                                        if state <= 31 then
                                                            if state <= 30 then
                                                                if state == 30 then
                                                                    r29 = #r35
                                                                    r27 = 0
                                                                    r32 = r29 == r27
                                                                    state = r32 and 31 or 29
                                                                end
                                                            else
                                                                if state == 31 then
                                                                    r32 = {}
                                                                    r29 = allocUpvalue()
                                                                    upvalueValues[r29] = r32
                                                                    r14 = allocUpvalue()
                                                                    r32 = allocUpvalue()
                                                                    r27 = createClosure0(77, {
                                                                        r29,
                                                                        r31,
                                                                        r39,
                                                                        r18
                                                                    })
                                                                    upvalueValues[r32] = r27
                                                                    r27 = {}
                                                                    upvalueValues[r14] = r27
                                                                    r21 = "setmetatable"
                                                                    r27 = _env[r21]
                                                                    r24 = upvalueValues[r14]
                                                                    r1 = {}
                                                                    r40 = "__metatable"
                                                                    r36 = nil
                                                                    r12 = "__index"
                                                                    r15 = {
                                                                        [r12] = r24,
                                                                        [r40] = r36
                                                                    }
                                                                    r21 = r27(r1, r15)
                                                                    r18 = releaseUpvalue(r18)
                                                                    r27 = createClosure6(83, {
                                                                        r14,
                                                                        r29,
                                                                        r34,
                                                                        r31,
                                                                        r39,
                                                                        r32
                                                                    })
                                                                    r31 = releaseUpvalue(r31)
                                                                    r39 = releaseUpvalue(r39)
                                                                    r29 = releaseUpvalue(r29)
                                                                    r14 = releaseUpvalue(r14)
                                                                    r32 = releaseUpvalue(r32)
                                                                    r34 = releaseUpvalue(r34)
                                                                    upvalueValues[r26] = r21
                                                                    upvalueValues[r25] = r27
                                                                    r18 = "getgenv"
                                                                    r22 = nil
                                                                    r22 = _env[r18]
                                                                    r18 = r22()
                                                                    r17 = nil
                                                                    r17 = upvalueValues[r26]
                                                                    r38 = nil
                                                                    r38 = upvalueValues[r25]
                                                                    r39 = 20229026827972
                                                                    r31 = "\162\159\005\224\231vH"
                                                                    r37 = nil
                                                                    r37 = r38(r31, r39)
                                                                    r22 = r17[r37]
                                                                    r37 = upvalueValues[r26]
                                                                    r31 = upvalueValues[r25]
                                                                    r20 = nil
                                                                    r20 = "\151g\n\182"
                                                                    r34 = 7305083100789
                                                                    r39 = r31(r20, r34)
                                                                    r38 = r37[r39]
                                                                    r37 = false
                                                                    r17 = {
                                                                        [r38] = r37
                                                                    }
                                                                    r18[r22] = r17
                                                                    r17 = upvalueValues[r26]
                                                                    r38 = upvalueValues[r25]
                                                                    r31 = "C\174-\133\247"
                                                                    r39 = 34963718814290
                                                                    r37 = r38(r31, r39)
                                                                    r18 = r17[r37]
                                                                    r17 = -1
                                                                    r37 = upvalueValues[r26]
                                                                    r31 = upvalueValues[r25]
                                                                    r34 = 3298573365350
                                                                    r20 = "\179\171wk\021\015\026\185]u\007\004\180\198"
                                                                    r39 = r31(r20, r34)
                                                                    r38 = r37[r39]
                                                                    r39 = upvalueValues[r26]
                                                                    r20 = upvalueValues[r25]
                                                                    r32 = 10816627144714
                                                                    r35 = nil
                                                                    r35 = "B\191\170\n\248\210&8"
                                                                    r34 = r20(r35, r32)
                                                                    r31 = r39[r34]
                                                                    r34 = upvalueValues[r26]
                                                                    r35 = upvalueValues[r25]
                                                                    r29 = "6K\185e\240\"\220T"
                                                                    r27 = 16087025857050
                                                                    r32 = r35(r29, r27)
                                                                    r20 = r34[r32]
                                                                    r32 = upvalueValues[r26]
                                                                    r29 = upvalueValues[r25]
                                                                    r1 = 7668739352155
                                                                    r14 = "\0311\253@\243)iK\008"
                                                                    r27 = r29(r14, r1)
                                                                    r35 = r32[r27]
                                                                    r27 = upvalueValues[r26]
                                                                    r14 = upvalueValues[r25]
                                                                    r15 = "\206\211\149{U\240Ey\196\245\\"
                                                                    r12 = 32133755882447
                                                                    r1 = r14(r15, r12)
                                                                    r29 = r27[r1]
                                                                    r27 = -1
                                                                    r1 = upvalueValues[r26]
                                                                    r15 = upvalueValues[r25]
                                                                    r24 = "\018\r\221$\243\027j1"
                                                                    r40 = 16389169686522
                                                                    r12 = r15(r24, r40)
                                                                    r14 = r1[r12]
                                                                    r37 = true
                                                                    r39 = false
                                                                    r34 = false
                                                                    r32 = false
                                                                    r1 = false
                                                                    r22 = {
                                                                        [r18] = r17,
                                                                        [r38] = r37,
                                                                        [r31] = r39,
                                                                        [r20] = r34,
                                                                        [r35] = r32,
                                                                        [r29] = r27,
                                                                        [r14] = r1
                                                                    }
                                                                    r18 = allocUpvalue()
                                                                    upvalueValues[r18] = r22
                                                                    r22 = {}
                                                                    r17 = {}
                                                                    r38 = allocUpvalue()
                                                                    upvalueValues[r38] = r17
                                                                    r39 = "Enum"
                                                                    r31 = _env[r39]
                                                                    r20 = upvalueValues[r26]
                                                                    r34 = upvalueValues[r25]
                                                                    r29 = 14197650270609
                                                                    r32 = ".\206\006\014\134f\163Z\142"
                                                                    r35 = r34(r32, r29)
                                                                    r39 = r20[r35]
                                                                    r37 = r31[r39]
                                                                    r39 = upvalueValues[r26]
                                                                    r20 = upvalueValues[r25]
                                                                    r32 = 3354354673220
                                                                    r35 = "\192\150\023\168\008"
                                                                    r34 = r20(r35, r32)
                                                                    r31 = r39[r34]
                                                                    r17 = r37[r31]
                                                                    r39 = "Rect"
                                                                    r31 = _env[r39]
                                                                    r20 = upvalueValues[r26]
                                                                    r34 = upvalueValues[r25]
                                                                    r29 = 16713857054150
                                                                    r32 = ">]\191"
                                                                    r35 = r34(r32, r29)
                                                                    r39 = r20[r35]
                                                                    r37 = r31[r39]
                                                                    r35 = 277
                                                                    r34 = 277
                                                                    r20 = 23
                                                                    r39 = 23
                                                                    r31 = r37(r39, r20, r34, r35)
                                                                    r20 = "UDim2"
                                                                    r39 = _env[r20]
                                                                    r34 = upvalueValues[r26]
                                                                    r35 = upvalueValues[r25]
                                                                    r27 = 10970089285794
                                                                    r29 = "\011\150\216\177\157\183Z\"\243"
                                                                    r32 = r35(r29, r27)
                                                                    r20 = r34[r32]
                                                                    r31 = r39[r20]
                                                                    r34 = 1
                                                                    r20 = 1
                                                                    r39 = r31(r20, r34)
                                                                    r34 = "UDim2"
                                                                    r20 = _env[r34]
                                                                    r35 = upvalueValues[r26]
                                                                    r32 = upvalueValues[r25]
                                                                    r14 = 8925388780796
                                                                    r27 = "\155U+\135\236G@?J\192"
                                                                    r29 = r32(r27, r14)
                                                                    r34 = r35[r29]
                                                                    r31 = r20[r34]
                                                                    r35 = 30
                                                                    r34 = 30
                                                                    r20 = r31(r34, r35)
                                                                    r37 = r39 + r20
                                                                    r20 = "UDim2"
                                                                    r39 = _env[r20]
                                                                    r34 = upvalueValues[r26]
                                                                    r35 = upvalueValues[r25]
                                                                    r27 = 34352597651381
                                                                    r29 = "\130C\131gd\2082\021\158j"
                                                                    r32 = r35(r29, r27)
                                                                    r20 = r34[r32]
                                                                    r31 = r39[r20]
                                                                    r34 = -15
                                                                    r20 = -15
                                                                    r39 = r31(r20, r34)
                                                                    r20 = "task"
                                                                    r39 = _env[r20]
                                                                    r34 = upvalueValues[r26]
                                                                    r35 = upvalueValues[r25]
                                                                    r29 = "\187Q\017\156\019"
                                                                    r27 = 14557122724150
                                                                    r32 = r35(r29, r27)
                                                                    r20 = r34[r32]
                                                                    r31 = r39[r20]
                                                                    r20 = createClosure4(90, {
                                                                        r26,
                                                                        r25
                                                                    })
                                                                    r39 = r31(r20)
                                                                    r39 = "game"
                                                                    r31 = _env[r39]
                                                                    r34 = upvalueValues[r26]
                                                                    r35 = upvalueValues[r25]
                                                                    r29 = "\1579R\137\\#n"
                                                                    r27 = 11955616554381
                                                                    r32 = r35(r29, r27)
                                                                    r20 = r34[r32]
                                                                    r39 = "GetService"
                                                                    r39 = r31[r39]
                                                                    r39 = r39(r31, r20)
                                                                    r20 = "game"
                                                                    r31 = _env[r20]
                                                                    r35 = upvalueValues[r26]
                                                                    r20 = "GetService"
                                                                    r20 = r31[r20]
                                                                    r32 = upvalueValues[r25]
                                                                    r14 = 12041957350559
                                                                    r27 = " \227b\254\217\150C"
                                                                    r29 = r32(r27, r14)
                                                                    r34 = r35[r29]
                                                                    r20 = r20(r31, r34)
                                                                    r31 = allocUpvalue()
                                                                    upvalueValues[r31] = r20
                                                                    r34 = "game"
                                                                    r20 = _env[r34]
                                                                    r32 = upvalueValues[r26]
                                                                    r29 = upvalueValues[r25]
                                                                    r1 = 14249554912916
                                                                    r14 = "\227`?\r\\\014\194J)\244\247\153"
                                                                    r27 = r29(r14, r1)
                                                                    r35 = r32[r27]
                                                                    r34 = "GetService"
                                                                    r34 = r20[r34]
                                                                    r34 = r34(r20, r35)
                                                                    r20 = allocUpvalue()
                                                                    upvalueValues[r20] = r34
                                                                    r35 = "game"
                                                                    r34 = _env[r35]
                                                                    r29 = upvalueValues[r26]
                                                                    r27 = upvalueValues[r25]
                                                                    r35 = "GetService"
                                                                    r35 = r34[r35]
                                                                    r15 = 28748617417870
                                                                    r1 = "i\022SU\234\162\174\018\222F\178G\r\222D\008"
                                                                    r14 = r27(r1, r15)
                                                                    r32 = r29[r14]
                                                                    r35 = r35(r34, r32)
                                                                    r34 = allocUpvalue()
                                                                    upvalueValues[r34] = r35
                                                                    r29 = upvalueValues[r26]
                                                                    r27 = upvalueValues[r25]
                                                                    r1 = "k\164I\206C[F_\140FV"
                                                                    r15 = 19615927799171
                                                                    r14 = r27(r1, r15)
                                                                    r32 = r29[r14]
                                                                    r35 = r39[r32]
                                                                    r32 = "GetMouse"
                                                                    r32 = r35[r32]
                                                                    r32 = r32(r35)
                                                                    r35 = allocUpvalue()
                                                                    upvalueValues[r35] = r32
                                                                    r29 = state
                                                                    r1 = "getsynasset"
                                                                    r14 = _env[r1]
                                                                    r27 = not r14
                                                                    state = r27 and 32 or 33
                                                                    r32 = r27
                                                                end
                                                            end
                                                        else
                                                            if state <= 32 then
                                                                if state == 32 then
                                                                    r1 = "getcustomasset"
                                                                    r14 = _env[r1]
                                                                    r27 = not r14
                                                                    r32 = r27
                                                                    state = 33
                                                                end
                                                            else
                                                                if state == 33 then
                                                                    state = r29
                                                                    state = r32 and 34 or 35
                                                                end
                                                            end
                                                        end
                                                    else
                                                        if state <= 35 then
                                                            if state <= 34 then
                                                                if state == 34 then
                                                                    state = 35
                                                                end
                                                            else
                                                                if state == 35 then
                                                                    r27 = "game"
                                                                    r29 = _env[r27]
                                                                    r1 = upvalueValues[r26]
                                                                    r15 = upvalueValues[r25]
                                                                    r24 = "P\215\228\160\1817\202\182\017Zm\137{'\r\2536\172"
                                                                    r40 = 25674968677524
                                                                    r12 = r15(r24, r40)
                                                                    r27 = "GetService"
                                                                    r27 = r29[r27]
                                                                    r14 = r1[r12]
                                                                    r27 = r27(r29, r14)
                                                                    r15 = "game"
                                                                    r1 = _env[r15]
                                                                    r12 = upvalueValues[r26]
                                                                    r24 = upvalueValues[r25]
                                                                    r7 = 3781487783803
                                                                    r36 = "dS0\175\171\204X"
                                                                    r40 = r24(r36, r7)
                                                                    r15 = r12[r40]
                                                                    r29 = "GetProductInfo"
                                                                    r29 = r27[r29]
                                                                    r14 = r1[r15]
                                                                    r29 = r29(r27, r14)
                                                                    r14 = upvalueValues[r26]
                                                                    r1 = upvalueValues[r25]
                                                                    r12 = "\189<4k"
                                                                    r24 = 8715676995334
                                                                    r15 = r1(r12, r24)
                                                                    r27 = r14[r15]
                                                                    r32 = r29[r27]
                                                                    r27 = "syn"
                                                                    r29 = _env[r27]
                                                                    state = r29 and 36 or 37
                                                                end
                                                            end
                                                        else
                                                            if state == 36 then
                                                                r1 = "syn"
                                                                r14 = _env[r1]
                                                                r15 = upvalueValues[r26]
                                                                r12 = upvalueValues[r25]
                                                                r36 = 25255235405963
                                                                r40 = "\252\173>\159;-\252"
                                                                r24 = r12(r40, r36)
                                                                r1 = r15[r24]
                                                                r27 = r14[r1]
                                                                r29 = r27
                                                                state = 37
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 40 then
                                                        if state <= 38 then
                                                            if state <= 37 then
                                                                if state == 37 then
                                                                    r14 = not r29
                                                                    state = r14 and 38 or 39
                                                                end
                                                            else
                                                                if state == 38 then
                                                                    r1 = "http"
                                                                    r14 = _env[r1]
                                                                    state = r14 and 40 or 41
                                                                end
                                                            end
                                                        else
                                                            if state <= 39 then
                                                                if state == 39 then
                                                                    r15 = state
                                                                    r36 = "setclipboard"
                                                                    r40 = _env[r36]
                                                                    r24 = not r40
                                                                    state = r24 and 42 or 43
                                                                    r14 = r24
                                                                end
                                                            else
                                                                if state == 40 then
                                                                    r12 = "http"
                                                                    r15 = _env[r12]
                                                                    r24 = upvalueValues[r26]
                                                                    r40 = upvalueValues[r25]
                                                                    r30 = 11479584590757
                                                                    r7 = "\128\180\1911\012\160\170"
                                                                    r36 = r40(r7, r30)
                                                                    r12 = r24[r36]
                                                                    r1 = r15[r12]
                                                                    r14 = r1
                                                                    state = 41
                                                                end
                                                            end
                                                        end
                                                    else
                                                        if state <= 42 then
                                                            if state <= 41 then
                                                                if state == 41 then
                                                                    r12 = state
                                                                    r24 = not r14
                                                                    state = r24 and 44 or 45
                                                                    r15 = r24
                                                                end
                                                            else
                                                                if state == 42 then
                                                                    r40 = state
                                                                    r30 = "toclipboard"
                                                                    r7 = _env[r30]
                                                                    r36 = not r7
                                                                    state = r36 and 46 or 47
                                                                    r24 = r36
                                                                end
                                                            end
                                                        else
                                                            if state == 43 then
                                                                state = r15
                                                                state = r14 and 48 or 49
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 50 then
                                                    if state <= 47 then
                                                        if state <= 45 then
                                                            if state <= 44 then
                                                                if state == 44 then
                                                                    r36 = "http_request"
                                                                    r40 = _env[r36]
                                                                    r24 = not r40
                                                                    r15 = r24
                                                                    state = 45
                                                                end
                                                            else
                                                                if state == 45 then
                                                                    state = r12
                                                                    state = r15 and 50 or 51
                                                                end
                                                            end
                                                        else
                                                            if state <= 46 then
                                                                if state == 46 then
                                                                    r7 = state
                                                                    r3 = "set_clipboard"
                                                                    r19 = _env[r3]
                                                                    r30 = not r19
                                                                    state = r30 and 52 or 53
                                                                    r36 = r30
                                                                end
                                                            else
                                                                if state == 47 then
                                                                    state = r40
                                                                    r14 = r24
                                                                    state = 43
                                                                end
                                                            end
                                                        end
                                                    else
                                                        if state <= 49 then
                                                            if state <= 48 then
                                                                if state == 48 then
                                                                    r24 = "Clipboard"
                                                                    r15 = _env[r24]
                                                                    r40 = upvalueValues[r26]
                                                                    r36 = upvalueValues[r25]
                                                                    r30 = "h|\234"
                                                                    r19 = 11957320361117
                                                                    r7 = r36(r30, r19)
                                                                    r24 = r40[r7]
                                                                    r14 = r15[r24]
                                                                    r14 = nil
                                                                    state = 49
                                                                end
                                                            else
                                                                if state == 49 then
                                                                    r15 = upvalueValues[r38]
                                                                    r14 = createClosure0(95, {
                                                                        r26,
                                                                        r25
                                                                    })
                                                                    r24 = "generateUUID"
                                                                    r15[r24] = r14
                                                                    r14 = createClosure4(96, {
                                                                        r26,
                                                                        r25,
                                                                        r31,
                                                                        r38
                                                                    })
                                                                    r15 = upvalueValues[r38]
                                                                    r24 = "protected"
                                                                    r15[r24] = r14
                                                                    r15 = upvalueValues[r38]
                                                                    r14 = createClosure(97, {
                                                                        r20,
                                                                        r26,
                                                                        r25
                                                                    })
                                                                    r24 = "tween"
                                                                    r15[r24] = r14
                                                                    r15 = upvalueValues[r38]
                                                                    r14 = createClosure5(98, {
                                                                        r26,
                                                                        r25
                                                                    })
                                                                    r24 = "stroke"
                                                                    r15[r24] = r14
                                                                    r31 = releaseUpvalue(r31)
                                                                    r14 = createClosure1(99, {
                                                                        r34,
                                                                        r26,
                                                                        r25
                                                                    })
                                                                    r15 = upvalueValues[r38]
                                                                    r24 = "device"
                                                                    r15[r24] = r14
                                                                    r15 = upvalueValues[r38]
                                                                    r14 = createClosure4(100, {
                                                                        r26,
                                                                        r25
                                                                    })
                                                                    r24 = "format_timer"
                                                                    r15[r24] = r14
                                                                    r15 = upvalueValues[r38]
                                                                    r14 = createClosure2(101, {
                                                                        r26,
                                                                        r25,
                                                                        r35
                                                                    })
                                                                    r24 = "getXY"
                                                                    r15[r24] = r14
                                                                    r15 = upvalueValues[r38]
                                                                    r14 = createClosure4(102, {
                                                                        r38,
                                                                        r26,
                                                                        r25
                                                                    })
                                                                    r24 = "animatedcircle"
                                                                    r15[r24] = r14
                                                                    r15 = upvalueValues[r38]
                                                                    r14 = createClosure4(105, {
                                                                        r26,
                                                                        r25
                                                                    })
                                                                    r24 = "color_to_byte"
                                                                    r15[r24] = r14
                                                                    r15 = upvalueValues[r38]
                                                                    r14 = createClosure3(106, {
                                                                        r26,
                                                                        r25,
                                                                        r35
                                                                    })
                                                                    r24 = "checkmouse_ingui"
                                                                    r15[r24] = r14
                                                                    r14 = createClosure7(115, {
                                                                        r26,
                                                                        r25
                                                                    })
                                                                    r15 = upvalueValues[r38]
                                                                    ReturnVal = {}
                                                                    r24 = "create_corner"
                                                                    r15[r24] = r14
                                                                    r14 = createClosure3(118, {
                                                                        r38,
                                                                        r26,
                                                                        r25,
                                                                        r18,
                                                                        r34
                                                                    })
                                                                    r15 = "create"
                                                                    r22[r15] = r14
                                                                    r24 = upvalueValues[r26]
                                                                    r35 = releaseUpvalue(r35)
                                                                    r40 = upvalueValues[r25]
                                                                    r30 = 22528536706043
                                                                    r7 = "\252\216F\171X\191"
                                                                    r36 = r40(r7, r30)
                                                                    r20 = releaseUpvalue(r20)
                                                                    r15 = r24[r36]
                                                                    r14 = r22[r15]
                                                                    r15 = r14()
                                                                    r40 = upvalueValues[r26]
                                                                    r36 = upvalueValues[r25]
                                                                    r19 = 911991162139
                                                                    r30 = "\239;\244\012\163\217"
                                                                    r7 = r36(r30, r19)
                                                                    r24 = r40[r7]
                                                                    r18 = releaseUpvalue(r18)
                                                                    r14 = r15[r24]
                                                                    r24 = r14()
                                                                    r36 = upvalueValues[r26]
                                                                    r7 = upvalueValues[r25]
                                                                    r3 = 13889144331933
                                                                    r19 = "s\194\149\127v\170"
                                                                    r30 = r7(r19, r3)
                                                                    r40 = r36[r30]
                                                                    r14 = r15[r40]
                                                                    r40 = r14()
                                                                    r36 = upvalueValues[r26]
                                                                    r7 = upvalueValues[r25]
                                                                    r19 = "\194\170H\1323\021"
                                                                    r3 = 20165561242821
                                                                    r30 = r7(r19, r3)
                                                                    r40 = r36[r30]
                                                                    r14 = r24[r40]
                                                                    r30 = upvalueValues[r26]
                                                                    r19 = upvalueValues[r25]
                                                                    r38 = releaseUpvalue(r38)
                                                                    r9 = "!I =\143"
                                                                    r10 = 13617239285590
                                                                    r3 = r19(r9, r10)
                                                                    r7 = r30[r3]
                                                                    r19 = upvalueValues[r26]
                                                                    r3 = upvalueValues[r25]
                                                                    r13 = 6706377437493
                                                                    r10 = "\244\008\154\159.\249\127x\241"
                                                                    r9 = r3(r10, r13)
                                                                    r30 = r19[r9]
                                                                    r3 = upvalueValues[r26]
                                                                    r9 = upvalueValues[r25]
                                                                    r4 = 19194461414495
                                                                    r13 = "N\152\193\200\139\n\185"
                                                                    r10 = r9(r13, r4)
                                                                    r19 = r3[r10]
                                                                    r10 = upvalueValues[r26]
                                                                    r13 = upvalueValues[r25]
                                                                    r6 = "To\128\184\244]\151\029"
                                                                    r28 = 10137673936733
                                                                    r4 = r13(r6, r28)
                                                                    r9 = r10[r4]
                                                                    r10 = createClosure2(131, {})
                                                                    r3 = false
                                                                    r36 = {
                                                                        [r7] = r30,
                                                                        [r19] = r3,
                                                                        [r9] = r10
                                                                    }
                                                                    r7 = false
                                                                    r40 = r14(r36, r7)
                                                                    r36 = upvalueValues[r26]
                                                                    r7 = upvalueValues[r25]
                                                                    r3 = 4282785375022
                                                                    r19 = "\026\016\0171\220<"
                                                                    r30 = r7(r19, r3)
                                                                    r40 = r36[r30]
                                                                    r14 = r24[r40]
                                                                    r30 = upvalueValues[r26]
                                                                    r19 = upvalueValues[r25]
                                                                    r10 = 20566455229492
                                                                    r9 = "\169\177C\193`"
                                                                    r3 = r19(r9, r10)
                                                                    r7 = r30[r3]
                                                                    r34 = releaseUpvalue(r34)
                                                                    r19 = upvalueValues[r26]
                                                                    r3 = upvalueValues[r25]
                                                                    r13 = 25755403149885
                                                                    r10 = "\132\169\016\015s\143o\229\146"
                                                                    r9 = r3(r10, r13)
                                                                    r30 = r19[r9]
                                                                    r3 = upvalueValues[r26]
                                                                    r9 = upvalueValues[r25]
                                                                    r4 = 10396434271618
                                                                    r13 = "w\171\028\181\146\131\233"
                                                                    r10 = r9(r13, r4)
                                                                    r19 = r3[r10]
                                                                    r10 = upvalueValues[r26]
                                                                    r13 = upvalueValues[r25]
                                                                    r6 = "$S\173:\161\151pn"
                                                                    r28 = 34091892141891
                                                                    r4 = r13(r6, r28)
                                                                    r9 = r10[r4]
                                                                    r10 = createClosure1(132, {})
                                                                    r3 = false
                                                                    r36 = {
                                                                        [r7] = r30,
                                                                        [r19] = r3,
                                                                        [r9] = r10
                                                                    }
                                                                    r7 = false
                                                                    r40 = r14(r36, r7)
                                                                    r40 = "getgenv"
                                                                    r14 = _env[r40]
                                                                    r40 = r14()
                                                                    r36 = upvalueValues[r26]
                                                                    r7 = upvalueValues[r25]
                                                                    r3 = 32665395324350
                                                                    r19 = ":\163\239\1811\177"
                                                                    r30 = r7(r19, r3)
                                                                    r14 = r36[r30]
                                                                    r25 = releaseUpvalue(r25)
                                                                    r26 = releaseUpvalue(r26)
                                                                    r36 = true
                                                                    r40[r14] = r36
                                                                    r32 = nil
                                                                    r37 = nil
                                                                    r29 = nil
                                                                    r39 = nil
                                                                    r15 = nil
                                                                    r22 = nil
                                                                    r24 = nil
                                                                    r17 = nil
                                                                    state = nil
                                                                end
                                                            end
                                                        else
                                                            if state == 50 then
                                                                r12 = "fluxus"
                                                                r15 = _env[r12]
                                                                state = r15 and 54 or 55
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 54 then
                                                        if state <= 52 then
                                                            if state <= 51 then
                                                                if state == 51 then
                                                                    r14 = nil
                                                                    state = 39
                                                                end
                                                            else
                                                                if state == 52 then
                                                                    r19 = "Clipboard"
                                                                    r30 = _env[r19]
                                                                    r36 = r30
                                                                    state = 53
                                                                end
                                                            end
                                                        else
                                                            if state <= 53 then
                                                                if state == 53 then
                                                                    state = r7
                                                                    r24 = r36
                                                                    state = 47
                                                                end
                                                            else
                                                                if state == 54 then
                                                                    r40 = "fluxus"
                                                                    r24 = _env[r40]
                                                                    r36 = upvalueValues[r26]
                                                                    r7 = upvalueValues[r25]
                                                                    r3 = 18833292107263
                                                                    r19 = "\177\155\207\223\002 \003"
                                                                    r30 = r7(r19, r3)
                                                                    r40 = r36[r30]
                                                                    r12 = r24[r40]
                                                                    r15 = r12
                                                                    state = 55
                                                                end
                                                            end
                                                        end
                                                    else
                                                        if state <= 56 then
                                                            if state <= 55 then
                                                                if state == 55 then
                                                                    r24 = not r15
                                                                    state = r24 and 56 or 57
                                                                end
                                                            else
                                                                if state == 56 then
                                                                    r40 = "request"
                                                                    r24 = _env[r40]
                                                                    r24 = nil
                                                                    state = 57
                                                                end
                                                            end
                                                        else
                                                            if state == 57 then
                                                                r15 = nil
                                                                state = 51
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure4 entry 10433652 -> 58, states 58-58
                                        if state == 58 then -- entry 10433652 -> 58
                                            state = true
                                            upvalueValues[upvalues[1]] = state
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure5 entry 5979599 -> 59, states 59-59
                                    if state == 59 then -- entry 5979599 -> 59
                                        ReturnVal = "error"
                                        state = _env[ReturnVal]
                                        r11 = "Tamper Detected!"
                                        ReturnVal = state(r11)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                if state <= 72 then
                                    if state <= 60 then
                                        -- createClosure0 entry 3920375 -> 60, states 60-60
                                        if state == 60 then -- entry 3920375 -> 60
                                            r22 = 14553271
                                            r25 = "2K6jav0TTuREq"
                                            r11 = r25 ^ r22
                                            ReturnVal = 11042981
                                            state = ReturnVal - r11
                                            r11 = state
                                            ReturnVal = "f2Vg"
                                            state = ReturnVal / r11
                                            ReturnVal = {
                                                state
                                            }
                                            state = nil
                                        end
                                    else
                                        -- createClosure4 entry 3927532 -> 61, states 61-72
                                        if state <= 66 then
                                            if state <= 63 then
                                                if state <= 62 then
                                                    if state <= 61 then
                                                        if state == 61 then -- entry 3927532 -> 61
                                                            r25 = upvalueValues[upvalues[1]]
                                                            r26 = 1
                                                            r18 = 2
                                                            r22 = r25(r26, r18)
                                                            r25 = 1
                                                            r11 = r22 == r25
                                                            state = r11 and 62 or 63
                                                            ReturnVal = r11
                                                        end
                                                    else
                                                        if state == 62 then
                                                            state = ReturnVal and 64 or 65
                                                        end
                                                    end
                                                else
                                                    if state == 63 then
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r22 = upvalueValues[upvalues[3]]
                                                        r11 = r25 == r22
                                                        ReturnVal = r11
                                                        state = 62
                                                    end
                                                end
                                            else
                                                if state <= 65 then
                                                    if state <= 64 then
                                                        if state == 64 then
                                                            r31 = createClosure5(133, {})
                                                            ReturnVal = "tonumber"
                                                            state = _env[ReturnVal]
                                                            r11 = upvalueValues[upvalues[4]]
                                                            r26 = "tostring"
                                                            r22 = _env[r26]
                                                            r37 = "pcall"
                                                            r38 = _env[r37]
                                                            r37 = {
                                                                r38(r31)
                                                            }
                                                            r17 = {
                                                                unpack(r37)
                                                            }
                                                            r38 = 2
                                                            r18 = r17[r38]
                                                            r26 = r22(r18)
                                                            r22 = ":(%d*):"
                                                            r25 = r11(r26, r22)
                                                            r11 = {
                                                                r25()
                                                            }
                                                            ReturnVal = state(unpack(r11))
                                                            r11 = ReturnVal
                                                            r25 = upvalueValues[upvalues[5]]
                                                            state = r25 and 66 or 67
                                                            ReturnVal = r25
                                                        end
                                                    else
                                                        if state == 65 then
                                                            state = upvalueValues[upvalues[7]]
                                                            state = state and 68 or 69
                                                        end
                                                    end
                                                else
                                                    if state == 66 then
                                                        r22 = upvalueValues[upvalues[6]]
                                                        r25 = r22 == r11
                                                        ReturnVal = r25
                                                        state = 67
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 69 then
                                                if state <= 68 then
                                                    if state <= 67 then
                                                        if state == 67 then
                                                            upvalueValues[upvalues[5]] = ReturnVal
                                                            r11 = nil
                                                            state = 65
                                                        end
                                                    else
                                                        if state == 68 then
                                                            r11 = "error"
                                                            state = _env[r11]
                                                            r25 = upvalueValues[upvalues[8]]
                                                            r22 = 0
                                                            r11 = state(r25, r22)
                                                            state = 69
                                                        end
                                                    end
                                                else
                                                    if state == 69 then
                                                        r22 = upvalueValues[upvalues[9]]
                                                        r26 = r22
                                                        state = {}
                                                        r11 = state
                                                        r22 = 1
                                                        r18 = r22
                                                        r22 = 0
                                                        r17 = r18 < r22
                                                        r25 = 1
                                                        r22 = r25 - r18
                                                        state = 70
                                                    end
                                                end
                                            else
                                                if state <= 71 then
                                                    if state <= 70 then
                                                        if state == 70 then
                                                            r22 = r22 + r18
                                                            r25 = r22 <= r26
                                                            r38 = not r17
                                                            r25 = r38 and r25
                                                            r38 = r22 >= r26
                                                            r38 = r17 and r38
                                                            r25 = r38 or r25
                                                            r38 = 71
                                                            state = r25 and r38
                                                            r25 = 72
                                                            state = state or r25
                                                        end
                                                    else
                                                        if state == 71 then
                                                            state = upvalueValues[upvalues[1]]
                                                            r31 = 255
                                                            r37 = 0
                                                            r38 = state(r37, r31)
                                                            r25 = r22
                                                            r11[r25] = r38
                                                            r25 = nil
                                                            state = 70
                                                        end
                                                    end
                                                else
                                                    if state == 72 then
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
                                    end
                                else
                                    -- createClosure4 entry 12599675 -> 73, states 73-76
                                    if state <= 74 then
                                        if state <= 73 then
                                            if state == 73 then -- entry 12599675 -> 73
                                                state = 74
                                            end
                                        else
                                            if state == 74 then
                                                state = true
                                                state = state and 75 or 76
                                            end
                                        end
                                    else
                                        if state <= 75 then
                                            if state == 75 then
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
                                                state = 74
                                            end
                                        else
                                            if state == 76 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 94 then
                                if state <= 89 then
                                    if state <= 82 then
                                        -- createClosure0 entry 4639261 -> 77, states 77-82
                                        if state <= 79 then
                                            if state <= 78 then
                                                if state <= 77 then
                                                    if state == 77 then -- entry 4639261 -> 77
                                                        r11 = upvalueValues[upvalues[1]]
                                                        ReturnVal = #r11
                                                        r11 = 0
                                                        state = ReturnVal == r11
                                                        state = state and 78 or 79
                                                    end
                                                else
                                                    if state == 78 then
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r22 = 1
                                                        r11 = r25 * r22
                                                        r25 = 34468506574257
                                                        ReturnVal = r11 + r25
                                                        r11 = 35184372088832
                                                        state = ReturnVal % r11
                                                        upvalueValues[upvalues[2]] = state
                                                        r11 = upvalueValues[upvalues[3]]
                                                        r25 = 1
                                                        ReturnVal = r11 ~= r25
                                                        state = 80
                                                    end
                                                end
                                            else
                                                if state == 79 then
                                                    r22 = "table"
                                                    r25 = _env[r22]
                                                    r22 = "remove"
                                                    r11 = r25[r22]
                                                    r22 = upvalueValues[upvalues[1]]
                                                    r25 = {
                                                        r11(r22)
                                                    }
                                                    ReturnVal = {
                                                        unpack(r25)
                                                    }
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state <= 81 then
                                                if state <= 80 then
                                                    if state == 80 then
                                                        r25 = upvalueValues[upvalues[3]]
                                                        r22 = 161
                                                        r11 = r25 * r22
                                                        r25 = 257
                                                        ReturnVal = r11 % r25
                                                        upvalueValues[upvalues[3]] = ReturnVal
                                                        state = 81
                                                    end
                                                else
                                                    if state == 81 then
                                                        r25 = upvalueValues[upvalues[3]]
                                                        r22 = 1
                                                        r11 = r25 ~= r22
                                                        state = r11 and 82 or 80
                                                    end
                                                end
                                            else
                                                if state == 82 then
                                                    r25 = upvalueValues[upvalues[3]]
                                                    r22 = 32
                                                    r11 = r25 % r22
                                                    r26 = upvalueValues[upvalues[4]]
                                                    r38 = upvalueValues[upvalues[2]]
                                                    r32 = upvalueValues[upvalues[3]]
                                                    r35 = r32 - r11
                                                    r32 = 32
                                                    r34 = r35 / r32
                                                    r20 = 13
                                                    r39 = r20 - r34
                                                    r31 = 2
                                                    r37 = r31 ^ r39
                                                    r17 = r38 / r37
                                                    r18 = r26(r17)
                                                    r26 = 4294967296
                                                    r22 = r18 % r26
                                                    r18 = 2
                                                    r26 = r18 ^ r11
                                                    r25 = r22 / r26
                                                    r26 = upvalueValues[upvalues[4]]
                                                    r37 = 1
                                                    r38 = r25 % r37
                                                    r37 = 4294967296
                                                    r17 = r38 * r37
                                                    r18 = r26(r17)
                                                    r26 = upvalueValues[upvalues[4]]
                                                    r17 = r26(r25)
                                                    r22 = r18 + r17
                                                    r18 = 65536
                                                    r26 = r22 % r18
                                                    r17 = r22 - r26
                                                    r38 = 65536
                                                    r18 = r17 / r38
                                                    r38 = 256
                                                    r17 = r26 % r38
                                                    r37 = r26 - r17
                                                    r31 = 256
                                                    r38 = r37 / r31
                                                    r31 = 256
                                                    r37 = r18 % r31
                                                    r39 = r18 - r37
                                                    r20 = 256
                                                    r31 = r39 / r20
                                                    r39 = {
                                                        r17,
                                                        r38,
                                                        r37,
                                                        r31
                                                    }
                                                    upvalueValues[upvalues[1]] = r39
                                                    r38 = nil
                                                    r25 = nil
                                                    r22 = nil
                                                    r11 = nil
                                                    r26 = nil
                                                    r18 = nil
                                                    r31 = nil
                                                    r17 = nil
                                                    r37 = nil
                                                    state = 79
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure6 entry 5926769 -> 83, states 83-89
                                        if state <= 86 then
                                            if state <= 84 then
                                                if state <= 83 then
                                                    if state == 83 then -- entry 5926769 -> 83
                                                        state = upvalueValues[upvalues[1]]
                                                        r22 = state
                                                        r11 = args[1]
                                                        r25 = args[2]
                                                        state = r22[r25]
                                                        state = state and 84 or 85
                                                    end
                                                else
                                                    if state == 84 then
                                                        state = 86
                                                    end
                                                end
                                            else
                                                if state <= 85 then
                                                    if state == 85 then
                                                        state = {}
                                                        upvalueValues[upvalues[2]] = state
                                                        ReturnVal = upvalueValues[upvalues[3]]
                                                        r26 = ReturnVal
                                                        r18 = 35184372088832
                                                        ReturnVal = r25 % r18
                                                        upvalueValues[upvalues[4]] = ReturnVal
                                                        r38 = 255
                                                        r17 = r25 % r38
                                                        r38 = 2
                                                        r18 = r17 + r38
                                                        upvalueValues[upvalues[5]] = r18
                                                        r37 = "string"
                                                        r38 = _env[r37]
                                                        r37 = "len"
                                                        r17 = r38[r37]
                                                        r38 = r17(r11)
                                                        r17 = ""
                                                        r22[r25] = r17
                                                        r39 = 1
                                                        r20 = r39
                                                        r39 = 0
                                                        r34 = r20 < r39
                                                        r37 = 1
                                                        r39 = r37 - r20
                                                        r31 = r38
                                                        r17 = 94
                                                        state = 87
                                                    end
                                                else
                                                    if state == 86 then
                                                        ReturnVal = {
                                                            r25
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 88 then
                                                if state <= 87 then
                                                    if state == 87 then
                                                        r39 = r39 + r20
                                                        r37 = r39 <= r31
                                                        r35 = not r34
                                                        r37 = r35 and r37
                                                        r35 = r39 >= r31
                                                        r35 = r34 and r35
                                                        r37 = r35 or r37
                                                        r35 = 88
                                                        state = r37 and r35
                                                        r37 = 89
                                                        state = state or r37
                                                    end
                                                else
                                                    if state == 88 then
                                                        r37 = r39
                                                        r5 = "string"
                                                        r2 = _env[r5]
                                                        r5 = "byte"
                                                        r33 = r2[r5]
                                                        r2 = r33(r11, r37)
                                                        r33 = upvalueValues[upvalues[6]]
                                                        r5 = r33()
                                                        r29 = r2 + r5
                                                        r32 = r29 + r17
                                                        r29 = 256
                                                        r35 = r32 % r29
                                                        r17 = r35
                                                        r29 = r22[r25]
                                                        r5 = 1
                                                        r2 = r17 + r5
                                                        r33 = r26[r2]
                                                        r32 = r29 .. r33
                                                        r22[r25] = r32
                                                        r37 = nil
                                                        state = 87
                                                    end
                                                end
                                            else
                                                if state == 89 then
                                                    r17 = nil
                                                    r26 = nil
                                                    r38 = nil
                                                    state = 86
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure4 entry 14625723 -> 90, states 90-94
                                    if state <= 92 then
                                        if state <= 91 then
                                            if state <= 90 then
                                                if state == 90 then -- entry 14625723 -> 90
                                                    r11 = "isfolder"
                                                    ReturnVal = _env[r11]
                                                    r22 = upvalueValues[upvalues[1]]
                                                    r26 = upvalueValues[upvalues[2]]
                                                    r38 = 25772869816454
                                                    r17 = "\147\129DB_7'\220#|\206f\008x"
                                                    r18 = r26(r17, r38)
                                                    r25 = r22[r18]
                                                    r11 = ReturnVal(r25)
                                                    state = not r11
                                                    state = state and 91 or 92
                                                end
                                            else
                                                if state == 91 then
                                                    ReturnVal = "makefolder"
                                                    state = _env[ReturnVal]
                                                    r25 = upvalueValues[upvalues[1]]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r18 = "\1521\2523L3\192h\203\153Bctl"
                                                    r17 = 27514066817637
                                                    r26 = r22(r18, r17)
                                                    r11 = r25[r26]
                                                    ReturnVal = state(r11)
                                                    state = 92
                                                end
                                            end
                                        else
                                            if state == 92 then
                                                r11 = "isfolder"
                                                ReturnVal = _env[r11]
                                                r26 = upvalueValues[upvalues[1]]
                                                r18 = upvalueValues[upvalues[2]]
                                                r38 = "\202\023\201[\1602\255\151\144\191N<x\204\019"
                                                r37 = 20769510658474
                                                r17 = r18(r38, r37)
                                                r22 = r26[r17]
                                                r17 = "game"
                                                r18 = _env[r17]
                                                r38 = upvalueValues[upvalues[1]]
                                                r37 = upvalueValues[upvalues[2]]
                                                r20 = 14722425173991
                                                r39 = "\000\218\242L\223}"
                                                r31 = r37(r39, r20)
                                                r17 = r38[r31]
                                                r26 = r18[r17]
                                                r25 = r22 .. r26
                                                r11 = ReturnVal(r25)
                                                state = not r11
                                                state = state and 93 or 94
                                            end
                                        end
                                    else
                                        if state <= 93 then
                                            if state == 93 then
                                                ReturnVal = "makefolder"
                                                state = _env[ReturnVal]
                                                r22 = upvalueValues[upvalues[1]]
                                                r26 = upvalueValues[upvalues[2]]
                                                r38 = 701669972054
                                                r17 = "\127\186\232\245\004\190\166\001\005<\159L\231Z!"
                                                r18 = r26(r17, r38)
                                                r25 = r22[r18]
                                                r18 = "game"
                                                r26 = _env[r18]
                                                r17 = upvalueValues[upvalues[1]]
                                                r38 = upvalueValues[upvalues[2]]
                                                r39 = 27234279616821
                                                r31 = "P\204\240\188\165\159"
                                                r37 = r38(r31, r39)
                                                r18 = r17[r37]
                                                r22 = r26[r18]
                                                r11 = r25 .. r22
                                                ReturnVal = state(r11)
                                                state = 94
                                            end
                                        else
                                            if state == 94 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 96 then
                                    if state <= 95 then
                                        -- createClosure0 entry 4566822 -> 95, states 95-95
                                        if state == 95 then -- entry 4566822 -> 95
                                            r11 = "string"
                                            ReturnVal = _env[r11]
                                            r25 = upvalueValues[upvalues[1]]
                                            r22 = upvalueValues[upvalues[2]]
                                            r18 = "\217\206\221\209"
                                            r17 = 29717569936147
                                            r26 = r22(r18, r17)
                                            r11 = r25[r26]
                                            state = ReturnVal[r11]
                                            r25 = upvalueValues[upvalues[1]]
                                            r22 = upvalueValues[upvalues[2]]
                                            r17 = 31184623154820
                                            r18 = "'X\148\226\184\135yOp\158\192\129\248\246\206\130\213\147F\243\212E\166\152X\128\127\223\229\\\217\171j\244\251\191"
                                            r26 = r22(r18, r17)
                                            r11 = r25[r26]
                                            r22 = upvalueValues[upvalues[1]]
                                            r26 = upvalueValues[upvalues[2]]
                                            r38 = 1203852421000
                                            r17 = "\140\127\184\164"
                                            r18 = r26(r17, r38)
                                            r25 = r22[r18]
                                            r22 = createClosure5(134, {
                                                upvalues[1],
                                                upvalues[2]
                                            })
                                            ReturnVal = {
                                                state(r11, r25, r22)
                                            }
                                            ReturnVal = {
                                                unpack(ReturnVal)
                                            }
                                            state = nil
                                        end
                                    else
                                        -- createClosure4 entry 10854128 -> 96, states 96-96
                                        if state == 96 then -- entry 10854128 -> 96
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r25 = upvalueValues[upvalues[2]]
                                            r18 = 1397336555896
                                            r26 = "\157\166\162dLG"
                                            r22 = r25(r26, r18)
                                            r11 = args[1]
                                            state = ReturnVal[r22]
                                            ReturnVal = upvalueValues[upvalues[3]]
                                            r11[state] = ReturnVal
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r25 = upvalueValues[upvalues[2]]
                                            r26 = "\230\167\246I"
                                            r18 = 1495273330276
                                            r22 = r25(r26, r18)
                                            state = ReturnVal[r22]
                                            r25 = upvalueValues[upvalues[4]]
                                            r26 = upvalueValues[upvalues[1]]
                                            r18 = upvalueValues[upvalues[2]]
                                            r38 = "H\250\217*u\150V\212\144\250\197\212"
                                            r37 = 15394857904212
                                            r17 = r18(r38, r37)
                                            r22 = r26[r17]
                                            ReturnVal = r25[r22]
                                            r25 = ReturnVal()
                                            r11[state] = r25
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r25 = upvalueValues[upvalues[2]]
                                            r18 = 15371530017586
                                            r26 = "\153\188D[\022\211\179j\182r$\018"
                                            r22 = r25(r26, r18)
                                            state = ReturnVal[r22]
                                            ReturnVal = 999
                                            r11[state] = ReturnVal
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r25 = upvalueValues[upvalues[2]]
                                            r18 = 16361089258754
                                            r26 = "\206W\177\001\254\243\028*{y\187T\172\196"
                                            r22 = r25(r26, r18)
                                            state = ReturnVal[r22]
                                            ReturnVal = true
                                            r11[state] = ReturnVal
                                            r25 = upvalueValues[upvalues[1]]
                                            r22 = upvalueValues[upvalues[2]]
                                            r17 = 21470645877549
                                            r18 = "\173\196\178\132\133\139\185$m"
                                            r26 = r22(r18, r17)
                                            state = "SetAttribute"
                                            ReturnVal = r25[r26]
                                            r22 = "tostring"
                                            r25 = _env[r22]
                                            r18 = upvalueValues[upvalues[4]]
                                            r38 = upvalueValues[upvalues[1]]
                                            r37 = upvalueValues[upvalues[2]]
                                            r39 = "\024\203\143;\191\155\003\233?q>\229"
                                            r20 = 4541556331260
                                            r31 = r37(r39, r20)
                                            r17 = r38[r31]
                                            state = r11[state]
                                            r26 = r18[r17]
                                            r18 = {
                                                r26()
                                            }
                                            r22 = {
                                                r25(unpack(r18))
                                            }
                                            state = state(r11, ReturnVal, unpack(r22))
                                            r25 = upvalueValues[upvalues[1]]
                                            state = "SetAttribute"
                                            r22 = upvalueValues[upvalues[2]]
                                            r17 = 31749970439185
                                            r18 = "\212\229\r>Ax\014"
                                            r26 = r22(r18, r17)
                                            ReturnVal = r25[r26]
                                            state = r11[state]
                                            r25 = true
                                            state = state(r11, ReturnVal, r25)
                                            r11 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure entry 7527746 -> 97, states 97-97
                                    if state == 97 then -- entry 7527746 -> 97
                                        state = upvalueValues[upvalues[1]]
                                        r26 = {
                                            select(4, unpack(args))
                                        }
                                        r25 = args[2]
                                        r11 = args[1]
                                        r22 = args[3]
                                        r38 = "TweenInfo"
                                        r17 = _env[r38]
                                        r37 = upvalueValues[upvalues[2]]
                                        r31 = upvalueValues[upvalues[3]]
                                        r20 = "Di\""
                                        r34 = 23363729394657
                                        r39 = r31(r20, r34)
                                        r38 = r37[r39]
                                        r18 = r17[r38]
                                        ReturnVal = "Create"
                                        ReturnVal = state[ReturnVal]
                                        r17 = r18(r25, r22)
                                        ReturnVal = ReturnVal(state, r11, r17, unpack(r26))
                                        state = "Play"
                                        state = ReturnVal[state]
                                        state = state(ReturnVal)
                                        r25 = nil
                                        r22 = nil
                                        r11 = nil
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        end
                    else
                        if state <= 105 then
                            if state <= 100 then
                                if state <= 99 then
                                    if state <= 98 then
                                        -- createClosure5 entry 2433539 -> 98, states 98-98
                                        if state == 98 then -- entry 2433539 -> 98
                                            r11 = args[1]
                                            r25 = args[2]
                                            r26 = args[4]
                                            r22 = args[3]
                                            r18 = "Instance"
                                            ReturnVal = _env[r18]
                                            r17 = upvalueValues[upvalues[1]]
                                            r38 = upvalueValues[upvalues[2]]
                                            r31 = "\233\147\021"
                                            r39 = 4185920248810
                                            r37 = r38(r31, r39)
                                            r18 = r17[r37]
                                            state = ReturnVal[r18]
                                            r17 = upvalueValues[upvalues[1]]
                                            r38 = upvalueValues[upvalues[2]]
                                            r39 = 12994474621138
                                            r31 = "\230\199u\182\1812(\217"
                                            r37 = r38(r31, r39)
                                            r18 = r17[r37]
                                            ReturnVal = state(r18, r11)
                                            r18 = ReturnVal
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r17 = upvalueValues[upvalues[2]]
                                            r31 = 24037987882699
                                            r37 = "I\249\174\153\234(&i\017"
                                            r38 = r17(r37, r31)
                                            state = ReturnVal[r38]
                                            ReturnVal = r22
                                            r18[state] = ReturnVal
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r17 = upvalueValues[upvalues[2]]
                                            r31 = 11218894979817
                                            r37 = "C\141\191A\024\165\030\148C\248\023\001"
                                            r38 = r17(r37, r31)
                                            state = ReturnVal[r38]
                                            r37 = "Enum"
                                            r38 = _env[r37]
                                            r31 = upvalueValues[upvalues[1]]
                                            r39 = upvalueValues[upvalues[2]]
                                            r35 = 30795494475376
                                            r34 = ";\238\154\137\216\127\181\129P\238\217\202"
                                            r20 = r39(r34, r35)
                                            r37 = r31[r20]
                                            r17 = r38[r37]
                                            r37 = upvalueValues[upvalues[1]]
                                            r31 = upvalueValues[upvalues[2]]
                                            r34 = 14319583677848
                                            r20 = ";\1386;4"
                                            r39 = r31(r20, r34)
                                            r38 = r37[r39]
                                            ReturnVal = r17[r38]
                                            r18[state] = ReturnVal
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r17 = upvalueValues[upvalues[2]]
                                            r31 = 3054602075303
                                            r37 = "\0026u\226\175"
                                            r38 = r17(r37, r31)
                                            state = ReturnVal[r38]
                                            ReturnVal = r26
                                            r18[state] = ReturnVal
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r17 = upvalueValues[upvalues[2]]
                                            r37 = "\248\201\"\160\201\191/\238[U\206\167"
                                            r31 = 28578219611210
                                            r38 = r17(r37, r31)
                                            state = ReturnVal[r38]
                                            ReturnVal = r25
                                            r18[state] = ReturnVal
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r17 = upvalueValues[upvalues[2]]
                                            r31 = 16850357082299
                                            r37 = "1\197s\"\246$7\166\163>yEWl\195"
                                            r38 = r17(r37, r31)
                                            state = ReturnVal[r38]
                                            r37 = "Enum"
                                            r38 = _env[r37]
                                            r31 = upvalueValues[upvalues[1]]
                                            r39 = upvalueValues[upvalues[2]]
                                            r34 = "Q\169\201VO\135\229\237g\135\191\233\142\135\171"
                                            r35 = 17539873981052
                                            r20 = r39(r34, r35)
                                            r37 = r31[r20]
                                            r17 = r38[r37]
                                            r37 = upvalueValues[upvalues[1]]
                                            r31 = upvalueValues[upvalues[2]]
                                            r20 = "f\012\136\249|:"
                                            r34 = 22422575641277
                                            r39 = r31(r20, r34)
                                            r38 = r37[r39]
                                            ReturnVal = r17[r38]
                                            r18[state] = ReturnVal
                                            ReturnVal = {
                                                r18
                                            }
                                            state = nil
                                        end
                                    else
                                        -- createClosure1 entry 3660487 -> 99, states 99-99
                                        if state == 99 then -- entry 3660487 -> 99
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r11 = "GetPlatform"
                                            r11 = ReturnVal[r11]
                                            r11 = r11(ReturnVal)
                                            r26 = "Enum"
                                            r22 = _env[r26]
                                            r18 = upvalueValues[upvalues[2]]
                                            r17 = upvalueValues[upvalues[3]]
                                            r31 = 6542997666593
                                            r37 = "\170j\\\155;\191\163\008"
                                            r38 = r17(r37, r31)
                                            r26 = r18[r38]
                                            r25 = r22[r26]
                                            r26 = upvalueValues[upvalues[2]]
                                            r18 = upvalueValues[upvalues[3]]
                                            r37 = 32600493503706
                                            r38 = "\1389`\247\245\001\028"
                                            r17 = r18(r38, r37)
                                            r22 = r26[r17]
                                            ReturnVal = r25[r22]
                                            state = r11 == ReturnVal
                                            ReturnVal = {
                                                state
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure4 entry 11903905 -> 100, states 100-100
                                    if state == 100 then -- entry 11903905 -> 100
                                        r11 = args[1]
                                        r25 = "math"
                                        ReturnVal = _env[r25]
                                        r22 = upvalueValues[upvalues[1]]
                                        r26 = upvalueValues[upvalues[2]]
                                        r38 = 25540003650776
                                        r17 = "\234\015Z\195\246"
                                        r18 = r26(r17, r38)
                                        r25 = r22[r18]
                                        state = ReturnVal[r25]
                                        r22 = 86400
                                        r25 = r11 / r22
                                        ReturnVal = state(r25)
                                        r25 = ReturnVal
                                        r22 = "math"
                                        ReturnVal = _env[r22]
                                        r26 = upvalueValues[upvalues[1]]
                                        r18 = upvalueValues[upvalues[2]]
                                        r37 = 18530274322657
                                        r38 = "\228\155\200(\209"
                                        r17 = r18(r38, r37)
                                        r22 = r26[r17]
                                        state = ReturnVal[r22]
                                        r18 = 86400
                                        r26 = r11 % r18
                                        r18 = 3600
                                        r22 = r26 / r18
                                        ReturnVal = state(r22)
                                        r22 = ReturnVal
                                        r26 = "math"
                                        ReturnVal = _env[r26]
                                        r18 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r31 = 13002973388063
                                        r37 = "g\160\141\167o"
                                        r38 = r17(r37, r31)
                                        r26 = r18[r38]
                                        state = ReturnVal[r26]
                                        r17 = 3600
                                        r18 = r11 % r17
                                        r17 = 60
                                        r26 = r18 / r17
                                        ReturnVal = state(r26)
                                        r26 = ReturnVal
                                        ReturnVal = "string"
                                        state = _env[ReturnVal]
                                        r18 = state
                                        ReturnVal = 60
                                        state = r11 % ReturnVal
                                        r17 = state
                                        r38 = upvalueValues[upvalues[1]]
                                        r37 = upvalueValues[upvalues[2]]
                                        r39 = "\201\208\202\1327\025"
                                        r20 = 17881184369738
                                        r31 = r37(r39, r20)
                                        ReturnVal = r38[r31]
                                        state = r18[ReturnVal]
                                        r37 = upvalueValues[upvalues[1]]
                                        r31 = upvalueValues[upvalues[2]]
                                        r20 = "&F\130\218\014\238\127\128<\223\250\255\163'\245"
                                        r34 = 6505263179908
                                        r39 = r31(r20, r34)
                                        r38 = r37[r39]
                                        ReturnVal = state(r38, r25, r22, r26, r17)
                                        r37 = upvalueValues[upvalues[1]]
                                        r31 = upvalueValues[upvalues[2]]
                                        r20 = "\173ek\021\015"
                                        r34 = 30486613108761
                                        r39 = r31(r20, r34)
                                        r38 = r37[r39]
                                        r31 = upvalueValues[upvalues[1]]
                                        r39 = upvalueValues[upvalues[2]]
                                        r35 = 33520930460604
                                        r34 = ""
                                        r20 = r39(r34, r35)
                                        r37 = r31[r20]
                                        r31 = "gsub"
                                        r31 = ReturnVal[r31]
                                        state = {
                                            r31(ReturnVal, r38, r37)
                                        }
                                        ReturnVal = {
                                            unpack(state)
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 104 then
                                    if state <= 101 then
                                        -- createClosure2 entry 8558234 -> 101, states 101-101
                                        if state == 101 then -- entry 8558234 -> 101
                                            r11 = args[1]
                                            r22 = upvalueValues[upvalues[1]]
                                            r26 = upvalueValues[upvalues[2]]
                                            r17 = "1\022\201>i\137\198B\162\243s\142"
                                            r38 = 29673632430586
                                            r18 = r26(r17, r38)
                                            r25 = r22[r18]
                                            ReturnVal = r11[r25]
                                            r22 = upvalueValues[upvalues[1]]
                                            r26 = upvalueValues[upvalues[2]]
                                            r17 = "\216"
                                            r38 = 32751214074023
                                            r18 = r26(r17, r38)
                                            r25 = r22[r18]
                                            state = ReturnVal[r25]
                                            r26 = upvalueValues[upvalues[1]]
                                            r18 = upvalueValues[upvalues[2]]
                                            r37 = 2219150690811
                                            r38 = "8a\185\016\170\148\162\t\148\021\007\\"
                                            r17 = r18(r38, r37)
                                            r22 = r26[r17]
                                            ReturnVal = r11[r22]
                                            r25 = state
                                            r26 = upvalueValues[upvalues[1]]
                                            r18 = upvalueValues[upvalues[2]]
                                            r38 = "\138"
                                            r37 = 18158995407703
                                            r17 = r18(r38, r37)
                                            r22 = r26[r17]
                                            state = ReturnVal[r22]
                                            r22 = state
                                            r26 = "math"
                                            ReturnVal = _env[r26]
                                            r18 = upvalueValues[upvalues[1]]
                                            r17 = upvalueValues[upvalues[2]]
                                            r37 = "\030\191c\148F"
                                            r31 = 29108361173890
                                            r38 = r17(r37, r31)
                                            r26 = r18[r38]
                                            state = ReturnVal[r26]
                                            r17 = upvalueValues[upvalues[3]]
                                            r37 = upvalueValues[upvalues[1]]
                                            r31 = upvalueValues[upvalues[2]]
                                            r20 = "\199"
                                            r34 = 3036877664776
                                            r39 = r31(r20, r34)
                                            r38 = r37[r39]
                                            r18 = r17[r38]
                                            r31 = upvalueValues[upvalues[1]]
                                            r39 = upvalueValues[upvalues[2]]
                                            r35 = 17146905032862
                                            r34 = "^e\168k\210cv\146\003|\188^F?\1360"
                                            r20 = r39(r34, r35)
                                            r37 = r31[r20]
                                            r38 = r11[r37]
                                            r31 = upvalueValues[upvalues[1]]
                                            r39 = upvalueValues[upvalues[2]]
                                            r34 = "\146"
                                            r35 = 18061095791231
                                            r20 = r39(r34, r35)
                                            r37 = r31[r20]
                                            r17 = r38[r37]
                                            r26 = r18 - r17
                                            r18 = 0
                                            ReturnVal = state(r26, r18, r25)
                                            r26 = ReturnVal
                                            r18 = "math"
                                            ReturnVal = _env[r18]
                                            r17 = upvalueValues[upvalues[1]]
                                            r38 = upvalueValues[upvalues[2]]
                                            r39 = 11559829352942
                                            r31 = "2p\250s1"
                                            r37 = r38(r31, r39)
                                            r18 = r17[r37]
                                            state = ReturnVal[r18]
                                            r38 = upvalueValues[upvalues[3]]
                                            r31 = upvalueValues[upvalues[1]]
                                            r39 = upvalueValues[upvalues[2]]
                                            r35 = 4139059387749
                                            r34 = "\186"
                                            r20 = r39(r34, r35)
                                            r37 = r31[r20]
                                            r17 = r38[r37]
                                            r39 = upvalueValues[upvalues[1]]
                                            r20 = upvalueValues[upvalues[2]]
                                            r32 = 5655214755993
                                            r35 = "\231\017\193\180\003\171E\024\138\195X \026\181\217O"
                                            r34 = r20(r35, r32)
                                            r31 = r39[r34]
                                            r37 = r11[r31]
                                            r39 = upvalueValues[upvalues[1]]
                                            r20 = upvalueValues[upvalues[2]]
                                            r32 = 1409204655775
                                            r35 = "\133"
                                            r34 = r20(r35, r32)
                                            r31 = r39[r34]
                                            r38 = r37[r31]
                                            r18 = r17 - r38
                                            r17 = 0
                                            ReturnVal = state(r18, r17, r22)
                                            state = r26 / r25
                                            r18 = ReturnVal
                                            ReturnVal = r18 / r22
                                            ReturnVal = {
                                                state,
                                                ReturnVal
                                            }
                                            state = nil
                                        end
                                    else
                                        -- createClosure4 entry 9738745 -> 102, states 102-104
                                        if state <= 103 then
                                            if state <= 102 then
                                                if state == 102 then -- entry 9738745 -> 102
                                                    r25 = args[2]
                                                    r22 = args[3]
                                                    r11 = args[1]
                                                    r26 = args[4]
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r17 = upvalueValues[upvalues[2]]
                                                    r38 = upvalueValues[upvalues[3]]
                                                    r39 = 21350592102605
                                                    r31 = "\171\186\170X\""
                                                    r37 = r38(r31, r39)
                                                    r18 = r17[r37]
                                                    state = ReturnVal[r18]
                                                    r17 = {
                                                        state(r25)
                                                    }
                                                    r18 = r17[2]
                                                    ReturnVal = r17[1]
                                                    r17 = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r37 = upvalueValues[upvalues[2]]
                                                    r31 = upvalueValues[upvalues[3]]
                                                    r34 = 16806430597558
                                                    r20 = "\166yp\152\140\005\192\007\004"
                                                    r39 = r31(r20, r34)
                                                    r38 = r37[r39]
                                                    state = ReturnVal[r38]
                                                    r38 = allocUpvalue()
                                                    ReturnVal = state(r11)
                                                    upvalueValues[r38] = ReturnVal
                                                    state = upvalueValues[r38]
                                                    r37 = upvalueValues[upvalues[2]]
                                                    r31 = upvalueValues[upvalues[3]]
                                                    r34 = 19269780872812
                                                    r20 = "\134!M\141"
                                                    r39 = r31(r20, r34)
                                                    ReturnVal = r37[r39]
                                                    r39 = "UDim2"
                                                    r31 = _env[r39]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r29 = 21962571522518
                                                    r32 = "q\189\tF8\134\169\133q"
                                                    r35 = r34(r32, r29)
                                                    r39 = r20[r35]
                                                    r37 = r31[r39]
                                                    r20 = 0
                                                    r39 = 0
                                                    r31 = r37(r39, r20)
                                                    state[ReturnVal] = r31
                                                    state = upvalueValues[r38]
                                                    r37 = upvalueValues[upvalues[2]]
                                                    r31 = upvalueValues[upvalues[3]]
                                                    r20 = "\141\187\161.x\149\189F"
                                                    r34 = 21989257051058
                                                    r39 = r31(r20, r34)
                                                    ReturnVal = r37[r39]
                                                    r39 = "UDim2"
                                                    r31 = _env[r39]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r32 = "6p\170\177\150\224nc^"
                                                    r29 = 21509113546855
                                                    r35 = r34(r32, r29)
                                                    r39 = r20[r35]
                                                    r37 = r31[r39]
                                                    r31 = r37(r17, r18)
                                                    state[ReturnVal] = r31
                                                    state = not r26
                                                    state = state and 103 or 104
                                                end
                                            else
                                                if state == 103 then
                                                    r37 = upvalueValues[upvalues[2]]
                                                    r31 = upvalueValues[upvalues[3]]
                                                    r20 = "\158\198\149\\\184\202\188\185\146H\014"
                                                    r34 = 10521057572019
                                                    r39 = r31(r20, r34)
                                                    ReturnVal = r37[r39]
                                                    state = r25[ReturnVal]
                                                    r26 = state
                                                    state = 104
                                                end
                                            end
                                        else
                                            if state == 104 then
                                                ReturnVal = upvalueValues[r38]
                                                r31 = upvalueValues[upvalues[2]]
                                                r39 = upvalueValues[upvalues[3]]
                                                r34 = "\174\199z\023\250\244!s\243\017\021"
                                                r35 = 12173485459930
                                                r20 = r39(r34, r35)
                                                r37 = r31[r20]
                                                r31 = r26
                                                ReturnVal[r37] = r31
                                                ReturnVal = upvalueValues[r38]
                                                r31 = upvalueValues[upvalues[2]]
                                                r39 = upvalueValues[upvalues[3]]
                                                r34 = "\182;\023\011\177\252"
                                                r35 = 25365772212011
                                                r20 = r39(r34, r35)
                                                r37 = r31[r20]
                                                r31 = 200
                                                ReturnVal[r37] = r31
                                                ReturnVal = upvalueValues[r38]
                                                r31 = upvalueValues[upvalues[2]]
                                                r39 = upvalueValues[upvalues[3]]
                                                r34 = "\137\000\230\017_\136"
                                                r35 = 10685220864861
                                                r20 = r39(r34, r35)
                                                r37 = r31[r20]
                                                r31 = r25
                                                ReturnVal[r37] = r31
                                                r39 = upvalueValues[upvalues[2]]
                                                r20 = upvalueValues[upvalues[3]]
                                                r32 = 26050002276582
                                                r35 = "\195\1763\231\154&\175\2291\224\170\198"
                                                r34 = r20(r35, r32)
                                                r31 = r39[r34]
                                                r37 = r25[r31]
                                                r39 = upvalueValues[upvalues[2]]
                                                r20 = upvalueValues[upvalues[3]]
                                                r35 = "\221"
                                                r32 = 23576574922077
                                                r34 = r20(r35, r32)
                                                r31 = r39[r34]
                                                ReturnVal = r37[r31]
                                                r37 = ReturnVal
                                                r31 = upvalueValues[upvalues[1]]
                                                r20 = upvalueValues[upvalues[2]]
                                                r34 = upvalueValues[upvalues[3]]
                                                r29 = 19723407937424
                                                r32 = "\220\247\197\207;"
                                                r35 = r34(r32, r29)
                                                r39 = r20[r35]
                                                ReturnVal = r31[r39]
                                                r31 = ReturnVal
                                                r34 = "Enum"
                                                r20 = _env[r34]
                                                r35 = upvalueValues[upvalues[2]]
                                                r32 = upvalueValues[upvalues[3]]
                                                r2 = 2787945850387
                                                r33 = "\175N\177\005'\212M\024\166\200\251"
                                                r29 = r32(r33, r2)
                                                r34 = r35[r29]
                                                r39 = r20[r34]
                                                r34 = upvalueValues[upvalues[2]]
                                                r35 = upvalueValues[upvalues[3]]
                                                r29 = "\186\208q\031\165,\235\026"
                                                r33 = 13573459775399
                                                r32 = r35(r29, r33)
                                                r20 = r34[r32]
                                                ReturnVal = r39[r20]
                                                r35 = "UDim2"
                                                r34 = _env[r35]
                                                r32 = upvalueValues[upvalues[2]]
                                                r29 = upvalueValues[upvalues[3]]
                                                r5 = 27234513640874
                                                r2 = "\219\192\000O\t%\146\198\248"
                                                r33 = r29(r2, r5)
                                                r35 = r32[r33]
                                                r20 = r34[r35]
                                                r34 = r20(r17, r18)
                                                r32 = "UDim2"
                                                r35 = _env[r32]
                                                r29 = upvalueValues[upvalues[2]]
                                                r33 = upvalueValues[upvalues[3]]
                                                r27 = 7516100253767
                                                r5 = "\031Z\143I\184s\030\229z\217"
                                                r2 = r33(r5, r27)
                                                r32 = r29[r2]
                                                r20 = r35[r32]
                                                r29 = 2
                                                r32 = r37 / r29
                                                r33 = 2
                                                r29 = r37 / r33
                                                r35 = r20(r32, r29)
                                                r39 = ReturnVal
                                                ReturnVal = r34 - r35
                                                r20 = ReturnVal
                                                r35 = "UDim2"
                                                r34 = _env[r35]
                                                r32 = upvalueValues[upvalues[2]]
                                                r29 = upvalueValues[upvalues[3]]
                                                r2 = "\235\134\191\157\028|\215\162N\188"
                                                r5 = 28175813769950
                                                r33 = r29(r2, r5)
                                                r35 = r32[r33]
                                                ReturnVal = r34[r35]
                                                r34 = ReturnVal(r37, r37)
                                                r35 = upvalueValues[r38]
                                                r2 = upvalueValues[upvalues[2]]
                                                r5 = upvalueValues[upvalues[3]]
                                                r21 = 14201846676201
                                                r14 = "t\188I\2387\146\183\134"
                                                r27 = r5(r14, r21)
                                                r33 = r2[r27]
                                                r5 = upvalueValues[upvalues[2]]
                                                r27 = upvalueValues[upvalues[3]]
                                                r1 = 20974405063784
                                                r21 = "\184a\136k\237\221\183\012f\136Z\003\173\202\133\185n"
                                                r14 = r27(r21, r1)
                                                r2 = r5[r14]
                                                r14 = upvalueValues[upvalues[2]]
                                                r21 = upvalueValues[upvalues[3]]
                                                r12 = 19752730247246
                                                r15 = "\246O\239.&\139\244\1697\002@"
                                                r1 = r21(r15, r12)
                                                r27 = r14[r1]
                                                r21 = upvalueValues[upvalues[2]]
                                                r1 = upvalueValues[upvalues[3]]
                                                r24 = 3443810783785
                                                r12 = "C\179\187\196"
                                                r15 = r1(r12, r24)
                                                r14 = r21[r15]
                                                r5 = 1
                                                r29 = {
                                                    [r33] = r20,
                                                    [r2] = r5,
                                                    [r27] = r22,
                                                    [r14] = r34
                                                }
                                                r32 = 0.25
                                                ReturnVal = r31(r35, r32, r39, r29)
                                                r32 = createClosure2(139, {
                                                    r38
                                                })
                                                r38 = releaseUpvalue(r38)
                                                r35 = "spawn"
                                                ReturnVal = _env[r35]
                                                r35 = ReturnVal(r32)
                                                r11 = nil
                                                r17 = nil
                                                r18 = nil
                                                r26 = nil
                                                r25 = nil
                                                r37 = nil
                                                r22 = nil
                                                r39 = nil
                                                r20 = nil
                                                r34 = nil
                                                r31 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure4 entry 11428307 -> 105, states 105-105
                                    if state == 105 then -- entry 11428307 -> 105
                                        r11 = args[1]
                                        r25 = "math"
                                        ReturnVal = _env[r25]
                                        r22 = upvalueValues[upvalues[1]]
                                        r26 = upvalueValues[upvalues[2]]
                                        r38 = 19487913418688
                                        r17 = "\170\127\140\212J"
                                        r18 = r26(r17, r38)
                                        r25 = r22[r18]
                                        state = ReturnVal[r25]
                                        r25 = state
                                        r22 = "string"
                                        ReturnVal = _env[r22]
                                        r26 = upvalueValues[upvalues[1]]
                                        r18 = upvalueValues[upvalues[2]]
                                        r37 = 22562402707074
                                        r38 = "\017g>K8\184"
                                        r17 = r18(r38, r37)
                                        r22 = r26[r17]
                                        state = ReturnVal[r22]
                                        r26 = upvalueValues[upvalues[1]]
                                        r18 = upvalueValues[upvalues[2]]
                                        r37 = 15343284306910
                                        r38 = "B\t\240\141\188\184\227\188\005("
                                        r17 = r18(r38, r37)
                                        r22 = r26[r17]
                                        r37 = upvalueValues[upvalues[1]]
                                        r31 = upvalueValues[upvalues[2]]
                                        r34 = 26808757384146
                                        r20 = "F"
                                        r39 = r31(r20, r34)
                                        r38 = r37[r39]
                                        r17 = r11[r38]
                                        r38 = 255
                                        r18 = r17 * r38
                                        r26 = r25(r18)
                                        r31 = upvalueValues[upvalues[1]]
                                        r39 = upvalueValues[upvalues[2]]
                                        r34 = "p"
                                        r35 = 34842062443448
                                        r20 = r39(r34, r35)
                                        r37 = r31[r20]
                                        r38 = r11[r37]
                                        r37 = 255
                                        r17 = r38 * r37
                                        r18 = r25(r17)
                                        r39 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r32 = 29383198782963
                                        r35 = "\177"
                                        r34 = r20(r35, r32)
                                        r31 = r39[r34]
                                        r37 = r11[r31]
                                        r31 = 255
                                        r38 = r37 * r31
                                        r17 = {
                                            r25(r38)
                                        }
                                        ReturnVal = {
                                            state(r22, r26, r18, unpack(r17))
                                        }
                                        ReturnVal = {
                                            unpack(ReturnVal)
                                        }
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 130 then
                                if state <= 117 then
                                    if state <= 114 then
                                        -- createClosure3 entry 13291137 -> 106, states 106-114
                                        if state <= 110 then
                                            if state <= 108 then
                                                if state <= 107 then
                                                    if state <= 106 then
                                                        if state == 106 then -- entry 13291137 -> 106
                                                            r11 = args[1]
                                                            ReturnVal = nil
                                                            state = r11 == ReturnVal
                                                            state = state and 107 or 108
                                                        end
                                                    else
                                                        if state == 107 then
                                                            state = false
                                                            ReturnVal = {
                                                                state
                                                            }
                                                            state = nil
                                                        end
                                                    end
                                                else
                                                    if state == 108 then
                                                        r25 = upvalueValues[upvalues[1]]
                                                        r22 = upvalueValues[upvalues[2]]
                                                        r17 = 20168795470104
                                                        r18 = "\005\250r\162m\248\n\231\201\219\136\145e-\001\008"
                                                        r26 = r22(r18, r17)
                                                        ReturnVal = r25[r26]
                                                        state = r11[ReturnVal]
                                                        r25 = state
                                                        r22 = upvalueValues[upvalues[1]]
                                                        r26 = upvalueValues[upvalues[2]]
                                                        r38 = 17454149731354
                                                        r17 = "q\195\025\186\190w}^1\156\\\160"
                                                        r18 = r26(r17, r38)
                                                        ReturnVal = r22[r18]
                                                        state = r11[ReturnVal]
                                                        r26 = upvalueValues[upvalues[3]]
                                                        r17 = upvalueValues[upvalues[1]]
                                                        r38 = upvalueValues[upvalues[2]]
                                                        r31 = "F"
                                                        r39 = 8102597414796
                                                        r37 = r38(r31, r39)
                                                        r18 = r17[r37]
                                                        ReturnVal = r26[r18]
                                                        r17 = upvalueValues[upvalues[1]]
                                                        r38 = upvalueValues[upvalues[2]]
                                                        r31 = "\156"
                                                        r39 = 17818038859904
                                                        r37 = r38(r31, r39)
                                                        r18 = r17[r37]
                                                        r26 = r25[r18]
                                                        r22 = state
                                                        state = ReturnVal >= r26
                                                        r26 = state
                                                        state = r26 and 109 or 110
                                                    end
                                                end
                                            else
                                                if state <= 109 then
                                                    if state == 109 then
                                                        r18 = upvalueValues[upvalues[3]]
                                                        r38 = upvalueValues[upvalues[1]]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r39 = "S"
                                                        r20 = 31619097833733
                                                        r31 = r37(r39, r20)
                                                        r17 = r38[r31]
                                                        ReturnVal = r18[r17]
                                                        r37 = upvalueValues[upvalues[1]]
                                                        r31 = upvalueValues[upvalues[2]]
                                                        r34 = 291799781242
                                                        r20 = "\016"
                                                        r39 = r31(r20, r34)
                                                        r38 = r37[r39]
                                                        r17 = r25[r38]
                                                        r31 = upvalueValues[upvalues[1]]
                                                        r39 = upvalueValues[upvalues[2]]
                                                        r35 = 13043345648907
                                                        r34 = "8"
                                                        r20 = r39(r34, r35)
                                                        r37 = r31[r20]
                                                        r38 = r22[r37]
                                                        r18 = r17 + r38
                                                        state = ReturnVal < r18
                                                        r26 = state
                                                        state = r26 and 111 or 112
                                                    end
                                                else
                                                    if state == 110 then
                                                        ReturnVal = {
                                                            r26
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 112 then
                                                if state <= 111 then
                                                    if state == 111 then
                                                        r17 = upvalueValues[upvalues[3]]
                                                        r37 = upvalueValues[upvalues[1]]
                                                        r31 = upvalueValues[upvalues[2]]
                                                        r20 = "\028"
                                                        r34 = 33023235447554
                                                        r39 = r31(r20, r34)
                                                        r38 = r37[r39]
                                                        r18 = r17[r38]
                                                        r37 = upvalueValues[upvalues[1]]
                                                        r31 = upvalueValues[upvalues[2]]
                                                        r34 = 3263893118368
                                                        r20 = "V"
                                                        r39 = r31(r20, r34)
                                                        r38 = r37[r39]
                                                        r17 = r25[r38]
                                                        ReturnVal = r18 >= r17
                                                        r26 = ReturnVal
                                                        state = r26 and 113 or 114
                                                    end
                                                else
                                                    if state == 112 then
                                                        state = 110
                                                    end
                                                end
                                            else
                                                if state <= 113 then
                                                    if state == 113 then
                                                        r38 = upvalueValues[upvalues[3]]
                                                        r31 = upvalueValues[upvalues[1]]
                                                        r39 = upvalueValues[upvalues[2]]
                                                        r34 = "3"
                                                        r35 = 22205258429118
                                                        r20 = r39(r34, r35)
                                                        r37 = r31[r20]
                                                        r17 = r38[r37]
                                                        r39 = upvalueValues[upvalues[1]]
                                                        r20 = upvalueValues[upvalues[2]]
                                                        r32 = 33448396403015
                                                        r35 = "\231"
                                                        r34 = r20(r35, r32)
                                                        r31 = r39[r34]
                                                        r37 = r25[r31]
                                                        r20 = upvalueValues[upvalues[1]]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r29 = 8330115206675
                                                        r32 = "\177"
                                                        r35 = r34(r32, r29)
                                                        r39 = r20[r35]
                                                        r31 = r22[r39]
                                                        r38 = r37 + r31
                                                        r18 = r17 < r38
                                                        r26 = r18
                                                        state = 114
                                                    end
                                                else
                                                    if state == 114 then
                                                        state = 112
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure7 entry 5540184 -> 115, states 115-117
                                        if state <= 116 then
                                            if state <= 115 then
                                                if state == 115 then -- entry 5540184 -> 115
                                                    r25 = args[2]
                                                    r22 = "Instance"
                                                    ReturnVal = _env[r22]
                                                    r26 = upvalueValues[upvalues[1]]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r38 = "n\201\192"
                                                    r37 = 11909931304982
                                                    r17 = r18(r38, r37)
                                                    r11 = args[1]
                                                    r22 = r26[r17]
                                                    state = ReturnVal[r22]
                                                    r26 = upvalueValues[upvalues[1]]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r38 = "X\189K\244\029\162\023\206"
                                                    r37 = 32458842790790
                                                    r17 = r18(r38, r37)
                                                    r22 = r26[r17]
                                                    ReturnVal = state(r22)
                                                    r22 = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r26 = upvalueValues[upvalues[2]]
                                                    r38 = 7077287543699
                                                    r17 = "\156\144J\216\161\206\014\232+\".\187"
                                                    r18 = r26(r17, r38)
                                                    state = ReturnVal[r18]
                                                    r18 = "UDim"
                                                    r26 = _env[r18]
                                                    r17 = upvalueValues[upvalues[1]]
                                                    r38 = upvalueValues[upvalues[2]]
                                                    r31 = "\016\146\137"
                                                    r39 = 5491895766607
                                                    r37 = r38(r31, r39)
                                                    r18 = r17[r37]
                                                    ReturnVal = r26[r18]
                                                    r18 = 0
                                                    r26 = ReturnVal(r18, r11)
                                                    r22[state] = r26
                                                    state = r25 and 116 or 117
                                                end
                                            else
                                                if state == 116 then
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r26 = upvalueValues[upvalues[2]]
                                                    r17 = "\019\150`\023\167\146"
                                                    r38 = 8197559812147
                                                    r18 = r26(r17, r38)
                                                    state = ReturnVal[r18]
                                                    ReturnVal = r25
                                                    r22[state] = ReturnVal
                                                    state = 117
                                                end
                                            end
                                        else
                                            if state == 117 then
                                                ReturnVal = {
                                                    r22
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure3 entry 12818192 -> 118, states 118-130
                                    if state <= 124 then
                                        if state <= 121 then
                                            if state <= 119 then
                                                if state <= 118 then
                                                    if state == 118 then -- entry 12818192 -> 118
                                                        ReturnVal = upvalueValues[upvalues[1]]
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r22 = upvalueValues[upvalues[3]]
                                                        r18 = "l\182\154'}\162"
                                                        r17 = 20153739635090
                                                        r26 = r22(r18, r17)
                                                        r11 = r25[r26]
                                                        state = ReturnVal[r11]
                                                        ReturnVal = state()
                                                        r11 = "Instance"
                                                        ReturnVal = _env[r11]
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r22 = upvalueValues[upvalues[3]]
                                                        r17 = 4632080832914
                                                        r18 = "\193<\139"
                                                        r26 = r22(r18, r17)
                                                        r11 = r25[r26]
                                                        state = ReturnVal[r11]
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r22 = upvalueValues[upvalues[3]]
                                                        r17 = 14471942270376
                                                        r18 = "\228\132\141\029\182\223b$\004"
                                                        r26 = r22(r18, r17)
                                                        r11 = r25[r26]
                                                        ReturnVal = state(r11)
                                                        r11 = ReturnVal
                                                        ReturnVal = upvalueValues[upvalues[1]]
                                                        r22 = upvalueValues[upvalues[2]]
                                                        r26 = upvalueValues[upvalues[3]]
                                                        r38 = 13358106917446
                                                        r17 = "R\219\146\006\133@v\215\236"
                                                        r18 = r26(r17, r38)
                                                        r25 = r22[r18]
                                                        state = ReturnVal[r25]
                                                        ReturnVal = state(r11)
                                                        r25 = "Instance"
                                                        ReturnVal = _env[r25]
                                                        r22 = upvalueValues[upvalues[2]]
                                                        r26 = upvalueValues[upvalues[3]]
                                                        r38 = 34174705068591
                                                        r17 = "\004\027\150"
                                                        r18 = r26(r17, r38)
                                                        r25 = r22[r18]
                                                        state = ReturnVal[r25]
                                                        r22 = upvalueValues[upvalues[2]]
                                                        r26 = upvalueValues[upvalues[3]]
                                                        r17 = "^\026\184\231\188"
                                                        r38 = 5587618039991
                                                        r18 = r26(r17, r38)
                                                        r25 = r22[r18]
                                                        ReturnVal = state(r25, r11)
                                                        r25 = ReturnVal
                                                        ReturnVal = upvalueValues[upvalues[2]]
                                                        r22 = upvalueValues[upvalues[3]]
                                                        r18 = "\\LM\127M\008Ao\1922\204"
                                                        r17 = 9381641942331
                                                        r26 = r22(r18, r17)
                                                        state = ReturnVal[r26]
                                                        r26 = "Vector2"
                                                        r22 = _env[r26]
                                                        r18 = upvalueValues[upvalues[2]]
                                                        r17 = upvalueValues[upvalues[3]]
                                                        r37 = "\144\031\249"
                                                        r31 = 8173741122231
                                                        r38 = r17(r37, r31)
                                                        r26 = r18[r38]
                                                        ReturnVal = r22[r26]
                                                        r26 = 0.5
                                                        r18 = 0.5
                                                        r22 = ReturnVal(r26, r18)
                                                        r25[state] = r22
                                                        ReturnVal = upvalueValues[upvalues[2]]
                                                        r22 = upvalueValues[upvalues[3]]
                                                        r17 = 15132942414937
                                                        r18 = "\234\151\029#I\168M\136n'}?\213M\255\022"
                                                        r26 = r22(r18, r17)
                                                        state = ReturnVal[r26]
                                                        r26 = "Color3"
                                                        r22 = _env[r26]
                                                        r18 = upvalueValues[upvalues[2]]
                                                        r17 = upvalueValues[upvalues[3]]
                                                        r37 = "\218\160\160\001e\172\157"
                                                        r31 = 22031518291587
                                                        r38 = r17(r37, r31)
                                                        r26 = r18[r38]
                                                        ReturnVal = r22[r26]
                                                        r18 = 34
                                                        r17 = 39
                                                        r26 = 35
                                                        r22 = ReturnVal(r26, r18, r17)
                                                        r25[state] = r22
                                                        ReturnVal = upvalueValues[upvalues[2]]
                                                        r22 = upvalueValues[upvalues[3]]
                                                        r17 = 6121535563277
                                                        r18 = "\132\162\175\167\184\205\027\228]e\"~|3\180\188\182\214!\138\139\200"
                                                        r26 = r22(r18, r17)
                                                        state = ReturnVal[r26]
                                                        ReturnVal = 0
                                                        r25[state] = ReturnVal
                                                        ReturnVal = upvalueValues[upvalues[2]]
                                                        r22 = upvalueValues[upvalues[3]]
                                                        r18 = "'\147\011-\t\240\218\237"
                                                        r17 = 30021202528626
                                                        r26 = r22(r18, r17)
                                                        state = ReturnVal[r26]
                                                        r26 = "UDim2"
                                                        r22 = _env[r26]
                                                        r18 = upvalueValues[upvalues[2]]
                                                        r17 = upvalueValues[upvalues[3]]
                                                        r37 = "\004C\182"
                                                        r31 = 23905367231763
                                                        r38 = r17(r37, r31)
                                                        r26 = r18[r38]
                                                        ReturnVal = r22[r26]
                                                        r18 = 0
                                                        r38 = 0
                                                        r17 = 0.5
                                                        r26 = 0.5
                                                        r22 = ReturnVal(r26, r18, r17, r38)
                                                        r25[state] = r22
                                                        ReturnVal = upvalueValues[upvalues[2]]
                                                        r22 = upvalueValues[upvalues[3]]
                                                        r18 = ",\204\011\019"
                                                        r17 = 22738697322961
                                                        r26 = r22(r18, r17)
                                                        state = ReturnVal[r26]
                                                        r22 = upvalueValues[upvalues[2]]
                                                        r26 = upvalueValues[upvalues[3]]
                                                        r38 = 33954438380454
                                                        r17 = "\r\221|\029\150"
                                                        r18 = r26(r17, r38)
                                                        ReturnVal = r22[r18]
                                                        r25[state] = ReturnVal
                                                        ReturnVal = upvalueValues[upvalues[1]]
                                                        r26 = upvalueValues[upvalues[2]]
                                                        r18 = upvalueValues[upvalues[3]]
                                                        r37 = 21022527064233
                                                        r38 = "jp\178\255\001"
                                                        r17 = r18(r38, r37)
                                                        r22 = r26[r17]
                                                        state = ReturnVal[r22]
                                                        r22 = state
                                                        r18 = "Enum"
                                                        r26 = _env[r18]
                                                        r17 = upvalueValues[upvalues[2]]
                                                        r38 = upvalueValues[upvalues[3]]
                                                        r31 = "\184&\175\201s\204p\206\187R\154"
                                                        r39 = 34353968740360
                                                        r37 = r38(r31, r39)
                                                        r18 = r17[r37]
                                                        ReturnVal = r26[r18]
                                                        r18 = upvalueValues[upvalues[2]]
                                                        r17 = upvalueValues[upvalues[3]]
                                                        r37 = "@?\129A"
                                                        r31 = 22608255472572
                                                        r38 = r17(r37, r31)
                                                        r26 = r18[r38]
                                                        state = ReturnVal[r26]
                                                        r26 = state
                                                        ReturnVal = upvalueValues[upvalues[1]]
                                                        r17 = upvalueValues[upvalues[2]]
                                                        r38 = upvalueValues[upvalues[3]]
                                                        r31 = "{G\223J\\:"
                                                        r39 = 18564192107238
                                                        r37 = r38(r31, r39)
                                                        r18 = r17[r37]
                                                        state = ReturnVal[r18]
                                                        ReturnVal = state()
                                                        r18 = ReturnVal
                                                        state = r18 and 119 or 120
                                                    end
                                                else
                                                    if state == 119 then
                                                        r17 = "UDim2"
                                                        ReturnVal = _env[r17]
                                                        r38 = upvalueValues[upvalues[2]]
                                                        r37 = upvalueValues[upvalues[3]]
                                                        r20 = 33967774093655
                                                        r39 = "\159\007\145"
                                                        r31 = r37(r39, r20)
                                                        r17 = r38[r31]
                                                        state = ReturnVal[r17]
                                                        r17 = 0
                                                        r37 = 0
                                                        r38 = 700
                                                        r31 = 500
                                                        ReturnVal = state(r17, r38, r37, r31)
                                                        r18 = ReturnVal
                                                        state = 120
                                                    end
                                                end
                                            else
                                                if state <= 120 then
                                                    if state == 120 then
                                                        state = not r18
                                                        state = state and 121 or 122
                                                    end
                                                else
                                                    if state == 121 then
                                                        r38 = "UDim2"
                                                        r17 = _env[r38]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r31 = upvalueValues[upvalues[3]]
                                                        r34 = 34093029965916
                                                        r20 = "\021,\171"
                                                        r39 = r31(r20, r34)
                                                        r38 = r37[r39]
                                                        state = r17[r38]
                                                        r31 = 0
                                                        r38 = 0
                                                        r37 = 600
                                                        r39 = 400
                                                        r17 = state(r38, r37, r31, r39)
                                                        r18 = r17
                                                        state = 122
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 123 then
                                                if state <= 122 then
                                                    if state == 122 then
                                                        r39 = upvalueValues[upvalues[2]]
                                                        r20 = upvalueValues[upvalues[3]]
                                                        r32 = 16765924500517
                                                        r35 = "q\002J["
                                                        r34 = r20(r35, r32)
                                                        r31 = r39[r34]
                                                        r37 = {
                                                            [r31] = r18
                                                        }
                                                        r38 = 0.25
                                                        state = r22(r25, r38, r26, r37)
                                                        r38 = upvalueValues[upvalues[1]]
                                                        r31 = upvalueValues[upvalues[2]]
                                                        r39 = upvalueValues[upvalues[3]]
                                                        r34 = "\002\243rD&lm\235\129=\210\145\171"
                                                        r35 = 23263236062612
                                                        r20 = r39(r34, r35)
                                                        r37 = r31[r20]
                                                        state = r38[r37]
                                                        r37 = 10
                                                        r38 = state(r37, r25)
                                                        r37 = "Instance"
                                                        r38 = _env[r37]
                                                        r31 = upvalueValues[upvalues[2]]
                                                        r39 = upvalueValues[upvalues[3]]
                                                        r35 = 10918413169610
                                                        r34 = "s\175o"
                                                        r20 = r39(r34, r35)
                                                        r37 = r31[r20]
                                                        state = r38[r37]
                                                        r31 = upvalueValues[upvalues[2]]
                                                        r39 = upvalueValues[upvalues[3]]
                                                        r35 = 10974148053869
                                                        r34 = "\187\002a\227M"
                                                        r20 = r39(r34, r35)
                                                        r37 = r31[r20]
                                                        r38 = state(r37, r25)
                                                        r37 = allocUpvalue()
                                                        upvalueValues[r37] = r38
                                                        state = upvalueValues[r37]
                                                        r31 = upvalueValues[upvalues[2]]
                                                        r39 = upvalueValues[upvalues[3]]
                                                        r34 = "\247\180\160\007\023\242Y\207\178\247\169"
                                                        r35 = 25094063772929
                                                        r20 = r39(r34, r35)
                                                        r38 = r31[r20]
                                                        r20 = "Vector2"
                                                        r39 = _env[r20]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r35 = upvalueValues[upvalues[3]]
                                                        r29 = "O\162\186"
                                                        r33 = 34116394608121
                                                        r32 = r35(r29, r33)
                                                        r20 = r34[r32]
                                                        r31 = r39[r20]
                                                        r34 = 0.5
                                                        r20 = 0.5
                                                        r39 = r31(r20, r34)
                                                        state[r38] = r39
                                                        state = upvalueValues[r37]
                                                        r31 = upvalueValues[upvalues[2]]
                                                        r39 = upvalueValues[upvalues[3]]
                                                        r35 = 313230885157
                                                        r34 = "\0297r\194\001\029\173>\176\152\1567\024\240\213\191\000c\000i4\249"
                                                        r20 = r39(r34, r35)
                                                        r38 = r31[r20]
                                                        r31 = 1
                                                        state[r38] = r31
                                                        state = upvalueValues[r37]
                                                        r31 = upvalueValues[upvalues[2]]
                                                        r39 = upvalueValues[upvalues[3]]
                                                        r35 = 18064873719274
                                                        r34 = "CX\163~\236s\197\150"
                                                        r20 = r39(r34, r35)
                                                        r38 = r31[r20]
                                                        r20 = "UDim2"
                                                        r39 = _env[r20]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r35 = upvalueValues[upvalues[3]]
                                                        r29 = "5\1618"
                                                        r33 = 31424574148453
                                                        r32 = r35(r29, r33)
                                                        r20 = r34[r32]
                                                        r31 = r39[r20]
                                                        r32 = 0
                                                        r20 = 0.5
                                                        r35 = 0.5
                                                        r34 = 0
                                                        r39 = r31(r20, r34, r35, r32)
                                                        state[r38] = r39
                                                        state = upvalueValues[r37]
                                                        r31 = upvalueValues[upvalues[2]]
                                                        r39 = upvalueValues[upvalues[3]]
                                                        r35 = 33324384346742
                                                        r34 = "M\211\227j"
                                                        r20 = r39(r34, r35)
                                                        r38 = r31[r20]
                                                        r20 = "UDim2"
                                                        r39 = _env[r20]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r35 = upvalueValues[upvalues[3]]
                                                        r33 = 12433623428146
                                                        r29 = "\230V\015"
                                                        r32 = r35(r29, r33)
                                                        r20 = r34[r32]
                                                        r31 = r39[r20]
                                                        r35 = 0.95
                                                        r34 = 0
                                                        r32 = 0
                                                        r20 = 0.95
                                                        r39 = r31(r20, r34, r35, r32)
                                                        state[r38] = r39
                                                        state = upvalueValues[r37]
                                                        r31 = upvalueValues[upvalues[2]]
                                                        r39 = upvalueValues[upvalues[3]]
                                                        r34 = "\236\231\192\127"
                                                        r35 = 20671298730317
                                                        r20 = r39(r34, r35)
                                                        r38 = r31[r20]
                                                        r39 = upvalueValues[upvalues[2]]
                                                        r20 = upvalueValues[upvalues[3]]
                                                        r32 = 19489760553202
                                                        r35 = "\176\251m\157\248"
                                                        r34 = r20(r35, r32)
                                                        r31 = r39[r34]
                                                        state[r38] = r31
                                                        state = upvalueValues[r37]
                                                        r31 = upvalueValues[upvalues[2]]
                                                        r39 = upvalueValues[upvalues[3]]
                                                        r35 = 19773290975624
                                                        r34 = "L\175T\207y=\246p@\255#V\231\234.\183"
                                                        r20 = r39(r34, r35)
                                                        r38 = r31[r20]
                                                        r31 = true
                                                        state[r38] = r31
                                                        r31 = "Instance"
                                                        r38 = _env[r31]
                                                        r39 = upvalueValues[upvalues[2]]
                                                        r20 = upvalueValues[upvalues[3]]
                                                        r35 = "\002\2334"
                                                        r32 = 5786192335230
                                                        r34 = r20(r35, r32)
                                                        r31 = r39[r34]
                                                        state = r38[r31]
                                                        r39 = upvalueValues[upvalues[2]]
                                                        r20 = upvalueValues[upvalues[3]]
                                                        r35 = "\180\018t\014\215\1565=\190_\229+"
                                                        r32 = 25536536298804
                                                        r34 = r20(r35, r32)
                                                        r31 = r39[r34]
                                                        r39 = upvalueValues[r37]
                                                        r38 = state(r31, r39)
                                                        r31 = allocUpvalue()
                                                        upvalueValues[r31] = r38
                                                        state = upvalueValues[r31]
                                                        r39 = upvalueValues[upvalues[2]]
                                                        r20 = upvalueValues[upvalues[3]]
                                                        r35 = "\203\190\231\184\182\180\217$"
                                                        r32 = 34887901991083
                                                        r34 = r20(r35, r32)
                                                        r38 = r39[r34]
                                                        r39 = true
                                                        state[r38] = r39
                                                        state = upvalueValues[r31]
                                                        r39 = upvalueValues[upvalues[2]]
                                                        r20 = upvalueValues[upvalues[3]]
                                                        r32 = 10823126963116
                                                        r35 = "\238\217\227\201\154\163\031\133"
                                                        r34 = r20(r35, r32)
                                                        r38 = r39[r34]
                                                        r39 = true
                                                        state[r38] = r39
                                                        state = upvalueValues[r31]
                                                        r39 = upvalueValues[upvalues[2]]
                                                        r20 = upvalueValues[upvalues[3]]
                                                        r32 = 105946257806
                                                        r35 = "\234\193Z\248\171q^{a\203\251"
                                                        r34 = r20(r35, r32)
                                                        r38 = r39[r34]
                                                        r35 = "Enum"
                                                        r34 = _env[r35]
                                                        r32 = upvalueValues[upvalues[2]]
                                                        r29 = upvalueValues[upvalues[3]]
                                                        r2 = "\150\014\181\146\216\157\008\198\127\n4"
                                                        r5 = 21418741873517
                                                        r33 = r29(r2, r5)
                                                        r35 = r32[r33]
                                                        r20 = r34[r35]
                                                        r35 = upvalueValues[upvalues[2]]
                                                        r32 = upvalueValues[upvalues[3]]
                                                        r33 = "\197=U\187\004"
                                                        r2 = 2528618196598
                                                        r29 = r32(r33, r2)
                                                        r34 = r35[r29]
                                                        r39 = r20[r34]
                                                        state[r38] = r39
                                                        state = upvalueValues[r31]
                                                        r39 = upvalueValues[upvalues[2]]
                                                        r20 = upvalueValues[upvalues[3]]
                                                        r35 = "'\219f\149\223\195X\131\141"
                                                        r32 = 20651748756410
                                                        r34 = r20(r35, r32)
                                                        r38 = r39[r34]
                                                        r39 = 0.5
                                                        state[r38] = r39
                                                        r39 = "Instance"
                                                        r38 = _env[r39]
                                                        r20 = upvalueValues[upvalues[2]]
                                                        r34 = upvalueValues[upvalues[3]]
                                                        r29 = 21208066895799
                                                        r32 = "\236\029\223"
                                                        r35 = r34(r32, r29)
                                                        r39 = r20[r35]
                                                        state = r38[r39]
                                                        r20 = upvalueValues[upvalues[2]]
                                                        r34 = upvalueValues[upvalues[3]]
                                                        r32 = "0!\252\188e\142"
                                                        r29 = 7834506421359
                                                        r35 = r34(r32, r29)
                                                        r39 = r20[r35]
                                                        r38 = state(r39, r25)
                                                        r20 = "Instance"
                                                        r39 = _env[r20]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r35 = upvalueValues[upvalues[3]]
                                                        r33 = 11669455199990
                                                        r29 = "rz}"
                                                        r32 = r35(r29, r33)
                                                        r20 = r34[r32]
                                                        state = r39[r20]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r35 = upvalueValues[upvalues[3]]
                                                        r29 = "]\223Y\0250Tw\220Lm"
                                                        r33 = 32938401189366
                                                        r32 = r35(r29, r33)
                                                        r20 = r34[r32]
                                                        r39 = state(r20, r38)
                                                        r20 = allocUpvalue()
                                                        upvalueValues[r20] = r39
                                                        state = upvalueValues[r20]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r35 = upvalueValues[upvalues[3]]
                                                        r29 = "\2039\159\241\"\127\169,F\185X\003\186\180\234"
                                                        r33 = 13365670334056
                                                        r32 = r35(r29, r33)
                                                        r39 = r34[r32]
                                                        r34 = false
                                                        state[r39] = r34
                                                        state = upvalueValues[r20]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r35 = upvalueValues[upvalues[3]]
                                                        r29 = ":\027l\147\008\007U\141\246\018\204\183\171\187\137\182"
                                                        r33 = 25624154852228
                                                        r32 = r35(r29, r33)
                                                        r39 = r34[r32]
                                                        r34 = 1
                                                        state[r39] = r34
                                                        state = upvalueValues[r20]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r35 = upvalueValues[upvalues[3]]
                                                        r33 = 7328529864018
                                                        r29 = "\195\238U5\024\224"
                                                        r32 = r35(r29, r33)
                                                        r39 = r34[r32]
                                                        r34 = 0
                                                        state[r39] = r34
                                                        state = upvalueValues[r20]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r35 = upvalueValues[upvalues[3]]
                                                        r33 = 18296598471792
                                                        r29 = "\208CKG*e1\207\253\166\015"
                                                        r32 = r35(r29, r33)
                                                        r39 = r34[r32]
                                                        r32 = "Vector2"
                                                        r35 = _env[r32]
                                                        r29 = upvalueValues[upvalues[2]]
                                                        r33 = upvalueValues[upvalues[3]]
                                                        r27 = 15519754626971
                                                        r5 = "H#\187"
                                                        r2 = r33(r5, r27)
                                                        r32 = r29[r2]
                                                        r34 = r35[r32]
                                                        r29 = 0.5
                                                        r32 = 0.5
                                                        r35 = r34(r32, r29)
                                                        state[r39] = r35
                                                        state = upvalueValues[r20]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r35 = upvalueValues[upvalues[3]]
                                                        r33 = 7836422975696
                                                        r29 = "\253\150\209\239!\2150\174c\178\162\232D\233\187d"
                                                        r32 = r35(r29, r33)
                                                        r39 = r34[r32]
                                                        r32 = "Color3"
                                                        r35 = _env[r32]
                                                        r29 = upvalueValues[upvalues[2]]
                                                        r33 = upvalueValues[upvalues[3]]
                                                        r5 = "\217\169}v\242\167~"
                                                        r27 = 8839805079542
                                                        r2 = r33(r5, r27)
                                                        r32 = r29[r2]
                                                        r34 = r35[r32]
                                                        r29 = 0
                                                        r33 = 0
                                                        r32 = 0
                                                        r35 = r34(r32, r29, r33)
                                                        state[r39] = r35
                                                        state = upvalueValues[r20]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r35 = upvalueValues[upvalues[3]]
                                                        r29 = "\172PF\183\245\023\191\151\216`\254\214\160I\225\015\012\242t\020\148\207"
                                                        r33 = 32354706615150
                                                        r32 = r35(r29, r33)
                                                        r39 = r34[r32]
                                                        r34 = 1
                                                        state[r39] = r34
                                                        state = upvalueValues[r20]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r35 = upvalueValues[upvalues[3]]
                                                        r29 = "\181\193\253\023M\135m\247"
                                                        r33 = 2633480073412
                                                        r32 = r35(r29, r33)
                                                        r39 = r34[r32]
                                                        r32 = "UDim2"
                                                        r35 = _env[r32]
                                                        r29 = upvalueValues[upvalues[2]]
                                                        r33 = upvalueValues[upvalues[3]]
                                                        r27 = 30348475685146
                                                        r5 = "\196\250V"
                                                        r2 = r33(r5, r27)
                                                        r32 = r29[r2]
                                                        r34 = r35[r32]
                                                        r29 = 0
                                                        r2 = 0
                                                        r33 = 0.5
                                                        r32 = 0.5
                                                        r35 = r34(r32, r29, r33, r2)
                                                        state[r39] = r35
                                                        state = upvalueValues[r20]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r35 = upvalueValues[upvalues[3]]
                                                        r29 = "\250G\143\233"
                                                        r33 = 23257455710907
                                                        r32 = r35(r29, r33)
                                                        r39 = r34[r32]
                                                        r32 = "UDim2"
                                                        r35 = _env[r32]
                                                        r29 = upvalueValues[upvalues[2]]
                                                        r33 = upvalueValues[upvalues[3]]
                                                        r5 = "\130\131l"
                                                        r27 = 10939818952755
                                                        r2 = r33(r5, r27)
                                                        r32 = r29[r2]
                                                        r34 = r35[r32]
                                                        r33 = 1
                                                        r2 = 0
                                                        r29 = 0
                                                        r32 = 1
                                                        r35 = r34(r32, r29, r33, r2)
                                                        state[r39] = r35
                                                        r39 = upvalueValues[upvalues[1]]
                                                        r35 = upvalueValues[upvalues[2]]
                                                        r32 = upvalueValues[upvalues[3]]
                                                        r33 = "\005Sm)\1568\146\198q\238T\138}"
                                                        r2 = 26007795905282
                                                        r29 = r32(r33, r2)
                                                        r34 = r35[r29]
                                                        state = r39[r34]
                                                        r35 = upvalueValues[r20]
                                                        r34 = 10
                                                        r39 = state(r34, r35)
                                                        r34 = "Instance"
                                                        r39 = _env[r34]
                                                        r35 = upvalueValues[upvalues[2]]
                                                        r32 = upvalueValues[upvalues[3]]
                                                        r33 = "\019\199\193"
                                                        r2 = 8143055672982
                                                        r29 = r32(r33, r2)
                                                        r34 = r35[r29]
                                                        state = r39[r34]
                                                        r35 = upvalueValues[upvalues[2]]
                                                        r32 = upvalueValues[upvalues[3]]
                                                        r2 = 15642187208389
                                                        r33 = "\180\193\201p\229"
                                                        r29 = r32(r33, r2)
                                                        r34 = r35[r29]
                                                        r39 = state(r34, r25)
                                                        r34 = allocUpvalue()
                                                        upvalueValues[r34] = r39
                                                        state = upvalueValues[r34]
                                                        r35 = upvalueValues[upvalues[2]]
                                                        r32 = upvalueValues[upvalues[3]]
                                                        r33 = "\191+,\206\2159\185T"
                                                        r2 = 25787779260802
                                                        r29 = r32(r33, r2)
                                                        r39 = r35[r29]
                                                        r29 = "UDim2"
                                                        r32 = _env[r29]
                                                        r33 = upvalueValues[upvalues[2]]
                                                        r2 = upvalueValues[upvalues[3]]
                                                        r14 = 14449439541900
                                                        r27 = ">p9"
                                                        r5 = r2(r27, r14)
                                                        r29 = r33[r5]
                                                        r35 = r32[r29]
                                                        r2 = 0.5
                                                        r5 = 0
                                                        r29 = 0.019
                                                        r33 = 0
                                                        r32 = r35(r29, r33, r2, r5)
                                                        state[r39] = r32
                                                        state = upvalueValues[r34]
                                                        r35 = upvalueValues[upvalues[2]]
                                                        r32 = upvalueValues[upvalues[3]]
                                                        r33 = "$\2520I\156&\244F\005\012-VC\173\240\215)\252TE.\219"
                                                        r2 = 10562882301095
                                                        r29 = r32(r33, r2)
                                                        r39 = r35[r29]
                                                        r35 = 1
                                                        state[r39] = r35
                                                        r39 = upvalueValues[upvalues[1]]
                                                        r32 = upvalueValues[upvalues[2]]
                                                        r29 = upvalueValues[upvalues[3]]
                                                        r2 = "\229\205T\161X\164"
                                                        r5 = 15362261098656
                                                        r33 = r29(r2, r5)
                                                        r35 = r32[r33]
                                                        state = r39[r35]
                                                        r39 = state()
                                                        state = r39 and 123 or 124
                                                    end
                                                else
                                                    if state == 123 then
                                                        r32 = "UDim2"
                                                        r35 = _env[r32]
                                                        r29 = upvalueValues[upvalues[2]]
                                                        r33 = upvalueValues[upvalues[3]]
                                                        r27 = 2660065491259
                                                        r5 = "\171\156\000"
                                                        r2 = r33(r5, r27)
                                                        r32 = r29[r2]
                                                        state = r35[r32]
                                                        r29 = 30
                                                        r2 = 500
                                                        r33 = 0
                                                        r32 = 0
                                                        r35 = state(r32, r29, r33, r2)
                                                        r39 = r35
                                                        state = 124
                                                    end
                                                end
                                            else
                                                if state == 124 then
                                                    state = not r39
                                                    state = state and 125 or 126
                                                end
                                            end
                                        end
                                    else
                                        if state <= 127 then
                                            if state <= 126 then
                                                if state <= 125 then
                                                    if state == 125 then
                                                        r29 = "UDim2"
                                                        r32 = _env[r29]
                                                        r33 = upvalueValues[upvalues[2]]
                                                        r2 = upvalueValues[upvalues[3]]
                                                        r14 = 29938725753008
                                                        r27 = "\131\236\142"
                                                        r5 = r2(r27, r14)
                                                        r29 = r33[r5]
                                                        state = r32[r29]
                                                        r5 = 400
                                                        r33 = 30
                                                        r2 = 0
                                                        r29 = 0
                                                        r32 = state(r29, r33, r2, r5)
                                                        r39 = r32
                                                        state = 126
                                                    end
                                                else
                                                    if state == 126 then
                                                        state = upvalueValues[r34]
                                                        r33 = upvalueValues[upvalues[2]]
                                                        r2 = upvalueValues[upvalues[3]]
                                                        r27 = "\206\131,\214"
                                                        r14 = 18075897525081
                                                        r5 = r2(r27, r14)
                                                        r29 = r33[r5]
                                                        r33 = r39
                                                        state[r29] = r33
                                                        state = upvalueValues[r34]
                                                        r33 = upvalueValues[upvalues[2]]
                                                        r2 = upvalueValues[upvalues[3]]
                                                        r14 = 29084060606982
                                                        r27 = "\002\166\249\158\213\137\1586^\1985"
                                                        r5 = r2(r27, r14)
                                                        r29 = r33[r5]
                                                        r5 = "Vector2"
                                                        r2 = _env[r5]
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r14 = upvalueValues[upvalues[3]]
                                                        r15 = 10991517236888
                                                        r1 = "\241\211\139"
                                                        r21 = r14(r1, r15)
                                                        r5 = r27[r21]
                                                        r33 = r2[r5]
                                                        r27 = 0.5
                                                        r5 = 0.5
                                                        r2 = r33(r5, r27)
                                                        state[r29] = r2
                                                        r33 = "Instance"
                                                        r29 = _env[r33]
                                                        r2 = upvalueValues[upvalues[2]]
                                                        r5 = upvalueValues[upvalues[3]]
                                                        r21 = 23789147060241
                                                        r14 = "\139\159\016"
                                                        r27 = r5(r14, r21)
                                                        r33 = r2[r27]
                                                        state = r29[r33]
                                                        r2 = upvalueValues[upvalues[2]]
                                                        r5 = upvalueValues[upvalues[3]]
                                                        r21 = 13245408337516
                                                        r14 = "r\015(aiT`zJ\189"
                                                        r27 = r5(r14, r21)
                                                        r33 = r2[r27]
                                                        r2 = upvalueValues[r34]
                                                        r29 = state(r33, r2)
                                                        r33 = upvalueValues[upvalues[2]]
                                                        r2 = upvalueValues[upvalues[3]]
                                                        r27 = "B\003\178\215\130\136\174\196\184\196U\252"
                                                        r14 = 13092683270820
                                                        r5 = r2(r27, r14)
                                                        state = r33[r5]
                                                        r5 = "NumberSequence"
                                                        r2 = _env[r5]
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r14 = upvalueValues[upvalues[3]]
                                                        r1 = "\152\142\217"
                                                        r15 = 31728160809188
                                                        r21 = r14(r1, r15)
                                                        r5 = r27[r21]
                                                        r33 = r2[r5]
                                                        r27 = 1
                                                        r5 = 0
                                                        r2 = r33(r5, r27)
                                                        r29[state] = r2
                                                        r33 = upvalueValues[upvalues[2]]
                                                        r2 = upvalueValues[upvalues[3]]
                                                        r14 = 11624591377160
                                                        r27 = "6\162\018|1"
                                                        r5 = r2(r27, r14)
                                                        state = r33[r5]
                                                        r5 = "ColorSequence"
                                                        r2 = _env[r5]
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r14 = upvalueValues[upvalues[3]]
                                                        r1 = "_-G"
                                                        r15 = 6534592729268
                                                        r21 = r14(r1, r15)
                                                        r5 = r27[r21]
                                                        r33 = r2[r5]
                                                        r14 = "Color3"
                                                        r27 = _env[r14]
                                                        r21 = upvalueValues[upvalues[2]]
                                                        r1 = upvalueValues[upvalues[3]]
                                                        r12 = "\237\170pJb\144\236"
                                                        r24 = 6997312615104
                                                        r15 = r1(r12, r24)
                                                        r14 = r21[r15]
                                                        r5 = r27[r14]
                                                        r21 = 0
                                                        r14 = 0
                                                        r1 = 0
                                                        r27 = {
                                                            r5(r14, r21, r1)
                                                        }
                                                        r2 = r33(unpack(r27))
                                                        r29[state] = r2
                                                        r33 = upvalueValues[upvalues[1]]
                                                        r5 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r1 = 10939785598892
                                                        r21 = "\212Kt'\139\131\217\185\r\236\174\199\181"
                                                        r14 = r27(r21, r1)
                                                        r2 = r5[r14]
                                                        state = r33[r2]
                                                        r5 = upvalueValues[r34]
                                                        r2 = 10
                                                        r33 = state(r2, r5)
                                                        r2 = "Instance"
                                                        r33 = _env[r2]
                                                        r5 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r1 = 7035567133259
                                                        r21 = "\201A\021"
                                                        r14 = r27(r21, r1)
                                                        r2 = r5[r14]
                                                        state = r33[r2]
                                                        r5 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r21 = " \025\211)\017{\2030\221G"
                                                        r1 = 31198882367837
                                                        r14 = r27(r21, r1)
                                                        r2 = r5[r14]
                                                        r5 = upvalueValues[r34]
                                                        r33 = state(r2, r5)
                                                        r2 = allocUpvalue()
                                                        upvalueValues[r2] = r33
                                                        state = upvalueValues[r2]
                                                        r5 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r1 = 8919562587734
                                                        r21 = "3\154\\\164i8\202\140\206@\239"
                                                        r14 = r27(r21, r1)
                                                        r33 = r5[r14]
                                                        r14 = "Vector2"
                                                        r27 = _env[r14]
                                                        r21 = upvalueValues[upvalues[2]]
                                                        r1 = upvalueValues[upvalues[3]]
                                                        r12 = "=M`"
                                                        r24 = 30780543613066
                                                        r15 = r1(r12, r24)
                                                        r14 = r21[r15]
                                                        r5 = r27[r14]
                                                        r1 = 0.5
                                                        r15 = 0
                                                        r14 = 0.5
                                                        r21 = 0
                                                        r27 = r5(r14, r21, r1, r15)
                                                        state[r33] = r27
                                                        state = upvalueValues[r2]
                                                        r5 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r21 = "\158-\020\142\136\130\161\177\136\137O\231\141\030\237\143\245\024\166)p\147"
                                                        r1 = 26907508757920
                                                        r14 = r27(r21, r1)
                                                        r33 = r5[r14]
                                                        r5 = 1
                                                        state[r33] = r5
                                                        state = upvalueValues[r2]
                                                        r5 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r21 = "\137\156\245\197 "
                                                        r1 = 4437605622615
                                                        r14 = r27(r21, r1)
                                                        r33 = r5[r14]
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r14 = upvalueValues[upvalues[3]]
                                                        r15 = 12314912390027
                                                        r1 = "\198hQ\163\183\014\250\251o|$wkFj\218\202\207A\242\225\180\1367\012s3l"
                                                        r21 = r14(r1, r15)
                                                        r5 = r27[r21]
                                                        state[r33] = r5
                                                        state = upvalueValues[r2]
                                                        r5 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r21 = "\222\158\246\236\031\156\011U"
                                                        r1 = 11729103829546
                                                        r14 = r27(r21, r1)
                                                        r33 = r5[r14]
                                                        r14 = "UDim2"
                                                        r27 = _env[r14]
                                                        r21 = upvalueValues[upvalues[2]]
                                                        r1 = upvalueValues[upvalues[3]]
                                                        r24 = 14426370687061
                                                        r12 = "\159\023+"
                                                        r15 = r1(r12, r24)
                                                        r14 = r21[r15]
                                                        r5 = r27[r14]
                                                        r1 = 0.5
                                                        r15 = 0
                                                        r14 = 0.5
                                                        r21 = 0
                                                        r27 = r5(r14, r21, r1, r15)
                                                        state[r33] = r27
                                                        state = upvalueValues[r2]
                                                        r5 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r1 = 32236862491542
                                                        r21 = "\159\251j\018"
                                                        r14 = r27(r21, r1)
                                                        r33 = r5[r14]
                                                        r14 = "UDim2"
                                                        r27 = _env[r14]
                                                        r21 = upvalueValues[upvalues[2]]
                                                        r1 = upvalueValues[upvalues[3]]
                                                        r24 = 2591502843252
                                                        r12 = "7Rm"
                                                        r15 = r1(r12, r24)
                                                        r14 = r21[r15]
                                                        r5 = r27[r14]
                                                        r21 = 35
                                                        r1 = 0
                                                        r14 = 0
                                                        r15 = 35
                                                        r27 = r5(r14, r21, r1, r15)
                                                        state[r33] = r27
                                                        state = upvalueValues[r2]
                                                        r5 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r1 = 24803192155281
                                                        r21 = "_\223\012\194\022\022N\138c\027\231\134)\"\015\215\144"
                                                        r14 = r27(r21, r1)
                                                        r33 = r5[r14]
                                                        r5 = 1
                                                        state[r33] = r5
                                                        r5 = "Instance"
                                                        r33 = _env[r5]
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r14 = upvalueValues[upvalues[3]]
                                                        r15 = 13742984081669
                                                        r1 = "\237_I"
                                                        r21 = r14(r1, r15)
                                                        r5 = r27[r21]
                                                        state = r33[r5]
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r14 = upvalueValues[upvalues[3]]
                                                        r15 = 30325057874419
                                                        r1 = "\128\027a\175\020\239\139\249\1786"
                                                        r21 = r14(r1, r15)
                                                        r5 = r27[r21]
                                                        r27 = upvalueValues[r34]
                                                        r33 = state(r5, r27)
                                                        r5 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r1 = 9041273319856
                                                        r21 = "\165\228R\031K\2431\244p\231\183"
                                                        r14 = r27(r21, r1)
                                                        state = r5[r14]
                                                        r14 = "Vector2"
                                                        r27 = _env[r14]
                                                        r21 = upvalueValues[upvalues[2]]
                                                        r1 = upvalueValues[upvalues[3]]
                                                        r24 = 15302374067749
                                                        r12 = "\139\002\237"
                                                        r15 = r1(r12, r24)
                                                        r14 = r21[r15]
                                                        r5 = r27[r14]
                                                        r14 = 0.5
                                                        r21 = 0.5
                                                        r27 = r5(r14, r21)
                                                        r33[state] = r27
                                                        r5 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r1 = 7849577491814
                                                        r21 = "\252\162\r\162'\169\021/kZ\226\027u\024`"
                                                        r14 = r27(r21, r1)
                                                        state = r5[r14]
                                                        r5 = false
                                                        r33[state] = r5
                                                        r5 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r1 = 1081585470825
                                                        r21 = "\186\140\1818-\213\164\017`c\"\015-\001C\190\008F\019\131\166\254"
                                                        r14 = r27(r21, r1)
                                                        state = r5[r14]
                                                        r5 = 1
                                                        r33[state] = r5
                                                        r5 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r1 = 5417405554856
                                                        r21 = "\251-\169c\226\195\142>\t\129J+\174?\209q"
                                                        r14 = r27(r21, r1)
                                                        state = r5[r14]
                                                        r5 = 1
                                                        r33[state] = r5
                                                        r5 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r1 = 24562601561147
                                                        r21 = "\141\233\252\239\187\\\209\219"
                                                        r14 = r27(r21, r1)
                                                        state = r5[r14]
                                                        r14 = "UDim2"
                                                        r27 = _env[r14]
                                                        r21 = upvalueValues[upvalues[2]]
                                                        r1 = upvalueValues[upvalues[3]]
                                                        r24 = 13420694796210
                                                        r12 = "`\155\162"
                                                        r15 = r1(r12, r24)
                                                        r14 = r21[r15]
                                                        r5 = r27[r14]
                                                        r1 = 0.5
                                                        r21 = 0
                                                        r15 = 0
                                                        r14 = 0.5
                                                        r27 = r5(r14, r21, r1, r15)
                                                        r33[state] = r27
                                                        r5 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r1 = 21968373642066
                                                        r21 = "o\196\231d"
                                                        r14 = r27(r21, r1)
                                                        state = r5[r14]
                                                        r14 = "UDim2"
                                                        r27 = _env[r14]
                                                        r21 = upvalueValues[upvalues[2]]
                                                        r1 = upvalueValues[upvalues[3]]
                                                        r24 = 10416258230873
                                                        r12 = ">k\156"
                                                        r15 = r1(r12, r24)
                                                        r14 = r21[r15]
                                                        r5 = r27[r14]
                                                        r21 = 0
                                                        r1 = 1
                                                        r14 = 1
                                                        r15 = 0
                                                        r27 = r5(r14, r21, r1, r15)
                                                        r33[state] = r27
                                                        r27 = "Instance"
                                                        r5 = _env[r27]
                                                        r14 = upvalueValues[upvalues[2]]
                                                        r21 = upvalueValues[upvalues[3]]
                                                        r12 = 25439513138491
                                                        r15 = "`\008I"
                                                        r1 = r21(r15, r12)
                                                        r27 = r14[r1]
                                                        state = r5[r27]
                                                        r14 = upvalueValues[upvalues[2]]
                                                        r21 = upvalueValues[upvalues[3]]
                                                        r15 = "a\152-\219\020"
                                                        r12 = 31103169736312
                                                        r1 = r21(r15, r12)
                                                        r27 = r14[r1]
                                                        r5 = state(r27, r25)
                                                        r27 = allocUpvalue()
                                                        upvalueValues[r27] = r5
                                                        state = upvalueValues[r27]
                                                        r14 = upvalueValues[upvalues[2]]
                                                        r21 = upvalueValues[upvalues[3]]
                                                        r15 = ")X\000\017\2490~&"
                                                        r12 = 29000145216336
                                                        r1 = r21(r15, r12)
                                                        r5 = r14[r1]
                                                        r1 = "UDim2"
                                                        r21 = _env[r1]
                                                        r15 = upvalueValues[upvalues[2]]
                                                        r12 = upvalueValues[upvalues[3]]
                                                        r16 = 26392623263779
                                                        r40 = "\201\157\188"
                                                        r24 = r12(r40, r16)
                                                        r1 = r15[r24]
                                                        r14 = r21[r1]
                                                        r24 = 0
                                                        r1 = 0.98
                                                        r12 = 0.5
                                                        r15 = 0
                                                        r21 = r14(r1, r15, r12, r24)
                                                        state[r5] = r21
                                                        state = upvalueValues[r27]
                                                        r14 = upvalueValues[upvalues[2]]
                                                        r21 = upvalueValues[upvalues[3]]
                                                        r15 = "\019}\197I\239\157\014M\171\184\015\249J\216?\029a\002\223\209(\149"
                                                        r12 = 22303407125441
                                                        r1 = r21(r15, r12)
                                                        r5 = r14[r1]
                                                        r14 = 1
                                                        state[r5] = r14
                                                        r5 = upvalueValues[upvalues[1]]
                                                        r21 = upvalueValues[upvalues[2]]
                                                        r1 = upvalueValues[upvalues[3]]
                                                        r24 = 9002566081317
                                                        r12 = "B\182\2274\028\245"
                                                        r15 = r1(r12, r24)
                                                        r14 = r21[r15]
                                                        state = r5[r14]
                                                        r5 = state()
                                                        state = r5 and 127 or 128
                                                    end
                                                end
                                            else
                                                if state == 127 then
                                                    r21 = "UDim2"
                                                    r14 = _env[r21]
                                                    r1 = upvalueValues[upvalues[2]]
                                                    r15 = upvalueValues[upvalues[3]]
                                                    r40 = 10180000325827
                                                    r24 = "j\1721"
                                                    r12 = r15(r24, r40)
                                                    r21 = r1[r12]
                                                    state = r14[r21]
                                                    r15 = 0
                                                    r12 = 500
                                                    r21 = 0
                                                    r1 = 30
                                                    r14 = state(r21, r1, r15, r12)
                                                    r5 = r14
                                                    state = 128
                                                end
                                            end
                                        else
                                            if state <= 129 then
                                                if state <= 128 then
                                                    if state == 128 then
                                                        state = not r5
                                                        state = state and 129 or 130
                                                    end
                                                else
                                                    if state == 129 then
                                                        r1 = "UDim2"
                                                        r21 = _env[r1]
                                                        r15 = upvalueValues[upvalues[2]]
                                                        r12 = upvalueValues[upvalues[3]]
                                                        r40 = "\018(\207"
                                                        r16 = 18306773396167
                                                        r24 = r12(r40, r16)
                                                        r1 = r15[r24]
                                                        state = r21[r1]
                                                        r15 = 30
                                                        r24 = 400
                                                        r12 = 0
                                                        r1 = 0
                                                        r21 = state(r1, r15, r12, r24)
                                                        r5 = r21
                                                        state = 130
                                                    end
                                                end
                                            else
                                                if state == 130 then
                                                    state = upvalueValues[r27]
                                                    r15 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r40 = "\\\134\192J"
                                                    r16 = 17153252926855
                                                    r24 = r12(r40, r16)
                                                    r1 = r15[r24]
                                                    r15 = r5
                                                    state[r1] = r15
                                                    state = upvalueValues[r27]
                                                    r15 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r40 = "3\158ab\146\\\rPM\230\250"
                                                    r16 = 18924725639089
                                                    r24 = r12(r40, r16)
                                                    r1 = r15[r24]
                                                    r24 = "Vector2"
                                                    r12 = _env[r24]
                                                    r40 = upvalueValues[upvalues[2]]
                                                    r16 = upvalueValues[upvalues[3]]
                                                    r7 = 29844447451773
                                                    r36 = "_\025s"
                                                    r23 = r16(r36, r7)
                                                    r24 = r40[r23]
                                                    r15 = r12[r24]
                                                    r24 = 0.5
                                                    r40 = 0.5
                                                    r12 = r15(r24, r40)
                                                    state[r1] = r12
                                                    r15 = "Instance"
                                                    r1 = _env[r15]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r23 = 4957308057880
                                                    r16 = "Z\027\197"
                                                    r40 = r24(r16, r23)
                                                    r15 = r12[r40]
                                                    state = r1[r15]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r16 = ")\236\143\193\011\165\019i\199\231"
                                                    r23 = 27582677839667
                                                    r40 = r24(r16, r23)
                                                    r15 = r12[r40]
                                                    r12 = upvalueValues[r27]
                                                    r1 = state(r15, r12)
                                                    r15 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r40 = ":|\011J\176\162.\131\161\016\146^"
                                                    r16 = 28308741635881
                                                    r24 = r12(r40, r16)
                                                    state = r15[r24]
                                                    r24 = "NumberSequence"
                                                    r12 = _env[r24]
                                                    r40 = upvalueValues[upvalues[2]]
                                                    r16 = upvalueValues[upvalues[3]]
                                                    r7 = 20383815965548
                                                    r36 = "\195\196\217"
                                                    r23 = r16(r36, r7)
                                                    r24 = r40[r23]
                                                    r15 = r12[r24]
                                                    r24 = 1
                                                    r40 = 0
                                                    r12 = r15(r24, r40)
                                                    r1[state] = r12
                                                    r15 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r16 = 31482032391578
                                                    r40 = "IG\182\r\240"
                                                    r24 = r12(r40, r16)
                                                    state = r15[r24]
                                                    r24 = "ColorSequence"
                                                    r12 = _env[r24]
                                                    r40 = upvalueValues[upvalues[2]]
                                                    r16 = upvalueValues[upvalues[3]]
                                                    r7 = 14947917789974
                                                    r36 = "oI\175"
                                                    r23 = r16(r36, r7)
                                                    r24 = r40[r23]
                                                    r15 = r12[r24]
                                                    r16 = "Color3"
                                                    r40 = _env[r16]
                                                    r23 = upvalueValues[upvalues[2]]
                                                    r36 = upvalueValues[upvalues[3]]
                                                    r19 = 3465324222043
                                                    r30 = "\186\140\248\238L\216d"
                                                    r7 = r36(r30, r19)
                                                    r16 = r23[r7]
                                                    r24 = r40[r16]
                                                    r16 = 0
                                                    r23 = 0
                                                    r36 = 0
                                                    r40 = {
                                                        r24(r16, r23, r36)
                                                    }
                                                    r12 = r15(unpack(r40))
                                                    r1[state] = r12
                                                    r15 = upvalueValues[upvalues[1]]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r40 = upvalueValues[upvalues[3]]
                                                    r23 = "\204\144\179hI\136\216\182\206\219\024\235\136"
                                                    r36 = 8618203900293
                                                    r16 = r40(r23, r36)
                                                    r12 = r24[r16]
                                                    state = r15[r12]
                                                    r24 = upvalueValues[r27]
                                                    r12 = 10
                                                    r15 = state(r12, r24)
                                                    r12 = "Instance"
                                                    r15 = _env[r12]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r40 = upvalueValues[upvalues[3]]
                                                    r23 = "\172W\028"
                                                    r36 = 7762603498888
                                                    r16 = r40(r23, r36)
                                                    r12 = r24[r16]
                                                    state = r15[r12]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r40 = upvalueValues[upvalues[3]]
                                                    r36 = 221974552558
                                                    r23 = "\240\n\241kjl|\174\015\008"
                                                    r16 = r40(r23, r36)
                                                    r12 = r24[r16]
                                                    r24 = upvalueValues[r27]
                                                    r15 = state(r12, r24)
                                                    r12 = allocUpvalue()
                                                    upvalueValues[r12] = r15
                                                    state = upvalueValues[r12]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r40 = upvalueValues[upvalues[3]]
                                                    r36 = 25312404521220
                                                    r23 = "^H\008\198(\149\213\\(c\215"
                                                    r16 = r40(r23, r36)
                                                    r15 = r24[r16]
                                                    r16 = "Vector2"
                                                    r40 = _env[r16]
                                                    r23 = upvalueValues[upvalues[2]]
                                                    r36 = upvalueValues[upvalues[3]]
                                                    r30 = " \000\197"
                                                    r19 = 13527307869385
                                                    r7 = r36(r30, r19)
                                                    r16 = r23[r7]
                                                    r24 = r40[r16]
                                                    r7 = 0
                                                    r36 = 0.5
                                                    r16 = 0.5
                                                    r23 = 0
                                                    r40 = r24(r16, r23, r36, r7)
                                                    state[r15] = r40
                                                    state = upvalueValues[r12]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r40 = upvalueValues[upvalues[3]]
                                                    r36 = 26514886394933
                                                    r23 = "\241\217\021n\241\030\251\253b\188sL\005\002\235\002.\246p\207\178\192"
                                                    r16 = r40(r23, r36)
                                                    r15 = r24[r16]
                                                    r24 = 1
                                                    state[r15] = r24
                                                    state = upvalueValues[r12]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r40 = upvalueValues[upvalues[3]]
                                                    r23 = "\134H\131\135\025"
                                                    r36 = 31989659779502
                                                    r16 = r40(r23, r36)
                                                    r15 = r24[r16]
                                                    r40 = upvalueValues[upvalues[2]]
                                                    r16 = upvalueValues[upvalues[3]]
                                                    r7 = 31407063332685
                                                    r36 = "1\199C6\142\167Qy\017\251\216u-\204\007\n\216\192j\200\228\166\176\220\127\136\232\236"
                                                    r23 = r16(r36, r7)
                                                    r24 = r40[r23]
                                                    state[r15] = r24
                                                    state = upvalueValues[r12]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r40 = upvalueValues[upvalues[3]]
                                                    r23 = "\127~\230X\147\220\030\148"
                                                    r36 = 11108094542000
                                                    r16 = r40(r23, r36)
                                                    r15 = r24[r16]
                                                    r16 = "UDim2"
                                                    r40 = _env[r16]
                                                    r23 = upvalueValues[upvalues[2]]
                                                    r36 = upvalueValues[upvalues[3]]
                                                    r19 = 13688535569025
                                                    r30 = "202"
                                                    r7 = r36(r30, r19)
                                                    r16 = r23[r7]
                                                    r24 = r40[r16]
                                                    r7 = 0
                                                    r23 = 0
                                                    r36 = 0.5
                                                    r16 = 0.5
                                                    r40 = r24(r16, r23, r36, r7)
                                                    state[r15] = r40
                                                    state = upvalueValues[r12]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r40 = upvalueValues[upvalues[3]]
                                                    r36 = 1413751808384
                                                    r23 = "\022\133\211J"
                                                    r16 = r40(r23, r36)
                                                    r15 = r24[r16]
                                                    r16 = "UDim2"
                                                    r40 = _env[r16]
                                                    r23 = upvalueValues[upvalues[2]]
                                                    r36 = upvalueValues[upvalues[3]]
                                                    r30 = "\180\250\142"
                                                    r19 = 22663480367587
                                                    r7 = r36(r30, r19)
                                                    r16 = r23[r7]
                                                    r24 = r40[r16]
                                                    r36 = 0
                                                    r23 = 35
                                                    r7 = 35
                                                    r16 = 0
                                                    r40 = r24(r16, r23, r36, r7)
                                                    state[r15] = r40
                                                    state = upvalueValues[r12]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r40 = upvalueValues[upvalues[3]]
                                                    r23 = "\147F:\168w\247\183CC\232\212\025?\020\029_-"
                                                    r36 = 16036759355263
                                                    r16 = r40(r23, r36)
                                                    r15 = r24[r16]
                                                    r24 = 1
                                                    state[r15] = r24
                                                    state = upvalueValues[r12]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r40 = upvalueValues[upvalues[3]]
                                                    r36 = 34150714687631
                                                    r23 = "\133\233\177\198:v\150\129"
                                                    r16 = r40(r23, r36)
                                                    r15 = r24[r16]
                                                    r24 = 180
                                                    state[r15] = r24
                                                    r24 = "Instance"
                                                    r15 = _env[r24]
                                                    r40 = upvalueValues[upvalues[2]]
                                                    r16 = upvalueValues[upvalues[3]]
                                                    r7 = 2138247462614
                                                    r36 = "\200\130\230"
                                                    r23 = r16(r36, r7)
                                                    r24 = r40[r23]
                                                    state = r15[r24]
                                                    r40 = upvalueValues[upvalues[2]]
                                                    r16 = upvalueValues[upvalues[3]]
                                                    r36 = "\231\022\tR^\248\236\005\008q"
                                                    r7 = 29512188944917
                                                    r23 = r16(r36, r7)
                                                    r24 = r40[r23]
                                                    r40 = upvalueValues[r27]
                                                    r15 = state(r24, r40)
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r40 = upvalueValues[upvalues[3]]
                                                    r23 = "\226\230XT\017wy\173\160\127+"
                                                    r36 = 9353314524221
                                                    r16 = r40(r23, r36)
                                                    state = r24[r16]
                                                    r16 = "Vector2"
                                                    r40 = _env[r16]
                                                    r23 = upvalueValues[upvalues[2]]
                                                    r36 = upvalueValues[upvalues[3]]
                                                    r30 = "\215t\230"
                                                    r19 = 7403787077611
                                                    r7 = r36(r30, r19)
                                                    r16 = r23[r7]
                                                    r24 = r40[r16]
                                                    r16 = 0.5
                                                    r23 = 0.5
                                                    r40 = r24(r16, r23)
                                                    r15[state] = r40
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r40 = upvalueValues[upvalues[3]]
                                                    r23 = "\243\166\019`&\185\204\175\209\0181\153*\129\227"
                                                    r36 = 23222693081158
                                                    r16 = r40(r23, r36)
                                                    state = r24[r16]
                                                    r24 = false
                                                    r15[state] = r24
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r40 = upvalueValues[upvalues[3]]
                                                    r23 = "\181\183\148r!\\\211\1546\198|-\005(\159\233\225\252\248\201\199P"
                                                    r36 = 3301899660872
                                                    r16 = r40(r23, r36)
                                                    state = r24[r16]
                                                    r24 = 1
                                                    r15[state] = r24
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r40 = upvalueValues[upvalues[3]]
                                                    r23 = "t+\189\0113\128jn\234<8\029\008A\156\024"
                                                    r36 = 15818593302678
                                                    r16 = r40(r23, r36)
                                                    state = r24[r16]
                                                    r24 = 1
                                                    r15[state] = r24
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r40 = upvalueValues[upvalues[3]]
                                                    r36 = 764559428709
                                                    r23 = "\208\127O\144'L\141\184"
                                                    r16 = r40(r23, r36)
                                                    state = r24[r16]
                                                    r16 = "UDim2"
                                                    r40 = _env[r16]
                                                    r23 = upvalueValues[upvalues[2]]
                                                    r36 = upvalueValues[upvalues[3]]
                                                    r19 = 34272185677772
                                                    r30 = "\133\225\142"
                                                    r7 = r36(r30, r19)
                                                    r16 = r23[r7]
                                                    r24 = r40[r16]
                                                    r23 = 0
                                                    r7 = 0
                                                    r36 = 0.5
                                                    r16 = 0.5
                                                    r40 = r24(r16, r23, r36, r7)
                                                    r15[state] = r40
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r40 = upvalueValues[upvalues[3]]
                                                    r23 = "\188[UR"
                                                    r36 = 7649803897338
                                                    r16 = r40(r23, r36)
                                                    state = r24[r16]
                                                    r16 = "UDim2"
                                                    r40 = _env[r16]
                                                    r23 = upvalueValues[upvalues[2]]
                                                    r36 = upvalueValues[upvalues[3]]
                                                    r30 = "\149\152:"
                                                    r19 = 22666364455657
                                                    r7 = r36(r30, r19)
                                                    r16 = r23[r7]
                                                    r24 = r40[r16]
                                                    r36 = 1
                                                    r23 = 0
                                                    r7 = 0
                                                    r16 = 1
                                                    r40 = r24(r16, r23, r36, r7)
                                                    r15[state] = r40
                                                    r24 = upvalueValues[r34]
                                                    r16 = upvalueValues[upvalues[2]]
                                                    r23 = upvalueValues[upvalues[3]]
                                                    r30 = 26863062395497
                                                    r7 = "\225\196\200\011+' {\219\147"
                                                    r36 = r23(r7, r30)
                                                    r40 = r16[r36]
                                                    state = r24[r40]
                                                    r40 = createClosure0(140, {
                                                        upvalues[1],
                                                        upvalues[2],
                                                        upvalues[3],
                                                        r34,
                                                        r2
                                                    })
                                                    r24 = "Connect"
                                                    r24 = state[r24]
                                                    r24 = r24(state, r40)
                                                    r24 = upvalueValues[r34]
                                                    r16 = upvalueValues[upvalues[2]]
                                                    r23 = upvalueValues[upvalues[3]]
                                                    r30 = 8784169451925
                                                    r7 = "\169\241\027S\019m#M\129_"
                                                    r36 = r23(r7, r30)
                                                    r40 = r16[r36]
                                                    state = r24[r40]
                                                    r24 = "Connect"
                                                    r24 = state[r24]
                                                    r40 = createClosure0(141, {
                                                        upvalues[1],
                                                        upvalues[2],
                                                        upvalues[3],
                                                        r34,
                                                        r2
                                                    })
                                                    r24 = r24(state, r40)
                                                    r40 = upvalueValues[upvalues[2]]
                                                    r16 = upvalueValues[upvalues[3]]
                                                    r36 = "\221\191}\024\168\238w\158\162R0\234\178\177\204S\193"
                                                    r7 = 31279469819186
                                                    r23 = r16(r36, r7)
                                                    r24 = r40[r23]
                                                    r40 = createClosure5(142, {
                                                        upvalues[4],
                                                        upvalues[2],
                                                        upvalues[3],
                                                        r31
                                                    })
                                                    state = r33[r24]
                                                    r24 = "Connect"
                                                    r24 = state[r24]
                                                    r24 = r24(state, r40)
                                                    r24 = upvalueValues[r27]
                                                    r16 = upvalueValues[upvalues[2]]
                                                    r23 = upvalueValues[upvalues[3]]
                                                    r30 = 26559635023050
                                                    r7 = "\220\151\206\198=\201\148\153\228\028"
                                                    r36 = r23(r7, r30)
                                                    r40 = r16[r36]
                                                    state = r24[r40]
                                                    r40 = createClosure2(143, {
                                                        upvalues[1],
                                                        upvalues[2],
                                                        upvalues[3],
                                                        r27,
                                                        r12
                                                    })
                                                    r24 = "Connect"
                                                    r24 = state[r24]
                                                    r24 = r24(state, r40)
                                                    r24 = upvalueValues[r27]
                                                    r16 = upvalueValues[upvalues[2]]
                                                    r23 = upvalueValues[upvalues[3]]
                                                    r7 = "\016\141\025\019\240a\156fb\170"
                                                    r30 = 16369669652769
                                                    r36 = r23(r7, r30)
                                                    r40 = r16[r36]
                                                    state = r24[r40]
                                                    r40 = createClosure5(144, {
                                                        upvalues[1],
                                                        upvalues[2],
                                                        upvalues[3],
                                                        r27,
                                                        r12
                                                    })
                                                    r24 = "Connect"
                                                    r24 = state[r24]
                                                    r24 = r24(state, r40)
                                                    r40 = upvalueValues[upvalues[2]]
                                                    r16 = upvalueValues[upvalues[3]]
                                                    r36 = "\238\020\019\024\235)o\233,sy\245\005!\196\191\159"
                                                    r7 = 15014062508180
                                                    r23 = r16(r36, r7)
                                                    r24 = r40[r23]
                                                    state = r15[r24]
                                                    r24 = state
                                                    r16 = upvalueValues[upvalues[2]]
                                                    r23 = upvalueValues[upvalues[3]]
                                                    r7 = "\250|\230)\225\149\184"
                                                    r30 = 18133571898885
                                                    r36 = r23(r7, r30)
                                                    r40 = r16[r36]
                                                    state = r24[r40]
                                                    r40 = state
                                                    r16 = createClosure0(145, {
                                                        upvalues[4],
                                                        upvalues[2],
                                                        upvalues[3],
                                                        r31
                                                    })
                                                    state = r40(r24, r16)
                                                    state = true
                                                    r16 = allocUpvalue()
                                                    upvalueValues[r16] = state
                                                    state = createClosure7(146, {
                                                        upvalues[2],
                                                        upvalues[3],
                                                        upvalues[5],
                                                        upvalues[4],
                                                        r16,
                                                        upvalues[1]
                                                    })
                                                    r36 = upvalueValues[r20]
                                                    r23 = state(r36, r25)
                                                    r36 = upvalueValues[upvalues[2]]
                                                    r7 = upvalueValues[upvalues[3]]
                                                    r3 = 13938321475364
                                                    r19 = "\194\149\222\170"
                                                    r30 = r7(r19, r3)
                                                    state = {}
                                                    r23 = r36[r30]
                                                    r36 = createClosure2(147, {
                                                        upvalues[2],
                                                        upvalues[3]
                                                    })
                                                    state[r23] = r36
                                                    r36 = upvalueValues[upvalues[2]]
                                                    r7 = upvalueValues[upvalues[3]]
                                                    r19 = "FZ{\250\tU"
                                                    r3 = 7501835690955
                                                    r30 = r7(r19, r3)
                                                    r23 = r36[r30]
                                                    r36 = createClosure5(152, {
                                                        upvalues[4],
                                                        upvalues[2],
                                                        upvalues[3],
                                                        r37,
                                                        r31,
                                                        upvalues[1],
                                                        r20
                                                    })
                                                    state = {
                                                        [r23] = r36
                                                    }
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
                                if state <= 132 then
                                    if state <= 131 then
                                        -- createClosure2 entry 8404587 -> 131, states 131-131
                                        if state == 131 then -- entry 8404587 -> 131
                                            r11 = args[1]
                                            ReturnVal = "print"
                                            state = _env[ReturnVal]
                                            ReturnVal = state(r11)
                                            r11 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    else
                                        -- createClosure1 entry 16259246 -> 132, states 132-132
                                        if state == 132 then -- entry 16259246 -> 132
                                            r11 = args[1]
                                            ReturnVal = "print"
                                            state = _env[ReturnVal]
                                            ReturnVal = state(r11)
                                            r11 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure5 entry 4672002 -> 133, states 133-133
                                    if state == 133 then -- entry 4672002 -> 133
                                        r25 = "ub4VwSVClFU3Ghp"
                                        r22 = 15476607
                                        r11 = r25 ^ r22
                                        ReturnVal = 10950807
                                        state = ReturnVal - r11
                                        r11 = state
                                        ReturnVal = "brkH4UMMjYoVqJ7"
                                        state = ReturnVal / r11
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
                    if state <= 159 then
                        if state <= 143 then
                            if state <= 140 then
                                if state <= 139 then
                                    if state <= 138 then
                                        -- createClosure5 entry 59967 -> 134, states 134-138
                                        if state <= 136 then
                                            if state <= 135 then
                                                if state <= 134 then
                                                    if state == 134 then -- entry 59967 -> 134
                                                        r25 = upvalueValues[upvalues[1]]
                                                        r22 = upvalueValues[upvalues[2]]
                                                        r11 = args[1]
                                                        r18 = ")"
                                                        r17 = 10604171189040
                                                        r26 = r22(r18, r17)
                                                        ReturnVal = r25[r26]
                                                        state = r11 == ReturnVal
                                                        r25 = state
                                                        state = r25 and 135 or 136
                                                    end
                                                else
                                                    if state == 135 then
                                                        r22 = "math"
                                                        ReturnVal = _env[r22]
                                                        r26 = upvalueValues[upvalues[1]]
                                                        r18 = upvalueValues[upvalues[2]]
                                                        r38 = "\191\166]6\163t"
                                                        r37 = 28962797268270
                                                        r17 = r18(r38, r37)
                                                        r22 = r26[r17]
                                                        state = ReturnVal[r22]
                                                        r26 = 15
                                                        r22 = 0
                                                        ReturnVal = state(r22, r26)
                                                        r25 = ReturnVal
                                                        state = 136
                                                    end
                                                end
                                            else
                                                if state == 136 then
                                                    state = not r25
                                                    state = state and 137 or 138
                                                end
                                            end
                                        else
                                            if state <= 137 then
                                                if state == 137 then
                                                    r26 = "math"
                                                    r22 = _env[r26]
                                                    r18 = upvalueValues[upvalues[1]]
                                                    r17 = upvalueValues[upvalues[2]]
                                                    r31 = 25395075174243
                                                    r37 = "\222\182\0043>\195"
                                                    r38 = r17(r37, r31)
                                                    r26 = r18[r38]
                                                    state = r22[r26]
                                                    r26 = 8
                                                    r18 = 11
                                                    r22 = state(r26, r18)
                                                    r25 = r22
                                                    state = 138
                                                end
                                            else
                                                if state == 138 then
                                                    r18 = "string"
                                                    r26 = _env[r18]
                                                    r17 = upvalueValues[upvalues[1]]
                                                    r38 = upvalueValues[upvalues[2]]
                                                    r31 = "\172\147\008\134\140-"
                                                    r39 = 22961610527074
                                                    r37 = r38(r31, r39)
                                                    r18 = r17[r37]
                                                    state = r26[r18]
                                                    r17 = upvalueValues[upvalues[1]]
                                                    r38 = upvalueValues[upvalues[2]]
                                                    r39 = 23135453385374
                                                    r31 = "\204\138"
                                                    r37 = r38(r31, r39)
                                                    r18 = r17[r37]
                                                    r26 = {
                                                        state(r18, r25)
                                                    }
                                                    ReturnVal = {
                                                        unpack(r26)
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure2 entry 13351125 -> 139, states 139-139
                                        if state == 139 then -- entry 13351125 -> 139
                                            ReturnVal = "wait"
                                            state = _env[ReturnVal]
                                            r11 = 0.5
                                            ReturnVal = state(r11)
                                            state = upvalueValues[upvalues[1]]
                                            ReturnVal = "Destroy"
                                            ReturnVal = state[ReturnVal]
                                            ReturnVal = ReturnVal(state)
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure0 entry 3046634 -> 140, states 140-140
                                    if state == 140 then -- entry 3046634 -> 140
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r25 = upvalueValues[upvalues[2]]
                                        r22 = upvalueValues[upvalues[3]]
                                        r17 = 28656514119616
                                        r18 = "^\204DL\153"
                                        r26 = r22(r18, r17)
                                        r11 = r25[r26]
                                        state = ReturnVal[r11]
                                        r11 = upvalueValues[upvalues[4]]
                                        r17 = "Enum"
                                        r18 = _env[r17]
                                        r38 = upvalueValues[upvalues[2]]
                                        r37 = upvalueValues[upvalues[3]]
                                        r39 = "\242f\237\164\130\195\141x!d "
                                        r20 = 25065426951531
                                        r31 = r37(r39, r20)
                                        r17 = r38[r31]
                                        r26 = r18[r17]
                                        r17 = upvalueValues[upvalues[2]]
                                        r38 = upvalueValues[upvalues[3]]
                                        r31 = "\232\244\249\195\215\132~\\"
                                        r39 = 17184449970082
                                        r37 = r38(r31, r39)
                                        r18 = r17[r37]
                                        r22 = r26[r18]
                                        r17 = upvalueValues[upvalues[2]]
                                        r38 = upvalueValues[upvalues[3]]
                                        r39 = 2293372758929
                                        r31 = "\210\212\136\178\134\179\203\223\185\230\248\166\238\"',b\177\201\190\192:"
                                        r37 = r38(r31, r39)
                                        r18 = r17[r37]
                                        r17 = 0
                                        r26 = {
                                            [r18] = r17
                                        }
                                        r25 = 0.25
                                        ReturnVal = state(r11, r25, r22, r26)
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r25 = upvalueValues[upvalues[2]]
                                        r22 = upvalueValues[upvalues[3]]
                                        r17 = 2820695906620
                                        r18 = "n\189C%\189"
                                        r26 = r22(r18, r17)
                                        r11 = r25[r26]
                                        state = ReturnVal[r11]
                                        r11 = upvalueValues[upvalues[5]]
                                        r17 = "Enum"
                                        r18 = _env[r17]
                                        r38 = upvalueValues[upvalues[2]]
                                        r37 = upvalueValues[upvalues[3]]
                                        r20 = 30885764644162
                                        r39 = "1@\244o\026\210\184J\184\225\214"
                                        r31 = r37(r39, r20)
                                        r17 = r38[r31]
                                        r26 = r18[r17]
                                        r17 = upvalueValues[upvalues[2]]
                                        r38 = upvalueValues[upvalues[3]]
                                        r39 = 910434160511
                                        r31 = "?\142\021\219\133\183c\252"
                                        r37 = r38(r31, r39)
                                        r18 = r17[r37]
                                        r22 = r26[r18]
                                        r17 = upvalueValues[upvalues[2]]
                                        r38 = upvalueValues[upvalues[3]]
                                        r31 = "\141=\"i\030\003\020\152\134\235\183\231(\137\197\236\195"
                                        r39 = 9317030283763
                                        r37 = r38(r31, r39)
                                        r18 = r17[r37]
                                        r17 = 0
                                        r26 = {
                                            [r18] = r17
                                        }
                                        r25 = 0.25
                                        ReturnVal = state(r11, r25, r22, r26)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                if state <= 142 then
                                    if state <= 141 then
                                        -- createClosure0 entry 12380887 -> 141, states 141-141
                                        if state == 141 then -- entry 12380887 -> 141
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r25 = upvalueValues[upvalues[2]]
                                            r22 = upvalueValues[upvalues[3]]
                                            r18 = "VUf79"
                                            r17 = 3216845461161
                                            r26 = r22(r18, r17)
                                            r11 = r25[r26]
                                            state = ReturnVal[r11]
                                            r11 = upvalueValues[upvalues[4]]
                                            r17 = "Enum"
                                            r18 = _env[r17]
                                            r38 = upvalueValues[upvalues[2]]
                                            r37 = upvalueValues[upvalues[3]]
                                            r39 = "\179\015\131\014\018M`\168\007}\007"
                                            r20 = 7586216222225
                                            r31 = r37(r39, r20)
                                            r17 = r38[r31]
                                            r26 = r18[r17]
                                            r17 = upvalueValues[upvalues[2]]
                                            r38 = upvalueValues[upvalues[3]]
                                            r39 = 27027514956922
                                            r31 = "7D\129\166\245\t\134\180"
                                            r37 = r38(r31, r39)
                                            r18 = r17[r37]
                                            r22 = r26[r18]
                                            r17 = upvalueValues[upvalues[2]]
                                            r38 = upvalueValues[upvalues[3]]
                                            r39 = 25789014280971
                                            r31 = "d|\203\216\031\243a\138\185\189\201\236S\183\173\224.-\018qbc"
                                            r37 = r38(r31, r39)
                                            r18 = r17[r37]
                                            r17 = 1
                                            r26 = {
                                                [r18] = r17
                                            }
                                            r25 = 0.25
                                            ReturnVal = state(r11, r25, r22, r26)
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r25 = upvalueValues[upvalues[2]]
                                            r22 = upvalueValues[upvalues[3]]
                                            r18 = "\019\237\012\146x"
                                            r17 = 30994177800515
                                            r26 = r22(r18, r17)
                                            r11 = r25[r26]
                                            state = ReturnVal[r11]
                                            r11 = upvalueValues[upvalues[5]]
                                            r17 = "Enum"
                                            r18 = _env[r17]
                                            r38 = upvalueValues[upvalues[2]]
                                            r37 = upvalueValues[upvalues[3]]
                                            r39 = "=\169\\\140\127N\220W\247\144\202"
                                            r20 = 33371933406884
                                            r31 = r37(r39, r20)
                                            r17 = r38[r31]
                                            r26 = r18[r17]
                                            r17 = upvalueValues[upvalues[2]]
                                            r38 = upvalueValues[upvalues[3]]
                                            r39 = 18532597215638
                                            r31 = "U\190z\004_\1508`"
                                            r37 = r38(r31, r39)
                                            r18 = r17[r37]
                                            r22 = r26[r18]
                                            r17 = upvalueValues[upvalues[2]]
                                            r38 = upvalueValues[upvalues[3]]
                                            r31 = "\171AD\239=T\029E\001>\208%B[]d\241"
                                            r39 = 14736199282855
                                            r37 = r38(r31, r39)
                                            r18 = r17[r37]
                                            r17 = 1
                                            r26 = {
                                                [r18] = r17
                                            }
                                            r25 = 0.25
                                            ReturnVal = state(r11, r25, r22, r26)
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    else
                                        -- createClosure5 entry 2628189 -> 142, states 142-142
                                        if state == 142 then -- entry 2628189 -> 142
                                            state = upvalueValues[upvalues[1]]
                                            r11 = upvalueValues[upvalues[2]]
                                            r25 = upvalueValues[upvalues[3]]
                                            r18 = 16449190807398
                                            r26 = "rd\004Z\229-\212Y\185\228\185"
                                            r22 = r25(r26, r18)
                                            ReturnVal = r11[r22]
                                            r22 = upvalueValues[upvalues[1]]
                                            r18 = upvalueValues[upvalues[2]]
                                            r17 = upvalueValues[upvalues[3]]
                                            r37 = "\245\221n+=\212\160\2407X\140"
                                            r31 = 8460031577005
                                            r38 = r17(r37, r31)
                                            r26 = r18[r38]
                                            r25 = r22[r26]
                                            r22 = 1
                                            r11 = r25 - r22
                                            state[ReturnVal] = r11
                                            state = upvalueValues[upvalues[4]]
                                            r25 = upvalueValues[upvalues[1]]
                                            r26 = upvalueValues[upvalues[2]]
                                            r18 = upvalueValues[upvalues[3]]
                                            ReturnVal = "JumpToIndex"
                                            ReturnVal = state[ReturnVal]
                                            r37 = 25036021289453
                                            r38 = "$b\008\160 `\180\172\"\197\236"
                                            r17 = r18(r38, r37)
                                            r22 = r26[r17]
                                            r11 = r25[r22]
                                            ReturnVal = ReturnVal(state, r11)
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure2 entry 8859791 -> 143, states 143-143
                                    if state == 143 then -- entry 8859791 -> 143
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r25 = upvalueValues[upvalues[2]]
                                        r22 = upvalueValues[upvalues[3]]
                                        r17 = 28398066843424
                                        r18 = ";^F\136\174"
                                        r26 = r22(r18, r17)
                                        r11 = r25[r26]
                                        state = ReturnVal[r11]
                                        r11 = upvalueValues[upvalues[4]]
                                        r17 = "Enum"
                                        r18 = _env[r17]
                                        r38 = upvalueValues[upvalues[2]]
                                        r37 = upvalueValues[upvalues[3]]
                                        r39 = "\138\006\222\014xH\132e)\233\211"
                                        r20 = 25502565599888
                                        r31 = r37(r39, r20)
                                        r17 = r38[r31]
                                        r26 = r18[r17]
                                        r17 = upvalueValues[upvalues[2]]
                                        r38 = upvalueValues[upvalues[3]]
                                        r31 = "}k\r\134p@&\025"
                                        r39 = 31486813243838
                                        r37 = r38(r31, r39)
                                        r18 = r17[r37]
                                        r22 = r26[r18]
                                        r17 = upvalueValues[upvalues[2]]
                                        r38 = upvalueValues[upvalues[3]]
                                        r31 = "\182\242\184I6!\025a\219\250\129\025\006\143`\203\179\249r(\175V"
                                        r39 = 31001067171693
                                        r37 = r38(r31, r39)
                                        r18 = r17[r37]
                                        r17 = 0
                                        r26 = {
                                            [r18] = r17
                                        }
                                        r25 = 0.25
                                        ReturnVal = state(r11, r25, r22, r26)
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r25 = upvalueValues[upvalues[2]]
                                        r22 = upvalueValues[upvalues[3]]
                                        r17 = 1539237385977
                                        r18 = "q\006H\179H"
                                        r26 = r22(r18, r17)
                                        r11 = r25[r26]
                                        state = ReturnVal[r11]
                                        r11 = upvalueValues[upvalues[5]]
                                        r17 = "Enum"
                                        r18 = _env[r17]
                                        r38 = upvalueValues[upvalues[2]]
                                        r37 = upvalueValues[upvalues[3]]
                                        r39 = "\247_8\134k\127_\001\170\249\226"
                                        r20 = 9438197999224
                                        r31 = r37(r39, r20)
                                        r17 = r38[r31]
                                        r26 = r18[r17]
                                        r17 = upvalueValues[upvalues[2]]
                                        r38 = upvalueValues[upvalues[3]]
                                        r31 = "\181\142\2270C\135\022\228"
                                        r39 = 20921992456471
                                        r37 = r38(r31, r39)
                                        r18 = r17[r37]
                                        r22 = r26[r18]
                                        r17 = upvalueValues[upvalues[2]]
                                        r38 = upvalueValues[upvalues[3]]
                                        r39 = 3999742290692
                                        r31 = "\2012\155\202\132\150\150Z\1626\222\160}\146\129f\187"
                                        r37 = r38(r31, r39)
                                        r18 = r17[r37]
                                        r17 = 0
                                        r26 = {
                                            [r18] = r17
                                        }
                                        r25 = 0.25
                                        ReturnVal = state(r11, r25, r22, r26)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 146 then
                                if state <= 145 then
                                    if state <= 144 then
                                        -- createClosure5 entry 10474709 -> 144, states 144-144
                                        if state == 144 then -- entry 10474709 -> 144
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r25 = upvalueValues[upvalues[2]]
                                            r22 = upvalueValues[upvalues[3]]
                                            r17 = 4752859788194
                                            r18 = "\150\142q\rH"
                                            r26 = r22(r18, r17)
                                            r11 = r25[r26]
                                            state = ReturnVal[r11]
                                            r11 = upvalueValues[upvalues[4]]
                                            r17 = "Enum"
                                            r18 = _env[r17]
                                            r38 = upvalueValues[upvalues[2]]
                                            r37 = upvalueValues[upvalues[3]]
                                            r20 = 8139034188288
                                            r39 = "-uT\244\173\147Cq8(\003"
                                            r31 = r37(r39, r20)
                                            r17 = r38[r31]
                                            r26 = r18[r17]
                                            r17 = upvalueValues[upvalues[2]]
                                            r38 = upvalueValues[upvalues[3]]
                                            r39 = 18331649526453
                                            r31 = "\165\251\021\142\170\022^]"
                                            r37 = r38(r31, r39)
                                            r18 = r17[r37]
                                            r22 = r26[r18]
                                            r17 = upvalueValues[upvalues[2]]
                                            r38 = upvalueValues[upvalues[3]]
                                            r31 = "\176-\214\190\198^a\179\241\127\023\133\181\144\178\2557\198\008\190}E"
                                            r39 = 24395204997433
                                            r37 = r38(r31, r39)
                                            r18 = r17[r37]
                                            r17 = 1
                                            r26 = {
                                                [r18] = r17
                                            }
                                            r25 = 0.25
                                            ReturnVal = state(r11, r25, r22, r26)
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r25 = upvalueValues[upvalues[2]]
                                            r22 = upvalueValues[upvalues[3]]
                                            r17 = 11681646794028
                                            r18 = "\164\n\195\129\202"
                                            r26 = r22(r18, r17)
                                            r11 = r25[r26]
                                            state = ReturnVal[r11]
                                            r11 = upvalueValues[upvalues[5]]
                                            r17 = "Enum"
                                            r18 = _env[r17]
                                            r38 = upvalueValues[upvalues[2]]
                                            r37 = upvalueValues[upvalues[3]]
                                            r39 = "n\2542\n\205\221\151\167\187g\205"
                                            r20 = 8841020304869
                                            r31 = r37(r39, r20)
                                            r17 = r38[r31]
                                            r26 = r18[r17]
                                            r17 = upvalueValues[upvalues[2]]
                                            r38 = upvalueValues[upvalues[3]]
                                            r31 = "\184\217\194\230\192\028\1837"
                                            r39 = 25294261383469
                                            r37 = r38(r31, r39)
                                            r18 = r17[r37]
                                            r22 = r26[r18]
                                            r17 = upvalueValues[upvalues[2]]
                                            r38 = upvalueValues[upvalues[3]]
                                            r31 = "\129>\225\216$\202\028l\227\245\135\223\198\164\255^\184"
                                            r39 = 25654076361120
                                            r37 = r38(r31, r39)
                                            r18 = r17[r37]
                                            r17 = 1
                                            r26 = {
                                                [r18] = r17
                                            }
                                            r25 = 0.25
                                            ReturnVal = state(r11, r25, r22, r26)
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    else
                                        -- createClosure0 entry 9095831 -> 145, states 145-145
                                        if state == 145 then -- entry 9095831 -> 145
                                            state = upvalueValues[upvalues[1]]
                                            r11 = upvalueValues[upvalues[2]]
                                            r25 = upvalueValues[upvalues[3]]
                                            r18 = 21544318857700
                                            r26 = "\249\004\152\209\202[\197#+\190z"
                                            r22 = r25(r26, r18)
                                            ReturnVal = r11[r22]
                                            r22 = upvalueValues[upvalues[1]]
                                            r18 = upvalueValues[upvalues[2]]
                                            r17 = upvalueValues[upvalues[3]]
                                            r37 = ";\203\187\166\242\149\246\219\187;\229"
                                            r31 = 3915304673903
                                            r38 = r17(r37, r31)
                                            r26 = r18[r38]
                                            r25 = r22[r26]
                                            r22 = 1
                                            r11 = r25 + r22
                                            state[ReturnVal] = r11
                                            state = upvalueValues[upvalues[4]]
                                            r25 = upvalueValues[upvalues[1]]
                                            ReturnVal = "JumpToIndex"
                                            ReturnVal = state[ReturnVal]
                                            r26 = upvalueValues[upvalues[2]]
                                            r18 = upvalueValues[upvalues[3]]
                                            r38 = "\015\026\248\231\232\222p\243\014\239y"
                                            r37 = 10055104065574
                                            r17 = r18(r38, r37)
                                            r22 = r26[r17]
                                            r11 = r25[r22]
                                            ReturnVal = ReturnVal(state, r11)
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure7 entry 14025232 -> 146, states 146-146
                                    if state == 146 then -- entry 14025232 -> 146
                                        r18 = allocUpvalue()
                                        r11 = args[1]
                                        r25 = allocUpvalue()
                                        r22 = allocUpvalue()
                                        r26 = allocUpvalue()
                                        state = nil
                                        upvalueValues[r25] = args[2]
                                        upvalueValues[r22] = state
                                        state = nil
                                        r17 = allocUpvalue()
                                        upvalueValues[r26] = state
                                        state = nil
                                        upvalueValues[r18] = state
                                        state = nil
                                        upvalueValues[r17] = state
                                        r38 = upvalueValues[upvalues[1]]
                                        r37 = upvalueValues[upvalues[2]]
                                        r39 = "\137\030\194\016<p\226\145\2547"
                                        r20 = 1712812532398
                                        r31 = r37(r39, r20)
                                        ReturnVal = r38[r31]
                                        state = r11[ReturnVal]
                                        r38 = createClosure4(157, {
                                            upvalues[1],
                                            upvalues[2],
                                            r22,
                                            r18,
                                            r25,
                                            r17
                                        })
                                        ReturnVal = "Connect"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state, r38)
                                        r38 = upvalueValues[upvalues[1]]
                                        r37 = upvalueValues[upvalues[2]]
                                        r39 = "}V|\207\218\171\020\150\164T\217'"
                                        r20 = 26450287924992
                                        r31 = r37(r39, r20)
                                        ReturnVal = r38[r31]
                                        state = r11[ReturnVal]
                                        r38 = createClosure3(160, {
                                            upvalues[1],
                                            upvalues[2],
                                            r26
                                        })
                                        ReturnVal = "Connect"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state, r38)
                                        ReturnVal = upvalueValues[upvalues[3]]
                                        r37 = upvalueValues[upvalues[1]]
                                        r31 = upvalueValues[upvalues[2]]
                                        r34 = 19290002448900
                                        r20 = "\236\\\193[\194\2209]S\193\225#"
                                        r39 = r31(r20, r34)
                                        r38 = r37[r39]
                                        state = ReturnVal[r38]
                                        r38 = createClosure3(163, {
                                            r26,
                                            r22,
                                            upvalues[4],
                                            upvalues[1],
                                            upvalues[2],
                                            r18,
                                            upvalues[5],
                                            upvalues[6],
                                            r25,
                                            r17
                                        })
                                        ReturnVal = "Connect"
                                        ReturnVal = state[ReturnVal]
                                        r17 = releaseUpvalue(r17)
                                        r22 = releaseUpvalue(r22)
                                        r25 = releaseUpvalue(r25)
                                        ReturnVal = ReturnVal(state, r38)
                                        r26 = releaseUpvalue(r26)
                                        r18 = releaseUpvalue(r18)
                                        r11 = nil
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                if state <= 156 then
                                    if state <= 151 then
                                        -- createClosure2 entry 10669831 -> 147, states 147-151
                                        if state <= 149 then
                                            if state <= 148 then
                                                if state <= 147 then
                                                    if state == 147 then -- entry 10669831 -> 147
                                                        r11 = args[1]
                                                        r22 = upvalueValues[upvalues[1]]
                                                        r26 = upvalueValues[upvalues[2]]
                                                        r17 = "\014\214\007\225N"
                                                        r38 = 19390658021326
                                                        r18 = r26(r17, r38)
                                                        r25 = r22[r18]
                                                        ReturnVal = r11[r25]
                                                        state = not ReturnVal
                                                        state = state and 148 or 149
                                                    end
                                                else
                                                    if state == 148 then
                                                        state = 149
                                                    end
                                                end
                                            else
                                                if state == 149 then
                                                    r22 = upvalueValues[upvalues[1]]
                                                    r26 = upvalueValues[upvalues[2]]
                                                    r17 = "\198\134\027r"
                                                    r38 = 1536477813765
                                                    r18 = r26(r17, r38)
                                                    r25 = r22[r18]
                                                    ReturnVal = r11[r25]
                                                    state = not ReturnVal
                                                    state = state and 150 or 151
                                                end
                                            end
                                        else
                                            if state <= 150 then
                                                if state == 150 then
                                                    state = 151
                                                end
                                            else
                                                if state == 151 then
                                                    r11 = nil
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure5 entry 13852301 -> 152, states 152-156
                                        if state <= 154 then
                                            if state <= 153 then
                                                if state <= 152 then
                                                    if state == 152 then -- entry 13852301 -> 152
                                                        state = upvalueValues[upvalues[1]]
                                                        r11 = upvalueValues[upvalues[2]]
                                                        r25 = upvalueValues[upvalues[3]]
                                                        r26 = "\169=\247&\213"
                                                        r18 = 26159242177988
                                                        r22 = r25(r26, r18)
                                                        ReturnVal = r11[r22]
                                                        r22 = upvalueValues[upvalues[1]]
                                                        r18 = upvalueValues[upvalues[2]]
                                                        r17 = upvalueValues[upvalues[3]]
                                                        r37 = "\223X\223(d"
                                                        r31 = 19779277912185
                                                        r38 = r17(r37, r31)
                                                        r26 = r18[r38]
                                                        r25 = r22[r26]
                                                        r22 = 1
                                                        r11 = r25 + r22
                                                        state[ReturnVal] = r11
                                                        r11 = "Random"
                                                        ReturnVal = _env[r11]
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r22 = upvalueValues[upvalues[3]]
                                                        r17 = 19717313666024
                                                        r18 = "\240}\206"
                                                        r26 = r22(r18, r17)
                                                        r11 = r25[r26]
                                                        state = ReturnVal[r11]
                                                        ReturnVal = state()
                                                        state = "NextInteger"
                                                        state = ReturnVal[state]
                                                        r25 = 999999
                                                        r11 = 1
                                                        state = state(ReturnVal, r11, r25)
                                                        r11 = state
                                                        r25 = "Instance"
                                                        ReturnVal = _env[r25]
                                                        r22 = upvalueValues[upvalues[2]]
                                                        r26 = upvalueValues[upvalues[3]]
                                                        r38 = 10098079117046
                                                        r17 = "\239\025\t"
                                                        r18 = r26(r17, r38)
                                                        r25 = r22[r18]
                                                        state = ReturnVal[r25]
                                                        r22 = upvalueValues[upvalues[2]]
                                                        r26 = upvalueValues[upvalues[3]]
                                                        r38 = 3968843808272
                                                        r17 = "B\146cj\217\021\130\186\148\255X\2348\243"
                                                        r18 = r26(r17, r38)
                                                        r25 = r22[r18]
                                                        r22 = upvalueValues[upvalues[4]]
                                                        ReturnVal = state(r25, r22)
                                                        r25 = allocUpvalue()
                                                        upvalueValues[r25] = ReturnVal
                                                        state = upvalueValues[r25]
                                                        r22 = upvalueValues[upvalues[2]]
                                                        r26 = upvalueValues[upvalues[3]]
                                                        r38 = 899888912249
                                                        r17 = "\179v\172C\r\180\028\252\186\1361\180u*xIp\188+\247\220N"
                                                        r18 = r26(r17, r38)
                                                        ReturnVal = r22[r18]
                                                        r22 = 1
                                                        state[ReturnVal] = r22
                                                        state = upvalueValues[r25]
                                                        r22 = upvalueValues[upvalues[2]]
                                                        r26 = upvalueValues[upvalues[3]]
                                                        r17 = "\239\153of"
                                                        r38 = 8165446608751
                                                        r18 = r26(r17, r38)
                                                        ReturnVal = r22[r18]
                                                        r18 = "UDim2"
                                                        r26 = _env[r18]
                                                        r17 = upvalueValues[upvalues[2]]
                                                        r38 = upvalueValues[upvalues[3]]
                                                        r31 = "\188Y\218"
                                                        r39 = 28071943690644
                                                        r37 = r38(r31, r39)
                                                        r18 = r17[r37]
                                                        r22 = r26[r18]
                                                        r38 = 1
                                                        r18 = 1
                                                        r37 = 0
                                                        r17 = 0
                                                        r26 = r22(r18, r17, r38, r37)
                                                        state[ReturnVal] = r26
                                                        state = upvalueValues[r25]
                                                        r22 = upvalueValues[upvalues[2]]
                                                        r26 = upvalueValues[upvalues[3]]
                                                        r38 = 3812257664171
                                                        r17 = "\246\196c8!\232\158\165\003\149"
                                                        r18 = r26(r17, r38)
                                                        ReturnVal = r22[r18]
                                                        r18 = "UDim2"
                                                        r26 = _env[r18]
                                                        r17 = upvalueValues[upvalues[2]]
                                                        r38 = upvalueValues[upvalues[3]]
                                                        r39 = 11671479430221
                                                        r31 = "9[s"
                                                        r37 = r38(r31, r39)
                                                        r18 = r17[r37]
                                                        r22 = r26[r18]
                                                        r38 = 0
                                                        r18 = 0
                                                        r37 = 0
                                                        r17 = 0
                                                        r26 = r22(r18, r17, r38, r37)
                                                        state[ReturnVal] = r26
                                                        state = upvalueValues[r25]
                                                        r22 = upvalueValues[upvalues[2]]
                                                        r26 = upvalueValues[upvalues[3]]
                                                        r38 = 21380980117929
                                                        r17 = ">\131\005\t\158\194e\249\019\241\150\227\240\026\1936I\211"
                                                        r18 = r26(r17, r38)
                                                        ReturnVal = r22[r18]
                                                        r22 = 3
                                                        state[ReturnVal] = r22
                                                        state = upvalueValues[r25]
                                                        r22 = upvalueValues[upvalues[2]]
                                                        r26 = upvalueValues[upvalues[3]]
                                                        r17 = "\207\007s\212v\140\234\165@\134W"
                                                        r38 = 18048898656584
                                                        r18 = r26(r17, r38)
                                                        ReturnVal = r22[r18]
                                                        r26 = upvalueValues[upvalues[1]]
                                                        r17 = upvalueValues[upvalues[2]]
                                                        r38 = upvalueValues[upvalues[3]]
                                                        r39 = 25495403320129
                                                        r31 = "}\244\201\016\t"
                                                        r37 = r38(r31, r39)
                                                        r18 = r17[r37]
                                                        r22 = r26[r18]
                                                        state[ReturnVal] = r22
                                                        state = upvalueValues[r25]
                                                        r22 = upvalueValues[upvalues[2]]
                                                        r26 = upvalueValues[upvalues[3]]
                                                        r38 = 22012616937856
                                                        r17 = "\172m5I"
                                                        r18 = r26(r17, r38)
                                                        ReturnVal = r22[r18]
                                                        r18 = upvalueValues[upvalues[2]]
                                                        r17 = upvalueValues[upvalues[3]]
                                                        r37 = "Vd\196_\151\134\191P\181\166\197"
                                                        r31 = 18111156458058
                                                        r38 = r17(r37, r31)
                                                        r26 = r18[r38]
                                                        r22 = r26 .. r11
                                                        state[ReturnVal] = r22
                                                        r22 = "Instance"
                                                        ReturnVal = _env[r22]
                                                        r26 = upvalueValues[upvalues[2]]
                                                        r18 = upvalueValues[upvalues[3]]
                                                        r38 = "\153B\147"
                                                        r37 = 6672976040311
                                                        r17 = r18(r38, r37)
                                                        r22 = r26[r17]
                                                        state = ReturnVal[r22]
                                                        r26 = upvalueValues[upvalues[2]]
                                                        r18 = upvalueValues[upvalues[3]]
                                                        r37 = 17564505225113
                                                        r38 = "\210\n\020\207[P\219\004\187X\001x"
                                                        r17 = r18(r38, r37)
                                                        r22 = r26[r17]
                                                        r26 = upvalueValues[r25]
                                                        ReturnVal = state(r22, r26)
                                                        r22 = ReturnVal
                                                        ReturnVal = upvalueValues[upvalues[2]]
                                                        r26 = upvalueValues[upvalues[3]]
                                                        r17 = "\231\153\232B\133\231W\169"
                                                        r38 = 3071638035374
                                                        r18 = r26(r17, r38)
                                                        state = ReturnVal[r18]
                                                        r18 = "UDim2"
                                                        r26 = _env[r18]
                                                        r17 = upvalueValues[upvalues[2]]
                                                        r38 = upvalueValues[upvalues[3]]
                                                        r39 = 2334522962321
                                                        r31 = "\008\000\133"
                                                        r37 = r38(r31, r39)
                                                        r18 = r17[r37]
                                                        ReturnVal = r26[r18]
                                                        r38 = 0
                                                        r17 = 155
                                                        r18 = 0
                                                        r37 = 100
                                                        r26 = ReturnVal(r18, r17, r38, r37)
                                                        r22[state] = r26
                                                        ReturnVal = upvalueValues[upvalues[2]]
                                                        r26 = upvalueValues[upvalues[3]]
                                                        r17 = "\1991T]\178\021\200V\253\137\217"
                                                        r38 = 232561750823
                                                        r18 = r26(r17, r38)
                                                        state = ReturnVal[r18]
                                                        r18 = "UDim2"
                                                        r26 = _env[r18]
                                                        r17 = upvalueValues[upvalues[2]]
                                                        r38 = upvalueValues[upvalues[3]]
                                                        r31 = "\175%\151"
                                                        r39 = 2307356045793
                                                        r37 = r38(r31, r39)
                                                        r18 = r17[r37]
                                                        ReturnVal = r26[r18]
                                                        r37 = 15
                                                        r18 = 0
                                                        r17 = 15
                                                        r38 = 0
                                                        r26 = ReturnVal(r18, r17, r38, r37)
                                                        r22[state] = r26
                                                        ReturnVal = upvalueValues[upvalues[2]]
                                                        r26 = upvalueValues[upvalues[3]]
                                                        r38 = 30064527316637
                                                        r17 = "\023^\241\1943<Uq&\023F\139*"
                                                        r18 = r26(r17, r38)
                                                        state = ReturnVal[r18]
                                                        r17 = "Enum"
                                                        r18 = _env[r17]
                                                        r38 = upvalueValues[upvalues[2]]
                                                        r37 = upvalueValues[upvalues[3]]
                                                        r20 = 16223678132938
                                                        r39 = "\179\192\176\224\195w\137[1\186\030:\139"
                                                        r31 = r37(r39, r20)
                                                        r17 = r38[r31]
                                                        r26 = r18[r17]
                                                        r17 = upvalueValues[upvalues[2]]
                                                        r38 = upvalueValues[upvalues[3]]
                                                        r39 = 19379884155546
                                                        r31 = "Z.u\196?\020\181i\028\133"
                                                        r37 = r38(r31, r39)
                                                        r18 = r17[r37]
                                                        ReturnVal = r26[r18]
                                                        r22[state] = ReturnVal
                                                        r26 = "Instance"
                                                        ReturnVal = _env[r26]
                                                        r18 = upvalueValues[upvalues[2]]
                                                        r17 = upvalueValues[upvalues[3]]
                                                        r37 = "\007\241\133"
                                                        r31 = 5572672952564
                                                        r38 = r17(r37, r31)
                                                        r26 = r18[r38]
                                                        state = ReturnVal[r26]
                                                        r18 = upvalueValues[upvalues[2]]
                                                        r17 = upvalueValues[upvalues[3]]
                                                        r37 = "\224n\227\247/\017_\024("
                                                        r31 = 14530231336246
                                                        r38 = r17(r37, r31)
                                                        r26 = r18[r38]
                                                        r18 = upvalueValues[r25]
                                                        ReturnVal = state(r26, r18)
                                                        r26 = upvalueValues[upvalues[2]]
                                                        r18 = upvalueValues[upvalues[3]]
                                                        r38 = "L.7-e'@\237|S"
                                                        r37 = 11330034630495
                                                        r17 = r18(r38, r37)
                                                        state = r26[r17]
                                                        r17 = "UDim"
                                                        r18 = _env[r17]
                                                        r38 = upvalueValues[upvalues[2]]
                                                        r37 = upvalueValues[upvalues[3]]
                                                        r39 = "\223\180\128"
                                                        r20 = 13996862895498
                                                        r31 = r37(r39, r20)
                                                        r17 = r38[r31]
                                                        r26 = r18[r17]
                                                        r38 = 15
                                                        r17 = 0
                                                        r18 = r26(r17, r38)
                                                        ReturnVal[state] = r18
                                                        ReturnVal = upvalueValues[upvalues[1]]
                                                        r18 = upvalueValues[upvalues[2]]
                                                        r17 = upvalueValues[upvalues[3]]
                                                        r37 = "\1541\020\218\135\238W\021\206\184\204\219\181\141"
                                                        r31 = 20120163827748
                                                        r38 = r17(r37, r31)
                                                        r26 = r18[r38]
                                                        state = ReturnVal[r26]
                                                        state = state and 153 or 154
                                                    end
                                                else
                                                    if state == 153 then
                                                        state = upvalueValues[upvalues[1]]
                                                        r26 = upvalueValues[upvalues[2]]
                                                        r18 = upvalueValues[upvalues[3]]
                                                        r37 = 19377562555139
                                                        r38 = "E\031\250\183\200p\221l\144\174\011\158\232\005"
                                                        r17 = r18(r38, r37)
                                                        ReturnVal = r26[r17]
                                                        r26 = false
                                                        state[ReturnVal] = r26
                                                        state = upvalueValues[upvalues[1]]
                                                        r26 = upvalueValues[upvalues[2]]
                                                        r18 = upvalueValues[upvalues[3]]
                                                        r37 = 31006847823265
                                                        r38 = "`\200[uo\030@\183 \184\014"
                                                        r17 = r18(r38, r37)
                                                        ReturnVal = r26[r17]
                                                        r18 = upvalueValues[upvalues[1]]
                                                        r38 = upvalueValues[upvalues[2]]
                                                        r37 = upvalueValues[upvalues[3]]
                                                        r20 = 31971265917630
                                                        r39 = "\0025\137\202%"
                                                        r31 = r37(r39, r20)
                                                        r17 = r38[r31]
                                                        r26 = r18[r17]
                                                        state[ReturnVal] = r26
                                                        r26 = upvalueValues[r25]
                                                        r17 = upvalueValues[upvalues[2]]
                                                        r38 = upvalueValues[upvalues[3]]
                                                        r31 = "\219b\140m"
                                                        r39 = 7519385395258
                                                        r37 = r38(r31, r39)
                                                        r18 = r17[r37]
                                                        ReturnVal = r26[r18]
                                                        r18 = "tostring"
                                                        r26 = _env[r18]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r31 = upvalueValues[upvalues[3]]
                                                        r34 = 11076683091612
                                                        r20 = "\n\130Y-\2069\138\228\240P+"
                                                        r39 = r31(r20, r34)
                                                        r38 = r37[r39]
                                                        r17 = r38 .. r11
                                                        r18 = r26(r17)
                                                        state = ReturnVal == r18
                                                        state = state and 155 or 156
                                                    end
                                                end
                                            else
                                                if state == 154 then
                                                    r26 = upvalueValues[upvalues[2]]
                                                    r18 = upvalueValues[upvalues[3]]
                                                    r37 = 29198454324453
                                                    r38 = "\171\206\1331\229\129"
                                                    r17 = r18(r38, r37)
                                                    ReturnVal = r26[r17]
                                                    r26 = createClosure7(176, {
                                                        upvalues[2],
                                                        upvalues[3],
                                                        r25,
                                                        upvalues[6],
                                                        upvalues[7]
                                                    })
                                                    state = {
                                                        [ReturnVal] = r26
                                                    }
                                                    ReturnVal = {
                                                        state
                                                    }
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state <= 155 then
                                                if state == 155 then
                                                    state = upvalueValues[upvalues[5]]
                                                    r18 = upvalueValues[r25]
                                                    r38 = upvalueValues[upvalues[2]]
                                                    r37 = upvalueValues[upvalues[3]]
                                                    r20 = 13998758971850
                                                    r39 = "D\240\177\162+\005b\025\030\237%"
                                                    r31 = r37(r39, r20)
                                                    ReturnVal = "JumpToIndex"
                                                    ReturnVal = state[ReturnVal]
                                                    r17 = r38[r31]
                                                    r26 = r18[r17]
                                                    ReturnVal = ReturnVal(state, r26)
                                                    state = 156
                                                end
                                            else
                                                if state == 156 then
                                                    state = 154
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure4 entry 14363842 -> 157, states 157-159
                                    if state <= 158 then
                                        if state <= 157 then
                                            if state == 157 then -- entry 14363842 -> 157
                                                r11 = allocUpvalue()
                                                upvalueValues[r11] = args[1]
                                                r25 = upvalueValues[r11]
                                                r26 = upvalueValues[upvalues[1]]
                                                r18 = upvalueValues[upvalues[2]]
                                                r37 = 9872028792256
                                                r38 = "\164I\022\2504Y<Q0_\220\023\195"
                                                r17 = r18(r38, r37)
                                                r22 = r26[r17]
                                                ReturnVal = r25[r22]
                                                r18 = "Enum"
                                                r26 = _env[r18]
                                                r17 = upvalueValues[upvalues[1]]
                                                r38 = upvalueValues[upvalues[2]]
                                                r39 = 7392151924782
                                                r31 = "\169\2331K\172\199\220\220\029\146\2539r"
                                                r37 = r38(r31, r39)
                                                r18 = r17[r37]
                                                r22 = r26[r18]
                                                r18 = upvalueValues[upvalues[1]]
                                                r17 = upvalueValues[upvalues[2]]
                                                r37 = "\186\t\167\rH_\135\1789\n\171~"
                                                r31 = 28505780072339
                                                r38 = r17(r37, r31)
                                                r26 = r18[r38]
                                                r25 = r22[r26]
                                                state = ReturnVal == r25
                                                state = state and 158 or 159
                                            end
                                        else
                                            if state == 158 then
                                                state = true
                                                upvalueValues[upvalues[3]] = state
                                                r25 = upvalueValues[r11]
                                                r26 = upvalueValues[upvalues[1]]
                                                r18 = upvalueValues[upvalues[2]]
                                                r37 = 17521616938729
                                                r38 = "B\021s-\141\003\224\220"
                                                r17 = r18(r38, r37)
                                                r22 = r26[r17]
                                                ReturnVal = r25[r22]
                                                upvalueValues[upvalues[4]] = ReturnVal
                                                r22 = upvalueValues[upvalues[5]]
                                                r18 = upvalueValues[upvalues[1]]
                                                r17 = upvalueValues[upvalues[2]]
                                                r37 = "\179\214\141W\008\200\027\012"
                                                r31 = 12254612824211
                                                r38 = r17(r37, r31)
                                                r26 = r18[r38]
                                                r25 = r22[r26]
                                                upvalueValues[upvalues[6]] = r25
                                                r26 = upvalueValues[r11]
                                                r17 = upvalueValues[upvalues[1]]
                                                r38 = upvalueValues[upvalues[2]]
                                                r39 = 25303907397426
                                                r31 = "\026\138\201\252N\1566"
                                                r37 = r38(r31, r39)
                                                r18 = r17[r37]
                                                r22 = r26[r18]
                                                r18 = createClosure3(187, {
                                                    r11,
                                                    upvalues[1],
                                                    upvalues[2],
                                                    upvalues[3]
                                                })
                                                r26 = "Connect"
                                                r26 = r22[r26]
                                                r26 = r26(r22, r18)
                                                state = 159
                                            end
                                        end
                                    else
                                        if state == 159 then
                                            ReturnVal = {}
                                            r11 = releaseUpvalue(r11)
                                            state = nil
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 199 then
                            if state <= 186 then
                                if state <= 175 then
                                    if state <= 162 then
                                        -- createClosure3 entry 13964610 -> 160, states 160-162
                                        if state <= 161 then
                                            if state <= 160 then
                                                if state == 160 then -- entry 13964610 -> 160
                                                    r11 = args[1]
                                                    r22 = upvalueValues[upvalues[1]]
                                                    r26 = upvalueValues[upvalues[2]]
                                                    r17 = "\236\019\000W\172%\182\021\n\165\022\029\191"
                                                    r38 = 17194271089840
                                                    r18 = r26(r17, r38)
                                                    r25 = r22[r18]
                                                    ReturnVal = r11[r25]
                                                    r18 = "Enum"
                                                    r26 = _env[r18]
                                                    r17 = upvalueValues[upvalues[1]]
                                                    r38 = upvalueValues[upvalues[2]]
                                                    r39 = 30973432418582
                                                    r31 = "\135A\"q\194i\149\201\173=\173\\\178"
                                                    r37 = r38(r31, r39)
                                                    r18 = r17[r37]
                                                    r22 = r26[r18]
                                                    r18 = upvalueValues[upvalues[1]]
                                                    r17 = upvalueValues[upvalues[2]]
                                                    r31 = 23636833853433
                                                    r37 = "\217\157hc\215\182\027\195!\198\"sY"
                                                    r38 = r17(r37, r31)
                                                    r26 = r18[r38]
                                                    r25 = r22[r26]
                                                    state = ReturnVal == r25
                                                    state = state and 161 or 162
                                                end
                                            else
                                                if state == 161 then
                                                    state = r11
                                                    upvalueValues[upvalues[3]] = state
                                                    state = 162
                                                end
                                            end
                                        else
                                            if state == 162 then
                                                r11 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        -- createClosure3 entry 5340036 -> 163, states 163-175
                                        if state <= 169 then
                                            if state <= 166 then
                                                if state <= 164 then
                                                    if state <= 163 then
                                                        if state == 163 then -- entry 5340036 -> 163
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r11 = args[1]
                                                            state = r11 == ReturnVal
                                                            r25 = state
                                                            state = r25 and 164 or 165
                                                        end
                                                    else
                                                        if state == 164 then
                                                            state = upvalueValues[upvalues[2]]
                                                            r25 = state
                                                            state = r25 and 166 or 167
                                                        end
                                                    end
                                                else
                                                    if state <= 165 then
                                                        if state == 165 then
                                                            state = r25 and 168 or 169
                                                        end
                                                    else
                                                        if state == 166 then
                                                            r26 = upvalueValues[upvalues[3]]
                                                            r17 = upvalueValues[upvalues[4]]
                                                            r38 = upvalueValues[upvalues[5]]
                                                            r39 = 16580592789
                                                            r31 = "X~\196\197\n\135\014\019"
                                                            r37 = r38(r31, r39)
                                                            r18 = r17[r37]
                                                            r22 = r26[r18]
                                                            ReturnVal = not r22
                                                            r25 = ReturnVal
                                                            state = 167
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 168 then
                                                    if state <= 167 then
                                                        if state == 167 then
                                                            state = 165
                                                        end
                                                    else
                                                        if state == 168 then
                                                            r17 = upvalueValues[upvalues[4]]
                                                            r38 = upvalueValues[upvalues[5]]
                                                            r31 = "\180\214,\200\129O\209l"
                                                            r39 = 24954774704902
                                                            r37 = r38(r31, r39)
                                                            r18 = r17[r37]
                                                            r26 = r11[r18]
                                                            r18 = upvalueValues[upvalues[6]]
                                                            r22 = r26 - r18
                                                            r18 = state
                                                            r17 = true
                                                            state = r17 and 170 or 171
                                                            r26 = r17
                                                        end
                                                    end
                                                else
                                                    if state == 169 then
                                                        r11 = nil
                                                        r25 = nil
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 172 then
                                                if state <= 171 then
                                                    if state <= 170 then
                                                        if state == 170 then
                                                            r17 = upvalueValues[upvalues[7]]
                                                            r26 = r17
                                                            state = 171
                                                        end
                                                    else
                                                        if state == 171 then
                                                            state = r18
                                                            state = r26 and 172 or 173
                                                        end
                                                    end
                                                else
                                                    if state == 172 then
                                                        r18 = upvalueValues[upvalues[8]]
                                                        r38 = upvalueValues[upvalues[4]]
                                                        r37 = upvalueValues[upvalues[5]]
                                                        r20 = 34753295947657
                                                        r39 = "C7\243-\233"
                                                        r31 = r37(r39, r20)
                                                        r17 = r38[r31]
                                                        r26 = r18[r17]
                                                        r17 = upvalueValues[upvalues[9]]
                                                        r20 = "Enum"
                                                        r39 = _env[r20]
                                                        r34 = upvalueValues[upvalues[4]]
                                                        r35 = upvalueValues[upvalues[5]]
                                                        r33 = 9400258985630
                                                        r29 = "\184+\146\015hZD~\175[U"
                                                        r32 = r35(r29, r33)
                                                        r20 = r34[r32]
                                                        r31 = r39[r20]
                                                        r20 = upvalueValues[upvalues[4]]
                                                        r34 = upvalueValues[upvalues[5]]
                                                        r29 = 9794779855575
                                                        r32 = ".\221\244="
                                                        r35 = r34(r32, r29)
                                                        r39 = r20[r35]
                                                        r37 = r31[r39]
                                                        r20 = upvalueValues[upvalues[4]]
                                                        r34 = upvalueValues[upvalues[5]]
                                                        r32 = "\235F\198b\165\163\209\154"
                                                        r29 = 13743551211999
                                                        r35 = r34(r32, r29)
                                                        r39 = r20[r35]
                                                        r35 = "UDim2"
                                                        r34 = _env[r35]
                                                        r32 = upvalueValues[upvalues[4]]
                                                        r29 = upvalueValues[upvalues[5]]
                                                        r5 = 10478868952012
                                                        r2 = "\142\191\202"
                                                        r33 = r29(r2, r5)
                                                        r35 = r32[r33]
                                                        r20 = r34[r35]
                                                        r29 = upvalueValues[upvalues[10]]
                                                        r2 = upvalueValues[upvalues[4]]
                                                        r5 = upvalueValues[upvalues[5]]
                                                        r14 = "\253"
                                                        r21 = 15432565882661
                                                        r27 = r5(r14, r21)
                                                        r33 = r2[r27]
                                                        r32 = r29[r33]
                                                        r33 = upvalueValues[upvalues[4]]
                                                        r2 = upvalueValues[upvalues[5]]
                                                        r27 = "9\151\131=v"
                                                        r14 = 20264807419342
                                                        r5 = r2(r27, r14)
                                                        r29 = r33[r5]
                                                        r35 = r32[r29]
                                                        r2 = upvalueValues[upvalues[10]]
                                                        r27 = upvalueValues[upvalues[4]]
                                                        r14 = upvalueValues[upvalues[5]]
                                                        r1 = "\169"
                                                        r15 = 23299759070042
                                                        r21 = r14(r1, r15)
                                                        r5 = r27[r21]
                                                        r33 = r2[r5]
                                                        r5 = upvalueValues[upvalues[4]]
                                                        r27 = upvalueValues[upvalues[5]]
                                                        r1 = 1999210900607
                                                        r21 = "@\003\171s\017\007"
                                                        r14 = r27(r21, r1)
                                                        r2 = r5[r14]
                                                        r29 = r33[r2]
                                                        r5 = upvalueValues[upvalues[4]]
                                                        r27 = upvalueValues[upvalues[5]]
                                                        r1 = 12713977174780
                                                        r21 = "\027"
                                                        r14 = r27(r21, r1)
                                                        r2 = r5[r14]
                                                        r33 = r22[r2]
                                                        r32 = r29 + r33
                                                        r2 = upvalueValues[upvalues[10]]
                                                        r27 = upvalueValues[upvalues[4]]
                                                        r14 = upvalueValues[upvalues[5]]
                                                        r15 = 8382085296935
                                                        r1 = "k"
                                                        r21 = r14(r1, r15)
                                                        r5 = r27[r21]
                                                        r33 = r2[r5]
                                                        r5 = upvalueValues[upvalues[4]]
                                                        r27 = upvalueValues[upvalues[5]]
                                                        ReturnVal = {}
                                                        r21 = "?\223\250\005\247"
                                                        r1 = 34815139210414
                                                        r14 = r27(r21, r1)
                                                        r2 = r5[r14]
                                                        r29 = r33[r2]
                                                        r27 = upvalueValues[upvalues[10]]
                                                        r21 = upvalueValues[upvalues[4]]
                                                        r1 = upvalueValues[upvalues[5]]
                                                        r24 = 25025071417317
                                                        r12 = " "
                                                        r15 = r1(r12, r24)
                                                        r14 = r21[r15]
                                                        r5 = r27[r14]
                                                        r14 = upvalueValues[upvalues[4]]
                                                        r21 = upvalueValues[upvalues[5]]
                                                        r12 = 20206397325224
                                                        r15 = "\138\169\129\127\220\237"
                                                        r1 = r21(r15, r12)
                                                        r27 = r14[r1]
                                                        r2 = r5[r27]
                                                        r14 = upvalueValues[upvalues[4]]
                                                        r21 = upvalueValues[upvalues[5]]
                                                        r12 = 5430980246878
                                                        r15 = "\157"
                                                        r1 = r21(r15, r12)
                                                        r27 = r14[r1]
                                                        r5 = r22[r27]
                                                        r33 = r2 + r5
                                                        r34 = r20(r35, r32, r29, r33)
                                                        r31 = {
                                                            [r39] = r34
                                                        }
                                                        r38 = 0.25
                                                        r18 = r26(r17, r38, r37, r31)
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state <= 174 then
                                                    if state <= 173 then
                                                        if state == 173 then
                                                            r18 = upvalueValues[upvalues[7]]
                                                            r26 = not r18
                                                            state = r26 and 174 or 175
                                                        end
                                                    else
                                                        if state == 174 then
                                                            r26 = upvalueValues[upvalues[9]]
                                                            r17 = upvalueValues[upvalues[4]]
                                                            r38 = upvalueValues[upvalues[5]]
                                                            r31 = "\008,\021\190C\140a\166"
                                                            r39 = 2339222411706
                                                            r37 = r38(r31, r39)
                                                            r18 = r17[r37]
                                                            r37 = "UDim2"
                                                            r38 = _env[r37]
                                                            r31 = upvalueValues[upvalues[4]]
                                                            r39 = upvalueValues[upvalues[5]]
                                                            r35 = 5487232694017
                                                            r34 = "\191\226X"
                                                            r20 = r39(r34, r35)
                                                            r37 = r31[r20]
                                                            r17 = r38[r37]
                                                            r39 = upvalueValues[upvalues[10]]
                                                            r34 = upvalueValues[upvalues[4]]
                                                            r35 = upvalueValues[upvalues[5]]
                                                            r29 = "\212"
                                                            r33 = 3675716111306
                                                            r32 = r35(r29, r33)
                                                            r20 = r34[r32]
                                                            r31 = r39[r20]
                                                            r20 = upvalueValues[upvalues[4]]
                                                            r34 = upvalueValues[upvalues[5]]
                                                            r32 = "oB\194)\005"
                                                            r29 = 24576811696739
                                                            r35 = r34(r32, r29)
                                                            r39 = r20[r35]
                                                            r37 = r31[r39]
                                                            r34 = upvalueValues[upvalues[10]]
                                                            r32 = upvalueValues[upvalues[4]]
                                                            r29 = upvalueValues[upvalues[5]]
                                                            r2 = "\207"
                                                            r5 = 27390570669701
                                                            r33 = r29(r2, r5)
                                                            r35 = r32[r33]
                                                            r20 = r34[r35]
                                                            r35 = upvalueValues[upvalues[4]]
                                                            r32 = upvalueValues[upvalues[5]]
                                                            r33 = "\230\027nn\154\245"
                                                            r2 = 30978176332105
                                                            r29 = r32(r33, r2)
                                                            r34 = r35[r29]
                                                            r39 = r20[r34]
                                                            r35 = upvalueValues[upvalues[4]]
                                                            r32 = upvalueValues[upvalues[5]]
                                                            r2 = 14893378905724
                                                            r33 = "2"
                                                            r29 = r32(r33, r2)
                                                            r34 = r35[r29]
                                                            r20 = r22[r34]
                                                            r31 = r39 + r20
                                                            r34 = upvalueValues[upvalues[10]]
                                                            r32 = upvalueValues[upvalues[4]]
                                                            r29 = upvalueValues[upvalues[5]]
                                                            r5 = 31483450835563
                                                            r2 = "\254"
                                                            r33 = r29(r2, r5)
                                                            r35 = r32[r33]
                                                            r20 = r34[r35]
                                                            r35 = upvalueValues[upvalues[4]]
                                                            r32 = upvalueValues[upvalues[5]]
                                                            r2 = 30269097680328
                                                            r33 = ":\176\025$\221"
                                                            r29 = r32(r33, r2)
                                                            r34 = r35[r29]
                                                            r39 = r20[r34]
                                                            r32 = upvalueValues[upvalues[10]]
                                                            r33 = upvalueValues[upvalues[4]]
                                                            r2 = upvalueValues[upvalues[5]]
                                                            r14 = 709399488504
                                                            r27 = "w"
                                                            r5 = r2(r27, r14)
                                                            r29 = r33[r5]
                                                            r35 = r32[r29]
                                                            r29 = upvalueValues[upvalues[4]]
                                                            r33 = upvalueValues[upvalues[5]]
                                                            r5 = "\197\019\"#m\238"
                                                            r27 = 26805828982486
                                                            r2 = r33(r5, r27)
                                                            r32 = r29[r2]
                                                            r34 = r35[r32]
                                                            r29 = upvalueValues[upvalues[4]]
                                                            r33 = upvalueValues[upvalues[5]]
                                                            r27 = 4501897958433
                                                            r5 = "\130"
                                                            r2 = r33(r5, r27)
                                                            r32 = r29[r2]
                                                            r35 = r22[r32]
                                                            r20 = r34 + r35
                                                            r38 = r17(r37, r31, r39, r20)
                                                            r26[r18] = r38
                                                            state = 175
                                                        end
                                                    end
                                                else
                                                    if state == 175 then
                                                        r22 = nil
                                                        state = 169
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure7 entry 4920979 -> 176, states 176-186
                                    if state <= 181 then
                                        if state <= 178 then
                                            if state <= 177 then
                                                if state <= 176 then
                                                    if state == 176 then -- entry 4920979 -> 176
                                                        r11 = allocUpvalue()
                                                        upvalueValues[r11] = args[1]
                                                        r25 = allocUpvalue()
                                                        upvalueValues[r25] = args[2]
                                                        ReturnVal = upvalueValues[r11]
                                                        r26 = upvalueValues[upvalues[1]]
                                                        r18 = upvalueValues[upvalues[2]]
                                                        r38 = "\131\t5\176\021"
                                                        r37 = 1296504866957
                                                        r17 = r18(r38, r37)
                                                        r22 = r26[r17]
                                                        state = ReturnVal[r22]
                                                        r22 = state
                                                        state = not r22
                                                        state = state and 177 or 178
                                                    end
                                                else
                                                    if state == 177 then
                                                        ReturnVal = "tostring"
                                                        state = _env[ReturnVal]
                                                        r18 = upvalueValues[upvalues[1]]
                                                        r17 = upvalueValues[upvalues[2]]
                                                        r37 = "\183%\184\170c\228"
                                                        r31 = 12569954807593
                                                        r38 = r17(r37, r31)
                                                        r26 = r18[r38]
                                                        ReturnVal = state(r26)
                                                        r22 = ReturnVal
                                                        state = 178
                                                    end
                                                end
                                            else
                                                if state == 178 then
                                                    r18 = createClosure4(190, {
                                                        r25,
                                                        r11,
                                                        upvalues[1],
                                                        upvalues[2]
                                                    })
                                                    state = r18 and 179 or 180
                                                    r26 = r18
                                                end
                                            end
                                        else
                                            if state <= 180 then
                                                if state <= 179 then
                                                    if state == 179 then
                                                        state = upvalueValues[r25]
                                                        r18 = state
                                                        state = upvalueValues[r25]
                                                        state = state and 181 or 182
                                                    end
                                                else
                                                    if state == 180 then
                                                        r18 = createClosure5(199, {})
                                                        r26 = r18
                                                        state = 179
                                                    end
                                                end
                                            else
                                                if state == 181 then
                                                    r17 = upvalueValues[r11]
                                                    r37 = upvalueValues[upvalues[1]]
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r20 = "=\237\2003ZN\169"
                                                    r34 = 22230739277309
                                                    r39 = r31(r20, r34)
                                                    r38 = r37[r39]
                                                    state = r17[r38]
                                                    r18 = state
                                                    state = 182
                                                end
                                            end
                                        end
                                    else
                                        if state <= 184 then
                                            if state <= 183 then
                                                if state <= 182 then
                                                    if state == 182 then
                                                        r17 = not r18
                                                        state = r17 and 183 or 184
                                                    end
                                                else
                                                    if state == 183 then
                                                        r38 = state
                                                        r20 = "getgenv"
                                                        r39 = _env[r20]
                                                        r20 = r39()
                                                        r34 = upvalueValues[upvalues[1]]
                                                        r35 = upvalueValues[upvalues[2]]
                                                        r33 = 23236774278750
                                                        r29 = "\219\2078\150\201b\209"
                                                        r32 = r35(r29, r33)
                                                        r39 = r34[r32]
                                                        r31 = r20[r39]
                                                        r20 = upvalueValues[r11]
                                                        r35 = upvalueValues[upvalues[1]]
                                                        r32 = upvalueValues[upvalues[2]]
                                                        r2 = 15420818034341
                                                        r33 = "l@\015\193n"
                                                        r29 = r32(r33, r2)
                                                        r34 = r35[r29]
                                                        r39 = r20[r34]
                                                        r37 = r31[r39]
                                                        r31 = false
                                                        r17 = r37 or r31
                                                        r18 = r17
                                                        state = 184
                                                    end
                                                end
                                            else
                                                if state == 184 then
                                                    r31 = upvalueValues[upvalues[1]]
                                                    r39 = upvalueValues[upvalues[2]]
                                                    r34 = "\152\177X\025d"
                                                    r35 = 7283186098559
                                                    r20 = r39(r34, r35)
                                                    r37 = r31[r20]
                                                    r39 = upvalueValues[upvalues[1]]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r32 = 14514678774755
                                                    r35 = "\210\217\152\142\0313\202!"
                                                    r34 = r20(r35, r32)
                                                    r31 = r39[r34]
                                                    r20 = upvalueValues[upvalues[1]]
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r29 = 22786926206034
                                                    r32 = "\217\230JZ\238cM"
                                                    r35 = r34(r32, r29)
                                                    r39 = r20[r35]
                                                    r38 = {
                                                        [r37] = r22,
                                                        [r31] = r26,
                                                        [r39] = r18
                                                    }
                                                    r37 = allocUpvalue()
                                                    upvalueValues[r37] = r38
                                                    r39 = "Instance"
                                                    r31 = _env[r39]
                                                    r20 = upvalueValues[upvalues[1]]
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r29 = 15554826584794
                                                    r32 = "#y\027"
                                                    r35 = r34(r32, r29)
                                                    r39 = r20[r35]
                                                    r38 = r31[r39]
                                                    r20 = upvalueValues[upvalues[1]]
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r32 = "#\217L\006\156"
                                                    r29 = 17223080129580
                                                    r35 = r34(r32, r29)
                                                    r39 = r20[r35]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r31 = r38(r39, r20)
                                                    r38 = allocUpvalue()
                                                    upvalueValues[r38] = r31
                                                    r31 = upvalueValues[r38]
                                                    r20 = upvalueValues[upvalues[1]]
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r29 = 19426713499627
                                                    r32 = "\193tn`C\250\199\155\194\t*6\016S\196C\181\224L\002\148\140"
                                                    r35 = r34(r32, r29)
                                                    r39 = r20[r35]
                                                    r20 = 0
                                                    r31[r39] = r20
                                                    r31 = upvalueValues[r38]
                                                    r20 = upvalueValues[upvalues[1]]
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r32 = "W\199\165\181\249Jv'\173yQ\139IV\131\226"
                                                    r29 = 14367895823655
                                                    r35 = r34(r32, r29)
                                                    r39 = r20[r35]
                                                    r35 = "Color3"
                                                    r34 = _env[r35]
                                                    r32 = upvalueValues[upvalues[1]]
                                                    r29 = upvalueValues[upvalues[2]]
                                                    r2 = "\005\130\233\0064\135\167"
                                                    r5 = 18794500583876
                                                    r33 = r29(r2, r5)
                                                    r35 = r32[r33]
                                                    r20 = r34[r35]
                                                    r29 = 48
                                                    r32 = 43
                                                    r35 = 42
                                                    r34 = r20(r35, r32, r29)
                                                    r31[r39] = r34
                                                    r39 = upvalueValues[upvalues[4]]
                                                    r34 = upvalueValues[upvalues[1]]
                                                    r35 = upvalueValues[upvalues[2]]
                                                    r33 = 20772065844140
                                                    r29 = "y\128\135P\238\149\158\237\1390;\148\233"
                                                    r32 = r35(r29, r33)
                                                    r20 = r34[r32]
                                                    r31 = r39[r20]
                                                    r34 = upvalueValues[r38]
                                                    r20 = 4
                                                    r39 = r31(r20, r34)
                                                    r20 = "Instance"
                                                    r39 = _env[r20]
                                                    r34 = upvalueValues[upvalues[1]]
                                                    r35 = upvalueValues[upvalues[2]]
                                                    r33 = 4554070384981
                                                    r29 = "\021\170f"
                                                    r32 = r35(r29, r33)
                                                    r20 = r34[r32]
                                                    r31 = r39[r20]
                                                    r34 = upvalueValues[upvalues[1]]
                                                    r35 = upvalueValues[upvalues[2]]
                                                    r29 = "(&\176\138K\195\142\212\188h"
                                                    r33 = 9157855157678
                                                    r32 = r35(r29, r33)
                                                    r20 = r34[r32]
                                                    r34 = upvalueValues[r38]
                                                    r39 = r31(r20, r34)
                                                    r20 = upvalueValues[upvalues[1]]
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r29 = 27938438008190
                                                    r32 = "U/(\216\246'Gd\008P\2529\169\235\1485\014\n\251\192\246\021"
                                                    r35 = r34(r32, r29)
                                                    r31 = r20[r35]
                                                    r20 = 1
                                                    r39[r31] = r20
                                                    r20 = upvalueValues[upvalues[1]]
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r29 = 29470154347755
                                                    r32 = "\227\161~\255\218\150\140\221\247I\152^\017y\144b"
                                                    r35 = r34(r32, r29)
                                                    r31 = r20[r35]
                                                    r20 = 1
                                                    r39[r31] = r20
                                                    r20 = upvalueValues[upvalues[1]]
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r29 = 17070447214883
                                                    r32 = "\219\230 \"<\014|\017|\201<\154G\006\137"
                                                    r35 = r34(r32, r29)
                                                    r31 = r20[r35]
                                                    r20 = false
                                                    r39[r31] = r20
                                                    r20 = upvalueValues[upvalues[1]]
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r29 = 30011697022598
                                                    r32 = "c\1313f"
                                                    r35 = r34(r32, r29)
                                                    r31 = r20[r35]
                                                    r35 = "UDim2"
                                                    r34 = _env[r35]
                                                    r32 = upvalueValues[upvalues[1]]
                                                    r29 = upvalueValues[upvalues[2]]
                                                    r5 = 21414838128652
                                                    r2 = "\195\140o"
                                                    r33 = r29(r2, r5)
                                                    r35 = r32[r33]
                                                    r20 = r34[r35]
                                                    r29 = 1
                                                    r33 = 0
                                                    r32 = 0
                                                    r35 = 1
                                                    r34 = r20(r35, r32, r29, r33)
                                                    r39[r31] = r34
                                                    r20 = upvalueValues[upvalues[1]]
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r32 = "\243;J\161\245\003\137\175\190\230/"
                                                    r29 = 16979523839513
                                                    r35 = r34(r32, r29)
                                                    r31 = r20[r35]
                                                    r35 = "Vector2"
                                                    r34 = _env[r35]
                                                    r32 = upvalueValues[upvalues[1]]
                                                    r29 = upvalueValues[upvalues[2]]
                                                    r2 = "\253\202r"
                                                    r5 = 20784337599914
                                                    r33 = r29(r2, r5)
                                                    r35 = r32[r33]
                                                    r20 = r34[r35]
                                                    r35 = 0.5
                                                    r32 = 0.5
                                                    r34 = r20(r35, r32)
                                                    r39[r31] = r34
                                                    r20 = upvalueValues[upvalues[1]]
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r32 = "\214A\132\003\241\012:2"
                                                    r29 = 31998159400540
                                                    r35 = r34(r32, r29)
                                                    r31 = r20[r35]
                                                    r35 = "UDim2"
                                                    r34 = _env[r35]
                                                    r32 = upvalueValues[upvalues[1]]
                                                    r29 = upvalueValues[upvalues[2]]
                                                    r2 = "\216\190\147"
                                                    r5 = 14033484608802
                                                    r33 = r29(r2, r5)
                                                    r35 = r32[r33]
                                                    r20 = r34[r35]
                                                    r29 = 0.5
                                                    r32 = 0
                                                    r33 = 0
                                                    r35 = 0.5
                                                    r34 = r20(r35, r32, r29, r33)
                                                    r39[r31] = r34
                                                    r34 = "Instance"
                                                    r20 = _env[r34]
                                                    r35 = upvalueValues[upvalues[1]]
                                                    r32 = upvalueValues[upvalues[2]]
                                                    r2 = 13147598892797
                                                    r33 = "\194z\005"
                                                    r29 = r32(r33, r2)
                                                    r34 = r35[r29]
                                                    r31 = r20[r34]
                                                    r35 = upvalueValues[upvalues[1]]
                                                    r32 = upvalueValues[upvalues[2]]
                                                    r33 = "'\128l\r\147B\180#\180"
                                                    r2 = 31450188668021
                                                    r29 = r32(r33, r2)
                                                    r34 = r35[r29]
                                                    r35 = upvalueValues[r38]
                                                    r20 = r31(r34, r35)
                                                    r34 = upvalueValues[upvalues[1]]
                                                    r35 = upvalueValues[upvalues[2]]
                                                    r33 = 6508248796491
                                                    r29 = "\160{\016[\202\148\029\223\174\214\n\167N\209\149\243u\190+\143\232\005"
                                                    r32 = r35(r29, r33)
                                                    r31 = r34[r32]
                                                    r34 = 1
                                                    r20[r31] = r34
                                                    r34 = upvalueValues[upvalues[1]]
                                                    r35 = upvalueValues[upvalues[2]]
                                                    r33 = 8263917309051
                                                    r29 = "\204B\154\004\0217\253\184"
                                                    r32 = r35(r29, r33)
                                                    r31 = r34[r32]
                                                    r32 = "UDim2"
                                                    r35 = _env[r32]
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r27 = 23961648981961
                                                    r5 = "lm}"
                                                    r2 = r33(r5, r27)
                                                    r32 = r29[r2]
                                                    r34 = r35[r32]
                                                    r33 = 0.7
                                                    r2 = 0
                                                    r29 = 0
                                                    r32 = 0.078
                                                    r35 = r34(r32, r29, r33, r2)
                                                    r20[r31] = r35
                                                    r34 = upvalueValues[upvalues[1]]
                                                    r35 = upvalueValues[upvalues[2]]
                                                    r29 = ".\182\209\220"
                                                    r33 = 9520429725107
                                                    r32 = r35(r29, r33)
                                                    r31 = r34[r32]
                                                    r32 = "UDim2"
                                                    r35 = _env[r32]
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r27 = 32371771203884
                                                    r5 = "\1438\173"
                                                    r2 = r33(r5, r27)
                                                    r32 = r29[r2]
                                                    r34 = r35[r32]
                                                    r33 = 0
                                                    r2 = 23
                                                    r29 = 130
                                                    r32 = 0
                                                    r35 = r34(r32, r29, r33, r2)
                                                    r20[r31] = r35
                                                    r34 = upvalueValues[upvalues[1]]
                                                    r35 = upvalueValues[upvalues[2]]
                                                    r33 = 10152379044723
                                                    r29 = "\195g\171\150\0057\241%"
                                                    r32 = r35(r29, r33)
                                                    r31 = r34[r32]
                                                    r32 = "Font"
                                                    r35 = _env[r32]
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r5 = "]ul\177\225Y[\240"
                                                    r27 = 19642416834269
                                                    r2 = r33(r5, r27)
                                                    r32 = r29[r2]
                                                    r34 = r35[r32]
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r27 = 23970375179699
                                                    r5 = "\193\190\"S\224\007\021\203\234$"
                                                    r2 = r33(r5, r27)
                                                    r32 = r29[r2]
                                                    r5 = "Enum"
                                                    r2 = _env[r5]
                                                    r27 = upvalueValues[upvalues[1]]
                                                    r14 = upvalueValues[upvalues[2]]
                                                    r15 = 21783810641727
                                                    r1 = "\152QT\252N\t\216\0119\152"
                                                    r21 = r14(r1, r15)
                                                    r5 = r27[r21]
                                                    r33 = r2[r5]
                                                    r5 = upvalueValues[upvalues[1]]
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r1 = 22378012660291
                                                    r21 = "X/S\145\008H\254"
                                                    r14 = r27(r21, r1)
                                                    r2 = r5[r14]
                                                    r29 = r33[r2]
                                                    r27 = "Enum"
                                                    r5 = _env[r27]
                                                    r14 = upvalueValues[upvalues[1]]
                                                    r21 = upvalueValues[upvalues[2]]
                                                    r12 = 15831858032659
                                                    r15 = ".\142\129\0248\219Pg\192"
                                                    r1 = r21(r15, r12)
                                                    r27 = r14[r1]
                                                    r2 = r5[r27]
                                                    r27 = upvalueValues[upvalues[1]]
                                                    r14 = upvalueValues[upvalues[2]]
                                                    r15 = 16479890140918
                                                    r1 = "e\218\216\207\147\158"
                                                    r21 = r14(r1, r15)
                                                    r5 = r27[r21]
                                                    r33 = r2[r5]
                                                    r35 = r34(r32, r29, r33)
                                                    r20[r31] = r35
                                                    r34 = upvalueValues[upvalues[1]]
                                                    r35 = upvalueValues[upvalues[2]]
                                                    r29 = "\234*\191\005"
                                                    r33 = 24251085102313
                                                    r32 = r35(r29, r33)
                                                    r31 = r34[r32]
                                                    r35 = upvalueValues[r37]
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r5 = "n\018\232\186\226"
                                                    r27 = 20320001622358
                                                    r2 = r33(r5, r27)
                                                    r32 = r29[r2]
                                                    r34 = r35[r32]
                                                    r20[r31] = r34
                                                    r34 = upvalueValues[upvalues[1]]
                                                    r35 = upvalueValues[upvalues[2]]
                                                    r29 = "\188\137\144\135\199sN>"
                                                    r33 = 29889488885104
                                                    r32 = r35(r29, r33)
                                                    r31 = r34[r32]
                                                    r34 = 12
                                                    r20[r31] = r34
                                                    r34 = upvalueValues[upvalues[1]]
                                                    r35 = upvalueValues[upvalues[2]]
                                                    r33 = 8774454470112
                                                    r29 = "\129\205~\172\031\162G\146d\190"
                                                    r32 = r35(r29, r33)
                                                    r31 = r34[r32]
                                                    r32 = "Color3"
                                                    r35 = _env[r32]
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r27 = 3639035430236
                                                    r5 = "\230dc}\012q\251"
                                                    r2 = r33(r5, r27)
                                                    r32 = r29[r2]
                                                    r34 = r35[r32]
                                                    r29 = 255
                                                    r32 = 255
                                                    r33 = 255
                                                    r35 = r34(r32, r29, r33)
                                                    r20[r31] = r35
                                                    r34 = upvalueValues[upvalues[1]]
                                                    r35 = upvalueValues[upvalues[2]]
                                                    r29 = "^,\208Hz'\161B\1426\158\182\160S"
                                                    r33 = 34604828192122
                                                    r32 = r35(r29, r33)
                                                    r31 = r34[r32]
                                                    r29 = "Enum"
                                                    r32 = _env[r29]
                                                    r33 = upvalueValues[upvalues[1]]
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r14 = 29521954037822
                                                    r27 = "gk\181\231L%\239\196\145\171\141-\177\011"
                                                    r5 = r2(r27, r14)
                                                    r29 = r33[r5]
                                                    r35 = r32[r29]
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r27 = 18665419514072
                                                    r5 = "\187\205^I"
                                                    r2 = r33(r5, r27)
                                                    r32 = r29[r2]
                                                    r34 = r35[r32]
                                                    r20[r31] = r34
                                                    r35 = "Instance"
                                                    r34 = _env[r35]
                                                    r32 = upvalueValues[upvalues[1]]
                                                    r29 = upvalueValues[upvalues[2]]
                                                    r2 = "0\168\228"
                                                    r5 = 15963082445303
                                                    r33 = r29(r2, r5)
                                                    r35 = r32[r33]
                                                    r31 = r34[r35]
                                                    r32 = upvalueValues[upvalues[1]]
                                                    r29 = upvalueValues[upvalues[2]]
                                                    r5 = 30490088954426
                                                    r2 = "H\253~\199;"
                                                    r33 = r29(r2, r5)
                                                    r35 = r32[r33]
                                                    r32 = upvalueValues[r38]
                                                    r34 = r31(r35, r32)
                                                    r31 = allocUpvalue()
                                                    upvalueValues[r31] = r34
                                                    r34 = upvalueValues[r31]
                                                    r32 = upvalueValues[upvalues[1]]
                                                    r29 = upvalueValues[upvalues[2]]
                                                    r5 = 8706328749695
                                                    r2 = "\224\219\150O\244\148\142\018\231\015\1605\255\166\179\\"
                                                    r33 = r29(r2, r5)
                                                    r35 = r32[r33]
                                                    r33 = "Color3"
                                                    r29 = _env[r33]
                                                    r2 = upvalueValues[upvalues[1]]
                                                    r5 = upvalueValues[upvalues[2]]
                                                    r21 = 4014183380033
                                                    r14 = "\t&\220\221\148l\016"
                                                    r27 = r5(r14, r21)
                                                    r33 = r2[r27]
                                                    r32 = r29[r33]
                                                    r5 = 54
                                                    r2 = 48
                                                    r33 = 47
                                                    r29 = r32(r33, r2, r5)
                                                    r34[r35] = r29
                                                    r34 = upvalueValues[r31]
                                                    r32 = upvalueValues[upvalues[1]]
                                                    r29 = upvalueValues[upvalues[2]]
                                                    r2 = "\182\016\241=K\145_\201"
                                                    r5 = 15265398641790
                                                    r33 = r29(r2, r5)
                                                    r35 = r32[r33]
                                                    r33 = "UDim2"
                                                    r29 = _env[r33]
                                                    r2 = upvalueValues[upvalues[1]]
                                                    r5 = upvalueValues[upvalues[2]]
                                                    r21 = 4329998187064
                                                    r14 = "~\001\226"
                                                    r27 = r5(r14, r21)
                                                    r33 = r2[r27]
                                                    r32 = r29[r33]
                                                    r27 = 0
                                                    r33 = 0.8
                                                    r2 = 0
                                                    r5 = 0.25
                                                    r29 = r32(r33, r2, r5, r27)
                                                    r34[r35] = r29
                                                    r34 = upvalueValues[r31]
                                                    r32 = upvalueValues[upvalues[1]]
                                                    r29 = upvalueValues[upvalues[2]]
                                                    r5 = 30427552291952
                                                    r2 = "\181\217\172-\134\154b\169\159~\251"
                                                    r33 = r29(r2, r5)
                                                    r35 = r32[r33]
                                                    r33 = "Vector2"
                                                    r29 = _env[r33]
                                                    r2 = upvalueValues[upvalues[1]]
                                                    r5 = upvalueValues[upvalues[2]]
                                                    r21 = 14025363013006
                                                    r14 = "\163j\165"
                                                    r27 = r5(r14, r21)
                                                    r33 = r2[r27]
                                                    r32 = r29[r33]
                                                    r33 = 0.5
                                                    r2 = 0.5
                                                    r29 = r32(r33, r2)
                                                    r34[r35] = r29
                                                    r34 = upvalueValues[r31]
                                                    r32 = upvalueValues[upvalues[1]]
                                                    r29 = upvalueValues[upvalues[2]]
                                                    r5 = 30492224733055
                                                    r2 = "\176\224\189\212"
                                                    r33 = r29(r2, r5)
                                                    r35 = r32[r33]
                                                    r33 = "UDim2"
                                                    r29 = _env[r33]
                                                    r2 = upvalueValues[upvalues[1]]
                                                    r5 = upvalueValues[upvalues[2]]
                                                    r21 = 7315086636549
                                                    r14 = "\144\215\004"
                                                    r27 = r5(r14, r21)
                                                    r33 = r2[r27]
                                                    r32 = r29[r33]
                                                    r27 = 20
                                                    r2 = 40
                                                    r5 = 0
                                                    r33 = 0
                                                    r29 = r32(r33, r2, r5, r27)
                                                    r34[r35] = r29
                                                    r35 = upvalueValues[upvalues[4]]
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r5 = "\t\141| 0\139\229\1400\187#\003+"
                                                    r27 = 25040686407196
                                                    r2 = r33(r5, r27)
                                                    r32 = r29[r2]
                                                    r34 = r35[r32]
                                                    r29 = upvalueValues[r31]
                                                    r32 = 30
                                                    r35 = r34(r32, r29)
                                                    r35 = upvalueValues[upvalues[4]]
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r27 = 9372526035052
                                                    r5 = "(\tl0\025\137"
                                                    r2 = r33(r5, r27)
                                                    r32 = r29[r2]
                                                    r34 = r35[r32]
                                                    r32 = upvalueValues[r31]
                                                    r27 = "Color3"
                                                    r5 = _env[r27]
                                                    r14 = upvalueValues[upvalues[1]]
                                                    r21 = upvalueValues[upvalues[2]]
                                                    r12 = 32401662679292
                                                    r15 = "d\177\2101\231\195Z"
                                                    r1 = r21(r15, r12)
                                                    r27 = r14[r1]
                                                    r2 = r5[r27]
                                                    r14 = 71
                                                    r21 = 71
                                                    r27 = 71
                                                    r5 = {
                                                        r2(r27, r14, r21)
                                                    }
                                                    r29 = 0
                                                    r33 = 1
                                                    r35 = r34(r32, r29, r33, unpack(r5))
                                                    r32 = "Instance"
                                                    r35 = _env[r32]
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r27 = 18337830850979
                                                    r5 = "`\220W"
                                                    r2 = r33(r5, r27)
                                                    r32 = r29[r2]
                                                    r34 = r35[r32]
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r5 = "\239\220\198\160."
                                                    r27 = 26094870704643
                                                    r2 = r33(r5, r27)
                                                    r32 = r29[r2]
                                                    r29 = upvalueValues[r31]
                                                    r35 = r34(r32, r29)
                                                    r34 = allocUpvalue()
                                                    upvalueValues[r34] = r35
                                                    r35 = upvalueValues[r34]
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r5 = "\138O}\001+>b\142\005\022\247"
                                                    r27 = 14508008924544
                                                    r2 = r33(r5, r27)
                                                    r32 = r29[r2]
                                                    r2 = "Vector2"
                                                    r33 = _env[r2]
                                                    r5 = upvalueValues[upvalues[1]]
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r1 = 19302251525776
                                                    r21 = "\244\008\181"
                                                    r14 = r27(r21, r1)
                                                    r2 = r5[r14]
                                                    r29 = r33[r2]
                                                    r5 = 0.5
                                                    r2 = 0.5
                                                    r33 = r29(r2, r5)
                                                    r35[r32] = r33
                                                    r35 = upvalueValues[r34]
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r5 = "e\215\229tT\2403\177\144 \144\138\244\219\029\207\254[\022\228Y\130"
                                                    r27 = 16461167417729
                                                    r2 = r33(r5, r27)
                                                    r32 = r29[r2]
                                                    r29 = 0
                                                    r35[r32] = r29
                                                    r35 = upvalueValues[r34]
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r27 = 24995292379066
                                                    r5 = "Jx\016\014T\205,\229"
                                                    r2 = r33(r5, r27)
                                                    r32 = r29[r2]
                                                    r2 = "UDim2"
                                                    r33 = _env[r2]
                                                    r5 = upvalueValues[upvalues[1]]
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r1 = 11617963319142
                                                    r21 = "S\162)"
                                                    r14 = r27(r21, r1)
                                                    r2 = r5[r14]
                                                    r29 = r33[r2]
                                                    r14 = 0
                                                    r2 = 0.25
                                                    r5 = 0
                                                    r27 = 0.5
                                                    r33 = r29(r2, r5, r27, r14)
                                                    r35[r32] = r33
                                                    r35 = upvalueValues[r34]
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r27 = 7551055471794
                                                    r5 = "\0074\238g"
                                                    r2 = r33(r5, r27)
                                                    r32 = r29[r2]
                                                    r2 = "UDim2"
                                                    r33 = _env[r2]
                                                    r5 = upvalueValues[upvalues[1]]
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r1 = 20116606384869
                                                    r21 = "C\207`"
                                                    r14 = r27(r21, r1)
                                                    r2 = r5[r14]
                                                    r29 = r33[r2]
                                                    r14 = 12
                                                    r5 = 12
                                                    r27 = 0
                                                    r2 = 0
                                                    r33 = r29(r2, r5, r27, r14)
                                                    r35[r32] = r33
                                                    r35 = upvalueValues[r34]
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r5 = "\152<\194\tbl\216\001\018\201X\151\185^T\135"
                                                    r27 = 33027994955495
                                                    r2 = r33(r5, r27)
                                                    r32 = r29[r2]
                                                    r2 = "Color3"
                                                    r33 = _env[r2]
                                                    r5 = upvalueValues[upvalues[1]]
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r21 = ":D\205\146I\147\156"
                                                    r1 = 33805206308642
                                                    r14 = r27(r21, r1)
                                                    r2 = r5[r14]
                                                    r29 = r33[r2]
                                                    r27 = 255
                                                    r5 = 255
                                                    r2 = 255
                                                    r33 = r29(r2, r5, r27)
                                                    r35[r32] = r33
                                                    r32 = upvalueValues[upvalues[4]]
                                                    r33 = upvalueValues[upvalues[1]]
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r27 = "\192\208\0308\156\014x\201\154-\159K8"
                                                    r14 = 12503548485913
                                                    r5 = r2(r27, r14)
                                                    r29 = r33[r5]
                                                    r35 = r32[r29]
                                                    r33 = upvalueValues[r34]
                                                    r29 = 30
                                                    r32 = r35(r29, r33)
                                                    r29 = "Instance"
                                                    r32 = _env[r29]
                                                    r33 = upvalueValues[upvalues[1]]
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r14 = 20746821721959
                                                    r27 = "\tz\219"
                                                    r5 = r2(r27, r14)
                                                    r29 = r33[r5]
                                                    r35 = r32[r29]
                                                    r33 = upvalueValues[upvalues[1]]
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r27 = "\218\212J\130\165h\162`S\028C"
                                                    r14 = 12278207978260
                                                    r5 = r2(r27, r14)
                                                    r29 = r33[r5]
                                                    r33 = upvalueValues[r38]
                                                    r32 = r35(r29, r33)
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r27 = 11675737680359
                                                    r5 = "%\211\169\200e\199\029\213\002\240\184"
                                                    r2 = r33(r5, r27)
                                                    r35 = r29[r2]
                                                    r2 = "Vector2"
                                                    r33 = _env[r2]
                                                    r5 = upvalueValues[upvalues[1]]
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r21 = "\029\254\196"
                                                    r1 = 12602086623613
                                                    r14 = r27(r21, r1)
                                                    r2 = r5[r14]
                                                    r29 = r33[r2]
                                                    r5 = 0.5
                                                    r2 = 0.5
                                                    r33 = r29(r2, r5)
                                                    r32[r35] = r33
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r5 = "h\026\162\173\\\193\240\195"
                                                    r27 = 19787976239720
                                                    r2 = r33(r5, r27)
                                                    r35 = r29[r2]
                                                    r2 = "UDim2"
                                                    r33 = _env[r2]
                                                    r5 = upvalueValues[upvalues[1]]
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r1 = 23665778804002
                                                    r21 = "\025\2254"
                                                    r14 = r27(r21, r1)
                                                    r2 = r5[r14]
                                                    r29 = r33[r2]
                                                    r5 = 0
                                                    r2 = 0.15
                                                    r27 = 0.25
                                                    r14 = 0
                                                    r33 = r29(r2, r5, r27, r14)
                                                    r32[r35] = r33
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r27 = 3922295619554
                                                    r5 = "\164R\255\142"
                                                    r2 = r33(r5, r27)
                                                    r35 = r29[r2]
                                                    r2 = "UDim2"
                                                    r33 = _env[r2]
                                                    r5 = upvalueValues[upvalues[1]]
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r21 = "q\163z"
                                                    r1 = 17939962441362
                                                    r14 = r27(r21, r1)
                                                    r2 = r5[r14]
                                                    r29 = r33[r2]
                                                    r27 = 0
                                                    r5 = 18
                                                    r2 = 0
                                                    r14 = 18
                                                    r33 = r29(r2, r5, r27, r14)
                                                    r32[r35] = r33
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r27 = 19938696670222
                                                    r5 = "D\195cN\181\210\200\199)\2467\222\134\169\021\t\021\243'\192\202O"
                                                    r2 = r33(r5, r27)
                                                    r35 = r29[r2]
                                                    r29 = 1
                                                    r32[r35] = r29
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r27 = 31920213296512
                                                    r5 = "\227\212\196\\\006"
                                                    r2 = r33(r5, r27)
                                                    r35 = r29[r2]
                                                    r33 = upvalueValues[upvalues[1]]
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r14 = 18159759462572
                                                    r27 = "\224\147\\\247\005M\230\188\213\189F i!\135\164\197:\131^\202\249\140\159W\160\221\223"
                                                    r5 = r2(r27, r14)
                                                    r29 = r33[r5]
                                                    r32[r35] = r29
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r5 = "\207o\019\t\164\\\218\174\215\169J}\024\218Oe6"
                                                    r27 = 34091804618142
                                                    r2 = r33(r5, r27)
                                                    r35 = r29[r2]
                                                    r29 = 0.2
                                                    r32[r35] = r29
                                                    r29 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r5 = "4\147<L&t"
                                                    r27 = 28937162179656
                                                    r2 = r33(r5, r27)
                                                    r35 = r29[r2]
                                                    r29 = 9
                                                    r32[r35] = r29
                                                    r29 = allocUpvalue()
                                                    r35 = false
                                                    upvalueValues[r29] = r35
                                                    r33 = upvalueValues[r38]
                                                    r5 = upvalueValues[upvalues[1]]
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r1 = 17253632215789
                                                    r21 = "\205\131\025\148\140m\011p\014)"
                                                    r14 = r27(r21, r1)
                                                    r2 = r5[r14]
                                                    r35 = r33[r2]
                                                    r33 = "Connect"
                                                    r33 = r35[r33]
                                                    r2 = createClosure2(200, {
                                                        r29,
                                                        upvalues[4],
                                                        upvalues[1],
                                                        upvalues[2],
                                                        r38
                                                    })
                                                    r33 = r33(r35, r2)
                                                    r33 = upvalueValues[r38]
                                                    r5 = upvalueValues[upvalues[1]]
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r21 = "Y\166B\026\245n\160O{v"
                                                    r1 = 27776622557876
                                                    r14 = r27(r21, r1)
                                                    r2 = r5[r14]
                                                    r35 = r33[r2]
                                                    r2 = createClosure5(203, {
                                                        r29,
                                                        upvalues[4],
                                                        upvalues[1],
                                                        upvalues[2],
                                                        r38
                                                    })
                                                    r33 = "Connect"
                                                    r33 = r35[r33]
                                                    r33 = r33(r35, r2)
                                                    r35 = allocUpvalue()
                                                    r33 = createClosure1(206, {
                                                        upvalues[1],
                                                        upvalues[2],
                                                        r37
                                                    })
                                                    upvalueValues[r35] = r33
                                                    r5 = upvalueValues[upvalues[1]]
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r1 = 32304866558383
                                                    r21 = "$t\212\005z\181\199r\019E;\021[\012\191\233J"
                                                    r14 = r27(r21, r1)
                                                    r2 = r5[r14]
                                                    r5 = createClosure0(212, {
                                                        r29,
                                                        upvalues[4],
                                                        upvalues[1],
                                                        upvalues[2],
                                                        r31,
                                                        r34,
                                                        r35
                                                    })
                                                    r33 = r39[r2]
                                                    r2 = "Connect"
                                                    r2 = r33[r2]
                                                    r2 = r2(r33, r5)
                                                    r2 = upvalueValues[r37]
                                                    r27 = upvalueValues[upvalues[1]]
                                                    r14 = upvalueValues[upvalues[2]]
                                                    r15 = 29151997470522
                                                    r1 = "\211\1590\196N\139\199"
                                                    r21 = r14(r1, r15)
                                                    r5 = r27[r21]
                                                    r33 = r2[r5]
                                                    state = r33 and 185 or 186
                                                end
                                            end
                                        else
                                            if state <= 185 then
                                                if state == 185 then
                                                    r2 = upvalueValues[upvalues[4]]
                                                    r27 = upvalueValues[upvalues[1]]
                                                    r14 = upvalueValues[upvalues[2]]
                                                    r15 = 19568849753014
                                                    r1 = "\180\184\212%\199"
                                                    r21 = r14(r1, r15)
                                                    r5 = r27[r21]
                                                    r33 = r2[r5]
                                                    r5 = upvalueValues[r31]
                                                    r15 = "Enum"
                                                    r1 = _env[r15]
                                                    r12 = upvalueValues[upvalues[1]]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r16 = "J\170h\223en;\215\218\248\191"
                                                    r23 = 22127704322276
                                                    r40 = r24(r16, r23)
                                                    r15 = r12[r40]
                                                    r21 = r1[r15]
                                                    r15 = upvalueValues[upvalues[1]]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r16 = 26584287275938
                                                    r40 = "\218\163Fv\201\134\190\015"
                                                    r24 = r12(r40, r16)
                                                    r1 = r15[r24]
                                                    r14 = r21[r1]
                                                    r15 = upvalueValues[upvalues[1]]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r16 = 10659482281469
                                                    r40 = ".$\246\220l\241A\250<\008@\197\221#J\137"
                                                    r24 = r12(r40, r16)
                                                    r1 = r15[r24]
                                                    r24 = "Color3"
                                                    r12 = _env[r24]
                                                    r40 = upvalueValues[upvalues[1]]
                                                    r16 = upvalueValues[upvalues[2]]
                                                    r36 = "\201\1961=5\208\148"
                                                    r7 = 14786513172113
                                                    r23 = r16(r36, r7)
                                                    r24 = r40[r23]
                                                    r15 = r12[r24]
                                                    r16 = 242
                                                    r40 = 101
                                                    r24 = 88
                                                    r12 = r15(r24, r40, r16)
                                                    r21 = {
                                                        [r1] = r12
                                                    }
                                                    r27 = 0.25
                                                    r2 = r33(r5, r27, r14, r21)
                                                    r2 = upvalueValues[upvalues[4]]
                                                    r27 = upvalueValues[upvalues[1]]
                                                    r14 = upvalueValues[upvalues[2]]
                                                    r15 = 6651831530843
                                                    r1 = "\241\190\136\237\242"
                                                    r21 = r14(r1, r15)
                                                    r5 = r27[r21]
                                                    r33 = r2[r5]
                                                    r5 = upvalueValues[r34]
                                                    r15 = "Enum"
                                                    r1 = _env[r15]
                                                    r12 = upvalueValues[upvalues[1]]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r23 = 9814162608635
                                                    r16 = "\221\011{\197\152\197nb<D\021"
                                                    r40 = r24(r16, r23)
                                                    r15 = r12[r40]
                                                    r21 = r1[r15]
                                                    r15 = upvalueValues[upvalues[1]]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r40 = "V\172S4\182Gj\162"
                                                    r16 = 6966718468036
                                                    r24 = r12(r40, r16)
                                                    r1 = r15[r24]
                                                    r14 = r21[r1]
                                                    r15 = upvalueValues[upvalues[1]]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r40 = "\154@-\215o\252 l"
                                                    r16 = 18185634275224
                                                    r24 = r12(r40, r16)
                                                    r1 = r15[r24]
                                                    r24 = "UDim2"
                                                    r12 = _env[r24]
                                                    r40 = upvalueValues[upvalues[1]]
                                                    r16 = upvalueValues[upvalues[2]]
                                                    r36 = "Am\213"
                                                    r7 = 27813786298857
                                                    r23 = r16(r36, r7)
                                                    r24 = r40[r23]
                                                    r15 = r12[r24]
                                                    r23 = 0
                                                    r40 = 0
                                                    r16 = 0.5
                                                    r24 = 0.75
                                                    r12 = r15(r24, r40, r16, r23)
                                                    r21 = {
                                                        [r1] = r12
                                                    }
                                                    r27 = 0.25
                                                    r2 = r33(r5, r27, r14, r21)
                                                    r2 = upvalueValues[r29]
                                                    r33 = not r2
                                                    upvalueValues[r29] = r33
                                                    r27 = "task"
                                                    r5 = _env[r27]
                                                    r14 = upvalueValues[upvalues[1]]
                                                    r21 = upvalueValues[upvalues[2]]
                                                    r15 = "d\238\149\177-"
                                                    r12 = 6701284400208
                                                    r1 = r21(r15, r12)
                                                    r27 = r14[r1]
                                                    r2 = r5[r27]
                                                    r27 = upvalueValues[r35]
                                                    r14 = upvalueValues[r29]
                                                    r5 = r2(r27, r14)
                                                    state = 186
                                                end
                                            else
                                                if state == 186 then
                                                    r27 = upvalueValues[upvalues[1]]
                                                    r37 = releaseUpvalue(r37)
                                                    r14 = upvalueValues[upvalues[2]]
                                                    r31 = releaseUpvalue(r31)
                                                    r29 = releaseUpvalue(r29)
                                                    r11 = releaseUpvalue(r11)
                                                    r25 = releaseUpvalue(r25)
                                                    r15 = 26081455466248
                                                    r1 = "]\230\167\174!\168\152\247\186\237\219z1+\021\012'"
                                                    r21 = r14(r1, r15)
                                                    r5 = r27[r21]
                                                    r35 = releaseUpvalue(r35)
                                                    r2 = r32[r5]
                                                    r27 = createClosure5(216, {
                                                        upvalues[4],
                                                        upvalues[1],
                                                        upvalues[2],
                                                        upvalues[5]
                                                    })
                                                    r34 = releaseUpvalue(r34)
                                                    r38 = releaseUpvalue(r38)
                                                    r5 = "Connect"
                                                    r5 = r2[r5]
                                                    ReturnVal = {}
                                                    r5 = r5(r2, r27)
                                                    r22 = nil
                                                    r18 = nil
                                                    r32 = nil
                                                    r26 = nil
                                                    r20 = nil
                                                    r39 = nil
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 198 then
                                    if state <= 189 then
                                        -- createClosure3 entry 13497074 -> 187, states 187-189
                                        if state <= 188 then
                                            if state <= 187 then
                                                if state == 187 then -- entry 13497074 -> 187
                                                    r11 = upvalueValues[upvalues[1]]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r26 = upvalueValues[upvalues[3]]
                                                    r38 = 21277396355986
                                                    r17 = "\160`\156\162\163\192\148]'}U\236\146s"
                                                    r18 = r26(r17, r38)
                                                    r25 = r22[r18]
                                                    ReturnVal = r11[r25]
                                                    r26 = "Enum"
                                                    r22 = _env[r26]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r17 = upvalueValues[upvalues[3]]
                                                    r37 = "\219\198}n8\024\021\019q\203\236\139\156\195"
                                                    r31 = 15692892035284
                                                    r38 = r17(r37, r31)
                                                    r26 = r18[r38]
                                                    r25 = r22[r26]
                                                    r26 = upvalueValues[upvalues[2]]
                                                    r18 = upvalueValues[upvalues[3]]
                                                    r37 = 25972980989946
                                                    r38 = "\165_="
                                                    r17 = r18(r38, r37)
                                                    r22 = r26[r17]
                                                    r11 = r25[r22]
                                                    state = ReturnVal == r11
                                                    state = state and 188 or 189
                                                end
                                            else
                                                if state == 188 then
                                                    state = false
                                                    upvalueValues[upvalues[4]] = state
                                                    state = 189
                                                end
                                            end
                                        else
                                            if state == 189 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        -- createClosure4 entry 4835905 -> 190, states 190-198
                                        if state <= 194 then
                                            if state <= 192 then
                                                if state <= 191 then
                                                    if state <= 190 then
                                                        if state == 190 then -- entry 4835905 -> 190
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            state = not ReturnVal
                                                            state = state and 191 or 192
                                                            r11 = args[1]
                                                        end
                                                    else
                                                        if state == 191 then
                                                            ReturnVal = upvalueValues[upvalues[2]]
                                                            r22 = upvalueValues[upvalues[3]]
                                                            r26 = upvalueValues[upvalues[4]]
                                                            r38 = 13351682103150
                                                            r17 = "\023\186\027\238\239"
                                                            r18 = r26(r17, r38)
                                                            r25 = r22[r18]
                                                            state = ReturnVal[r25]
                                                            r25 = state
                                                            state = r25 and 193 or 194
                                                        end
                                                    end
                                                else
                                                    if state == 192 then
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r26 = upvalueValues[upvalues[3]]
                                                        r18 = upvalueValues[upvalues[4]]
                                                        r38 = "'\178\1830q\172\213\253"
                                                        r37 = 24567215807393
                                                        r17 = r18(r38, r37)
                                                        r22 = r26[r17]
                                                        ReturnVal = r25[r22]
                                                        state = ReturnVal and 195 or 196
                                                    end
                                                end
                                            else
                                                if state <= 193 then
                                                    if state == 193 then
                                                        r18 = "getgenv"
                                                        r26 = _env[r18]
                                                        r18 = r26()
                                                        r17 = upvalueValues[upvalues[3]]
                                                        r38 = upvalueValues[upvalues[4]]
                                                        r39 = 12132734691220
                                                        r31 = "\163\218\145n2\129J"
                                                        r37 = r38(r31, r39)
                                                        r26 = r17[r37]
                                                        r22 = r18[r26]
                                                        r18 = upvalueValues[upvalues[2]]
                                                        r38 = upvalueValues[upvalues[3]]
                                                        r37 = upvalueValues[upvalues[4]]
                                                        r20 = 24547727273198
                                                        r39 = "\167\002\178e\015"
                                                        r31 = r37(r39, r20)
                                                        r17 = r38[r31]
                                                        r26 = r18[r17]
                                                        ReturnVal = r22[r26]
                                                        r22 = nil
                                                        state = ReturnVal ~= r22
                                                        r25 = state
                                                        state = 194
                                                    end
                                                else
                                                    if state == 194 then
                                                        state = r25 and 197 or 198
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 196 then
                                                if state <= 195 then
                                                    if state == 195 then
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r26 = upvalueValues[upvalues[3]]
                                                        r18 = upvalueValues[upvalues[4]]
                                                        r38 = "f\190eDN\179'#"
                                                        r37 = 17148368616539
                                                        r17 = r18(r38, r37)
                                                        r22 = r26[r17]
                                                        ReturnVal = r25[r22]
                                                        r25 = ReturnVal(r11)
                                                        state = 196
                                                    end
                                                else
                                                    if state == 196 then
                                                        r11 = nil
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state <= 197 then
                                                    if state == 197 then
                                                        r26 = "getgenv"
                                                        r22 = _env[r26]
                                                        r26 = r22()
                                                        r18 = upvalueValues[upvalues[3]]
                                                        r17 = upvalueValues[upvalues[4]]
                                                        r37 = "/R=\142t\146\238"
                                                        r31 = 25685441215248
                                                        r38 = r17(r37, r31)
                                                        r22 = r18[r38]
                                                        ReturnVal = r26[r22]
                                                        r26 = upvalueValues[upvalues[2]]
                                                        r17 = upvalueValues[upvalues[3]]
                                                        r38 = upvalueValues[upvalues[4]]
                                                        r39 = 13309991807897
                                                        r31 = "\029\003#`F"
                                                        r37 = r38(r31, r39)
                                                        r18 = r17[r37]
                                                        r22 = r26[r18]
                                                        r26 = r11
                                                        ReturnVal[r22] = r26
                                                        state = 198
                                                    end
                                                else
                                                    if state == 198 then
                                                        r25 = nil
                                                        state = 192
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure5 entry 2029295 -> 199, states 199-199
                                    if state == 199 then -- entry 2029295 -> 199
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 211 then
                                if state <= 205 then
                                    if state <= 202 then
                                        -- createClosure2 entry 13016054 -> 200, states 200-202
                                        if state <= 201 then
                                            if state <= 200 then
                                                if state == 200 then -- entry 13016054 -> 200
                                                    state = upvalueValues[upvalues[1]]
                                                    state = state and 201 or 202
                                                end
                                            else
                                                if state == 201 then
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state == 202 then
                                                ReturnVal = upvalueValues[upvalues[2]]
                                                r25 = upvalueValues[upvalues[3]]
                                                r22 = upvalueValues[upvalues[4]]
                                                r18 = "\183\221\201%\129"
                                                r17 = 28738792214699
                                                r26 = r22(r18, r17)
                                                r11 = r25[r26]
                                                state = ReturnVal[r11]
                                                r11 = upvalueValues[upvalues[5]]
                                                r17 = "Enum"
                                                r18 = _env[r17]
                                                r38 = upvalueValues[upvalues[3]]
                                                r37 = upvalueValues[upvalues[4]]
                                                r39 = "\018t~MFG\169\249>6\140"
                                                r20 = 8042369349384
                                                r31 = r37(r39, r20)
                                                r17 = r38[r31]
                                                r26 = r18[r17]
                                                r17 = upvalueValues[upvalues[3]]
                                                r38 = upvalueValues[upvalues[4]]
                                                r39 = 18106227107607
                                                r31 = "F\132\005Kl\209P\187"
                                                r37 = r38(r31, r39)
                                                r18 = r17[r37]
                                                r22 = r26[r18]
                                                r17 = upvalueValues[upvalues[3]]
                                                r38 = upvalueValues[upvalues[4]]
                                                r31 = "n3\028P\187\251\227\160\018,\172\016E-;\229"
                                                r39 = 33537157353423
                                                r37 = r38(r31, r39)
                                                r18 = r17[r37]
                                                r37 = "Color3"
                                                r38 = _env[r37]
                                                r31 = upvalueValues[upvalues[3]]
                                                r39 = upvalueValues[upvalues[4]]
                                                r34 = "\023\253\023M\146\197\021"
                                                r35 = 30419753197232
                                                r20 = r39(r34, r35)
                                                r37 = r31[r20]
                                                r17 = r38[r37]
                                                r39 = 62
                                                r37 = 54
                                                r31 = 55
                                                r38 = r17(r37, r31, r39)
                                                r26 = {
                                                    [r18] = r38
                                                }
                                                r25 = 0.25
                                                ReturnVal = state(r11, r25, r22, r26)
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        -- createClosure5 entry 14252681 -> 203, states 203-205
                                        if state <= 204 then
                                            if state <= 203 then
                                                if state == 203 then -- entry 14252681 -> 203
                                                    state = upvalueValues[upvalues[1]]
                                                    state = state and 204 or 205
                                                end
                                            else
                                                if state == 204 then
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state == 205 then
                                                ReturnVal = upvalueValues[upvalues[2]]
                                                r25 = upvalueValues[upvalues[3]]
                                                r22 = upvalueValues[upvalues[4]]
                                                r17 = 32122276756256
                                                r18 = "\242\236\239\233\227"
                                                r26 = r22(r18, r17)
                                                r11 = r25[r26]
                                                state = ReturnVal[r11]
                                                r11 = upvalueValues[upvalues[5]]
                                                r17 = "Enum"
                                                r18 = _env[r17]
                                                r38 = upvalueValues[upvalues[3]]
                                                r37 = upvalueValues[upvalues[4]]
                                                r39 = "z\127\149P\193\019\173\248\157\1495"
                                                r20 = 21859910663560
                                                r31 = r37(r39, r20)
                                                r17 = r38[r31]
                                                r26 = r18[r17]
                                                r17 = upvalueValues[upvalues[3]]
                                                r38 = upvalueValues[upvalues[4]]
                                                r31 = "V\214\240Q\156\231\224\019"
                                                r39 = 9134216390082
                                                r37 = r38(r31, r39)
                                                r18 = r17[r37]
                                                r22 = r26[r18]
                                                r17 = upvalueValues[upvalues[3]]
                                                r38 = upvalueValues[upvalues[4]]
                                                r31 = "\004\140ly=\128\195\157\1898\196f(\202d2"
                                                r39 = 799995904730
                                                r37 = r38(r31, r39)
                                                r18 = r17[r37]
                                                r37 = "Color3"
                                                r38 = _env[r37]
                                                r31 = upvalueValues[upvalues[3]]
                                                r39 = upvalueValues[upvalues[4]]
                                                r34 = "\024\182\156\024\169\133\132"
                                                r35 = 28786089933144
                                                r20 = r39(r34, r35)
                                                r37 = r31[r20]
                                                r17 = r38[r37]
                                                r31 = 43
                                                r37 = 42
                                                r39 = 48
                                                r38 = r17(r37, r31, r39)
                                                r26 = {
                                                    [r18] = r38
                                                }
                                                r25 = 0.25
                                                ReturnVal = state(r11, r25, r22, r26)
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure1 entry 12229356 -> 206, states 206-211
                                    if state <= 208 then
                                        if state <= 207 then
                                            if state <= 206 then
                                                if state == 206 then -- entry 12229356 -> 206
                                                    r25 = "loaded"
                                                    ReturnVal = _env[r25]
                                                    state = not ReturnVal
                                                    r11 = args[1]
                                                    state = state and 207 or 208
                                                end
                                            else
                                                if state == 207 then
                                                    ReturnVal = "loaded"
                                                    state = _env[ReturnVal]
                                                    state = 209
                                                end
                                            end
                                        else
                                            if state == 208 then
                                                r25 = "task"
                                                ReturnVal = _env[r25]
                                                r22 = upvalueValues[upvalues[1]]
                                                r26 = upvalueValues[upvalues[2]]
                                                r17 = "\195\208\239\011\209"
                                                r38 = 15044636153635
                                                r18 = r26(r17, r38)
                                                r25 = r22[r18]
                                                state = ReturnVal[r25]
                                                r22 = upvalueValues[upvalues[3]]
                                                r18 = upvalueValues[upvalues[1]]
                                                r17 = upvalueValues[upvalues[2]]
                                                r31 = 703810366552
                                                r37 = "Ky\rhr\0212w"
                                                r38 = r17(r37, r31)
                                                r26 = r18[r38]
                                                r25 = r22[r26]
                                                ReturnVal = state(r25, r11)
                                                r11 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        if state <= 210 then
                                            if state <= 209 then
                                                if state == 209 then
                                                    r25 = "task"
                                                    ReturnVal = _env[r25]
                                                    r22 = upvalueValues[upvalues[1]]
                                                    r26 = upvalueValues[upvalues[2]]
                                                    r38 = 76940352445
                                                    r17 = "\191\027\195\029"
                                                    r18 = r26(r17, r38)
                                                    r25 = r22[r18]
                                                    state = ReturnVal[r25]
                                                    ReturnVal = state()
                                                    state = 210
                                                end
                                            else
                                                if state == 210 then
                                                    ReturnVal = "loaded"
                                                    state = _env[ReturnVal]
                                                    state = state and 211 or 209
                                                end
                                            end
                                        else
                                            if state == 211 then
                                                state = 208
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 215 then
                                    -- createClosure0 entry 6561193 -> 212, states 212-215
                                    if state <= 213 then
                                        if state <= 212 then
                                            if state == 212 then -- entry 6561193 -> 212
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                state = not ReturnVal
                                                state = state and 213 or 214
                                            end
                                        else
                                            if state == 213 then
                                                ReturnVal = upvalueValues[upvalues[2]]
                                                r25 = upvalueValues[upvalues[3]]
                                                r22 = upvalueValues[upvalues[4]]
                                                r17 = 29809788934164
                                                r18 = "\030\142y\012{"
                                                r26 = r22(r18, r17)
                                                r11 = r25[r26]
                                                state = ReturnVal[r11]
                                                r11 = upvalueValues[upvalues[5]]
                                                r17 = "Enum"
                                                r18 = _env[r17]
                                                r38 = upvalueValues[upvalues[3]]
                                                r37 = upvalueValues[upvalues[4]]
                                                r20 = 1743728337976
                                                r39 = "\248\203\172\245t\005s\255\199\001r"
                                                r31 = r37(r39, r20)
                                                r17 = r38[r31]
                                                r26 = r18[r17]
                                                r17 = upvalueValues[upvalues[3]]
                                                r38 = upvalueValues[upvalues[4]]
                                                r39 = 31855133625655
                                                r31 = "A\204\002\161\012E\0111"
                                                r37 = r38(r31, r39)
                                                r18 = r17[r37]
                                                r22 = r26[r18]
                                                r17 = upvalueValues[upvalues[3]]
                                                r38 = upvalueValues[upvalues[4]]
                                                r31 = "\204^=,B\180\237\159\127\209\239i'3\168\136"
                                                r39 = 24006949269615
                                                r37 = r38(r31, r39)
                                                r18 = r17[r37]
                                                r37 = "Color3"
                                                r38 = _env[r37]
                                                r31 = upvalueValues[upvalues[3]]
                                                r39 = upvalueValues[upvalues[4]]
                                                r35 = 29041892109626
                                                r34 = "\252a\250\151\235\238\220"
                                                r20 = r39(r34, r35)
                                                r37 = r31[r20]
                                                r17 = r38[r37]
                                                r31 = 101
                                                r37 = 88
                                                r39 = 242
                                                r38 = r17(r37, r31, r39)
                                                r26 = {
                                                    [r18] = r38
                                                }
                                                r25 = 0.25
                                                ReturnVal = state(r11, r25, r22, r26)
                                                ReturnVal = upvalueValues[upvalues[2]]
                                                r25 = upvalueValues[upvalues[3]]
                                                r22 = upvalueValues[upvalues[4]]
                                                r18 = "(\219\239a\026"
                                                r17 = 14883083182192
                                                r26 = r22(r18, r17)
                                                r11 = r25[r26]
                                                state = ReturnVal[r11]
                                                r11 = upvalueValues[upvalues[6]]
                                                r17 = "Enum"
                                                r18 = _env[r17]
                                                r38 = upvalueValues[upvalues[3]]
                                                r37 = upvalueValues[upvalues[4]]
                                                r39 = "g[\202\143P@S~lc."
                                                r20 = 14021140493455
                                                r31 = r37(r39, r20)
                                                r17 = r38[r31]
                                                r26 = r18[r17]
                                                r17 = upvalueValues[upvalues[3]]
                                                r38 = upvalueValues[upvalues[4]]
                                                r39 = 31987176622568
                                                r31 = "\030^(\027b\187R*"
                                                r37 = r38(r31, r39)
                                                r18 = r17[r37]
                                                r22 = r26[r18]
                                                r17 = upvalueValues[upvalues[3]]
                                                r38 = upvalueValues[upvalues[4]]
                                                r31 = ";\253!\137\1553#s"
                                                r39 = 28674912943536
                                                r37 = r38(r31, r39)
                                                r18 = r17[r37]
                                                r37 = "UDim2"
                                                r38 = _env[r37]
                                                r31 = upvalueValues[upvalues[3]]
                                                r39 = upvalueValues[upvalues[4]]
                                                r35 = 5259975806220
                                                r34 = "\232\"\206"
                                                r20 = r39(r34, r35)
                                                r37 = r31[r20]
                                                r17 = r38[r37]
                                                r39 = 0.5
                                                r31 = 0
                                                r20 = 0
                                                r37 = 0.75
                                                r38 = r17(r37, r31, r39, r20)
                                                r26 = {
                                                    [r18] = r38
                                                }
                                                r25 = 0.25
                                                ReturnVal = state(r11, r25, r22, r26)
                                                state = 215
                                            end
                                        end
                                    else
                                        if state <= 214 then
                                            if state == 214 then
                                                ReturnVal = upvalueValues[upvalues[2]]
                                                r25 = upvalueValues[upvalues[3]]
                                                r22 = upvalueValues[upvalues[4]]
                                                r17 = 4425375074487
                                                r18 = "\023\209\241\129\201"
                                                r26 = r22(r18, r17)
                                                r11 = r25[r26]
                                                state = ReturnVal[r11]
                                                r11 = upvalueValues[upvalues[5]]
                                                r17 = "Enum"
                                                r18 = _env[r17]
                                                r38 = upvalueValues[upvalues[3]]
                                                r37 = upvalueValues[upvalues[4]]
                                                r20 = 34733545474773
                                                r39 = ",[\164\0113\243\163s4s\005"
                                                r31 = r37(r39, r20)
                                                r17 = r38[r31]
                                                r26 = r18[r17]
                                                r17 = upvalueValues[upvalues[3]]
                                                r38 = upvalueValues[upvalues[4]]
                                                r31 = "\006;M\228\215\152P\177"
                                                r39 = 11705541836846
                                                r37 = r38(r31, r39)
                                                r18 = r17[r37]
                                                r22 = r26[r18]
                                                r17 = upvalueValues[upvalues[3]]
                                                r38 = upvalueValues[upvalues[4]]
                                                r31 = "\n\212\169\143\127\127\144e\001f\149\224(?TJ"
                                                r39 = 14830712878354
                                                r37 = r38(r31, r39)
                                                r18 = r17[r37]
                                                r37 = "Color3"
                                                r38 = _env[r37]
                                                r31 = upvalueValues[upvalues[3]]
                                                r39 = upvalueValues[upvalues[4]]
                                                r34 = " \144\232;^\029\202"
                                                r35 = 18681975983784
                                                r20 = r39(r34, r35)
                                                r37 = r31[r20]
                                                r17 = r38[r37]
                                                r31 = 55
                                                r39 = 62
                                                r37 = 54
                                                r38 = r17(r37, r31, r39)
                                                r26 = {
                                                    [r18] = r38
                                                }
                                                r25 = 0.25
                                                ReturnVal = state(r11, r25, r22, r26)
                                                ReturnVal = upvalueValues[upvalues[2]]
                                                r25 = upvalueValues[upvalues[3]]
                                                r22 = upvalueValues[upvalues[4]]
                                                r17 = 20980005013520
                                                r18 = "e\224~\026\138"
                                                r26 = r22(r18, r17)
                                                r11 = r25[r26]
                                                state = ReturnVal[r11]
                                                r11 = upvalueValues[upvalues[6]]
                                                r17 = "Enum"
                                                r18 = _env[r17]
                                                r38 = upvalueValues[upvalues[3]]
                                                r37 = upvalueValues[upvalues[4]]
                                                r20 = 9552366116786
                                                r39 = "\164GR\171-K\008\170@\019\132"
                                                r31 = r37(r39, r20)
                                                r17 = r38[r31]
                                                r26 = r18[r17]
                                                r17 = upvalueValues[upvalues[3]]
                                                r38 = upvalueValues[upvalues[4]]
                                                r39 = 14065633693178
                                                r31 = "9\150\025/&}\183\198"
                                                r37 = r38(r31, r39)
                                                r18 = r17[r37]
                                                r22 = r26[r18]
                                                r17 = upvalueValues[upvalues[3]]
                                                r38 = upvalueValues[upvalues[4]]
                                                r31 = "mz{m\2490 \220"
                                                r39 = 5195705873823
                                                r37 = r38(r31, r39)
                                                r18 = r17[r37]
                                                r37 = "UDim2"
                                                r38 = _env[r37]
                                                r31 = upvalueValues[upvalues[3]]
                                                r39 = upvalueValues[upvalues[4]]
                                                r34 = "#^f"
                                                r35 = 14476632035320
                                                r20 = r39(r34, r35)
                                                r37 = r31[r20]
                                                r17 = r38[r37]
                                                r39 = 0.5
                                                r20 = 0
                                                r31 = 0
                                                r37 = 0.25
                                                r38 = r17(r37, r31, r39, r20)
                                                r26 = {
                                                    [r18] = r38
                                                }
                                                r25 = 0.25
                                                ReturnVal = state(r11, r25, r22, r26)
                                                state = 215
                                            end
                                        else
                                            if state == 215 then
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                state = not ReturnVal
                                                upvalueValues[upvalues[1]] = state
                                                r25 = "task"
                                                r11 = _env[r25]
                                                r22 = upvalueValues[upvalues[3]]
                                                r26 = upvalueValues[upvalues[4]]
                                                r38 = 12642548699227
                                                r17 = "\163\"z\170f"
                                                r18 = r26(r17, r38)
                                                r25 = r22[r18]
                                                ReturnVal = r11[r25]
                                                r25 = upvalueValues[upvalues[7]]
                                                r22 = upvalueValues[upvalues[1]]
                                                r11 = ReturnVal(r25, r22)
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure5 entry 2837990 -> 216, states 216-216
                                    if state == 216 then -- entry 2837990 -> 216
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r25 = upvalueValues[upvalues[2]]
                                        r22 = upvalueValues[upvalues[3]]
                                        r18 = "\240kJ\027\185"
                                        r17 = 6381618704131
                                        r26 = r22(r18, r17)
                                        r11 = r25[r26]
                                        state = ReturnVal[r11]
                                        r11 = upvalueValues[upvalues[4]]
                                        r17 = "Enum"
                                        r18 = _env[r17]
                                        r38 = upvalueValues[upvalues[2]]
                                        r37 = upvalueValues[upvalues[3]]
                                        r20 = 25041298402912
                                        r39 = "\030\208\243B\002\170$\226o6\024"
                                        r31 = r37(r39, r20)
                                        r17 = r38[r31]
                                        r26 = r18[r17]
                                        r17 = upvalueValues[upvalues[2]]
                                        r38 = upvalueValues[upvalues[3]]
                                        r39 = 12192837451142
                                        r31 = "\151 \2396\149X\188\225"
                                        r37 = r38(r31, r39)
                                        r18 = r17[r37]
                                        r22 = r26[r18]
                                        r17 = upvalueValues[upvalues[2]]
                                        r38 = upvalueValues[upvalues[3]]
                                        r39 = 30064343415345
                                        r31 = "\177\237\012\225\155\160\232\237\022\014?/\006w\014xl\027\219\243DW"
                                        r37 = r38(r31, r39)
                                        r18 = r17[r37]
                                        r17 = 0.5
                                        r26 = {
                                            [r18] = r17
                                        }
                                        r25 = 0.25
                                        ReturnVal = state(r11, r25, r22, r26)
                                        state = upvalueValues[upvalues[4]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r25 = upvalueValues[upvalues[3]]
                                        r18 = 13454983945135
                                        r26 = "\128D\030\166\011\248"
                                        r22 = r25(r26, r18)
                                        ReturnVal = r11[r22]
                                        r11 = 9
                                        state[ReturnVal] = r11
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
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
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
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -2736802
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -2736802
                    end
                })
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)